<%--
Mark White
CSD430 --%>


<%@ page import="bean.StateBean" %>
<jsp:useBean id="bean" class="bean.StateBean" scope="request" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All States</title>
<link rel="stylesheet" href="Styles.css" />
</head>
<body>
<a href="Crud_Index.jsp">Home</a><br/><br/>
<a href="select.jsp">Back to Selection</a><br/><br/>
<h2>All States</h2>

<%
    String showAll = request.getParameter("showAll");
    if ("true".equals(showAll)) {
        out.print(bean.readAllStatesTable());
    } else {
%>
        <p>No states to display.</p>
<%
    }
%>
</body>
</html>

