class Article::Merger
  attr_reader :first
  attr_accessor :second

  def initialize(first, second)
    raise(SameArticle, "Cannot merge the same article") if first == second
    @first = first
    @second = second
  end

  def merge!
    merge_attributes
    first.class.transaction do
      first.save && second.destroy
    end
    finished!
  end

  def result
    first if finished?
  end

  class SameArticle < Exception; end

  private

  def finished!
    @finished = true 
  end

  def finished?
    @finished || false
  end

  def merge_attributes
    merge_body
    merge_comments
  end

  def merge_body
    first.body += " " + second.body
  end

  def merge_comments
    second.comments.update_all(:article_id => first.id)
  end
end
