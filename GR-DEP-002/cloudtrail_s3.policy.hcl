# Copyright (c) HashiCorp, Inc.

policy {}

resource_policy "aws_cloudtrail" "ensure_private_s3_bucket" {
  locals {
    matching_buckets = core::getresources("aws_s3_bucket", {
      bucket = attrs.s3_bucket_name
    })
    acl = core::length(local.matching_buckets) > 0 ? core::try(local.matching_buckets[0].acl, "") : ""
  }

  enforce {
    condition     = core::length(local.matching_buckets) > 0
    error_message = "CloudTrail must reference an S3 bucket that exists in this configuration"
  }

  enforce {
    condition     = local.acl == "private"
    error_message = "CloudTrail S3 bucket must have acl set to private"
  }
}
