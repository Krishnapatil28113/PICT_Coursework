package SocketProgramming;

import java.io.*;
import java.util.*;
import java.net.*;
// import java.io.BufferedReader;
// import java.io.IOException;
// import java.io.PrintWriter;
// import java.net.ServerSocket;
// import java.net.Socket;
// import java.util.Scanner;

class RequestHandler extends Thread {
    Socket sock;
    PrintWriter out;
    BufferedReader in;

    public RequestHandler(Socket s) {
        try{
            sock = s;
            out = new PrintWriter(sock.getOutputStream(),true);
            in = new BufferedReader(new InputStreamReader(sock.getInputStream()));

        } catch(Exception e){
            e.printStackTrace();
        }
    }

    public void run() {
        try{
            String clientmessage;

            while((clientmessage = in.readLine()) != null) {
                System.out.println("Client: " + clientmessage);

                System.out.println("Reply: ");
                BufferedReader temp = new BufferedReader(new InputStreamReader(System.in));
                String reply;
                reply = temp.readLine();

                out.println(reply);
            }

            out.close();
            sock.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}


public class Server {
    public static void main(String args[]) {
        try(ServerSocket serversock = new ServerSocket(21)) {
            Socket sock = serversock.accept();
            Thread newConvo = new RequestHandler(sock);
            newConvo.start();
        }
        catch(IOException e) {
            e.printStackTrace();
        }
    }
}
