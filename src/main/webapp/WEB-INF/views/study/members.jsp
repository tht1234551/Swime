<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp" %>

<h2>멤버 관리</h2>
<a class="btn btn-primary" href="/study/get?pageNum=${cri.pageNum}&amount=${cri.amount}&sn=${stdSn}">스터디로 돌아가기</a>


<!-- nav -->
<div class="topnav" style="margin-bottom: 10px;">
    <a href="#member" class="active">참여 멤버</a>
    <a href="#waitingMember">승인 대기 멤버</a>
</div>
<!-- /nav -->

<div id="member">
    <ul id="attendList">

    </ul>
</div>

<div id="waitingMember">
    <ul id="waitingList">

    </ul>
</div>

<!-- 답변 모달창 -->
<div class="answerModal modal fade" id="answerModal" tabindex="-1" role="dialog" aria-labelledby="answerModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="answerModalLabel">스터디 설문 답변</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body"><span style="color: gray; font-size: small">회원의 참석을 승인하거나, 거절할 수 있습니다.</span></div>
            <div class="questionForm form-group" hidden="true">
                <strong><label style="padding-left: 16px;">질문 1. </label></strong>
                <p class="questionLabel" style="padding-left: 16px;"></p>
                <input style="width:465px;margin-left: 16px;" class="form-control answer" readonly>
            </div>
            <div class="questionForm form-group" hidden="true">
                <strong><label style="padding-left: 16px;">질문 2. </label></strong>
                <p class="questionLabel" style="padding-left: 16px;"></p>
                <input style="width:465px;margin-left: 16px;" class="form-control answer" readonly>
            </div>
            <div class="questionForm form-group" hidden="true">
                <strong><label style="padding-left: 16px;">질문 3. </label></strong>
                <p class="questionLabel" style="padding-left: 16px;"></p>
                <input style="width:465px;margin-left: 16px;" class="form-control answer" readonly>
            </div>
            <div class = "modal-footer">
                <button id= "permitBtn" type="button" class="btn btn-primary">승인</button>
                <button id= "rejectBtn" type="button" class="btn btn-default">거절</button>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp" %>

<script type="text/javascript" src="/resources/js/studyMember.js"></script>
<script type="text/javascript" src="/resources/js/studyAttend.js"></script>
<script type="text/javascript" src="/resources/js/studyAnswer.js"></script>

<script>
    $(document).ready(function() {

        // post방식 처리
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        });

    })
</script>

<script>
    $(document).ready(function() {

        getAttendList();
        getWaitingList();

    })
</script>

<script>

    // 참여멤버 가져오기
    function getAttendList() {
        studyMemberService.getAttendList("${stdSn}", function(result) {

            for(let i = 0; i < result.length; i++) {
                console.log(result[i]);
            }

            if(result == null || result.length == 0) {
                $('#attendList').html("");
                return;
            }

            let str = "";

            for(let i = 0; i < result.length; i++) {
                str += '<li>';
                str += '<div class="attendCard">';
                str += '<img src="../../../resources/img/img_avatar2.png" alt="Avatar" class="avatar">';
                str += '<strong> ' + result[i].userName + '</strong>';

                if("${representation}" === result[i].userId) str += '<span style="color:gray;"> 스터디장</span>';

                if(result[i].grpRole === 'GRRO01') str += '<span style="color:gray;"> 모임장</span>';
                if(result[i].grpRole === 'GRRO02') str += '<span style="color:gray;"> 운영진</span>';
                if(result[i].grpRole === 'GRRO03') str += '<span style="color:gray;"> 일반회원</span>';

                str += '</div>';

                // 로그인한 사용자가 스터디장이고, 본인이 아닌 사람들만 강퇴 가능
                if("${pinfo.username}" !== "" && "${representation}" === "${pinfo.username}" && "${representation}" !== result[i].userId) {
                    str += '<div class="attendBtn">';
                    str += '<a id ="cancel" class="' + result[i].userId + '" href="">강퇴</a>'
                    str += '<a id = "ban" class="' + result[i].userId + '" href="">영구강퇴</a>'
                    str += '</div>';
                }

                str += '</li>';
            }

            $('#attendList').html(str);
        });
    }


    // 대기멤버 가져오기
    function getWaitingList() {
        studyMemberService.getWaitingList("${stdSn}", function (result) {
            for(let i = 0; i < result.length; i++) {
                console.log(result[i]);
            }

            if(result == null || result.length == 0) {
                $('#waitingList').html("");
                return;
            }

            let str = "";

            for(let i = 0; i < result.length; i++) {
                str += '<li>';
                str += '<div class="attendCard">';
                str += '<img src="../../../resources/img/img_avatar2.png" alt="Avatar" class="avatar">';
                str += '<strong> ' + result[i].userName + '</strong>';

                if(result[i].grpRole === 'GRRO01') str += '<span style="color:gray;"> 모임장</span>';
                if(result[i].grpRole === 'GRRO02') str += '<span style="color:gray;"> 운영진</span>';
                if(result[i].grpRole === 'GRRO03') str += '<span style="color:gray;"> 일반회원</span>';

                str += '</div>';

                // 로그인한 사용자가 스터디장일때만 답변 보기 가능
                if("${pinfo.username}" !== "" && "${representation}" === "${pinfo.username}" && "${representation}" !== result[i].userId) {
                    str += '<div class="attendBtn">';
                    str += '<a id ="getAnswer" class="' + result[i].userId + '" href="" style="color: blue;">답변보기</a>';
                    str += '</div>';
                }

                str += '</li>';
            }

            $('#waitingList').html(str);
        })
    }
