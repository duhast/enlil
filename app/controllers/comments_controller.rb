class CommentsController < ApplicationController
  before_filter :authenticated_user_required, :only => [:create, :new]

  include UrlHelper

  before_filter :find_post, :except => [:new]

  def index
    if request.post?
      create
    else
      redirect_to(post_path(@post))
    end
  end

  def new
    @comment = Comment.build_for_preview(params[:comment], current_user)

    respond_to do |format|
      format.js do
        render :partial => 'comment.html.erb', :locals => {:comment => @comment}
      end
    end
  end

  def form
    @comment = Comment.new
    respond_to do |format|
      format.js do
        render :partial => 'comment_form' #, :locals => {:comment => @comment}
      end
    end
  end

  def create
    @comment = Comment.new((session[:pending_comment] || params[:comment] || {}).reject {|key, value| !Comment.protected_attribute?(key) })
          @comment.post = @post

    @comment.set_author_info(current_user)

          session[:pending_comment] = nil

      if @comment.save
        redirect_to post_path(@post)
      else
        render :template => 'posts/show'
      end
    end

  protected

  def find_post
    @post = Post.find_by_permalink(*[:year, :month, :day, :slug].collect {|x| params[x] })
  end
end
