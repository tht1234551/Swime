package com.swime.controller;

import com.swime.domain.*;
import com.swime.mapper.GroupTagMapper;
import com.swime.service.AuthService;
import com.swime.service.MemberService;
import com.swime.service.ProfileService;
import com.swime.util.GmailSend;
import com.swime.util.MakeRandomValue;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("/user")
@Log4j
@AllArgsConstructor
public class UserController {

    MemberService service;
    PasswordEncoder passwordEncoder;
    AuthService authService;
    GmailSend gmailSend;
    MakeRandomValue makeRandomValue;
    ProfileService profileService;
    GroupTagMapper groupTagMapper;


    @GetMapping("/already")
    public ResponseEntity<Boolean> isAlready(String id){
        return service.get(id) != null ?
                new ResponseEntity<>(true, HttpStatus.OK) :
                new ResponseEntity<>(false, HttpStatus.OK);
    }

    @GetMapping("/login")
    public void login(){
    }

    @GetMapping("/register")
    public void register(){
    }

    @Transactional
    @PostMapping("/register")
    public ResponseEntity<String> register(MemberVO vo, RedirectAttributes rttr){
        log.info(vo);
        boolean result = false;
        boolean result1 = false;
        boolean result2 = false;
        boolean result3 = false;
        vo.setPassword(passwordEncoder.encode(vo.getPassword()));
        result = service.registerHistory(vo);
        result1 = service.register(vo);
        String key = makeRandomValue.MakeAuthKey();
        result2 = service.registerKey(vo.getId(), key);
        result3 = authService.register(vo.getId(),"MEMBER");
        gmailSend.sendAuthMail(new MailVO(vo.getId(), key));
        rttr.addFlashAttribute("vo", vo);
//        return "redirect:/user/registerSuccess";
        boolean all = result && result1 && result2 && result3;
        return all ?
                new ResponseEntity<>("Register Success", HttpStatus.OK) :
                new ResponseEntity<>("Register Fail", HttpStatus.BAD_REQUEST);
    }



    @GetMapping("/registerSuccess")
    public void regSuccess(MemberVO vo){}

    @GetMapping("/modify")
    public void modify(){
    }

    @PostMapping("/modify")
    public ResponseEntity<String> modify(MemberVO vo, MemberHistoryVO hvo){//, MemberHistoryVO hvo
        log.info("Modify = " + vo);
        service.modify(vo, hvo);
        return service.modify(vo, hvo) ?
                new ResponseEntity<>("Modify Success", HttpStatus.OK) :
                new ResponseEntity<>("Modify Fail", HttpStatus.BAD_REQUEST);
    }

    @GetMapping("/remove")
    public void remove(){
    }

    @PostMapping("/remove")
    public ResponseEntity<String> remove(@RequestBody String id,
                                         @RequestBody MemberHistoryVO hvo){
        return service.remove(id, hvo) ?
                new ResponseEntity<>("Remove Success", HttpStatus.OK) :
                new ResponseEntity<>("Remove Fail", HttpStatus.BAD_REQUEST);
    }

    @GetMapping("/getlist")
    public List<MemberVO> getlist(){
        return service.getlist();
    }

    @Transactional
    @GetMapping("/auth")
    public String auth(String key, String id){
        // 키를 조회하고
        if(!service.isKey(id, key)) return null;
        // 키를 삭제
        service.deleteKey(id);
        // 멤버 이력을 수정하고
//        service.registerHistory(vo);
        // 멤버 항목중 인증날짜를 수정한다
        service.updateAuthdate(id);
        return "redirect:/user/AuthSuccess";
    }

    @GetMapping("/AuthSuccess")
    public void emailAuth(){
    }

    @GetMapping("/info")
    public void infotest(){
    }

    @GetMapping("/infoDetail")
    public void infoDetail(Model model, String id){
        model.addAttribute("MemberVo", service.get(id));
    }

    @GetMapping("/details/info")
    public void info(Model model, String id){
        model.addAttribute("MemberVo", service.get(id));
    }

    @GetMapping("/details/group")
    public void group(Model model, String id){
        List<GroupVO> ownerList = profileService.getOwnerGroupList(id);
        List<GroupVO> joinList = profileService.getJoinGroupList(id);
        List<GroupVO> wishList = profileService.getWishGroupList(id);

        List<List<GroupVO>> list = new ArrayList<>();
        list.add(ownerList);
        list.add(joinList);
        list.add(wishList);

        Iterator<List<GroupVO>> it = list.iterator();

        while (it.hasNext()){
            List<GroupVO> vo = it.next();
            vo.forEach(group -> {
                List<String> tags = new ArrayList<>();
                groupTagMapper.getList(group.getSn()).forEach(tag -> tags.add(CodeTable.valueOf(tag.getName()).getValue()));
                group.setTags(tags);
            });
        }

        model.addAttribute("ownerList", ownerList);
        model.addAttribute("joinList", joinList);
        model.addAttribute("wishList", wishList);

    }

    @GetMapping("/details/study")
    public void study(Model model, String id){
        model.addAttribute("MemberVo", service.get(id));
    }

    @GetMapping("/details/written")
    public void written(){
    }

    @GetMapping("/details/reply")
    public void reply(){
    }

    @GetMapping("/details/profile")
    public void profile(Model model, String id){
        model.addAttribute("MemberVo", service.get(id));
    }


    String dateFormat(Date date){

        return null;
    }



}