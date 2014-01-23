/**
 * When a value is clicked in a record, call the widget to be displayed.
 * @param {Object} pageItemId
 * @param {Object} formFieldId
 * @param {Object} formId
 * @param {Object} encounterId
 * @param {Object} currentFieldNameIdentifier - If this is one of the special patient bridge forms, this value helps the system locate the correct field to render the widget.
 * @param {Object} bridgeId - id of the record from the patient bridge table.
 */
function callWidget(pageItemId, formFieldId, formId, encounterId, currentFieldNameIdentifier, bridgeId) {
    if (currentFieldNameIdentifier) {
		var item = document.getElementById("field" + currentFieldNameIdentifier + formFieldId);
		} else {
		var item = document.getElementById("field" + currentFieldNameIdentifier + formFieldId);
	}
    if (! item) {
    	if (currentFieldNameIdentifier) {
			var item = document.getElementById("inputWidget" + currentFieldNameIdentifier + formFieldId);
		} else {
			var item = document.getElementById("inputWidget" + currentFieldNameIdentifier + formFieldId);
		}
    }
    if (! item) {
        if (currentFieldNameIdentifier) {
			var item = document.getElementById("value" + currentFieldNameIdentifier + formFieldId);
        	var widget = document.getElementById("widget" + currentFieldNameIdentifier + formFieldId);
		} else {
			var item = document.getElementById("value" + formFieldId);
	        var widget = document.getElementById("widget" + formFieldId);
		}
        // if the widget is being displayed (item value is hidden)
        if (item.style.display == "none") {
        	// fetch the original value, so that you don't pass the html for the widget.
        	//itemValue = widget.innerHTML;
			itemValue = item.innerHTML;
			/*alert("itemValue.substring(0,1): " + itemValue.substring(0,1) + " item.style.display: " + item.style.display);
			if (itemValue.substring(0,1) == "<") {
				itemValue = "";
		    } else {
				itemValue = item.innerHTML;
		    }*/
			if (itemValue.substring(0,6) == "Error:") {
				itemValue = item.innerHTML;
		    }
        } else {
            itemValue = item.innerHTML;
        }


        //alert("itemValue: " + itemValue);
        WidgetDisplay.dispatch(displayWidget, itemValue, pageItemId, formFieldId, formId, encounterId, currentFieldNameIdentifier, bridgeId);
        DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
        DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden'; });
    }
}

function callChartWidget(pageItemId, formFieldId, formId, encounterId, inputType, displayField) {
    if (displayField != "") {
        //alert("inputWidget" + encounterId + "." + displayField);  // enum: 1847, float: 1858
        var item = document.getElementById("inputWidget" + encounterId + "." + displayField);
        if (! item) {
            var item = document.getElementById("inputWidget" + encounterId + "." + formFieldId);
        }
    } else {
        var item = document.getElementById("inputWidget" + encounterId + "." + formFieldId);
    }
    if (! item) {
      //  alert("2 inputWidget" + encounterId + "." + displayField);  // enum: 1847, float: 1858
        var item = document.getElementById("value" + encounterId + "." + formFieldId);
        var widget = document.getElementById("widget" + encounterId + "." + formFieldId);
        if (! item) {
            var item = document.getElementById("value" + encounterId + "." + displayField);
            var widget = document.getElementById("widget" + encounterId + "." + displayField);
        }
        if (item.style.display == "none") {
            itemValue = widget.innerHTML;
        } else {
            itemValue = item.innerHTML;
        }
        if (inputType =="lab_results") {
            // if (widget.innerHTML =="") {
                WidgetDisplay.dispatchChartLabs(displayWidget, itemValue, pageItemId, formFieldId, formId, encounterId, displayField);
                DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
                DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden'; });
        } else {
            if (formId == 170) {
				WidgetDisplay.dispatchChartStringIdentifier(displayWidget, itemValue, pageItemId, formFieldId, formId, encounterId);
			} else {
				WidgetDisplay.dispatchChart(displayWidget, itemValue, pageItemId, formFieldId, formId, encounterId);
			}
            DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
            DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden'; });
        }
    }
}

/**
 * Calls widget for editing encounter record metadata such as site id.
 * @param {Object} item
 * @param {Object} encounterId
 */
