package com.kh.danaa.review.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.danaa.recomment.model.service.RecommentService;
import com.kh.danaa.recomment.model.vo.Recomment;
import com.kh.danaa.review.model.service.ReviewService;
import com.kh.danaa.review.model.vo.Review;

@Controller
public class ReviewController {
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private RecommentService recommentService;

	// 후기 게시판 목록보기
	@RequestMapping("rlist.do")
	public ModelAndView reviewListMethod(HttpServletRequest request, ModelAndView mv) {
	

		int currentPage = 1;

		if (request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}

		// 한페이지에서 출력할 갯수
		int limit = 6;

		// 전체 목록 갯수
		int listCount = reviewService.selectListCount();

		ArrayList<Review> list = reviewService.selectList(currentPage, limit);
		
		int maxPage = (int) ((double) listCount / limit + 0.9);

		int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;
		int endPage = startPage + limit - 1;
		
		if (maxPage < endPage) {
			endPage = maxPage;
		}

		if (list.size() > 0) {

			mv.addObject("list", list);
			mv.addObject("currentPage", currentPage);
			mv.addObject("maxPage", maxPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("listCount", listCount);

			mv.setViewName("review/reviewListView");
			
		} else {

			mv.addObject("message", "목록이 없습니다"); 
			mv.addObject("url", "/rlist.do?page=1");
			mv.setViewName("common/alert");
		}
		return mv;
	}

	// 후기 게시판 상세보기
	@RequestMapping("rdetail.do")
	public String selectOne(Model m, @RequestParam(value = "review_no", required = false) int review_no,
			@RequestParam(value = "page", required = false, defaultValue="1") int page) {
		
		reviewService.updateReadCount(review_no);
		
		// 이전글, 현재글, 다음글 3개 조회해 옴
		ArrayList<Review> detailList = reviewService.selectDetail(review_no);
		logger.info("detailList" + detailList.size());

		ArrayList<Recomment> list = recommentService.selectList(review_no);
		int currentPage = 1;

		if (page != 0) {
			currentPage = page;
		}
		if (detailList.size() == 3) {
			m.addAttribute("prevReview", detailList.get(0));
			m.addAttribute("review", detailList.get(1));
			m.addAttribute("nextReview", detailList.get(2));
			m.addAttribute("currentPage", currentPage);
			m.addAttribute("list", list);
			m.addAttribute("listsize", list.size());
			return "review/reviewDetailView";
		} else if (detailList.size() == 2) {
			if (detailList.get(0).getReview_no() == review_no) {
				m.addAttribute("review", detailList.get(0));
				m.addAttribute("nextReview", detailList.get(1));
				m.addAttribute("currentPage", currentPage);
				m.addAttribute("list", list);
				m.addAttribute("listsize", list.size());
				return "review/reviewDetailView";
			} else {
				m.addAttribute("prevReview", detailList.get(0));
				m.addAttribute("review", detailList.get(1));
				m.addAttribute("currentPage", currentPage);
				m.addAttribute("list", list);
				m.addAttribute("listsize", list.size());
				return "review/reviewDetailView";
			}
		} else {
			m.addAttribute("message", review_no + "번글 후기 상세보기 실패 !");
			return "common/error";
		}
	}

	// 작성페이지로 이동
	@RequestMapping("reviewWriteForm.do")
	public String moveReviewWriteForm() {
		return "review/reviewWriteForm";
	}

	// 후기글 작성
	@RequestMapping(value = "rinsert.do", method = RequestMethod.POST)
	public String insertOriginReview(Review review,
			@RequestParam(value = "ofile", required = false) MultipartFile ofile, HttpServletRequest request) {
		
		 
		if (ofile != null) {
			String originalFileName = ofile.getOriginalFilename();
			String savePath = request.getSession().getServletContext().getRealPath("resources/images");
			logger.info("originalFileName" + originalFileName);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));

			renameFileName += "." + originalFileName.substring(originalFileName.lastIndexOf(".") + 1);

			try {
				ofile.transferTo(new File(savePath + "\\" + renameFileName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			review.setReview_original_filename(originalFileName);
			review.setReview_rename_filename(renameFileName);
		} // ofile != null
		logger.info("review" + review.toString());
		if (reviewService.insertOriginReview(review) > 0) {
			return "redirect:rlist.do?page=1";
		} else {
			return "common/error";
		}
	}

	// 후기글 검색
	@RequestMapping(value = "rsearch.do", method = RequestMethod.POST)
	public String reviewSearch(HttpServletRequest request, Model model,
			@RequestParam(value = "", required = false) String keyword) {

		String action = request.getParameter("action");

		ArrayList<Review> list = null;
		switch (action) {
		case "title":
			list = reviewService.selectSearchtitle(keyword);
			break;
		case "content":
			list = reviewService.selectSearchcontent(keyword);
			break;
		}
		
		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "review/reviewSearchView";
		} else {
			model.addAttribute("message", action + "검색에 대한 결과가 존재하지 않습니다");
			return "common/error";
		}
	}

	// 게시글 삭제
	@RequestMapping(value = "rdelete.do", method = RequestMethod.GET)
	public String deleteReview(Review review) {

		reviewService.deleteReview(review);
		 return "redirect:rlist.do?page=1";

	}

	// 수정페이지로 이동
	@RequestMapping("reviewUpdateForm.do")
	public String moveReviewUpdateForm(@RequestParam(value = "review_no") int review_no, Model model) {
		logger.info("review_no" + review_no);
		Review review = reviewService.selectReview(review_no);

		logger.info("업데이트 view 값 : ", review);

		String url = "";
		if (review != null) {
			model.addAttribute("review", review);
			url = "review/reviewUpdateForm";
		} else {
			model.addAttribute("message", "수정게시글 이동 실패");
			url = "common/error";
		}
		return url;
	}

	// 게시글 수정
	@RequestMapping(value = "rupdate.do", method = RequestMethod.POST)
	public ModelAndView reviewupdate(Review review, HttpServletRequest request, ModelAndView mv,
			@RequestParam("ofile") String originalFileName, @RequestParam("rfile") String renameFileName,
			@RequestParam(name = "delflag", required = false) String deleteFlag,
			@RequestParam(name = "upfile", required = false) MultipartFile file) throws IOException {

		String savePath = request.getSession().getServletContext().getRealPath("/resources/images");

		String newRenameFileName = null;

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

		newRenameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));

