package com.example.traveljournal;

import javafx.event.ActionEvent;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CityJEController {
    public void viewJE(ActionEvent event) throws SQLException {
        DataBaseConnector connection = new DataBaseConnector();
        Connection connectDB = connection.getConnection();
        String connectQuery;

        try {
            Statement statement = connectDB.createStatement();
            ResultSet queryOutput = statement.executeQuery((connectQuery));
            while(queryOutput.next()) {
                FXMLLoader fxmlLoader = new FXMLLoader((traveljournal.class.getResource("CityJEScene")));
                Scene scene = new Scene(fxmlLoader.load());
                stage = getCurrentStage();
                stage.setScene(scene);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        connectDB.close();

    }
}