function callMetaDataWidget(metadataItem, formId, encounterId) {
	var item = document.getElementById("value" + metadataItem);
    var widget = document.getElementById("widget" + metadataItem);
    if (item.style.display == "none") {
        itemValue = widget.innerHTML;
    } else {
        itemValue = item.innerHTML;
    }
    // alert ("encounterId: " + encounterId + " itemValue: " + itemValue);
    WidgetDisplay.dispatchMetaData(displayWidget, itemValue, metadataItem, formId, encounterId);
    DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
    DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden'; });
}

/**
 * Summons the widget for a report
 * @param item
 * @param className
 * @return
 */
function callReportWidget(identifier, className) {
	var item = document.getElementById("value." + identifier);
	var widget = document.getElementById("widget." + identifier);
	if (item.style.display == "none") {
		itemValue = item.innerHTML;
	} else {
		itemValue = item.innerHTML;
	}
	// alert("identifier:" + identifier);
	WidgetDisplay.dispatchReportWidget(displayReportWidget, itemValue, identifier, className);
	DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
	DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden'; });
}
/**
 * Summons the widget for a report
 * @param item
 * @param className
 * @return
 */
function callDynamicReportWidget(identifier, className) {
	var item = document.getElementById("value." + identifier);
	var widget = document.getElementById("widget." + identifier);
	if (item.style.display == "none") {
		itemValue = item.innerHTML;
	} else {
		itemValue = item.innerHTML;
	}
	var updateMethod = "updateDynamicReportValue";
	WidgetDisplay.dispatchDynamicReportWidget(displayReportWidget, itemValue, identifier, className, updateMethod);
	DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
	DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden'; });
}

/**
 * Updates the record and returns updated value.
 * @param {Object} inputType
 * @param {Object} formFieldId
 * @param {Object} pageItemId
 * @param {Object} formId
 * @param {Object} encounterId
 * @param {Object} widgetType
 * @param {Object} className
 * @param {Object} bridgeId
 * @param {Object} currentFieldNameIdentifier
 */
function updateRecord(inputType, formFieldId, pageItemId, formId, encounterId, widgetType, className, bridgeId, currentFieldNameIdentifier) {
    DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
	var widgetName = "widget" + formFieldId;
	if (currentFieldNameIdentifier != null) {
		widgetName = "widget" + currentFieldNameIdentifier + formFieldId;
	}
    DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden'; Fat.fade_element(widgetName, 60, 2000, "#FFFF33", "#AFEEEE") });
    itemValue = getValue(formFieldId, "inputWidget", inputType);
    var displayFunction = displayWidget;
    if (widgetType == "Chart") {
       displayFunction = displayWidget;
    }
    var displayField = formFieldId;
    var isValid = false;
    if (itemValue == "") {
        if (inputType == "checkbox") {
        	Encounter.update(displayFunction, inputType, itemValue, pageItemId, formId, encounterId, widgetType, displayField);
        } else {
        	//alert("No value entered. Please enter a value.");
        	isValid = confirm("Are you sure you wish to submit an empty value?")
        }
    }

    if ((isValid == true) || (itemValue != "")){
        var validate = eval("validate" + className + "(document.getElementById('" + className + "'))");
        if (validate) {
        	if (formId == 132) {
        		StockEncounter.update(displayFunction, inputType, itemValue, pageItemId, formId, encounterId, widgetType, displayField, bridgeId, currentFieldNameIdentifier);
        	} else {
        		Encounter.update(displayFunction, inputType, itemValue, pageItemId, formId, encounterId, widgetType, displayField, bridgeId, currentFieldNameIdentifier);
        	}
        }
    }
}

/**
 * Update reports
 * @param inputType
 * @param formFieldId
 * @param pageItemId
 * @param formId
 * @param encounterId
 * @param widgetType
 * @param bridgeId
 * @param currentFieldNameIdentifier
 * @return
 */
function updateReportValue(identifier, widgetType) {
	// alert("identifier: " + identifier + " widgetType: " + widgetType);
	//DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
	var widgetName = "widget." + identifier;
	//DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden'; Fat.fade_element(widgetName, 60, 2000, "#FFFF33", "#AFEEEE") });
	itemValue = getValue(identifier, "inputWidget", null);
	var displayFunction = displayReportValues;
	if (widgetType == "CDRRArtReport" || widgetType == "CDRROIReport") {
		displayFunction = "displayCdrrReportValues";
	} else if (widgetType == "MonthlyArtReport") {
		displayFunction = "displayCdrrReportValues";
	}
	if (itemValue == "") {
		alert("No value entered. Please enter a value.");
	} else {
		 //alert("identifier = "+ identifier);
		ReportHelper.updateReport(displayCdrrReportValues, identifier, widgetType, itemValue);
	}
}

