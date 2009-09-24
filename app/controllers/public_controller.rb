class PublicController < ApplicationController
  skip_before_filter :login_required, :recent_posts, :recent_videos, :recent_guides
  before_filter :set_all_categories,
                :instantiate_controller_and_action_names, :get_pages_for_tabs, :get_sub_tabs, :get_tags
 
  layout "public"
  
  def index 
    @page = Page.find_by_name(params[:name], :include => [:parent])
    if @page.nil?
      redirect_to(:action => "start")
    end
    @posts = Post.find(:all, :conditions => "status = 'Offentlig'", 
                                     :order => "created_at DESC", :limit => 3)
    
    
  end
  
  def start
    
  end
  def tag
    @tag = Tag.find(params[:id])
    @posts = Post.find_tagged_with(@tag, :include => [:author, :comments],
    :order => "posts.created_at DESC", :conditions => "status = 'Offentlig'")
    @posts_til_liste = Post.eager_post
    render(:action => 'blogg')
    
  end
  
  def blogg
    @posts = Post.search(params[:search])
    @posts_til_liste = Post.eager_post
    respond_to do |format|
      format.html
      format.rss {render :layout => false}
    end
  end
  
  def view_post
    @post = Post.find(params[:id], :include => [:author, :categories, :approved_comments])
    @posts_til_liste = Post.eager_post
    render(:template => 'shared/view_post')
    
  end
  
  def add_comment
    @posts_til_liste = Post.eager_post
    @comment = Comment.new(params[:comment])
    @post = Post.find(params[:id])
    if simple_captcha_valid?
    
    @comment.post = @post
    @comment.status = "nye"
    if @comment.save
      flash[:notice] = "Du har lagt til en kommentar."
      redirect_to(:action => "view_post", :id => @post.id)
    else
      flash[:error] = "Obs! Du skrive navn, gyldig epost og en kommentar. Prøv igjen."
      render(:template => 'shared/view_post')
    end
  else
    
   flash[:error] = "Du skrev ikke koden riktig. Prøv igjen"
   render(:template => 'shared/view_post')
    end
   
  end
  
   def category
     @posts_til_liste = Post.eager_post
    @posts = Post.find(:all, :include => [:author, :categories], 
    :conditions => ["status = 'Offentlig' AND categories.id = ?", params[:id]], 
    :order => "posts.created_at DESC")
    
    render(:action => 'blogg')
    
  end
   
  
  
end
