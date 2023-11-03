defmodule AthenaWeb.Components.CardComponent do
  use Phoenix.Component
  import AthenaWeb.CoreComponents

  def course(assigns) do
    ~H"""
    <.link id={@course.slug} navigate={@course_url}>
    	<div class="group">
    		<div class="h-64 w-full overflow-hidden rounded-lg bg-gray-200 group-hover:opacity-75">
    			<img src={@course.cover_url} alt={@course.description} class="h-full w-full object-cover object-center">
    		</div>
    		<h2 class="mt-4 text-lg text-white">
    			<%= @course.name %>
    		</h2>
    		<p class="mt-1 text-md font-light text-gray-100"><%= @course.description %></p>
    	</div>
    </.link>
    """
  end

  def add_course(assigns) do
    ~H"""
    <.link id="new_course" navigate={@new_course_url}>
    	<div class="flex h-64 w-64 rounded-md bg-transparent group-hover:opacity-75 lg:h-64 lg:xl:h-64">
    		<.icon name="hero-plus-circle" class="h-32 w-32 text-gray-300 mx-auto mt-14" />

    	</div>
    	<h2 class="text-white mt-4 text-xl font-normal antialiased">
    		Adicionar Novo Curso
    	</h2>
    </.link>
    """
  end
end
