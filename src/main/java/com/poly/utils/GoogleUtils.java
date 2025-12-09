package com.poly.utils;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class GoogleUtils {
    // Khai báo biến tĩnh để hứng dữ liệu
    public static String GOOGLE_CLIENT_ID;
    public static String GOOGLE_CLIENT_SECRET;
    public static String GOOGLE_REDIRECT_URI;
    public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
    public static String GOOGLE_GRANT_TYPE = "authorization_code";

    // Khối static này sẽ chạy ngay khi class được gọi lần đầu
    static {
        Properties props = new Properties();
        try (InputStream input = GoogleUtils.class.getClassLoader().getResourceAsStream("env.properties")) {
            if (input == null) {
                System.out.println("Sorry, unable to find env.properties");
            } else {
                // Load dữ liệu từ file
                props.load(input);
                // Gán giá trị vào biến
                GOOGLE_CLIENT_ID = props.getProperty("GOOGLE_CLIENT_ID");
                GOOGLE_CLIENT_SECRET = props.getProperty("GOOGLE_CLIENT_SECRET");
                GOOGLE_REDIRECT_URI = props.getProperty("GOOGLE_REDIRECT_URI");
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    public static String getToken(final String code) throws IOException {
        String response = Request.Post(GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form()
                        .add("client_id", GOOGLE_CLIENT_ID)
                        .add("client_secret", GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", GOOGLE_REDIRECT_URI)
                        .add("code", code)
                        .add("grant_type", GOOGLE_GRANT_TYPE)
                        .build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        return jobj.get("access_token").getAsString();
    }

    public static GooglePojo getUserInfo(final String accessToken) throws IOException {
        String link = GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        return new Gson().fromJson(response, GooglePojo.class);
    }
}