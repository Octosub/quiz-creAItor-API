require 'openai'
require 'pdf-reader'

class Api::V1::TestsController < ApplicationController

  def index
    @tests = Test.all

    render json: @tests.order(created_at: :desc)
  end

  def show
    @test = Test.find(params[:id])

    render json: @test
  end

  def create
    uploaded_file = params[:file]
    number_of_challenges = params[:number].to_i
    file_path = Rails.root.join('public', 'uploads', uploaded_file.original_filename)

    File.open(file_path, 'wb') do |file|
      file.write(uploaded_file.read)
    end

    if File.exist?(file_path)
      reader = PDF::Reader.new(file_path)
      text = ""
      reader.pages.each do |page|
        text << page.text
      end
    end

    #raw_body = request.body.read
    #parsed_body = JSON.parse(raw_body)
    #prompt = parsed_body['content']

    @test = Test.new
    @test.create_test(number_of_challenges, text)

    if @test.save
      render json: @test, status: :created
    else
      render json:{ error: @test.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def test_params
    params.require(:test).permit(:max_score, :time)
  end
end
