defmodule AthenaWeb.Teachers.TeacherLive.FormComponent do
  use AthenaWeb, :live_component

  alias Athena.Education
  alias Athena.Education.Teacher

  def render(assigns) do
    ~H"""
    <div class="mx-auto bg-gray-800">
      <div class="px-4 border-b border-gray-900/10">
        <h2 class="text-xl font-semibold leading-7 text-gray-50">Cadastro</h2>
        <p class="mt-1 text-lg leading-6 text-gray-100">
          Ao clicar no botão para se cadastrar você concorda com os termos de serviço desta plataforma
        </p>
        <.simple_form
          for={@form}
          id={@id}
          phx-submit="save"
          phx-change="validate"
          phx-target={@myself}
        >
          <.input field={@form[:name]} type="text" placeholder="Nome" label="Nome" required />
          <.input field={@form[:email]} type="email" placeholder="Email" label="Email" required />
          <:actions>
            <.button
              phx-disable-with="Criando..."
              class="bg-green-600 border border-green-700 rounded-md p-2"
            >
              Quero me tornar um professor
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
      |> assign_teacher()
      |> clear_form()
    }
  end

  def handle_event("validate", %{"teacher" => teacher_params}, socket) do
    params = params_with_user_id(teacher_params, socket)
    changeset = validate_teacher(socket, params)
    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"teacher" => teacher_params}, socket) do
    params = params_with_user_id(teacher_params, socket)
    {:noreply, save_teacher(socket, params)}
  end

  defp save_teacher(socket, params) do
    case Education.create_teacher(params) do
      {:ok, teacher} ->
        send(self(), {:created_teacher, teacher})
        socket

      {:error, %Ecto.Changeset{} = changeset} ->
        assign_form(socket, changeset)
    end
  end

  defp assign_teacher(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :teacher, %Teacher{user_id: current_user.id})
  end

  defp clear_form(%{assigns: %{teacher: teacher}} = socket) do
    assign_form(socket, Education.change_teacher(teacher))
  end

  defp clear_form(socket) do
    assign_form(socket, Education.change_teacher(%Teacher{}))
  end

  defp assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp validate_teacher(socket, teacher_params) do
    socket.assigns.teacher
    |> Education.change_teacher(teacher_params)
    |> Map.put(:action, :validate)
  end

  defp params_with_user_id(teacher_params, %{assigns: %{current_user: current_user}}) do
    Map.put(teacher_params, "user_id", current_user.id)
  end
end
