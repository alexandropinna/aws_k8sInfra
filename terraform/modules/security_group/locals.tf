# Local Variables Block
# Used to define variables that are local to this configuration file.
locals {
  # Suffix composed of the project, environment, and region tags
  # Will be used for consistently naming resources across the project
  sufix = "${var.tags.project}-${var.tags.env}-${var.tags.region}"
}
