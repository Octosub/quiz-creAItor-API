class Api::V1::TestsController < ApplicationController

  def index
    @tests = Test.all

    render json: @tests.order(created_at: :desc)
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
