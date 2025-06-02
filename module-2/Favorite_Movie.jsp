<%--
Mark White
CSD430
Assignment2
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Favorite Movie</title>
<link rel="stylesheet" type="text/css" href="MyStyle.css">
</head>
<body>
 <h1>Inception: Movie Overview</h1>
    <p class="caption">This page highlights key facts about the movie <em>Inception</em></p>

    <%
        // Class to store movie detail records
        class MovieFact {
            String category;
            String description;
            String detail;

            MovieFact(String category, String description, String detail) {
                this.category = category;
                this.description = description;
                this.detail = detail;
            }
        }

        // list of facts about Inception
        ArrayList<MovieFact> facts = new ArrayList<MovieFact>();
        facts.add(new MovieFact("Director:", "Who directed the movie?", "Christopher Nolan"));
        facts.add(new MovieFact("Release Date:", "When was the movie released?", "July 13th, 2010"));
        facts.add(new MovieFact("Genre:", "Movie's primary genre", "Science Fiction, Thriller"));
        facts.add(new MovieFact("Lead Actor:", "Main character role", "Leonardo DiCaprio as Dom Cobb"));
        facts.add(new MovieFact("Notable Feature:", "Unique aspect of the film", "Dream within a dream concept"));
        facts.add(new MovieFact("Duration:", "Length of the film", "148 minutes, or 2hr 28m"));
    %>

    <!-- Display the facts in a table -->
    <table>
        <tr>
            <th>Category</th>
            <th>Description</th>
            <th>Detail</th>
        </tr>
        <%
            for (MovieFact fact : facts) {
        %>
        <tr>
            <td><%= fact.category %></td>
            <td><%= fact.description %></td>
            <td><%= fact.detail %></td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>