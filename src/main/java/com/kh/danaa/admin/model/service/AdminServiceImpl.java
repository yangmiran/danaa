package com.kh.danaa.admin.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.danaa.admin.model.dao.AdminDao;
import com.kh.danaa.admin.model.vo.Admin;

@Service("adminService")
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDao adminDao;

	@Override
	public Admin selectAdmin() {
		return adminDao.selectAdmin();
	}

	@Override
	public int updateAdmin(Admin admin) {
		return adminDao.updateAdmin(admin);
	}

}
