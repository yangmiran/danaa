package com.kh.danaa.banner.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.danaa.banner.model.vo.Banner;
import com.kh.danaa.banner.model.vo.BannerPage;

@Repository("bannerDao")
public class BannerDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public BannerDao() {}


	public ArrayList<Banner> selectList() {
		List<Banner> list = session.selectList("bannerMapper.selectBanner");
		return (ArrayList<Banner>)list;
	}

	//배너카운트
	public int selectBannerCount() {
		return session.selectOne("bannerMapper.selectBannerCount");
	}

	
	//배너 리스트
	public ArrayList<Banner> selectListBanner(int page, int limit) {
		int startRow = (page-1) *limit +1;
		int endRow = startRow + limit -1;
		
		BannerPage bpage = new BannerPage(startRow, endRow);
		
		List<Banner> list = session.selectList("bannerMapper.selectListBanner", bpage);
		return (ArrayList<Banner>) list;
	}

	
	//배너등록
	public int insertBanner(Banner banner) {
		return session.insert("bannerMapper.insertBanner", banner);
	}


	public int deleteBanner(Banner banner) {
		return session.delete("bannerMapper.deleteBanner", banner);
	}


	public ArrayList<Banner> selectAllBanner() {
		List<Banner> list = session.selectList("bannerMapper.selectAllBanner");
		return (ArrayList<Banner>)list;
	}
	
	public Banner selectOneBanner(int bn_no) {
		return session.selectOne("bannerMapper.selectOneBanner", bn_no);
	}


	public int updateBanner(Banner banner) {
		return session.update("bannerMapper.updateBanner", banner);
	}


	public int deleteMultiBanner(int bn_no) {
		return session.delete("bannerMapper.deleteMultiBanner", bn_no);
	}


	public ArrayList<Banner> selectSearchTit(String keyword) {
		List<Banner> list = session.selectList("bannerMapper.selectSearchTit", keyword);
		return (ArrayList<Banner>)list;
	}


	public ArrayList<Banner> selectSearchState(String keyword) {
		List<Banner> list = session.selectList("bannerMapper.selectSearchState", keyword);
		return (ArrayList<Banner>)list;
	}
}
