class Post < ActiveRecord::Base

  require 'open-uri'
  require 'nokogiri'

  GOOD_POST_LEVEL = 10_000

  scope :reversed, -> { order(id: :desc) }

  def self.delete_old
    delete_all("created_at < '#{1.day.ago}'")
  end

  def self.get_new
    page = Nokogiri::HTML(open('http://9gag.com/'))
    existed_posts = Post.all.to_a.map(&:post_link)
    new_posts = []
    page.css('article.badge-entry-container').each do |post|
      rating = post.css('span.badge-item-love-count').first.content.gsub(/,/, '').to_i
      post_link = post.css('a').first['href']
      preview_link = post.css('img.badge-item-img').first['src']
      if rating >= GOOD_POST_LEVEL && !existed_posts.include?(post_link)
        new_posts << { post_link: post_link, rating: rating, preview_link: preview_link }
      end
    end
    create(new_posts) if new_posts.any?
  end
end
