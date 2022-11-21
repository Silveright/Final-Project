 	package com.project.test.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
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

import com.project.test.domain.Group;
import com.project.test.domain.GroupJoin;
import com.project.test.domain.GroupUser;
import com.project.test.domain.Group_Board;
import com.project.test.domain.Search;
import com.project.test.service.CommentService;
import com.project.test.service.GroupService;
import com.project.test.service.MemberService;
import com.project.test.service.MySaveFolder;

@Controller
@RequestMapping(value="/group")
public class GroupController {
	
	//@Autowired
	private MemberService memberService;
    //private GroupService groupService;
	private CommentService commentService;
	
	private static final Logger logger = LoggerFactory.getLogger(GroupController.class);
	private GroupService groupservice;
	private MySaveFolder mysavefolder;
	

	 @Autowired 
	 public GroupController(GroupService groupservice, MySaveFolder mysavefolder, CommentService commentService) {
	 this.groupservice = groupservice;
	 this.mysavefolder = mysavefolder; 
	 this.commentService = commentService;
	 }

	//모임 생성
		@GetMapping(value = "/groupMake") // 
//		@RequestMapping(value = "/write", method = RequestMethod.GET)
		public String group_make() {
			return "group/group_make";
		}
		
		@PostMapping("/add")
//		@RequestMapping(value = "/add", method = RequestMethod.POST)
		public String add(Group group, HttpServletRequest request)
				throws Exception{
			
			MultipartFile uploadfile = group.getUploadfile();
			logger.info("uploadfile = " + uploadfile);
			if(!uploadfile.isEmpty()) {
				String fileName = uploadfile.getOriginalFilename(); // 원래 파일명
				group.setGroup_original(fileName);// 원래 파일명 저장
				/* String saveFolder = request.getSession().getServletContext().getRealPath("resources")
						 + "/upload"; */
				String saveFolder = mysavefolder.getSavefolder();

				String fileDBName = fileDBName(fileName, saveFolder);
				logger.info("fileDBName = " + fileDBName);
				
				// transferTo(File path) : 업로드한 파일을 매개변수의 경로에 저장합니다.
				uploadfile.transferTo(new File(saveFolder + fileDBName));
				logger.info("fileDBName = " + saveFolder + fileDBName);
				//바뀐 파일명으로 저장
				group.setGroup_img(fileDBName);
			}
			logger.info(group.getArea_name());
			logger.info(group.getCatename());
			logger.info(group.getGroup_content());
			logger.info(group.getGroup_img());
			logger.info(group.getGroup_name());
			logger.info(group.getGroup_original());
			String userid=group.getUserid().substring(1);
			group.setUserid(userid);
			logger.info(group.getUserid());
			groupservice.insertGroup(group); // 저장메서드 호출
			logger.info(group.toString()); // selectKey로 정의한 BOARD_NUM 값 확인해 봅니다.
			return "redirect:/main/list";
		}
		
		
		private String fileDBName(String fileName, String saveFolder) {
			// 새로운 폴더 이름 : 오늘 년+월+일
			Calendar c = Calendar.getInstance();
			int year = c.get(Calendar.YEAR); // 오늘 년도 구합니다.
			int month = c.get(Calendar.MONTH) + 1; // 오늘 월을 구합니다.
			int date = c.get(Calendar.DATE); // 오늘 일 구합니다.
			
			String homedir = saveFolder + "/" + year + "-" + month + "-" + date;
			logger.info(homedir);
			File path1 = new File(homedir);
			if(!(path1.exists())) {
				path1.mkdir(); // 새로운 폴더를 생성
			}
			
			// 난수를 구합니다.
			Random r = new Random();
			int random = r.nextInt(10000000);
			
			/**** 확장자 구하기 시작 ****/
			int index = fileName.lastIndexOf(".");
			// 문자열에서 특정 문자열의 위치 값(index)를 반환합니다.
			// indexOf가 처음 발견되는 문자열에 대한 index를 반환하는 반면,
			// lastIndexOf는 마지막으로 발견되는 문자열의 index를 반환합니다.
			// (파일명에 점에 여러개 있을 경우 맨 마지막에 발견되는 문자열의 위치를 리턴합니다.)
			logger.info("index = " + index);
			
			String fileExtension = fileName.substring(index + 1);
			logger.info("fileExtension = " + fileExtension);
			/**** 확장자 구하기 끝 ****/
			
			// 새로운 파일명
			String refileName = "bbs" + year + month + date + random + "." + fileExtension;
			logger.info("refileName = " + refileName);
			
			// 오라클 디비에 저장될 파일 명
//			String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName;
			String fileDBName = File.separator + year + "-" + month + "-" + date + File.separator + refileName;
			logger.info("fileDBName = " + fileDBName);
			return fileDBName;
		}
		
