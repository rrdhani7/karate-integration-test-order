package api;


import java.time.LocalDate;
import java.util.Date;

public class DataGenerator {
    private static LocalDate now;
    public static String rootDir() {
        System.out.println("User dir: ");
        return System.getProperty("user.dir");
    }
}
