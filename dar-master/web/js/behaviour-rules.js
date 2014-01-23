var mynewrules = {
	'#formFieldType': function(el) {
		Behaviour.addEventObserver(el, 'change', function() {
			// this.parentNode.removeChild(this);
			var formFieldValue = el[el.selectedIndex].value
			alert("formFieldValue: " + formFieldValue);
			return false; // prevent default action
		});
	},
	'#example li': function(el) {
		Behaviour.addEventObserver(el, 'click', function() {
			this.parentNode.removeChild(this);
			return false; // prevent default action
		});
	}
}

var myrules = {
	'#example li' : function(el){
		el.onclick = function(){
			this.parentNode.removeChild(this);

		}
	}
};
//Behaviour.register(myrules);
// Event.observe(element, eventName, handler[, useCapture = false])
