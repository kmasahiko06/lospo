class PostsController < ApplicationController

    include Jpmobile::ViewSelector

    before_action :set_project, only: [:show, :edit, :update, :destroy]

    def index
        if request.smart_phone?
              per = 12
        elsif request.mobile && request.mobile.tablet? #タブレット用の処理
          per = 12
      elsif
          per = 18
        end
        @posts = Post.order(:id).reverse_order.page(params[:page]).per(per)

        # パラメータとして募集形式か都道府県かスポーツを受け取っている場合は絞って検索する
         if params[:bosyuu].present?
           @posts = @posts.get_by_bosyuu params[:bosyuu]
         end
        if params[:prefecture].present?
            @posts = @posts.get_by_prefecture params[:prefecture]
         end
         if params[:spo_cate].present?
             @posts = @posts.get_by_spo_cate params[:spo_cate]
          end
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(params_post)
        if @post.save
            redirect_to post_path(@post)
        else
            render "new"
        end
    end

    def show
    end

    def edit
    end

    def update
	     if @post.update_attributes(params_post)
	        redirect_to post_path(@post)
        else
            render "edit"
        end
    end

    def destroy
        @post.destroy
        redirect_to posts_path
    end

    private

    def params_post
        params.require(:post).permit(:title, :text, :image, :image_cache, :remove_image, :bosyuu, :prefecture,:spo_cate)
    end

    def set_project
        @post = Post.find(params[:id])
    end
end
