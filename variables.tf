variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "DefaultName"
}

variable "app_name" {
  description = "Value of the App tag for the EC2 instance"
  type        = string
  default     = "AppName"
}

variable "instance_count" {
  description = "Number of instances to be created"
  type = number
  default = 1

}