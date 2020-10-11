package com.kh.danaa.member.model.service;

import java.util.ArrayList;

import com.kh.danaa.member.model.vo.Member;
import com.kh.danaa.member.model.vo.MemberPage;

public interface MemberService {
	public int selectChkPhone(String phone);

	public Member selectLogin(Member member);

	public int updateDelayChgPwd(String id);

	public int updatePwd(Member member);

	public int selectCkPwd(Member member);

	public int selectIdCheck(String id);

	public int selectEmailCheck(String email);

	public String selectMemberFid(Member member);

	public ArrayList<Member> selectMemberList(MemberPage mPage);

	public ArrayList<Member> selectSearchid(String keyword);

	public ArrayList<Member> selectSearchName(String keyword);

	public ArrayList<Member> selectSearchGender(String keyword);

	public ArrayList<Member> selectSearchAge(int keyword);

	public int selectMemberGetListCount();

	public int selectGetListCountId(String keyword);

	public int selectGetListCountName(String keyword);

	public int selectGetListCountGen(String keyword);

	public int selectGetListCountAge(int keyword);

	public int deleteMemberAd(String id);

	public Member selectChkMember(Member member);

	public int updateTempPwd(Member chkmember);

	public int insertMember(Member member);

	public Member selectProMember(String phone);

	public Member selectChkSns(String checkid);

	public int updateEmailag1(Member member);

	public int updateEmailag2(Member member);

	public int updateMemInfo(Member member);

	public Member selectOneMem(String id);

	public int selectMemberCount();

	public String selectMemberFid2(Member member);

	public int selectChkMem(Member member);

	

	

	
}
