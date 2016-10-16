Item {
	anchors.fill: context;

	SvgContainer {
		id: drawer;
		anchors.fill: parent;
	}

	ListModel {
		id: bubblesModel;

		addBubble(x, y, r): {
			this.append({
				x: x,
				y: y,
				root: r
				})
		}

		ListElement { x: 300; y: 100; root: bubble1;}
		ListElement { x: 300; y: 300; root: bubble1;}
		ListElement { x: 300; y: 500; root: bubble1;}
	}

	// Repeater {
	// 	id: bubblegen;
	// 	anchors.fill: parent;
	// 	model: bubblesModel;
	// 	delegate: MindBubble {
	// 		x: model.x;
	// 		y: model.y;
	// 		root: model.root;
	// 		curve.target: drawer;
	// 		onCreateBubble: {
	// 			log("bubble delegate on creation")
	// 			this.parent.model.addBubble(this.x + 300, this.y, this)
	// 		}
	// 	}
	// }

	MindBubble {
		id: bubble1;
		anchors.verticalCenter: parent.verticalCenter;
		x: 30;
//		drag.direction: DragMixin.Vertical;
		onCreateBubble: {
			log("bubble clicked")
			buubleView.model.addBubble(this)
		}
	}

	ListView {
		id: buubleView;
		anchors.top: parent.top;
		anchors.bottom: parent.bottom;
		height: contentHeight;
		width: 300;
		x: 400;
		spacing: 10;
		model: 	ListModel {
			addBubble(r): {
				this.append({root: r})
			}

			ListElement { root: bubble1;}
			ListElement { root: bubble1;}
			ListElement { root: bubble1;}
		}

		delegate: MindBubble {
			root: model.root;
			curve.target: drawer;
			onCreateBubble: {
				log("bubble delegate on creation")
				this.parent.model.addBubble(this)
			}
		}
	}


	// MindBubble {
	// 	id: bubble2;
	// 	anchors.verticalCenter: parent.verticalCenter;
	// 	x: 330;
	// 	root: bubble1;
	// 	curve.target: drawer;
	// 	drag.direction: DragMixin.Horizontal;
	// }

	// MindBubble {
	// 	id: bubble3;
	// 	y: 600;
	// 	x: 330;
	// 	root: bubble1;
	// 	curve.target: drawer;
	// }

	// MindBubble {
	// 	id: bubble4;
	// 	y: 100;
	// 	x: 330;
	// 	root: bubble1;
	// 	curve.target: drawer;
	// }
}
