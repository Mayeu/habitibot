defmodule Habitica.User do
  @enforce_keys [:id, :token]
  defstruct [:id, :token]
  @type t :: %Habitica.User{id: String.t(), token: String.t()}
end
