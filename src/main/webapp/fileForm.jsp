<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일</title>
<script type="text/javascript">
    // 파일의 크기가 5MB가 넘는 지 검사
    function checkFileSize() {
    	var input1 = document.getElementById("upload1");
    	var input2 = document.getElementById("upload2");
    	// input1.files.length : 선택된 파일의 갯수
    	if(input1.files.length > 0 && input2.files.length > 0 ){
            var fileName1 = input1.files[0].name;
            var fileSize1 = input1.files[0].size; 
            var fileName2 = input2.files[0].name;
            var fileSize2 = input2.files[0].size;
            
            if((fileSize1 + fileSize2) > 5*1024*1024) {
            	// 파일의 크기가 5MB 이상이면 전송안함
            	var str1 = fileName1 + " : " + fileSize1;
            	var str2 = fileName2 + " : " + fileSize2;
            	alert("파일의 크기가 5MB가 넘었습니다.\n" + str1 + "\n" + str2);
            } else {
            	// 파일의 크기가 5MB 미만이면 전송
            	document.form1.submit();
            }
    	} else {
    		alert("파일을 선택하세요.")
    	}
    }
</script>
</head>
<body>
    <form action="fileUpload.jsp" enctype="multipart/form-data" 
          method="post" name="form1">
       <table border="1">
           <tr>
                <th width="50">제목</th>
                <td><input type="text" name="subject" size="50"></td>
           </tr>
           <tr>
                <th>내용</th>
                <td><textarea name="content" rows="15" cols="45"></textarea></td>
           </tr>
           <tr>
                <td colspan="2">
                    <input type="file" name="upload1" id="upload1" size="50">
                </td>
           </tr>
           <tr>
                <td colspan="2">
                    <input type="file" name="upload2" id="upload2" size="50">
                </td>
           </tr>
           <tr>
                <td colspan="2" align="center">
                    <input type="button" value="파일업로드"
                        onclick="checkFileSize()">
                    <input type="reset" value="다시작성">
                </td>
           </tr>
       </table>
    </form>
</body>
</html>