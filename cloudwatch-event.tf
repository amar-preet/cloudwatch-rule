resource "aws_cloudwatch_event_rule" "event_rule" {
  name        = "event_rule"
  description = "Create Cloudwatch rule that will trigger AWS Batch job"

  schedule_expression = "cron(${var.cron-schedule})"
}

resource "aws_cloudwatch_event_target" "batch-queue" {
  rule      = "${aws_cloudwatch_event_rule.event_rule.name}"
  target_id = "${var.cloudwatch-rule-target-event-id}"
  arn       = "${data.aws_batch_job_queue.batch-job-queue.arn}"
  role_arn  = "${var.cloudwatch-rule-target-role-arn}"

  batch_target {
    job_name       = "batch-target"
    job_definition = "${var.batch-job-arn}"
  }

  input_transformer {
    input_paths = {
      "S3KeyValue" = "$.detail.requestParameters.key"
    }

    input_template = <<INPUT_TEMPLATE_EOF
    {
        "Parameters":{"S3key" : "file.json"}
    }
    INPUT_TEMPLATE_EOF
  }
}

data "aws_batch_job_queue" "batch-job-queue" {
  name = "batch-job-queue"
}

resource "aws_s3_bucket_object" "object" {
  bucket = "${var.s3-bucket-name}"
  key    = "${var.s3-bucket-object}"
  source = "/Users/Documents/file.json"
}
