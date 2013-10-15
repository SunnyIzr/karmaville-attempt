class UsersController < ApplicationController
  def index
  	@page = params[:page].to_i
  	@page = 1 if @page == 0
    @users = User.by_karma.limit(50).offset(50*(@page-1))
    p @page
	case @page
	when 2
		@paginate = [-1, 0, 1, 2, 3]
	when 1
		@paginate = [0, 1, 2, 3, 4]
	else
		@paginate = [-2,-1,0,1,2] 
	end
	p "*"*1000
	p @paginate
  end
end
