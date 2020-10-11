package com.kh.danaa.admin.model.service;

import com.kh.danaa.admin.model.vo.Admin;

public interface AdminService {

	Admin selectAdmin();

	int updateAdmin(Admin admin);

}
