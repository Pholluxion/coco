/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package persistence.mysql;

import logic.daos.UserRolDao;
import logic.models.UserRolModel;

/**
 *
 * @author carlosdanielpenalozatorres
 */
public class NewMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {

        UserRolDao userRol = new UserRolDao();
        UserRolModel user = new UserRolModel();

        System.out.println(userRol.readAll().toString());
    }

}
