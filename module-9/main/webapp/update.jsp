<%--
Mark White
CSD430 --%>


<%@ page import="java.util.*, bean.StateBean" %>
<jsp:useBean id="bean" class="bean.StateBean" scope="request" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update State</title>
<link rel="stylesheet" href="Styles.css" />
</head>
<body>
<a href="Crud_Index.jsp">Home</a><br/><br/>
<a href="update.jsp">Back to Selection</a><br/><br/>
<h2>Update State Record</h2>

<%
    String method = request.getMethod();
    String selectedIdParam = request.getParameter("state_id");

    if ("GET".equals(method) && selectedIdParam == null) {
        // Show dropdown to select state
        List<Integer> ids = bean.getAllStateIds();
%>
        <form method="get" action="update.jsp">
            <label for="state_id">Select State ID to Update:</label>
            <select name="state_id">
                <% for (Integer id : ids) { %>
                    <option value="<%= id %>"><%= id %></option>
                <% } %>
            </select>
            <input type="submit" value="Load State">
        </form>
<%
    } else if ("GET".equals(method) && selectedIdParam != null) {
        int selectedId = Integer.parseInt(selectedIdParam);
        Map<String, String> state = bean.getStateById(selectedId);
%>
        <form method="post" action="update.jsp">
            <input type="hidden" name="state_id" value="<%= state.get("state_id") %>" />
            <table border="1" cellpadding="5">
                <tr><th>Field</th><th>Current Value</th><th>New Value</th></tr>
                <tr><td>ID</td><td><%= state.get("state_id") %></td><td>(unchanged)</td></tr>
                <tr><td>Name</td><td><%= state.get("name") %></td><td><input type="text" name="name" value="<%= state.get("name") %>" /></td></tr>
                <tr><td>Abbreviation</td><td><%= state.get("abbreviation") %></td><td><input type="text" name="abbreviation" maxlength="2" value="<%= state.get("abbreviation") %>" /></td></tr>
                <tr><td>Capital</td><td><%= state.get("capital") %></td><td><input type="text" name="capital" value="<%= state.get("capital") %>" /></td></tr>
                <tr><td>Population</td><td><%= state.get("population") %></td><td><input type="number" name="population" value="<%= state.get("population") %>" /></td></tr>
                <tr><td>Region</td><td><%= state.get("region") %></td><td><input type="text" name="region" value="<%= state.get("region") %>" /></td></tr>
            </table>
            <br/>
            <input type="submit" value="Update State" />
        </form>
<%
    } else if ("POST".equals(method)) {
        try {
            int stateId = Integer.parseInt(request.getParameter("state_id"));
            String name = request.getParameter("name");
            String abbr = request.getParameter("abbreviation");
            String capital = request.getParameter("capital");
            int population = Integer.parseInt(request.getParameter("population"));
            String region = request.getParameter("region");

            String result = bean.upsertState(stateId, name, abbr, capital, population, region);
            out.println("<p>" + result + "</p>");
            out.println(bean.read(stateId));
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>
</body>
</html>
