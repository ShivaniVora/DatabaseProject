package com.example.traveljournal;

import javafx.application.Application;
import javafx.stage.Stage;

public class HomeController extends Application {

    public String user;
    public String pass;
    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {

    }

    public void setInfo(String user, String pass) {
        this.user = user;
        this.pass = pass;
    }
}
