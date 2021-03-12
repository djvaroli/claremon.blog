---
layout: single
title:  "Using Toys.rb for Fun and Simple Command Line Interface"
date:   2021-03-10 18:32:13 -0500
categories: tech
author: Daniel Varoli
classes: wide
header:
  overlay_image: /assets/images/ruby.jpg
  overlay_filter: 0.6 # same as adding an opacity of 0.5 to a black background
---

I'm by no means the greatest programmer when it comes to using command line tools. I know the basics like `ls`, `cd`, `touch` and so on, but writing bash scripts, especially anything that involves passing arguments is a pain for me. At times I will go with Python and use the `argparse` module, which has been helpful, but for some reason it doesn't feel rewarding. Well, yesterday I found something that makes me feel like a command line god. Introducing *[Toys](https://github.com/dazuma/toys)*.

Essentially is a configurable command line tool that uses the Ruby programming language. Let's dive right into it. Here's an example from the github repo.

{% highlight ruby %}
tool "greet" do
    desc "My First Tool!"
    flag :whom, default: "world"
    def run
        puts "Hello #{whom}"
    end
end
{% endhighlight %}

I am not very familiar with Ruby (the language Toys uses), but if you place close attention I think it's relatively straightfowrad to decipher what's going on. Here's how you would use this.

First you would need install `Toys` and you can find the steps on their GitHub page. Once the installation is complete all you have to do is create the file `.toys.rb` (notice the leading `.`). Add the above function to the file and you are good to go. To run the function simply open up a terminal in the same directory as the file you just created and run 
```
toys greet
```

and you should see your terminal print 
```
Hello world
```

It get's better. Now try running

```
toys greet --whom=ruby
```

You should see your terminal print out 

```
Hello ruby
``` 

Remember those times when you had to muddle around with command line arguments, especially with keyword arguments? I know I have and **Toys** makes it much more fun. Perhaps that's where the name comes from.

Here's a more involved example that I am currently using to run this blog locally inside of a Docker container. 

{% highlight ruby %}
tool "run-local" do
    flag :no_cache
    include :exec, exit_on_nonzero_status: true
    def run
        cache_args = no_cache ? ["--pull", "--no-cache"] : []
        exec ["docker", "build"] + cache_args +
            ["-t", LOCAL_IMAGE, "-f", "_build/Dockerfile", "."]
        puts "Running on http://localhost:8080"
        exec ["docker", "run", "--rm", "-it", "-p", "8080:8080", LOCAL_IMAGE]
    end
end
{% endhighlight %}

This one is a bit more involved and also requires Docker to run the image, but a I think you get the general gist of it. An important thing to note that took me some time to figur eout, is that you need to add the line `include :exec` in order to be able to run external commands such as `docker build` in this case. 

Hopefully this very simple tutorial was helpful, and I enourage to checkout *Toys* for yourself. I am sure there may be other tools out there, but I thought this was one was pretty cool and a lot of fun to use!