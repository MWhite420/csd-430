<%-- 
Mark White
CSD430
--%>


<%@ page import="java.util.*" %>
<jsp:useBean id="bean" class="bean.StateBean" scope="page" />
<%
    int selectedId = Integer.parseInt(request.getParameter("state_id"));
    Map<String, String> state = bean.getStateById(selectedId);
%>
<html>
<head>
<title>State Details</title>
<link rel="stylesheet" href="Styles.css" />
<meta charset="UTF-8">
</head>
<body>
<a href="Crud_Index.jsp">Home</a><br/><br/>
<a href="select.jsp">Back to Selection</a><br/><br/>
    <h2>Details for State ID: <%= selectedId %></h2>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th><th>Name</th><th>Abbreviation</th><th>Capital</th><th>Population</th><th>Region</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><%= state.get("state_id") %></td>
                <td><%= state.get("name") %></td>
                <td><%= state.get("abbreviation") %></td>
                <td><%= state.get("capital") %></td>
                <td><%= state.get("population") %></td>
                <td><%= state.get("region") %></td>
            </tr>
        </tbody>
    </table>
</body>
</html>
