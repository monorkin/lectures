# Preparation

```
bundle exec rake db:drop db:create db:migrate db:seed
```

# Queries

Index items

```
query {
  posts() {
    title
    created_at
    author {
      full_name
    }
    comments {
      author {
        full_name
      }
      body
    }
  }
}
```

Show single item

```
query {
  post(id: 1) {
    title
    body
    author {
      full_name
    }
    comments {
      author {
        full_name
      }
      body
    }
  }
}
```

Custom query fields

```
query {
  comments(postId: "1") {
    author {
      full_name
      posts {
        author {
          full_name
        }
      }
    }
    body
  }
}
```

Fragments

```
query {
  post_1: post(id: "1") {
    ...postFields
  },
  post_2: post(id: "2") {
    ...postFields
  }
  post_3: post(id: "3") {
    ...postFields
  }
}

fragment postFields on Post {
  title
  author {
    full_name
  }
  body
  comment_count
}
```


## Mutations

Simple mutation

```
query {
  post(id: "1") {
    title
    author {
      full_name
    }
    comment_count
  }
}

mutation {
  createComment(input: {
    postId: "1",
    authorId: "1",
    body: "This was created with GraphQL 🙌"
  }) {
    post {
      title
      author {
        full_name
      }
      comment_count
    }
  }
}
```

Named variables

```
mutation CommentOnPost($postID: ID!, $authorID: ID!, $body: String!) {
  createComment(input: {
      postId: $postID,
      authorId: $authorID,
      body: $body
  }) {
    post {
      title
      author {
        full_name
      }
      comment_count
    }
  }
}
```

```
{
  "postID": "1",
  "authorID": "2",
  "body": "This was also created with GraphQL 🎉"
}
```
