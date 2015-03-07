<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="username.jsp" %>

<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Baruch College</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="icon" href="http://www.baruch.cuny.edu/favicon.ico" />
<link rel="stylesheet" type="text/css" href="http://www.baruch.cuny.edu/css/baruch_interior.css" />
<link rel="stylesheet" type="text/css" href="http://www.baruch.cuny.edu/css/application.css" />
<style type="text/css">
/* CSS Document */

/* elements */

 .ui-autocomplete.ui-widget {
  font-family: Verdana,Arial,sans-serif;
  font-size: 10px;
}

address, blockquote, body, caption, center, dd, dir, div, dl, dt, form, h1, h2, h3, h4, h5, h6, menu, ol, p, td, th, ul  {
	font-family:Arial, Helvetica, sans-serif;
	}
table {
	border-collapse: collapse;
}

td{
	background-color:#FFF;
}


a:link {
	color: #036;
	text-decoration: underline;
	}
a:visited {
	color: #666;
	text-decoration: underline;
	}	
a:hover {
	text-decoration: underline;
	}
a:active {
	text-decoration: underline;
	}	

/* classes */	
.errormsg {
	color: #F00;
	font-weight: bold;
	}

/* ids */
#search caption, #results caption, #criteria caption, #details caption {
	color: #000;
	padding-bottom: 4px;
	}
#search th, #search td, #results th, #results td, #criteria th, #criteria td, #details th, #details td {
	padding: 3px 2px;
	border: 1px solid #999;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 0.8em;
	}
#search th, #search td {
	padding: 4px 4px;
	vertical-align: top;
	}
#details th, #details td {
	padding: 4px 2px;
	vertical-align: top;
	}	
#search th, #results th, #criteria th, #details th {
	background: #ccc;
	}
#search th, #details th {
	text-align: right;
	}	
#results td {
	text-align: center;
	}
#search td, #criteria td, #details td {
	text-align: left;
	}
</style>

<script>
function numberValidate()
{
	var string = document.getElementById("number").value;
	var test = isNaN(string);
	if (test == true)
	{
		alert("You have entered a invalid character in a Number Field!");
		document.getElementById("number").value = '';
	}
}
</script>
<!-- DOESN'T WORK WITH ASC CODES -->
<script>
 
 $(function() {
	 $("#instructor").autocomplete({
	 	source: function(request, response) {
	 	$.ajax({
	 	url: "teachers.jsp",
	    type: "POST",
	 	dataType: "json",
	 	data: {	name: request.term},
	 	success: function( data ) {
	 			
	 		response( $.map( data, function( item ) {
	 		return {
	 			label: item.name,
	 			value: item.value,
	 		}
	 		}));
	 	},
	 	error: function (error) {
	        alert('error: ' + error);
	     }
	 	});
	 	},
	 	minLength: 1
	 	});
	 });
 </script>

</head>

<body>
<!-- wrapper -->
<div id="wrapper">

<!-- banner -->
<div id="banner"><a href="http://www.baruch.cuny.edu"><img src="http://www.baruch.cuny.edu/images/logo_baruch.gif" alt="Baruch College" name="logo" width="201" height="68" border="0" id="logo" /></a>
<!-- /banner -->
<!-- main -->
<div id="main">

