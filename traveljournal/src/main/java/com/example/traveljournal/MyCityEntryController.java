package com.example.traveljournal;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.sql.SQLException;

public class MyCityEntryController extends Application {

    public String user;

    public static void main(String[] args) {
        launch(args);
    }

    public void start(Stage primaryStage) {
    }

    public void back(ActionEvent event) throws SQLException {
        try {
            FXMLLoader fxmlLoader = new FXMLLoader(TJApp.class.getResource("MyTripReport.fxml"));
            Scene scene = new Scene((Parent)fxmlLoader.load());
            Stage stage = (Stage)((Node)event.getSource()).getScene().getWindow();
            stage.setScene(scene);
            MyTripReportController controller = fxmlLoader.getController();
            controller.setInfo(this.user);
        } catch (Exception var6) {
            var6.printStackTrace();
        }

    }

    public void setInfo(String user) {
        this.user = user;
    }
}
