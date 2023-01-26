defmodule ElixirMs.Domain.Behaviours.HelloBehaviour do

  @callback hello(term()) :: {:ok, String.t()} | {:error, term()}
end