</script>


<!-- 참여멤버 처리 -->
<script>
    $('#attendList').on("click", "li", function(e) {
        e.preventDefault();

        console.log("userId = " + e.target.className);
        console.log("userId = " + e.target.id);

        let userId = e.target.className;
        let method = e.target.id;

        if(method === 'cancel') {
            if (confirm("해당 회원을 정말로 강퇴하겠습니까?")) {
                studyAttendService.cancel({stdSn : ${stdSn}, userId : userId}, function(result) {

                    if(result === 'success') {
                        alert('해당 회원을 성공적으로 강퇴시켰습니다.');
                        getAttendList();

                    }else if (result === 'fail') {
                        alert('해당 회원을 강퇴시키지 못했습니다.');
                    }
                })
            }
        } else if(method === 'ban') {
            if (confirm("해당 회원을 정말로 영구탈퇴시키겠습니까? (해당 회원은 다시 스터디에 참석할 수 없습니다.)")) {
                studyAttendService.ban({stdSn : ${stdSn}, userId : userId}, function(result) {

                    if(result === 'success') {
                        alert('해당 회원을 성공적으로 강퇴시켰습니다.');
                        getAttendList();

                    }else if (result === 'fail') {
                        alert('해당 회원을 강퇴시키지 못했습니다.');
                    }
                })
            }
        }


    })
</script>

<!-- 대기멤버 처리 -->
<script>
    $('#waitingList').on("click", "li", function(e) {
        e.preventDefault();

        console.log("userId = " + e.target.className);
        console.log("userId = " + e.target.id);

        let userId = e.target.className;
        let method = e.target.id;

        if(method === 'getAnswer') {
            // 답변 가져오기
            studyAnswerService.get({userId : userId, stdSn : ${stdSn}}, function(result) {
                for(let i = 0; i < result.length; i++) {
                    console.log(result[i]);

                    // 질문을 모달에 등록
                    $('.questionLabel')[i].innerText = result[i].question;

                    // 답변을 모달에 등록
                    $('.answer')[i].value = result[i].answer;

                    // 해당 신청자의 id를 승인과 거절버튼에 넣어주기
                    $('#permitBtn').attr('data-userId', userId);
                    $('#rejectBtn').attr('data-userId', userId);

                    // form의 hidden 처리를 풀어준다.
                    $('.questionForm')[i].hidden = false;
                }

                // 모달을 띄운다.
                $('#answerModal').modal("show");
            })

        }
    })
</script>

<!-- 대기멤버 승인/거절 처리 -->
<script>
    // 승인 버튼 눌렸을 때
    $('#permitBtn').on("click", function() {

        if(confirm('선택한 신청자의 스터디 참석을 승인하시겠습니까?')) {
            $('#answerModal').modal("hide");

            let userId = $('#permitBtn').data('userid');

            // 해당 신청자의 답변을 모두 삭제
            studyAnswerService.remove({stdSn : ${stdSn}, userId : userId}, function (result) {

                if(result === 'success') {
                    // 성공하면 신청자의 스터디 참석을 진행
                    studyAttendService.attend({stdSn : ${stdSn}, userId : userId}, function(result) {
                        if(result === 'success') {
                            alert('참석 승인 처리가 완료되었습니다.');

                            // 참여 멤버 reload
                            getAttendList();

                            // 대기 멤버 reload
                            getWaitingList();

                        }else {
                            alert('참석 승인 처리를 실패했습니다.');
                        }
                    })

                }else {
                    // 실패하면 실패했다고 띄우고 돌아가기
                    alert('참석 승인 처리를 실패했습니다.');
                }
            })
        }
    })


    // 거절 버튼 눌렸을 때
    $('#rejectBtn').on("click", function() {

        if(confirm('선택한 신청자의 스터디 참석을 거절하시겠습니까?')) {
            $('#answerModal').modal("hide");

            let userId = $('#rejectBtn').data('userid');

            // reject ajax 호출 - 선택한 신청자를 참여명단에서 지우고, 답변도 모두 삭제
            studyAttendService.reject({stdSn : ${stdSn}, userId : userId}, function(result) {

                if(result === "success") {
                    alert('참석 거절 처리가 완료되었습니다.');

                    // 대기 멤버 reload
                    getWaitingList();
                }else {
                    alert('참석 거절 처리를 실패했습니다.');
                }
            })
        }
    })
</script>