<% 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CODE
Connection conn = null;
try
{   
	Class.forName(driver); // 1. Load the driver. Username & Password are declared in username.jsp
	
conn = DriverManager.getConnection(url,myusername,mypassword);// 2. Establish the connection
//CODE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%>










<form method="post" action="scheduleresults.jsp">

    <div align="center">
      <p>Enter the professor's name, discipline, course number and/or days you wish to search.

      </p>
      <table id="search" summary="This table contains search options for the schedule of classes.">
       <caption>
  Schedule of Classes Search&nbsp; - <a href="schedulesearcherror.jsp">ERROR</a></caption>
	  <tbody>
        <tr>
          <th><label for="semester">Semester:</label></th>
          <td><select id="semester" name="semester">
<%
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CODE

Statement stmt = conn.createStatement(); //3. Create a statement object

String sql = "SELECT SEMESTER_NAME,START_DATE,END_DATE FROM SEMESTER_SR ORDER BY SEMESTER_NAME";
ResultSet rs = stmt.executeQuery(sql); //4. Execute Query

SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

while (rs.next())
{ //Open rs.next Bracket
	java.sql.Date Date1 = new java.sql.Date(formatter.parse(rs.getString(2)).getTime()); //Make Date appear without time
	java.sql.Date Date2 = new java.sql.Date(formatter.parse(rs.getString(3)).getTime());
	

//CODE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%>
              <option value='<%=rs.getString(1)%>'><%=rs.getString(1)%> (<%=Date1%> to <%=Date2%>)</option>
<%
} //Close rs.next Bracket  
%>
          </select></td>
        </tr>
        <tr>
          <th>Dept:</th>
          <td><select name="department" size="1">
			<option value="00">Select	All</option>
<% 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CODE

sql = "SELECT DISTINCT DEPT_NAME FROM DEPT_SR ORDER BY DEPT_NAME"; //renaming SQL query
rs=stmt.executeQuery(sql);
while(rs.next())
{ //Open resultset bracket
	

//CODE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%>
			<option><%=rs.getString(1) %></option>
<%
} //Close resultset bracket
%>
			</select></td>
        </tr>
        <tr>
          <th>Discipline:</th>
          <td><select name="discipline" size="1">
<%
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CODE
sql = "SELECT DISC_ABBREVIATION FROM DISCIPLINE_SR ORDER BY DISC_ABBREVIATION"; //SQL Query Change
 rs = stmt.executeQuery(sql);

while(rs.next())
{ //Open ResultSet
//CODE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%>
          	<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
          	
<%
} //Close ResultSet
%>

			</select></td>
        </tr>
        <tr>
          <th>Division</th>
          <td>
            <label for="undergraduate">Undergraduate </label><input type="checkbox" id="undergraduate" value="u" name="div_undr" checked>
            <br>
            <label for="graduate">Graduate</label><input type="checkbox" id="gradaute" value="g" name="div_grad" checked>
          </td>
        </tr>
        <tr>
          <th><label for="number">Course number:</label></th>
          <td><input id="number" size="10" name="number" maxlength="5" type="text" onkeyup="numberValidate()"></td>
        </tr>
        <tr>
          <th><label for="days">Days:</label></th>
          <td><select id="days" name="days">
              <option value="Select All">Select All </option>
<%
sql = "SELECT DISTINCT MEETING_DAYS FROM CRS_SEC_SR WHERE MEETING_DAYS IS NOT NULL ORDER BY MEETING_DAYS";
rs = stmt.executeQuery(sql);
while(rs.next())
{ //Open ResultSet
	
%>
			<option value="<%=rs.getString(1)%>">
			
<%
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CODE
if (rs.getString(1).equals("F")) //if statement to make a better looking display option
{
	out.println("Fri");
}
else if (rs.getString(1).equals("HTBA"))
{
	out.println("Hours To Be Arranged");
}
else if (rs.getString(1).equals("M"))
{
	out.println("Mon");
}
else if (rs.getString(1).equals("MT"))
{
	out.println("Mon-Tues");
}
else if (rs.getString(1).equals("MTH"))
{
	out.println("Mon-Thurs");
}
else if (rs.getString(1).equals("MTTH"))
{
	out.println("Mon-Tues-Thurs");
}
else if (rs.getString(1).equals("MTW"))
{
	out.println("Mon-Tues-Wed");
}
else if (rs.getString(1).equals("MTWTH"))
{
	out.println("Mon-Tues-Wed-Thurs");
}
else if (rs.getString(1).equals("MW"))
{
	out.println("Mon-Wed");
}
else if (rs.getString(1).equals("MWTH"))
{
	out.println("Mon-Wed-Thurs");
}
else if (rs.getString(1).equals("ONLINE"))
{
	out.println("Online Class");
}
else if (rs.getString(1).equals("S"))
{
	out.println("Sat");
}
else if (rs.getString(1).equals("SSU"))
{
	out.println("Sat-Sun");
}
else if (rs.getString(1).equals("SU"))
{
	out.println("Sun");
}
else if (rs.getString(1).equals("T"))
{
	out.println("Tues");
}
else if (rs.getString(1).equals("TF"))
{
	out.println("Tues-Fri");
}
else if (rs.getString(1).equals("TH"))
{
	out.println("Thurs");
}
else if (rs.getString(1).equals("TTH"))
{
	out.println("Tues-Thurs");
}
else if (rs.getString(1).equals("TTHF"))
{
	out.println("Tues-Thurs-Fri");
}
else if (rs.getString(1).equals("TWTH"))
{
	out.println("Tues-Wed-thurs");
}
else if (rs.getString(1).equals("W"))
{
	out.println("Wed");
}
else if (rs.getString(1).equals("WF"))
{
	out.println("Wed-Fri");
}

//CODE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%>
</option>
<%
} //Close ResultSet
%>              
          </select></td>
        </tr>
        <tr>
          <th><label for="time">Time:</label></th>
          <td><select id="time" name="time_a_b">
              <option value="00">Select All </option>
              <option value="Before">Before </option>
              <option value="After">After </option>
              <option value="Around">Around </option>
            </select>
            <select name="time">
              <option value="00">Select All </option>
              <option value="7">7:00am </option>
              <option value="8">8:00am </option>
              <option value="9">9:00am </option>
              <option value="10">10:00am </option>
              <option value="11">11:00am </option>
              <option value="12">12:00pm </option>
              <option value="13">1:00pm </option>
              <option value="14">2:00pm </option>
              <option value="15">3:00pm </option>
              <option value="16">4:00pm </option>
              <option value="17">5:00pm </option>
              <option value="18">6:00pm </option>
              <option value="19">7:00pm </option>
              <option value="20">8:00pm </option>
              <option value="21">9:00pm </option>
            </select>          </td>
        </tr>
        <tr>
          <th><label for="instructor">Instructor:</label></th>
          <td><input id="instructor" size="30" name="instructor" type="text"></td>
        </tr>
      </tbody>
      </table>
    </div>
    <p align="center">
      <input value="Start Search" type="submit">
   </p>
   
<%


}
catch(SQLException e)
{
	out.println("SQLException: " + e.getMessage() + "<BR>"); //Exception if connections is not made
	while((e = e.getNextException()) != null)
	   out.println(e.getMessage() + "<BR>");
}
catch(ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
}

finally
{
	if(conn != null) //Close connection; Clean up resources
	{
	   try
	   {
	      conn.close();
	   }
	   catch (Exception ignored) {}
	}
}

%>
</form>
</div>
</div>
</div>
</body>
</html>