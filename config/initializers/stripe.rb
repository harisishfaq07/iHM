# Rails.configuration.stripe = {
#   :publishable_key => ENV['#{StripeAccount.last.p_key}'],
#   :secret_key      => ENV['SECRET_KEY']
# }
Rails.application.config.to_prepare do
  if StripeAccount.count > 0
    @s_key = StripeAccount.last.s_key.to_s
    @p_key = StripeAccount.last.p_key.to_s
  end
Rails.configuration.stripe = {
  :publishable_key => @p_key ,
  :secret_key      => @s_key
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
end