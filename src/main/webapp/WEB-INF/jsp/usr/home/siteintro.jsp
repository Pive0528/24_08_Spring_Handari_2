<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="사이트소개"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />

<!-- Wrapper div to draw a border around the central content, including images -->
<div class="border-wrapper" style="border: 2px solid #ccc; border-radius: 25px; padding: 20px; margin: 40px auto; max-width: 1200px;">

    <div class="container mx-auto"
        style="text-align: center;">
        <p style="font-size: 30px;">한다리 프로젝트는?</p>

        <p style="font-size: 18px; line-height: 1.6; margin: 20px 0;">
            <div class="text1">현대 사회의 사람들은 일과 일상에 짓눌려 점점 새로운 만남과 소통의 경험이 줄어들고
                있습니다.</div>
            <div class="text2">한다리는 소통과 만남의 경험을 늘리기 위해 지역 축제에서라도 가볍게 만나</div>
            <div class="text3">축제를 즐길 수 있는 커뮤니티가 필요하다고 생각하여 제작하게 된 프로젝트입니다.</div>
        </p>

        <!-- Images Section with rounded corners -->
        <div style="display: flex; justify-content: center; align-items: center; gap: 20px; margin-top: 30px;">
            <!-- Left Image (Map) -->
            <img
                src="https://korean.visitkorea.or.kr/kfes/resources/img/2023FestivalMap.jpg"
                alt="축제 지도"
                style="max-width: 300px; width: 100%; border: 1px solid #ccc; border-radius: 15px;">

            <!-- Middle Image (Centrally aligned) -->
            <img
                src="https://jejusotong.kr/data/cheditor4/2310/20231025103200_sdvrhals.jpg"
                alt="축제 이미지"
                style="max-width: 400px; height: 200px; border: 1px solid #ccc; border-radius: 15px;">

            <!-- Right Image (Poster) -->
            <img
                src="https://image.ajunews.com/content/image/2022/04/25/20220425140636865980.jpg"
                alt="축제 이미지"
                style="max-width: 300px; width: 100%; height: auto; border: 1px solid #ccc; border-radius: 15px;">
        </div>
    </div>

</div>

<%@ include file="../common/foot.jspf"%>
