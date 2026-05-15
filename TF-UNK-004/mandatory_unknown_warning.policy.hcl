# Copyright (c) HashiCorp, Inc.

policy {}

resource_policy "aws_vpc" "mandatory_flow_log_check" {
  enforcement_level = mandatory

  locals {
    flow_logs = core::getresources("aws_flow_log", {
      vpc_id = attrs.id
    })
  }

  enforce {
    condition     = core::length(local.flow_logs) > 0
    error_message = "Mandatory: VPC must have a flow log (unknown at plan time due to computed vpc_id)"
  }
}
