<%--
Mark White
CSD430 --%>


<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="bean.StateBean, java.util.*" %>
<jsp:useBean id="bean" class="bean.StateBean" scope="request" />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Delete State by ID</title>
  <link rel="stylesheet" type="text/css" href="Styles.css" />
</head>
<body>
  <a href="Crud_Index.jsp">Home</a><br/><br/>
  <h2>Delete State by ID</h2>

  <form method="post">
   <label for="state_id">State ID:</label>
    <select name="state_id" id="state_id">
        <%
            try {
                List<Integer> ids = bean.getAllStateIds();
                for (Integer id : ids) {
        %>
            <option value="<%= id %>"><%= id %></option>
        <%
                }
            } catch (Exception e) {
        %>
            <option disabled>Error: <%= e.getMessage() %></option>
        <%
            }
        %>
    </select>
    <button type="submit">Delete State</button>
</form>

<%
  if ("POST".equalsIgnoreCase(request.getMethod())) {
      try {
          int id = Integer.parseInt(request.getParameter("state_id"));  // match your form field name
          String result = bean.deleteStateById(id);
          out.println("<p>" + result + "</p>");
          out.println(bean.readAllStatesTable());
      } catch (Exception e) {
          out.println("<p>Error deleting record: " + e.getMessage() + "</p>");
      }
  }
%>


</body>
</html>
