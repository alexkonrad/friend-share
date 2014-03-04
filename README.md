# Share

A Rails and Javascript application implementing a wall where users can share secrets with each other, but in implementation it looks more like a wall a la Facebook. Has nested Rails forms for posting, friending, unfriending, tagging, etc. but also offers AJAX and JQuery to dynamically post on someone's wall, friend/unfriend someone, add tags, etc. Bootstraps the Javascript on page load.

## Form
 * plain-old non-AJAX `/users/123/secrets/new` form
 * a nested route and controller
 * nested `new` form posts to the top-level `/secrets` route
 * when you post a secret, you are sharing it to someone's 'wall'

## Friendships
 * `Friendship` model joins `User` to `User`. 
 * I used `out_friend_id`/`in_friend_id` columns and `out_friend`/`in_friend` associations.
 * a `/users` index page lists all the users and shows buttons to allow us to friend people.
 * simple `Friendships` controller (the only action needed is `create`, I think)
 * Nested `friendships` resource: `/users/:user_id/friendship`. 
 * there is a form posting to `/users/:user_id/friendship` in a partial `friendships/_form.html.erb` with the appropriate `user` local variable passed in.
 * We have a `Friendship::can_friend?(out_friend_id, in_friend_id)` helper using ActiveRecord's `exists?` method.

## Remote friendships
 * Instead of rendering the form partial, we have a `button`
element with class `friend`
 * a click handler is attached to the buttons within the list of users. (using jQuery's event delegation).
 * uses a `data-*` attribute on the button
 * uses `$.ajax` to make a POST request and construct a `Friendship`
 * success callback `remove`s the button when done.
 * with JQuery we change the text to "Friending...", while in the midst of of friending

## Remove friendships
 * There is a second button to unfriend a user corresponding to a `destroy`
action on `FriendshipsController`. 
 * Similarly we have a helper method `Friendship::can_unfriend`: we show the button if this is true. 
 * Again, the button comes with a click handler that will remove the friendship.

### Toggling
 * uses JQuery to toggle the CSS class of the elements
 * the CSS classes use `display: block` and `display: none` to show and hide the elements, respectively.

## Remote secrets form
 * users can submit via AJAX
 * we use `serializeJSON`
 * on successful submission, we add the new secret to the `ul` listing all
the secrets
 * we also clear the form

## Dynamic form without nesting
 * we allow users to tag secrets when they create them
 * `Tag` and `SecretTagging` models with appropriate associations, validations/DB constraints, indices, appropriate
associations etc.
 * `Secret` `has_many :tags, :through => :secret_taggings`
 * there is a single `select` element for tags plus an "add another tag" link. Clicking this link invokes a JS function to add another `select` tag element dynamically to the form.

### Bootstrapped `Tag`s
 * We bootstrap our tags in the view because when we generate the `select` element, the JavaScript needs to know what `Tag`s should be presented in the dropdown.
 * `script type="application/json"`
 * an inline-script `type="application/javascript"` finds the `script` element with
bootstrapped data, extracts its contents, and parses 
JSON.

### Underscore template
 * "Add another tag" link inserts a new select box into the form.
 * Underscore template generates a `select` tag that iterates through `tags` creating `option`
tags for each.
 * A helper function, `addSecretTagSelect` finds the template, extracts its contents, compiles the template function
(with `_.template`) and renders the function. It passes in the bootstrapped tags to the template function so that all the `Tag`s are
presented.
 * `addSecretTagSelect` appends the rendered template result into this div.
 * Finally we have a click handler listening for the link which calls `addSecretTagSelect`.
