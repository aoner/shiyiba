defmodule SkyWeb.Router do
  use SkyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Sky.Plugs.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SkyWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/help", HelpController, :index
    # 注册
    get "/signup", UserController, :new, as: :signup
    post "/signup", UserController, :create, as: :signup
    # 登录
    get "/signin", SessionController, :new, as: :signin
    post "/signin", SessionController, :create, as: :signin
    # 退出
    get "/signout", SessionController, :delete, as: :signout
    # 个人主页
    get "/:mobile", UserController, :show
    # resources "/users", UserController, only: [:index, :edit, :update, :delete]
    resources "/setting", SettingController, only: [:update, :show], singleton: true do
      get("/account", SettingController, :account, as: :account)
      get("/password", SettingController, :password, as: :password)
      get("/profile", SettingController, :profile, as: :profile)
    end

    resources "/posts", PostController
    resources "/commodities", CommodityController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SkyWeb do
  #   pipe_through :api
  # end
end
