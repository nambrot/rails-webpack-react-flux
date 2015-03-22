# Rails with (semi-)isomorphic React and Flux, bundled with Webpack

I know this sounds like quite the handful, but I basically tried to have a Rails app that is an SPA on the client, yet still offer server side rendering. I've been using React for a while now and while it's clearly a great candidate for SSR but since it's advertised as the "V in MVC", it lacks a complete overall strategy when it comes transferring model data to the client. Flux has been a very popular companion to manage your data on the client, so I tried to make them all work together with the twist of including the great react-hot-loader by using Webpack.

First though, I want to give credits to others you have tried to make React work with Rails, namely Justin Gordon and ...

However, most Rails/React/Flux examples out there are usually lacking in two departments:

1. They are "just" TodoMVC, i.e. don't concern themselves with persistence by using localstorage
2. SSR examples usually only concern with spitting out HTML without addressing how to deal with passing initial model data. Most will return HTML but require a second rountrip to initialize the Stores.

I'll try to keep this as concise as possible in a step-by-step guide of how I approached the topic. I'm starting with a very basic Rails Blog.

### 1. Introducing Webpack and NPM

Love the asset pipeline to death, but the lack of true models definitely gets noticable with larger amounts of client side code. We will be using Webpack to allow us to write modular code as well as use the great diversity of the NPM ecosystem.




### Not Adressing

1. User Authentication
2. Associations
