package SocketProgramming;

import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class Client {
    public static void main(String args[]) {
        try{
            while(true) {
                Socket sock = new Socket("localhost" , 21);
                PrintWriter out = new PrintWriter(sock.getOutputStream(),true);
                Scanner in = new Scanner(sock.getInputStream());

                System.out.println("Reply: ");
                String replString;

                Scanner temp = new Scanner(System.in);
                replString = temp.nextLine();

                out.println(replString);

                temp.close();
                sock.close();
            }
        }catch(Exception e) {
            e.printStackTrace();
        }
    }
}
