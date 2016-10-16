Rectangle {
	width: 200;
	height: hover.value ? 84 : 80;
	radius: 12;
	border.width: 1;
	border.color: "#888";
	property Mixin hover: HoverMixin { cursor: "pointer"; }
	color: hover.value ? "#B3E5FC" : "#E1F5FE";
//	property Mixin drag: DragMixin {}
//	z: drag.pressed ? 1 : 0;
	property Object root;
	signal createBubble;

	Behavior on height, y { Animation {duration: 200; easing: "linear";} }

	Rectangle {
		color: hover.value ?  "#388E3C" : "#66BB6A";
		border.width: 1;
		border.color: "#1B5E20";
		width: 36;
		height: 36;
		radius: 19;
		anchors.verticalCenter: parent.verticalCenter;
		x: 180;
		visible: parent.hover.value;
		property Mixin text: TextMixin { text: "+"; font.pixelSize: 28; font.bold: true; color: "#EEE"; }
		property Mixin hover: HoverMixin { cursor: "pointer"; }
		onClicked: { this.parent.createBubble(); }
		Behavior on y { Animation {duration: 200; easing: "linear";} }
	}

	ExternalPath {
		id: curve;
		x2: parent.viewX + parent.parent.x + parent.x;
		y2: parent.viewY + parent.height / 2 + parent.y;
		width: 2;
		color: "#263238";
		fill: "transparent";
		function targetRequired() { return true }
		Behavior on y2, x2 { Animation {duration: 200;}}
	}

	/// @internal
	function _update (name, value) {
		var self = this
		switch(name) {
			case 'root':
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