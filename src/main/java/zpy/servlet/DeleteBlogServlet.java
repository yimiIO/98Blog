package zpy.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;

import zpy.model.User;

public class DeleteBlogServlet extends HttpServlet {
	private static final long serialVersionUID = 7339499832960257436L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath()+"/aha/login.jsp");
		} else {
			String id = request.getParameter("id");
			DataSource ds = null;
			try {
				Context context = new InitialContext();
				ds = (DataSource) context.lookup("java:/comp/env/jdbc/mysqlds");
			} catch (Exception e) {
				System.out.println("获取数据源时出错");
			}

			try {
				// 删除博文的SQL语句
				String sql = "delete from blog where id=" + id;
				QueryRunner qr = new QueryRunner(ds);
				qr.update(sql);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/servlet/AdminBlogListServlet")
					.forward(request, response);
		}
	}
}
