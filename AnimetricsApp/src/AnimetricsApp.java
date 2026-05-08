import java.sql.*;
import java.util.Scanner;

public class AnimetricsApp {

    public static void main(String[] args) {
        Connection c = null;
        Scanner scanner = new Scanner(System.in);

        try {
            Class.forName("org.sqlite.JDBC");
            c = DriverManager.getConnection("jdbc:sqlite:animetrics.db");
            System.out.println("Opened database successfully");

            int choice = -1;
            while (choice != 0) {
         
                System.out.println("AniMetrics Database Management System - Main Menu");
                System.out.println("1. Which animation studio has the highest average rating?");
                System.out.println("2. Which medium tends to result in higher ratings (Anime vs Manga)?");
                System.out.println("3. Show all manga written by Eiichiro Oda (High to Low Rating).");
                System.out.println("4. Which anime is rated 8+/10 while having less than 40 volumes?");
                System.out.println("5. What were my favourite anime released from 2010-2019?");
                System.out.println("6. Update 'Fire Force' anime rating to 9/10.");
                System.out.println("7. Drop 'Solo Leveling' from the tracking database.");
                System.out.println("8. Update 'One Piece' manga status to 'Completed'.");
                System.out.println("9. Update 'Jujutsu Kaisen' manga volume count to 30.");
                System.out.println("10. Add new series 'Burn the Witch' to the database.");
                System.out.println("0. Exit Application");

                System.out.print("Select Your Query: ");

                choice = scanner.nextInt();
                scanner.nextLine(); 

                switch (choice) {
                    case 1: task1(c); break;
                    case 2: task2(c); break;
                    case 3: task3(c); break;
                    case 4: task4(c); break;
                    case 5: task5(c); break;
                    case 6: task6(c); break;
                    case 7: task7(c); break;
                    case 8: task8(c); break;
                    case 9: task9(c); break;
                    case 10: task10(c); break;
                    case 0: System.out.println("Closing database connection and exiting..."); break;
                    default: System.out.println("Invalid selection. Please enter a number between 0 and 10.");
                }
            }
            c.close();
        } catch (Exception e) {
            System.err.println("Database Error: " + e.getMessage());
        }
    }

