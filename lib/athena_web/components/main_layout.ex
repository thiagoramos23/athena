defmodule AthenaWeb.MainLayout do
  @moduledoc false
  use Phoenix.Component
  use AthenaWeb, :html

  alias AthenaWeb.MainLayout

  slot :inner_block, required: true

  def header(assigns) do
    ~H"""
    <header class="mx-auto bg-transparent">
      <div class="flex">
        <nav class="flex flex-row flex-auto p-7 lg:px-8" aria-label="Global">
          <div class="hidden lg:flex lg:gap-x-12">
            <a href="/" class="text-lg font-semibold text-white leading-6">Cursos</a>
            <div :if={!is_nil(@current_user)}>
              <a href="/my-courses" class="text-sm font-semibold text-white leading-6">Meus Cursos</a>
            </div>
          </div>
          <div :if={can_become_teacher(@current_user)} class="hidden lg:flex ml-auto">
            <a
              href="/teachers/new"
              class="text-sm font-semibold text-white leading-6 bg-green-600 p-2 rounded-md"
            >
              Se torne um professor
            </a>
          </div>
          <div :if={can_access_teacher_panel(@current_user)} class="hidden lg:flex ml-auto">
            <a
              href="/teachers"
              class="text-sm font-semibold text-white leading-6 bg-green-600 p-2 rounded-md"
            >
              Acesse a plataforma de ensino
            </a>
          </div>
        </nav>
        <div class="mt-2">
          <div :if={!is_nil(@current_user)} class="flex items-center justify-end p-6 lg:px-8">
            <label class="text-sm font-semibold text-white leading-6">
              <%= @current_user.email %>
            </label>
            <.link
              class="ml-4 text-sm font-semibold text-white"
              href={~p"/users/log_out"}
              method="delete"
            >
              Sair
            </.link>
          </div>
        </div>
        <div
          :if={is_nil(@current_user)}
          class="flex items-center justify-end p-6 lg:px-8 cursor-pointer"
        >
          <.link class="ml-4 text-sm font-semibold text-white" href={~p"/users/log_in"}>
            Entrar
          </.link>
          <.link
            class="p-2 ml-4 text-sm font-semibold text-white bg-green-600 border-green-800 rounded-md"
            href={~p"/users/register"}
          >
            Criar Conta
          </.link>
        </div>
      </div>
    </header>
    """
  end

  def headline(assigns) do
    ~H"""
    <div class="relative overflow-hidden bg-transparent">
      <div class="px-6 py-24 max-w-7xl md:min-w-fit lg:px-8">
        <div class="max-w-4xl lg:text-center">
          <h2 class="max-w-xl mt-2 text-5xl font-normal tracking-normal text-left text-white sm:leading-tight sm:text-5xl">
            Aprenda a Construir Aplicações Íncriveis com
            <span class="font-bold">Elixir, LiveView e iOS</span>
          </h2>
          <p class="mt-2 text-left text-gray-300 text-lg font-normal md:min-w-fit">
            Um jeito novo de aprender, mão na massa e divertido. Uma plataforma criada pra você que quer criar um produto completo do zero.
            Aprenda a criar aplicações WEB escaláveis com Elixir e LiveView e aplicações mobile nativas com iOS. Todas as aulas com conteúdo
            super bem explicado e muita mão na massa.
          </p>
        </div>
      </div>
    </div>
    """
  end

  attr :class, :string, default: nil

  def show_course(assigns) do
    ~H"""
    <.link navigate={~p"/courses/#{@course.slug}"}>
      <div class="flex flex-col md:w-60">
        <div class={[
          "h-48 overflow-hidden bg-gray-100 rounded-lg outline-none aspect-h-1 aspect-w-2",
          @class
        ]}>
          <img
            src={@course.thumbnail_url}
            alt=""
            class="object-cover pointer-events-none group-hover:opacity-75"
          />
        </div>
        <div class="mt-2 text-xl font-semibold text-white">
          <%= @course.name %>
        </div>
        <div class="mt-2 font-normal text-white text-md">
          <%= @course.description %>
        </div>
      </div>
    </.link>
    """
  end

  def show_course_with_classes(assigns) do
    ~H"""
    <div class="flex flex-col items-start mt-5 text-xl font-bold text-white antialised pl-2">
      <%= @course.name %>
      <span class="mt-2 text-sm font-normal text-gray-400">
        <%= @course.description %>
      </span>
    </div>
    <MainLayout.list_classes_for_course
      course={@course}
      current_user={@current_user}
      paid_student={@paid_student}
    />
    """
  end

  defp get_class_link(course, class, is_paid_student, user) do
    cond do
      class.state == :soon || (class.state == :paid && !is_paid_student) ->
        "#"

      !user && class.state == :private ->
        ~p"/users/log_in"

      true ->
        ~p"/courses/#{course.slug}/classes/#{class.slug}"
    end
  end

  def list_classes_for_course(assigns) do
    ~H"""
    <div class="mt-12">
      <div class="max-w-7xl md:min-w-full mt-7 flex snap-x snap-mandatory space-x-4 overflow-x-auto pb-6
        lg:max-w-7xl lg:mt-8 lg:grid lg:snap-none lg:grid-cols-3 lg:gap-x-3.5 lg:gap-y-12 lg:space-x-0 lg:before:hidden lg:after:hidden">
        <div :for={klass <- @course.classes} class="flex min-w-fit">
          <.link
            id={klass.slug}
            navigate={get_class_link(@course, klass, @paid_student, @current_user)}
          >
            <div class="md:pt-0 w-80 lg:w-full">
              <div class="flex-none snap-start scroll-ml-4 sm:max-w-none md:max-w-xs lg:max-w-2xl md:scroll-ml-6 lg:w-auto lg:px-2">
                <img
                  :if={klass.state != :soon}
                  src={klass.thumbnail_url}
                  alt=""
                  class="object-cover pointer-events-none group-hover:opacity-76 rounded-md max-h-48 min-w-full md:max-h-56 md:w-3/5"
                />
                <img
                  :if={klass.state == :soon}
                  src="/images/soon.png"
                  alt=""
                  class="object-fill pointer-events-none group-hover:opacity-75 rounded-md max-h-48 md:max-h-56 min-w-full"
                />
                <span class="sr-only"><%= klass.name %></span>
              </div>
              <div class="flex">
                <div class="mt-2">
                  <div class="px-1.5 py-0.5 text-sm font-medium text-white rounded-lg">
                    <.icon :if={klass.state == :public} name="hero-eye" />
                    <.icon :if={klass.state == :private and @current_user} name="hero-eye" />
                    <.icon :if={klass.state == :private and !@current_user} name="hero-eye-slash" />
                    <.icon :if={klass.state == :paid and @paid_student} name="hero-eye" />
                    <.icon :if={klass.state == :paid and !@paid_student} name="hero-lock-closed" />
                    <.icon :if={klass.state == :soon} name="hero-lock-closed" />
                  </div>
                </div>

                <p class="block mt-3 text-sm font-medium text-white truncate pointer-events-none">
                  <%= klass.name %>
                </p>
              </div>
              <p class="px-1.5 mt-1 text-sm font-normal text-gray-300 pointer-events-none">
                <%= klass.summary %>
              </p>
            </div>
          </.link>
        </div>
      </div>
    </div>
    """
  end

  def footer(assigns) do
    assigns = assign(assigns, :year, Date.utc_today().year)

    ~H"""
    <footer>
      <div class="px-6 py-12 mx-auto max-w-7xl md:flex md:items-center md:justify-between lg:px-8">
        <div class="flex justify-center space-x-6 md:order-2">
          <a href="https://www.instagram.com/thiagoramosal" class="text-gray-400 hover:text-gray-500">
            <span class="sr-only">Instagram</span>
            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
              <path
                fill-rule="evenodd"
                d="M12.315 2c2.43 0 2.784.013 3.808.06 1.064.049 1.791.218 2.427.465a4.902 4.902 0 011.772 1.153 4.902 4.902 0 011.153 1.772c.247.636.416 1.363.465 2.427.048 1.067.06 1.407.06 4.123v.08c0 2.643-.012 2.987-.06 4.043-.049 1.064-.218 1.791-.465 2.427a4.902 4.902 0 01-1.153 1.772 4.902 4.902 0 01-1.772 1.153c-.636.247-1.363.416-2.427.465-1.067.048-1.407.06-4.123.06h-.08c-2.643 0-2.987-.012-4.043-.06-1.064-.049-1.791-.218-2.427-.465a4.902 4.902 0 01-1.772-1.153 4.902 4.902 0 01-1.153-1.772c-.247-.636-.416-1.363-.465-2.427-.047-1.024-.06-1.379-.06-3.808v-.63c0-2.43.013-2.784.06-3.808.049-1.064.218-1.791.465-2.427a4.902 4.902 0 011.153-1.772A4.902 4.902 0 015.45 2.525c.636-.247 1.363-.416 2.427-.465C8.901 2.013 9.256 2 11.685 2h.63zm-.081 1.802h-.468c-2.456 0-2.784.011-3.807.058-.975.045-1.504.207-1.857.344-.467.182-.8.398-1.15.748-.35.35-.566.683-.748 1.15-.137.353-.3.882-.344 1.857-.047 1.023-.058 1.351-.058 3.807v.468c0 2.456.011 2.784.058 3.807.045.975.207 1.504.344 1.857.182.466.399.8.748 1.15.35.35.683.566 1.15.748.353.137.882.3 1.857.344 1.054.048 1.37.058 4.041.058h.08c2.597 0 2.917-.01 3.96-.058.976-.045 1.505-.207 1.858-.344.466-.182.8-.398 1.15-.748.35-.35.566-.683.748-1.15.137-.353.3-.882.344-1.857.048-1.055.058-1.37.058-4.041v-.08c0-2.597-.01-2.917-.058-3.96-.045-.976-.207-1.505-.344-1.858a3.097 3.097 0 00-.748-1.15 3.098 3.098 0 00-1.15-.748c-.353-.137-.882-.3-1.857-.344-1.023-.047-1.351-.058-3.807-.058zM12 6.865a5.135 5.135 0 110 10.27 5.135 5.135 0 010-10.27zm0 1.802a3.333 3.333 0 100 6.666 3.333 3.333 0 000-6.666zm5.338-3.205a1.2 1.2 0 110 2.4 1.2 1.2 0 010-2.4z"
                clip-rule="evenodd"
              />
            </svg>
          </a>
          <a href="https://www.twitter.com/thramosal" class="text-gray-400 hover:text-gray-500">
            <span class="sr-only">Twitter</span>
            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
              <path d="M8.29 20.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84" />
            </svg>
          </a>
          <a href="https://github.com/thiagoramos23" class="text-gray-400 hover:text-gray-500">
            <span class="sr-only">GitHub</span>
            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
              <path
                fill-rule="evenodd"
                d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z"
                clip-rule="evenodd"
              />
            </svg>
          </a>
          <a href="https://www.youtube.com/thiagoramosal" class="text-gray-400 hover:text-gray-500">
            <span class="sr-only">YouTube</span>
            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
              <path
                fill-rule="evenodd"
                d="M19.812 5.418c.861.23 1.538.907 1.768 1.768C21.998 8.746 22 12 22 12s0 3.255-.418 4.814a2.504 2.504 0 0 1-1.768 1.768c-1.56.419-7.814.419-7.814.419s-6.255 0-7.814-.419a2.505 2.505 0 0 1-1.768-1.768C2 15.255 2 12 2 12s0-3.255.417-4.814a2.507 2.507 0 0 1 1.768-1.768C5.744 5 11.998 5 11.998 5s6.255 0 7.814.418ZM15.194 12 10 15V9l5.194 3Z"
                clip-rule="evenodd"
              />
            </svg>
          </a>
        </div>
        <div class="mt-8 md:order-1 md:mt-0">
          <p class="text-xs text-center text-gray-500 leading-5">
            &copy; <%= @year %>. Feito com carinho por Thiago Ramos.
          </p>
        </div>
      </div>
    </footer>
    """
  end

  defp can_become_teacher(current_user) do
    current_user && Athena.Accounts.user_admin?(current_user) && is_nil(current_user.teacher)
  end

  defp can_access_teacher_panel(current_user) do
    current_user && !is_nil(current_user.teacher) && Athena.Accounts.user_admin?(current_user)
  end
end
