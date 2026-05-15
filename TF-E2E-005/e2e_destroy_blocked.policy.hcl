# Copyright (c) HashiCorp, Inc.
# TF-E2E-005: Destroy blocked by delete policy.

policy {}

resource_policy "aws_vpc" "delete_requires_approval_tag" {
  operations = ["delete"]

  enforce {
    condition     = core::try(prior_attrs.tags.DeletionApproved, "false") == "true"
    error_message = "VPC must have DeletionApproved=true tag before deletion"
  }
}
