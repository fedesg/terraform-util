# Defines a map of tags to assign to AWS resources for identification and categorization.
variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
}
