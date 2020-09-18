package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{

	var spritesheet:FlxSprite;
	var text:FlxText;
	var accel:Int;
	var vel:Float;
	var maxVel:Float;
	var friction:Float;
	var isRight:Bool;

	override public function create()
	{
		super.create();

		//load the background in as a sprite
		var bg:FlxSprite = new FlxSprite();
		bg.loadGraphic(AssetPaths.backgroundSky__png, true, FlxG.width, FlxG.height);

		//use system cursor
		FlxG.mouse.useSystemCursor = true;

		//initialize movement values
		maxVel = 1.4;
		vel = 0;
		accel = 0;
		friction = 0.03;
		isRight = true;

		//add movement data text
		text = new FlxText(0,0,FlxG.width/2, "sample text", 24);
    	text.setFormat(null, 24, FlxColor.BLACK, FlxTextAlign.LEFT);

    	//add tutorial text
    	var tutText:FlxText = new FlxText(FlxG.width-500,0,500, "Arrow keys to move!", 24);
    	tutText.setFormat(null, 24, FlxColor.BLACK, FlxTextAlign.RIGHT);

		//create sprite out of spritesheet with animations for walking left and right
		spritesheet = new FlxSprite();
		spritesheet.loadGraphic(AssetPaths.walker__png, true, 64, 128);
		spritesheet.animation.add("walkRight",[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24],20,true);
		spritesheet.animation.add("walkLeft",[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24],20,true, true);

		//slower animations for transitioning to a stop
		spritesheet.animation.add("slowWalkRight",[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24],10,true);
		spritesheet.animation.add("slowWalkLeft",[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24],10,true, true);

		//position walker near bottom of screen
		spritesheet.y = 256;

		//add sprites in order from back to front
		add(bg);
		add(text);
		add(tutText);
		add(spritesheet);

	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if(FlxG.keys.pressed.LEFT) {
			//play walkLeft animation and calculate velocity
			isRight = false;
			spritesheet.animation.play("walkLeft");
			accel = -1;
			vel += accel * 0.1;
		}else if(FlxG.keys.pressed.RIGHT) {
			//play walkRight animation and calculate velocity
			isRight = true;
			spritesheet.animation.play("walkRight");
			accel = 1;
			vel += accel * 0.1;
		} else {
			accel = 0;
			//use friction variable to slow down to stop
			if(vel != 0) {
				if(isRight) {
					//play slower animation when transitioning from maxVelocity
					if(vel == maxVel) {
						var fi:Int = spritesheet.animation.frameIndex;
						spritesheet.animation.play("slowWalkRight", false, false, fi);
					}
					vel-= friction;

					//when velocity hits zero stop the animation
					if(vel < 0) {
						vel = 0;
						spritesheet.animation.pause();
					}else if(vel == 0) {
						spritesheet.animation.pause();
					}
				} else {
					//play slower left animation when transitioning from maxVelocity
					if(vel == -1*maxVel) {
						var fi:Int = spritesheet.animation.frameIndex;
						spritesheet.animation.play("slowWalkLeft", false, false, fi);
					}
					vel += friction;

					//when velocity hits zero pause walking animation
					if(vel > 0) {
						vel = 0;
						spritesheet.animation.pause();
					}else if(vel == 0) {
						spritesheet.animation.pause();
					}
				}
			}


		}

		//don't go over max speed
		if(vel > maxVel) {
			vel = maxVel;
		} else if(vel < (-1 * maxVel)) {
			vel = -1*maxVel;
		}

		//move sprite according to velocity value
		spritesheet.x += vel;

		//movement data
		text.text = "x: " + spritesheet.x + "\nacceleration: " + accel + "\nvelocity: " + vel + "\nframe: " + spritesheet.animation.frameIndex;
		
		//loop over window if gone too far left or right
		if(spritesheet.x > FlxG.width) {
			spritesheet.x = -64;
		} else if(spritesheet.x < -64) {
			spritesheet.x = FlxG.width;
		}
	}
}
