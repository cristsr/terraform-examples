# Simple variable with validation
# Demonstrates how to add validation rules to ensure input values meet specific criteria
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  # Validation block ensures only allowed values are accepted
  # This prevents configuration errors and enforces standards
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging or prod."
  }
}

# Complex variable - object type
# Objects allow grouping related configuration parameters together
# This creates a structured configuration that's easier to manage
variable "database_config" {
  description = "Database configuration settings"
  type = object({
    engine            = string # Database engine (mysql, postgres, etc.)
    engine_version    = string # Specific version of the database engine
    instance_class    = string # AWS RDS instance type (determines CPU/memory)
    allocated_storage = number # Storage size in GB
    backup_retention  = number # Number of days to retain backups
    multi_az          = bool   # Whether to enable Multi-AZ deployment for HA
  })

  # Default values provide a working configuration out of the box
  # These can be overridden when calling the module or configuration
  default = {
    engine            = "mysql"
    engine_version    = "8.0"
    instance_class    = "db.t3.micro" # Small instance suitable for development
    allocated_storage = 20            # 20GB storage
    backup_retention  = 7             # Keep backups for 7 days
    multi_az          = false         # Single AZ for cost savings in dev
  }
}

# List of objects variable
# Useful for defining multiple similar resources with different configurations
# Each object in the list represents one subnet configuration
variable "subnets" {
  description = "Subnet configuration for VPC"
  type = list(object({
    name              = string # Human-readable name for the subnet
    cidr_block        = string # IP address range for the subnet
    availability_zone = string # AWS AZ where the subnet will be created
    public            = bool   # Whether subnet should have internet access
  }))

  # Default configuration creates both public and private subnets
  # This is a common pattern for web applications requiring both tiers
  default = [
    {
      name              = "public-1"
      cidr_block        = "10.0.1.0/24" # 256 IP addresses
      availability_zone = "us-east-1a"
      public            = true # Internet-facing subnet
    },
    {
      name              = "private-1"
      cidr_block        = "10.0.2.0/24" # 256 IP addresses
      availability_zone = "us-east-1b"
      public            = false # Internal subnet, no direct internet access
    }
  ]
}
