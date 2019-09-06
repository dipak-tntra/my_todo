class TodoItemsController < ApplicationController
	before_action :set_todo_list
	before_action :set_todo_item, except: [:create]

	def create
		@todo_item = @todo_list.todo_items.create(todo_item_params)
		redirect_to @todo_list
	end

	def destroy
		@todo_item = @todo_list.todo_items.find_by(id: params[:id])
		if @todo_item.destroy
			flash[:success] = t('success.todo_item')
		else
			flash[:error] = t('failure.todo_item')
		end
		redirect_to @todo_list
	end

	def complete
		@todo_item.update_attribute(:completed_at, Time.now)
		redirect_to @todo_list, notice: t('success.complete')
	end

	private

	def set_todo_list
		@todo_list = TodoList.find_by(id: params[:todo_list_id])
	end

	def set_todo_item
		@todo_item = @todo_list.todo_items.find_by(id: params[:id])
	end

	def todo_item_params
		params[:todo_item].permit(:content)
	end
end
