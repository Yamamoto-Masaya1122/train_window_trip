class CommentsController < ApplicationController

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend('comments', partial: 'comments/comment', locals: { comment: @comment }),
            turbo_stream.replace('comment_form', partial: 'comments/form', locals: { commentable: @commentable, comment: Comment.new })
          ]
        end
        format.js
        format.html { redirect_to @comment.commentable, flash: { success: t('defaults.message.created', item: Comment.model_name.human)} }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('comment_form', partial: 'comments/form', locals: { commentable: @comment.commentable, comment: @comment }),
            turbo_stream.prepend('error_messages', partial: 'shared/error_messages', locals: { object: @comment }),
          ]
        end
        format.html { redirect_to @comment.commentable, flash: { error: t('defaults.message.not_created', item: Comment.model_name.human) } }
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
        format.js
        format.html { redirect_to @comment.commentable, flash: { success: t('defaults.message.destroyed', item: Comment.model_name.human) } }
    end
  end

  def edit
    @commentable = find_commentable
    @comment = current_user.comments.find(params[:id])
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@comment), partial: 'comments/form', locals: { comment: @comment }) }
      format.html
    end
  end

  def update
    @comment = current_user.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@comment, partial: 'comments/comment', locals: { comment: @comment })
        end
        format.html { redirect_to @comment.commentable, flash: { success: t('defaults.message.updated', item: Comment.model_name.human) } }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(@comment, partial: 'comments/form', locals: { commentable: @comment.commentable, comment: @comment }),
            turbo_stream.prepend('error_messages', partial: 'shared/error_messages', locals: { object: @comment })
          ]
        end
        format.html do
          redirect_to @comment.commentable,
                      flash: { danger: t('defaults.message.not_updated', item: Comment.model_name.human) }
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end

  def find_commentable
    params.each do |name, value|
      return ::Regexp.last_match(1).classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    nil
  end
end