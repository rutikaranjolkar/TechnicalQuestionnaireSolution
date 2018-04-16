package com.arrow.dbtest;

public class TradeNAK {
	String BatchId;
	String TradeId;
	boolean AckNakSuccess;
	String ErrorText;

	public TradeNAK(String BatchId, String TradeId, boolean AckNakSuccess, String ErrorText) {
		this.BatchId = BatchId;
		this.TradeId = TradeId;
		this.AckNakSuccess = AckNakSuccess;
		this.ErrorText = ErrorText;

	}
}
