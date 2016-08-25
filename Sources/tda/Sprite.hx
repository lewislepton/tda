package tda;

import kha.Color;
import kha.graphics2.Graphics;
import kha.Image;
import kha.math.FastMatrix3;
import kha.math.Matrix3;
import kha.math.Vector2;

@:expose
class Sprite {
	private var image: Image;
	private var animation: Animation;
	public var x: Float;
	public var y: Float;
	public var z: Int;
	var w: Float;
	var h: Float;
	public var removed: Bool = false;
	public var angle: Float = 0.0;
	public var originX: Float = 0.0;
	public var originY: Float = 0.0;
	public var scaleX: Float = 1;
	public var scaleY: Float = 1;
	public var visible: Bool = true;
	
	public function new(image: Image, width: Int = 0, height: Int = 0, ?z: Int = 1) {
		this.image = image;
		x = 0;
		y = 0;
		h = height;
		w = width;
		if (this.width  == 0 && image != null) this.width  = image.width;
		if (this.height == 0 && image != null) this.height = image.height;
		this.z = z;
		animation = Animation.create(0);
	}
	
	public function setAnimation(animation: Animation): Void {
		this.animation.take(animation);
	}
	
	public function update(): Void {
		animation.next();
	}
	
	public function render(g: Graphics): Void {
		if (image != null && visible) {
			g.color = Color.White;
			if (angle != 0) g.pushTransformation(g.transformation.multmat(FastMatrix3.translation(x + originX, y + originY)).multmat(FastMatrix3.rotation(angle)).multmat(FastMatrix3.translation(-x - originX, -y - originY)));
			g.drawScaledSubImage(image, Std.int(animation.get() * w) % image.width, Math.floor(animation.get() * w / image.width) * h, w, h, Math.round(x * scaleX), Math.round(y * scaleY), width, height);
			if (angle != 0) g.popTransformation();
		}
	}
	
	public function hit(sprite: Sprite): Void {
		
	}
	
	public function setImage(image: Image): Void {
		this.image = image;
	}
	
	public function outOfView(): Void {
		
	}
	
	function get_width(): Float {
		return w * scaleX;
	}
	
	function set_width(value: Float): Float {
		return w = value;
	}
	
	public var width(get, set): Float;
	
	function get_height(): Float {
		return h * scaleY;
	}
	
	function set_height(value: Float): Float {
		return h = value;
	}
	
	public var height(get, set): Float;
	
	public function setPosition(pos : Vector2) {
		x = pos.x;
		y = pos.y;
	}
}
