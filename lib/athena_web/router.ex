defmodule AthenaWeb.Router do
  use AthenaWeb, :router

  import AthenaWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AthenaWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AthenaWeb do
    pipe_through :browser

    live_session :public,
      on_mount: [{AthenaWeb.UserAuth, :mount_current_user}] do
      live "/", Students.CoursesLive.Index, :index
      live "/courses/:course_slug", Students.CoursesLive.Show, :show
      live "/courses/:course_slug/classes/:class_slug", Students.ClassesLive.Show, :show
      live "/checkout", CheckoutLive.Index, :index
    end

    live_session :require_user_authenticated,
      on_mount: [{AthenaWeb.UserAuth, :ensure_authenticated}] do
      live "/my-courses", Students.MyCoursesLive.Index, :index
      live "/teachers/new", Teachers.TeacherLive.Index, :new
      live "/teachers", Teachers.TeacherLive.Index, :index

      live "/teachers/courses/new", Teachers.CourseLive.Index, :new
      live "/teachers/courses", Teachers.CourseLive.Index, :index
      live "/teachers/courses/:course_slug/edit", Teachers.CourseLive.Index, :edit
      live "/teachers/courses/:course_slug", Teachers.ClassLive.Index, :index
      live "/teachers/courses/:course_slug/classes/new", Teachers.ClassLive.Index, :new

      live "/teachers/courses/:course_slug/classes/:class_slug/edit",
           Teachers.ClassLive.Index,
           :edit

      live "/teachers/courses/:course_slug/classes/:class_slug", Teachers.ClassLive.Show, :index
    end
  end

  scope "/", AthenaWeb do
    pipe_through [:browser, :require_authenticated_user]
  end

  # Other scopes may use custom stacks.
  # scope "/api", AthenaWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:athena, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: AthenaWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", AthenaWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{AthenaWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", AthenaWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{AthenaWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", AthenaWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{AthenaWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