function updateDynamicReportValue(identifier, widgetType) {
	// alert("identifier: " + identifier + " widgetType: " + widgetType);
	//DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
	var widgetName = "widget." + identifier;
	//DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden'; Fat.fade_element(widgetName, 60, 2000, "#FFFF33", "#AFEEEE") });
	itemValue = getValue(identifier, "inputWidget", null);
	var displayFunction = displayReportValues;
	if (widgetType == "CDRRArtReport" || widgetType == "CDRROIReport") {
		displayFunction = "displayCdrrReportValues";
	} else if (widgetType == "MonthlyArtReport") {
		displayFunction = "displayCdrrReportValues";
	}
	if (itemValue == "") {
		alert("No value entered. Please enter a value.");
	} else {
		//alert("identifier = "+ identifier);
		ReportHelper.updateDynamicReport(displayCdrrReportValues, identifier, widgetType, itemValue);
	}
}

function saveReport(widgetType, dynamicReport) {
	//DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
	//DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden'; Fat.fade_element(widgetName, 60, 2000, "#FFFF33", "#AFEEEE") });
	/*var displayFunction = displayReportValues;
	if (widgetType == "CDRRArtReport" || widgetType == "CDRROIReport") {
		displayFunction = "displayCdrrReportValues";
	} else if (widgetType == "MonthlyArtReport") {
		displayFunction = "displayCdrrReportValues";
	}*/
	if (dynamicReport == '1') {
		ReportHelper.updateDynamicReport(saveReportNext, 'SaveNext', widgetType, null);
	} else {
		ReportHelper.updateReport(saveReportNext, 'SaveNext', widgetType, null);
	}
}

/**
 * Creates a new bridge table record
 * @param {Object} inputType
 * @param {Object} formFieldId
 * @param {Object} pageItemId
 * @param {Object} formId
 * @param {Object} encounterId
 * @param {Object} widgetType
 * @param {Object} className
 * @param {Object} currentFieldNameIdentifier
 */
function createRecord(inputType, formFieldId, pageItemId, formId, encounterId, widgetType, className, currentFieldNameIdentifier) {
    DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
	var widgetName = "widget" + formFieldId;
	if (currentFieldNameIdentifier != null) {
		widgetName = "widget" + currentFieldNameIdentifier + formFieldId;
	}
    DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden'; Fat.fade_element(widgetName, 60, 2000, "#FFFF33", "#AFEEEE") });
    itemValue = getValue(formFieldId, "inputWidget", inputType);
    var displayFunction = displayWidget;
    if (widgetType == "Chart") {
       displayFunction = displayWidget;
    }
    var displayField = formFieldId;
    if (itemValue == "") {
        if (inputType == "checkbox") {
        Encounter.update(displayFunction, inputType, itemValue, pageItemId, formId, encounterId, widgetType, displayField);
        } else {
        alert("No value entered. Please enter a value.");
        }
    } else {
        var validate = eval("validate" + className + "(document.getElementById('" +className + "'))");
        if (validate) {
            Encounter.update(reloadPage, inputType, itemValue, pageItemId, formId, encounterId, widgetType, displayField, null, currentFieldNameIdentifier);
        }
    }
}

/**
 * Update an encounter record metadata field such as siteId.
 * @param {Object} inputType
 * @param {Object} encounterId
 *
 */
function updateRecordMetadata(inputType, encounterId) {
    DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
    DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden'; Fat.fade_element("widget" + formFieldId, 60, 2000, "#FFFF33", "#AFEEEE") });
    itemValue = getValue(0, "inputWidget", inputType);
    var displayFunction = displayWidget;
    if (itemValue == "") {
        alert("No value entered. Please enter a value.");
    } else {
        Encounter.updateMetadata(displayFunction, inputType, itemValue, encounterId);
    }
}

