<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="zpy.model.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>做很酷的事情，改变世界</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style.css" />



	<script language="JavaScript" type="text/javascript">
						function closeHTML(str) {
							var arrTags = [ "span", "font", "b", "u", "i",
									"h1", "h2", "h3", "h4", "h5", "h6", "p",
									"li", "ul", "table", "div" ];
							for ( var i = 0; i < arrTags.length; i++) {
								var intOpen = 0;
								var intClose = 0;
								var re = new RegExp("\\<" + arrTags[i]
										+ "( [^\\<\\>]+|)\\>", "ig");
								var arrMatch = str.match(re);
								if (arrMatch != null)
									intOpen = arrMatch.length;
								re = new RegExp("\\<\\/"+arrTags[i]+"\\>", "ig");
								arrMatch = str.match(re);
								if (arrMatch != null)
									intClose = arrMatch.length;
								for ( var j = 0; j < intOpen - intClose; j++) {
									str += "</"+arrTags[i]+">";
								}
								/*for(var j=(intOpen-intClose-1);j>=0;j--){ 
								 str+="</"+arrTags[i]+">"; 
								 }*/
							}
							return str;
						}
					</script>
</head>
<body>
	<div id="container">
		<div id="banner">
			<h1>
				<a href="<%=request.getContextPath() %>"></a>
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
					<a href="<%=request.getContextPath()%>/servlet/HomeServlet?method=get&id=<%=blog.getId()%>"
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
					<input type="hidden" value="<%=newString %>" id="aaa"/>
							<script language="JavaScript" type="text/javascript">
								var blog = closeHTML(document.getElementById('aaa').value);
								
								document.write(blog);
							</script>
					</br>
					</br>

					<%=date%>
					<%=time%>
					<a
						href="<%=request.getContextPath()%>/servlet/HomeServlet?cid=<%=blog.getCategoryId()%>"><%=blog.getCategory()%></a>
					| <a href="">评论</a>
					</p>
				</div>
				<%
					}
				%>

				<!-- 产生分页的连接-->
				&nbsp; 1/2 &nbsp;
				<!-- zpy a href="tm?method=h&p=2"-->
				&gt;&gt;</a>
				<!-- end list -->


				<br clear="all" />
			</div>
			<!-- end content -->
		</div>
		<!-- end center -->

		<div id="right">
			<div class="sidebar">
				<ul>
					<li>BernieZPY-做很酷的事情，改变世界</li>
				</ul>


				<h2>分类</h2>
				<ul>
					<li><a href="<%=request.getContextPath() %>">全部</a>
					</li>
					<%
						List categorys = (List) request.getAttribute("categorys");
						for (int i = 0; i < categorys.size(); i++) {
							Category category = (Category) categorys.get(i);
					%>
					<li><a
						href="<%=request.getContextPath()%>/servlet/HomeServlet?cid=<%=category.getId()%>"><%=category.getName()%></a>
					</li>
					<%
						}
					%>
				</ul>

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
	<script type="text/javascript">
		var cnzz_protocol = (("https:" == document.location.protocol) ? " https://"
				: " http://");
		document
				.write(unescape("%3Cspan id='cnzz_stat_icon_1000116636'%3E%3C/span%3E%3Cscript src='"
						+ cnzz_protocol
						+ "s22.cnzz.com/z_stat.php%3Fid%3D1000116636%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));
	</script>
</body>
</html>