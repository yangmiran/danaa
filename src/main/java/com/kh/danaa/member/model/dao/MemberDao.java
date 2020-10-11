package com.kh.danaa.member.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.danaa.member.model.vo.Member;
import com.kh.danaa.member.model.vo.MemberPage;

@Repository("memberDao")
public class MemberDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public MemberDao() {}
	
	public Member selectLogin(Member member) {
		return session.selectOne("memberMapper.selectLogin", member);
	}

	public int updateDelayChgPwd(String id) {		
		return session.update("memberMapper.updateDelayChgPwd", id);
	}

	public int updatePwd(Member member) {
		return session.update("memberMapper.updatePwd", member);
	}

	public int selectCkPwd(Member member) {
		return session.selectOne("memberMapper.selectCkPwd", member);
	}

	public int selectIdCheck(String id) {		
		return session.selectOne("memberMapper.selectIdCheck",id);
	}

	public int selectEmailCheck(String email) {		
		return session.selectOne("memberMapper.selectEmailCheck", email);
	}

	public String selectMemberFid(Member member) {	
		return session.selectOne("memberMapper.selectMemberFid", member);
	}

	public ArrayList<Member> selectMemberList(MemberPage mPage) {
		List<Member> list= session.selectList("memberMapper.selectMemberList",mPage);
		return (ArrayList<Member>)list;
	}

	public ArrayList<Member> selectSearchid(String keyword) {
		List<Member> list= session.selectList("memberMapper.selectSearchid",keyword);
		return (ArrayList<Member>)list;
	}

	public ArrayList<Member> selectSearchName(String keyword) {
		List<Member> list= session.selectList("memberMapper.selectSearchName",keyword);
		return (ArrayList<Member>)list;
	}

	public ArrayList<Member> selectSearchGender(String keyword) {
		List<Member> list= session.selectList("memberMapper.selectSearchGender",keyword);
		return (ArrayList<Member>)list;
	}

	public ArrayList<Member> selectSearchAge(int keyword) {
		List<Member> list= session.selectList("memberMapper.selectSearchAge",keyword);
		return (ArrayList<Member>)list;
	}

	public int selectMemberGetListCount() {
		return session.selectOne("memberMapper.selectMemberGetListCount");
	}

	public int selectGetListCountId(String keyword) {
		return session.selectOne("memberMapper.selectGetListCountId",keyword);
	}

	public int selectGetListCountName(String keyword) {
		return session.selectOne("memberMapper.selectGetListCountName",keyword);
	}

	public int selectGetListCountGen(String keyword) {
		return session.selectOne("memberMapper.selectGetListCountGen",keyword);
	}

	public int selectGetListCountAge(int keyword) {
		return session.selectOne("memberMapper.selectGetListCountAge",keyword);
	}

	public int deleteMemberAd(String id) {
		return session.delete("memberMapper.deleteMemberAd", id);
	}

	public Member selectChkMember(Member member) {
		return session.selectOne("memberMapper.selectChkMember", member);
	}

	public int updateTempPwd(Member chkmember) {
		return session.update("memberMapper.updateTempPwd", chkmember);
	}

	public int insertMember(Member member) {
		return session.insert("memberMapper.insertMember", member);
	}

	public Member selectProMember(String phone) {
		return session.selectOne("memberMapper.selectProMember", phone);
	}

	public Member selectChkSns(String checkid) {
		return session.selectOne("memberMapper.selectChkSns", checkid);
	}

	public int selectChkPhone(String phone) {
		return session.selectOne("memberMapper.selectChkPhone", phone);
	}

	public int updateEmailag1(Member member) {
		return session.update("memberMapper.updateEmailag1", member);
	}

	public int updateEmailag2(Member member) {
		return session.update("memberMapper.updateEmailag2", member);
	}

	public int updateMemInfo(Member member) {
		return session.update("memberMapper.updateMemInfo", member);
	}

	public Member selectOneMem(String id) {
		return session.selectOne("memberMapper.selectOneMem", id);
	}

	public int selectMemberCount() {
		return session.selectOne("memberMapper.selectMemberCount");
	}

	public String selectMemberFid2(Member member) {
		return session.selectOne("memberMapper.selectMemberFid2", member);
	}

	public int selectChkMem(Member member) {
		return session.selectOne("memberMapper.selectChkMem", member);
	}

	
}
