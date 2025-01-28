# Include the definition of the variables you will use throughout the
# definition of resources.

variable "project" {
  type        = string
  description = "The name of the project"
  default     = "de-c2w3lab1"
}

variable "region" {
  type        = string
  description = "The AWS region to use for provisioning"
  default     = "us-east-1"
}

variable "vpc_id" {
  type        = string
  description = "The id of the VPC to use"
}

### START CODE HERE ### (~ 16 lines of code)

# Define a variable `public_subnet_a_id` of type 
# string for the id of the public subnet in the 
# availability zone A
variable "public_subnet_a_id" {
  type        = string
  description = "The id of the public subnet in the availability zone A"
}

# Define a variable `public_subnet_b_id` of type 
# string for the id of the public subnet in the 
# availability zone B
variable "public_subnet_b_id" {
  type        = string
  description = "The id of the public subnet in the availability zone B"
}


# Define a variable `private_subnet_a_id` of type 
# string for the id of the private subnet in the 
# availability zone A
variable "private_subnet_a_id" {
  type        = string
  description = "The id of the private subnet in the availability zone A"
}

# Define a variable `private_subnet_b_id` of type 
# string for the id of the private subnet in the 
# availability zone B
variable "private_subnet_b_id" {
  type        = string
  description = "The id of the private subnet in the availability zone B"
}

### END CODE HERE ###

variable "db_master_username" {
  type        = string
  description = "The master username for the RDS instance"
  default     = "postgres_admin"
}