function updateRecordChart(inputType, formFieldId, pageItemId, formId, encounterId, widgetType, displayField) {
    DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
    DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden';
    var fadeElementName =  "widget"+ encounterId + "." + formFieldId;
    var fadeElement =  document.getElementById(fadeElementName);
    if (!fadeElement) {
       fadeElementName =  "widget"+ encounterId + "." + displayField;
    }
    Fat.fade_element(fadeElementName, 60, 2000, "#FFFF33", "#AFEEEE") });
    var inputWidgetName =  encounterId + "." + formFieldId;
    if (formFieldId == 1858) {  // HB screen lab test
        if (displayField) {
        inputWidgetName =  encounterId + "." + displayField;
        }
        itemValue = getValue(inputWidgetName, "inputWidget", inputType);
    } else if (formFieldId == 2004) {  // CD4 count lab test
        if (displayField) {
        inputWidgetName =  encounterId + "." + displayField;
        }
        itemValue = getValue(inputWidgetName, "inputWidget", inputType);
    } else {
        itemValue = getValue(inputWidgetName, "inputWidget", inputType);
    }

    var displayFunction = displayWidget;
    if ((formFieldId == 1563) || (formFieldId == 1565)) {  // RPR Result or RPR Drug
        displayFunction = displayChartDateWidget;
    }
    if ((formFieldId == 2244) || (formFieldId == 201)) {  // StockControl expiry and Status dropdown
    	displayFunction = displayWidgetRefresh;
    }
    if ((formFieldId == 2168) || (formFieldId == 2169)) {  // Health weight and height
    	displayFunction = displayWidgetRefresh;
    }
    if (displayField != "") {
        displayFunction = displayChartWidget;
    }
    if (itemValue == "") {
        if (inputType == "checkbox" || inputType == "checkbox_dwr") {
        Encounter.update(displayFunction, inputType, itemValue, pageItemId, formId, encounterId, widgetType, displayField);
        } else {
        alert("No value entered. Please enter a value.");
        }
    } else {
        // cek 2/20/2006 - disabled validation - causing problems w/ labs form.
        // var validate = eval("validateForm" + formId + "(this)");
       // if (validate) {
    	if (formId == 170) {
    		var submitForm = true;
    		if (formFieldId == 2267) {
    			if (itemValue.length < 8) {
    				alert("The password is too short. Please choose a password with at least 8 characters.");
    				submitForm = false;
    			}
    		}
    		if (submitForm == true) {
    			Encounter.updateStringIdentifier(displayFunction, inputType, itemValue, pageItemId, formId, encounterId, widgetType, displayField);
    		}
    	} else {
	   	   	Encounter.update(displayFunction, inputType, itemValue, pageItemId, formId, encounterId, widgetType, displayField);
	   }
       // }
    }
}


function updateRecordIdName(inputType, formFieldId, pageItemId, formId, encounterId, idName, widgetType) {
	var widgetName = "widget" + formFieldId;
	DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
    DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden'; Fat.fade_element(widgetName, 60, 2000, "#FFFF33", "#AFEEEE") });
    if (!widgetType) {
        widgetType = "Form";
    }
    displayField = formFieldId;
    idNamePrefix = "field" + idName;
    itemValue = getValue(formFieldId, idNamePrefix, inputType);
    Encounter.update(displayWidget, inputType, itemValue, pageItemId, formId, encounterId, widgetType, displayField);
}

/**
 * Fetch value of rendered widget
 * @param {Object} formFieldId
 * @param {Object} prefix
 * @param {Object} inputType
 */
function getValue(formFieldId, prefix, inputType) {
    // alert (prefix + formFieldId + " inputType" + inputType);
	if (formFieldId == 0) {	// record metadata field
		var item = document.getElementById(prefix + inputType);
		if (inputType == "SiteId") {
			itemValue = item[item.selectedIndex].value;
		}
	} else {
		var item = document.getElementById(prefix + formFieldId);
	}

    if (inputType == "patientid") {
        item = document.getElementById("patient");
        // alert("item.value: " + item.value)
    }
    if (inputType == "select") {
        itemValue = item[item.selectedIndex].value;
    } else if (inputType == "textarea") {
        itemValue = item.value;
    } else if (inputType == "checkbox" || inputType == "checkbox_dwr") {
        if (item.checked == true) {
            // cek changed 2/1/2006 - problems w/ routine ante form, problem field
        itemValue = 1;
        } else {
        itemValue = 0;
        }
    } else {
        itemValue = item.value;
    }
// alert("prefix + formFieldId: " + prefix + formFieldId + ", itemValue: " + itemValue);
    return itemValue;
}

/**
 * Improved version of DRWUtil.getValue
 * fixes improper return of select value.
 */
