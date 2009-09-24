class MessagesController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  
 layout "application"
 
  # GET /messages
  # GET /messages.xml
  def index
    @messages = Message.find(:all, :order => "created_at DESC")
    if params[:id].blank?
    @message = Message.find(:last)
   
  else
    @message = Message.find(params[:id]) 
  end
   
    
    respond_to do |format|
      format.html # index.html.erb
      
     
   end
  
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @messages = Message.find(:all, :order => "created_at DESC")
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new
   render :action => "new", :layout => "public"
   
  end

  

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
  if simple_captcha_valid?
    respond_to do |format|
      if @message.save
        flash[:notice] = 'Tusen takk for meldingen din, vi vil svare deg så fort som mulig.'
        format.html { redirect_to(root_path) }
        
      else
        format.html { render :action => "new", :layout => "public" }
        
      end
    end
    else
        respond_to do |format|
        flash[:notice] = 'Koden nederst i meldingsvinduet var feil. Prøv igjen. Du trenger ikke å bry deg om store eller små bokstaver.'
        format.html { render :action => "new", :layout => "public" }
    end
    end
  end

 

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
 
  
 
  
end
