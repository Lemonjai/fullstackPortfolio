class ProjectsController < ApplicationController
	before_action :find_projects, only: [:show, :edit, :update, :destroy]

	def index
		@projects = Project.all.order("created_at desc").paginate(page: params[:page], per_page: 4) 
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new project_params

		if @project.save
			redirect_to @project, notice: "Project has been saved!!"
		else
			render 'new', notice: "Project failed to save"
		end
	end

	def show
	end

	def edit
	end

	def update
		if @project.update project_params
			redirect_to @project, notice: "Successful"
		else
			render 'edit'
		end
	end

	def destroy
		@project.destroy
		redirect_to projects_path
	end


	private

		def find_projects
			@project = Project.friendly.find(params[:id])
		end

		def project_params
			params.require(:project).permit(:title, :description, :link, :slug)
		end
end
