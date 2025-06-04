## Primitives
variable "str" {
  type    = string
  default = "Hello World"
}

variable "num" {
  type    = number
  default = 10
}

variable "bool" {
  type    = bool
  default = true
}

## Collections
variable "list" {
  type    = list(string)
  default = ["Hello", "World"]
}

variable "map" {
  type = map(string)
  default = {
    "key1" = "value1"
    "key2" = "value2"
  }
}

variable "set" {
  type    = set(string)
  default = ["Hello", "World"]
}

variable "tuple" {
  type    = tuple([string, number])
  default = ["Hello", 10]
}

variable "object" {
  type = object({
    name = string
    age  = number
  })
  default = {
    name = "John"
    age  = 30
  }
}

variable "any" {
  type    = any
  default = "Hello World"
}






