package zpy.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import zpy.model.Blog;
import zpy.model.Category;
import zpy.model.Comment;
import zpy.util.DbHelper;

public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = -7152478870507997462L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String method = request.getParameter("method");

		if (method == null) {			
			main(request, response);
			request.getRequestDispatcher("/main.jsp")
					.forward(request, response);
		} else if (method.equals("get")) {
			main(request, response);
			get(request, response);
			request.getRequestDispatcher("/displayBlog.jsp").forward(request,
					response);
		}
	}

	public void get(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String sql = "select id,title,content,createdtime from blog where id="
				+ id;
		QueryRunner qr = DbHelper.getQueryRunner();
		// 根据博文的id值读取一篇博文
		Blog blog = null;
		try {
			List list = (List) qr.query(sql, new BeanListHandler(Blog.class));
			blog = (Blog) list.get(0);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 根据博文的id，读取这个博文下的所有评论
		sql = "select id,username,content,createdtime from comment where blog_id="
				+ id + " order by id desc";
		List commentList = null;
		try {
			commentList = (List) qr.query(sql, new BeanListHandler(
					Comment.class));
		} catch (SQLException e) {
			e.printStackTrace();
		}

		request.setAttribute("blog", blog);
		request.setAttribute("commentList", commentList);
	}

	public void main(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cid=request.getParameter("cid");
		String sql=null;
		if(cid==null){
			sql = "select b.id as id,title,content,createdtime,name as category,c.id as categoryid  from blog b,category c where  category_id=c.id order by b.id desc  limit 0,4";
		}else{
			sql = "select b.id as id,title,content,createdtime,name as category,c.id as categoryid  from blog b,category c where  category_id=c.id and category_id="+cid+" order by b.id desc  limit 0,4";
		}
		
		// DButils中核心类，生成对象时传递数据源对象
		QueryRunner qr = DbHelper.getQueryRunner();

		// 查询最新博文		 
		List blogs = null;
		try {
			blogs = (List) qr.query(sql, new BeanListHandler(Blog.class));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 查询分类
		sql = "select id,name from category order by level desc,id desc";
		List categorys = null;
		try {
			categorys = (List) qr.query(sql,
					new BeanListHandler(Category.class));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 查询最新的评论
		sql = "select id,username,content,blog_id as blogid from comment order by id desc limit 0,4";
		List comments = null;

		try {
			comments = (List) qr.query(sql, new BeanListHandler(Comment.class));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 读取首页需要显示的博文
		request.setAttribute("blogs", blogs);
		// 读取首页需要显示的分类信息
		request.setAttribute("categorys", categorys);
		// 读取首页需要显示的评论
		request.setAttribute("comments", comments);
	}
}
