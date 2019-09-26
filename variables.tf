variable "region" {
  description = "AWS Region"
  default     = "us-west-1"
}

variable "cloudwatch-rule-target-event-id" {
  description = "The unique target assignment ID. If missing, will generate a random, unique id."
  default     = "batch-queue"
}

variable "cloudwatch-rule-target-role-arn" {
  description = "The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered. Required if ecs_target is used"
  default     = ""
}

variable "cron-schedule" {
  default = "31 03 * * ? *"
}

variable "batch-job-arn" {
  default = ""
}

variable "s3-bucket-name" {
  default = ""
}

variable "s3-bucket-object" {
  default = ""
}
