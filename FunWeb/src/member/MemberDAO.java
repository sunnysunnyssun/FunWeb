package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
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
	
	
	public int insertMember(MemberBean mb) {
		
		int result=0;		
		try {
			con = getConnection();
			String sql ="insert into member"
					+ " (id, pass, name, reg_date, email, address, mobile)"
					+ " values(?,?,?,?,?,?,?)";
			ps = con.prepareStatement(sql);			
				ps.setString(1,mb.getId());
				ps.setString(2,mb.getPass());
				ps.setString(3,mb.getName());
				ps.setTimestamp(4, mb.getReg_date());
				ps.setString(5, mb.getEmail());
				ps.setString(6, mb.getAddress());
//				ps.setString(7, mb.getPhone());
				ps.setString(7, mb.getMobile());				
			result = ps.executeUpdate();	 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cleaning(con, ps, rs);
		}		
		return result;
	}
	
	public int userCheck(String id, String pass) {
		
		int check=0;
		
		try {
			con = getConnection();
			String sql = "select * from member where id=?";
			
			ps = con.prepareStatement(sql);	
				ps.setString(1, id);
			rs = ps.executeQuery();
			
			if(rs.next()==false) {
				check=-1;				
			}
			else {		// if로하는게 좋은지? while로 하는게 좋은지?
	//			while(rs.next()){				
					if(rs.getString("pass").equals(pass)) {
						check=1;
					}
					else {
						check=0;
					}
	//			}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cleaning(con, ps, rs);
		}	
		return check;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}	

	
	
	
	
	