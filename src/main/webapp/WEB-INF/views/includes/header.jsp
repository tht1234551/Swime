<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="pinfo"/>
</sec:authorize>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">


    <title>SWIME</title>


    <!-- Bootstrap core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/resources/css/small-business.css" rel="stylesheet">

    <!-- nav -->
    <link href="/resources/css/nav.css" rel="stylesheet">

    <!-- avatar -->
    <link href="/resources/css/avatar.css" rel="stylesheet">

    <!-- filter -->
    <link href="/resources/css/filter.css" rel="stylesheet">

    <!-- jquery -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <!-- fontawsome icon -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

    <style>
        @media (min-width: 768px) {
            .container {
                width: 750px;
            }
        }

        @media (min-width: 992px) {
            .container {
                width: 1000px;
            }
        }
    </style>

</head>

<body>
<!-- header -->
<div class="header">
    <a href="/" class="logo"><img src="../../../resources/img/logo2.png"></a>
    <a href="/group/list">모임찾기</a>
    <a href="/group/register">모임만들기</a>

    <div class="header-right">
        <sec:authorize access="isAuthenticated()">
        <a href="/serviceCenter/list">고객센터</a>
        </sec:authorize>
        <sec:authorize access="isAnonymous()">
            <a href="/user/register">회원가입</a>
            <a class="active" href="/user/login">로그인</a>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <a href="/user/infoDetail?id=<sec:authentication property='principal.username'/>"><sec:authentication property="principal.memberVO.name"/> 님 안녕하세요</a>
            <sec:authorize access="hasAuthority('ADMIN')">
                <a href="/admin/adminIndex">어드민 페이지</a>
            </sec:authorize>
            <a href="#" onclick="document.getElementById('logout').submit();">로그아웃</a>
        </sec:authorize>
    </div>
</div>

<form id="logout" action="/user/logout" method="post">
    <%--    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>--%>
    <sec:csrfInput/>
</form>

<hr style="
    margin-top: 0px;
    margin-bottom: 0px;">