		// detail?num=9요청시 파라미터 num의 값을 int num에 저장합니다.
		@GetMapping("/group_detail")
		public ModelAndView Detail(
				int num, ModelAndView mv,
				HttpServletRequest request,
				@RequestHeader(value = "referer") String beforeURL)
		// String bsforeURL = request.getHeader("referer"); 의미로
		// 어느 주소에서 detail로 이동했지만 header의 정보 중에서 "referer"를 통해 알 수 있습니다.
		{
			
			Group group = groupservice.getDetail(num);
			// board=null; // error 페이지 이동 확인하고자 임의로 지정합니다.
			if(group == null) {
				logger.info("가입신청 페이지 이동 실패");
				mv.setViewName("error/error");
				mv.addObject("url",request.getRequestURL());
				mv.addObject("message","가입신청 페이지 이동 실패입니다.");
			}else {
				logger.info("가입신청 성공");
				int count = groupservice.getMemberCount(num);
				mv.setViewName("group/group_detail");
				mv.addObject("count", count);
				mv.addObject("group_no", group.getGroup_no());
				mv.addObject("groupdata", group);
			}
			return mv;
		}
	
//==================================================================================


		@ResponseBody
		@GetMapping(value="/main")
		public Map<String, Object> getUserRole(@RequestParam("group_no") int group_no, String userid) {
			GroupUser user= groupservice.getUserRole(group_no, userid);
			
			int result = (user==null) ? -1: user.getGroup_role();
			
			Map<String,Object> map = new HashMap<String,Object>();
		     map.put("join", groupservice.getUserJoin(group_no, userid));//(user==null) ? -1 : 1;
		     map.put("role", result);
			return map;
	}
		
		@ResponseBody
		@GetMapping(value="/groupcount")
		public int getUserGroup(String userid) {
			
			int result = groupservice.getUserGroupCount(userid);
			logger.info("가입 모임 수는 " + result);
			return result;
		}				
		
		//그룹 가입신청
		@RequestMapping(value = "/insert", method = RequestMethod.GET)
		public String member_delete(String userid, int group_no) {
			groupservice.insert(userid, group_no);
			
			return "redirect:/group/group_detail?num="+group_no;
	}
		
