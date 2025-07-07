<%--
Mark White
CSD430 --%>

<%@ page import="java.util.*, bean.StateBean" %>
<jsp:useBean id="bean" class="bean.StateBean" scope="request" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select State</title>
<link rel="stylesheet" href="Styles.css" />
</head>
<body>
<a href="Crud_Index.jsp">Home</a><br/><br/>
<h2>Select a State ID</h2>
<!-- Button to View Select State -->
<form action="display.jsp" method="post">
    <select name="state_id">
        <%
            List<Integer> ids = bean.getAllStateIds();
            for (Integer id : ids) {
        %>
            <option value="<%= id %>"><%= id %></option>
        <%
            }
        %>
    </select>
    <input type="submit" value="View State">
</form>

<!-- Button to View All States -->
<form method="get" action="read.jsp">
    <input type="hidden" name="showAll" value="true" />
    <button type="submit">View All States</button>
</form>

</body>
</html>
