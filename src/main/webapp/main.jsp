<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="zpy.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script src="<%=request.getContextPath()%>/aha/js/menu.js"></script>
<script src="<%=request.getContextPath()%>/aha/js/closeHTML.js"></script>
<meta name="baidu-site-verification" content="BEP77teu3W"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>做很酷的事情</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/style.css" />



</head>
<body>
	<div id="container">
		<div id="banner">
			<h1>
				<a href="<%=request.getContextPath()%>"></a>
			</h1>
		</div>

		<div id="center">
			<div class="content">
				<!-- list blog begin  -->
				<%
					List list = (List) request.getAttribute("blogs");
					for (int i = 0; i < list.size(); i++) {
						Blog blog = (Blog) list.get(i);

						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String date = sdf.format(blog.getCreatedTime());

						sdf = new SimpleDateFormat("HH:mm:ss");
						String time = sdf.format(blog.getCreatedTime());
				%>

				<h2>
					<a
						href="<%=request.getContextPath()%>/servlet/HomeServlet?method=get&id=<%=blog.getId()%>"
						target="_blank"><img src="/aha/images/import.gif" /><%=blog.getTitle()%></a>
				</h2>
				<div class="entry">
					<a id="6"></a>


					<%
						String source = blog.getContent();
							int length = 2000;
							if (source.length() < 2000) {
								length = source.length();
							}
							String newString = source.substring(0, length);

							request.setAttribute("newString", newString);
					%>
					<input type="hidden" value="<%=newString%>" id="aaa" />
					<script language="JavaScript" type="text/javascript">
						var blog = closeHTML(document.getElementById('aaa').value);

						document.write(blog);
					</script>
					</br> </br>
					<p class="posted">
						<%=date%>
						<%=time%>
						<a
							href="<%=request.getContextPath()%>/servlet/HomeServlet?cid=<%=blog.getCategoryId()%>"><%=blog.getCategory()%></a>
						| <a href="">评论</a>
					</p>
					<br> <br>
				</div>
				<%
					}
				%>

				<!-- 产生分页的连接-->
				&nbsp; 1/2 &nbsp; <a href="tm?method=h&p=2"> &gt;&gt;</a>
				<!-- end list -->


				<br clear="all" />
			</div>
			<!-- end content -->




			<h1 align="center">
				<script type="text/javascript">
					var cnzz_protocol = (("https:" == document.location.protocol) ? " https://"
							: " http://");
					document
							.write(unescape("%3Cspan id='cnzz_stat_icon_1000116636'%3E%3C/span%3E%3Cscript src='"
									+ cnzz_protocol
									+ "s22.cnzz.com/z_stat.php%3Fid%3D1000116636%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));
				</script>

			</h1>


		</div>
		<!-- end center -->




		<div id="right">
			<div class="sidebar">
				<ul>
					<li>做很酷的事情</li>
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


					<h2>最近的主题</h2>
					<ul>
						<%
							List recentBlogs = (List) request.getAttribute("blogs");
							for (int i = 0; i < recentBlogs.size(); i++) {
								Blog blog = (Blog) recentBlogs.get(i);
						%>
						<li><a
							href="<%=request.getContextPath()%>/servlet/HomeServlet?method=get&id=<%=blog.getId()%>"
							target="_blank"><%=blog.getTitle()%></a>
						</li>
						<%
							}
						%>
					</ul>


					<h2>最近的评论</h2>
					<ul>
						<%
							List comments = (List) request.getAttribute("comments");
							for (int i = 0; i < comments.size(); i++) {
								Comment c = (Comment) comments.get(i);
						%>
						<li><a
							href="<%=request.getContextPath()%>/servlet/HomeServlet?method=get&id=<%=c.getBlogId()%>"
							target="_blank"><%=c.getContent()%></a>
						</li>
						<%
							}
						%>
					</ul>
			</div>










			<!-- end sidebar -->
		</div>
		<!-- end right -->
	</div>
	<!-- end container -->





</body>





</html>



