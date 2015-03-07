<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.text.DateFormat" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.*" %>
<%@ include file ="username.jsp" %>

<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
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
address, blockquote, body, caption, center, dd, dir, div, dl, dt, form, h1, h2, h3, h4, h5, h6, menu, ol, p, td, th, ul  {
	font-family:Arial, Helvetica, sans-serif;	
	}
table {
	border-collapse: collapse;
}

h2{
	color:#AA0;
}
td{
	background-color:#FFF
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
</head>

<body>

<%
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//SEMESTER

String semester = request.getParameter("semester");
String semesterDateDisplay = ""; //For Displaying time
String startDateForSQL = "";
String endDateForSQL = "";
String orSemester = null;
if (semester == null) //Do Nothing Clause
{
	startDateForSQL = null;
	endDateForSQL = null;
}
else if (semester.equals("January Intersession"))
{
	semesterDateDisplay = "(Dates: 01/02/2014 to 01/23/2014)";
	startDateForSQL = "01/02/2014";
	endDateForSQL = "01/23/2014";
}
else if (semester.equals("Spring"))
{
	semesterDateDisplay = "(Dates: 01/27/2014 to 05/15/2014)";
	startDateForSQL = "01/27/2014";
	endDateForSQL = "05/15/2014";
}
else if (semester.equals("Summer ALL"))
{
	semesterDateDisplay = "(Dates: 06/03/2013 to 08/15/2013)";
	startDateForSQL = null;
	endDateForSQL = null;
	orSemester = "su%";
}
else if (semester.equals("Summer00"))
{
	semesterDateDisplay = "(Dates: 06/03/2013 to 08/15/2013)";
	startDateForSQL = "06/03/2013";
	endDateForSQL= "08/15/2013";
}
else if (semester.equals("Summer01"))
{
	semesterDateDisplay = "(Dates: 06/03/2013 to 07/11/2013)";
	startDateForSQL = "06/03/2013";
	endDateForSQL = "07/11/2013";
}
else if (semester.equals("Summer02"))
{
	semesterDateDisplay = "(Dates: 07/15/2013 to 08/15/2013)";
	startDateForSQL = "07/15/2013";
	endDateForSQL = "08/15/2013";
}
else if (semester.equals("Fall"))
{
	semesterDateDisplay = "(Dates: 08/28/2013 to 12/15/2013)";
	startDateForSQL = "08/28/2013";
	endDateForSQL = "12/15/2013";
}

String semesterDisplay = "";
if (semester == null)
{
	semesterDisplay = "None Selected";
}
else
{
	semesterDisplay = semester;
}

//SEMESTER
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//DAYS

String days = request.getParameter("days");
String daysDisplay = "";
if (days == null)
{
	daysDisplay = "None Selected";
}
else if (days.equals("Select All"))
{
	daysDisplay = "Select All";
	days = "";
}
else 
{
	daysDisplay = days;
}

//DAYS
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//DEPT

String dept = request.getParameter("department");


//DEPT
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//DISC

String disc = request.getParameter("discipline");
String discDisplay = "";
if (disc == null)
{
	discDisplay = "None Selected";
}
else 
{
	discDisplay = disc;
}

//DISC
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//INSTRUCTOR

String instructor = request.getParameter("instructor");
String instructorDisplay = "";
if (instructor == "" || instructor == null)
{
	instructorDisplay = "None Selected";
}
else 
{
	instructorDisplay = instructor;
}

//INSTRUCTOR
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//COURSENUMBER

String courseNumber = request.getParameter("number");
String numberDisplay = ""; //Initiate course number Display
if (courseNumber == null || courseNumber == "")
{
	numberDisplay = "None Selected";
}
else
{
	numberDisplay = courseNumber;
}

//COURSENUMBER
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//TIME

String time = request.getParameter("time"); //Getting time data
SimpleDateFormat form = new SimpleDateFormat("hh:mm");
//java.sql.Date militaryTime = new java.sql.Date(parse(time)).getTime();
//new java.sql.Date(militaryTime.parse(rs.getString(15)).getTime());
String timeDisplay = ""; //initiate string
String AM_PM = "AM";
String beforeAfter = request.getParameter("time_a_b"); //getting before or after selection
int timeInt = 0;

if (time != null)
{
	timeInt = Integer.parseInt(time);
}
if (time == null)
{
	timeDisplay = "None Selected";
	AM_PM = null;
	beforeAfter = null;
}
else if (time.equals("00"))
{
	timeDisplay = "Select All";
	AM_PM = "";
	time = null;
	beforeAfter = null;
}
else if(Integer.parseInt(time) > 12)
{
	AM_PM = "PM";
	int temp = (Integer.parseInt(time)-12);
	time = Integer.toString(temp);
	timeDisplay = time;
}

String beforeAfterDisplay = "";
if (time == null)
{}
else if (beforeAfter.equals("after"))
{
	beforeAfterDisplay = "after";
}
else if (beforeAfter.equals("before"))
{
	beforeAfterDisplay = "before";
}

//x = x
//CASE WHEN END

//TIME
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//DIVISION

String undergrad = request.getParameter("div_undr"); //Getting undergrad checkbox.
String grad = request.getParameter("div_grad"); //Getting grad checkbox.
String divDisplay = "None Selected "; //initiating string called divDisplay to show what you selected.
String divSQL = "%";

if (undergrad != null && grad != null)
{
	divDisplay = "Both";
}
else if (undergrad != null)
{
	divDisplay = "Undergraduate";
	divSQL = "u%";
}
else if (grad != null)
{
	divDisplay = "Graduate";
	divSQL = "g%";
}


//DIVISION
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%>
<div id="wrapper">

<div id="banner"><a href="http://www.baruch.cuny.edu"><img src="http://www.baruch.cuny.edu/images/logo_baruch.gif" alt="Baruch College" name="logo" width="201" height="68" border="0" id="logo" /></a></div>
<div id="main">

  <p>Search results are based on the following keywords:</p>
  <table id="criteria" summary="This table contains the search criteria. Results are listed in next table.">
    <tr>
      <td><strong>Semester</strong>: <%=semesterDisplay %> <%=semesterDateDisplay %></td>
      <td><strong>Days</strong>: <%=daysDisplay%></td>
    </tr>
    <tr>
      <td><strong>Department</strong>: *USELESS* </td>
      <td><strong>Time</strong>: <%=beforeAfterDisplay %> <%=timeDisplay%><%=AM_PM %></td>
    </tr>
    <tr>
      <td><strong>Discipline</strong>: <%=discDisplay %></td>
      <td><strong>Course number</strong>: <%=numberDisplay %></td>
    </tr>
    <tr>
      <td><strong>Division</strong>: <%=divDisplay%></td>
      <td><strong>Instructor</strong>: <%=instructorDisplay %> </td>
    </tr>
    </table>
  <font color="red">
  <p><b>The schedule was LAST&nbsp; updated at 9:00am on Nov 27th, 2006.</b></p>
  <p>Due to the dynamic nature of the registration process, not all courses listed as open will have space for new registrants.</p>
  </font></div>
<table id="results" summary="This table contains the search results for schedule of classes.">
  <caption>
  <h2>Schedule of Classes Search Results</h2>
  </caption>
  <thead>
    <tr>
      <th scope="col">Course</th>
      <th scope="col">Code</th>
      <th scope="col">Section</th>
      <th scope="col">Day &amp; Time </th>
      <th scope="col">Dates</th>
      <th scope="col">Bldg &amp; Rm </th>
      <th scope="col">Instructor</th>
      <th scope="col">Seats Avail </th>
      <th scope="col">Comments</th>
    </tr>
  </thead>
  <%
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //CODE
  Connection conn = null;
  try
  {
	  Class.forName(driver);
	  conn=DriverManager.getConnection(url,myusername,mypassword);
	//PreparedStatement Stmt = conn.prepareStatement("SELECT t1.*, t2.crs_comments1 FROM crs_sec_sr t1 INNER JOIN crs_comments_sr t2 ON t1.crs_cd = t2.crs_cd INNER JOIN course_sr t3 ON t1.disc = t3.discipline AND t1.crs_num = t3.coursenumber  INNER JOIN semester_sr t4 ON t1.semester = t4.semester WHERE t4.semester_name = '"+semester+"' AND t1.disc = '"+disc+"' AND t3.level_div LIKE '"+divSQL+"' AND '"+courseNumber+"' IS NULL OR t1.crs_num = '"+courseNumber+"' AND '"+days+"' IS NULL OR t1.meeting_days ='"+days+"' AND '"+AM_PM+"' IS NULL OR t1.AM_PM ='"+AM_PM+"'AND '"+time+"' IS NULL OR CASE WHEN '"+beforeAfter+"' = 'before' THEN '"+timeInt+"' < (CONVERT(INT,MID(t1.start_time,1,2))*100 + CONVERT(INT,MID(t1.start_time,4,5))) OR WHEN '"+beforeAfter+"' = 'around' THEN '"+(timeInt-1)+"' < (CONVERT(INT,MID(t1.start_time,1,2))*100 + CONVERT(INT,MID(t1.start_time,4,5))) < '"+(timeInt+1)+"' OR WHEN '"+beforeAfter+"' = 'after' THEN '"+timeInt+"' > (CONVERT(INT,MID(t1.start_time,1,2))*100 + CONVERT(INT,MID(t1.start_time,4,5))) END AND '"+instructor+"' IS NULL OR t1.instructor_lname = '"+instructor+"'");
	//AND '"+AM_PM+"' IS NULL OR t1.AM_PM ='"+AM_PM+"'AND '"+time+"' IS NULL OR CASE WHEN '"+beforeAfter+"' = 'before' THEN '"+timeInt+"' < (CONVERT(INT,MID(t1.start_time,1,2))*100 + CONVERT(INT,MID(t1.start_time,4,5))) OR WHEN '"+beforeAfter+"' = 'around' THEN '"+(timeInt-1)+"' < (CONVERT(INT,MID(t1.start_time,1,2))*100 + CONVERT(INT,MID(t1.start_time,4,5))) < '"+(timeInt+1)+"' OR WHEN '"+beforeAfter+"' = 'after' THEN '"+timeInt+"' > (CONVERT(INT,MID(t1.start_time,1,2))*100 + CONVERT(INT,MID(t1.start_time,4,5))) END AND '"+instructor+"' IS NULL OR t1.instructor_lname = '"+instructor+"'
	 //PreparedStatement Stmt = conn.prepareStatement("SELECT t1.*, t2.crs_comments1, t3.credithour, t4.semester_name FROM crs_sec_sr t1 INNER JOIN crs_comments_sr t2 ON t1.crs_cd = t2.crs_cd INNER JOIN course_sr t3 ON t1.disc = t3.discipline AND t1.crs_num = t3.coursenumber  INNER JOIN semester_sr t4 ON t1.semester = t4.semester WHERE (t4.semester_name = '"+semester+"') AND (t1.disc = '"+disc+"') AND (t3.level_div LIKE '"+divSQL+"') AND ('"+days+"' IS NULL OR t1.meeting_days ='"+days+"') ORDER BY t1.crs_num");
	  PreparedStatement Stmt = conn.prepareStatement("SELECT t1.*, t2.crs_comments1, t3.credithour, t4.semester_name FROM crs_sec_sr t1 INNER JOIN crs_comments_sr t2 ON t1.crs_cd = t2.crs_cd INNER JOIN course_sr t3 ON (t1.disc = t3.discipline AND t1.crs_num = t3.coursenumber) INNER JOIN semester_sr t4 ON t1.semester = t4.semester WHERE (t1.seats_avail <> 0) AND (t1.disc = '"+disc+"') AND (t3.level_div LIKE '"+divSQL+"') AND ('"+courseNumber+"' IS NULL OR t1.crs_num = '"+courseNumber+"') AND ('"+instructor+"' IS NULL OR t1.instructor_lname = '"+instructor+"') AND ('"+days+"' IS NULL OR t1.meeting_days ='"+days+"') ORDER BY t1.crs_num");// ()
	  //WHERE CLAUSE [1] seats available is not zero [2] discipline equals selected discipline [3] division [4] Course number is specific or selects all [5] instructor [6] days
	  //REMAINING time and semester
	  SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); //Format Date
	  ResultSet rs=Stmt.executeQuery();
	  while (rs.next())
	  {
		java.sql.Date StartDate = new java.sql.Date(formatter.parse(rs.getString(14)).getTime());
		java.sql.Date EndDate = new java.sql.Date(formatter.parse(rs.getString(15)).getTime());
		//out.println(rs.getString(19));
		//out.println(rs.getString(20));
  //CODE
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  %>
  <!-- 
  COLUMN INFORMATION
  __________________
  
  1.  CRS_INDEX			**T1 - CRS_SEC_SR**
  2.  D_E_G
  3.  DISC
  4.  CRS_NUM
  5.  CRS_SEC
  6.  CRS_CD
  7.  MEETING_DAYS
  8.  START_TIME
  9.  STOP_TIME
  10. AM_PM
  11. SEATS_AVAIL
  12. BUILDING
  13. RM
  14. START_DATE
  15. END_DATE
  16. INSTRUCTOR_LNAME
  17. SEMESTER      
  18. CRS_COMMENTS1 	**T2 - CRS_COMMENTS_SR
  19. TITLE				**T3 - COURSE_SR
  20. CREDITHOUR
  21. DESCRIPTION
  22. PREREQ
  23. SEMESTER_NAME		**T4 - SEMESTER_SR
  
  
   -->
  
  <tbody>
    <tr>
      <td><a href="coursedetails.jsp?cde=<%=rs.getString(6)%>&sec=<%=rs.getString(5)%>"><%=rs.getString(3)%> <%=rs.getString(4)%></a></td> 
      <!--//DISC & LEVEL\\-->
      <td><%=rs.getString(6)%></td> 										<!--///////COURSE CODE\\\\\\\-->
      <td><%=rs.getString(5)%></td> 										<!--/////COURSE SECTION\\\\\\-->
      <td><%=rs.getString(7)%></td>											<!--///////DAYS & TIME\\\\\\\-->
      <td>(<%=StartDate+") to ("+EndDate %>)</td>							<!--////START & END DATE\\\\\-->
      <td><%=rs.getString(12)%> <%=rs.getString(13) %></td>					<!--/////BUILDING & ROOM\\\\\-->
      <td><%=rs.getString(16)%></td>										<!--///////INSTRUCTOR\\\\\\\\-->
      <td><%=rs.getString(11) %></td>										<!--/////SEATS AVAILABLE\\\\\-->
      <td><%=rs.getString(18)%></td>										<!--////////COMMENTS\\\\\\\\\-->
    </tr>
  </tbody>
<%}%> <!-- Close While Loop -->
</table>
<!--FOOT Include Begins -->
</div>
<!-- /main -->
</div>
<!-- /wrapper -->
</body>
<%}
  

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CODE

catch(SQLException e)
{
	// Do exception catch such as if connection is not made or 
	// query is not set up properly
	out.println("SQLException: " + e.getMessage() + "<BR>");
	while((e = e.getNextException()) != null)
	   out.println(e.getMessage() + "<BR>");
}
catch(ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
}
finally
{
	//7. Close connection; Clean up resources
	if(conn != null)
	{
	   try
	   {
	      conn.close();
	   }
	   catch (Exception ignored) {}
	}
}
//CODE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%>
</html>