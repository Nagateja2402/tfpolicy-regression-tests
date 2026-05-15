# Copyright (c) HashiCorp, Inc.
# TF-E2E-004: Full lifecycle — plan with getresources unknown then apply denies.
# No flow log → plan is UNKNOWN, apply is FAIL.

policy {}

resource_policy "aws_vpc" "must_have_flow_log" {
  locals {
    flow_logs = core::getresources("aws_flow_log", {
      vpc_id = attrs.id
    })
  }

  enforce {
    condition     = core::length(local.flow_logs) > 0
    error_message = "VPC must have an associated flow log"
  }
}