dwrUtilgetValue = function(ele, options) {
	if (options == null) {
		options = {};
	}
	var orig = ele;
	ele = $(ele);


	var nodes = document.getElementsByName(orig);
	if (ele == null && nodes.length >= 1) {
		ele = nodes.item(0);
	}
	if (ele == null) {
		DWRUtil.debug("getValue() can't find an element with id/name: " + orig + ".");
		return "";
	}

	if (DWRUtil._isHTMLElement(ele, "select")) {


		var sel = ele.selectedIndex;
		if (sel != -1) {
			var reply = ele.options[sel].value;
			/*if (reply == null || reply == "") {
				reply = ele.options[sel].text;
			}*/

			return reply;
		}
		else {
			return "";
		}
	}

	if (DWRUtil._isHTMLElement(ele, "input")) {
		if (ele.type == "radio") {
			var node;
			for (i = 0; i < nodes.length; i++) {
				node = nodes.item(i);
				if (node.type == "radio") {
					if (node.checked) {
						if (nodes.length > 1) return node.value;
						else return true;
					}
				}
			}
		}
		switch (ele.type) {
		case "checkbox":
		case "check-box":
		case "radio":
			return ele.checked;
		default:
			return ele.value;
		}
	}

	if (DWRUtil._isHTMLElement(ele, "textarea")) {
		return ele.value;
	}

	if (options.textContent) {
		if (ele.textContent) return ele.textContent;
		else if (ele.innerText) return ele.innerText;
	}
	return ele.innerHTML;
};


/**
 * cek 11 aug 2005
 * Uncomment the following line to check if user is logged in
 * test("http://" + hostname + ":8080/zeprs/dwr;jsessionid=" + jsessionid);
 * @param {Object} url
 */
function test(url) {

    if (window.XMLHttpRequest)
    {
        xmlhttp = new XMLHttpRequest();
    }

    else if (window.ActiveXObject && !(navigator.userAgent.indexOf('Mac') >= 0 && navigator.userAgent.indexOf("MSIE") >= 0))
    {
        xmlhttp = new window.ActiveXObject("Microsoft.XMLHTTP");
    }

     xmlhttp.open("GET", url,true);
     xmlhttp.onreadystatechange=function() {
     // alert("xmlhttp.readyState: " + xmlhttp.readyState + " xmlhttp.status: " + xmlhttp.status + " xmlhttp.statusText: " + xmlhttp.statusText)
     if (xmlhttp.readyState==4) {
     var txt = xmlhttp.responseText
        if (xmlhttp.status==200) {
            var titleLoc = txt.indexOf("title",0);
            var subs = txt.substring(titleLoc+6,35);
            if (subs !="DWR Test Index") {
            alert("Your session has expired and you have been logged out of the ZEPRS application. \n\n Please refresh this page and login again.")
            }
        }
        else if (xmlhttp.status==404) {
            alert("URL doesn't exist!")
        }
        else {
            alert("Status is "+xmlhttp.status)
        }
      }
     }
     xmlhttp.send(null)
}

var displayWidget = function(data)
{
	//alert("data: " + data);
	var delim = data.indexOf("=",0);
    var length = data.length;
    var fieldId = data.substr(0,delim);
    var key = "widget" + fieldId;
    var value =  data.substr(delim+1,length);
    var widgetValue = document.getElementById(key);
    if (value.substring(0,6) == "Error:") {
    } else {
    	widgetValue.innerHTML = value;
    }
    var valueLink =  document.getElementById("value" + fieldId);
    valueLink.style.display = "none";
    valueLink.style.visibility = "hidden";
	if (value.substring(0,6) == "Error:") {
		alert(value);
		window.location.reload();
    }
};

var displayWidgetRefresh = function(data)
{
	//alert("data: " + data);
	var delim = data.indexOf("=",0);
	var length = data.length;
	var fieldId = data.substr(0,delim);
	var key = "widget" + fieldId;
	var value =  data.substr(delim+1,length);
	var widgetValue = document.getElementById(key);
	if (value.substring(0,6) == "Error:") {
	} else {
		widgetValue.innerHTML = value;
	}
	var valueLink =  document.getElementById("value" + fieldId);
	valueLink.style.display = "none";
	valueLink.style.visibility = "hidden";
	if (value.substring(0,6) == "Error:") {
		alert(value);
		window.location.reload();
	}
	window.location.reload();
};

var displayChartWidget = function(data)
{
    var delim = data.indexOf("=",0);
    var length = data.length;
    var fieldId = data.substr(0,delim);
    var key = "widget" + fieldId;
    var value =  data.substr(delim+1,length);
    var itemValue = document.getElementById(key);
    itemValue.innerHTML = value;
    var valueLink =  document.getElementById("value" + fieldId);
    valueLink.style.display = "none";
    valueLink.style.visibility = "hidden";
}

