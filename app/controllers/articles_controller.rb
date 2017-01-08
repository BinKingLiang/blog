class ArticlesController < ApplicationController

	http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
	
	def new
		@article = Article.new
	end
# render 方法接受一个简单的 Hash 为参数，这个 Hash 的键是 plain，对应的值为 params[:article].inspect。params 方法表示通过表单提交的参数，返回 ActiveSupport::HashWithIndifferentAccess 对象，可以使用字符串或者 Symbol 获取键对应的值。现在，我们只关注通过表单提交的参数。


	def create
	  	@article = Article.new(article_params)
 
  		if @article.save
    		redirect_to @article
  		else
    		render 'new'
 		end
	end
	
	def show
  		@article = Article.find(params[:id])
	end

	private
	  def article_params
	    params.require(:article).permit(:title, :text)
	  end


	public

	def index
  		@articles = Article.all
	end

	def edit
  		@article = Article.find(params[:id])
	end

	def update
  		@article = Article.find(params[:id])
 
  		if @article.update(article_params)
    	redirect_to @article
  		else
    		render 'edit'
  		end
	end
 
	private
  	def article_params
    	params.require(:article).permit(:title, :text)
  	end

  	public
  	def destroy
  		@article = Article.find(params[:id])
  		@article.destroy
  		redirect_to articles_path
	end

end
