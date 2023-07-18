package com.example.traveljournal;

import javafx.event.ActionEvent;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class LoginController {

        public void loginAction (ActionEvent event) throws SQLException {
            DataBaseConnector connection = new DataBaseConnector();
            Connection connectDB = connection.getConnection();
            String connectQuery = "SELECT IsUser FROM ACCOUNT WHERE username = \"user\" AND UserPassword = \"pass\"";

            try {
                Statement statement = connectDB.createStatement();
                ResultSet queryOutput = statement.executeQuery((connectQuery));
                while (queryOutput.next()) {
                    FXMLLoader fxmlLoader = new FXMLLoader((TJApp.class.getResource("hello-view.fxml")));
                    Scene scene = new Scene(fxmlLoader.load());
                    //Stage stage = getCurrentStage(event);
                    Stage stage = (Stage) ((Node) (event.getSource())).getScene().getWindow();
                    stage.setScene(scene);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            connectDB.close();

        }
    }














