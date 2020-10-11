package com.kh.danaa.notice.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.danaa.notice.model.service.NoticeService;
import com.kh.danaa.notice.model.vo.Notice;

@Controller
public class NoticeController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
	// =========================== 페이지이동.s ===========================
	// 원글 작성폼으로 이동
	@RequestMapping("moveNwrite.do")
	public String moveNoticeWrite() {
		return "notice/noticeWriteForm";
	}
	// 원글 수정페이지 이동
		@RequestMapping("nUpView.do")
		public String noticeUpdateView(@RequestParam("currentPage") int currentPage, Notice notice,
				Model model) {
			notice = noticeService.selectNotice(notice.getNotice_no());

			if (notice.getNotice_no() != 0) {
				model.addAttribute("notice", notice);
				model.addAttribute("currentPage", currentPage); 
					return "notice/noticeUpdateView"; 
			} else {
				model.addAttribute("message", notice.getNotice_no() + "번 게시글 수정페이지 이동 실패");
				return "common/error";
			}
		}
	// =========================== 페이지이동.e ===========================
	
		// 리스트출력
		@RequestMapping("nlist.do")
		public ModelAndView noticeList(@RequestParam("page") int currentPage, ModelAndView mv) {
			// 한페이지에서 출력될 목록 갯수
			int limit = 10;

			// 전체 목록 갯수
			int listCount = noticeService.selectListCount();

			// 현재 페이지에 출력할 게시글 목록
			ArrayList<Notice> list = noticeService.selectListNotice(currentPage, limit);

			// 뷰에 출력될 총 페이지 수 계산식
			int maxPage = (int) (((double) listCount / limit) + 0.9);

			// 현재 페이지가 속한 그룹의 시작페이지 수 지정
			int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;
			int endPage = startPage + limit - 1;

			if (maxPage < endPage) {
				endPage = maxPage;
			}
			// 내보내기
			if (list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("currentPage", currentPage);
				mv.addObject("maxPage", maxPage);
				mv.addObject("startPage", startPage);
				mv.addObject("endPage", endPage);
				mv.addObject("listCount", listCount);
				mv.setViewName("notice/noticeListView");
			} else {
				mv.addObject("message", currentPage + "페이지에 대한 목록 조회 실패!");
				mv.setViewName("common/error");
			}
			return mv;
		}
		
		// 게시글 등록
		@RequestMapping(value = "ninsert.do", method = RequestMethod.POST)
		public String noticeOriginInsert(Notice notice, HttpServletRequest request,
				@RequestParam(name = "ofile", required = false) MultipartFile file, Model model) {
			// 저장할 폴더를 지정해야해서 request 사용한다
			
			String fileName = file.getOriginalFilename();

			String savePath = request.getSession().getServletContext().getRealPath("/resources/nupfiles");
						
			// 업로드된 파일이 있다면
			if (file != null) {
				// 바꿀 파일명에 대한 포맷문자열 만들기 : 년월일시분초 형식으로 지정
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); // java.text.SimpleDateFormat

				// 바꿀파일명 만들기 // 현재 시스템 시간의 long형 정수
				// 업로드된 파일의 확장자를 추출해서, 새 파일명 뒤에 붙여줌
				String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())); // 파일명
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1); // 원래 파일명 . 뒤에서부터 추출해라

				notice.setNotice_file(fileName);
				notice.setNotice_refile(renameFileName);
			
				// 업로드된 파일을 지정한 폴더로 옮기는 작업
				try {
					file.transferTo(new File(savePath + "\\" + renameFileName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
			
			if (noticeService.insertNotice(notice) > 0) {
				return "redirect:/nlist.do?page=1";
			} else {
			model.addAttribute("message", "새 공지글 등록 실패");
				return "common/error";
			}
			
		}
		
	// 상세보기 (이전글, 현재글, 다음글 상세보기 처리)
	@RequestMapping("ndetail.do")
	public ModelAndView moveNoticeDetail(@RequestParam("notice_no") int notice_no, 
			@RequestParam(value="currentPage", required = false, defaultValue="1") int currentPage, ModelAndView mv) {
		// 조회수 1증가
		noticeService.updateReadCount(notice_no);

		// 게시글 상세보기
		//Notice notice = noticeService.selectNotice(notice_no);
		ArrayList<Notice> detailList = noticeService.selectDetail(notice_no);
		
		if(detailList.size() == 3) { //이전글, 현재글, 다음글 있는경우
			mv.addObject("notice", detailList.get(1));
			mv.addObject("prevNotice", detailList.get(0));
			mv.addObject("nextNotice", detailList.get(2));
			mv.addObject("currentPage", currentPage);
			mv.setViewName("notice/noticeDetailView");
		} else if (detailList.size() == 2) {
			if(detailList.get(0).getNotice_no() < notice_no) {
				mv.addObject("notice", detailList.get(1));
				mv.addObject("prevNotice", detailList.get(0));
			}
			if(detailList.get(0).getNotice_no() == notice_no) {
				mv.addObject("notice", detailList.get(0));
				mv.addObject("nextNotice", detailList.get(1));
			}
			mv.addObject("currentPage", currentPage);
			mv.setViewName("notice/noticeDetailView");
		}else {
			mv.addObject("message", "미앤란 소식 상세보기 실패");
			mv.setViewName("common/error");
		}
		return mv;

	}
	
	// 공지글 삭제
	@RequestMapping("ndelete.do")
	public String noticeDelete(Notice notice, HttpServletRequest request,
			@RequestParam(name = "currentPage", required = false) String currentPage) {
		
		String returnview;
		
		if (noticeService.deleteNotice(notice) > 0) {
			if (notice.getNotice_refile() != null) {
				String savePath = request.getSession().getServletContext().getRealPath("resources/nupfiles");
				new File(savePath + "\\" + notice.getNotice_refile()).delete();
			}
			if (currentPage != null) {
				returnview = "redirect:/nlist.do?page=" + currentPage;
			}
			returnview = "redirect:/nlist.do?page=1";
		} else {
			request.setAttribute("message", notice.getNotice_no() + " 번 글 삭제 실패");
			returnview = "common/error";
		}
		return returnview;
	}
	
	// 공지글 수정
	@RequestMapping(value = "nupdete.do", method = RequestMethod.POST)
	public ModelAndView noticeUpdate(Notice notice, HttpServletRequest request, ModelAndView mv,
			@RequestParam(name="page", required = false) int page, @RequestParam("ofile") String originalFileName,
			@RequestParam("rfile") String renameFileName,
			@RequestParam(name = "delflag", required = false) String deleteFlag,
			@RequestParam(name = "upfile", required = false) MultipartFile file) throws IOException {
		// 업로드되는 파일의 저장 폴더 지정하기 //db에는 저장된 파일명으로만 기록되고 파일은web에 기록됨
		String savePath = request.getSession().getServletContext().getRealPath("resources/nupfiles");

		// 첨부파일 이름 바꾸기
		String newRenameFileName = null;

		// 바꿀 파일명에 대한 포맷 문자열 만들기 : 년월일시분초 형식으로
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

		// 바꿀 파일명 만들기 // date()~return long형 정수
		newRenameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));
		logger.info(originalFileName);
		logger.info(file.getOriginalFilename());
		// 원래 첨부파일이 있었고, 변경되지 않았을 때는 원래 꺼로 저장하겠다
		if (/*
			 * originalFileName != null &&
			 * originalFileName.equals(file.getOriginalFilename()) && new File(savePath +
			 * "//" + renameFileName).length() == new File(savePath + "\\" +
			 * newRenameFileName) .length() &&
			 */ deleteFlag == null && originalFileName != null && file.getOriginalFilename() == "") {

			notice.setNotice_file(originalFileName);
			notice.setNotice_refile(renameFileName);

		} else if (file.getOriginalFilename() != "") { // 수정한 글에 첨부파일이 있다면

			// 업로드된 파일을 지정한 폴더로 옮기기
			try {
				file.transferTo(new File(savePath + "\\" + file.getOriginalFilename()));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}

			// 서버에 새로 업로드된 파일명 저장
			notice.setNotice_file(file.getOriginalFilename());

			// 원래 파일과 새로 업로드된 파일의 이름이 같고 파일 용량도 동일하면 원래 이름 그대로 객체에 기록함
			// 첨부파일이 없었는데 추가된 경우와 첨부파일이 있었는데 변경된 경우 둘 다 파일명 바꾸기함
			// 첨부된 파일의 파일명 바꾸기 (추가적 작업) 저장 폴더에 같은 이름의 파일이 있을 경우를 대비하기 위함.
			// 불러올때는 원래이름, 저장할때는 업로드 시간으로 함 /"년월일시분초.확장자" 형식으로 변경해 봄

			// 업로드된 파일의 확장자를 추출해서, 새 파일명에 붙여줌
			newRenameFileName += "."
					+ file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);

			// 원본 파일명 rename 처리를 위해서 File 객체 만들기
			File originFile = new File(savePath + "\\" + file.getOriginalFilename());
			File renameFile = new File(savePath + "\\" + newRenameFileName);

			// 이름 바꾸기 실행함
			if (!originFile.renameTo(renameFile)) {
				// renameTo()메소드가 실패(false)한 경우에 직접 바꾸기함
				// 원본 파일 내용 읽어서, 복사본에 기록하고
				// 완료되면, 원본 파일 삭제함

				FileInputStream fin = new FileInputStream(originFile);
				FileOutputStream fout = new FileOutputStream(renameFile);

				int data = -1;

				byte[] buffer = new byte[1024]; // 배열로 읽기
				while ((data = fin.read(buffer, 0, buffer.length)) != -1) {
					fout.write(buffer, 0, buffer.length);
				}
				fin.close();
				fout.close();
				originFile.delete(); // 원본파일 삭제

			} // 직접이름 바꾸기

			notice.setNotice_refile(newRenameFileName);

			if (originalFileName != null) {// 원래 첨부파일이 있었다면,// 원래 첨부파일을 폴더에서 삭제함
				new File(savePath + "\\" + renameFileName).delete();
			} // 업로드된 새 파일이 있다면

		} else if (originalFileName != null && deleteFlag != null && deleteFlag.equals("yes")) {
			// 원래 첨부파일이 있었고, 파일삭제가 선택된 경우
			notice.setNotice_file(null);
			notice.setNotice_refile(null);

			new File(savePath + "\\" + renameFileName).delete();

		}

		// DB 수정하러 가기
		if (noticeService.updateNotice(notice) > 0) {
			mv.setViewName("redirect:/nlist.do?page=1");// 목록으로
		} else {
			mv.addObject("message", notice.getNotice_no() + "번 공지사항 수정 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	
	// 게시글 검색
	@RequestMapping("nsearch.do")
	public String noticeSerch(@RequestParam("keyword") String keyword, Model model) {
		
		ArrayList<Notice> list = noticeService.selectSearch(keyword);
		
		model.addAttribute("list", list);
		
		return "notice/noticeSearchView";
	}
	
	//메인 공지글 5개 출력
		@RequestMapping(value="ntop5.do", method=RequestMethod.POST)
		@ResponseBody
		public String noticeNewTop5(HttpServletResponse response) throws UnsupportedEncodingException {
			
			ArrayList<Notice> list = noticeService.selectNewTop5();
			
			//전송용 json 객체 준비
			JSONObject sendJson = new JSONObject();
			//json 배열 객체 생성
			JSONArray jarr = new JSONArray();
			
			for(Notice notice : list) {
				//user 객체 저장용 json 객체 생성
				JSONObject job = new JSONObject();
				
				job.put("notice_no", notice.getNotice_no());
				job.put("notice_title", URLEncoder.encode(notice.getNotice_title(), "utf-8"));
				job.put("notice_date", notice.getNotice_date().toString());
				
				//jarr 에 json 객체 저장
				jarr.add(job);
			}
			
			sendJson.put("list", jarr);
			
			return sendJson.toJSONString(); //jsonView 로 리턴됨.
		}
}


















