package com.kh.danaa.reservation.model.service;

import java.util.ArrayList;

import com.kh.danaa.doctor.model.vo.Doctor;
import com.kh.danaa.reservation.model.vo.Askform;
import com.kh.danaa.reservation.model.vo.Reservation;


public interface ReservationService {
	Reservation selectReservation(int res_no);
	Askform selectAskform(int res_no);
	Reservation selectForaskform(Reservation reservation);
	int selectListCount();	
	int selectNonmemListCount(Reservation reservation);
	int selectMyListCount(String member_id);
	int selectReserved(Reservation reservation);
	ArrayList<Reservation> selectAllList(int currentPage, int limit);
	ArrayList<Reservation> selectMyList(String member_id);
	ArrayList<Reservation> selectNonmemList(Reservation reservation);
	int insertMemReservation(Reservation reservation);
	int insertNonmemReservation(Reservation reservation);
	int insertAskform(Askform askform);
	int updateResConfirm(int res_no);
	int updateResComplete(int res_no);
	int updateResCancel(int res_no);
	int selectCancelOk(int res_no);
	int selectDocListCount(int res_doctor);
	int selectStatusListCount(int res_status);
	int selectAdListCount();
	ArrayList<Reservation> selectResDoctor(int currentPage, int limit, int res_doctor);
	ArrayList<Reservation> selectResStatus(int currentPage, int limit, int res_status);
	ArrayList<Doctor> selectDoctor();
	int insertAdReservation(Reservation reservation);
	int deleteAdReservation(int res_no);
	ArrayList<Reservation> selectResAdmin(int currentPage, int limit);
	ArrayList<Reservation> selectCalList();
	int updateResChange(Reservation reservation);
	int selectResLee();
	int selectResChae();
	int selectResAhn();
	int selectNotYet();
}
