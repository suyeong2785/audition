package com.quantom.audition.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.google.common.base.Joiner;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import com.quantom.audition.dto.File;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.service.FileService;
import com.quantom.audition.service.VideoStreamService;
import com.quantom.audition.util.Util;

@Controller
public class FileController {
	@Value("${custom.genFileDirPath}")
	private String genFileDirPath;
	@Autowired
	private FileService fileService;
	@Autowired
	private VideoStreamService videoStreamService;

	@RequestMapping("/usr/file/testMkdirs")
	@ResponseBody
	public String showTestMkdirs() {
		String relTypeCode = "article";
		String dirName = Util.getNowYearMonthDateStr();
		java.io.File file = new java.io.File(genFileDirPath + "/" + relTypeCode + "/" + dirName);
		boolean mkdirsRs = file.mkdirs();

		return "mkdirsRs : " + mkdirsRs;
	}

	@RequestMapping("/usr/file/testUpload")
	public String showTestUpload() {
		return "usr/file/testUpload";
	}
	
	@RequestMapping("/usr/file/getFileByApplymentIdAjax")
	@ResponseBody
	public ResultData getFileByApplymentIdAjax(@RequestParam Map<String, Object> param) {
		
		File file = fileService.getFileByRelIdAndRelTypeCode(param);
		
		return new ResultData("S-1", "해당하는 파일을 가져왔습니다.","file",file);
	}

	@RequestMapping("/usr/file/doTestUpload")
	@ResponseBody
	public ResultData doTestUpload(@RequestParam Map<String, Object> param, HttpServletRequest req,
			MultipartRequest multipartRequest) {

		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		List<Integer> fileIds = new ArrayList<>();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			String[] fileInputNameBits = fileInputName.split("__");

			if (fileInputNameBits[0].equals("file")) {
				int fileSize = (int) multipartFile.getSize();

				if (fileSize <= 0) {
					continue;
				}

				String relTypeCode = fileInputNameBits[1];
				int relId = Integer.parseInt(fileInputNameBits[2]);
				String typeCode = fileInputNameBits[3];
				String type2Code = fileInputNameBits[4];
				int fileNo = Integer.parseInt(fileInputNameBits[5]);
				String originFileName = multipartFile.getOriginalFilename();
				String fileExtTypeCode = Util.getFileExtTypeCodeFromFileName(multipartFile.getOriginalFilename());
				String fileExtType2Code = Util.getFileExtType2CodeFromFileName(multipartFile.getOriginalFilename());
				String fileExt = Util.getFileExtFromFileName(multipartFile.getOriginalFilename()).toLowerCase();

				boolean fileUpdated = false;

				if (relId != 0) {
					int oldFileId = fileService.getFileId(relTypeCode, relId, typeCode, type2Code, fileNo);

					if (oldFileId > 0) {
						fileService.updateFileOnDisk(multipartFile, oldFileId, originFileName, fileExtTypeCode,
								fileExtType2Code, fileExt, fileSize);

						fileCache.refresh(oldFileId);
						fileUpdated = true;
					}
				}

				if (fileUpdated == false) {
					int fileId = fileService.saveFileOnDisk(multipartFile, relTypeCode, relId, typeCode, type2Code,
							fileNo, originFileName, fileExtTypeCode, fileExtType2Code, fileExt, fileSize);

					fileIds.add(fileId);
				}
			}
		}

		int deleteCount = 0;

		for (String inputName : param.keySet()) {
			String[] inputNameBits = inputName.split("__");

			if (inputNameBits[0].equals("deleteFile")) {
				String relTypeCode = inputNameBits[1];
				int relId = Integer.parseInt(inputNameBits[2]);
				String typeCode = inputNameBits[3];
				String type2Code = inputNameBits[4];
				int fileNo = Integer.parseInt(inputNameBits[5]);

				int oldFileId = fileService.getFileId(relTypeCode, relId, typeCode, type2Code, fileNo);

				boolean needToDelete = oldFileId > 0;

				if (needToDelete) {
					fileService.deleteFile(oldFileId);
					fileCache.refresh(oldFileId);
					deleteCount++;
				}
			}
		}

		Map<String, Object> rsDataBody = new HashMap<>();
		rsDataBody.put("fileIdsStr", Joiner.on(",").join(fileIds));
		rsDataBody.put("fileIds", fileIds);

