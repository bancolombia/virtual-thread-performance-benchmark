defmodule ElixirMs.Domain.UseCase.CasesUseCase do
  alias ElixirMs.Domain.Model.Primes

  @hello_gateway Application.compile_env(:elixir_ms, :hello_gateway)

  def case_one(latency) do
    with {:ok, _} <- @hello_gateway.hello(latency),
         primes <- Primes.get_primes_list(1000) do
      {:ok, primes}
    end
  end

  def case_two(latency) do
    @hello_gateway.hello(latency)
  end

  def case_three() do
    Primes.get_primes_list(1000)
  end
end
