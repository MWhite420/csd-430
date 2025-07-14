<%--
Mark White
CSD430 --%>

<%@ page import="bean.StateBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="bean" class="bean.StateBean" scope="request" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Populate State Data</title>
    <link rel="stylesheet" href="Styles.css" />
</head>
<body>

<a href="Crud_Index.jsp">Home</a>
<h2>Database Setup: white_states_data</h2>

<form method="post">
    <input type="hidden" name="action" value="create" />
    <button type="submit">Create Table</button>
</form>

<form method="post">
    <input type="hidden" name="action" value="insert" />
    <button type="submit">Insert Sample Data</button>
</form>

<form method="post">
    <input type="hidden" name="action" value="delete" />
    <button type="submit">Delete Table</button>
</form>

<hr>

<%
    String action = request.getParameter("action");
    String result = null;

    if ("create".equals(action)) {
        result = bean.createTable();
    } else if ("insert".equals(action)) {
        result = bean.insertSampleData();
    } else if ("delete".equals(action)) {
        result = bean.deleteTable();
    }

    if (result != null) {
%>
        <p><strong>Result:</strong> <%= result %></p>
<%
    }
%>

</body>
</html>
