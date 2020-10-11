package com.kh.danaa.reservation.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.danaa.doctor.model.vo.Doctor;
import com.kh.danaa.reservation.model.dao.ReservationDao;
import com.kh.danaa.reservation.model.vo.Askform;
import com.kh.danaa.reservation.model.vo.Reservation;

@Service("reservationService")
public class ReservationServiceImpl implements ReservationService {
	
	@Autowired
	private ReservationDao reservationDao;

	@Override
	public Reservation selectReservation(int res_no) {
		return reservationDao.selectReservation(res_no);
	}

	@Override
	public Askform selectAskform(int res_no) {
		return reservationDao.selectAskform(res_no);
	}

	@Override
	public int selectListCount() {
		return reservationDao.selectListCount();		
	}
	
	@Override
	public Reservation selectForaskform(Reservation reservation) {
		return reservationDao.selectForaskform(reservation);
	}

	@Override
	public int selectReserved(Reservation reservation) {
		return reservationDao.selectReserved(reservation);
	}

	@Override
	public ArrayList<Reservation> selectAllList(int currentPage, int limit) {
		return reservationDao.selectAllList(currentPage, limit);
	}

	@Override
	public ArrayList<Reservation> selectMyList(String member_id) {
		return reservationDao.selectMyList(member_id);
	}

	@Override
	public ArrayList<Reservation> selectNonmemList(Reservation reservation) {
		return reservationDao.selectNonmemList(reservation);
	}

	@Override
	public int insertMemReservation(Reservation reservation) {
		return reservationDao.insertMemReservation(reservation);
	}

	@Override
	public int insertNonmemReservation(Reservation reservation) {
		return reservationDao.insertNonmemReservation(reservation);
	}

	@Override
	public int insertAskform(Askform askform) {
		return reservationDao.insertAskform(askform);
	}

	@Override
	public int updateResConfirm(int res_no) {
		return reservationDao.updateResConfirm(res_no);
	}

	@Override
	public int updateResComplete(int res_no) {
		return reservationDao.updateResComplete(res_no);
	}

	@Override
	public int updateResCancel(int res_no) {
		return reservationDao.updateResCancel(res_no);
	}

	@Override
	public int selectNonmemListCount(Reservation reservation) {
		return reservationDao.selectNonmemListCount(reservation);
	}

	@Override
	public int selectMyListCount(String member_id) {
		return reservationDao.selectMyListCount(member_id);
	}

	@Override
	public int selectCancelOk(int res_no) {
		return reservationDao.selectCancelOk(res_no);
	}

	@Override
	public int selectDocListCount(int res_doctor) {
		return reservationDao.selectDocListCount(res_doctor);
	}

	@Override
	public int selectStatusListCount(int res_status) {
		return reservationDao.selectStatusListCount(res_status);
	}

	@Override
	public ArrayList<Reservation> selectResDoctor(int currentPage, int limit, int res_doctor) {
		return reservationDao.selectResDoctor(currentPage, limit, res_doctor);
	}

	@Override
	public ArrayList<Reservation> selectResStatus(int currentPage, int limit, int res_status) {
		return reservationDao.selectResStatus(currentPage, limit, res_status);
	}

	@Override
	public ArrayList<Doctor> selectDoctor() {
		return reservationDao.selectDoctor();
	}

	@Override
	public int insertAdReservation(Reservation reservation) {
		return reservationDao.insertAdReservation(reservation);
	}

	@Override
	public int deleteAdReservation(int res_no) {
		return reservationDao.deleteAdReservation(res_no);
	}

	@Override
	public ArrayList<Reservation> selectResAdmin(int currentPage, int limit) {
		return reservationDao.selectResAdmin(currentPage, limit);
	}

	@Override
	public int selectAdListCount() {
		return reservationDao.selectAdListCount();
	}

	@Override
	public ArrayList<Reservation> selectCalList() {
		return reservationDao.selectCalList();
	}

	@Override
	public int updateResChange(Reservation reservation) {
		return reservationDao.updateResChange(reservation);
	}

	@Override
	public int selectResLee() {
		return reservationDao.selectResLee();
	}

	@Override
	public int selectResChae() {
		return reservationDao.selectResChae();
	}

	@Override
	public int selectResAhn() {
		return reservationDao.selectResAhn();
	}

	@Override
	public int selectNotYet() {
		return reservationDao.selectNotYet();
	}	


}
