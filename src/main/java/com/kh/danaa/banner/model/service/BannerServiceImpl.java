package com.kh.danaa.banner.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.danaa.banner.model.dao.BannerDao;
import com.kh.danaa.banner.model.vo.Banner;

@Service("bannerService")
public class BannerServiceImpl implements BannerService {
	
	@Autowired
	private BannerDao bannerDao;


	@Override
	public ArrayList<Banner> selectBanner() {
		return bannerDao.selectList();
	}


	@Override
	public int selectBannerCount() {
		return bannerDao.selectBannerCount();
	}


	@Override
	public ArrayList<Banner> selectListBanner(int page, int limit) {
		return bannerDao.selectListBanner(page, limit);
	}


	@Override
	public int insertBanner(Banner banner) {
		return bannerDao.insertBanner(banner);
	}


	@Override
	public int deleteBanner(Banner banner) {
		return bannerDao.deleteBanner(banner);
	}


	@Override
	public ArrayList<Banner> selectAllBanner() {
		return bannerDao.selectAllBanner();
	}
	
	@Override
	public Banner selectOneBanner(int bn_no) {
		return bannerDao.selectOneBanner(bn_no);
	}


	@Override
	public int updateBanner(Banner banner) {
		return bannerDao.updateBanner(banner);
	}


	@Override
	public int deleteMultiBanner(int bn_no) {
		return bannerDao.deleteMultiBanner(bn_no);
	}


	@Override
	public ArrayList<Banner> selectSearchTit(String keyword) {
		return bannerDao.selectSearchTit(keyword);
	}


	@Override
	public ArrayList<Banner> selectSearchState(String keyword) {
		return bannerDao.selectSearchState(keyword);
	}
}
