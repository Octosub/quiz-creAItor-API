class Test < ApplicationRecord

  def create_test(number_of_challenges, max_score, time, input)
    client = OpenAI::Client.new

    response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          response_format: { type: "json_object" },
          messages: [{ role: "user", content:
          "
          Generate the following json object and fill out the curly braces with the instructions inside the curly braces. Take the following topic to generate the questions and answers '#{input}' and create #{number_of_challenges} challenges:
          {
          'test': {
            'max_score': '#{max_score}',
            'time': '#{time}',
            'challenges': {
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
              'challenge2' : {
                'question': '{generate question 2}',
                'choices': {
                  'choice1': '{generate choice 1}',
                  'choice2': '{generate choice 2}',
                  'choice3': '{generate choice 3}',
                  'choice4': '{generate choice 4}'
                },
                'answer': '{generate answer 2}'
              }
            }
          }
          Dont put any '\' or '\n' in the json object. The json object should be in one line.
          "}],
          temperature: 0.7,
      }
    )

    self.challenges = response.dig("choices", 0, "message", "content")
  end
end
