package com.example.traveljournal;

import java.sql.Connection;
import java.sql.DriverManager;

public class DataBaseConnector {
    public Connection databaseLink;

    public Connection getConnection() {
        String databaseName = "travel_journal";
        String databaseUser = "root";
        //TODO put in password
        String databasePassword = "shivu797";
        String url = "jdbc:mysql://localhost:3306/" + databaseName;

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("test");
            databaseLink = DriverManager.getConnection(url, databaseUser, databasePassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return databaseLink;
    }

}