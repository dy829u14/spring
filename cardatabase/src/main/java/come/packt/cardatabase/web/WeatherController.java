package come.packt.cardatabase.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;



@RestController
@RequestMapping("/weather")
public class WeatherController {
	WeatherController(){

	    }

	    @GetMapping("/wea")
	    //String CURRENT_DATE, String CITY_AREA_ID
	    
	    public String weather(String CURRENT_DATE, String CITY_AREA_ID) throws IOException, java.io.IOException {
	        String apiUrl = "https://apis.data.go.kr/1360000/TourStnInfoService1/getCityTourClmIdx1";

	        String serviceKey = "d1EvELSunEH5MUvsn9zoOoY6BUpLMjjvRVuFd2lNrK%2FIKvsh%2B8rNtY9AzP0AYAqcmnnAIz9W6JqYnGwy80ARNg%3D%3D";
	        String pageNo = "1";	//페이지 번호
	        String numOfRows = "10";	//한 페이지 결과 수
	        String dataType = "JSON";	//데이터 타입
	     // String CURRENT_DATE = "20230902";	//조회하고싶은 날짜
	        String DAY = "3";	//조회하고 싶은 날짜의 시간 날짜
	      // String CITY_AREA_ID = "2620000000";	//지역 ID


	        StringBuilder urlBuilder = new StringBuilder(apiUrl);
	        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+serviceKey);
	        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode(pageNo, "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode(dataType, "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("CURRENT_DATE","UTF-8") + "=" + URLEncoder.encode(CURRENT_DATE, "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("DAY","UTF-8") + "=" + URLEncoder.encode(DAY, "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("CITY_AREA_ID","UTF-8") + "=" + URLEncoder.encode(CITY_AREA_ID, "UTF-8"));

	        /*
	         * GET방식으로 전송해서 파라미터 받아오기
	         */
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        String result= sb.toString();
	        System.out.println(result);

	    return result;
	    }
	}
