package Assign8;
import java.sql.*;
import java.util.Scanner;

public class jdbc {

    public Connection connection;
    String name_column;
    String rollno_column;

    public void checkConnection() throws ClassNotFoundException{
        Class.forName("com.mysql.cj.jdbc.Driver");

        try {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/college" , "root" , "K9022241658p@");
            if(connection != null && !connection.isClosed()) {
                System.out.println("Database Connected!");
            }
            else {
                System.out.println("Database Not Connected!");
            }
        } catch (SQLException e) {
            System.out.println("Wrong Credentials!");
        }
        catch(Exception e) {
            System.out.println("Error 404 : Timed Out!");
        }
    }

    public void createTable(String table_name , String roll_num , String name) {
        this.name_column = name;
        this.rollno_column = roll_num;

        String query = "Create table " + table_name + "(" + name_column + "," + rollno_column + ");";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.executeUpdate();
            System.out.println("Succesfully Created Table!");
        }
        catch(SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void insertRecord(String table_name , int roll_num , String name) {
        String query = "Insert into " + table_name + "(" + this.name_column + "," + this.name_column + ") Values" + "(" + name + "," + roll_num +");";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            int rowsAffected = ps.executeUpdate();

            if(rowsAffected > 0) {
                System.out.println("Succesfully Insered into table!");
            }
            else {
                System.out.println("Error Occured!");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateTable(String table_name , int roll_num , String name) {
        try {
            String query = "Update " + table_name + " Set " + this.name_column + " = " + name + " where " + this.rollno_column + " = " + roll_num + ";";
            PreparedStatement ps = connection.prepareStatement(query);

            //execute update method returns the number of rows affected by the query
            int rowsAffected = ps.executeUpdate();

            if(rowsAffected > 0) {
                System.out.println("Succesfully Updated into table!");
            }
            else {
                System.out.println("Error Occured!");
            }

        } catch(SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteRecord(String table_name , int roll_num) {
        try {
            String query = "Delete from " + table_name + " where " + this.rollno_column + " = " + roll_num + ";";
            PreparedStatement ps = connection.prepareStatement(query);

            //execute update method returns the number of rows affected by the query
            int rowsAffected = ps.executeUpdate();

            if(rowsAffected > 0) {
                System.out.println("Succesfully Deleted entry from the table!");
            }
            else {
                System.out.println("Error Occured!");
            }

        } catch(SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void showContents(String table_name) {
        try {
            String query = "Select * from" + table_name + ";";
            PreparedStatement ps = connection.prepareStatement(query);

            //execute update method returns the number of rows affected by the query
            int rowsAffected = ps.executeUpdate();

            if(rowsAffected > 0) {
                System.out.println("Succesfully Updated into table!");
            }
            else {
                System.out.println("Error Occured!");
            }
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        jdbc myjdbc = new jdbc();
        int a = 99;
        String table_name = "";

        while(a!=0) {
            System.out.println("1 . Check Connection");
            System.out.println("2 . Create Table ");
            System.out.println("3 . Insertion");
            System.out.println("4 . Updation");
            System.out.println("5 . Deletion");
            System.out.println("6 . Show Contents");
            System.out.println("7 . Press 0 to exit");
            a = sc.nextInt();

            switch(a) {
                case 1:
                    myjdbc.checkConnection();
                    break;
                case 3:
                    System.out.println("Enter the Roll no and Name of the student ");
                    int roll_no = sc.nextInt();
                    String name = sc.next();
                    myjdbc.insertRecord(table_name, roll_no, name);
                    break;
                case 4:
                    System.out.println("Enter the new name to be replaced and its roll no : ");
                    String new_name = sc.next();
                    int id = sc.nextInt();
                    myjdbc.updateTable(table_name, id, new_name);
                    break;
                case 5:
                    System.out.println("Enter the roll no of the record to be deleted : ");
                    int rol = sc.nextInt();
                    myjdbc.deleteRecord(table_name, rol);
                    break;
                case 2:
                    System.out.print("Enter the name of the table you would like to create : ");
                    table_name = sc.next();
                    myjdbc.createTable(table_name, "Roll_no", "Name");
                    break;
                case 6:
                    System.out.println("Contents are : ");
                    myjdbc.showContents(table_name);
                    break;
                case 0:
                    a = 0;
                    break;
                default:
                    System.out.println("Wrong Input Entered");
                    break;
            }
        }
    }
}
