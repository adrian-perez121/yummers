# The Idea Behind it

Yummers is meant to be a food-themed social media app where users are supposed
to post their food along with a description of what they made and the recipe behind
their creation. Other users can like or dislike posts and comment on them for any feedback. Here is a short demo.



https://github.com/user-attachments/assets/fd1a1b0f-bcc0-4d34-b4bf-c4334b1d9835



## Where I am

As of the time writing this. I have been able to successfully implement posts, likes, dislikes, comments, and user profiles.
I did most of the CSS myself. Yes there are many incredibly helpful frameworks out there but before I start using them
I want to make sure I know the core of what CSS truly is. I believe this project has greatly contributed to that goal.
I am proud to say that I was able to integrate Turbo Drive in several parts of the app like when a user is making a comment
or searching for users. If I'm going to be honest, I really didn't know how to use Turbo Drive at first, although
there is still so much more to learn I am grateful it was implemented somewhere in the app. Stimulus is also something I
got a better grip of while creating this project. I was able to reuse my controllers in various places of the app. My
favorite controller is one that shows the word count of an input field when the character count is too low or
reaches the limit. School is going to be starting soon and there is still so much more I want to add.

## Roadmap

+ ### Deployement
  There is one major thing missing from the app os of now and that's deployment. I would
  love to have the website up and running. At least for a while. The main roadblock holding me
  back is cost. Render databases are free for a while before they delete themselves and I would also need
  a storage provider for images. However, self-hosting the server seems like a more better option...who knows.
+ ### Messaging
  I would like to get messages working at some point. Before I started I did a bunch of readings on websockets
  and I would hate for that knowledge to go to waste.
+ ### Mailer
  This is one of those features that I haven't implemented yet because I have been busy with other features. Also, I have
  found that trying to deploy a mailer with no budget is a major pain.
+ ### Handling Large Amounts of Posts
  Something I recognize as a potential problem for the future is handling multiple posts. If this website were to get
  thousands of people and thousands of pictures. How would loading be handled? This is something I will have to research on
  my own when the time comes.
+ ### Misc
  This is more of a checklist of small things I need to do. For example, being able to delete comments from a post
  and also like a comment(the back-end stuff is there).


## Some Thanks

I appreciate the creators of the Devise and Google OmniAuth gems. These Gems proved to be immensely valuable. They deserve
every Github star they have and more.
