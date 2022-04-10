defmodule RewarderWeb.Router do
  use RewarderWeb, :router

  import RewarderWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {RewarderWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RewarderWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", RewarderWeb do
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

      live_dashboard "/dashboard", metrics: RewarderWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  ## Routes related to user account settings and session
  scope "/", RewarderWeb do
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
  ## Routes related to authenticated users
  scope "/", RewarderWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
    get "/users/show", UserSendController, :show
    post "/users/show", UserSendController, :send

  ## Routes related to rewards intended for ordinary users
  end
  scope "/", RewarderWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/reward", RewardController, :index
    get "/reward/:reward_id/buy", RewardController, :buy
  end

  ## Routes related to history
  scope "/", RewarderWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/history", StoriesController, :user_index
  end

  ## Routes related to rewards that require admin role
  scope "/", RewarderWeb do
    pipe_through [:browser, :require_authenticated_user, :require_admin]

    post "/reward", RewardController, :create
    get "/reward/:id/edit", RewardController, :edit
    get "/reward/new", RewardController, :new
    put "/reward/:id", RewardController, :update
    patch "/reward/:id", RewardController, :update
    delete "/reward/:id", RewardController, :delete


  end
  ## Routes intended for admin, related to history
  scope "/", RewarderWeb do
    pipe_through [:browser, :require_authenticated_user, :require_admin]

    get "/adminhistory", StoriesController, :admin_index
    post "/history/getby", StoriesController, :show_filtered_stories
  end

  ## Routes intended for admin, related to granting points to each user
  scope "/", RewarderWeb do
    pipe_through [:browser, :require_authenticated_user, :require_admin]

    get "/users/show/updated", UserSendController, :give_pointsTS
  end

  ## Routes related to session and account confirmation
  scope "/", RewarderWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
