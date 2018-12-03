class EmployeesController < ApplicationController
    before_action :authentication!, only:[:index]
    # caches_action :index
    caches_page :info
    def index
      @employees = Employee.by_gender params[:gender]
      fresh_when etag: @employees, last_modified: @employees.first.updated_at
    end

    def info
      @employees = Employee.all
    end


  private

  def authentication!
    render plain: '404' unless params[:admin].present?
  end
end