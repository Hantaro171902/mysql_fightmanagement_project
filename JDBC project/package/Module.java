package Demo;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import java.sql.*;

public class Module {
	Connection con;
	PreparedStatement pst;

	public void Connect() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","");
			System.out.println("Connected");
		}catch (Exception ex) { //exception handling (if any)
			System.out.println("Cannot connect");
			ex.printStackTrace();
		}
	}

}
