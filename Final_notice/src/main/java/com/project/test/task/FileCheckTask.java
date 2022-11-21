package com.project.test.task;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.project.test.service.MySaveFolder;
import com.project.test.service.BoardService;

@Service
public class FileCheckTask {

	private static final Logger logger = LoggerFactory.getLogger(FileCheckTask.class);
	
	@Autowired
	private MySaveFolder mysavefolder;
	@Autowired
	private BoardService boardService;
	
	//스케줄러를 이용해서 주기적으로
	//매일, 매주, 매월 프로그램 실행을 위한 작업을 실시합니다.
	//1000 : 밀리세컨드 단위입니다(1초)
	
	//@Scheduled(fixedDelay = 1000)
	public void test() throws Exception {
		logger.info("test");
	}
	
	//cron 사용법
	//seconds(초 : 0 ~ 59) minutes(분 : 0 ~ 59) hours(시 : 0 ~ 23) day(일 : 1 ~ 31)
	//months(달 : 1 ~ 12) day of week(요일 : 0 ~ 6) year(optional)
	//				  초 분 시 일	달 요일
	@Scheduled(cron = "0 * * * * *")
	public void checkFiles() throws Exception {
		logger.info("checkFiles");
		String saveFolder = mysavefolder.getSavefolder();

		List<String> deleteFileList = boardService.getDeleteFileList();
		
		//for(String filename : deleteFileList) {
		for (int i = 0; i < deleteFileList.size(); i++) {
			String filename = deleteFileList.get(i);
			File file = new File(saveFolder + filename);
			if(file.exists()) {
				if(file.delete()) {
					logger.info(file.getPath() + " 삭제되었습니다.");
					boardService.deleteFileList(filename);
				}
			} else {
				logger.info(file.getPath());
			}
		}
	}
}
