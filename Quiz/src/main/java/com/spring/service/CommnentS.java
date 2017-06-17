package com.spring.service;

public interface CommnentS {
	/**
	 * Xóa 1 bình luận trong một bài đăng
	 * 
	 * @param idComment
	 * @param idAcc
	 * @return thành công hay thất bại
	 */
	public boolean deleteComment(int idComment, int idAcc);
}
