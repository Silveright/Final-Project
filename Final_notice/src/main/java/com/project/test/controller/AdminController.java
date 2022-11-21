package com.project.test.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.test.domain.AdminChartAreaDate;
import com.project.test.domain.AdminChartCategory;
import com.project.test.domain.AdminMember;
import com.project.test.domain.Inquery;
import com.project.test.domain.Planner;
import com.project.test.domain.Notice;
import com.project.test.service.AdminService;
import com.project.test.service.MySaveFolder;

@Controller
@RequestMapping(value="/admin")
public class AdminController {
	private AdminService adminService;
	private MySaveFolder mysavefolder;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	
	@Autowired
	public AdminController(AdminService adminService,MySaveFolder mysavefolder) {
		this.adminService = adminService;
		this.mysavefolder = mysavefolder;
	}
	
	@RequestMapping(value="/dashboard", method=RequestMethod.GET)
	public ModelAndView login(ModelAndView mv) {
		mv.setViewName("admin/admin");
		return mv;
	}
	@ResponseBody
	@GetMapping(value="/map")
	public Map<String, Object> mapLoad(){
		Map<String, Object> map = new HashMap<String, Object>();
		List<Planner> chart = adminService.getChartSchedule();
		
		map.put("chart", chart);
		return map;
	}
	@ResponseBody
	@GetMapping(value="/total")
	public Map<String, Object> overallStats(){
		Map<String, Object> map = new HashMap<String, Object>();
		int totaluser = adminService.gettotaluser();
		int totalgroup = adminService.gettotalgroup();
		int totalschedule = adminService.gettotalschedule();
		String bestgroup = adminService.getbestgroup();
		map.put("totalUser", totaluser);
		map.put("totalGroup", totalgroup);
		map.put("totalSchedule", totalschedule);
		map.put("bestGroup", bestgroup);
		return map;
	}

	@ResponseBody
	@GetMapping(value="/areachart")
	public Map<String, Object> areaChart(){
		Map<String, Object> map = new HashMap<String, Object>();
		List<AdminChartAreaDate> chartdate = adminService.getChartareaDate();
		
		map.put("chartdate", chartdate);
		return map;
	}

	@ResponseBody
	@GetMapping(value="/piechart")//모임 카테고리별 회원 수 차트
	public Map<String, Object> pieChart(){
		Map<String, Object> map = new HashMap<String, Object>();
		List<AdminChartCategory> piechart = adminService.getPieChart();
		
		map.put("piechart", piechart);
		return map;
	}

	@ResponseBody
	@GetMapping(value="/piechart2")//가입자 성비 차트
	public Map<String, Object> pieChart2(){
		Map<String, Object> map = new HashMap<String, Object>();
		List<AdminChartCategory> piechart = adminService.getPieChart2();
		
		map.put("piechart", piechart);
		return map;
	}

	@RequestMapping(value="/noticelist")
	public ModelAndView noticeList(
			  @RequestParam(value="page", defaultValue="1", required=false)	int page,
			  ModelAndView mv,
			  @RequestParam(value="search_field", defaultValue="-1", required=false) int index,
				@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
		int limit=10;//한 화면에 출력할 로우 개수
		logger.info("검색어는 "+search_word);
		int listcount=adminService.getNoticeListCount(index, search_word); //총 리스트 수를 받아옴
		//총 페이지 수
		int maxpage=(listcount+limit-1)/limit;
		//현재 페이지에 보여줄 시작 페이지 수
		int startpage=((page-1)/10)*10 +1;
		//현재 페이지에 보여줄 마지막 페이지 수
		int endpage=startpage +10-1;
		
		if(endpage>maxpage)
		endpage=maxpage;
		
		List<Notice> noticelist = adminService.getNoticeList(index, search_word, page,limit);//리스트를 받아옴
		
		mv.setViewName("admin/notice");
		mv.addObject("page",page);
		mv.addObject("maxpage",maxpage);
		mv.addObject("startpage",startpage);
		mv.addObject("endpage",endpage);
		mv.addObject("listcount",listcount);
		mv.addObject("noticelist",noticelist);
		mv.addObject("limit",limit);
		mv.addObject("search_field",index);
		mv.addObject("search_word",search_word);
		return mv;
		}
	
