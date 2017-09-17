# Gmylm

This is an Elixir port of the text adventure game, ["Give Me Your Lunch Money"](http://www.adrift.co/game/1197). 

It was meticulously and lovingly created by my friend Daniel C. Berlin using the Adrift Interactive Fiction Toolkit, and features an original soundtrack of my composition.

How to Play
----------

```
iex -S mix
```

And then run Gmylm.start_game, e.g. 

```
Interactive Elixir (1.4.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> Gmylm.start_game
> north
Hankin is my school.  The school is a pretty cool building.  Made of brick and really old with designs in the stone parts.  I like the carvings of gears, and the one of the people dancing.  There are lots of kids out in front of the school right now because the bell just rang.

east: Hankin School Playground, west: The Park, 

```

Other commands include `north`, `east`, `south`, `west`, `up`, `down`, `look`

TODO
------

* events (e.g. altercation with bullies)

* pick things up
* drop them
* assemble things into traps
* do a little dance

