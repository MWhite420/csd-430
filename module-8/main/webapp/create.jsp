<%--
Mark White
CSD430 --%>

<%@ page import="bean.StateBean" %>
<jsp:useBean id="bean" class="bean.StateBean" scope="request" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add State</title>
<link rel="stylesheet" href="Styles.css" />
</head>
<body>
<a href="Crud_Index.jsp">Home</a><br/><br/>
<h2>Add a New State</h2>

<form method="post">
    Name: <input type="text" name="name" required /><br/>
    Abbreviation: <input type="text" name="abbreviation" maxlength="2" required /><br/>
    Capital: <input type="text" name="capital" required /><br/>
    Population: <input type="number" name="population" required /><br/>
    Region: <input type="text" name="region" required /><br/>
    <input type="submit" value="Add State" />
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String abbr = request.getParameter("abbreviation");
        String capital = request.getParameter("capital");
        int population = Integer.parseInt(request.getParameter("population"));
        String region = request.getParameter("region");

        String msg = bean.insertState(name, abbr, capital, population, region);
        out.println("<p>" + msg + "</p>");
    }
%>
</body>
</html>
