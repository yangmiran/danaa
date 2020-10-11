package com.kh.danaa.admin.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.danaa.admin.model.vo.Admin;

@Repository("adminDao")
public class AdminDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public AdminDao() {}

	public Admin selectAdmin() {
		return session.selectOne("adminMapper.selectAdmin");
	}

	public int updateAdmin(Admin admin) {
		return session.update("adminMapper.updateAdmin", admin);
	}


}
