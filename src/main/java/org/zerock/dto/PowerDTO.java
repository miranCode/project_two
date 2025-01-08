package org.zerock.dto;

public class PowerDTO {
	private String year;
    private String month;
    private String metro;
    private String city;
    private String cntr;
    private int custCnt;
    private long powerUsage;
    private long bill;
    private double unitCost;
    
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getMetro() {
		return metro;
	}
	public void setMetro(String metro) {
		this.metro = metro;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCntr() {
		return cntr;
	}
	public void setCntr(String cntr) {
		this.cntr = cntr;
	}
	public int getCustCnt() {
		return custCnt;
	}
	public void setCustCnt(int custCnt) {
		this.custCnt = custCnt;
	}
	public long getPowerUsage() {
		return powerUsage;
	}
	public void setPowerUsage(long powerUsage) {
		this.powerUsage = powerUsage;
	}
	public long getBill() {
		return bill;
	}
	public void setBill(long bill) {
		this.bill = bill;
	}
	public double getUnitCost() {
		return unitCost;
	}
	public void setUnitCost(double unitCost) {
		this.unitCost = unitCost;
	}

	@Override
	public String toString() {
		return "PowerDTO [year=" + year + ", month=" + month + ", metro=" + metro + ", city=" + city + ", cntr=" + cntr
				+ ", custCnt=" + custCnt + ", powerUsage=" + powerUsage + ", bill=" + bill + ", unitCost=" + unitCost
				+ "]";
	}
}