var displayReportWidget = function(data)
{
	var delim = data.indexOf("=",0);
	var length = data.length;
	var identifier = data.substr(0,delim);
	var key = "widget." + identifier;
	var value =  data.substr(delim+1,length);
	var itemValue = document.getElementById(key);
	itemValue.innerHTML = value;
	var valueLink =  document.getElementById("value." + identifier);
	valueLink.style.display = "none";
	valueLink.style.visibility = "hidden";
}

var displayCdrrReportValues = function(data)
{
    //alert("data: " + data);
	var records = data.split(";");
    var quantityRequiredResupply = records[0];
    var totalQuantityRequired =  records[1];
    if (quantityRequiredResupply == "0=0") {
    } else {
    	var dvals = quantityRequiredResupply.split("=");
        var key = dvals[0];
        var value =  dvals[1];
    	if (value.substring(0,6) == "Error:") {
    		alert(value);
        } else {
            setFieldValues(key, value);
        }
    }
    if (totalQuantityRequired != null) {
    	dvals = totalQuantityRequired.split("=");
        key = dvals[0];
        value =  dvals[1];
        if (value.substring(0,6) == "Error:") {
    		alert(value);
        } else {
            setFieldValues(key, value);
        }
    } else {
    }
};

var saveReportMessage = function(data)
{
	var output = alert(data);
}

var saveReportNext = function(data)
{
	/*var params = data.split(";");
	var reportName = params[0];
	var jsessionid = params[1];
	var bdate = params[2];
	var edate = params[3];
	var siteId = params[4];
	var report = params[5];*/
	//if (reportName == 'CDRRArtReport') {
		//http://localhost:8088/dar/ChooseReportAction.do;jsessionid=A8FDBEC1E3D95CF2EABD1582A430077C?bdate=2010-08-07&edate=2010-09-07&siteId=9&report=7&isCombinedReport=1
    window.location.href = data;
	//}
	/*else if (reportName == 'CDRRArtReport') {

	} else {*/

}

var displayReportValues = function(data)
{
	var dvals = data.split("=");
	var key = dvals[0];
	var value =  dvals[1];
	setFieldValues(key, value);

	//var delim = data.indexOf("=",0);
	//var length = data.length;
	//var identifier = data.substr(0,delim);
	/*var key = "widget." + identifier;
	var value =  data.substr(delim+1,length);
	var itemValue = document.getElementById(key);
	itemValue.innerHTML = value;
	var valueLink =  document.getElementById("value." + identifier);
	valueLink.style.display = "none";
	valueLink.style.visibility = "hidden";*/
}

/**
 * Set values after update.
 * @param key
 * @param value
 * @return
 */
function setFieldValues(key,value) {
	var widgetSpanId = "widget." + key;
	var valueSpanId = "value." + key;
	var widgetSpan = document.getElementById(widgetSpanId);
	widgetSpan.innerHTML = value;
	var valueSpan = document.getElementById(valueSpanId);
	valueSpan.style.display = "none";
	valueSpan.style.visibility = "hidden";
}

// Updates value and date
var displayChartDateWidget = function(data)
{
    var dvals = data.split("=");
    var fieldId = dvals[0];
    var value =  dvals[1];
    var dateFieldId =  dvals[2];
    var dateValue =  dvals[3];
    var key = "widget" + fieldId;
    var itemValue = document.getElementById(key);
    itemValue.innerHTML = value;
    var valueLink =  document.getElementById("value" + fieldId);
    valueLink.style.display = "none";
    valueLink.style.visibility = "hidden";
    if (dateValue != "") {
        DWRUtil.setValue("widget" + dateFieldId, dateValue);
    }

}

function redirect(url, jsessionId, patientId, labtest_id, extendedTestId) {
    var dateResultsField = "widget" + labtest_id + ".1846";
    var dateResultsFieldV = "value" + labtest_id + ".1846";
    var dateResults = DWRUtil.getValue(dateResultsField);
    var dateResultsV = DWRUtil.getValue(dateResultsField);
    if (dateResults == "" && dateResultsFieldV == '') {
        alert("Please enter Date of Lab Results first.")
    } else {
        window.location.href = "/dar/" + url +".do;jsessionid=" + jsessionId + "?patientId=" + patientId + "&field2037=" + labtest_id + "&extendedTestId=" + extendedTestId;
    }
}