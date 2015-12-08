defmodule Releasebot.CLI do
  def main(_) do
    Releasebot.Notify.send_notification
  end
end
