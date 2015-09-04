# HTML Forms and Params

## Objectives

1. Build a basic HTML form
2. Connect an HTML form to a sinatra application via the `method` and `action` attributes
3. Build a `POST` route in Sinatra's application controller to accept data from a form via params.
4. Understand that params are a Ruby hash containing form data.

![Green Eggs and Ham](https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSwGoDVUDPLd8f_397Fp9BrLKlu-6msu0sSiT0LeEZQ8Ga2228z)

## Forms, Forms, Forms!

Think about how many forms you fill out online every day. Credit card payments, logins, registration forms, and even searches Google - all forms.

That's because form are the most common way for users to pass data to a web application. In this walkthrough, we'll create a new HTML form and connect it to a Sinatra application so that we can we can use and manipulate the data provided by the user.

If you want to code along, fork and clone the repo, which contains a sample Sinatra application. Notice that it has a `get` route which renders the `food.erb` HTML page. We'll be working with `app.rb` (Application Controller), and `food.erb` in the `views` directory. Make sure to run `shotgun` when to test your application.

### Build an HTML form
We're not going to dive too deep into form-making here (look in our HTML lessons for more), but the basics are these:

+ HTML forms need a `<form>` opening tag and a `</form>` closing tag.
+ Each form field (text, date, password, etc) has a tag (usually `<input>`) with an attribute `type` denoting the type of form field. For example, a text box field looks like this:

```html
<input type="text">
```
+ A form needs a submit button:

```html
<input type="submit">
```
You'll need some other tags to give context as well. For now we'll use <p> tags. Put it together, and your HTML form will look like this:

```html
<form>
  <p>Your Name:<input type="text"></p>
  <p>Your Favorite Food:<input type="text"></p>
  <input type="submit">
</form>
```

Now if you run `shotgun` and go to the corresponding view (`localhost:9393/food-form`, you'll see your very basic form. However, if you try submitting the form, nothing will happen. That's because the form is not yet connected to the controller - it is unable to send data that is input into the form's fields.

### Connecting the form to your Sinatra App

In order to connect the form to our application, we need to give it expicit directions on **where** and **how** to send the data from the user. Both of these pieces of data are attributes that we give our `<form>` tag. 

```
<form method="POST" action="/food">
```
+ The `method` tag tells the form what kind of request should be fired to the server when the submit button is clicked. In general, forms use POST request, because it is 'posting' data to the server.
+ The `action` tag tells the form what specific route the post request should be sent to. In this case, we're posting to a route called `/food-receiver`

Each form field (`<input>`) also a `name` attribute. This is because we will be passing our data in the form of a hash, where the key will be the name of the data, and the value will be the data itself. In this case, we want our hash (which we call `params`) to look something like this:

```ruby
params = { :name => "Sam",
			 :favorite_food => "Green Eggs and Ham"
}
```

So our input names will need to be "name" and "favorite food":

```html
<form method="POST" action="/foodreceiver">
  <p>Your Name:<input type="text" name="name"></p>
  <p>Your Favorite Food:<input type="text" name="favorite_food"></p>
  <input type="submit">
</form>
```

Let's see what happens when we submit this form...

![Sinatra Error](https://curriculum-content.s3.amazonaws.com/web-development/Sinatra/localhost_9393_foodreceiver.png)

We get our classic Sinatra error! This is amazing, because Sinatra errors like this one tell us exactly what we need to do next to make the form work.

## Post Routes and Params

The error message Sinatra gives us is telling us that we don't have a route to receive the data from the HTML form that we created in `food_form.erb`. If you recall, we gave our form a method attribute of `POST` and an `action` attribute of `"/foodreceiver"`. Again, this is the **how** and **where** the data goes from this form.

Every form needs a corresponding route in the controller file (`app.rb`). Instead of a `get` route (which we used to route users to view an html page), we'll set up a post route:

```ruby
post '/foodreceiver' do

end
```
Notice that both of the attributes from the form are covered in this route: The method (post) and the action (/foodreceiver).

### Paramaramadingdong

The data from the form come nicely packaged up in the form of a hash called `params`. Let's set the return value of the post route to be params.to_s, and see what our form does now...

```
post '/foodreceiver' do
    params.to_s
  end
```

When you submit your form, you should now see the contents of `params` displayed as a hash in your browser like this:

```
{"name"=>"Sam", "favorite_food"=>"Green Eggs and Ham"}
```
Great! This means we've been able to successfully get the data from the form in to the controller, and can now manipulate it any way we want. I'm going to use the key-value pairs in `params` to return the following phrase, using good-old string interpolation:

```
"My name is #{params[:name}}, and I love #{params[:favorite_foods]}"
```

Here's the full post request in `app.rb`:

```
post '/foodreceiver' do
    "My name is #{params[:name}}, and I love #{params[:favorite_foods]}"
end
```
Submit the form and see what happens! If you've gotten this far you can successfully connect an HTML form to your Sinatra app, and can use the params hash to use and manipulate data from the user. 

