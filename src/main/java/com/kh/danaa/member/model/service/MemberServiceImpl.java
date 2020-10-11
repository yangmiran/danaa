package com.kh.danaa.member.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.danaa.member.model.dao.MemberDao;
import com.kh.danaa.member.model.vo.Member;
import com.kh.danaa.member.model.vo.MemberPage;
@Service("memberService")
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao memberDao;
	
	@Override
	public Member selectLogin(Member member) {
		return memberDao.selectLogin(member);
	}

	@Override
	public int updateDelayChgPwd(String id) {		
		return memberDao.updateDelayChgPwd(id);
	}

	@Override
	public int updatePwd(Member member) {
		return memberDao.updatePwd(member);
	}

	@Override
	public int selectCkPwd(Member member) {
		return memberDao.selectCkPwd(member);
	}

	@Override
	public int selectIdCheck(String id) {	
		return memberDao.selectIdCheck(id);
	}

	@Override
	public int selectEmailCheck(String email) {		
		return memberDao.selectEmailCheck(email);
	}

	@Override
	public String selectMemberFid(Member member) {
		return memberDao.selectMemberFid(member);
	}

	@Override
	public ArrayList<Member> selectMemberList(MemberPage mPage) {
		return memberDao.selectMemberList(mPage);
	}

	@Override
	public ArrayList<Member> selectSearchid(String keyword) {
		return memberDao.selectSearchid(keyword);
	}

	@Override
	public ArrayList<Member> selectSearchName(String keyword) {
		return memberDao.selectSearchName(keyword);
	}

	@Override
	public ArrayList<Member> selectSearchGender(String keyword) {
		return memberDao.selectSearchGender(keyword);
	}

	@Override
	public ArrayList<Member> selectSearchAge(int keyword) {
		return memberDao.selectSearchAge(keyword);
	}

	@Override
	public int selectMemberGetListCount() {
		return memberDao.selectMemberGetListCount();
	}

	@Override
	public int selectGetListCountId(String keyword) {
		return memberDao.selectGetListCountId(keyword);
	}

	@Override
	public int selectGetListCountName(String keyword) {
		return memberDao.selectGetListCountName(keyword);
	}

	@Override
	public int selectGetListCountGen(String keyword) {
		return memberDao.selectGetListCountGen(keyword);
	}

	@Override
	public int selectGetListCountAge(int keyword) {
		return memberDao.selectGetListCountAge(keyword);
	}

	@Override
	public int deleteMemberAd(String id) {
		return memberDao.deleteMemberAd(id);
	}

	@Override
	public Member selectChkMember(Member member) {
		return memberDao.selectChkMember(member);
	}

	@Override
	public int updateTempPwd(Member chkmember) {
		return memberDao.updateTempPwd(chkmember);
	}

	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	public Member selectProMember(String phone) {
		return memberDao.selectProMember(phone);
	}

	@Override
	public Member selectChkSns(String checkid) {
		return memberDao.selectChkSns(checkid);
	}

	@Override
	public int selectChkPhone(String phone) {
		return memberDao.selectChkPhone(phone);
	}

	@Override
	public int updateEmailag1(Member member) {
		return memberDao.updateEmailag1(member);
	}

	@Override
	public int updateEmailag2(Member member) {
		return memberDao.updateEmailag2(member);
	}

	@Override
	public int updateMemInfo(Member member) {
		return memberDao.updateMemInfo(member);
	}

	@Override
	public Member selectOneMem(String id) {
		return memberDao.selectOneMem(id);
	}

	@Override
	public int selectMemberCount() {
		return memberDao.selectMemberCount();
	}

	@Override
	public String selectMemberFid2(Member member) {
		return memberDao.selectMemberFid2(member);
	}

	@Override
	public int selectChkMem(Member member) {
		return memberDao.selectChkMem(member);
	}


	
	
}
