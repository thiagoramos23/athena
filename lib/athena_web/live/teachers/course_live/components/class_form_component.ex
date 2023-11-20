defmodule AthenaWeb.Teachers.CourseLive.ClassFormComponent do
  use AthenaWeb, :live_component

  alias Athena.Education
  alias Athena.Education.Class

  def render(assigns) do
    ~H"""
    <div class="mx-auto bg-gray-800">
      <div class="px-4 border-b border-gray-900/10">
        <h2 class="text-xl font-semibold leading-7 text-gray-50">Criar Aula</h2>
        <.simple_form for={@form} id={@id} phx-submit="save" phx-change="validate" phx-target={@myself}>
          <.input field={@form[:id]} type="hidden"/>
          <.input field={@form[:name]} type="text" placeholder="Nome" label="Nome" required />
          <.input field={@form[:summary]} type="text" placeholder="Sumário" label="Sumário" required />
          <.input field={@form[:description]} type="textarea" placeholder="Adicionar descrição em markdown" label="Descrição" required />
          <.input field={@form[:thumbnail_url]} type="text" placeholder="Imagem de Capa" label="Imagem de Capa" required />
          <.input field={@form[:video_url]} type="text" placeholder="Vídeo URL" label="Vídeo URL" required />
          <.input field={@form[:class_length]} type="text" placeholder="Duração da Aula" label="Duração da Aula" required />
          <.input field={@form[:state]} type="select" placeholder="Tipo da aula" label="Tipo da aula"
    				options={["público": "public", private: "private", pago: "paid", breve: "soon"]} value={"public"} required />
          <:actions>
            <.button
              phx-disable-with="Criando..."
              class="bg-green-600 border border-green-700 rounded-md p-2"
            >
              Confirmar
            </.button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end

  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> clear_form()
    }
  end

  def handle_event("validate", %{"class" => class_params}, socket) do
    params = merge_params(class_params, socket)
    changeset = validate_class(socket, params)
    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"class" => %{"id" => class_id} = class_params}, socket) do
    params = merge_params(class_params, socket)
    class = Education.get_class_by_id(class_id)
    {:noreply, update_class(socket, class, params)}
  end

  def handle_event("save", %{"class" => class_params}, socket) do
    params = merge_params(class_params, socket)
    {:noreply, save_class(socket, params)}
  end

  defp save_class(socket, params) do
    case Education.create_class(params) do
      {:ok, class} ->
        send(self(), {:created_class, class})
        socket

      {:error, %Ecto.Changeset{} = changeset} ->
        assign_form(socket, changeset)
    end
  end

  defp update_class(socket, class, params) do
    case Education.update_class(class, params) do
      {:ok, class} ->
        send(self(), {:updated_class, class})
        socket

      {:error, %Ecto.Changeset{} = changeset} ->
        assign_form(socket, changeset)
    end
  end

  defp clear_form(%{assigns: %{class: class}} = socket) do
    assign_form(socket, change_class(class))
  end

  defp clear_form(socket) do
    assign_form(socket, change_class(%Class{}))
  end

  defp assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp validate_class(socket, class_params) do
    socket.assigns.class
    |> change_class(class_params)
    |> Map.put(:action, :validate)
  end

  defp change_class(class, params \\ %{}) do
    Education.change_class(class, params)
  end

  defp merge_params(class_params, %{assigns: %{course: course}}) do
    slug = Athena.Common.Slugify.call(class_params["name"])
    Map.merge(class_params, %{"course_id" => course.id, "slug" => slug})
  end
end
