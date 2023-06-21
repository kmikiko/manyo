class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.includes(:labels).order(created_at: "DESC").page(params[:page])

    if params[:sort_expired]
      @tasks = @tasks.includes(:labels).order(expired_at: "DESC").page(params[:page])
    end
    if params[:sort_priority]
      @tasks = @tasks.order(priority: "ASC").page(params[:page])
    end

    if params[:task].present?
      if params[:task][:keyword].present? && params[:task][:status].present?
        @tasks = @tasks.search_name(params[:task][:keyword]).search_status(params[:task][:status]).page(params[:page])
      elsif params[:task][:keyword].present?
        @tasks = @tasks.search_name(params[:task][:keyword]).page(params[:page])
      elsif params[:task][:status].present?
        @tasks = @tasks.search_status(params[:task][:status]).page(params[:page]) 
      elsif params[:task][:label_ids].present?
        # @labellings = Labelling.where(label_id: params[:task][:label_ids]).pluck(:task_id)
        @tasks = @tasks.where(id: Labelling.search_label_id(params[:task][:label_ids])).page(params[:page])
      else
        @tasks = @tasks.all.order(created_at: "DESC").page(params[:page])
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id

    if @task.save
      redirect_to tasks_path, notice:'登録しました！'
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました!!!!!!!"
    else
      render :edit
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to tasks_path, notice: '削除しました'
    end
  end

  private
  
  def task_params
    params.require(:task).permit(:name, :detail, :expired_at, :status, :priority, label_ids: [] )
  end

end


