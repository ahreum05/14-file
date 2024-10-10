<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String fileName = request.getParameter("fileName");
    // 파일 읽기 + 응답헤더에 파일 정보 저장
    String realPath = request.getServletContext().getRealPath("storage");
    File file = new File(realPath, fileName);
    System.out.println("다운받을 파일 : " + file);
    
    // 응답헤더에 파일 정보 저장
    // => 1. 파일명 2. 파일의 크기
    // response.setHeader("키","데이터")
    // 한글 파일명 처리
    // replaceAll("\\+"," ") : 파일명에 공백문자가 있을 경우, 공백문자가 +로 
    //                         변경되는데, 그 +를 공백문자로 변경하는 것
    
    String str_fileName = 
    new String(URLEncoder.encode(fileName, "UTf-8")).replaceAll("\\+", " ");
    response.setHeader("Content-Disposition", "attachement; fileName=" + str_fileName);
    response.setHeader("Content-Length", String.valueOf(file.length())); 
    
    // 2. 파일 읽기
    // 1) 파일 열기
    FileInputStream fis = new FileInputStream(file);
    BufferedInputStream bis = new BufferedInputStream(fis);
    // 2) 파일 읽기
    byte[] b = new byte[(int)file.length()];
    bis.read(b, 0, b.length);
    // 3) 파일 닫기
    bis.close();
    fis.close();
    
    // 3. 클라이언트로 파일 전송
    // out 객체 초기화
    // => 기존 jsp의 out 객체의 스트림을 지우고 출력해야, 예외가 발생하지 않는다고 함
    out.clear();
    out = pageContext.pushBody();
    // 클라이언트로 전송
    ServletOutputStream sos = response.getOutputStream();
    BufferedOutputStream bos = new BufferedOutputStream(sos);
    bos.write(b);
    bos.close();
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>