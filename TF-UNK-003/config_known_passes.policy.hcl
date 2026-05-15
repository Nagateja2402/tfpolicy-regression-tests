# Copyright (c) HashiCorp, Inc.

policy {}

resource_policy "aws_s3_bucket" "must_have_acl_logging" {
  locals {
    # Filter on acl — set in config, not computed → known at plan time
    private_buckets = core::getresources("aws_s3_bucket", {
      acl = "private"
    })
  }

  enforce {
    condition     = core::length(local.private_buckets) > 0
    error_message = "At least one private S3 bucket must exist in the configuration"
  }
}
