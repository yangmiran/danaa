package com.kh.danaa;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.danaa.banner.model.service.BannerService;
import com.kh.danaa.banner.model.vo.Banner;
import com.kh.danaa.event.model.service.EventService;
import com.kh.danaa.event.model.vo.Event;
import com.kh.danaa.popup.model.service.PopupService;
import com.kh.danaa.popup.model.vo.Popup;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private PopupService popupService;
	
	@Autowired
	private BannerService bannerService;
	
	@Autowired
	private EventService eventService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	
	@RequestMapping(value = "main.do", method = RequestMethod.GET)
	public String mainViewForward(Model model) {
		//메인배너
		ArrayList<Banner> bnlist = bannerService.selectBanner();		
		
		//이벤트
		ArrayList<Event> evlist = eventService.selectMainEvent();		
		
		// 팝업
		ArrayList<Popup> plist = popupService.selectMainList();
		
		model.addAttribute("plist", plist);
		model.addAttribute("evlist", evlist);
		model.addAttribute("bnlist", bnlist);
		
		return "common/main";
	}
}
