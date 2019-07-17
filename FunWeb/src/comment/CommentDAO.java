package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommentDAO {

	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	

	public Connection getConnection() throws Exception{	
// 	-- Connection : java.sql		
		Context init = new InitialContext();
//		-- Context : javax.naming
//		-- InitialContext() : javax.naming
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
//		-- init.lookup : object 타입 리턴 (- > DataSource 형 변환)
//		-- DataSource : java.sql;
		Connection con = ds. getConnection();
//		-- getConnection : DataSource -> Connection 형 변환 메서드
		return con;		
	}	
	
	
	public void cleaning(Connection con, PreparedStatement ps, ResultSet rs) {
//	-- PreparedStatement : java.sql
//	-- ResultSet : java.sql
		if(rs!=null) {
			try {rs.close();} 
			catch (SQLException ex) {}		
		}
		if(ps!=null) {				
			try {ps.close();} 
			catch (SQLException ex) {}				
		}
		if(con!=null) {				
			try {con.close();} 
			catch (SQLException ex) {}				
		}			
	}
	
	
	public int insertComment(CommentDTO cdto) {
		try {
			con = getConnection();
				
			String sql = "insert into comment values(null, ?,?,?,?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, cdto.getName());
			ps.setString(2, cdto.getContnet());
			ps.setTimestamp(3, cdto.getDate());
			ps.setInt(4, cdto.getBoardNum());	// boardNum
//		num, name, content, date, boardNum
			System.out.println(ps);

			int result = ps.executeUpdate();
			System.out.println(result +"성공했니?");
			return result;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			cleaning(con, ps, rs);
		}
		return 0;
	}
	
	
	public void deleteComment(CommentDTO cdto) {
		int num = cdto.getNum();
		try {
			con = getConnection();
				
			String sql = "delete from comment where num=? and pageNum=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, cdto.getName());
			ps.setString(2, cdto.getContnet());
			ps.setTimestamp(3, cdto.getDate());
			ps.setInt(4, num);	// boardNum
//		num, name, content, date, boardNum
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			cleaning(con, ps, rs);
		}
	}
	
	
	public List<CommentDTO> getCommentList(int boardNum){
		List<CommentDTO> cList = new ArrayList<>();
		try {
			con=getConnection();
			String sql = "select * from comment where boardNum=? order by num desc";
			ps = con.prepareStatement(sql);	
			
			ps.setInt(1, boardNum);
			System.out.println(ps);
			rs = ps.executeQuery();

			
			while(rs.next()) {
				CommentDTO cdto = new CommentDTO(rs.getInt("num"), rs.getString("name")
				, rs.getString("content"), rs.getTimestamp("date"), rs.getInt("boardNum"));
				cList.add(cdto);
			}
			return cList;
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("sql 예외 오류 : " +e.getMessage());
		} catch (Exception e) {
			System.out.println("예외 발생 : " +e.getMessage());
			e.printStackTrace();
		}	finally {
			cleaning(con, ps, rs);
		}
		return null;
	}
}
