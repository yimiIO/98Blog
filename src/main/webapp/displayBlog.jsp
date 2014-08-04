<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="zpy.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script src="<%=request.getContextPath()%>/aha/js/menu.js"></script>

<title>做很酷的事情，改变世界</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style.css" />
</head>

<body>
<div id="container">	
	<div id="banner">
	
	</div>

<div id="center">
<div class="content" >

<% Blog blog=(Blog)request.getAttribute("blog"); 
   List list=(List)request.getAttribute("commentList");	  
%>


<table width="745" id="tab" border="0" style='table-layout:fixed; word-break:break-all; word-wrap:break-word'>
  <tr>
    <td><h2><%=blog.getTitle()%></h2></td>
  </tr>
  <tr>
    <td ><%=blog.getContent()%></td>
  
  </tr>
 
  <tr>
    <td><%=blog.getCreatedTime()%></td>
  </tr>
 
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="79">
    
  <% 
  if(list!=null){
  for(int i=0;i<list.size();i++){ 
	  Comment comment=(Comment)list.get(i);
	  %>  
    <table id="tab">
      <tr>
        <td><%=comment.getUsername()%>的评论</td>
        </tr>
      <tr>
        <td ><xmp><%=comment.getContent()%></xmp></td>
        </tr>
      <tr>
        <td><%=comment.getCreatedTime()%></td>
        </tr>
    </table>
    <br><br>
      <%}
  }
  %>
   <p>&nbsp;</p></td>
  </tr>
  
  <tr>
    <td><form id="form1" action=<%=request.getContextPath() %>+"/servlet/CommentServlet" method="post" >
    <input type="hidden" name="method" value="add"/>
    <input type="hidden" name="blog_id" value="<%=blog.getId()%>"/>
      <table id="tab" >
        <tr>
          <td >评论人：</td>
          <td><label>
            <input name="name" type="text" id="name" size="20" />
          </label></td>
        </tr>
        <tr>
          <td>内容：</td>
          <td><label>
            <textarea name="content" cols="40" rows="10" id="content"></textarea>
          </label></td>
        </tr>
        <tr>
          <td><label>
            <input type="submit" name="button" id="button" value="提交" />
          </label></td>
          <td>&nbsp;</td>
        </tr>      
      </table>
        </form>
    </td>
  </tr>
</table>


<br clear="all" />
</div><!-- end content -->
</div><!-- end center -->


<div id="right">
<div class="sidebar">
        <ul>
    	<li>做很酷的事情y</li>
      </ul>
 
   <h2>分类</h2>
   	<ul>



					<%
						List p_cate = (List) request.getAttribute("p_cate");
						for (int i = 0; i < p_cate.size(); i++) {
							Category cate = (Category) p_cate.get(i);
					%>
					<li><a href="#Menu=ChildMenu<%=i%>"
						onclick="DoMenu('ChildMenu<%=i%>')"><%=cate.getName()%></a>



						<ul id="ChildMenu<%=i%>" class="collapsed">

							<%
								Category[][] c_cate = (Category[][]) request
											.getAttribute("c_cate");

									if (c_cate[cate.getLevel()][0] == null) {
							%>
						</ul></li>
					<%
						continue;
							}
							Category cate2 = new Category();
							for (int j = 0; j < 20; j++) {
								System.out.println(cate.getLevel());
								if (c_cate[cate.getLevel()][j] == null) {
									break;
								} else {
									cate2 = c_cate[cate.getLevel()][j];
					%>
					<li><a
						href="<%=request.getContextPath()%>/servlet/HomeServlet?cid=<%=cate2.getId()%>"><%=cate2.getName()%></a>
					</li>
					<%
						}
							}
					%>


				</ul>
				</li>

				<%
					}
				%>







				<ul>
   </ul>

  		    <h2>最近的主题</h2>
		<ul>	
			<%List recentBlogs=(List)request.getAttribute("blogs");
			  for(int i=0;i<recentBlogs.size();i++){
				Blog blog2=(Blog)recentBlogs.get(i);
				%>
	    		<li><a href="<%=request.getContextPath()%>/servlet/HomeServlet?method=get&id=<%=blog2.getId()%>" target="_blank"><%=blog2.getTitle()%></a></li>
            <%}%>
      </ul>
  	
	   
	   <h2>最近的评论</h2>
	  <ul>		
	  <% List comments=(List)request.getAttribute("comments");
	  	 for(int i=0;i<comments.size();i++){
	  		 Comment c=(Comment)comments.get(i);
	  		 
	  %>
	  	    <li><a href="<%=request.getContextPath()%>/servlet/HomeServlet?method=get&id=<%=c.getBlogId()%>" target="_blank"><%=c.getContent()%></a></li>
        <%} %>        
      </ul>
   	
  	   	
</div><!-- end sidebar -->	
</div><!-- end right -->
</div><!-- end container -->
</body>
</html>
  
