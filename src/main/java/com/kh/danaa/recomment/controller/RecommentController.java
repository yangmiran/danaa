package com.kh.danaa.recomment.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.danaa.recomment.model.service.RecommentService;
import com.kh.danaa.recomment.model.vo.Recomment;


@Controller
public class RecommentController {
	private static final Logger logger = LoggerFactory.getLogger(RecommentController.class);

	@Autowired
	private RecommentService recommentService;
	
	// 댓글 리스트를 호출할 때 맵핑되는 메소드
	@RequestMapping(value="relist.do", method= {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public String list(ModelAndView mv, Recomment recomment) throws UnsupportedEncodingException {
		logger.info(recomment.toString());
		ArrayList<Recomment> list = recommentService.selectList(recomment.getRecomment_ref());
		logger.info(list.toString());
		JSONObject sendJson = new JSONObject();

		JSONArray jarr = new JSONArray();

		for (Recomment re : list) {
			JSONObject job = new JSONObject();
			job.put("recomment_level", re.getRecomment_level());
			job.put("recomment_no", re.getRecomment_no());
			job.put("recomment_content", URLEncoder.encode(re.getRecomment_content(), "utf-8"));
			job.put("recomment_writer", URLEncoder.encode(re.getRecomment_writer(), "utf-8"));
			job.put("recomment_date", re.getRecomment_date().toString());

			jarr.add(job);
			
			sendJson.put("list", jarr);
		}
		logger.info("relist" + jarr);
		return sendJson.toString();
	}
	
	// 댓글 생성
	@RequestMapping(value="reinsert.do", method={RequestMethod.POST, RequestMethod.GET})
	public String insert1(Recomment recomment, @RequestParam("review_no")int review_no, @RequestParam("page")int page) {
		/* logger.info("reinsert" + recomment); */
			recomment.setRecomment_ref(review_no);
			logger.info("reinsert" + recomment);
			recommentService.insertRecomment1(recomment);
			return "redirect:/rdetail.do?review_no=" + review_no + "&page=" + page;
		
}
	
	/*
	 * // 대댓글 생성
	 * 
	 * @RequestMapping(value="recinsert.do", method=RequestMethod.POST) public void
	 * insert2(HttpSession session, Recomment recomment) {
	 * 
	 * recommentService.insertRecomment2(recomment); }
	 */
	
	// 댓글 수정
	@RequestMapping("reupdate.do")
	public String update(HttpServletRequest request)throws Exception{
		Recomment recomment = new Recomment();
		recomment.setRecomment_no(Integer.parseInt(request.getParameter("recomment_no")));
		recomment.setRecomment_content(request.getParameter("recomment_content"));
		
		
		recommentService.updateRecomment(recomment);
		
		return "redirect:/rdetail.do?review_no=" + Integer.parseInt(request.getParameter("review_no")) + "&page=" + Integer.parseInt(request.getParameter("page"));
	}
	
	// 댓글 삭제
	@RequestMapping(value="redelete.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String delete(@RequestParam(value="recomment_no")int recomment_no,@RequestParam(value="review_no")int review_no,
			@RequestParam(value="page")int page)throws Exception{
		logger.info( "delete" + recomment_no);
		recommentService.deleteRecomment(recomment_no);
	
		return "redirect:/rdetail.do?review_no=" + review_no + "&page=" + page;
	}

	
}
