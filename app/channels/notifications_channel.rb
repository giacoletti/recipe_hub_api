class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    # binding.pry
    ActionCable.server.broadcast 'NotificationsChannel', { message: data['message'] };
  end
end
