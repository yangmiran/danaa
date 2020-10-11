package com.kh.danaa.reservation.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.danaa.doctor.model.vo.Doctor;
import com.kh.danaa.reservation.model.vo.Askform;
import com.kh.danaa.reservation.model.vo.Reservation;
import com.kh.danaa.reservation.model.vo.ReservationPage;

@Repository("reservationDao")
public class ReservationDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public ReservationDao() {}	
	
	public Reservation selectReservation(int res_no) {
		return session.selectOne("reservationMapper.selectReservation", res_no);
	}
	
	public Askform selectAskform(int res_no) {
		return session.selectOne("reservationMapper.selectAskform", res_no);
	}
	
	public int selectListCount() {
		return session.selectOne("reservationMapper.getListCount");
	}
	
	public Reservation selectForaskform(Reservation reservation) {
		return session.selectOne("reservationMapper.forAskform", reservation);
	}
	
	public int selectReserved(Reservation reservation) {
		return session.selectOne("reservationMapper.getReserved", reservation);
	}
	
	public ArrayList<Reservation> selectAllList(int currentPage, int limit) {
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		ReservationPage rpage = new ReservationPage(startRow, endRow);
		List<Reservation> list = session.selectList("reservationMapper.selectAllList", rpage);
		return (ArrayList<Reservation>)list;
	}
	
	public ArrayList<Reservation> selectMyList(String member_id) {
		List<Reservation> list = session.selectList("reservationMapper.selectMyList", member_id);
		return (ArrayList<Reservation>)list;
	}
	
	public ArrayList<Reservation> selectNonmemList(Reservation reservation) {
		List<Reservation> list = session.selectList("reservationMapper.selectNonmemList", reservation);
		return (ArrayList<Reservation>)list;
	}
	
	public int insertMemReservation(Reservation reservation) {
		return session.insert("reservationMapper.insertMemReservation", reservation);
	}
	
	public int insertNonmemReservation(Reservation reservation) {
		return session.insert("reservationMapper.insertNonmemReservation", reservation);
	}
	
	public int insertAskform(Askform askform) {
		return session.insert("reservationMapper.insertAskform", askform);
	}
	
	public int updateResConfirm(int res_no) {
		return session.update("reservationMapper.confirmReservation", res_no);
	}
	
	public int updateResComplete(int res_no) {
		return session.update("reservationMapper.completeReservation", res_no);
	}
	
	public int updateResCancel(int res_no) {
		return session.update("reservationMapper.cancelReservation", res_no);
	}

	public int selectNonmemListCount(Reservation reservation) {
		return session.selectOne("reservationMapper.getNonmemListCount", reservation);
	}

	public int selectMyListCount(String member_id) {
		return session.selectOne("reservationMapper.getMyListCount", member_id);
	}

	public int selectCancelOk(int res_no) {
		return session.selectOne("reservationMapper.getCancelOk", res_no);
	}

	public int selectDocListCount(int res_doctor) {
		return session.selectOne("reservationMapper.getDocListCount", res_doctor);
	}

	public int selectStatusListCount(int res_status) {
		return session.selectOne("reservationMapper.getStatusListCount", res_status);
	}

	public ArrayList<Reservation> selectResDoctor(int currentPage, int limit, int res_doctor) {
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		ReservationPage rpage = new ReservationPage(startRow, endRow, res_doctor);
		List<Reservation> list = session.selectList("reservationMapper.selectResDoctor", rpage);
		return (ArrayList<Reservation>)list;
	}

	public ArrayList<Reservation> selectResStatus(int currentPage, int limit, int res_status) {
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		ReservationPage rpage = new ReservationPage(startRow, endRow, res_status);
		List<Reservation> list = session.selectList("reservationMapper.selectResStatus", rpage);
		return (ArrayList<Reservation>)list;
	}

	public ArrayList<Doctor> selectDoctor() {
		List<Doctor> list = session.selectList("reservationMapper.selectDoctor");
		return (ArrayList<Doctor>)list;
	}

	public int insertAdReservation(Reservation reservation) {
		return session.insert("reservationMapper.insertAdReservation", reservation);
	}

	public int deleteAdReservation(int res_no) {
		return session.delete("reservationMapper.deleteReservation", res_no);
	}

	public ArrayList<Reservation> selectResAdmin(int currentPage, int limit) {
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		ReservationPage rpage = new ReservationPage(startRow, endRow);
		List<Reservation> list = session.selectList("reservationMapper.selectResAdmin", rpage);
		return (ArrayList<Reservation>)list;
	}
	
	public int selectAdListCount() {
		return session.selectOne("reservationMapper.getAdListCount");
	}

	public ArrayList<Reservation> selectCalList() {
		List<Reservation> list = session.selectList("reservationMapper.selectCalList");
		return (ArrayList<Reservation>)list;
	}

	public int updateResChange(Reservation reservation) {
		return session.update("reservationMapper.changeReservation", reservation);
	}

	public int selectResLee() {
		return session.selectOne("reservationMapper.getResLee");
	}

	public int selectResChae() {
		return session.selectOne("reservationMapper.getResChae");
	}

	public int selectResAhn() {
		return session.selectOne("reservationMapper.getResAhn");
	}

	public int selectNotYet() {
		return session.selectOne("reservationMapper.getNotYet");
	}	
	
}
