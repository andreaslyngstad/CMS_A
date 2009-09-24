xml.instruct! :xml, :version => "1.0", :encoding => "ISO-8859-1"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Teater|Camp"
    xml.description "Blogginnlegg"
    xml.link formatted_posts_url(:rss)
    
    for post in @posts
      xml.item do
        xml.title post.title   
        xml.description post.lead
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link view_post_url(:id => post.id, :title => post.title)
        xml.guid view_post_url(:id => post.id, :title => post.title)
      end
    end
  end
end