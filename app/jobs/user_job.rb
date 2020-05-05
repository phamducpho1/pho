class UserJob < ApplicationJob
  queue_as :default

  def perform order
    @order = order
    UserMailer.mailer_order(@order).deliver_later
  end
end
