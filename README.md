# Rails with (semi-)isomorphic React and Flux, bundled with Webpack

I know this sounds like quite the handful, but I basically tried to have a Rails app that is an SPA on the client, yet still offer server side rendering. I've been using React for a while now and while it's clearly a great candidate for SSR but since it's advertised as the "V in MVC", it lacks a complete overall strategy when it comes transferring model data to the client. Flux has been a very popular companion to manage your data on the client, so I tried to make them all work together with the twist of including the great react-hot-loader by using Webpack.

First though, I want to give credits to others you have tried to make React work with Rails, namely Justin Gordon and ...

However, most Rails/React/Flux examples out there are usually lacking in two departments:

1. They are "just" TodoMVC, i.e. don't concern themselves with persistence by using localstorage
2. SSR examples usually only concern with spitting out HTML without addressing how to deal with passing initial model data. Most will return HTML but require a second rountrip to initialize the Stores.

I'll try to keep this as concise as possible in a step-by-step guide of how I approached the topic. I'm starting with a very basic Rails Blog.

### 1. Introducing Webpack and NPM

Love the asset pipeline to death, but the lack of true models definitely gets noticable with larger amounts of client side code. We will be using Webpack to allow us to write modular code as well as use the great diversity of the NPM ecosystem.

### 2. Setup basic React and Flux

We are going to set the barebones of the Flux architecture without thinking too much about the server part, for now, we will just fetch everything on demand.

### 3. Store Deserialization

The first step to server side rendering is to be able to deserialize data into the store for the client. This also avoids the inital request for data. React is also smart enough to not touch the DOM as the resulting HTML is identical.

### 4. Add Server-Side Rendering

We are going to use a simple express server which will take the 1. route and 2. serializedState as parameters and simply return the HTML.

### Not Adressing

1. User Authentication
2. Associations
