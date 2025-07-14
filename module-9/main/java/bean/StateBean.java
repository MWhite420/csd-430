/*
 * Mark White
 * CSD430
 * MOD5/6
 *  */

package bean;

import java.sql.*;
import java.util.*;

public class StateBean {
    private final String jdbcURL = "jdbc:mysql://localhost:3306/CSD430";
    private final String jdbcUsername = "student1";
    private final String jdbcPassword = "pass";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure driver is loaded
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }
    // Method to create the white_states_data table
    public String createTable() {
        String sql = """
        	    CREATE TABLE white_states_data (
                state_id INT PRIMARY KEY,
                name VARCHAR(100),
                abbreviation CHAR(2),
                capital VARCHAR(100),
                population INT,
                region VARCHAR(50)
            )
            """;

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
            return "Table created successfully (or already exists).";
        } catch (SQLException e) {
            e.printStackTrace();
            return "Error creating table: " + e.getMessage();
        }
    }

    // Method to populate the table with initial data
    public String insertSampleData() {
        String sql = """
            INSERT INTO white_states_data (state_id, name, abbreviation, capital, population, region) VALUES
            (1, 'Arizona', 'AZ', 'Phoenix', 7691740, 'Southwest'),
            (2, 'Texas', 'TX', 'Austin', 31853800, 'South'),
            (3, 'Florida', 'FL', 'Tallahassee', 23839600, 'South'),
            (4, 'New York', 'NY', 'Albany', 19997100, 'Northeast'),
            (5, 'Pennsylvania', 'PA', 'Harrisburg', 13139800, 'Northeast'),
            (6, 'Illinois', 'IL', 'Springfield', 12778100, 'Midwest'),
            (7, 'Ohio', 'OH', 'Columbus', 11942600, 'Midwest'),
            (8, 'Georgia', 'GA', 'Atlanta', 11297300, 'South'),
            (9, 'North Carolina', 'NC', 'Raleigh', 11210900, 'South'),
            (10, 'Michigan', 'MI', 'Lansing', 10197600, 'Midwest'),
            (11, 'Hawaii', 'HI', 'Honolulu', 1446146, 'West'),
            (12, 'California', 'CA', 'Sacremento', 39663800, 'West'),
            (13, 'Nebraska', 'NE', 'Lincoln', 1988700, 'Midwest')
        """;

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
            return "Sample state records inserted successfully.";
        } catch (SQLException e) {
            if (e.getMessage().contains("Duplicate")) {
                return "Records already exist. Skipped inserting.";
            }
            e.printStackTrace();
            return "Error inserting sample data: " + e.getMessage();
        }
    }
    
    // Remove Table and Data 
    public String deleteTable() {
        String sql = "DROP TABLE IF EXISTS white_states_data";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
            return "Table 'white_states_data' deleted successfully.";
        } catch (SQLException e) {
            e.printStackTrace();
            return "Error deleting table: " + e.getMessage();
        }
    }

    //Create State
    public String insertState(String name, String abbreviation, String capital, int population, String region) {
        String sql = "INSERT INTO white_states_data (name, abbreviation, capital, population, region) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, abbreviation);
            ps.setString(3, capital);
            ps.setInt(4, population);
            ps.setString(5, region);
            int rows = ps.executeUpdate();
            return rows > 0 ? "State added successfully!" : "Insert failed.";
        } catch (SQLException e) {
            e.printStackTrace();
            return "Error adding state: " + e.getMessage();
        }
    }


    // Retrieve all state IDs
    public List<Integer> getAllStateIds() throws Exception {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT state_id FROM white_states_data";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ids.add(rs.getInt("state_id"));
            }
        }
        if (ids.isEmpty()) {
            ids.add(1);
        }
        return ids;
    }
        

    // Retrieve one state record by ID as a map
    public Map<String, String> getStateById(int id) throws Exception {
        Map<String, String> state = new HashMap<>();
        String sql = "SELECT * FROM white_states_data WHERE state_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    state.put("state_id", String.valueOf(rs.getInt("state_id")));
                    state.put("name", rs.getString("name"));
                    state.put("abbreviation", rs.getString("abbreviation"));
                    state.put("capital", rs.getString("capital"));
                    state.put("population", String.valueOf(rs.getInt("population")));
                    state.put("region", rs.getString("region"));
                }
            }
        }
        return state;
    }

    // Return all states as an HTML table string
    public String readAllStatesTable() {
        StringBuilder html = new StringBuilder();
        html.append("<table border='1'>");
        html.append("<tr><th>ID</th><th>Name</th><th>Abbr.</th><th>Capital</th><th>Population</th><th>Region</th></tr>");

        String sql = "SELECT * FROM white_states_data";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                html.append("<tr>");
                html.append("<td>").append(rs.getInt("state_id")).append("</td>");
                html.append("<td>").append(rs.getString("name")).append("</td>");
                html.append("<td>").append(rs.getString("abbreviation")).append("</td>");
                html.append("<td>").append(rs.getString("capital")).append("</td>");
                html.append("<td>").append(rs.getInt("population")).append("</td>");
                html.append("<td>").append(rs.getString("region")).append("</td>");
                html.append("</tr>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Error retrieving states.";
        }

        html.append("</table>");
        return html.toString();
    }

    // Return one state as HTML string, or message if not found
    public String read(int stateId) {
        String sql = "SELECT * FROM white_states_data WHERE state_id = ?";
        StringBuilder html = new StringBuilder();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, stateId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    html.append("<h3>State Details</h3>");
                    html.append("<table border='1'>");
                    html.append("<tr><th>ID</th><th>Name</th><th>Abbr.</th><th>Capital</th><th>Population</th><th>Region</th></tr>");
                    html.append("<tr>");
                    html.append("<td>").append(rs.getInt("state_id")).append("</td>");
                    html.append("<td>").append(rs.getString("name")).append("</td>");
                    html.append("<td>").append(rs.getString("abbreviation")).append("</td>");
                    html.append("<td>").append(rs.getString("capital")).append("</td>");
                    html.append("<td>").append(rs.getInt("population")).append("</td>");
                    html.append("<td>").append(rs.getString("region")).append("</td>");
                    html.append("</tr>");
                    html.append("</table>");
                } else {
                    html.append("No state found with ID ").append(stateId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Error retrieving state with ID " + stateId;
        }

        return html.toString();
    }

    // Update a state record
    public String upsertState(int stateId, String name, String abbreviation, String capital, int population, String region) {
        String sqlInsert = "INSERT INTO white_states_data (state_id, name, abbreviation, capital, population, region) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlUpdate = "UPDATE white_states_data SET name = ?, abbreviation = ?, capital = ?, population = ?, region = ? WHERE state_id = ?";

        try (Connection conn = getConnection()) {
            // Check if state exists
            String checkSql = "SELECT COUNT(*) FROM white_states_data WHERE state_id = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, stateId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        // Exists, do update
                        try (PreparedStatement updateStmt = conn.prepareStatement(sqlUpdate)) {
                            updateStmt.setString(1, name);
                            updateStmt.setString(2, abbreviation);
                            updateStmt.setString(3, capital);
                            updateStmt.setInt(4, population);
                            updateStmt.setString(5, region);
                            updateStmt.setInt(6, stateId);
                            int updatedRows = updateStmt.executeUpdate();
                            if (updatedRows > 0) {
                                return "Record updated successfully.";
                            } else {
                                return "Update failed.";
                            }
                        }
                    } else {
                        // Does not exist, do insert
                        try (PreparedStatement insertStmt = conn.prepareStatement(sqlInsert)) {
                            insertStmt.setInt(1, stateId);
                            insertStmt.setString(2, name);
                            insertStmt.setString(3, abbreviation);
                            insertStmt.setString(4, capital);
                            insertStmt.setInt(5, population);
                            insertStmt.setString(6, region);
                            int insertedRows = insertStmt.executeUpdate();
                            if (insertedRows > 0) {
                                return "Record inserted successfully.";
                            } else {
                                return "Insert failed.";
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Database error: " + e.getMessage();
        }
    }
    
    public String deleteStateById(int stateId) {
        String sql = "DELETE FROM white_states_data WHERE state_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, stateId);
            int deleted = ps.executeUpdate();
            return deleted + " record(s) deleted.";
        } catch (SQLException e) {
            e.printStackTrace();
            return "Error deleting record: " + e.getMessage();
        }
    }

}
