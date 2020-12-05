# Understanding and Exploiting GraphQL

## What is GraphQL
GraphQL is a way to interact with APIs. It is not a database, nor a database language, it is simply a way to interact with APIs.  For example let's say you were trying to figure out the nutritional information of a box of cereal given that cereal's name.

In a normal REST api, you might do something like this

curl cereal.api -d "title='Lucky Charms'"

and you would receive a JSON response looking like

    {
    "sugar": "50000000g"
    "protein": "0g"
    ...
    }

In GraphQL, your query would look like this
    {
      {
      Cereal(name: "Lucky Charms")
        {
        sugar
        protein
      }
    }  

Note: you can still use curl with GraphQL, you would just need to URL encode this into something that curl would accept.

It's important to note that GraphQL isn't inherently vulnerable, however since we have the ability to pass data to an API, all of the same injection techniques still apply. However GraphQL specifically does give us some information that we can use to help aid our efforts, and we'll learn more about that in the upcoming tasks


## Understanding GraphQL
In order to properly understand how to use the information that GraphQL gives us, we need to know how to write a query. In essence, a GraphQL query works like this.

    {
    
    <type>  {
      field,
      field,
      ...
        }
    }

Let's take a look at the developer side of things to visualize how that works, to do this we'll be using the Cereal code from the previous task.

## Extracting Sensitive Information from GraphQL
One great benefit is that GraphQL effectively documents itself. GraphQL comes bundled with certain objects, types, and fields that allow us to get information on all the other types, fields, and objects.

From the perspective of a Penetration Tester, this means that we aren't going into this fully blind, with a regular API we may just have to guess and pray at endpoints and parameters if there's no publicly available documentation, however GraphQL gives us this information. Let's take a look at just how that works.

Documentation on the built-in types can be found here: https://graphql.org/learn/introspection/

### Querying 

Let's go through this query, recall that in the code, we defined all of our types in the schema method. GraphQL actually documents this, through the __schema object, which contains information about all the types we defined. Next we want to know about types, so we query the field types. From there all we need to do is query the name and description of those types which gives us the output shown below.

It's pretty intuitive, we're requesting information on all of the types that GraphQL has, it just so happens that it shows us types that we created. Just by looking at it, we can tell that Cereal is a pretty suspicious type, let's request more information about it.


