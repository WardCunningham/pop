require 'rubygems'
require 'nokogiri'
require 'json'

def random
  (1..16).collect {(rand*16).floor.to_s(16)}.join ''
end

def slug title
  title.gsub(/\s/, '-').gsub(/[^A-Za-z0-9-]/, '').downcase()
end

def clean text
  text.gsub(/’/,"'").gsub(/&nbsp;/,' ').gsub(/<img.*?>/,'>>>')
end

def url text
  text.gsub(/(http:\/\/)?([a-zA-Z0-9._-]+?\.(net|com|org|edu)(\/[^ )]+)?)/,'[http:\/\/\2 \2]')
end

def create title
  {'type' => 'create', 'id' => random, 'item' => {'title' => title}}
end 

def paragraph text
  {'type' => 'paragraph', 'text' => text, 'id' => random()}
end

def page title, story
  page = {'title' => title, 'story' => story, 'journal' => [create(title)]}
  File.open("../pages/#{slug(title)}", 'w') do |file| 
    file.write JSON.pretty_generate(page)
  end
end

@summary = []

def convert title, doc
  puts title
  doc.css('b').each do |elem|
    elem.content = "[[#{elem.content}]]" unless elem.content == 'Therefore'
  end
  story = doc.css('p').collect do |elem|
    paragraph clean(elem.inner_html)
  end
  page title, story
  @summary << paragraph("[[#{title}]]")
end

def summarize
  page "Patterns of Practice", @summary
end

Dir.glob('originals/*.xhtml').each do |filename|
  File.open(filename) do |file|
    title = filename.gsub(/originals\//,'').gsub(/\.xhtml/,'').gsub(/([a-z])([A-Z])/,'\1 \2')
    doc = Nokogiri::XML(file)
    convert title, doc
  end
end

summarize