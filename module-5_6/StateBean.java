/*
 * Mark White
 * CSD430
 * MOD5/6
 *  */

package bean;

import java.sql.*;
import java.util.*;

public class StateBean {
    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:8080/CSD430", "student1", "pass");
    }

    public List<Integer> getAllStateIds() throws Exception {
        List<Integer> ids = new ArrayList<>();
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT state_id FROM white_states_data")) {
            while (rs.next()) {
                ids.add(rs.getInt("state_id"));
            }
        }
        return ids;
    }

    public Map<String, String> getStateById(int stateId) throws Exception {
        Map<String, String> state = new HashMap<>();
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM white_states_data WHERE state_id = ?")) {
            ps.setInt(1, stateId);
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
}
