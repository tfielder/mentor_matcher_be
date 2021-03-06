class Api::V1::Admin::StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def create
    student = Student.new(student_params)
    if student.save
      render json: StudentSerializer.new(student), status: 201
    else
      render json: {}, status: 401
    end
  end

  def index
    render json: StudentSerializer.new(Student.all)
  end

  def show
    id = params[:id]
    render json: StudentSerializer.new(Student.find(id))
  end

  def update
    id = params[:id]
    Student.find(id).update(student_params)
    render json: StudentSerializer.new(Student.find(id))
  end

  def destroy
    id = params[:id]
    Student.find(id).delete
  end

  private
    def student_params
      params.require(:student).permit(:name,
                                    :pronouns,
                                    :email,
                                    :slack_username,
                                    :matched,
                                    :active,
                                    :background,
                                    :stack,
                                    industries: [],
                                    identity_marker: [])
    end
end
