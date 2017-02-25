# So the question is what to do with this front-end in JavaScript


# How does this flow work?
# Player and world spawn
# Player looks. He gets back a status code, a description, player, a world.
# Player moves north. Where does the world come from?
# It comes from the game loop. Every command takes in minimally a player and a world and gives back a player and a world
# So in the context of the game loop, we have access to the world
# If ANY function fails to return a world, the world is gone
# We can persist and load or whatever, but if we don't return the world in any function
# In the context of the game loop, the world has ended.
# Are you ever going to call remove object by itself? I.e. no pick up, no assembly?
# If not, it doesn't need to return a player and a world 
