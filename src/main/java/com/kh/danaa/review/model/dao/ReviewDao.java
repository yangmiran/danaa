package com.kh.danaa.review.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.danaa.review.model.vo.Review;
import com.kh.danaa.review.model.vo.ReviewPage;

@Repository("reviewDao")
public class ReviewDao {
	@Autowired
	private SqlSessionTemplate session;

	public ReviewDao() {}
	
	public Review selectReview(int review_no) {
		return session.selectOne("reviewMapper.selectReview", review_no);
	}

	public ArrayList<Review> selectList(int currentPage, int limit) {
		int startRow = (currentPage -1) * limit +1;
		int endRow = startRow + limit -1;

		ReviewPage rpage = new ReviewPage(startRow, endRow);
		List<Review> list = session.selectList("reviewMapper.selectList", rpage);
		return (ArrayList<Review>) list;
	}

	public ArrayList<Review> selectTop3() {
		List<Review> list = session.selectList("reviewMapper.reviewTop3");
		return (ArrayList<Review>) list;
	}

	public int selectListCount() {
		return session.selectOne("reviewMapper.getListCount");
	}
	
	public int insertOriginReview(Review review) {
		return session.insert("reviewMapper.insertOriginReview", review);
	}

	public int updateReview(Review review) {
		return session.update("reviewMapper.updateReview", review);
	}
	
	public int deleteReview(Review review) {
		return session.delete("reviewMapper.deleteReview", review);
	}
	
	public int updateComment(Review comment) {
		return session.update("reviewMapper.updateComment", comment);
	}

	public int updateReadCount(int review_no) {
		return session.update("reviewMapper.addReadCount", review_no);
	}

	public ArrayList<Review> selectList() {
		List<Review> list = session.selectList("reviewMapper.selectList");
		return(ArrayList<Review>)list;
	}

	public ArrayList<Review> selectSearchcontent(String keyword) {
		List<Review> list = session.selectList("reviewMapper.selectSearchcontent", keyword);
		return(ArrayList<Review>)list;
	}

	public ArrayList<Review> selectSearchtitle(String keyword) {
		List<Review> list = session.selectList("reviewMapper.selectSearchtitle", keyword);
		return(ArrayList<Review>)list;
	}

	public ArrayList<Review> selectDetail(int review_no) {
		List<Review> list = session.selectList("reviewMapper.selectDetail", review_no);
		return (ArrayList<Review>)list;
	}

	public int selectReviewCount() {
		return session.selectOne("reviewMapper.recount");
	}	

}
