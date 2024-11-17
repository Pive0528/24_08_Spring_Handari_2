<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page
        import="java.net.HttpURLConnection, java.net.URL, java.io.BufferedReader, java.io.InputStreamReader, org.json.JSONObject" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>

<%
    String city = request.getParameter("city") != null ? request.getParameter("city") : "Daejeon";
    String apiKey = "2b62a46be3f92ad9414c7c6d8a36433c";
    String apiUrl = String.format("https://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s&units=metric", city, apiKey);

    String cityName = "Unknown";
    String temp = "--";
    String icon = "01d"; // 기본 아이콘
    String weatherDescription = ""; // 날씨 상태
    String adviceMessage = ""; // 날씨 및 온도에 따른 메시지

    try {
        // OpenWeatherMap API 호출
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        // API 응답 읽기
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }
        br.close();

        // JSON 데이터 파싱
        JSONObject json = new JSONObject(sb.toString());
        cityName = json.getString("name");
        temp = json.getJSONObject("main").get("temp").toString();
        icon = json.getJSONArray("weather").getJSONObject(0).getString("icon");
        weatherDescription = json.getJSONArray("weather").getJSONObject(0).getString("main"); // 날씨 설명

        // 온도 값을 숫자로 변환
        double temperature = Double.parseDouble(temp);

        // 온도와 날씨에 따른 메시지 설정
        if (temperature < 5) {
            adviceMessage = "쌀쌀한 날씨에요. 체온 변화에 유의하세요.";
        } else if (temperature < 15) {
            adviceMessage = "약간 선선한 날씨입니다. 가벼운 외투를 준비하세요.";
        } else if (temperature < 25) {
            adviceMessage = "쾌적한 날씨에요. 야외 활동을 즐기기 좋은 날입니다.";
        } else {
            adviceMessage = "더운 날씨에요. 수분 섭취를 충분히 하세요.";
        }

        // 특정 날씨 상태에 따른 메시지 추가
        if (weatherDescription.contains("Rain") || weatherDescription.contains("Drizzle")) {
            adviceMessage += "<br>비가 올 수 있으니 우산을 챙기는게 좋아보여요.";
        } else if (weatherDescription.contains("Snow")) {
            adviceMessage += "<br>눈이 오고 있어요. 미끄럼에 주의하세요.";
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 현재 시간 포맷팅
    SimpleDateFormat sdf = new SimpleDateFormat("MM-dd HH:mm");
    String currentTime = sdf.format(new Date());
%>
<div id="weatherPopup" class="weather-popup">
    <div class="weather-content">
        <div class="weather-icon">
            <img src="http://openweathermap.org/img/wn/<%= icon %>@2x.png" alt="Weather Icon" />
        </div>
        <div class="weather-info">
            <div class="weather-header"><%= cityName %></div>
            <div class="weather-temp-time">
                <span class="weather-temp"><%= temp %>°C</span>
                <span class="weather-time"><%= currentTime %> 기준</span>
            </div>
            <div class="weather-advice"><%= adviceMessage %></div>
        </div>
    </div>
</div>

<style>
    .weather-popup {
        position: absolute;
        top: 30px;
        left: 30px;
        width: 35%; /* 가로 길이 설정 */
        padding: 15px; /* 패딩 증가 */
        background: rgba(255, 255, 255, 0.9);
        border-radius: 15px; /* 둥근 테두리 */
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        font-family: Arial, sans-serif; /* 글꼴 설정 */
        font-size: 14px; /* 기본 글씨 크기 */
        display: flex;
        align-items: center;
        z-index: 1000;
    }

    .weather-content {
        display: flex;
        align-items: center; /* 아이콘과 텍스트 수직 정렬 */
        width: 100%; /* 내용 가로 정렬 */
    }

    .weather-icon {
        flex: 1;
        display: flex;
        justify-content: center; /* 아이콘을 중앙 정렬 */
    }

    .weather-icon img {
        width: 100%; /* 아이콘 크기 설정 */
        border: 1px lightgray solid;
        border-radius: 100%;
    }

    .weather-info {
        flex: 3;
        text-align: left; /* 텍스트 왼쪽 정렬 */
        margin-left: 15px; /* 아이콘과 텍스트 간격 */
    }

    .weather-header {
        font-size: 22px; /* 도시명 크기 */
        font-weight: bold;
    }

    .weather-temp-time {
        display: flex;
        justify-content: space-between; /* 온도와 날짜를 같은 줄에 배치 */
        margin-top: 5px;
        font-size: 18px; /* 온도와 시간 크기 */
    }

    .weather-temp {
        font-weight: bold;
    }

    .weather-time {
        color: #555; /* 시간 글씨 색상 */
        font-size: 14px; /* 날짜 크기 */
        margin-left: 10px; /* 온도와 날짜 간격 */
    }

    .weather-advice {
        margin-top: 10px;
        font-size: 14px;
        color: #555; /* 메시지 색상 */
        white-space: nowrap; /* 줄바꿈 방지 */
        overflow: hidden;
        text-overflow: ellipsis; /* 긴 텍스트 처리 */
    }

    @media (max-width: 768px) {
        .weather-advice {
            white-space: normal; /* 반응형: 화면이 좁아지면 줄바꿈 허용 */
        }
    }
</style>
