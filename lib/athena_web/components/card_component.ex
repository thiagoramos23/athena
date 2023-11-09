defmodule AthenaWeb.Components.CardComponent do
  use Phoenix.Component
  import AthenaWeb.CoreComponents

  def show(assigns) do
    ~H"""
    <.link id={@item.slug} navigate={@item_url}>
    	<div class="group">
    		<div class="h-64 w-full overflow-hidden rounded-lg bg-gray-200 group-hover:opacity-75">
    			<img src={@item.thumbnail_url} alt={@item.description} class="h-full w-full object-cover object-center">
    		</div>
    		<h2 class="mt-4 text-lg text-white">
    			<%= @item.name %>
    		</h2>
    		<p class="mt-1 text-md font-light text-gray-100"><%= @item_description %></p>
    	</div>
    </.link>
    """
  end

  def add_new_item(assigns) do
    ~H"""
    <.link id="new_item" navigate={@new_item_url}>
    	<div class="flex h-64 w-64 rounded-md bg-transparent group-hover:opacity-75 lg:h-64 lg:xl:h-64">
    		<.icon name="hero-plus-circle" class="h-32 w-32 text-gray-300 mx-auto mt-14" />

    	</div>
    	<h2 class="text-white mt-4 text-xl font-normal antialiased">
    		Adicionar Novo
    	</h2>
    </.link>
    """
  end
end
