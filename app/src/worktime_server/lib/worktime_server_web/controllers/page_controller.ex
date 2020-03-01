defmodule WorktimeServerWeb.PageController do
  use WorktimeServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def version(conn, _params) do
    # TODO: get version from config
    text(conn, "WorkTime Server v1.0")
  end
end
