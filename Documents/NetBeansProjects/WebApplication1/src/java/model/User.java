/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class User {
    private int id;
    private String username, password, firstname, lastname,gender,birthday;

    public User(int id, String username, String password, String firstname, String lastname, String gender, String birthday) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.firstname = firstname;
        this.lastname = lastname;
        this.gender = gender;
        this.birthday = birthday;
    }
    public String getFullname() {
        return this.firstname+ " " + this.lastname;
    }
    public User(String username, String firstname, String lastname) {
        this.username = username;
        this.firstname = firstname;
        this.lastname = lastname;
    }

    
    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getFirstname() {
        return firstname;
    }

    public String getPassword() {
        return password;
    }
    
    public String getLastname() {
        return lastname;
    }

    public String getBirthday() {
        return birthday;
    }
    
    
}
