module ApplicationHelper

  def markdown_to_html(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      tables: true
    }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end
  
  def can_mark_private?(wiki, user, wiki_update)
    if user.role == 'admin'
      return true
    elsif wiki_update
      return (user.role == 'premium' && wiki.user == user) ? true : false
    else
      return (user.role == 'premium') ? true : false
    end
  end

end
