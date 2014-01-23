/*
   Behaviour v1.1 by Ben Nolan, June 2005. Based largely on the work
   of Simon Willison (see comments by Simon below).

   Description:

     Uses css selectors to apply javascript behaviours to enable
     unobtrusive javascript in html documents.

   Usage:

     var myRules = {
       'div' : function(element){
         Behaviour.addEventObserver(element, 'click', function(){alert(this.innerHTML);}, false);
       },

       '#somediv':  function(element){
         Behaviour.addEventObserver(element, 'mouseover', function(){this.innerHTML = "BLAH!";}, false);
       }
     };

     Behaviour.register(myRules);

  // Call Behaviour.apply() to re-apply the rules (if you
  // update the dom, etc).

   License:

    This file is entirely BSD licensed.

   More information:

    http://ripcord.co.nz/behaviour/

*/

// Modified by Jakob Kruse <kruse@kruse-net.dk>
//
// 1.1-p1:
// * Changed to use event observers instead of replacing events (from Sergio Pereira)
// * Bug fixed in checkFunction (from Ian Sollars)
// * Bug fixed with dash in css class (from james.estes)
// * Support for grouped selectors added (from Ian Sollars)
// * Method applySheet added (from Jakob Kruse)
//
// 1.1-p2:
// * clearedElements checking moved to addEventObserver method to support adding
//   observers to elements other than those hit by the selector (from Jakob Kruse)
//
// 1.1-p3:
// * Changed to use Prototype 1.5.1 functionality. Replaces code by Simon Willison.
//
// 1.1-p4:
// * Fixed a bug in removeEventObserver leading to decreasing performance when
//   calling apply multiple times. (Jakob Kruse)
//
// 1.2:
// * Added a parameter to applySheet, to allow applying a sheet to a subtree of
//   the entire document. (Jakob Kruse)

if (typeof Prototype == 'undefined' || Prototype.Version < '1.5.1') {
  throw "Behaviour needs Prototype 1.5.1";
}

var Behaviour = {
  list : [],

  eventObservers : [],

  clearedElements : [],

  addEventObserver : function(element, name, observer, useCapture){
    if (!this.clearedElements.include(element)) { // should do a hashed lookup here
      this.clearedElements.push(element);
      Behaviour.removeAllObservers(element);
    }

    element = $(element);
    useCapture = useCapture || false;
    Behaviour.eventObservers.push([element, name, observer, useCapture]);
	alert("element: + element");
    Event.observe(element, name, observer, useCapture);
  },

  removeEventObserver : function(element, name, observer, useCapture){
    element = $(element);
    useCapture = useCapture || false;
    Behaviour.eventObservers = Behaviour.eventObservers.reject(function(list) {
      return (list[0] == element && list[1] == name && list[2] == observer && list[3] == useCapture);
    });
    Event.stopObserving(element, name, observer, useCapture);
  },

  removeAllObservers : function(element){
    var el = $(element);
    var observersForElement = Behaviour.eventObservers.findAll(
                               function(observerInfo){
                                 return (observerInfo[0]==el);
                               });

    observersForElement.each(function(observerInfo){
      Behaviour.removeEventObserver(observerInfo[0], observerInfo[1], observerInfo[2], observerInfo[3]);
    });
  },

  register : function(sheet){
    Behaviour.list.push(sheet);
  },

  start : function(){
	Behaviour.addLoadEvent(function(){
    Behaviour.apply();
    });
  },

  addLoadEvent : function(func){
    var oldonload = window.onload;

    if (typeof window.onload != 'function') {
      window.onload = func;
	  alert("hi2");
    } else {
      window.onload = function() {
        oldonload();
        func();
      };
    }
  },

  apply : function(){

	alert("applyBeh");
	this.clearedElements = [];
    Behaviour.list.each(function(sheet) {
      for (selector in sheet) {
        list = $$(selector);

        if (!list){
          continue;
        }

        list.each(function(element) {
          sheet[selector](element);
        });
      }
    });
  },

  // applySheet can be used to (re)apply a single sheet.
  // Note that any element touched by the sheet will lose any
  // event observers added by other sheets!
  // If rootElement is specified, only adds behaviour to a subtree.
  applySheet : function(sheet, rootElement) {
    this.clearedElements = [];

    for (selector in sheet) {
      list = rootElement ? $(rootElement).getElementsBySelector(selector) : $$(selector);

      if (!list) {
        continue;
      }

      list.each(function(element) {
        sheet[selector](element);
      });
    }
  }
};

Behaviour.start();
