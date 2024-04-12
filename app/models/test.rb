class Test < ApplicationRecord

  self.table_name = "quizcr_tests"

  def create_test(number_of_challenges, input)
    client = OpenAI::Client.new

    response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          response_format: { type: "json_object" },
          messages: [{ role: "user", content:
          "
          Generate the following json object and fill out the curly braces with the instructions inside the curly braces. Take the following topic to generate the questions and answers '#{input}'. Create #{number_of_challenges} challenges with the following structure:
          {
          'challenge1': {
            'question': '{generate question 1}',
            'choices': {
              'choice1': '{generate choice 1}',
              'choice2': '{generate choice 2}',
              'choice3': '{generate choice 3}',
              'choice4': '{generate choice 4}'
            },
            'answer' : '{generate answer 1}'
          },
          ...
          "}],
          temperature: 0.5,
      }
    )

    self.challenges = response.dig("choices", 0, "message", "content")
    self.max_score = number_of_challenges * 10
    self.time = number_of_challenges * 40000
  end
end
