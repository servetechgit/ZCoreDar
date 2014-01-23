/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.transfer.access;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.thoughtworks.xstream.converters.basic.AbstractSingleValueConverter;

public class IntegerConverter extends AbstractSingleValueConverter {
	/**
	 * Commons Logging instance.
	 */

	private static Log log = LogFactory.getFactory().getInstance(IntegerConverter.class);

	@Override
	public boolean canConvert(Class type) {
		return type.equals(int.class) || type.equals(Integer.class);
	}

	@Override
	public Object fromString(String str) {
		/* If empty tag. */

		if (str.compareTo("") == 0) {

		/* Default to zero. */

		str = "0";

		}

		Integer value = null;
		try {
			value = Integer.decode(str);
		} catch (NumberFormatException e) {
			try {
				Float floatValue = Float.valueOf(str);
				value = floatValue.intValue();
			} catch (NumberFormatException e1) {
				log.debug(e);
			}
		}
		return value;
	}

/*	@Override
	public void marshal(Object arg0, HierarchicalStreamWriter arg1, MarshallingContext arg2) {
		// TODO Auto-generated method stub

	}

	@Override
	public Object unmarshal(HierarchicalStreamReader arg0, UnmarshallingContext arg1) {
        log.debug("unmarshal!");
		if ((arg0.getValue() != null) && (!arg0.getValue().equals(""))) {
			return Integer.parseInt(arg0.getValue());
		} else {
			return null;
		}
	}

	@Override
	public boolean canConvert(Class arg0) {
		// TODO Auto-generated method stub
		return false;
	}*/

}
