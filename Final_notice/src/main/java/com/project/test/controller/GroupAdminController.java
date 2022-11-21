package com.project.test.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
import com.project.test.service.GroupAdminService;
import com.project.test.service.MySaveFolder;

@Controller
@RequestMapping(value="/group")
public class GroupAdminController {

	private static final Logger logger = LoggerFactory.getLogger(GroupController.class);
	private GroupAdminService groupservice;
	private MySaveFolder mysavefolder;

	@Autowired
	public GroupAdminController(GroupAdminService groupservice, MySaveFolder mysavefolder) {
		this.groupservice = groupservice;
		this.mysavefolder = mysavefolder;
	}

	@RequestMapping(value = "/groupuserinfo")//모임 회원 정보 출력
	public ModelAndView memberList(@RequestParam(value = "group_no", defaultValue = "1", required = false) int group_no,
			@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "limit", defaultValue = "10", required = false) int limit, String userid,
			ModelAndView mv, @RequestParam(value = "search_field", defaultValue = "-1", required = false) int index,
			@RequestParam(value = "search_word", defaultValue = "", required = false) String search_word) {

		int listcount = groupservice.getUserSearchListCount(index, search_word, group_no, userid);// 총 리스트 수를 받아옴
		List<GroupUser> list = groupservice.getUserSearchList(index, search_word, page, limit, group_no, userid);

		int maxpage = (listcount + limit - 1) / limit;
		int startpage = ((page - 1) / 10) * 10 + 1;
		int endpage = startpage + 10 - 1;

		if (endpage > maxpage)
			endpage = maxpage;

		mv.setViewName("group/groupuserinfo");
		mv.addObject("page", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		mv.addObject("listcount", listcount);
		mv.addObject("memberlist", list);
		mv.addObject("search_field", index);
		mv.addObject("search_word", search_word);
		mv.addObject("group_no", group_no);
		return mv;
	}
	
	@RequestMapping(value = "/groupjoinagree")
	public ModelAndView groupJoinagree(int group_no, ModelAndView mv) {
		mv.addObject("group_no", group_no);
		mv.setViewName("group/groupjoinagree");
		return mv;
	}


	@ResponseBody // 각 메서드의 실행 결과는 JSON으로 변환되어 HTTP Response BODY에 설정된다
	@RequestMapping(value = "/list_ajax", method = RequestMethod.GET)//모임 가입신청 회원 목록 출력
	public Map<String, Object> userListAjax(
			@RequestParam(value = "group_no", defaultValue = "1", required = false) int group_no, 
			@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "limit", defaultValue = "3", required = false) int limit) {

		int listcount = groupservice.getJoinListCount(group_no); // 총 리스트 수를 받아옴
		// 총 페이지 수
		int maxpage = (listcount + limit - 1) / limit;
		// 현재 페이지에 보여줄 시작 페이지 수
		int startpage = ((page - 1) / 10) * 10 + 1;
		// 현재 페이지에 보여줄 마지막 페이지 수
		int endpage = startpage + 10 - 1;

		if (endpage > maxpage)
			endpage = maxpage;

		List<GroupJoin> list = groupservice.getJoinList(group_no, page, limit);// 리스트를 받아옴

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("maxpage", maxpage);
		map.put("startpage", startpage);
		map.put("endpage", endpage);
		map.put("listcount", listcount);
		map.put("list", list);
		map.put("group_no", group_no);
		map.put("limit", limit);
		return map;
	}

	
	@ResponseBody
	@GetMapping(value = "/joinAccept")//모임 회원 가입 승인
	public int joinAccept(@RequestParam("group_no") int group_no,
			@RequestParam("requestList[]") List<String> requestList) {

		return groupservice.acceptmembers(requestList, group_no);

	}

	@ResponseBody
	@GetMapping(value = "/DisAgree")//모임 회원 가입 거절
	public int disAgree(@RequestParam("group_no") int group_no, String userid,
			@RequestParam("requestList[]") List<String> requestList) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("requestid", requestList);
		map.put("group_no", group_no);
		int result = groupservice.deleteRequest(map);
		return result;
	}

	@GetMapping("/grouproleupdate")//모임장 권한 부여
	public String groupRoleupdate(String userid, int group_no, String manager, RedirectAttributes rattr) {
		groupservice.grouproleupdate(userid, manager, group_no);
		rattr.addFlashAttribute("result", "roleupdateSuccess");
		return "redirect:/main/list";
	}

	// 모임 회원 강퇴
	@RequestMapping(value = "/groupuserdelete", method = RequestMethod.GET)
	public String groupuserdelete(@RequestParam("userid") String userid, @RequestParam("group_no") int group_no,
			RedirectAttributes rattr) {

		groupservice.groupuserdelete(userid, group_no);

		rattr.addAttribute("group_no", group_no);

		return "redirect:groupuserinfo";
	}

	@GetMapping("/groupdelete")
	public String BoardDeleteAction(int num, Model mv, RedirectAttributes rattr, HttpServletRequest request,
			@RequestParam(value = "group_no", required = false) int group_no) {
		// 글 삭제 명령을 요청한 사용자가 글을 작성한 사용자인지 판단하기 위해
		// 입력한 비밀번호와 저장된 비밀번호를 비교하여 일치하면 삭제합니다.

		// 비밀번호 일치하는 경우 삭제처리 합니다.
		int result = groupservice.groupDelete(num);

		// 삭제 처리 실패한 경우
		if (result == 0) {
			logger.info("모임 삭제 실패");
			mv.addAttribute("url", request.getRequestURL());
			mv.addAttribute("message", "삭제 실패");
			return "error/error";
		}

		// 삭제 처리 성공한 경우 - 글 목록 보기 요청을 전송하는 부분입니다.
		logger.info("모임 삭제 성공");
		rattr.addFlashAttribute("result", "deleteSuccess");
		return "redirect:/main/list";
	}

	@GetMapping("/groupmodifyView")
	public ModelAndView ModifyView(int num, ModelAndView mv, HttpServletRequest request,
			@RequestParam(value = "group_no", required = false) int group_no) {
		Group groupdata = groupservice.getDetail(num);

		// 글 내용 불러오기 실패한 경우입니다.
		if (groupdata == null) {
			logger.info("수정보기 실패");
			mv.setViewName("error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "수정보기 실패입니다.");
			mv.addObject("group_no", group_no);
			mv.addObject("num", num);
			return mv;
		}

		logger.info("(수정)상세보기 성공");
		// 수정 폼 페이지로 이동할 때 원문 글 내용을 보여주기 때문에 boarddata 객체를
		// ModelAndView 객체에 저장합니다.
		mv.setViewName("group/group_modify");
		// 글 수정 폼 페이지로 이동하기 위해 경로를 설정합니다.
		mv.addObject("groupdata", groupdata);
		mv.addObject("group_no", group_no);
		return mv;
	}

	@PostMapping("/groupmodifyAction")
	public String GroupModifyAction(Group groupdata, String check, Model mv, HttpServletRequest request,
			RedirectAttributes rattr, @RequestParam(value = "group_no", required = false) int group_no)
			throws Exception {

		String url = "";

		MultipartFile uploadfile = groupdata.getUploadfile();
		/*
		 * String saveFolder =
		 * request.getSession().getServletContext().getRealPath("resources") +
		 * "/upload";
		 */

		if (check != null && !check.equals("")) { // 기존파일 그대로 사용하는 경우입니다.
			logger.info("기존파일 그대로 사용합니다.");
			groupdata.setGroup_original(check);
			// <input type="hidden" name="BOARD_FILE" value="${boarddata.BOARD_FILE}">
			// 위 문장 때문에 board.setBOARD_FILE()값은 자동 저장됩니다.
		} else {
			// 답변글의 경우 파일 첨부에 대한 기능이 없습니다.
			// 만약 답변글을 수정할 경우
			// <input type="file" id="upfile" name="uploadfile" > 엘리먼트가 존재하지 않아
			// private MultipartFile uploadfile;에서 uploadfile은 null 입니다.
			if (uploadfile != null && !uploadfile.isEmpty()) {
				logger.info("파일 변경되었습니다.");
				String saveFolder = mysavefolder.getSavefolder();

				String fileName = uploadfile.getOriginalFilename(); // 원래 파일명
				groupdata.setGroup_original(fileName);

				String fileDBName = fileDBName(fileName, saveFolder);
				logger.info("fileDBName = " + fileDBName);
				// transferTo(File path) : 업로드한 파일을 매개변수의 경로에 저장합니다.
				uploadfile.transferTo(new File(saveFolder + fileDBName));
				logger.info("transferTo path = " + saveFolder + fileDBName);
				// 바뀐 파일명으로 저장
				groupdata.setGroup_img(fileDBName);
			} else {// 기존 파일이 없는데 파일 선택하지 않은 경우 또는 기존 파일이 있었는데 삭제한 경우
				logger.info("선택 파일 없습니다.");
				// <input type="hidden" name="BOARD_FILE" value="${boarddata.BOARD_FILE}">
				// 위 태그에 값이 있다면 ""로 값을 변경합니다.
				groupdata.setGroup_img("");// ""로 초기화 합니다.
				groupdata.setGroup_original("");// ""로 초기화 합니다.
			} // else end
		} // else end

		// DAO에서 수정 메서드 호출하여 수정합니다.
		int result = groupservice.groupModify(groupdata);
		// 수정에 실패한 경우
		if (result == 0) {
			logger.info("모임 수정 실패");
			mv.addAttribute("url", request.getRequestURL());
			mv.addAttribute("message", "모임 수정 실패");
			url = "error/error";
		} else { // 수정 성공의 경우
			logger.info("모임 수정 완료");
			// 수정한 글 내용을 보여주기 위해 글 내용 보기 보기 페이지로 이동하기위해 경로를 설정합니다.
			url = "redirect:group_detail";
			rattr.addAttribute("num", groupdata.getGroup_no());
			rattr.addAttribute("group_no", group_no);
		}
		return url;
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
		if (!(path1.exists())) {
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

}
