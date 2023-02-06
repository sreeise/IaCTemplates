variable "family" {
  type        = string
  description = "(Required) The name of a family that this task definition is registered to"
}

// See Task Size at https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html
variable "cpu" {
  type        = string
  description = "(Required) The number of cpu units used by the task"
}

variable "memory" {
  type        = string
  description = "(Required) The amount (in MiB) of memory used by the task"
}

variable "task_role_arn" {
  type        = string
  description = "(Required) The ARN of the AWS Identity and Access Management role that grants containers in the task permission to call AWS APIs on your behalf"
}

variable "execution_role_arn" {
  type        = string
  description = "(Required) The ARN of the task execution role that grants the Amazon ECS container agent permission to make AWS API calls on your behalf"
}

variable "container_definitions" {
  type = list(object({
    name        = string
    image       = string
    environment = map(string)
    secrets     = map(string)
    port_mappings = object({
      // For task definitions that use the awsvpc network mode, you should only specify the containerPort.
      // The hostPort can be left blank or it must be the same value as the containerPort.
      container_port = string
    })
    log_configuration = object({
      // For tasks on AWS Fargate, the supported log drivers are awslogs, splunk, and awsfirelens
      log_driver = string
      options    = map(string)
      secret_options = list(object({
        name       = string
        value_from = string
      }))
    })
  }))
}
