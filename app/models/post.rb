class Post < ActiveRecord::Base

  require 'open-uri'
  require 'nokogiri'

  scope :reversed, -> { order(id: :desc) }

  def self.delete_old
    delete_all("created_at < '#{1.day.ago}'")
  end

  def self.get_new
    page = Nokogiri::HTML(open('http://9gag.com/'))
    existed_posts = Post.all.to_a.map(&:link)
    new_posts = []
    page.css('article.badge-entry-container').each do |post|
      rating = post.css('span.badge-item-love-count').first.content.gsub(/,/, '').to_i
      link = post.css('a').first
      if rating > 10_000 && !existed_posts.include?(link['href'])
        new_posts << { link: link['href'], rating: rating }
      end
    end
    create(new_posts) if new_posts.length > 0
  end
end
