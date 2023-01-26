defmodule ElixirMs.Config.AppConfig do

  @moduledoc """
   Provides strcut for app-config
  """

   defstruct [
     :external_service_ip,
     :enable_server,
     :http_port
   ]

   def load_config do
     %__MODULE__{
       external_service_ip: System.get_env("LATENCY_IP") || "localhost",
       enable_server: load(:enable_server),
       http_port: load(:http_port)
     }
   end

   defp load(property_name), do: Application.fetch_env!(:elixir_ms, property_name)
 end
