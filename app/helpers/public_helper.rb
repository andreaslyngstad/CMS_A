module PublicHelper
  
  def children_nested(pages)
    returning "" do |html|
        
       
      unless pages.empty?
        pages.each do |page|
        html << "<div class='thumbnail'>"
        
        html << "<div class='caption'>"
        html << "#{link_to(page.navlabel.upcase, view_page_path(page.name))}"
        html << "</div>"
        html << "#{link_to image_tag(page.nav_photo.url(:small), :border=>0, :title => page.navlabel, :align => "middle"), view_page_path(page.name)}"
        
        
        html << "</div>"
        end
           
     end
    end
  end
  def siblings_nested(pages) 
    returning "" do |html|      
      unless pages.empty?
        
        pages.each do |page|
         html << "<div class='thumbnail'>"
           if page.child? 
             html << "<div class='caption'>"
            html << "#{link_to(page.navlabel.upcase, view_page_path(page.name))}"
            html << "</div>"
            html << "#{link_to image_tag(page.nav_photo.url(:small), :border=>0, :title => page.navlabel, :align => "middle"), view_page_path(page.name)}"
           
            html << "</div>"
           end
     
       
     
    end
    end
    end
  end
  
  def public_nested(pages)
    returning "" do |html|
      unless pages.empty?
        html << "<ul>"
        pages.each do |page|
         
           if !page.child?
           
           html << "<li>#{link_to_unless_current "<span>#{page.navlabel.to_s}</span>", view_page_path(page.name)}"  
           
           end
     
        html << "</li>"
        
      end
      html << "</ul>"
      end
    end
  end 
end
