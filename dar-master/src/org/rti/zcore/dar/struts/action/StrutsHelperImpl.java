/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.struts.action;

import org.apache.struts.action.ActionForward;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.Form;
import org.rti.zcore.utils.struts.StrutsHelper;


public class StrutsHelperImpl implements StrutsHelper {
	  /**
    *
    * @param actionType
    * @param patientId
    * @param encounterForm
    * @return
    * @throws NumberFormatException
    */
	public ActionForward getActionForward(String actionType, Long patientId, Form encounterForm) throws NumberFormatException {
		ActionForward forwardForm = null;
		String forwardString = null;
		Long formTypeId = encounterForm.getFormTypeId();
		Long formId = encounterForm.getId();
		String formName = DynaSiteObjects.getFormIdClassNameMap().get(formId);
		if (actionType.equals("deleteEncounter")) {
			switch (formTypeId.intValue()) {
			case 5: 	// admin
				// TIMS
				if (formName.equals("Relationship")) {
					forwardString = "/PerpetratorDemographics/list.do?patientId=" + patientId;
					forwardForm = new ActionForward(forwardString);
					forwardForm.setRedirect(true);
					return forwardForm;
				}
				forwardString = "/admin/records/list.do?formId=" + formId  + "&className=" + formName;
				forwardForm = new ActionForward(forwardString);
				forwardForm.setRedirect(true);
				break;
			case 7: // charts
				forwardString = "/chart.do?id=" + formId;
				forwardForm = new ActionForward(forwardString);
				forwardForm.setRedirect(true);
				break;
			default:
				//return mapping.findForward("patientHome");
				if (formName.equals("Appointment")) {
					forwardString = "/Appointment/new.do?patientId=" + patientId;
					forwardForm = new ActionForward(forwardString);
					forwardForm.setRedirect(true);
				} else {
					forwardString = "/patientHome.do?patientId=" + patientId;
					forwardForm = new ActionForward(forwardString);
					forwardForm.setRedirect(true);
				}
				break;
			}
		}
		return forwardForm;
	}
}
