<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/tagLib.jsp" %>

<div class="container-fluid">
    <!-- <h2 class="mt-4">회원관리</h2> -->
    <ol class="breadcrumb mb-4">
        <!-- <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li> -->
        <li class="breadcrumb-item active">manage-user</li>
    </ol>
    <div class="card mb-4">
        <div class="card-header">
        </div>
        <div class="card-body">
            <div class="option-search">
                <div>
                    <select class="lines">
                        <option value="">--줄--</option>
                        <option value="10">10</option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                    </select>
                </div>
                <div style="display: flex; margin-left: auto;">
                    <select>
                        <option value="">--상태--</option>
                        <option value="normal">정상</option>
                        <option value="quit">탈퇴</option>
                    </select>
                    <div class="search-bar">
                        <input type="text" placeholder="Search.." >
                        <button class="search-button"><i class="fas fa-search"></i></button>
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered" width='100%' cellspacing="0">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>email</th>
                        <th>이름</th>
                        <th>가입일</th>
                        <th>수정일</th>
                        <th>상태</th>
                    </tr>
                    </thead>
                    <tr>
                        <td>1</td>
                        <td>ssk900620@gmail.com</td>
                        <td>신성권</td>
                        <td>2009/01/01</td>
                        <td>2010/03/12</td>
                        <td>정상</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>ssk900620@gmail.com</td>
                        <td>신상권</td>
                        <td>2020/07/12</td>
                        <td>2020/07/12</td>
                        <td>비정상</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>ssk900620@gmail.com</td>
                        <td>김성권</td>
                        <td>1990/06/20</td>
                        <td>1998/05/11</td>
                        <td>정상</td>
                    </tr>
                </table>
            </div>
            <div style="display: flex; justify-content: space-between;">

                <div>
                    <button class="footer-button">수정</button>
                    <button class="footer-button2">삭제</button>
                </div>
                <div>
                    <button class="page-number"><</button>
                    <button class="page-number">1</button>
                    <button class="page-number">2</button>
                    <button class="page-number">3</button>
                    <button class="page-number">></button>

                </div>
            </div>

        </div>
    </div>
</div>