		//그룹 게시판 목록
		@RequestMapping(value = "/groupboardlist", method = RequestMethod.GET)
		public ModelAndView groupboardList(  @RequestParam(value="group_no",required=false) int group_no,
										@RequestParam(value = "page", defaultValue = "1", required = false) int page,
										ModelAndView mv) {
			int limit = 10; // 한 화면에 출력할 로우 갯수
			
			
			
			int listcount = groupservice.getBoardListCount(group_no); // 총 리스트 수를 받아옴
			
			// 총 페이지 수
			int maxpage = (listcount + limit -1) / limit;
			
			// 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
			int startpage = ((page - 1) / 10) * 10 +1;
			
			// 현재 페이지에 보여줄 마지막 페이지 수(10,20,30 등..)
			int endpage = startpage + 10 -1;
			
			if(endpage > maxpage)
				endpage = maxpage;
			
			List<Group_Board> groupboardlist = groupservice.getGroupBoardList(page, limit, group_no); // 리스트를 받아옴
			
			mv.setViewName("group/groupboardlist");
			mv.addObject("page", page);
			mv.addObject("maxpage", maxpage);
			mv.addObject("startpage", startpage);
			mv.addObject("endpage", endpage);
			mv.addObject("listcount", listcount);
			mv.addObject("groupboardlist", groupboardlist);
			mv.addObject("limit", limit);
			mv.addObject("group_no",group_no);

			return mv;			
			
	}
		// 모임 게시글 검색
		@RequestMapping(value="/groupboardlistsearch", method=RequestMethod.GET)
		public ModelAndView searchlist(@RequestParam(value = "page", defaultValue = "1", required = false) int page,
									  @RequestParam(value = "limit", defaultValue = "12", required = false) int limit,
									  ModelAndView mv,
									  @RequestParam(value="group_no",required=false) int group_no,
									  @RequestParam(value = "search_field", defaultValue = "", required = false) String index,
									  @RequestParam(value = "search_word", defaultValue = "", required = false)
									  String search_word) {

			int listcount = groupservice.getSearchListCount(index, search_word); //총 리스트 수를 받아옵니다.

			List<Search> list = groupservice.getSearchList(index, search_word, page, limit);

			//총 페이지 수
			int maxpage = (listcount + limit - 1) / limit;

			//현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 ...)
			int startpage = ((page - 1) / 10) * 10 + 1;

			//현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30 ...)
			int endpage = startpage + 10 - 1;

			if(endpage > maxpage)
				endpage = maxpage;

			mv.setViewName("group/groupboardlist");
			mv.addObject("page", page);
			mv.addObject("maxpage", maxpage);
			mv.addObject("startpage", startpage);
			mv.addObject("endpage", endpage);
			mv.addObject("listcount", listcount);
			mv.addObject("groupboardlist", list);
			mv.addObject("group_no",group_no);
			mv.addObject("search_field", index);
			mv.addObject("search_word", search_word);
			
			return mv;
		}
		
		
		
//		@RequestMapping(value="/groupboardlist")
//		public ModelAndView groupboardlist(int group_no,
//				ModelAndView mv) {
//			mv.addObject("group_no", group_no);
//		mv.setViewName("group/groupboardlist");
//		return mv;
//	}
		
		// 글쓰기
		@GetMapping(value = "/groupboardwrite" ) // /board/write
//		@RequestMapping(value = "/write", method = RequestMethod.GET)
		public ModelAndView board_write(ModelAndView mv, @RequestParam(value="group_no",required=false) int group_no) {
			mv.setViewName("group/groupboardwrite");
			mv.addObject("group_no", group_no);
			return mv;
	}	
	
		/*
		 * 스프링 컨테이너는 매개변수Board객체를 생성하고
		 * Board객체의 setter 메서드들을 호출하여 사용자 입력값을 설정합니다.
		 * 매개변수의 이름과 setter의 property가 일치하면 됩니다.
		 */
		@PostMapping("/boardadd")
//		@RequestMapping(value = "/add", method = RequestMethod.POST)
		public String boardadd(
				Group_Board groupboard, HttpServletRequest request)
				throws Exception{
			
			MultipartFile uploadfile = groupboard.getUploadfile();
			
			if(!uploadfile.isEmpty()) {
				String fileName1 = uploadfile.getOriginalFilename(); // 원래 파일명
				groupboard.setBOARD_ORIGINAL(fileName1);// 원래 파일명 저장
				/* String saveFolder = request.getSession().getServletContext().getRealPath("resources")
						 + "/upload"; */
				String saveFolder = mysavefolder.getSavefolder();

				String fileDBName1 = fileDBName1(fileName1, saveFolder);
				logger.info("fileDBName1 = " + fileDBName1);
				
				// transferTo(File path) : 업로드한 파일을 매개변수의 경로에 저장합니다.
				uploadfile.transferTo(new File(saveFolder + fileDBName1));
				logger.info("fileDBName1 = " + saveFolder + fileDBName1);
				//바뀐 파일명으로 저장
				groupboard.setBOARD_FILE(fileDBName1);
			}
			
			groupservice.insertBoard(groupboard); // 저장메서드 호출
			logger.info(groupboard.toString()); // selectKey로 정의한 BOARD_NUM 값 확인해 봅니다.
			return "redirect:groupboardlist?group_no="+groupboard.getGROUP_NO();
		}