	@PostMapping("/noticeadd")
	//@RequestMapping(value="/add" , method=RequestMethod.POST)
	public String noticeadd(Notice notice, HttpServletRequest request)
		throws Exception{
		MultipartFile uploadfile = notice.getUploadfile();
		logger.info("조회수는.."+notice.getReadcount());
		//파일 첨부 여부를 확인한다.
		if(!uploadfile.isEmpty()) {
			String fileName = uploadfile.getOriginalFilename();//원래 파일명
			notice.setNotice_file_original(fileName);//원래 파일명 저장
			/*
			 * String saveFolder = request.getSession().getServletContext().getRealPath("resources") +
			 * "/upload";
			 */String saveFolder = mysavefolder.getSavefolder();

			String fileDBName = fileDBName(fileName, saveFolder);//db에 저장될 파일명 가공처리
			logger.info("fileDBName = " + fileDBName);
			
			//transferTo(File path) : 업로드한 파일을 매개변수의 경로에 저장한다.
			uploadfile.transferTo(new File(saveFolder + fileDBName));//throws IOException
			logger.info("fileDBName = " + saveFolder + fileDBName);
			notice.setNotice_file(fileDBName);
		}
		adminService.insertNotice(notice);//저장메서드 호출
		logger.info(notice.toString());//selectKey로 정의한 board_num의 값을 확인한다.
		return "redirect:noticelist";
	}
	
	private String fileDBName(String fileName, String saveFolder) {//saveFolder: 폴더경로 정보를 넘겨받음
		//새로운 폴더 이름(날짜): 오늘 년+월+일
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH)+1;
		int date = c.get(Calendar.DATE);
		
		String homedir = saveFolder  + "/" +  year + "-" + month + "-" + date;

		logger.info(homedir);
		File path1 = new File(homedir);
		if(!(path1.exists())) {
			path1.mkdir();//새로운 폴더를 생성한다.
		}
		//난수 생성
		Random r = new Random();
		int random = r.nextInt(100000000);
		
		//확장자 구하기 시작
		int index = fileName.lastIndexOf(".");
		//문자열에서 특정 문자열의 위치 값(index)를 반환한다.
		//indexOf가 처음 발견되는 문자열에 대한 index를 반환하는 반면,
		//lastIndexOf는 마지막으로 발견되는 문자열의 index를 반환한다.
		//(파일명에 점이 여러개 있을 경우 마지막에 발견되는 문자열의 위치를 리턴한다.)
		logger.info("index = " + index);
		
		String fileExtension = fileName.substring(index + 1);
		logger.info("fileExtension = " + fileExtension);
		//확장자 구하기 끝
		
