# Rails.configuration.stripe = {
#   :publishable_key => ENV['#{StripeAccount.last.p_key}'],
#   :secret_key      => ENV['SECRET_KEY']
# }

Rails.configuration.stripe = {
  :publishable_key => "pk_test_51MLO5YJKNJVhEqPTC9BoipbgmLcxo8zuAkUIMioC7NWLQMDM0Sg2w2TFai2UsjB74kbWv0UvJH6Tg9nVqZdBVkqZ00GGQmY3je" ,
  :secret_key      => "sk_test_51MLO5YJKNJVhEqPTWdd4rgGNY0g76Ca1PuTTfHEQMa0qXjt1E3RS7frvZluXSmwOtiyRlnpqWYS7zz3Ej99aYnik00p0KTYSuH"
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
