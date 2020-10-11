package com.kh.danaa.review.model.service;

import java.util.ArrayList;
import com.kh.danaa.review.model.vo.Review;


public interface ReviewService {

	Review selectReview(int reviewno);

	ArrayList<Review> selectList(int currentPage, int limit);

	ArrayList<Review> selectTop3();

	int selectListCount();

	int insertOriginReview(Review review);

	int updateReview(Review review);

	int deleteReview(Review review);

	int updateReadCount(int review_no);

	ArrayList<Review> selectSearchtitle(String keyword);

	ArrayList<Review> selectSearchcontent(String keyword);

	ArrayList<Review> selectList();

	ArrayList<Review> selectDetail(int review_no);

	int selectReviewCount();
	
}
