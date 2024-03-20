require 'openai'

class Api::V1::TestsController < ApplicationController

  def index
    @tests = Test.all

    render json: @tests.order(created_at: :desc)
  end

  def show
    @test = Test.find(params[:id])
    openai_client = OpenAI::Client.new(api_key: ENV.fetch("OPENAI_ACCESS_TOKEN"), default_engine: "ada")
    response = openai_client.search(documents: ["White House", "hospital", "school"], query: "the president")
    @test.challenges["challenge1"]["answer"] = response
    render json: @test
  end

  def create
    @test = Test.new(test_params)
    if @test.save
      render json: @test, status: :created
    else
      render json:{ error: @test.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def test_params
    params.require(:test).permit(:max_score, :time, challenges: {} )
  end
end
