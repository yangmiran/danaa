package com.kh.danaa.qna.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.danaa.qna.model.service.QnaService;
import com.kh.danaa.qna.model.vo.Qna;

@Controller
public class QnaController {

	@Autowired
	private QnaService qnaService;

	// =========================== 페이지이동.s ===========================
	// 원글 작성폼으로 이동
	@RequestMapping("moveQwrite.do")
	public String moveWriteForm() {
		return "qna/qnaWriteForm";
	}

	// 답글 작성폼으로 이동
	@RequestMapping("moveReply.do")
	public String moveRelyWrite(Qna qna, @RequestParam("currentPage") int currentPage, Model model) {
		qna = qnaService.selectOneQna(qna.getQna_no());
		model.addAttribute("qna", qna);
		model.addAttribute("currentPage", currentPage);
		return "qna/replyWriteForm";
	}
		
	// 원글 비밀번호 체크로 이동
	@RequestMapping("movePwdCheck.do")
	public String movePwdCheck(@RequestParam("qna_no") int qna_no, Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {
		model.addAttribute("qna_no", qna_no);
		model.addAttribute("currentPage", currentPage);
		return "qna/pwdCheckView";
	}

	// 답글 비밀번호 체크로 이동
	@RequestMapping("moveReplyPwd.do")
	public String moveReplyPwd(@RequestParam("qna_no") int qna_no, Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {
		model.addAttribute("qna_no", qna_no);
		model.addAttribute("currentPage", currentPage);
		return "qna/replyPwdView";
	}

	// 원글 수정페이지 이동
	@RequestMapping("qUpView.do")
	public String qnaUpdateView(@RequestParam("currentPage") int currentPage, @RequestParam("qna_no") int qna_no,
			Model model) {
		Qna qna = qnaService.selectOneQna(qna_no);

		if (qna.getQna_no() != 0) {
			model.addAttribute("qna", qna);
			model.addAttribute("currentPage", currentPage); 
				return "qna/qnaUpdateView"; 
		} else {
			model.addAttribute("message", qna_no + "번 게시글 수정페이지 이동 실패");
			return "common/error";
		}
	}

	// 답글 수정 페이지 이동
	@RequestMapping("qrUpdate.do")
	public String replyUpdateView(@RequestParam("currentPage") int currentPage, @RequestParam("qna_no") int qna_no,
			Model model) {
		Qna qna = qnaService.selectOneQna(qna_no);

		if (qna.getQna_no() != 0) {
			model.addAttribute("qna", qna);
			model.addAttribute("currentPage", currentPage); 
				return "qna/replyUpdateView"; 
		} else {
			model.addAttribute("message", qna_no + "번 게시글 수정페이지 이동 실패");
			return "common/error";
		}
	}
	

	// =========================== 페이지이동.e ===========================

	// 리스트출력
	@RequestMapping("qlist.do")
	public ModelAndView qnaList(@RequestParam("page") int currentPage, ModelAndView mv) {
		// 한페이지에서 출력될 목록 갯수
		int limit = 10;

		// 전체 목록 갯수
		int listCount = qnaService.selectListCount();

		// 현재 페이지에 출력할 게시글 목록
		ArrayList<Qna> list = qnaService.selectListQna(currentPage, limit);

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
			mv.setViewName("qna/qnaListView");
		} else {
			mv.addObject("message", currentPage + "페이지에 대한 목록 조회 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 문의글 등록
	@RequestMapping(value = "qinsert.do", method = RequestMethod.POST)
	public String qnaOriginInsert(Qna qna, HttpServletRequest request,
			@RequestParam(name = "ofile", required = false) MultipartFile file) {
		// 저장할 폴더를 지정해야해서 request 사용한다
		String fileName = file.getOriginalFilename();

		String savePath = request.getSession().getServletContext().getRealPath("/resources/qupfiles");
		
		// 업로드된 파일이 있다면
		if (file != null) {
			// 바꿀 파일명에 대한 포맷문자열 만들기 : 년월일시분초 형식으로 지정
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); // java.text.SimpleDateFormat

			// 바꿀파일명 만들기 // 현재 시스템 시간의 long형 정수
			// 업로드된 파일의 확장자를 추출해서, 새 파일명 뒤에 붙여줌
			String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())); // 파일명
			renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1); // 원래 파일명 . 뒤에서부터 추출해라

			qna.setQna_file(fileName);
			qna.setQna_refile(renameFileName);

			// 업로드된 파일을 지정한 폴더로 옮기는 작업
			try {
				file.transferTo(new File(savePath + "\\" + renameFileName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		} // 업로드 if
		
		
		if (qnaService.insertOriginQna(qna) > 0) {
			return "redirect:/qlist.do?page=1";
		} else {
			request.setAttribute("message", "새 문의글 등록 실패");
			return "common/error";
		}
	}

	// 원글 비밀번호 확인 메소드
	@RequestMapping("pwdCheck.do")
	public String selectPwdCheck(@RequestParam("qna_no") int qna_no, HttpServletResponse response, Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage, @RequestParam("checkpwd") int checkpwd, Qna qna) {
		// 확인 할 글 선택
		qna = qnaService.selectOneQna(qna_no);
		
		String url= "";
		
		if (qna.getQna_pwd() == checkpwd) {
			
			model.addAttribute("qna_no", qna_no);
			model.addAttribute("currentPage", currentPage);
			url= "redirect:/qdetail.do";
		} else {
			model.addAttribute("message", "비밀번호가 틀렸습니다");
			model.addAttribute("url", "/movePwdCheck.do?qna_no="+qna_no+"&currentPage="+currentPage);
			url="common/alert";
		}
		return url;
	}

	// 댓글 비밀번호 확인 메소드
	@RequestMapping("rPwdCheck.do")
	public String selectReplyPwd(@RequestParam("qna_no") int qna_no, HttpServletResponse response, Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage, @RequestParam("checkpwd") int checkpwd, Qna qna) {
		// 확인 할 글 선택
		qna = qnaService.selectOneQna(qna_no);
		String url = "";
		if (qna.getQna_pwd() == checkpwd) {
			model.addAttribute("qna_no", qna_no);
			model.addAttribute("currentPage", currentPage);
			
			url= "redirect:/qrdetail.do";
		} else {
			model.addAttribute("message", "비밀번호가 틀렸습니다");
			model.addAttribute("url", "/movePwdCheck.do?qna_no="+qna_no+"&currentPage="+currentPage);
			url="common/alert";
		}
		return url;
	}

	// 원글 상세보기
	@RequestMapping("qdetail.do")
	public ModelAndView moveDetail(@RequestParam("qna_no") int qna_no, @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			ModelAndView mv) {

		Qna qna = qnaService.selectOneQna(qna_no);
		
		int refcount = qnaService.selectRefCount(qna_no);

		if (qna != null) {
			mv.addObject("qna", qna);
			mv.addObject("currentPage", currentPage);
			mv.addObject("refcount", refcount);
			mv.setViewName("qna/qnaDetailView");
		} else {
			mv.addObject("message", qna_no + "번 글 상세보기 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 답글 상세보기
	@RequestMapping("qrdetail.do")
	public ModelAndView moveReplyDetail(@RequestParam("qna_no") int qna_no,
			@RequestParam("currentPage") int currentPage, ModelAndView mv) {

		Qna qna = qnaService.selectOneQna(qna_no);

		if (qna != null) {
			mv.addObject("qna", qna);
			mv.addObject("currentPage", currentPage);
			mv.setViewName("qna/replyDetailView");
		} else {
			mv.addObject("message", qna_no + "번 글 상세보기 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 원글 답글 삭제
	@RequestMapping(value = "qdelete.do")
	public String qnaDelete(Qna qna, HttpServletRequest request,
			@RequestParam(name = "currentPage", required = false) String currentPage) {

		String returnview;
		qna.setQna_no(qna.getQna_no());
		qna.setQna_refile(qna.getQna_refile());

		if (qnaService.deleteQna(qna) > 0) {
			if (qna.getQna_refile() != null) {
				String savePath = request.getSession().getServletContext().getRealPath("resources/qupfiles");
				new File(savePath + "\\" + qna.getQna_refile()).delete();
			}
			if (currentPage != null) {
				returnview = "redirect:/qlist.do?page=" + currentPage;
			}
			returnview = "redirect:/qlist.do?page=1";
		} else {
			request.setAttribute("message", qna.getQna_no() + " 번 글 삭제 실패");
			returnview = "common/error";
		}
		return returnview;
	}

	// 게시글 원글 수정하기
	@RequestMapping(value = "qUpdate.do", method = RequestMethod.POST)
	public ModelAndView qnaOriginUpdate(Qna qna, HttpServletRequest request, ModelAndView mv,
			@RequestParam("page") int page, @RequestParam("ofile") String originalFileName,
			@RequestParam("rfile") String renameFileName,
			@RequestParam(name = "delflag", required = false) String deleteFlag,
			@RequestParam(name = "upfile", required = false) MultipartFile file) throws IOException {
		// 업로드되는 파일의 저장 폴더 지정하기 //db에는 저장된 파일명으로만 기록되고 파일은web에 기록됨
		String savePath = request.getSession().getServletContext().getRealPath("resources/qupfiles");

		// 첨부파일 이름 바꾸기
		String newRenameFileName = null;

		// 바꿀 파일명에 대한 포맷 문자열 만들기 : 년월일시분초 형식으로
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

		// 바꿀 파일명 만들기 // date()~return long형 정수
		newRenameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));

		// 원래 첨부파일이 있었고, 변경되지 않았을 때는 원래 꺼로 저장하겠다
		if (/*
			 * originalFileName != null &&
			 * originalFileName.equals(file.getOriginalFilename()) && new File(savePath +
			 * "//" + renameFileName).length() == new File(savePath + "\\" +
			 * newRenameFileName) .length() &&
			 */ deleteFlag == null && originalFileName != null && file.getOriginalFilename() == "") {

			qna.setQna_file(originalFileName);
			qna.setQna_refile(renameFileName);

		} else if (file.getOriginalFilename() != "") { // 수정한 글에 첨부파일이 있다면

			// 업로드된 파일을 지정한 폴더로 옮기기
			try {
				file.transferTo(new File(savePath + "\\" + file.getOriginalFilename()));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// 서버에 새로 업로드된 파일명 저장
			qna.setQna_file(file.getOriginalFilename());

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

			qna.setQna_refile(newRenameFileName);

			if (originalFileName != null) {// 원래 첨부파일이 있었다면,// 원래 첨부파일을 폴더에서 삭제함
				new File(savePath + "\\" + renameFileName).delete();
			} // 업로드된 새 파일이 있다면

		} else if (originalFileName != null && deleteFlag != null && deleteFlag.equals("yes")) {
			// 원래 첨부파일이 있었고, 파일삭제가 선택된 경우
			qna.setQna_file(null);
			qna.setQna_refile(null);

			new File(savePath + "\\" + renameFileName).delete();

		}

		// DB 수정하러 가기
		if (qnaService.updateOrigin(qna) > 0) {
			mv.setViewName("redirect:/qlist.do?page=1");// 목록으로
		} else {
			mv.addObject("message", qna.getQna_no() + "번 공지사항 수정 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
			
	// 게시글 답글 수정하기
	@RequestMapping(value = "replyUpdate.do", method = RequestMethod.POST)
	public String qnaReplyUpdate(Qna qna, Model model, @RequestParam("currentPage") int currentPage) {
		qna.setQna_no(qna.getQna_no());
		qna.setQna_content(qna.getQna_content());
		qna.setQna_title(qna.getQna_title());
		qna.setQna_name(qna.getQna_name());
		qna.setQna_phone(qna.getQna_phone());
		qna.setQna_kinds(qna.getQna_kinds());
		qna.setQna_pwd(qna.getQna_pwd());
		qna.setQna_ref(qna.getQna_ref());

		if (qnaService.updateReply(qna) > 0) {
			model.addAttribute("qna", qna);
			model.addAttribute("currentPage", currentPage);

			return "redirect:/qlist.do?page=1";
		} else {
			model.addAttribute("message", "댓글 수정 실패");
			return "common/error";
		}

	}
	 
	
	// 답글 등록
	@RequestMapping(value = "qrinsert.do", method = RequestMethod.POST)
	public String insertReply(Qna qna, Model model, @RequestParam("currentPage") int currentPage,
			@RequestParam("qna_no") int qna_no) {

		Qna selectQna = qnaService.selectOneQna(qna_no);

		Qna reply = new Qna();
		reply.setQna_content(qna.getQna_content());
		reply.setQna_title(qna.getQna_title());
		reply.setQna_name(qna.getQna_name());
		reply.setQna_phone(qna.getQna_phone());
		reply.setQna_kinds(qna.getQna_kinds());
		reply.setQna_pwd(qna.getQna_pwd());
		reply.setQna_level(selectQna.getQna_level() + 1);
		reply.setQna_ref(selectQna.getQna_ref());

		if (qnaService.insertReplyQna(reply) > 0) {
			model.addAttribute("qna", reply);
			return "redirect:/qlist.do?page=" + currentPage;
		} else {
			model.addAttribute("message", "댓글 작성 실패");
			return "common/error";
		}

	}
	
	// 게시글 검색
		@RequestMapping("qsearch.do")
		public String qnaSearch(@RequestParam("keyword") String keyword, Model model) {

			ArrayList<Qna> list = qnaService.selectSearch(keyword);

			model.addAttribute("list", list);

			return "qna/qnaSearchView";
		}
		
		
		//리캡챠
		@ResponseBody
	    @RequestMapping(value = "VerifyRecaptcha.do", method = RequestMethod.POST)
	    public int VerifyRecaptcha(HttpServletRequest request) {
	        com.kh.danaa.VerifyRecaptcha.setSecretKey("6LeFfs0ZAAAAAIZCwl5-S20Um2e3AgioTD4ob0q2");
	        String gRecaptchaResponse = request.getParameter("recaptcha");
	        System.out.println(gRecaptchaResponse);
	        //0 = 성공, 1 = 실패, -1 = 오류
	        try {
	            if(com.kh.danaa.VerifyRecaptcha.verify(gRecaptchaResponse))
	                return 0;
	            else return 1;
	        } catch (IOException e) {
	            e.printStackTrace();
	            return -1;
	        }
	    }


}
