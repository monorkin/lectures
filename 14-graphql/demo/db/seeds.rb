Author.create(
  first_name: 'Stanko',
  last_name: 'Krtalic Rusendic',
  password: '0000000000'
)

Author.create(
  first_name: 'Bruno',
  last_name: 'Sutic',
  password: '0000000001'
)

Author.create(
  first_name: 'Zoran',
  last_name: 'Majstorovic',
  password: '0000000002'
)

Author.create(
  first_name: 'Dario',
  last_name: 'Daic',
  password: '0000000003'
)

Author.create(
  first_name: 'Tomislav',
  last_name: 'Mikulin',
  password: '0000000004'
)

Author.all.each do |author|
  5.times do
    Post.create(
      title: Faker::Book.title,
      body: Faker::Hacker.phrases.join("\n"),
      author: author
    )
  end
end

Post.all.each do |post|
  5.times do
    authors = Author.all - [post.author]
    Comment.create(
      post: post,
      author: authors.sample,
      body: Faker::Friends.quote
    )
  end
end
