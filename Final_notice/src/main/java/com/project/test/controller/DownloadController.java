package com.project.test.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.test.service.MySaveFolder;

@Controller
public class DownloadController {
	private static final Logger logger = LoggerFactory.getLogger(DownloadController.class);
	private MySaveFolder mysavefolder;
	/*
	 * @Autowired public GroupController(GroupService groupservice) {
	 * this.groupservice = groupservice; }
	 */
	
	@Autowired
	public DownloadController(MySaveFolder mysavefolder) {
		this.mysavefolder = mysavefolder;
	}
	@RequestMapping(value="/down")
	@ResponseBody
	public byte[] BoardFileDown(String filename,
								HttpServletRequest request,
								String original,
								HttpServletResponse response) throws Exception{
		//String savePath="resources/upload";
		//서블릿의 실행 환경 정보를 담고 있는 객체를 리턴한다.
		/*
		 * ServletContext context = request.getSession().getServletContext(); String
		 * sDownloadPath = context.getRealPath(savePath);
		 */String saveFolder = mysavefolder.getSavefolder();

		String sFilePath = saveFolder + filename;
		File file = new File(sFilePath);
		byte[] bytes = FileCopyUtils.copyToByteArray(file);
		String sEncoding = new String(original.getBytes("utf-8"), "ISO-8859-1");
		//Content-Disposition: attachment: 브라우저는 해당 Content를 처리하지 않고 다운로드하게 된다.
		response.setHeader("Content-Disposition", "attachment;filename=" + sEncoding);
		response.setContentLength(bytes.length);
		return bytes;
	}
	
}
