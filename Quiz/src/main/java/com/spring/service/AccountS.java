package com.spring.service;

import java.util.Date;

import com.spring.domain.Account;

public interface AccountS {
	/**
	 *  kiểm tra địa chỉ mail có tồn tại trong hệ thống
	 * @param email địa chỉ email
	 * @return true: tồn tại, false: không tồn tại
	 */
	public boolean checkEmail(String email);
	/**
	 * kiểm tra địa chỉ email vào password có tồn tại trong hệ thống hay không
	 * @param email
	 * @param password
	 * @return true: tồn tại| false: không
	 */
	public boolean checkEmailAndPassword(String email,String password);
	
	/**
	 * lấy ra tài khoản từ email nhận vào
	 * @param địa chỉ email
	 */
	public Account getAccountByEmail(String email);
	
	/**
	 * 
	 * @param email
	 * @param password
	 * @return mã người dùng
	 */
	 
	public int SignUp(String email,String password);
	/**
	 * 
	 * @param email
	 * @param password
	 * @return thông báo từ server|
	 */
	public String checkLogin(String email,String password);
	/**
	 * Lấy ra tài khoản người dùng
	 * @param id mã người dùng
	 * @return	Tài khoản người dùng
	 */
	public  Account getAccountByID(int id);
	
	/**
	 * Đối trạng thái tài khoản người dùng 
	 * @param idAccount mã người dùng
	 * @param state: trạng thái người dùng
	 * @return số dòng thay đổi
	 */
	public int enableAccount(int idAccount,boolean state);
	/**
	 * 
	 * @param IdAccount mã người dùng
	 * @param newPassword	mật khẩu mới
	 * @return số dòng thay đổi dữ liệu
	 */
	public int changePassword(int IdAccount,String NewPassword);
	
	/**
	 * 
	 * @param email địa chỉ email
	 * @param newPassword mật khẩu mới
	 * @return số dòng bị thay đổi
	 */
	public int changePassword(String email,String newPassword);
	
	/**
	 * Kiểm tra một tài khoản có phải là quản trị viên của một phòng hay không
	 * @param IDAccount mã người dùng 		
	 * @param IdRoom mã phòng
	 * @return true nếu là admin
	 */
	
	public boolean checkIsAdmin(int IDAccount,int IdRoom);
	/**
	 * cập nhật thông tin người dùng
	 * @param name
	 * @param birth
	 * @param job
	 * @param gender
	 * @param address
	 * @param idAccount
	 * @return true: cập nhật thành công | false: cập nhật thất bại
	 */
	public boolean updateAccountInfo(String name,Date birth,String job,boolean gender,String address,int idAccount);
	/**
	 * cập nhật hình ảnh của người dùng
	 * @param avatarLink
	 * @param idAccount
	 * @return true: cập nhật thành công | false:cập nhật thất bại
	 */
	
	public boolean updateAccountAvatar(String avatarLink, int idAccount);
	
}
