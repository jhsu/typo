Given /^there is an article called "([^"]+)" with text "([^"]+)"$/ do |title, body|
  article = Article.create(:title => title, :body => body)
end

Given /^the article "([^"]+)" has a comment "([^"]+)"$/ do |title, comment|
  article = Article.where(:title => title).first
  article.comments.create(:body => comment, :author => "person")
end

When /^I edit the article "([^"]+)"$/ do |title|
  article = Article.where(:title => title).first
  visit "/admin/content/edit/#{article.id}"
end

When /^I fill in "([^"]+)" with article "([^"]+)"$/ do |field, title|
  article = Article.where(:title => title).first
  fill_in(field, :with => article.id)
end

Then /^the article "([^"]+)" should no longer exist$/ do |title|
  article = Article.where(title: title).first
  assert_nil article
end

Then /^the article "([^"]+)" should contain "([^"]+)"$/ do |title, body|
  article = Article.where(title: title).first
  assert article.body =~ /#{body}$/, article.body
end

Then /^the article "([^"]+)" should have the comment "([^"]+)"$/ do |title, comment|
  article = Article.where(title: title).first
  assert article.comments.map(&:body).include?(comment), article.comments.map(&:body).inspect
end
