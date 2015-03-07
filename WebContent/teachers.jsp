<%@ page contentType="text/html; charset=iso-8859-1" language="java"%>
<%@ page import="java.sql.*"%>
<%@ include file="username.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.swing.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>


<%
try 
{

if (session.getAttribute("theName") == null)
{
	out.println("YOU FUCKED UP!!!!!!!!!!!!!!!!");
}
else 
{
	String name = (String)session.getAttribute("theName");
}
out.println(session.getAttribute("theName"));
Connection con;

Class.forName(driver);

// Get a Connection to the database
con = DriverManager.getConnection(url, myusername, mypassword);

//Add the data into the database
String sql = "SELECT DISTINCT INSTRUCTOR_LNAME FROM INSTRUCTOR_SR ";

//WHERE INSTRUCTOR_LNAME LIKE'"+name+"%'
Statement stm = con.createStatement();

stm.executeQuery(sql);

ResultSet rs= stm.getResultSet();

JSONObject json = new JSONObject();
JSONArray jsonArr = new JSONArray();

//ArrayList<String> teacherList = new ArrayList<String>();
//teacherList.add(rs.getString("INSTRUCTOR_LNAME"));
//json.put("name", rs.getString("INSTRUCTOR_LNAME"));
//json.put("value", rs.getString("INSTRUCTOR_LNAME"));
//jsonArr.add(json);
//out.println(jsonArr);

ArrayList<String> teacherList = new ArrayList<String>();
int count = 0;
while (rs.next () &&  count < 11)
	{
	teacherList.add(rs.getString("INSTRUCTOR_LNAME"));
	count++;
	}

for (int i=0;i<11;i++)
{
	if (i==0)
	{
	out.print("[{\"name\":\""+teacherList.get(i)+"\",\"value\":\""+teacherList.get(i)+"\"},");
	}
	else 
	if (i>0 && i<10)
	{
	out.print("{\"name\":\""+teacherList.get(i)+"\",\"value\":\""+teacherList.get(i)+"\"},");	
	}
	else 
	if (i==10)
	{
	out.print("{\"name\":\""+teacherList.get(i)+"\",\"value\":\""+teacherList.get(i)+"\"}]");	
	}
	else break;
}
//out.print(jsonArr);

rs.close();
stm.close();
con.close();
}



catch(Exception e)
{
e.printStackTrace();
}
%>