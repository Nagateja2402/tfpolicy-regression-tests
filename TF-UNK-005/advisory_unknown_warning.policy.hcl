# Copyright (c) HashiCorp, Inc.

policy {}

resource_policy "aws_vpc" "advisory_flow_log_check" {
  enforcement_level = advisory

  locals {
    flow_logs = core::getresources("aws_flow_log", {
      vpc_id = attrs.id
    })
  }

  enforce {
    condition     = core::length(local.flow_logs) > 0
    error_message = "Advisory: VPC should have a flow log"
  }
}
