<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="메인화면"></c:set>
<%@ include file="../common/head.jspf" %>
<%@ page import="java.util.Calendar" %>
<hr/>


<div class="mx-auto max-w-screen-lg">
    <!-- Get the current month using JSP/Java -->
    <%
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        String imageUrl = "";
        String textOverlay = "";

        if (month >= 8 && month <= 10) {
            imageUrl = "https://i.ibb.co/1b1nYgT/image-1.png";
            textOverlay = "가을의 첫 단풍을 볼 수 있는 곳, 설악산";
        } else if (month >= 5 && month <= 7) {
            imageUrl = "https://i.ibb.co/NYyYGTK/image-2.png";
            textOverlay = "뜨거운 태양 아래 시원한 바람이 반가운 계절.";
        } else if (month >= 2 && month <= 4) {
            imageUrl = "https://i.ibb.co/7tHzkxN/image-1.png";
            textOverlay = "싱그러운 벚꽃이 피는 계절.";
        } else {
            imageUrl = "https://i.ibb.co/CQdYYtx/image-3.png";
            textOverlay = "하얀 눈이 소복이 쌓여 세상을 포근하게 덮어주는 계절.";
        }
    %>

    <!-- Background image with content inside -->
    <div class="background-image-section" style="background-image: url('<%= imageUrl %>');">
        <!-- 텍스트 오버레이 -->
        <div class="text-overlay"><%= textOverlay %>
        </div>

        <!-- Weather.jsp 포함 -->
        <jsp:include page="./Weather.jsp"/>
        <!-- Right-hand side content within the background image -->
        <div class="side-content-overlay">
            <!-- Notice Section -->
            <!-- 공지사항 섹션 -->
            <div class="notice-section">
                <div class="title">공지사항</div>
                <ul class="notice-list">
                    <c:forEach var="article" items="${articles}" varStatus="status">
                        <c:if test="${status.index < 3}">
                            <li class="notice-item">
                                <a href="/usr/article/detail?id=${article.id}" class="notice-text">${article.title}</a>
                                <span class="date">${article.regDate.substring(5,10)}</span>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
                <div class="more-link">
                    <a href="../article/list?boardId=1">바로가기 -></a>
                </div>
            </div>

            <!-- 축제후기 HOT 섹션 -->
            <div class="festival-hot-section">
                <div class="title">축제후기</div>
                <ul class="festival-list">
                    <c:forEach var="article" items="${articlesFestival}" varStatus="status">
                        <c:if test="${status.index < 3}">
                            <li class="festival-item">
                                <a href="/usr/article/detail?id=${article.id}"
                                   class="festival-text">${article.title}</a>
                                <span class="date">${article.regDate.substring(5,10)}</span>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
                <div class="more-link">
                    <a href="../article/list?boardId=3">바로가기 -></a>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<%@ include file="../common/foot.jspf" %>
