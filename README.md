[![Build status](https://badge.buildkite.com/0e16a8e8b81104b7059cafc364375695c55427ae8328a68b5f.svg)](https://buildkite.com/datum/apollo-buildkite-plugin)

# Apollo Buildkite Plugin 

Buildkite plugin that will check apollo schemas. The current implementation only runs the `rover subgraph check` command. Future releases will add the ability to run the `graph` and `supergraph` commands

## Example

Add the following to your `pipeline.yml`:

```yml
steps:
  - plugins:
      - datumforge/apollo#v0.0.1:
          graph-ref: datum@current
          subgraph: datum
          schema: schema.graphql
```

To ignore existing lint violations set `ignore-existing: true` in the plugin definition  

## Environment Variables

1. `APOLLO_KEY` is required to be set in the environment before the plugin can run

## Developing

To run the linter:
```shell
task lint
```

To run the tests:

```shell
task test
```

## Contributing

1. Fork the repo
2. Make the changes
3. Run the tests
4. Commit and push your changes
5. Send a pull request
