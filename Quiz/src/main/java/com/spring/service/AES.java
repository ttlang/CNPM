package com.spring.service;

public interface AES {
	public String encrypt(String key,String initVector,String value);
	public String decrypt(String key,String initVector,String value);
	/**
	 * Mã hóa một chuỗi
	 * @param value chuỗi nhận vào
	 * @return chuỗi sau khi được mã hóa
	 */
	public String encrypt(String value);
	
	/**
	 * 
	 * @param value 
	 * @return
	 */
	public String decrypt(String value);
	

}
