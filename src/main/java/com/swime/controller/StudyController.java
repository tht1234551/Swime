package com.swime.controller;


import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyParamVO;
import com.swime.domain.StudyVO;
import com.swime.service.StudyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.ucp.proxy.annotation.Post;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/study")
@Log4j
@AllArgsConstructor
public class StudyController {

    private StudyService service;

    // 스터디 리스트 페이징처리
    @GetMapping("/list")
    public void getList(StudyCriteria cri, Model model) {
        model.addAttribute("list", service.getList(cri));
    }

    // 스터디 상세조회
    @GetMapping("/get")
    public void get(@RequestParam("sn") Long sn, Model model) {
        model.addAttribute("study", service.get(sn));
        model.addAttribute("members", service.getAttendantList(sn));
    }

    // 스터디 생성
    @PostMapping("/register")
    public String register(StudyVO study) {
        service.register(study);

        // 만들어진 스터디의 상세조회 페이지로 이동한다.
        return "redirect:/study/get?sn=" + study.getSn();
    }

    // 스터디 수정
    @PostMapping("/modify")
    public String modify(StudyVO study) {
        service.modify(study);

        // 수정된 스터디의 상세조회 페이지로 이동한다.
        return "redirect:/study/get?sn=" + study.getSn();
    }

    // 스터디 삭제
    @PostMapping("/remove")
    public String remove(StudyParamVO param, RedirectAttributes rttr) {
        if(service.remove(param) == 1) {
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/group/";  //??
    }
    
    // 스터디 멤버 관리 - 참여멤버/ 대기멤버 가져오기
    @GetMapping("/manage")
    public void manage(long stdSn, Model model) {
        model.addAttribute("attendantList", service.getAttendantList(stdSn));
        model.addAttribute("waitingList", service.getWaitingList(stdSn));
    }

}
