class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast 'notifications_channel', { message: data['message'] };
  end
end
