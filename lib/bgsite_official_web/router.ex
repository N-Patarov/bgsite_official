defmodule BgsiteOfficialWeb.Router do
  use BgsiteOfficialWeb, :router
  use Kaffy.Routes, scope: "/admin", pipe_through: [:browser, :require_authenticated_admin]

  import BgsiteOfficialWeb.AdminAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BgsiteOfficialWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_admin
  end

  pipeline :kaffy_browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BgsiteOfficialWeb do
    pipe_through :browser
    get "/", WebsitesController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BgsiteOfficialWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BgsiteOfficialWeb.Telemetry

    end
  end

  ## Authentication routes

  scope "/", BgsiteOfficialWeb do
    pipe_through [:browser, :redirect_if_admin_is_authenticated]

    get "/admin/register", AdminRegistrationController, :new
    post "/admin/register", AdminRegistrationController, :create
    get "/admin/log_in", AdminSessionController, :new
    post "/admin/log_in", AdminSessionController, :create
    get "/admin/reset_password", AdminResetPasswordController, :new
    post "/admin/reset_password", AdminResetPasswordController, :create
    get "/admin/reset_password/:token", AdminResetPasswordController, :edit
    put "/admin/reset_password/:token", AdminResetPasswordController, :update
  end

  scope "/", BgsiteOfficialWeb do
    pipe_through [:browser, :require_authenticated_admin]

    get "/admin/settings", AdminSettingsController, :edit
    put "/admin/settings", AdminSettingsController, :update
    get "/admin/settings/confirm_email/:token", AdminSettingsController, :confirm_email
  end

  scope "/", BgsiteOfficialWeb do
    pipe_through [:browser, :require_authenticated_admin]
    resources "/requests", RequestController
    resources "/tags", TagController
  end

  scope "/admin", BgsiteOfficialWeb do
    pipe_through [:browser, :require_authenticated_admin]
    resources "/requests", RequestController
    resources "/tags", TagController
  end

  scope "/", BgsiteOfficialWeb do
    pipe_through [:browser]
    resources "/feedback", FeedbackController
    delete "/admin/log_out", AdminSessionController, :delete
    get "/admin/confirm", AdminConfirmationController, :new
    post "/admin/confirm", AdminConfirmationController, :create
    get "/admin/confirm/:token", AdminConfirmationController, :confirm

    resources "/websites", WebsitesController
    get "/request/new", RequestController, :new
    post "/requests", RequestController, :create


  end
end