		if (deleteFlag == null && originalFileName != null && file.getOriginalFilename() == "") {

			review.setReview_original_filename(originalFileName);
			review.setReview_rename_filename(renameFileName);

		} else if (file.getOriginalFilename() != "") { // 수정한 글에 첨부파일이 있다면

			// 업로드된 파일을 지정한 폴더로 옮기기
			try {
				file.transferTo(new File(savePath + "\\" + file.getOriginalFilename()));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}

			// 서버에 새로 업로드된 파일명 저장
			review.setReview_original_filename(file.getOriginalFilename());

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

			review.setReview_rename_filename(newRenameFileName);

			if (originalFileName != null) {// 원래 첨부파일이 있었다면,// 원래 첨부파일을 폴더에서 삭제함
				new File(savePath + "\\" + renameFileName).delete();
			} // 업로드된 새 파일이 있다면

		} else if (originalFileName != null && deleteFlag != null && deleteFlag.equals("yes")) {
			// 원래 첨부파일이 있었고, 파일삭제가 선택된 경우
			review.setReview_original_filename(null);
			review.setReview_rename_filename(null);

			new File(savePath + "\\" + renameFileName).delete();

		}
		
		if (reviewService.updateReview(review) > 0) {
			mv.setViewName("redirect:/rlist.do?page=1");// 목록으로
		} else {
			mv.addObject("message", review.getReview_no() + "번 공지사항 수정 실패!");
			mv.setViewName("common/error");
		}
		return mv;

	}	

}
