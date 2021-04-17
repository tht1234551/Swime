package com.swime.service;

import com.swime.domain.BoardCriteria;
import com.swime.domain.ReplyPageDTO;
import com.swime.domain.ReplyVO;

import java.util.List;

public interface ReplyService {

    public int register(ReplyVO reply);

    public ReplyVO get(Long sn);

    public int modify(ReplyVO reply);

    public int remove(Long sn);

    //댓글 개수(getCountByBrdSn)
    public int getReplyCnt(Long brdSn);

    //일단 냅두고...해결되면 지우기
    //public List<ReplyVO> getList(BoardCriteria cri, Long brd_sn);

    //댓글 -> 댓글 수 처리, (페이징)
    public ReplyPageDTO getListPage(BoardCriteria cri, Long brdSn);
}