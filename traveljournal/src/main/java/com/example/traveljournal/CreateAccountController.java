package com.example.traveljournal;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.CheckBox;
import javafx.scene.control.TextField;
import javafx.scene.control.Label;
import javafx.stage.Stage;

import java.sql.*;

public class CreateAccountController extends Application {

    @FXML
    public TextField fn;

    @FXML
    public TextField ln;
    @FXML
    public TextField createUser;

    @FXML
    public TextField email;
    @FXML
    public TextField password;
    @FXML
    public CheckBox isAdmin;
    @FXML
    public CheckBox isPublic;

    @FXML
    public Label incorrect;

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {

    }

    public void onSubmit(ActionEvent event) throws SQLException {
        DataBaseConnector connection = new DataBaseConnector();
        Connection connectDB = connection.getConnection();
        String adminTrue = "1";
        String publicity = "0";
        if (isAdmin.isSelected()) {
            adminTrue = "0";
        }

        if (isPublic.isSelected()) {
            publicity = "1";
        }

        String connectQuery = "INSERT INTO ACCOUNT (FirstName, LastName, Username, Email, UserPassword, IsUser, MembershipStartDate, isPublic)" +
                "VALUES ('" + fn.getText() + "', '" + ln.getText() + "', '" + createUser.getText() + "', '" + email.getText() + "', '" + password.getText() + "', " + adminTrue + ", CURDATE(), "+ publicity +" );";

        try {
            int result = 0;
            boolean changed = false;
            FXMLLoader fxmlLoader = null;
            if (!(fn.getText().equals("") || ln.getText().equals("") || createUser.getText().equals("") || email.getText().equals("") || password.getText().equals(""))){
                Statement statement = connectDB.createStatement();
                result = statement.executeUpdate((connectQuery));
                if (result != 0 && adminTrue.equals("1")) {
                    changed = true;
                    fxmlLoader = new FXMLLoader((TJApp.class.getResource("Home.fxml")));
                    Scene scene = new Scene(fxmlLoader.load());
                    //Stage stage = getCurrentStage(event);
                    Stage stage = (Stage) ((Node) (event.getSource())).getScene().getWindow();
                    stage.setScene(scene);
                    HomeController controller = fxmlLoader.getController();
                    controller.setInfo(createUser.getText());
                } else if (result != 0 && adminTrue.equals("0")) {
                    changed = true;
                    fxmlLoader = new FXMLLoader((TJApp.class.getResource("Admin_Flags_Home_Page.fxml")));
                    Scene scene = new Scene(fxmlLoader.load());
                    //Stage stage = getCurrentStage(event);
                    Stage stage = (Stage) ((Node) (event.getSource())).getScene().getWindow();
                    stage.setScene(scene);
                }
                if (!changed){
                    incorrect.setText("Please choose a different username or email");
                }
            } else {
                incorrect.setText("No fields can be empty");
            }
        } catch (SQLIntegrityConstraintViolationException e) {
            incorrect.setText("Please choose a different username or email");
        } catch (Exception e) {
            e.printStackTrace();
        }
        connectDB.close();
    }
}
