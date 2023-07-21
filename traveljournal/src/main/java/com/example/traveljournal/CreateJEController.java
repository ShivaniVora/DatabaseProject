package com.example.traveljournal;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.DatePicker;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CreateJEController extends Application {

    public String user;
    @FXML
    public ChoiceBox privacyCB;
    @FXML
    public ChoiceBox ratingCB;
    @FXML
    public TextField cityText;
    @FXML
    public TextField countryText;
    @FXML
    public DatePicker dateText;
    @FXML
    public TextField noteText;
    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {

    }


    public void onSubmit(ActionEvent event) throws SQLException {
        DataBaseConnector connection = new DataBaseConnector();
        Connection connectDB = connection.getConnection();
        int privacy = 0;
        if (privacyCB != null) {
            if (privacyCB.getValue().toString().equals("Private")) {
                privacy = 0;
            } else {
                privacy = 1;
            }
        }

        String connectQuery;

//        System.out.println(ratingCB.getValue().toString());
//        System.out.println(privacyCB.getValue().toString());
//        System.out.println(privacy);
//        System.out.println(dateText.getValue().toString());
//        System.out.println(countryText.getText());
//        System.out.println(cityText.getText());
//        System.out.println(user);

        try {
            int result = 0;
            FXMLLoader fxmlLoader = null;
            if (!((this.noteText == null && (this.ratingCB.getValue() == null)) || this.cityText == null || this.countryText == null || this.dateText == null)) {
                if (noteText == null) {
                    connectQuery = "INSERT INTO JOURNAL_ENTRY(Username, EntryDate, Note, Rating, PrivacyLevel, CityName, Country) VALUES('"
                            + this.user + "', '" + this.dateText.getValue().toString() + "', NULL, '" + this.ratingCB.getValue().toString() + "', '" + privacy + "', '" + cityText.getText()
                            + "', '" + countryText.getText() + "' );";
                } else if (ratingCB.getValue() == null) {
                    connectQuery = "INSERT INTO JOURNAL_ENTRY(Username, EntryDate, Note, Rating, PrivacyLevel, CityName, Country) VALUES('"
                            + this.user + "', '" + this.dateText.getValue().toString() + "', '" + this.noteText.getText()
                            + "', NULL, '" + privacy + "', '" + cityText.getText()
                            + "', '" + countryText.getText() + "' );";
                } else {
                    connectQuery = "INSERT INTO JOURNAL_ENTRY(Username, EntryDate, Note, Rating, PrivacyLevel, CityName, Country) VALUES('" + this.user + "', '" + this.dateText.getValue().toString() + "', '" + this.noteText.getText() + "', '" + this.ratingCB.getValue().toString() + "', '" + privacy + "', '" + cityText.getText() + "', '" + countryText.getText() + "' );";
                }
                Statement statement = connectDB.createStatement();
                statement.executeUpdate(connectQuery);
                Stage stage;
                Scene scene;
                fxmlLoader = new FXMLLoader(TJApp.class.getResource("Home.fxml"));
                scene = new Scene((Parent)fxmlLoader.load());
                stage = (Stage)((Node)event.getSource()).getScene().getWindow();
                stage.setScene(scene);
                HomeController controller = (HomeController)fxmlLoader.getController();
                controller.setInfo(user);

            } else {
                System.out.println("fail");
            }

        } catch (Exception var12) {
            var12.printStackTrace();
        }

        connectDB.close();
    }

    public void back (ActionEvent event) throws SQLException {
        try {
            FXMLLoader fxmlLoader = new FXMLLoader((TJApp.class.getResource("Home.fxml")));
            Scene scene = new Scene(fxmlLoader.load());
            Stage stage = (Stage) ((Node) (event.getSource())).getScene().getWindow();
            stage.setScene(scene);
            HomeController controller = fxmlLoader.getController();
            controller.setInfo(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setInfo(String user) {
        this.user = user;
        privacyCB.getItems().addAll("Public", "Private");
        ratingCB.getItems().addAll("1", "2", "3", "4", "5");

        //get default account privacy
        DataBaseConnector connection = new DataBaseConnector();
        Connection connectDB = connection.getConnection();
        String connectQuery = "SELECT IsPublic FROM ACCOUNT WHERE Username = '" + user + "');";
        int result = 0;
        try {
            Statement statement = connectDB.createStatement();
            result = statement.executeUpdate(connectQuery);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(result);
        if (result == 1) {
            privacyCB.setValue("Private");
        } else {
            privacyCB.setValue("Public");
        }
        ratingCB.setValue(null);

    }
}
