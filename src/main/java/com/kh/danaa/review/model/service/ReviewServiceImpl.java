package com.kh.danaa.review.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.danaa.review.model.dao.ReviewDao;
import com.kh.danaa.review.model.vo.Review;

@Service("reviewService")
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	private ReviewDao reviewDao;

	@Override
	public Review selectReview(int review_no) {
		return reviewDao.selectReview(review_no);
	}

	@Override
	public ArrayList<Review> selectList(int currentPage, int limit) {
		return reviewDao.selectList(currentPage, limit);
	}

	@Override
	public ArrayList<Review> selectTop3() {
		return reviewDao.selectTop3();
	}

	@Override
	public int selectListCount() {
		return reviewDao.selectListCount();
	}

	@Override
	public int insertOriginReview(Review review) {
		return reviewDao.insertOriginReview(review);
	}

	@Override
	public int updateReview(Review review) {
		return reviewDao.updateReview(review);
	}

	@Override
	public int deleteReview(Review review) {
		return reviewDao.deleteReview(review);
	}

	@Override
	public int updateReadCount(int review_no) {
		return reviewDao.updateReadCount(review_no);
	}

	@Override
	public ArrayList<Review> selectSearchtitle(String keyword) {
		return reviewDao.selectSearchtitle(keyword);
	}

	@Override
	public ArrayList<Review> selectSearchcontent(String keyword) {
		return reviewDao.selectSearchcontent(keyword);
	}

	@Override
	public ArrayList<Review> selectList() {
		return reviewDao.selectList();
	}

	@Override
	public ArrayList<Review> selectDetail(int review_no) {
		return reviewDao.selectDetail(review_no);
	}

	@Override
	public int selectReviewCount() {
		return reviewDao.selectReviewCount();
	}
}
