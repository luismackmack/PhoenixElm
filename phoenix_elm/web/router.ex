defmodule PhoenixElm.Router do
  use PhoenixElm.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  # Other scopes may use custom stacks.
  scope "/api", PhoenixElm do
    pipe_through :api
    post "/authenticate", AuthenticateController, :authenticate
    post "/registrations", RegistrationController, :create
    get "/registrations", RegistrationController, :index
  end
end
