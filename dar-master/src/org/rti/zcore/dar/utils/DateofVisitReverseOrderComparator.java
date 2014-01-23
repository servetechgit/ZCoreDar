/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.utils;

import java.io.Serializable;
import java.util.Comparator;

/**
 * Sorts MshPatientTransactions objects. Other object types will default to natural order (see java.lang.Comparable).
 * SORTS IN REVERSE ORDER.
 * @author ckelley
 *
 */
public class DateofVisitReverseOrderComparator implements Comparator, Serializable {

	public int compare(Object o1, Object o2) {
        if ((o1 instanceof DateOfVisitOrderable) && (o2 instanceof DateOfVisitOrderable)) {
        	DateOfVisitOrderable do1, do2;
            do1 = (DateOfVisitOrderable) o1;
            do2 = (DateOfVisitOrderable) o2;
            if (do1.getDateofVisit().getTime() > do2.getDateofVisit().getTime()) {
                return -1;
            } else if (do1.getDateofVisit().getTime() < do2.getDateofVisit().getTime()) {
                return 1;
            }
        }
        return 0;
    }

}
