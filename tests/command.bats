#!/usr/bin/env bats

load "$BATS_PLUGIN_PATH/load.bash"

# Uncomment the following line to debug stub failures
# export BUILDKITE_AGENT_STUB_DEBUG=/dev/tty
# export WHICH_STUB_DEBUG=/dev/tty

@test "default step" {
  export BUILDKITE_PIPELINE_DEFAULT_BRANCH="main"
  export BUILDKITE_PLUGIN_APOLLO_GRAPH_REF="pets@current"
  export BUILDKITE_PLUGIN_APOLLO_SUBGRAPH="cats"

  stub rover \
    'subgraph check $BUILDKITE_PLUGIN_APOLLO_GRAPH_REF --name BUILDKITE_PLUGIN_APOLLO_SUBGRAPH --schema "schema.graphql" --format=json'\

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "+++ :graphql: schema check"
  assert_output --partial "check"

  unstub rover
}

@test "default step with schema" {
  export BUILDKITE_PIPELINE_DEFAULT_BRANCH="main"
  export BUILDKITE_PLUGIN_APOLLO_GRAPH_REF="pets@current"
  export BUILDKITE_PLUGIN_APOLLO_SUBGRAPH="cats"
  export BUILDKITE_PLUGIN_APOLLO_SCHEMA="graphql/schema.graphql"

  stub rover \
    'subgraph check $BUILDKITE_PLUGIN_APOLLO_GRAPH_REF --name BUILDKITE_PLUGIN_APOLLO_SUBGRAPH --schema $BUILDKITE_PLUGIN_APOLLO_SCHEMA --format=json'\

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "+++ :graphql: schema check"
  assert_output --partial "check"

  unstub rover
}

@test "ignore existing" {
  export BUILDKITE_PIPELINE_DEFAULT_BRANCH="main"
  export BUILDKITE_PLUGIN_APOLLO_GRAPH_REF="pets@current"
  export BUILDKITE_PLUGIN_APOLLO_SUBGRAPH="cats"
  export BUILDKITE_PLUGIN_APOLLO_IGNORE_EXISTING="true"

  stub rover \
    'subgraph check $BUILDKITE_PLUGIN_APOLLO_GRAPH_REF --name BUILDKITE_PLUGIN_APOLLO_SUBGRAPH --schema "schema.graphql" --ignore-existing-lint-violations --format=json'\

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "+++ :graphql: schema check"
  assert_output --partial "check"

  unstub rover
}