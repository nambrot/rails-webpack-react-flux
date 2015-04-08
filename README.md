# How to build a server-rendered web application with Rails, Webpack, React and Flux

Read the full blog post on my [website](http://nambrot.com/posts/23-snappy-server-rendered-web-app-with-rails-webpack-react-flux/) and the demo at [http://rails-react.nambrot.com/](http://rails-react.nambrot.com/)

I have build a very simple blog that offers the following features:

- Fully server-rendered HTML, meaning you can actually use the application without JS enabled.
- Minimization of unnecessary data fetching, as in embededing relevant data in the response as JSON and loading additional data if necessary
- Once loaded, everything going forward is client-side rendered and cached, making it incredibly responsive.

I used Rails as my favorite web framework and combined it with React and Flux on the client side via Webpack to render your UI on the server. I want to give credits to others you have tried to make React work with Rails, namely Justin Gordon's [Repo](https://github.com/justin808/react-webpack-rails-tutorial) and [Kevin Old](http://kevinold.com/2015/02/04/configure-webpack-dev-server-and-react-hot-loader-with-ruby-on-rails.html)

Most Rails/React/Flux examples out there are usually lacking in two departments:

1. They are "just" TodoMVC, i.e. don't concern themselves with persistence to a real server by using localstorage.
2. SSR examples with React usually only concern with spitting out HTML without addressing a data management strategy a la Flux. Most will return HTML but require a second rountrip to initialize the Stores. When they do, they usually load the whole collection in, which isn't so great.

I'll try to keep this as concise as possible in a step-by-step guide of how I approached the topic. I'm starting with a very basic Rails Blog that we will gradually "holy-grailify". The following links all points to commits with hopefully helpful commit messages.

### 1. Introducing Webpack and [NPM](https://github.com/nambrot/rails-webpack-react-flux/commit/bada647a36bdcd06250dcc6f48eae8e407ba2703)

Love the asset pipeline to death, but the lack of true modules definitely gets noticable with larger amounts of client side code. We will be using [Webpack](https://github.com/nambrot/rails-webpack-react-flux/commit/2277952e562891e37872a29fff64f96ca3b1fd60) to allow us to write modular code as well as use the great diversity of the NPM ecosystem, with easy compilation for client-side assets as well as [hot-loading](https://github.com/nambrot/rails-webpack-react-flux/commit/2277952e562891e37872a29fff64f96ca3b1fd60)

### 2. Setup basic React and Flux

We are going to set the barebones of the Flux architecture without thinking too much about the server part, for now, we will just fetch everything on demand. That includes setting up the basic App structure

**[React-Router](https://github.com/nambrot/rails-webpack-react-flux/commit/c8052433cb8350a916bbe8fbc4decb81de0c0d03)**

````jsx
# app.js
routes = (
  <Route name="app" path="/">
    <Route name="posts">
      <Route name="post" path=":postId">
        <DefaultRoute handler={PostShow} />
      </Route>
      <DefaultRoute handler={PostsIndex} />
    </Route>
    <DefaultRoute handler={PostsIndex} />
  </Route>
)
````

**[Flux with Flummox](https://github.com/nambrot/rails-webpack-react-flux/commit/715a1a4567775e7e818007ad017faf181194929f)**

- Components

````coffee
# components/posts/index.cjsx
Index = React.createClass
  displayName: "PostsIndex"
  render: ->
    <div>
      {
        @props.posts.map (post) ->
          <article key={post.get('id')}>
            <header>
              <h3>{post.get('title')}</h3>
            </header>
          </article>
        .toArray()
      }
    </div>

FluxIndex = React.createClass
  displayName: "WrappedPostsIndex"
  render: ->
    <FluxComponent connectToStores={
      posts: (store) => posts: store.getAllPosts(), didFetchAll: store.didFetchAll()
      }>
      <Index />
    </FluxComponent>
````

- Actions

````coffee
# actions/post.coffee
class PostActions extends Actions
  fetchAllPosts: ->
    axios.get('/posts', headers: acceptJSON)
    .then (posts) -> posts.data
  fetchPost: (id) ->
    axios.get("/posts/#{id}", headers: acceptJSON)
    .then (response) -> response.data

  createPost: (post) ->
    axios.post('/posts.json', post: post, headers: acceptJSON)
    .then (response) -> response.data
  updatePost: (post) ->
    axios.put("/posts/#{post.id}", post: post, headers:acceptJSON)
    .then (response) -> response.data
````

- Store

````coffee
# stores/post.coffee
class PostsStore extends Store
  constructor: (flux) ->
    super()

    postActionIds = flux.getActionIds('posts')
    @registerAsync postActionIds.fetchAllPosts, @startFetchingPosts, @fetchedAllPosts
    @registerAsync postActionIds.fetchPost, @startFetchingPost, @fetchedPost
    @registerAsync postActionIds.createPost, @startCreatePost, @createdPost
    @registerAsync postActionIds.updatePost, @startUpdatingPost, @updatedPost

    @state = getDefaultState()
    @flux = flux
````

### 3. [Store Deserialization](https://github.com/nambrot/rails-webpack-react-flux/blob/2c1727554373fd1e147df7133442c16079efb3a3/app/assets/javascripts/stores/post.coffee)

The first step to server side rendering is to be able to deserialize data into the store for the client. This also avoids the inital request for data. React is also smart enough to not touch the DOM as the resulting HTML is identical.

````coffee
# app.js
flux = new Flux()
flux.deserialize(window.serializedStoreState) if window.serializedStoreState
Router.run routes, Router.HistoryLocation, (Handler, state) ->
  handler = <FluxComponent flux={flux} render={ => <Handler  />}></FluxComponent>
  React.render(handler, document.getElementById("main"))
````

````coffee
# stores/post.coffee
class PostsStore extends Store
  @deserialize: (serializedState) ->
    if serializedState
      posts: getPostsFromJSON(JSON.parse(serializedState.serializedPosts))
      didFetchAll: serializedState.didFetchAll
    else
      getDefaultState()
````

### 4. Add Server-Side Rendering

We are going to use a [simple express server](https://github.com/nambrot/rails-webpack-react-flux/commit/545326e280ee3e483866e7222315aa784b97feeb) which will take the 1. route and 2. serializedState as parameters and [simply return the HTML](https://github.com/nambrot/rails-webpack-react-flux/commit/02204f74006390a8cbb591eb2281aa22d38dd7c1). The result is complete HTML pages being returned. In fact, you should now be able to navigate the page without the need for Javascript enabled, time-to-render on the client is faster, obvious SEO benefits. The downside is a "round-trip" to the express server

````coffee
# server.coffee
renderToString = (route, serializedStoreState, callback) ->
  flux = new Flux()
  flux.deserialize(serializedStoreState)

  Router.run routes, route, (Handler, state) ->
    html = React.renderToString(<FluxComponent flux={flux} render={ => <Handler  />}></FluxComponent>)
    embeddedStoreState = "<script>"
    embeddedStoreState += "window.serializedStoreState = " + JSON.stringify(serializedStoreState)
    embeddedStoreState += "</script>"
    callback (html + embeddedStoreState)
````

````ruby
# app/helpers/react_helper.rb
module ReactHelper
  def renderSerializedStoreState(state)
    component = HTTParty.post "http://localhost:3001", body: {path: request.path, serializedStoreState: state.to_json}.to_json, headers: {'Content-Type' => "application/json"}
    component.html_safe
  end
end
````

###  Conclusion

As you can see, building the "right" web application is not trivial, there is still a lot of decisions and configuration to be made. While the benefits are great, the cost may not be justifiable for many apps and should be carefully considered with the above trade-offs. I for one am excited for Ember's FastBoot that seems to be the least amount of effort to get the benefits.
