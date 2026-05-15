# Copyright (c) HashiCorp, Inc.

policy {}

resource_policy "aws_vpc" "exactly_one_flow_log" {
  locals {
    flow_logs = core::getresources("aws_flow_log", {
      vpc_id = attrs.id
    })
  }

  enforce {
    condition     = core::length(local.flow_logs) == 1
    error_message = "VPC must have exactly one flow log"
  }
}
