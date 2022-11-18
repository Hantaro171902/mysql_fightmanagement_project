package Demo;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import java.awt.Font;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingConstants;

import java.sql.PreparedStatement;
import java.sql.*;

import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.SQLException;
import java.awt.event.ActionEvent;

public class UI_Employee extends Module{

	private JFrame frame;
	private JTextField txtDepid;
	private JTextField txtFname;
	private JTextField txtGender;
	private JTextField txtTel;
	private JTextField txtEmpid;
	private JTextField txtLname;
	private JTextField txtBday;
	private JTextField txtEmail;
	private JTextField txtRole;
	private JTextField txtHday;
	private JTextField txtSal;
	private JTextField txtBonus;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					UI_Employee window = new UI_Employee();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public UI_Employee() {
		initialize();
		Connect();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 524, 430);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);
		
		JLabel lblTitle = new JLabel("EMPLOYEE");
		lblTitle.setHorizontalAlignment(SwingConstants.CENTER);
		lblTitle.setFont(new Font("Tahoma", Font.BOLD, 16));
		lblTitle.setBounds(189, 10, 122, 32);
		frame.getContentPane().add(lblTitle);
		
		JPanel panel = new JPanel();
		panel.setBounds(10, 64, 450, 290);
		frame.getContentPane().add(panel);
		panel.setLayout(null);
		
		txtDepid = new JTextField();
		txtDepid.setBounds(302, 13, 96, 19);
		panel.add(txtDepid);
		txtDepid.setColumns(10);
		
		JLabel lblEmp = new JLabel("Emp ID");
		lblEmp.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblEmp.setBounds(10, 10, 67, 22);
		panel.add(lblEmp);
		
		JLabel lblFname = new JLabel("First name");
		lblFname.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblFname.setBounds(10, 37, 67, 22);
		panel.add(lblFname);
		
		JLabel lblLname = new JLabel("Last name");
		lblLname.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblLname.setBounds(216, 37, 67, 22);
		panel.add(lblLname);
		
		JLabel lblGender = new JLabel("Gender");
		lblGender.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblGender.setBounds(10, 69, 67, 22);
		panel.add(lblGender);
		
		JLabel lblBday = new JLabel("Birthday");
		lblBday.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblBday.setBounds(216, 69, 67, 22);
		panel.add(lblBday);
		
		JLabel lblTel = new JLabel("Tel phone");
		lblTel.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblTel.setBounds(10, 101, 67, 22);
		panel.add(lblTel);
		
		JLabel lblEmail = new JLabel("Email");
		lblEmail.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblEmail.setBounds(216, 101, 41, 22);
		panel.add(lblEmail);
		
		JPanel panel_1 = new JPanel();
		panel_1.setBounds(10, 144, 259, 146);
		panel.add(panel_1);
		panel_1.setLayout(null);
		
		JLabel lblRole = new JLabel("Role");
		lblRole.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblRole.setBounds(10, 10, 60, 21);
		panel_1.add(lblRole);
		
		JLabel lblHday = new JLabel("Hired date");
		lblHday.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblHday.setBounds(10, 41, 81, 21);
		panel_1.add(lblHday);
		
		JLabel lblSal = new JLabel("Salary");
		lblSal.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblSal.setBounds(10, 72, 81, 21);
		panel_1.add(lblSal);
		
		JLabel lblBonus = new JLabel("Bonus");
		lblBonus.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblBonus.setBounds(10, 103, 81, 21);
		panel_1.add(lblBonus);
		
		txtRole = new JTextField();
		txtRole.setColumns(10);
		txtRole.setBounds(98, 12, 143, 19);
		panel_1.add(txtRole);
		
		txtHday = new JTextField();
		txtHday.setColumns(10);
		txtHday.setBounds(98, 43, 96, 19);
		panel_1.add(txtHday);
		
		txtSal = new JTextField();
		txtSal.setColumns(10);
		txtSal.setBounds(98, 72, 96, 19);
		panel_1.add(txtSal);
		
		txtBonus = new JTextField();
		txtBonus.setColumns(10);
		txtBonus.setBounds(98, 103, 96, 19);
		panel_1.add(txtBonus);
		
		txtFname = new JTextField();
		txtFname.setColumns(10);
		txtFname.setBounds(87, 42, 96, 19);
		panel.add(txtFname);
		
		txtGender = new JTextField();
		txtGender.setColumns(10);
		txtGender.setBounds(87, 72, 96, 19);
		panel.add(txtGender);
		
		txtTel = new JTextField();
		txtTel.setColumns(10);
		txtTel.setBounds(87, 104, 96, 19);
		panel.add(txtTel);
		
		txtLname = new JTextField();
		txtLname.setColumns(10);
		txtLname.setBounds(302, 42, 96, 19);
		panel.add(txtLname);
		
		txtBday = new JTextField();
		txtBday.setColumns(10);
		txtBday.setBounds(302, 72, 96, 19);
		panel.add(txtBday);
		
		txtEmail = new JTextField();
		txtEmail.setColumns(10);
		txtEmail.setBounds(302, 104, 96, 19);
		panel.add(txtEmail);
		
		JButton btnSave = new JButton("SAVE");
		btnSave.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				String depid, empid, fname, lname, gender, bday, tel, email;
				String role, hday, sal, bonus;
				
				empid = txtEmpid.getText();
				depid = txtDepid.getText();
				fname = txtFname.getText();
				lname = txtLname.getText();
				gender = txtGender.getText();
				bday = txtBday.getText();
				tel = txtTel.getText();
				email = txtEmail.getText();
				
				role = txtRole.getText();
				hday = txtHday.getText();
				sal = txtSal.getText();
				bonus = txtBonus.getText();
				
				try {
					pst = con.prepareStatement("insert into AS_EMPLOYEES values (?,?,?,?,?,?,?,?,?,?,?,?)");
					pst.setString(1, empid);
					pst.setString(2, depid);
					pst.setString(3, fname);
					pst.setString(4, lname);
					pst.setString(5, gender);
					pst.setString(6, bday);
					pst.setString(7, tel);
					pst.setString(8, email);
					pst.setString(9, role);
					pst.setString(10, hday);
					pst.setString(11, sal);
					pst.setString(12, bonus);
					pst.executeUpdate();
					
					JOptionPane.showMessageDialog(null, "Record Added Successfully!!!");
					
					//tabel_load();
					txtEmpid.setText("");
					txtDepid.setText("");
					txtFname.setText("");
					txtLname.setText("");
					txtGender.setText("");
					txtBday.setText("");
					txtTel.setText("");
					txtRole.setText("");
					txtHday.setText("");
					txtSal.setText("");
					txtBonus.setText("");
					txtEmpid.requestFocus();
				}
				catch (Exception e1) {
					e1.printStackTrace();
				}
				
			}
		});
		btnSave.setBounds(302, 165, 85, 21);
		panel.add(btnSave);
		
		JButton btnCancel = new JButton("CANCEL");
		btnCancel.setBounds(302, 258, 85, 21);
		panel.add(btnCancel);
		
		JButton btnShow = new JButton("SHOW");
		btnShow.setBounds(302, 227, 85, 21);
		panel.add(btnShow);
		
		JButton btnDelete = new JButton("DELETE");
		btnDelete.setBounds(302, 196, 85, 21);
		panel.add(btnDelete);
		
		txtEmpid = new JTextField();
		txtEmpid.setBounds(87, 13, 96, 19);
		panel.add(txtEmpid);
		txtEmpid.setColumns(10);
		
		JLabel lblDept = new JLabel("Dept ID");
		lblDept.setBounds(216, 10, 67, 22);
		panel.add(lblDept);
		lblDept.setFont(new Font("Tahoma", Font.BOLD, 12));
	}
}
