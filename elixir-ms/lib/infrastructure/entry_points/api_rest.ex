defmodule ElixirMs.Infrastructure.EntryPoint.ApiRest do
  @moduledoc """
  Access point to the rest exposed services
  """

  alias ElixirMs.Domain.UseCase.CasesUseCase

  require Logger

  use Plug.Router
  use Plug.ErrorHandler
  use Timex

  plug(CORSPlug,
    methods: ["GET", "POST", "PUT", "DELETE"],
    origin: [~r/.*/],
    headers: ["Content-Type", "Accept", "User-Agent"]
  )

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Poison)
  plug(Plug.Telemetry, event_prefix: [:elixir_ms, :plug])
  plug(:dispatch)

  forward(
    "/elixir_ms/api/health",
    to: PlugCheckup,
    init_opts: PlugCheckup.Options.new(json_encoder: Jason, checks: ElixirMs.Infrastructure.EntryPoint.HealthCheck.checks)
  )

  get "/api/hello" do
    "Hello"
    |> build_response(conn)
  end

  get "/api/case-one" do
    latency = conn.query_params["latency"] || 0

    case CasesUseCase.case_one(latency) do
      {:ok, response} -> response |> build_response(conn)
      {:error, error} ->
        Logger.error("Error case one #{inspect(error)}")
        build_response(%{status: 500, body: "Error"}, conn)
    end
  end

  get "/api/case-two" do
    latency = conn.query_params["latency"] || 0

    case CasesUseCase.case_two(latency) do
      {:ok, response} -> response |> build_response(conn)
      {:error, error} ->
        Logger.error("Error case two #{inspect(error)}")
        build_response(%{status: 500, body: "Error"}, conn)
    end
  end

  get "/api/case-three" do
    CasesUseCase.case_three()
    |> build_response(conn)
  end

  match _ do
    %{request_path: path} = conn
    build_response(%{status: 404, body: %{status: 404, path: path}}, conn)
  end

  def build_response(%{status: status, body: body}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(body))
  end

  def build_response(response, conn), do: build_response(%{status: 200, body: response}, conn)

  @impl Plug.ErrorHandler
  def handle_errors(conn, error) do
    Logger.error("Internal server - #{inspect(error)}")
    build_response(%{status: 500, body: %{status: 500, error: "Internal server"}}, conn)
  end
end
