class Gpt
  def self.call(prompt)
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
    model: "gpt-3.5-turbo",
    messages: [{ role: "user", content: prompt}],
    temperature: 1.0
    })
    chatgpt_response["choices"][0]["message"]["content"]
  end
end