    // Task 1
    public static void task1(Connection c) {
        try (Statement stmt = c.createStatement()) {
            // [cite: 170-175]
            String sql = "SELECT s.Name, AVG(a.MyRating) AS AvgRating FROM AnimationStudio s " +
                         "JOIN Anime a ON s.StudioID = a.StudioID GROUP BY s.Name ORDER BY AvgRating DESC LIMIT 1;";
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) System.out.println("\nResult: " + rs.getString("Name") + " (Avg Rating: " + rs.getFloat("AvgRating") + ")");
        } catch (Exception e) { System.err.println(e.getMessage()); }
    }

    // Task 2
    public static void task2(Connection c) {
        try (Statement stmt = c.createStatement()) {
            // [cite: 189-190]
            String sql = "SELECT 'Anime' AS Medium, AVG(MyRating) AS AvgRating FROM Anime " +
                         "UNION SELECT 'Manga', AVG(MyRating) AS AvgRating FROM Manga;";
            ResultSet rs = stmt.executeQuery(sql);
            System.out.println("\nMedium Ratings:");
            while (rs.next()) System.out.println(rs.getString("Medium") + ": " + String.format("%.2f", rs.getFloat("AvgRating")));
        } catch (Exception e) { System.err.println(e.getMessage()); }
    }

    // Task 3
    public static void task3(Connection c) {
        try (Statement stmt = c.createStatement()) {
            // [cite: 203-207]
            String sql = "SELECT m.Title, m.MyRating FROM Manga m JOIN Creator c ON m.CreatorID = c.CreatorID " +
                         "WHERE c.Name = 'Eiichiro Oda' ORDER BY m.MyRating DESC;";
            ResultSet rs = stmt.executeQuery(sql);
            System.out.println("\nWorks by Eiichiro Oda:");
            while (rs.next()) System.out.println("- " + rs.getString("Title") + " (Rating: " + rs.getInt("MyRating") + ")");
        } catch (Exception e) { System.err.println(e.getMessage()); }
    }

    // Task 4
    public static void task4(Connection c) {
        try (Statement stmt = c.createStatement()) {
            // [cite: 221-223]
            String sql = "SELECT a.Title, a.MyRating, m.VolumeCount FROM Anime a JOIN Manga m ON a.MangaID = m.MangaID " +
                         "WHERE a.MyRating >= 8 AND m.VolumeCount < 40;";
            ResultSet rs = stmt.executeQuery(sql);
            System.out.println("\nHighly Rated Anime with Short Source Material:");
            while (rs.next()) System.out.println("- " + rs.getString("Title") + " | Rating: " + rs.getInt("MyRating") + " | Volumes: " + rs.getInt("VolumeCount"));
        } catch (Exception e) { System.err.println(e.getMessage()); }
    }

    // Task 5
    public static void task5(Connection c) {
        try (Statement stmt = c.createStatement()) {
            // [cite: 242-245]
            String sql = "SELECT Title, MyRating, ReleaseYear FROM Anime WHERE ReleaseYear BETWEEN 2010 AND 2019 ORDER BY MyRating DESC;";
            ResultSet rs = stmt.executeQuery(sql);
            System.out.println("\nBest of 2010-2019:");
            while (rs.next()) System.out.println("- " + rs.getString("Title") + " (" + rs.getInt("ReleaseYear") + ") Rating: " + rs.getInt("MyRating"));
        } catch (Exception e) { System.err.println(e.getMessage()); }
    }

    // Task 6
    public static void task6(Connection c) {
        try (Statement stmt = c.createStatement()) {
            // [cite: 260-262]
            String sql = "UPDATE Anime SET MyRating = 9 WHERE Title = 'Fire Force';";
            int rowsAffected = stmt.executeUpdate(sql);
            if(rowsAffected > 0) System.out.println("\nSuccess: Updated Fire Force rating to 9.");
            else System.out.println("\nNo changes made. Is Fire Force in the database?");
        } catch (Exception e) { System.err.println(e.getMessage()); }
    }

    // Task 7
    public static void task7(Connection c) {
        try (Statement stmt = c.createStatement()) {
            // [cite: 270-271]
            String sql = "DELETE FROM Anime WHERE Title = 'Solo Leveling';";
            int rowsAffected = stmt.executeUpdate(sql);
            if(rowsAffected > 0) System.out.println("\nSuccess: Dropped Solo Leveling from the database.");
            else System.out.println("\nNo changes made. Solo Leveling might already be deleted.");
        } catch (Exception e) { System.err.println(e.getMessage()); }
    }

    // Task 8
    public static void task8(Connection c) {
        try (Statement stmt = c.createStatement()) {
            // [cite: 288-290]
            String sql = "UPDATE Manga SET CompletionStatus = 'Completed' WHERE Title = 'One Piece';";
            int rowsAffected = stmt.executeUpdate(sql);
            if(rowsAffected > 0) System.out.println("\nSuccess: Marked One Piece manga as Completed.");
            else System.out.println("\nNo changes made. Is One Piece manga in the database?");
        } catch (Exception e) { System.err.println(e.getMessage()); }
    }

    // Task 9
    public static void task9(Connection c) {
        try (Statement stmt = c.createStatement()) {
            // [cite: 306-308]
            String sql = "UPDATE Manga SET VolumeCount = 30 WHERE Title = 'Jujutsu Kaisen';";
            int rowsAffected = stmt.executeUpdate(sql);
            if(rowsAffected > 0) System.out.println("\nSuccess: Updated Jujutsu Kaisen volume count to 30.");
            else System.out.println("\nNo changes made. Is Jujutsu Kaisen manga in the database?");
        } catch (Exception e) { System.err.println(e.getMessage()); }
    }

    // Task 10
    public static void task10(Connection c) {
        try (Statement stmt = c.createStatement()) {
            // [cite: 314]
            String sql = "INSERT INTO Anime (Title, EpisodeCount, ReleaseYear, MyRating, StudioID, CreatorID) " +
                         "VALUES ('Burn the Witch', 3, 2020, 8, 8, 3);";
            stmt.executeUpdate(sql);
            System.out.println("\nSuccess: Added Burn the Witch to the database.");
        } catch (Exception e) { System.err.println("\nError adding record: " + e.getMessage()); }
    }
}