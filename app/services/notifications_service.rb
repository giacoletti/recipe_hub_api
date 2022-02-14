module NotificationsService
  def self.notify(channel, recipe)
    message = { message: "#{recipe.user.name} created a new #{recipe.name} recipe." }
    ActionCable.server.broadcast(channel, message)
  end
end
