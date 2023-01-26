defmodule ElixirMs.Application do
  alias ElixirMs.Infrastructure.EntryPoint.ApiRest
  alias ElixirMs.Config.{AppConfig, ConfigHolder}
  alias ElixirMs.Utils.CertificatesAdmin

  use Application
  require Logger

  def start(_type, _args) do
    config = AppConfig.load_config()

    CertificatesAdmin.setup()

    children = with_plug_server(config) ++ all_env_children() ++ env_children()

    opts = [strategy: :one_for_one, name: ElixirMs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp with_plug_server(%AppConfig{enable_server: true, http_port: port}) do
    Logger.debug("Configure Http server in port #{inspect(port)}. ")
    [{Plug.Cowboy, scheme: :http, plug: ApiRest, options: [port: port]}]
  end

  defp with_plug_server(%AppConfig{enable_server: false}), do: []

  def all_env_children() do
    [
      {ConfigHolder, AppConfig.load_config()}
    ]
  end

  #def env_children(:test), do: []

  def env_children() do
    [
			{Finch, name: HttpFinch, pools: %{:default => [size: 500]}},]
  end
end
