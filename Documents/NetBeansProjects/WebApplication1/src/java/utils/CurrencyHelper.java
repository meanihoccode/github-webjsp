/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author User
 */
public class CurrencyHelper {
    public static String format(int amount){
        String str = "" + amount;
        int cnt = 0;
        String res = "";
        for(int i = str.length()-1; i >= 0; i--){
            cnt++;
            res = str.charAt(i) + res;
            if(cnt % 3 == 0 && i != 0){
                res = "." + res;
            }
        }
        return "$" + res;
    }
}