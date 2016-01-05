defmodule Releasebot.CLI do
  def main(_) do
    Releasebot.Notify.needs_release
    Releasebot.Notify.open_prs
  end
end
