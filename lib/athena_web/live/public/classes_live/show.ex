defmodule AthenaWeb.Public.ClassesLive.Show do
  use AthenaWeb, :live_view
  alias AthenaWeb.MainLayout

  def mount(_params, _session, socket) do
    description = Earmark.as_html!(File.read!("priv/static/example.md"))
    {:ok, assign(socket, :description, description)}
  end
end
