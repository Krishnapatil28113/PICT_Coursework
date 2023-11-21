package Synchronization;
import java.util.LinkedList;
import java.util.Random;
import java.util.Scanner;
import java.util.Queue;
import java.util.concurrent.Semaphore;

public class synchronization {
    
    private static int BUFFER_SIZE;
    private static int TOTAL_ITEMS;

    static Queue<Integer> buffer = new LinkedList<>();
    static int itemCounter = 0;

    private static Semaphore empty;
    private static Semaphore full = new Semaphore(0);
    private static Semaphore mutex = new Semaphore(1);

    public static void main(String args[]) {

        Scanner sc = new Scanner(System.in);

        System.out.println("Enter the size of the buffer: ");
        BUFFER_SIZE = sc.nextInt();
        empty = new Semaphore(BUFFER_SIZE);

        System.out.println("Enter the total count of the semaphore: ");
        TOTAL_ITEMS = sc.nextInt();

        sc.close();
        
        Thread producerThread = new Thread(synchronization::producer);
        Thread consumerThread = new Thread(synchronization::consumer);

        producerThread.start();
        consumerThread.start();

        try{
            producerThread.join();
            consumerThread.join();
        } catch(InterruptedException ie) {
            System.out.println(ie);
        }
    }

    public static void producer() {
        Random random = new Random();

        while(itemCounter < TOTAL_ITEMS) {
            try {
            
                Thread.sleep(random.nextInt(1500) + 150);

                int item = random.nextInt(100) + 1;

                empty.acquire();
                mutex.acquire();

                buffer.add(item);

                System.out.println("Produced item: " + item + " , Buffer: " + buffer);

                mutex.release();
                full.release();
                itemCounter++;

            } catch(InterruptedException ie) {
                ie.printStackTrace();
            }

        }
    }

    public static void consumer() {
        Random random = new Random();

        while(itemCounter < TOTAL_ITEMS) {
        
            try{
                Thread.sleep(random.nextInt(1500) + 150);
                
                full.acquire();
                mutex.acquire();

                int item = buffer.poll();

                System.out.println("Consumed item: " + item + " , Buffer: " + buffer);

                mutex.release();
                empty.release();
            }
            catch(InterruptedException ie) {
                ie.printStackTrace();
            }
        }
    }
};