# Copyright (c) HashiCorp, Inc.

policy {}

resource_policy "aws_vpc" "must_have_flow_log_by_id" {
  locals {
    # vpc_id in flow_log references aws_vpc.main.id which is computed
    flow_logs = core::getresources("aws_flow_log", {
      vpc_id = attrs.id
    })
  }

  enforce {
    condition     = core::length(local.flow_logs) > 0
    error_message = "VPC must have an associated flow log (filtering by computed id)"
  }
}
