defmodule CueWeb.PageController do
  use CueWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
