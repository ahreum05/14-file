<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
/**
   // enctype="multipart/form-data"일 경우에는 request로는 문자열을 읽을 수 없음
   String subject = request.getParameter("subject");
   String content = request.getParameter("content");
   System.out.println("subject = " + subject);
   System.out.println("content = " + subject);
*/
   // 실제 파일 저장 폴더 위치 확인
   String realFolder = request.getServletContext().getRealPath("storage");
   System.out.println("realFolder = " + realFolder);
   // request : 요청 처리 객체
   // realFolder : 파일 저장 폴더 위치
   // 5*1024*1024 : 업로드 할 때의 최대 파일 크기, 5MB = 5*1KB*1KB
   // "UTF-8" : 인코딩 설정
   // new DefaultFileRenamePolicy() : 업로드시, 저장 폴더에 똑같은 파일이름이 있을 경우, 기존 파일 이름에 숫자를 덧붙여서 저장시키는 설정 클래스. 이 클래스 설정에서 뺴면, 같은 이름으로는 1개만 저장됨
   String subject = "";
   String content = "";
   String originalFileName1 = "";
   String originalFileName2 = "";
   String fileName1 = "";
   String fileName2 = "";
   long fileSize1 =  0, fileSize2 = 0;
   
   MultipartRequest multi = new MultipartRequest(request, realFolder, 5*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
   subject = multi.getParameter("subject");
   content = multi.getParameter("content");
   // 전달 파일명
   originalFileName1 = multi.getOriginalFileName("upload1");
   originalFileName2 = multi.getOriginalFileName("upload2");
   // 저장된 파일명
   fileName1 = multi.getFilesystemName("upload1");
   fileName2 = multi.getFilesystemName("upload2");
   // 저장된 파일 크기
   File file1 = multi.getFile("upload1");
   File file2 = multi.getFile("upload2");
   if(file1 != null) fileSize1 = file1.length();
   if(file2 != null) fileSize2 = file2.length();
   
   if(originalFileName1.equals("")){
      PrintWriter out1 = response.getWriter();
      out.println("<script>");
      out.println("alert('파일의 용량이 너무 큽니다.')");
      out.println("history.back();");
      out.println("</script>");
      
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <ul>
      <li>제목 : <%=subject %></li>
      <li>내용 : <%=content %></li>
      <li>원본파일명 : <%=originalFileName1 %></li>
      <li>파일 : <a href="fileDownload.jsp?fileName=<%=fileName1%>">
                 <%=fileName1 %></a>
      </li>
      <li>크기 : <%=fileSize1 %></li>
      <br><br>
      <li>원본파일명 : <%=originalFileName2 %></li>
      <li>파일 : <%=fileName2 %></li>
      <li>크기 : <%=fileSize2 %></li>
   </ul>
   <img alt="이미지" src="storage/<%=fileName1 %>" width="150">
   <img alt="이미지" src="storage/<%=fileName2 %>" width="150">
</body>
</html>