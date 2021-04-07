package com.swime.service;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyService {
    public int register(StudyVO study);

    public StudyVO get(Long sn);

    public int modify(StudyVO study);

    public int remove(Long sn);

    public List<StudyVO> getList();

    public List<StudyVO> getList(StudyCriteria cri);

    public List<StudyVO> getWishList(StudyCriteria cri);

    public int wish(WishStudyVO wish);

    public int cancelWish(Long stdSn,String userId);
}
