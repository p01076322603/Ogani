package com.ogani.util;

import java.util.Random;

public class TempKey {

	private int size;
	private boolean lowerCheck;

	public String getKey(int size, boolean lowerCheck) {
		this.size = size;
		this.lowerCheck = lowerCheck;
		return init();
	}

	private String init() {
		Random rand = new Random();
		StringBuffer key = new StringBuffer();

		int ch = 0;

		do {
			ch = rand.nextInt(75) + 48;

			if ((ch >= 48 && ch <= 57) || 
			    (ch >= 65 && ch <= 90) || 
			    (ch >= 97 && ch <= 122)) {
				key.append((char) ch);
			
			} else {
				continue;
			}

		} while (key.length() < size);

		if (lowerCheck) {
			return key.toString().toLowerCase();
		}

		return key.toString();
	}
}