		private String fileDBName1(String fileName1, String saveFolder) {
			// 새로운 폴더 이름 : 오늘 년+월+일
			Calendar c = Calendar.getInstance();
			int year = c.get(Calendar.YEAR); // 오늘 년도 구합니다.
			int month = c.get(Calendar.MONTH) + 1; // 오늘 월을 구합니다.
			int date = c.get(Calendar.DATE); // 오늘 일 구합니다.
			
			String homedir = saveFolder + "/" + year + "-" + month + "-" + date;
			logger.info(homedir);
			File path1 = new File(homedir);
			if(!(path1.exists())) {
				path1.mkdir(); // 새로운 폴더를 생성
			}
			
			// 난수를 구합니다.
			Random r = new Random();
			int random = r.nextInt(10000000);
			
			/**** 확장자 구하기 시작 ****/
			int index = fileName1.lastIndexOf(".");
			// 문자열에서 특정 문자열의 위치 값(index)를 반환합니다.
			// indexOf가 처음 발견되는 문자열에 대한 index를 반환하는 반면,
			// lastIndexOf는 마지막으로 발견되는 문자열의 index를 반환합니다.
			// (파일명에 점에 여러개 있을 경우 맨 마지막에 발견되는 문자열의 위치를 리턴합니다.)
			logger.info("index = " + index);
			
			String fileExtension = fileName1.substring(index + 1);
			logger.info("fileExtension = " + fileExtension);
			/**** 확장자 구하기 끝 ****/
			
			// 새로운 파일명
			String refileName = "bbs" + year + month + date + random + "." + fileExtension;
			logger.info("refileName1 = " + refileName);
			
			// 오라클 디비에 저장될 파일 명
//			String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName;
			String fileDBName = File.separator + year + "-" + month + "-" + date + File.separator + refileName;
			logger.info("fileDBName1 = " + fileDBName);
			return fileDBName;
		}
		
		// 그룹 상세페이지
		// detail?num=9요청시 파라미터 num의 값을 int num에 저장합니다.
		@GetMapping("/groupboarddetail")
		public ModelAndView GroupBoardDetail(
				@RequestParam(value="group_no",required=false) int group_no,
				int num, ModelAndView mv,
				HttpServletRequest request,
				@RequestHeader(value = "referer") String beforeURL)
		// String bsforeURL = request.getHeader("referer"); 의미로
		// 어느 주소에서 detail로 이동했지만 header의 정보 중에서 "referer"를 통해 알 수 있습니다.
		{
			logger.info("referer : " + beforeURL);
			logger.info("referer : [t/f] : " + beforeURL.contains("groupboardlist"));
			if(beforeURL.contains("groupboardlist")) {
				groupservice.setReadCountUpdate(num);
				
			}
			Group_Board groupboard = groupservice.getBoardDetail(num);
			// board=null; // error 페이지 이동 확인하고자 임의로 지정합니다.
			if(groupboard == null) {
				logger.info("상세보기 실패");
				mv.setViewName("error/error");
				mv.addObject("url",request.getRequestURL());
				mv.addObject("message","상세보기 실패입니다.");
			}else {
				logger.info("상세보기 성공");
				int count = commentService.getListCount(num);
				mv.setViewName("group/groupboarddetail");
				mv.addObject("group_no", group_no);
				mv.addObject("count", count);
				mv.addObject("boarddata", groupboard);
			}
			return mv;
		}
		
