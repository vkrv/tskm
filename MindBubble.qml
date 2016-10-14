Rectangle {
	width: 200;
	height: 80;
	radius: 12;
	border.width: 1;
	border.color: "#888";
	property Mixin hover: HoverMixin { cursor: "pointer"; }
	color: hover.value ? "#B3E5FC" : "#E1F5FE";
	property Mixin drag: DragMixin {}
	z: drag.pressed ? 1 : 0;
	property Object root;

	ExternalPath {
		id: curve;
		x2: parent.x;
		y2: parent.y + parent.height / 2;
		width: 2;
		color: "#263238";
		fill: "transparent";
		function targetRequired() { return true }
	}

	/// @internal
	function _update (name, value) {
		var self = this
		switch(name) {
			case 'root':
				log("Rectangle",name,value)
				self.curve.x1 = value.x + value.width / 2
				self.curve.y1 = value.y + value.height / 2

				value.onChanged('x', function (v) {
					self.curve.x1 = v + self.root.width / 2
				})
				value.onChanged('y', function (v) {
					self.curve.y1 = v + self.root.height / 2
				}) 
				break;
		}
		_globals.core.Rectangle.prototype._update.apply(this, arguments);
	}
}