		return new ResultData("S-1", String.format("%d개의 파일을 저장했습니다. %d개의 파일을 삭제했습니다.", fileIds.size(), deleteCount),
				rsDataBody);
	}

	private LoadingCache<Integer, File> fileCache = CacheBuilder.newBuilder().maximumSize(100)
			.expireAfterAccess(2, TimeUnit.MINUTES).build(new CacheLoader<Integer, File>() {
				@Override
				public File load(Integer fileId) {
					return fileService.getFileById(fileId);
				}
			});

	@RequestMapping(value = "/usr/file/img", method = RequestMethod.GET)
	public void showImg(HttpServletResponse response, int id) throws IOException {

		File file = Util.getCacheData(fileCache, id);

		InputStream in = new FileInputStream(file.getFilePath(genFileDirPath));

		switch (file.getFileExtType2Code()) {
		case "jpg":
			response.setContentType(MediaType.IMAGE_JPEG_VALUE);
			break;
		case "png":
			response.setContentType(MediaType.IMAGE_PNG_VALUE);
			break;
		case "gif":
			response.setContentType(MediaType.IMAGE_GIF_VALUE);
			break;
		}

		IOUtils.copy(in, response.getOutputStream());
	}

	@RequestMapping(value = "/usr/file/tempImg", method = RequestMethod.GET)
	public void showTempImg(HttpServletResponse response, int id) throws IOException {

		File file = Util.getCacheData(fileCache, id);

		InputStream in = new FileInputStream(file.getFilePath(genFileDirPath));

		switch (file.getFileExtType2Code()) {
		case "jpg":
			response.setContentType(MediaType.IMAGE_JPEG_VALUE);
			break;
		case "png":
			response.setContentType(MediaType.IMAGE_PNG_VALUE);
			break;
		case "gif":
			response.setContentType(MediaType.IMAGE_GIF_VALUE);
			break;
		}

		IOUtils.copy(in, response.getOutputStream());
	}

	@RequestMapping("/usr/file/streamVideo")
	public ResponseEntity<byte[]> streamVideo(@RequestHeader(value = "Range", required = false) String httpRangeList,
			int id) throws FileNotFoundException {
		File file = Util.getCacheData(fileCache, id);

		InputStream is = new FileInputStream(file.getFilePath(genFileDirPath));

		return videoStreamService.prepareContent(is, file.getFileSize(), file.getFileExt(), httpRangeList);
	}

	@RequestMapping("/usr/file/doUploadEditorBlobAjax")
	@ResponseBody
	public ResultData doUploadEditorBlobAjax(@RequestParam Map<String, Object> param, HttpServletRequest req,
			MultipartRequest multipartRequest) {

		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		List<Integer> fileIds = new ArrayList<>();
		List<Map<String, Object>> fileInfs = new ArrayList<>();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			String[] fileInputNameBits = fileInputName.split("__");

			if (fileInputNameBits[0].equals("file")) {
				byte[] fileBytes = Util.getFileBytesFromMultipartFile(multipartFile);

				if (fileBytes == null || fileBytes.length == 0) {
					continue;
				}

				String relTypeCode = fileInputNameBits[1];
				int relId = Integer.parseInt(fileInputNameBits[2]);
				String typeCode = fileInputNameBits[3];
				String type2Code = fileInputNameBits[4];
				int fileNo = Integer.parseInt(fileInputNameBits[5]);
				String originFileName = multipartFile.getOriginalFilename();
				String fileExtTypeCode = Util.getFileExtTypeCodeFromFileName(multipartFile.getOriginalFilename());
				String fileExtType2Code = Util.getFileExtType2CodeFromFileName(multipartFile.getOriginalFilename());
				String fileExt = Util.getFileExtFromFileName(multipartFile.getOriginalFilename()).toLowerCase();
				int fileSize = (int) multipartFile.getSize();

				int fileId = fileService.saveFileOnDisk(multipartFile, relTypeCode, relId, typeCode, type2Code, fileNo,
						originFileName, fileExtTypeCode, fileExtType2Code, fileExt, fileSize);
				fileIds.add(fileId);
				Map<String, Object> fileInf = new HashMap<>();
				fileInf.put("originFileName", originFileName);
				fileInf.put("fileExtTypeCode", fileExtTypeCode);
				fileInf.put("fileExtType2Code", fileExtType2Code);
				fileInf.put("fileExt", fileExt);
				fileInf.put("fileSize", fileSize);
				fileInf.put("id", fileId);
				fileInf.put("url", "/usr/file/img?id=" + fileId + "&updateDate="
						+ Util.getNowDateStr().replace("-", "").replace(":", "").replace(" ", ""));
				fileInfs.add(fileInf);
			}
		}

		Map<String, Object> rsDataBody = new HashMap<>();
		rsDataBody.put("fileIdsStr", Joiner.on(",").join(fileIds));
		rsDataBody.put("fileIds", fileIds);
		rsDataBody.put("fileInfs", fileInfs);

		return new ResultData("S-1", String.format("%d개의 파일을 저장했습니다.", fileIds.size()), rsDataBody);
	}

	@RequestMapping("/usr/file/doUploadAjax")
	@ResponseBody
	public ResultData doUploadAjax(@RequestParam Map<String, Object> param, HttpServletRequest req,
			MultipartRequest multipartRequest) {

		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		List<Integer> fileIds = new ArrayList<>();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			String[] fileInputNameBits = fileInputName.split("__");

			if (fileInputNameBits[0].equals("file")) {
				int fileSize = (int) multipartFile.getSize();

				if (fileSize <= 0) {
					continue;
				}

				String relTypeCode = fileInputNameBits[1];
				int relId = Integer.parseInt(fileInputNameBits[2]);
				String typeCode = fileInputNameBits[3];
				String type2Code = fileInputNameBits[4];
				int fileNo = Integer.parseInt(fileInputNameBits[5]);
				String originFileName = multipartFile.getOriginalFilename();
				String fileExtTypeCode = Util.getFileExtTypeCodeFromFileName(multipartFile.getOriginalFilename());
				String fileExtType2Code = Util.getFileExtType2CodeFromFileName(multipartFile.getOriginalFilename());
				String fileExt = Util.getFileExtFromFileName(multipartFile.getOriginalFilename()).toLowerCase();

				boolean fileUpdated = false;

				if (relId != 0) {
					int oldFileId = fileService.getFileId(relTypeCode, relId, typeCode, type2Code, fileNo);

					if (oldFileId > 0) {
						fileService.updateFileOnDisk(multipartFile, oldFileId, originFileName, fileExtTypeCode,
								fileExtType2Code, fileExt, fileSize);

						fileCache.refresh(oldFileId);
						fileUpdated = true;
					}
				}

				if (fileUpdated == false) {
					int fileId = fileService.saveFileOnDisk(multipartFile, relTypeCode, relId, typeCode, type2Code,
							fileNo, originFileName, fileExtTypeCode, fileExtType2Code, fileExt, fileSize);

					fileIds.add(fileId);
				}
			}
		}

		int deleteCount = 0;

		for (String inputName : param.keySet()) {
			String[] inputNameBits = inputName.split("__");

			if (inputNameBits[0].equals("deleteFile")) {
				String relTypeCode = inputNameBits[1];
				int relId = Integer.parseInt(inputNameBits[2]);
				String typeCode = inputNameBits[3];
				String type2Code = inputNameBits[4];
				int fileNo = Integer.parseInt(inputNameBits[5]);

				int oldFileId = fileService.getFileId(relTypeCode, relId, typeCode, type2Code, fileNo);

				boolean needToDelete = oldFileId > 0;

				if (needToDelete) {
					fileService.deleteFile(oldFileId);
					fileCache.refresh(oldFileId);
					deleteCount++;
				}
			}
		}

		Map<String, Object> rsDataBody = new HashMap<>();
		rsDataBody.put("fileIdsStr", Joiner.on(",").join(fileIds));
		rsDataBody.put("fileIds", fileIds);

		return new ResultData("S-1", String.format("%d개의 파일을 저장했습니다. %d개의 파일을 삭제했습니다.", fileIds.size(), deleteCount),
				rsDataBody);
	}

	@RequestMapping("/usr/file/doDeleteAjax")
	@ResponseBody
	public ResultData doDeleteAjax(@RequestParam Map<String, Object> param, HttpServletRequest req,
			MultipartRequest multipartRequest) {
		
		int deleteCheck = Util.getAsInt(param.get("deleteCheck"));
		int fileIdsStr = Util.getAsInt(param.get("fileIdsStr"));

		if (deleteCheck == 1) {
			if(fileIdsStr != 0) {
				fileService.deleteFile(Util.getAsInt(param.get("fileIdsStr")));
				return new ResultData("S-1",String.format("%d번 파일을 삭제했습니다.", fileIdsStr));
			}
			return new ResultData("F-1","파일번호를 입력해주세요.");
		}
		return new ResultData("F-2",String.format("파일삭제 체크박스가 체크되지 않았습니다."));
		
	}
}
