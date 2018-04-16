package com.arrow.dbtest;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class Test {
	static Statement stmt;

	public static void main(String args[]) throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/ARROWSTREET?autoReconnect=true&useSSL=false", "root", "root");
		stmt = con.createStatement();

		List<TradeNAK> _lANT = new ArrayList<TradeNAK>();
		TradeNAK tn1 = new TradeNAK("Batch1", "Trade1", true, null);
		TradeNAK tn2 = new TradeNAK("Batch1", "Trade1", true, "Error1");
		TradeNAK tn3 = new TradeNAK("Batch1", "Trade1", false, null);
		TradeNAK tn4 = new TradeNAK("Batch1", "Trade1", false, "Error2");
		_lANT.add(tn1);
		_lANT.add(tn2);
		_lANT.add(tn3);
		_lANT.add(tn4);
		System.out.println(UpdateTradeACKNAKDB(_lANT, "rectestFile1", "archrecDir1"));
		// con.commit();
		con.close();
	}

	public static int UpdateTradeACKNAKDB(List<TradeNAK> _lANT, String strFileNameReceived,
			String strDirectoryArchivedReceived) throws Exception {
		try {
			int j = 0;
			for (int i = 0; i < _lANT.size(); i++) {
				if (_lANT.get(i).AckNakSuccess == true) {
					if (_lANT.get(i).ErrorText == null) {
						// success = true & error = null
						String sql = "UPDATE tSWIFT_History_Trades SET MachineIdReceived = '"
								+ System.getProperty("user.name").toUpperCase() + "', FileNameReceived = '"
								+ strFileNameReceived + "', DirectoryArchivedReceived = '"
								+ strDirectoryArchivedReceived + "', DateReceived = Now(), AckNak = 'ACK' WHERE "
								+ "(BatchId = '" + _lANT.get(i).BatchId + "' AND TradeId = '" + _lANT.get(i).TradeId
								+ "')";
						int rs1 = stmt.executeUpdate(sql);
						
						System.out.println("Value of rs1 = " + rs1);
						j += rs1;
					} else {
						// success = true & error = not null
						String sql2 = "UPDATE tSWIFT_History_Trades SET MachineIdReceived = '"
								+ System.getProperty("user.name").toUpperCase() + "', FileNameReceived = '"
								+ strFileNameReceived + "', DirectoryArchivedReceived = '"
								+ strDirectoryArchivedReceived + "', DateReceived = Now(), AckNak = 'ACK', Error = '"
								+ _lANT.get(i).ErrorText.replace("'", "''") + "' WHERE (BatchId = '"
								+ _lANT.get(i).BatchId + "' AND TradeId = '" + _lANT.get(i).TradeId + "')";
						int rs1 = stmt.executeUpdate(sql2);
						System.out.println(sql2);
						j += rs1;
					}
				} else {
					if (_lANT.get(i).ErrorText == null) // success = false & error = null
					{
						int rs1 = stmt.executeUpdate("UPDATE tSWIFT_History_Trades SET MachineIdReceived = '"
								+ System.getProperty("user.name").toUpperCase() + "', FileNameReceived = '"
								+ strFileNameReceived + "', DirectoryArchivedReceived = '"
								+ strDirectoryArchivedReceived
								+ "', DateReceived =Now(), AckNak = 'NAK' WHERE (BatchId = '" + _lANT.get(i).BatchId
								+ "' AND TradeId = '" + _lANT.get(i).TradeId + "')");
						j += rs1;
					} else { // success = false & error = not null

						int rs1 = stmt.executeUpdate("UPDATE tSWIFT_History_Trades SET MachineIdReceived = '"
								+ System.getProperty("user.name").toUpperCase() + "', FileNameReceived = '"
								+ strFileNameReceived + "', DirectoryArchivedReceived = '"
								+ strDirectoryArchivedReceived + "', DateReceived = Now(), AckNak = 'NAK', Error = '"
								+ _lANT.get(i).ErrorText.replace("'", "''") + "' WHERE (BatchId = '"
								+ _lANT.get(i).BatchId + "' AND TradeId = '" + _lANT.get(i).TradeId + "')");
						j += rs1;

					}
				}
			}
			return j;
		} catch (Exception ex) {
			throw ex;
		}

	}
}
