// Variable that defines different instance types for each environment
// This allows scaling resources according to environment needs
variable "environments" {
  type = map(string)
  default = {
    dev  = "t2.micro"  // Development: small and economical instance
    test = "t2.small"  // Testing: medium instance for testing
    prod = "t2.medium" // Production: more robust instance
  }
}

// VPC (Virtual Private Cloud) resource
// Creates an isolated virtual network in AWS
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" // Private IP address range
}

// Subnet resource
// Creates a subnet within the VPC
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id // Reference to the VPC ID created above
  cidr_block = "10.0.1.0/24"     // Subset of the VPC range
}

// EC2 instance resource with meta-arguments
resource "aws_instance" "web_server" {
  // Resource arguments (resource-specific configuration)
  ami           = "ami-052cef01758351d39" // Amazon Machine Image ID
  instance_type = "t2.micro"              // Instance type (CPU, memory, network)

  // Tags to identify and organize resources
  tags = {
    Name        = "WebServer"   // Descriptive name
    Environment = "Development" // Deployment environment
  }

  // Meta-arguments (Terraform behavior configuration)

  // count meta-argument: useful to create a resource only if a condition is met
  // In this case, always creates 1 instance (true ? 1 : 0)
  count = true ? 1 : 0

  // Resource lifecycle management
  lifecycle {
    // Create the new resource before destroying the previous one
    // Useful to avoid downtime
    create_before_destroy = true

    // Prevents accidental destruction of the resource
    // Terraform will fail if you try to destroy this resource
    prevent_destroy = true

    // Ignore changes to these specific attributes
    // Useful when other processes modify these values
    ignore_changes = [
      ami,          // Ignore changes to the AMI
      instance_type // Ignore changes to the instance type
    ]
  }

  // Explicit dependency
  // Ensures these resources are created before this instance
  // Terraform normally detects dependencies automatically
  depends_on = [
    aws_vpc.my_vpc,
    aws_subnet.my_subnet
  ]

}

// Multiple instances using for_each
resource "aws_instance" "env_servers" {
  // for_each meta-argument: useful to create multiple 
  // resources with the same configuration using a configuration map
  // Creates one instance for each entry in the var.environments map
  for_each = var.environments

  ami = "ami-0c02fb55956c7d316"

  // each.value is the map value (instance type)
  instance_type = each.value

  tags = {
    Name = "Server-${each.key}" // each.key is the map key (dev, test, prod)
    // each.key is the map key (environment)
    Environment = each.key
  }
}

// Output that returns the IDs of all created instances
output "env_servers_ids" {
  // The value will contain the IDs of the created resources as a list
  // The [*] (splat) operator extracts the 'id' attribute from each instance
  value = aws_instance.env_servers[*].id
}

// Output that returns the ID of a specific instance
output "dev_server_id" {
  // The value will contain the ID of the specific resource from the 'dev' environment
  // Directly accesses the instance using the map key
  value = aws_instance.env_servers["dev"].id
}

