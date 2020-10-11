package com.kh.danaa.banner.model.service;

import java.util.ArrayList;

import com.kh.danaa.banner.model.vo.Banner;

public interface BannerService {
	ArrayList<Banner> selectBanner();
	int selectBannerCount();
	ArrayList<Banner> selectListBanner(int page, int limit);
	int insertBanner(Banner banner);
	int deleteBanner(Banner banner);
	ArrayList<Banner> selectAllBanner();
	Banner selectOneBanner(int bn_no);
	int updateBanner(Banner banner);
	int deleteMultiBanner(int bn_no);
	ArrayList<Banner> selectSearchTit(String keyword);
	ArrayList<Banner> selectSearchState(String keyword);
}
