import Config

config :perf_analyzer,
  url: "http://_IP_:8080/api/case-two?latency=10",
  request: %{
    method: "GET",
    headers: [],
    body: ""
  },
  execution: %{
    steps: 20,
    increment: 50,
    duration: 1000,
    constant_load: false,
    dataset: :none,
    separator: ","
  },
  distributed: :none

config :logger,
  level: :warn
