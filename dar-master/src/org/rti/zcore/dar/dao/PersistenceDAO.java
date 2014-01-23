/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.dao;

import java.sql.Connection;
import java.sql.Date;

public interface PersistenceDAO {

    public void updatePatientValues(Connection conn, Long patientId, int formFieldId, int value, Date dateVisit, Long encounterId);

}