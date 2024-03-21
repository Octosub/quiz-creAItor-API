class Test < ApplicationRecord

  def chatgpt
    client = OpenAI::Client.new

    response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          response_format: { type: "json_object" },
          messages: [{ role: "user", content: "Hello!"}],
          temperature: 0.7,
      }
    )

    self.challenges["challenge1"]["answer"] = response["choices"][0]["message"]["content"]
  end
end
