class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    #current_user.update_attribute(:online, true)

    stream_from "appearance_channel"

    speak('online' => true)
  end

  def unsubscribed
    #current_user.update_attribute(:online, false)

    stream_from "appearance_channel"

    speak('online' => false)
  end

  def speak(data)
    logger.info "appearance_channel, speak: #{data.inspect}"

    UserService.new(
      user: current_user, online: data['online']
    ).perform
  end
end
