class Author
  attr_reader :name

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def add_article (magazine, title)
    Article.new(self, magazine, title)
  end

  def articles
    Article.all.select { |article| article.author == self }
  end

  def magazines
    articles.map(&:magazine).uniq
  end

  def topic_areas
    articles.collect { |art| art.magazine.category }.uniq
  end
end

class Magazine
  attr_reader :name, :category
  @@all = []

  def initialize(name, category)
    @name = name
    @category = category
    @@all << self
  end

  def self.all
    @@all
  end

  def add_article(title, author)
    Article.new(author, self, title)
  end

  def articles
    Article.all.select { |article| article.magazine == self }
  end

  def article_titles
    articles.map { |article| article.title }
  end

  def contributors
    articles.map { |art| art.author }.uniq
  end

  def contributing_authors
    authors = articles.map do |article|
      if article.author.articles.length > 2
        article.author
      end
    end
    authors.uniq
  end

  def self.find_by_name(name)
    magazine = self.all.find { |magazine| magazine.name == name }
    magazine.name
  end

end

class Article
  attr_accessor :author, :magazine, :title

  @@all = []

  def initialize (author, magazine, title)
    @author = author
    @magazine = magazine
    @title = title
    @@all << self
  end

  def self.all
    @@all
  end
end