# Walking Sim

An application with sprite movement and animations

### How to play

After running the application with either the windows or neko64 builds, use the arrow keys (left arrow, right arrow) to move the walking knight sprite to the left or the right inside the window.

### Features

- [Left and right movement with corresponding walking animations](#animations-and-acceleration)

- [Looping over the edge of the window back to the other side](#looping-over-edges)

- Variable tracking (top right)

- [Acceleration vectors](#animations-and-acceleration)

- [maximum velocity](#max-velocity-check)

- [Friction vectors when arrow keys are let go](#friction-and-slower-animations)

- [Slower 'stopping animation' when arrow keys are let go from a maximum velocity](#friction-and-slower-animations)

  

  # Pseudocode

  #### Looping over edges

  ```pseudocode
  if(sprite.x > Window.width) {
  	sprite.x = -64
  } else if(sprite.x < -64) {
  	sprite.x = Window.width
  }
  ```

  #### Animations and acceleration

  ```pseudocode
  if(LEFT ARROW pressed) {
  	sprite.play(walkLeft)
  	acceleration = -1
  }else if(RIGHT ARROW pressed) {
  	sprite.play(walkRight)
  	acceleration = 1
  }
  velocity += acceleration * 0.1
  ```

  #### Max velocity check

  ```pseudocode
  if(velocity > maxVelocity) {
  	velocity = maxVel
  } else if(velocity < -maxVelocity) {
  	velocity = -maxVelocity
  }
  ```

  #### Friction and slower animations

  ```pseudocode
  else { //while not hitting the left or right arrows
  	acceleration = 0
  	if(velocity != 0) {
  		if(movingRight) { //moving right
  			//play slower animation when slowing down from maxVelocity
  			if(velocity = maxVelocity) {
  				int index = sprite.frameIndex
  				sprite.play("slowerRightAnimation", index)
  			}
  			velocity -= friction
  			
  			if(velocity < 0 || velocity == 0) {
  				velocity = 0
  				sprite.pauseAnimation()
  			}
  		} else { // Essencially same code as above except for moving left
  			if(velocity == -maxVelocity) {
  				int index = sprite.frameIndex
  				sprite.play("slowerLeftAnimation", index)
  			}
  			velocity += friction
  			
  			if(velocity >0 || velocity == 0) {
  				velocity = 0
  				sprite.pauseAnimation()
  			}
  		}
  	}
  }
  ```

  # Screenshots

![Screenshot Walking](screenshots/Screenshot-Left-Walking.png)
![Screenshot Startup](screenshots/Screenshot-Startup.png)

## Describe animating

In this program I created 4 animations:

- `walkRight`
- `walkLeft`
- `slowWalkRight`
- `slowWalkLeft`

These were used as movements for the left and right as well the slower variants playing when the user lets go of an arrow key and the sprite progressively comes to a stop. Also accounting for playing the slower animations on their corresponding frameIndex.



## Tools used

The following applications were used:

- Sublime Text 3
- Blender (The background) 
- Typora (ReadMe) 
- HaxeFlixel
- OBS Studio (Demo) 
- HandBrake (Demo Compression) 



**Exercise By: Ben Puhalski**

**September 2020**
