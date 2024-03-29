defmodule BgsiteOfficialWeb.Router do
  use BgsiteOfficialWeb, :router

  import BgsiteOfficialWeb.UserAuth
  #use Kaffy.Routes, scope: "/admin", pipe_through: [:browser, :require_authenticated_admin]

  import BgsiteOfficialWeb.AdminAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BgsiteOfficialWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
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
    # get "/", IndexController, :index
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
    get "/admin/register", AdminRegistrationController, :new
    post "/admin/register", AdminRegistrationController, :create
    get "/admin", AdminController, :index

  end

  scope "/", BgsiteOfficialWeb do
    pipe_through [:browser,:require_authenticated_admin]
    resources "/tags", TagController, except: [:show]
    get "/websites/new", WebsitesController, :new
    post "/websites", WebsitesController, :create
  end


  scope "/", BgsiteOfficialWeb do
    pipe_through [:browser]
    delete "/admin/log_out", AdminSessionController, :delete
    get "/admin/confirm", AdminConfirmationController, :new
    post "/admin/confirm", AdminConfirmationController, :create
    get "/admin/confirm/:token", AdminConfirmationController, :confirm
    resources "/tags", TagController, only: [:show]
    resources "/websites", WebsitesController, except: [:create]
    get "/admin/websites", AdminController, :websites
    live "/website_live/:id", WebsiteLive


    # get "/request/new", RequestController, :new
    # post "/requests", RequestController, :create


  end

  ## Authentication routes

  scope "/", BgsiteOfficialWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]
    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", BgsiteOfficialWeb do
    pipe_through [:browser, :require_authenticated_user]
    get "/feedback/new", FeedbackController, :new
    post "/feedback/new", FeedbackController, :create
    get "/request/new", RequestController, :new
    post "/request/new", RequestController, :create
    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
    live "/tag_live/:id", WebsitesLike
    get "/user/profile", UserController, :index
    resources "/promotions", PromotionController, only: [:create, :new, :index, :edit, :delete]

  end

  scope "/admin", BgsiteOfficialWeb do
    pipe_through [:browser, :require_authenticated_admin]
    resources "/feedback", FeedbackController, except: [:create]
    resources "/requests", RequestController, except: [:create]
  end

  scope "/", BgsiteOfficialWeb do
    pipe_through [:browser]
    resources "/requests", RequestController
    resources "/feedback", FeedbackController
    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm

  end
end
