<%--
  ~    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
  ~
  ~    Licensed under the Apache License, Version 2.0 (the "License");
  ~    you may not use this file except in compliance with the License.
  ~    You may obtain a copy of the License at
  ~
  ~        http://www.apache.org/licenses/LICENSE-2.0
  --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="syncLog" type="org.rti.zcore.SyncLog"/>

<tr>
	<td>${syncLog.importTimestamp}</td>
	<td>${syncLog.exportTimestamp}</td>
	<td>${syncLog.className}</td>
	<td>${syncLog.uuid}</td>
	<td>${syncLog.parentUuid}</td>
	<td>${syncLog.objectUuid}</td>
	<td>${syncLog.exception}</td>
	<td>${syncLog.exceptionClass}</td>
	<td>${syncLog.exceptionMessage}</td>
</tr>
