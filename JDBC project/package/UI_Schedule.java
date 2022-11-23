package UI;

import Backend.Module;
import net.proteanit.sql.DbUtils;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import java.awt.Font;
import javax.swing.JTextField;
import javax.swing.JComboBox;
import javax.swing.JTable;
import javax.swing.JPanel;
import javax.swing.JButton;
import javax.swing.SwingConstants;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.awt.event.ActionEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;

public class UI_Schedule extends Module {

	private JFrame frame;
	private JTextField txtFlight_id;
	private JTextField txtAirport;
	private JTextField txtOntime;
	private JTextField txtOfftime;
	private JTable table;
	private JTextField txtSearch;
	private JComboBox<String> comboBox_joid, comboBox_plane;
	
	Connection con = null;
	PreparedStatement pst = null;
	ResultSet rs = null;
	Statement st = null;
	
	public void table_load() {
		try {
			con = Module.Connect();
			pst = con.prepareStatement("select * from AS_SCHEDULE");
			rs = pst.executeQuery();
			table.setModel(DbUtils.resultSetToTableModel(rs));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			
			public void run() {
				try {
					UI_Schedule window = new UI_Schedule();
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
	public UI_Schedule() {
		initialize();
		Connect();
		fillComboBoxjoid();
		fillComboBoxPlane();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	
	public void fillComboBoxjoid() {
		try {
			con = Module.Connect();
			String jo = "select jo_id from AS_JOURNEY";
			pst = con.prepareStatement(jo);
			rs = pst.executeQuery();
			
			while(rs.next()) {
				comboBox_joid.addItem(rs.getString(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void fillComboBoxPlane() {
		try {
			con = Module.Connect();
			String plane = "select plane_id from AS_PLANE";
			pst = con.prepareStatement(plane);
			rs = pst.executeQuery();
			
			while(rs.next()) {
				comboBox_plane.addItem(rs.getString(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 750, 438);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBounds(23, 62, 319, 264);
		frame.getContentPane().add(panel);
		panel.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Flight id");
		lblNewLabel.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblNewLabel.setBounds(21, 10, 71, 31);
		panel.add(lblNewLabel);
		
		txtFlight_id = new JTextField();
		txtFlight_id.setBounds(116, 18, 96, 19);
		panel.add(txtFlight_id);
		txtFlight_id.setColumns(10);
		
		JLabel lblJoid = new JLabel("Jo id");
		lblJoid.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblJoid.setBounds(21, 51, 71, 31);
		panel.add(lblJoid);
		
		comboBox_joid = new JComboBox<String>();
		comboBox_joid.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String value = comboBox_joid.getSelectedItem().toString();
			}
		});
		comboBox_joid.setBounds(116, 60, 96, 21);
		panel.add(comboBox_joid);
		
		JLabel lblPlaneid = new JLabel("Plane id");
		lblPlaneid.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblPlaneid.setBounds(21, 91, 71, 31);
		panel.add(lblPlaneid);
		

		comboBox_plane = new JComboBox<String>();
		comboBox_plane.setBounds(116, 98, 96, 21);
		panel.add(comboBox_plane);
		
		JLabel lblAirport = new JLabel("Airport");
		lblAirport.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblAirport.setBounds(21, 132, 71, 31);
		panel.add(lblAirport);
		
		txtAirport = new JTextField();
		txtAirport.setColumns(10);
		txtAirport.setBounds(116, 140, 194, 19);
		panel.add(txtAirport);
		
		JLabel lblGetontime = new JLabel("Get on time");
		lblGetontime.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblGetontime.setBounds(21, 173, 88, 31);
		panel.add(lblGetontime);
		
		txtOntime = new JTextField();
		txtOntime.setColumns(10);
		txtOntime.setBounds(116, 181, 119, 19);
		panel.add(txtOntime);
		
		JLabel lblGetOffTime = new JLabel("Get off time");
		lblGetOffTime.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblGetOffTime.setBounds(21, 214, 88, 31);
		panel.add(lblGetOffTime);
		
		txtOfftime = new JTextField();
		txtOfftime.setColumns(10);
		txtOfftime.setBounds(116, 222, 119, 19);
		panel.add(txtOfftime);
		
		table = new JTable();
		table.setBounds(352, 110, 371, 216);
		frame.getContentPane().add(table);
		
		JButton btnNewButton = new JButton("Save");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				String fid, joid, planeid, airport, ontime, offtime;
				
				fid = txtFlight_id.getText();
				airport = txtAirport.getText();
				ontime = txtOntime.getText();
				offtime = txtOfftime.getText();
				try {
					pst = con.prepareStatement("insert into AS_SCHEDULE values (?,?,?,?,?,?)");
					pst.setString(1, fid);
					joid = comboBox_joid.getSelectedItem().toString();
					pst.setString(2, joid);
					planeid = comboBox_plane.getSelectedItem().toString();
					pst.setString(3, planeid);
					pst.setString(4, airport);
					pst.setString(5, ontime);
					pst.setString(6, offtime);
					pst.executeUpdate();
					
					JOptionPane.showMessageDialog(null, "Record Added Successfully!!!");
					
					table_load();
					txtFlight_id.setText("");
					txtAirport.setText("");
					txtOntime.setText("");
					txtOfftime.setText("");
					txtFlight_id.requestFocus();
				}
				catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		});
		btnNewButton.setFont(new Font("Tahoma", Font.PLAIN, 14));
		btnNewButton.setBounds(46, 343, 85, 35);
		frame.getContentPane().add(btnNewButton);
		
		JButton btnCancel = new JButton("Cancel");
		btnCancel.setFont(new Font("Tahoma", Font.PLAIN, 14));
		btnCancel.setBounds(141, 343, 85, 35);
		frame.getContentPane().add(btnCancel);
		
		JButton btnExit = new JButton("Exit");
		btnExit.setFont(new Font("Tahoma", Font.PLAIN, 14));
		btnExit.setBounds(236, 343, 85, 35);
		frame.getContentPane().add(btnExit);
		
		JLabel lblTitle = new JLabel("SCHEDULE");
		lblTitle.setFont(new Font("Tahoma", Font.BOLD, 18));
		lblTitle.setHorizontalAlignment(SwingConstants.CENTER);
		lblTitle.setBounds(313, 10, 147, 35);
		frame.getContentPane().add(lblTitle);
		
		JPanel panel_1 = new JPanel();
		panel_1.setBounds(352, 62, 374, 38);
		frame.getContentPane().add(panel_1);
		panel_1.setLayout(null);
		
		JLabel lblSearchFlightId = new JLabel("Search flight id:");
		lblSearchFlightId.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblSearchFlightId.setBounds(10, 0, 123, 31);
		panel_1.add(lblSearchFlightId);
		
		txtSearch = new JTextField();
		txtSearch.addKeyListener(new KeyAdapter() {
			@Override
			public void keyReleased(KeyEvent e) {
				
				String fid, joid, planeid, airport, ontime, offtime;
				try {
					con = Module.Connect();
					fid = txtFlight_id.getText(); 
					pst = con.prepareStatement("select * from AS_SCHEDULE where flight_sche_id = ?");
					pst.setString(1, fid);
					rs = pst.executeQuery();
					
					if(rs.next()==true) {
						fid = rs.getString(1);
						//joid = comboBox_joid.getSelectedItem().toString();
						joid = rs.getString(2);
						//planeid = comboBox_plane.getSelectedItem().toString();
						planeid = rs.getString(3);
						airport = rs.getString(4);
						ontime = rs.getString(5);
						offtime = rs.getString(6);
			
						//comboBox_joid.tex
						txtFlight_id.setText("fid");
						txtAirport.setText("airport");
						txtOntime.setText("ontime");
						txtOfftime.setText("offtime");
					} else {
						txtFlight_id.setText("");
						txtAirport.setText("");
						txtOntime.setText("");
						txtOfftime.setText("");
					}
				} catch (SQLException ex) {
					// TODO Auto-generated catch block
					ex.printStackTrace();
				}
			}
		});
		txtSearch.setColumns(10);
		txtSearch.setBounds(145, 6, 145, 23);
		panel_1.add(txtSearch);
		
		JButton btnUpdate = new JButton("Update");
		btnUpdate.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String fid, airport, ontime, offtime;
				
				fid = txtFlight_id.getText();
				airport = txtAirport.getText();
				ontime = txtOntime.getText();
				offtime = txtOfftime.getText();
				try {
					pst = con.prepareStatement("update AS_SCHEDULE set from_airport = ?, get_on_time = ?, get_off_time = ? where flight_sche_id = ?");
					pst.setString(1, airport);
					pst.setString(2, ontime);
					pst.setString(3, offtime);
					pst.setString(4, fid);
					pst.executeUpdate();
					
					JOptionPane.showMessageDialog(null, "Record Updated!!!");
					
					table_load();
					txtAirport.setText("");
					txtOntime.setText("");
					txtOfftime.setText("");
					txtAirport.requestFocus();
				}
				catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		});
		btnUpdate.setFont(new Font("Tahoma", Font.PLAIN, 14));
		btnUpdate.setBounds(438, 336, 85, 35);
		frame.getContentPane().add(btnUpdate);
		
		JButton btnDelete = new JButton("Delete");
		btnDelete.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String fid;
				
				fid = txtFlight_id.getText();
			
				try {
					pst = con.prepareStatement("delete from AS_SCHEDULE where flight_sche_id = ?");
					pst.setString(1, fid);
					pst.executeUpdate();
					
					JOptionPane.showMessageDialog(null, "Record deleted!!!");
					
					table_load();
					txtAirport.setText("");
					txtOntime.setText("");
					txtOfftime.setText("");
					txtAirport.requestFocus();
				}
				catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		});
		btnDelete.setFont(new Font("Tahoma", Font.PLAIN, 14));
		btnDelete.setBounds(545, 336, 85, 35);
		frame.getContentPane().add(btnDelete);
		
	}
}