		//그룹 보드 게시판 수정
		@GetMapping("/groupboardmodifyView")
		public ModelAndView ModifyView(
				
				int num, int group_no, ModelAndView mv,
				HttpServletRequest request
				
				){
		
			Group_Board groupboardmodify = groupservice.getBoardDetail(num);
			
			// 글 내용 불러오기 실패한 경우입니다.
			if(groupservice == null) {
				logger.info("수정보기 실패");
				mv.setViewName("error/error");
				mv.addObject("url",request.getRequestURL());
				mv.addObject("message","수정보기 실패입니다.");
				return mv;
			}
			
			logger.info("(수정)상세보기 성공");
			// 수정 폼 페이지로 이동할 때 원문 글 내용을 보여주기 때문에 boarddata 객체를
			// ModelAndView 객체에 저장합니다.
			mv.setViewName("group/groupboardmodify");
			// 글 수정 폼 페이지로 이동하기 위해 경로를 설정합니다.
			mv.addObject("boarddata", groupboardmodify);
			mv.addObject("group_no",group_no);
			return mv;
		}
		
		//그룹 보드 수정 페이지 작동
		@PostMapping("/groupboardmodifyAction")
		public String BoardModifyAction(
				@RequestParam(value="group_no") int group_no,
				Group_Board boarddata, 
				String check, Model mv, 
				HttpServletRequest request,
				RedirectAttributes rattr
				)  throws Exception {
			boolean usercheck = 
			  groupservice.isBoardWriter(boarddata.getBOARD_NUM(), boarddata.getBOARD_PASS());
			logger.info("입력한 비밀번호" + boarddata.getBOARD_PASS());
			logger.info("받아온 모임번호"+group_no);
			String url="";
			// 비밀번호가 다른 경우
			if (usercheck == false) {
				  rattr.addFlashAttribute("result", "passFail");
				  rattr.addAttribute("num",boarddata.getBOARD_NUM());
				 return "redirect:groupboardmodifyView";
			}

			MultipartFile uploadfile = boarddata.getUploadfile();
			/* String saveFolder =	request.getSession().getServletContext().getRealPath("resources") 
					           + "/upload"; */
			
			if (check != null && !check.equals("")) { // 기존파일 그대로 사용하는 경우입니다.
				logger.info("기존파일 그대로 사용합니다.");			
				boarddata.setBOARD_ORIGINAL(check);
				//<input type="hidden" name="BOARD_FILE" value="${boarddata.BOARD_FILE}">
				//위 문장 때문에 board.setBOARD_FILE()값은 자동 저장됩니다.
			} else {
				//답변글의 경우 파일 첨부에 대한 기능이 없습니다.
				//만약 답변글을 수정할 경우 
				//<input type="file" id="upfile" name="uploadfile" > 엘리먼트가 존재하지 않아
				//private MultipartFile uploadfile;에서 uploadfile은 null 입니다.
				if (uploadfile!=null && !uploadfile.isEmpty()) { 
					logger.info("파일 변경되었습니다.");	
					String saveFolder = mysavefolder.getSavefolder();

					String fileName = uploadfile.getOriginalFilename(); // 원래 파일명
					boarddata.setBOARD_ORIGINAL(fileName);

					String fileDBName = fileDBName(fileName, saveFolder);
					logger.info("fileDBName = " + fileDBName);
					// transferTo(File path) : 업로드한 파일을 매개변수의 경로에 저장합니다.
					uploadfile.transferTo(new File(saveFolder + fileDBName));
					logger.info("transferTo path = " + saveFolder + fileDBName);
					// 바뀐 파일명으로 저장
					boarddata.setBOARD_FILE(fileDBName);
				} else {//기존 파일이 없는데 파일 선택하지 않은 경우 또는 기존 파일이 있었는데 삭제한 경우
					logger.info("선택 파일 없습니다.");
					//<input type="hidden" name="BOARD_FILE" value="${boarddata.BOARD_FILE}">
					//위 태그에 값이 있다면 ""로 값을 변경합니다.
					boarddata.setBOARD_FILE("");//""로 초기화 합니다.
					boarddata.setBOARD_ORIGINAL("");//""로 초기화 합니다.
				}//else end
			}//else end
			
			// DAO에서 수정 메서드 호출하여 수정합니다.
			int result = groupservice.boardModify(boarddata);
			// 수정에 실패한 경우
			if (result == 0) {
				logger.info("게시판 수정 실패");
				mv.addAttribute("url", request.getRequestURL());
				mv.addAttribute("message", "게시판 수정 실패");
				url="error/error";
			} else { // 수정 성공의 경우
				logger.info("게시판 수정 완료");
				// 수정한 글 내용을 보여주기 위해 글 내용 보기 보기 페이지로 이동하기위해 경로를 설정합니다.
				url = "redirect:groupboarddetail";
				rattr.addAttribute("num", boarddata.getBOARD_NUM());
				rattr.addAttribute("group_no", group_no);
			}
			return url;
		}

