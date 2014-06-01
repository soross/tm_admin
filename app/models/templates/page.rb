class Templates::Page < ActiveRecord::Base
  belongs_to :template
  has_many :site_pages

  before_create :generate_form
  before_destroy :drop_keystore
  after_save :assign_template_keystore

  attr_accessor :html, :form 
  validates :title, :position, presence: true
  
  acts_as_taggable

  private
  def generate_form
    #  <%= SitePageKeystore.value_for(@site_page, 'name', title: '标题', typo: 'string', default: true, required: true) %>
    #  a =  "{typo: 'string', default: true, required: true}"
    #  > eval a
    # => {:typo=>"string", :default=>true, :required=>true} 
    form_html = []
    reg = /SitePageKeystore.value_for\(@site_page,\s*'([^'']+)'(?:,\s*(.*))?\)/
    self.html.scan(reg).each do |match|
      #parse a string into hash
      opt = {}
      opt = eval('{' + match[1] + '}') if match[1]
      form_html << get_input(match[0], opt)
    end
    self.form = form_html.join
  end

  #SitePageKeystore.value_for(@site_page, 'content', type: 'select', options: ['a', 'b', 'c'], title: 'title', default: true) 
  def get_input(name, opt)
    opt[:typo] = opt[:type] if opt[:typo].blank? #alias
    opt[:typo] = 'string' if opt[:typo].blank? #default 
    opt[:title] = name if opt[:title].blank? #init title
    key = CommonKey.find_or_create_by(name: name)
    key.typo = opt[:typo] if key.typo.blank?
    key.title = opt[:title] if key.title.blank?
    key.save

    arr = [%{<!-- #{name}-->}]
    arr << %{\n<div class="control-group">}
    arr << %{\n   <label class="}
    arr << 'required ' if opt[:required] == true
    arr << opt[:typo]
    arr << %{ control-label">}
    arr << %{<abbr title="必填项">*</abbr>} if opt[:required] == true
    arr << %{#{key.title}</label>}
    arr << %{\n    <div class="controls">\n        }
    case opt[:typo].downcase
    when 'string'
      arr << %{<input class="#{opt[:typo]} #{if opt[:required] then 'required' end}" id="site_page_#{name}" name="site_page[#{name}]" typo="#{opt[:typo]}"}
      arr << %{ placeholder="#{key.placeholder}"} if key.placeholder.present?
      arr << %{ value="<%= SitePageKeystore.value_for(@site_page, '#{name}') || CommonKey.get(:#{name}).try(:default_value) %>">}
      arr << %{\n        <p class="help-block"><%= CommonKey.find_by(:name).try(:hint) %></p>} if key.hint.present?
    when 'int', 'integer', 'numeric'
      arr << %{<input class="numeric integer #{if opt[:required] then 'required' end}" id="site_page_#{name}" name="site_page[#{name}]" step="1" type="number"}
      arr << %{ value="<%= SitePageKeystore.value_for(@site_page, '#{name}') || CommonKey.get(:#{name}).try(:default_value) %>">}
    when 'text', 'textarea'
      arr << %{<textarea class="text" id="site_page_#{name}" name="site_page[#{name}]">}
      arr << %{<%= SitePageKeystore.value_for(@site_page, '#{name}') || CommonKey.get(:#{name}).try(:default_value) %>}
      arr << %{</textarea>}
    when 'select', 'radio'
      arr << %{<select id="site_page_#{name}" name="site_pag_#{name}" class="input-xlarge">}
      opt[:options].each do |option|
        arr << %{<option value="#{option}">#{option}</option>}
      end
      arr << %{</select>}
    when 'dialog' # 相对于'string'多了一个： url: 'load dialog url'
      # <a class="btn btn-active" data-target="#myModal" data-toggle="modal" href="/pricing?site_page_id=11">点击这里</a>
      arr << %{<input class="#{opt[:typo]} #{if opt[:required] then 'required' end}" id="site_page_#{name}" name="site_page[#{name}]" typo="#{opt[:typo]}"}
      arr << %{ placeholder="#{key.placeholder}"} if key.placeholder.present?
      arr << %{ value="<%= SitePageKeystore.value_for(@site_page, '#{name}') || CommonKey.get(:#{name}).try(:default_value) %>">}
      arr << %{<a data-target="#myModal" data-toggle="modal" href="#{opt[:url]}">选择#{opt[:title]}</a>}
      arr << %{\n        <p class="help-block"><%= CommonKey.find_by(:name).try(:hint) %></p>} if key.hint.present?
    else
      raise "bad input typo: #{opt[:typo]}"
    end
    arr << %{\n    </div>}
    arr << %{\n</div>\n\n}
    arr.join
  end

  def assign_template_keystore
    Templates::Keystore.put(self, 'html', self.html) unless self.html.blank?
    Templates::Keystore.put(self, 'form', self.form) unless self.form.blank?
  end

  def drop_keystore
    Templates::Keystore.where("source_type = ? AND source_id = ?", 'Templates::Page', self.id).destroy_all
  end

end
