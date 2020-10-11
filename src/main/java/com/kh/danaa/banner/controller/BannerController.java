package com.kh.danaa.banner.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.danaa.banner.model.service.BannerService;
import com.kh.danaa.banner.model.vo.Banner;

@Controller
public class BannerController {
	
	@Autowired
	private BannerService bannerService;
	
	
	//배너리스트
	@RequestMapping("adBnList.do")
	public ModelAndView bnlistPage(@RequestParam("page") int page, ModelAndView mv) {
		int limit = 5;
		
		int listCount = bannerService.selectBannerCount();
		ArrayList<Banner> list = bannerService.selectListBanner(page, limit);
		
		int maxPage = (int) (((double) listCount / limit) + 0.9);		
		
		int startPage = (((int) ((double) page / limit + 0.9)) - 1) * limit + 1;
		int endPage = startPage + limit - 1;

		if (maxPage < endPage) {
			endPage = maxPage;
		}
		
		if(list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("page", page);
			mv.addObject("maxPage", maxPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.addObject("listCount", listCount);
			mv.setViewName("banner/adBnList");
		} else {
			mv.addObject("message", page + "페이지에 대한 목록 조회 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	
	//배너 등록페이지 이동
	@RequestMapping("bnWrite.do")
	public String moveadbnlist() {
		return "banner/adBnWriteForm";
	}
	
	//배너 등록
	@RequestMapping(value = "bninsert.do", method = RequestMethod.POST)
	public String bannerInsert(Banner banner, HttpServletRequest request,
			@RequestParam(name="bfile", required = false) MultipartFile file, Model model) {
		
		String fileName = file.getOriginalFilename();
		String savePath = request.getSession().getServletContext().getRealPath("/resources/bupfiles");
		
		// 업로드된 파일이 있다면
		if(file != null) {
			// 바꿀 파일명에 대한 포맷문자열 만들기 : 년월일시분초 형식으로 지정
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); // java.text.SimpleDateFormat
			
			// 바꿀파일명 만들기 // 현재 시스템 시간의 long형 정수
			// 업로드된 파일의 확장자를 추출해서, 새 파일명 뒤에 붙여줌
			String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())); // 파일명
			renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1); // 원래 파일명 . 뒤에서부터 추출해라

			banner.setBn_file(fileName);
			banner.setBn_refile(renameFileName);
			
			// 업로드된 파일을 지정한 폴더로 옮기는 작업
			try {
				file.transferTo(new File(savePath + "\\" + renameFileName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		
		if(bannerService.insertBanner(banner) > 0) {
			return "redirect:/adBnList.do?page=1";
		} else {
			model.addAttribute("message", "새 공지글 등록 실패");
			return "common/error";
		}
	}
	
	//배너 삭제
	@RequestMapping("bndelete.do")
	public String bannerDelete(Banner banner, HttpServletRequest request,
		@RequestParam("bn_no") int bn_no,
		@RequestParam(value = "page", required = false, defaultValue="1") int page) {
		
		String returnview;
		
		if(bannerService.deleteBanner(banner) > 0) {
			if(banner.getBn_refile() != null) {
				String savePath = request.getSession().getServletContext().getRealPath("resources/bupfiles");
				new File(savePath + "\\" + banner.getBn_refile()).delete();
			}
			if(page != 0) {
				returnview = "redirect:/adBnList.do?page=" + page;
			}
			returnview = "redirect:/adBnList.do?page=1";
		}else {
			request.setAttribute("message", banner.getBn_no() + " 번 배너 삭제 실패");
			returnview = "common/error";
		}
		return returnview;
	}
	
	//배너 다중 삭제
	@RequestMapping(value="bndelete2.do", method=RequestMethod.GET)
	public String bannerMultiDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		//받아온 체크박스 rno 배열에 담기
		String[] bno = request.getParameterValues("bn_no");		
		
		//rno[] 길이만큼 실행
		int result = 0;		
		for(int i = 0; i < bno.length; i++) {
			int bn_no = Integer.parseInt(bno[i]);			
			result = bannerService.deleteMultiBanner(bn_no);	
		}		
		
		if(result > 0) {			
			String referer = request.getHeader("Referer");
	        return "redirect:"+ referer;	
		} else {
			response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>alert('다중 삭제에 실패하였습니다.'); history.go(-1);</script>");
	        out.flush();
	        out.close();
	        
	        String referer = request.getHeader("Referer");
	        return "redirect:"+ referer;
		}
	}

	//배너 수정페이지
	@RequestMapping("bnInfo.do")
	public String bnInfoMethod(@RequestParam("page") String page, Banner banner, Model model) {
		banner = bannerService.selectOneBanner(banner.getBn_no());
		
		model.addAttribute("banner", banner);
		return  "banner/adBnDetailView";
	}
	
	
	//배너수정
	@RequestMapping(value = "bnUpdate.do", method = RequestMethod.POST)
	public ModelAndView updateBanner(Banner banner, HttpServletRequest request, ModelAndView mv,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(name = "bfile", required = false) MultipartFile file) throws IOException {

		String savePath = request.getSession().getServletContext().getRealPath("resources/bupfiles");
		
		// 첨부파일 이름 바꾸기
		String newRenameFileName = null;
		
		// 바꿀 파일명에 대한 포맷 문자열 만들기 : 년월일시분초 형식으로
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		// 바꿀 파일명 만들기 // date()~return long형 정수
		newRenameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));
				
		String originalFileName = banner.getBn_file();
		String renameFileName = banner.getBn_refile();
		
		if(originalFileName != null && file.getOriginalFilename() == "") { 
			banner.setBn_file(originalFileName);
			banner.setBn_refile(renameFileName);
			
		} else if(file.getOriginalFilename() != "") {
			try {
				file.transferTo(new File(savePath+"\\" + file.getOriginalFilename()));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			banner.setBn_file(file.getOriginalFilename());
			
			newRenameFileName += "."
					+ file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
			
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
			
			banner.setBn_refile(newRenameFileName);
			
			
		} else if (originalFileName != null) {

			new File(savePath + "\\" + renameFileName).delete();
		}
		
		if(bannerService.updateBanner(banner) > 0) {	
			mv.setViewName("redirect:/adBnList.do?page=1");
		}else {
			mv.addObject("message", banner.getBn_no() + "번 배너 수정 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	//배너리스트 검색
	@RequestMapping(value="adbnSerch.do", method=RequestMethod.POST)
	public String bannerSearch(HttpServletRequest request, Model model,
			@RequestParam(value = "", required = false) String keyword) {
		
		String action = request.getParameter("action");
		//String keyword = null;
		
		keyword = request.getParameter("keyword");
		
		ArrayList<Banner> list = null;
		
		switch (action) {
		case "bn_title": list = bannerService.selectSearchTit(keyword);
			break;
		case "bn_state": list = bannerService.selectSearchState(keyword);
			break;
		}
		
		if(list.size() > 0) {
			model.addAttribute("list", list);
			return "banner/adBnList";
		}else {
			model.addAttribute("message", action + " 검색에 대한 " 
                    + keyword + " 결과가 존재하지 않습니다.");
			return "common/error";
		}
	}
	
}
