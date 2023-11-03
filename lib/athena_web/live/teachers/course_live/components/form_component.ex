defmodule AthenaWeb.Teachers.CourseLIve.FormComponent do
  use AthenaWeb, :live_component

  alias Athena.Education
  alias Athena.Education.Course

  def render(assigns) do
    ~H"""
    <div class="mx-auto bg-gray-800">
      <div class="px-4 border-b border-gray-900/10">
        <h2 class="text-xl font-semibold leading-7 text-gray-50">Cadastro</h2>
        <p class="mt-1 text-lg leading-6 text-gray-100">
          Ao clicar no botão para se cadastrar você concorda com os termos de serviço desta plataforma
        </p>
        <.simple_form for={@form} id={@id} phx-submit="save" phx-change="validate" phx-target={@myself}>
          <.input field={@form[:name]} type="text" placeholder="Nome" label="Nome" required />
          <.input field={@form[:description]} type="text" placeholder="Descrição" label="Descrição" required />
          <.input field={@form[:cover_url]} type="text" placeholder="Imagem de Capa" label="Imagem de Capa" required />
          <.input field={@form[:featured]} type="checkbox" label="Em destaque?" required />
          <:actions>
            <.button
              phx-disable-with="Criando..."
              class="bg-green-600 border border-green-700 rounded-md p-2"
            >
              Criar curso
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

  def handle_event("validate", %{"course" => course_params}, socket) do
    params = merge_params(course_params, socket)
    changeset = validate_course(socket, params)
    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"course" => course_params}, socket) do
    params = merge_params(course_params, socket)
    {:noreply, save_course(socket, params)}
  end

  defp save_course(socket, params) do
    case Education.create_course(params) do
      {:ok, course} ->
        send(self(), {:created_course, course})
        socket

      {:error, %Ecto.Changeset{} = changeset} ->
        assign_form(socket, changeset)
    end
  end

  defp clear_form(%{assigns: %{course: course}} = socket) do
    assign_form(socket, change_course(course))
  end

  defp clear_form(socket) do
    assign_form(socket, change_course(%Course{}))
  end

  defp assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp validate_course(socket, course_params) do
    socket.assigns.course
    |> change_course(course_params)
    |> Map.put(:action, :validate)
  end

  defp change_course(course, params \\ %{}) do
    Education.change_course(course, params)
  end

  defp merge_params(course_params, %{assigns: %{teacher: teacher}}) do
    slug = Athena.Common.Slugify.call(course_params["name"])
    Map.merge(course_params, %{"teacher_id" => teacher.id, "slug" => slug})
  end
end
