defmodule Shiren do
    use Application

  def start( _type, _args ) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :run)
    ]

    opts = [strategy: :one_for_one, name: Shiren.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    root = Application.get_env(:shiren, :path_root)
    if root != "" and File.exists?(root) != true do
      IO.puts("Error: the path "<> Application.get_env(:shiren, :path_root) <>" not exist!")
    else
      { :ok, _ } = Plug.Adapters.Cowboy.http Wanderer, []
    end
  end

end