		//새로운 파일명
		String refileName = "bbs" + year + month + date + random + "." + fileExtension;
		logger.info("refileName = " + refileName);
		//오라클 db에 저장될 파일명
		//String fileDBName =  "/" +  year + "-" + month + "-" + date + "/" + refileName;
		String fileDBName = File.separator + year + "-" + month + "-" + date + File.separator + refileName;
		logger.info("fileDBName = " + fileDBName);
		return fileDBName;
	}
	
	@RequestMapping(value="/noticewrite", method=RequestMethod.GET)
	public ModelAndView noticeWrite(ModelAndView mv) {
		mv.setViewName("admin/noticewrite");
		return mv;
	}

	
	@GetMapping(value="/noticedetail")
	public ModelAndView noticeDetail(int num, ModelAndView mv, 
									HttpServletRequest request,
									@RequestHeader(value="referer") String beforeURL) {
									//String befoURL = request.getHeader("referer"); 의미로
									//어느 주소에서 detail로 이동했는지 header의 정보 중 "referer"을 통해 알 수 있다.
		logger.info("referer:" + beforeURL);// referer:http://localhost:8335/test/admin/noticelist
		if(beforeURL.endsWith("noticelist")) {//admin/noticelist 에서 제목 클릭한 경우 조회수 증가
			adminService.setReadCountUpdate(num);
		}
		
		Notice notice = adminService.getDetail(num);
		//board=null; //error페이지 이동 테스트
		if(notice == null) {
			logger.info("상세보기 실패");
			mv.setViewName("error/error");
			mv.addObject("url",request.getRequestURL());
			mv.addObject("message","공지 상세보기 실패입니다.");
		}else {
			logger.info("상세보기 성공");
			mv.setViewName("admin/noticedetail");
			mv.addObject("notice",notice);
		}
		return mv;
	}
	

	@RequestMapping(value="/noticemodify", method=RequestMethod.GET)
	public ModelAndView noticeModify(int num, ModelAndView mv,HttpServletRequest request) {
		
		Notice notice = adminService.getDetail(num);
		//notice=null; //error페이지 이동 테스트
		if(notice == null) {
			logger.info("상세보기 실패");
			mv.setViewName("error/error");
			mv.addObject("url",request.getRequestURL());
			mv.addObject("message","수정상세보기 실패입니다.");
			return mv;
		}else {
			logger.info("수정상세보기 성공");
			mv.addObject("notice",notice);
			mv.setViewName("admin/noticemodify");
			return mv;
		}
		
	}
	
	@PostMapping("/modifyaction")
	public String noticeModifyAction(
			Notice notice,
			String check, Model mv,
			HttpServletRequest request,
			RedirectAttributes rattr
			) throws Exception {
		String url ="";
		MultipartFile uploadfile = notice.getUploadfile();
		/*
		 * String saveFolder =
		 * request.getSession().getServletContext().getRealPath("resources") +"/upload";
		 */
				
		if(check!=null && !check.equals("")) {//기존파일 변경x
			logger.info("기존 파일 그대로 사용");
			notice.setNotice_file_original(check);
			//<input type="hidden" name="board_file" value="${boarddata.board_file}">
			//위 문장으로 board.setBoard_file()값은 자동저장된다.
		}else {
			//답변글의 경우 파일 첨부에 대한 기능이 없다.
			//만약 답변글을 수정할 경우
			//<input type="file" id="upfile" name="uploadfile">엘리먼트가 존재하지 않아
			//private MultipartFile uploadfile;에서 uploadFile은 null이된다.
			if(uploadfile!=null && !uploadfile.isEmpty()) {
				logger.info("파일 변경되었습니다.");
				
				String fileName= uploadfile.getOriginalFilename();//원래 파일명
				notice.setNotice_file_original(fileName);
				String saveFolder = mysavefolder.getSavefolder();

				String fileDBName= fileDBName(fileName,saveFolder);
				logger.info("fileDBName = " + fileDBName);
				//transferTo(File path):업로드한 파일을 매개변수의 경로에 저장한다.
				uploadfile.transferTo(new File(saveFolder + fileDBName));
				logger.info("transferTo path = " + saveFolder + fileDBName);
				//바뀐 파일명으로 저장
				notice.setNotice_file(fileDBName);
			}else {//기존 파일이 없는데 파일 선택하지 않은 경우 또는 기존 파일이 있었는데 삭제한 경우
				logger.info("선택 파일 없습니다.");
				//<input type="hidden" name="board_file" value="${boarddata.board_file}">
				//위 태그에 값이 있다면 ""로 값을 변경한다.
				notice.setNotice_file("");
				notice.setNotice_file_original("");//값 초기화
			}
		}
		//DAO에서 수정 메서드 호출
		int result = adminService.noticeModify(notice);
		//수정 실패 시
		if(result==0) {
			logger.info("게시판 수정 실패");
			mv.addAttribute("url",request.getRequestURL());
			mv.addAttribute("message","게시판 수정 실패");
			url="error/error";
		}else {//수정 성공
			logger.info("게시판 수정 완료");
			//수정한 글 내용 보여주기 위해 글내용보기 페이지로이동 경로 설정
			url = "redirect:noticedetail";
			rattr.addAttribute("num", notice.getNotice_no());
		}
		return url;
	
	}
	
	
	@GetMapping("/noticedelete")
	public String noticeDeleteAction(String board_pass, int num,
									Model mv, RedirectAttributes rattr,
									HttpServletRequest request) {
		int result = adminService.noticeDelete(num);
		//삭제 처리 실패시
		if(result==0) {
			logger.info("공지 삭제 실패");
			mv.addAttribute("message", "공지 삭제 실패");
			mv.addAttribute("url",request.getRequestURL());
			return "error/error";
		}
		//삭제 처리 성공한 경우 - 글 목록보기 요청 전송
		logger.info("공지 삭제 성공");
		rattr.addFlashAttribute("result","deleteSuccess");
		return "redirect:noticelist";
	}
	
	@RequestMapping(value="/memberinfo")
	public ModelAndView memberList(@RequestParam(value="page", defaultValue="1",required=false) int page,
									@RequestParam(value="limit", defaultValue="8", required=false) int limit,
									ModelAndView mv,
									@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
									@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
		
		int listcount=adminService.getSearchListCount(index, search_word);//총 리스트 수를 받아옴
		List<AdminMember> list = adminService.getSearchList(index, search_word, page, limit);
		
		int maxpage = (listcount + limit -1)/limit;
		int startpage = ((page-1)/10) *10 +1;
		int endpage = startpage +10-1;
		
		if(endpage>maxpage)
			endpage=maxpage;
		
		mv.setViewName("admin/memberinfo");
		mv.addObject("page",page);
		mv.addObject("maxpage",maxpage);
		mv.addObject("startpage",startpage);
		mv.addObject("endpage",endpage);
		mv.addObject("listcount",listcount);
		mv.addObject("memberlist",list);
		mv.addObject("search_field",index);
		mv.addObject("search_word",search_word);
		return mv;
	}
	
	@RequestMapping(value="/groupmanager")
	public ModelAndView groupManager(@RequestParam(value="page", defaultValue="1",required=false) int page,
			@RequestParam(value="limit", defaultValue="8", required=false) int limit,
			ModelAndView mv,
			@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
			@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
			
			int listcount=adminService.getGroupSearchListCount(index, search_word);//총 리스트 수를 받아옴
			List<AdminMember> list = adminService.getGroupSearchList(index, search_word, page, limit);
			
			int maxpage = (listcount + limit -1)/limit;
			int startpage = ((page-1)/10) *10 +1;
			int endpage = startpage +10-1;
			
			if(endpage>maxpage)
				endpage=maxpage;
			
			mv.setViewName("admin/groupmanager");
			mv.addObject("page",page);
			mv.addObject("maxpage",maxpage);
			mv.addObject("startpage",startpage);
			mv.addObject("endpage",endpage);
			mv.addObject("listcount",listcount);
			mv.addObject("memberlist",list);
			mv.addObject("search_field",index);
			mv.addObject("search_word",search_word);
			return mv;
	}
	@RequestMapping(value="/inquiry")
	public ModelAndView inquiry(
			  @RequestParam(value="page", defaultValue="1", required=false)	int page,
			  ModelAndView mv, String userid,
			  @RequestParam(value="search_field", defaultValue="-1", required=false) int index,
				@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
		int limit=10;//한 화면에 출력할 로우 개수
		logger.info("userid는 "+userid);
		int listcount=adminService.getInqueryListCount(index, search_word); //총 리스트 수를 받아옴
		//총 페이지 수
		int maxpage=(listcount+limit-1)/limit;
		//현재 페이지에 보여줄 시작 페이지 수
		int startpage=((page-1)/10)*10 +1;
		//현재 페이지에 보여줄 마지막 페이지 수
		int endpage=startpage +10-1;
		
		if(endpage>maxpage)
		endpage=maxpage;
		
		List<Inquery> noticelist = adminService.getInqueryList(index, search_word, page,limit);//리스트를 받아옴
		
		mv.setViewName("admin/inquerylist");
		mv.addObject("page",page);
		mv.addObject("maxpage",maxpage);
		mv.addObject("startpage",startpage);
		mv.addObject("endpage",endpage);
		mv.addObject("listcount",listcount);
		mv.addObject("inquirylist",noticelist);
		mv.addObject("limit",limit);
		mv.addObject("userid",userid);
		mv.addObject("search_field",index);
		mv.addObject("search_word",search_word);
		return mv;
	}
	
	@RequestMapping(value="/inquerywrite", method=RequestMethod.GET)
	public String inqueryWrite(ModelAndView mv, RedirectAttributes rattr) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userid=authentication.getName();
		logger.info(authentication.getName());
		if(userid.equals("anonymousUser")) {
			rattr.addFlashAttribute("result","emptyid");
			return "redirect:inquiry";
		} else {
		return "admin/inquerywrite";
		}
	}
	
	@PostMapping("/inqueryadd")
	//@RequestMapping(value="/add" , method=RequestMethod.POST)
	public String inqueryAdd(Inquery inquery, HttpServletRequest request)
		throws Exception{
		MultipartFile uploadfile = inquery.getUploadfile();
		logger.info("조회수는.."+inquery.getInquery_readcount());
		//파일 첨부 여부를 확인한다.
		if(!uploadfile.isEmpty()) {
			String fileName = uploadfile.getOriginalFilename();//원래 파일명
			inquery.setInquery_original(fileName);//원래 파일명 저장
			/*
			 * String saveFolder = request.getSession().getServletContext().getRealPath("resources") +
			 * "/upload";
			 */String saveFolder = mysavefolder.getSavefolder();

			String fileDBName = fileDBName(fileName, saveFolder);//db에 저장될 파일명 가공처리
			logger.info("fileDBName = " + fileDBName);
			
			//transferTo(File path) : 업로드한 파일을 매개변수의 경로에 저장한다.
			uploadfile.transferTo(new File(saveFolder + fileDBName));//throws IOException
			logger.info("fileDBName = " + saveFolder + fileDBName);
			inquery.setInquery_file(fileDBName);
		}
		adminService.insertInquery(inquery);//저장메서드 호출
		logger.info(inquery.toString());//selectKey로 정의한 board_num의 값을 확인한다.
		return "redirect:inquiry";
	}

	@RequestMapping(value="/inquirydetail")
	public ModelAndView inquiryDetail(int num, ModelAndView mv, 
			HttpServletRequest request, String userid,
			@RequestHeader(value="referer") String beforeURL) {
			//String befoURL = request.getHeader("referer"); 의미로
			//어느 주소에서 detail로 이동했는지 header의 정보 중 "referer"을 통해 알 수 있다.
		logger.info("referer:" + beforeURL);// referer:http://localhost:8335/test/admin/inquiry
		if(beforeURL.endsWith("inquiry")) {//admin/inquiry 에서 제목 클릭한 경우 조회수 증가
		adminService.setInquiryReadCountUpdate(num);
		}
		
		Inquery inquery = adminService.getInquiryDetail(num);
		if(inquery == null) {
		logger.info("상세보기 실패");
		mv.setViewName("error/error");
		mv.addObject("url",request.getRequestURL());
		mv.addObject("message","공지 상세보기 실패입니다.");
		}else {
		logger.info("상세보기 성공");
		mv.setViewName("admin/inquerydetail");
		mv.addObject("inquery",inquery);
		mv.addObject("userid",userid);
		}
		return mv;
	}
	
	@GetMapping(value="/inquiryreply")
	public ModelAndView replyView(int num, ModelAndView mv, 
			HttpServletRequest request
			) {
		Inquery inquery = adminService.getInquiryDetail(num);
		if(inquery == null) {
			logger.info("답변 폼 불러오기 실패");
			mv.setViewName("error/error");
			mv.addObject("url",request.getRequestURL());
			mv.addObject("message","답변 폼 보기 실패입니다.");
			return mv;
		}else {
			logger.info("답변 폼 상세보기 성공");
			mv.addObject("inquery",inquery);
			mv.setViewName("admin/inqueryreply");
			return mv;
		}
	}
	
	@PostMapping("/replyaction")
	public ModelAndView BoardReplyAction(Inquery inquery, ModelAndView mv,
										HttpServletRequest request,
										RedirectAttributes rattr) {
		int result = adminService.inqueryReply(inquery);
		if(result==0) {
			mv.setViewName("error/error");
			mv.addObject("url",request.getRequestURL());
			mv.addObject("message","문의 답변 처리 실패");
		}else {
			rattr.addAttribute("num", inquery.getInquery_num());
			mv.setViewName("redirect:inquirydetail");
		}
		return mv;
	}
	
	
	@GetMapping(value="/inquirymodify")
	public ModelAndView modifyView(int num, ModelAndView mv, 
			HttpServletRequest request
			) {
		Inquery inquery = adminService.getInquiryDetail(num);
		if(inquery == null) {
			logger.info("상세보기 실패");
			mv.setViewName("error/error");
			mv.addObject("url",request.getRequestURL());
			mv.addObject("message","수정상세보기 실패입니다.");
			return mv;
		}else {
			logger.info("수정상세보기 성공");
			mv.addObject("inquery",inquery);
			mv.setViewName("admin/inquerymodify");
			return mv;
		}
	}
	
	@PostMapping("/inquerymodifyaction")
	public String BoardModifyAction(
			Inquery inquery,
			String check, Model mv,
			HttpServletRequest request,
			RedirectAttributes rattr
			) throws Exception {
		boolean usercheck =
				adminService.isBoardWriter(inquery.getInquery_num(), inquery.getInquery_pass());
		String url ="";
		//비밀번호가 다른 경우
		if(usercheck==false) {
			rattr.addFlashAttribute("result","passFail");
			rattr.addAttribute("num", inquery.getInquery_num());
			return "redirect:inquirymodify";
		}
		
		MultipartFile uploadfile = inquery.getUploadfile();
				
		if(check!=null && !check.equals("")) {//기존파일 변경x
			logger.info("기존 파일 그대로 사용");
			inquery.setInquery_original(check);
		}else {
			if(uploadfile!=null && !uploadfile.isEmpty()) {
				logger.info("파일 변경되었습니다.");
				
				String fileName= uploadfile.getOriginalFilename();//원래 파일명
				inquery.setInquery_original(fileName);
				String saveFolder = mysavefolder.getSavefolder();

				String fileDBName= fileDBName(fileName,saveFolder);
				logger.info("fileDBName = " + fileDBName);
				uploadfile.transferTo(new File(saveFolder + fileDBName));
				logger.info("transferTo path = " + saveFolder + fileDBName);
				//바뀐 파일명으로 저장
				inquery.setInquery_file(fileDBName);
			}else {//기존 파일이 없는데 파일 선택하지 않은 경우 또는 기존 파일이 있었는데 삭제한 경우
				logger.info("선택 파일 없습니다.");
				inquery.setInquery_file("");
				inquery.setInquery_original("");//값 초기화
			}
		}
		//DAO에서 수정 메서드 호출
		int result = adminService.inqueryModify(inquery);
		//수정 실패 시
		if(result==0) {
			logger.info("게시판 수정 실패");
			mv.addAttribute("url",request.getRequestURL());
			mv.addAttribute("message","게시판 수정 실패");
			url="error/error";
		}else {//수정 성공
			logger.info("게시판 수정 완료");
			//수정한 글 내용 보여주기 위해 글내용보기 페이지로이동 경로 설정
			url = "redirect:inquirydetail";
			rattr.addAttribute("num", inquery.getInquery_num());
		}
		return url;
	
	}
	
	@PostMapping("/inquirydelete")
	public String BoardDeleteAction(String board_pass, int num,
									Model mv, RedirectAttributes rattr,
									HttpServletRequest request) {
		//글 삭제 명령을 요청한 사용자가 글을 작성한 사용자인지 판단하기 위해
		//입력한 비밀번호와 저장된 비밀번호를 비교하여 일치 시 삭제한다.
		boolean usercheck = adminService.isBoardWriter(num, board_pass);
		
		//비밀번호 일치하지 않는 경우
		if(usercheck==false) {
			rattr.addFlashAttribute("result","passFail");
			rattr.addAttribute("num",num);
			return "redirect:inquirydetail";
		}
		//비밀번호 일치하는 경우 삭제 처리
		int result = adminService.inqueryDelete(num);
		//삭제 처리 실패시
		if(result==0) {
			logger.info("게시판 삭제 실패");
			mv.addAttribute("url",request.getRequestURL());
			return "error/error";
		}
		//삭제 처리 성공한 경우 - 글 목록보기 요청 전송
		logger.info("게시판 삭제 성공");
		rattr.addFlashAttribute("result","deleteSuccess");
		return "redirect:inquiry";
	}
	
	@GetMapping(value="/delete")//사이트 회원삭제
	public String userDelete(String userid) {
		logger.info("userid="+userid);
		adminService.delete(userid);
		return "redirect:memberinfo";
	}
}
