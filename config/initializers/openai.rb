OpenAI.configure do |config|
  config.access_token = ENV.fetch("chatgpt_api_key")
end