		//모임 게시판 삭제
		@PostMapping("/delete")
		public String BoardDeleteAction(
										@RequestParam(value="group_no", 
										required=false) int group_no,
										String BOARD_PASS, int num,
										Model mv, RedirectAttributes rattr,
										HttpServletRequest request) {
			//글 삭제 명령을 요청한 사용자가 글을 작성한 사용자인지 판단하기 위해
			//입력한 비밀번호와 저장된 비밀번호를 비교하여 일치하면 삭제합니다.
			boolean usercheck = groupservice.isBoardWriter(num, BOARD_PASS);
			
			//비밀번호가 일치하지 않는 경우
			if(usercheck == false) {
				rattr.addFlashAttribute("result", "passFail");
				rattr.addAttribute("num", num);
				rattr.addAttribute("group_no", group_no);
				return "redirect:groupboarddetail";
			}
			
			//비밀번호 일치하는 경우 삭제처리 합니다.
			int result = groupservice.boardDelete(num);
			
			//삭제 처리 실패한 경우
			if(result == 0) {
				logger.info("게시판 삭제 실패");
				mv.addAttribute("url", request.getRequestURL());
				mv.addAttribute("message", "삭제 실패");
				return "error/error";
			}
			
			//삭제 처리 성공한 경우 - 글 목록 보기 요청을 전송하는 부분입니다.
			logger.info("게시판 삭제 성공");
			rattr.addFlashAttribute("result", "deleteSuccess");
			rattr.addAttribute("group_no", group_no);
			return "redirect:groupboardlist";
		}
		
		//다운로드
		@ResponseBody
		@PostMapping("/down")
		public byte[] BoardFileDown(
									@RequestParam(value="group_no", 
									required=false) int group_no,
									String filename,
									HttpServletRequest request,
									String original,
									HttpServletResponse response) throws Exception {
			//String savaPath = "resources/upload";
			//서블릿의 실행 환경 정보를 담고 있는 객체를 리턴합니다.
			/* ServletContext context = request.getSession().getServletContext();
			String sDownloadPath = context.getRealPath(savaPath); */
			String saveFolder = mysavefolder.getSavefolder();

			String sFilePath = saveFolder + filename;
			
			File file = new File(sFilePath);
			
			byte[] bytes = FileCopyUtils.copyToByteArray(file);
			
			String sEncodig = new String(original.getBytes("utf-8"), "ISO-8859-1");
			
			//Content-Disposition : attachment => 브라우저는 해당 Content를 처리하지 않고, 다운로드하게 됩니다.
			response.setHeader("Content-Disposition", "attachment;filename=" + sEncodig);
			
			response.setContentLength(bytes.length);
			return bytes;
		}
//================================================================================================	
}
