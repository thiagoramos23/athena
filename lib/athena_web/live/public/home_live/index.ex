defmodule AthenaWeb.Public.HomeLive.Index do
  use AthenaWeb, :live_view
  alias AthenaWeb.MainLayout

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
