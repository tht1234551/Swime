package com.swime.mapper;

import com.swime.domain.BoardLikeVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class BoardLikeMapperTests {

    @Setter(onMethod_ = @Autowired)
    private BoardLikeMapper mapper;



    @Test
    public void testInsert(){
        BoardLikeVO boardLike = new BoardLikeVO();

        boardLike.setBrdSn(1L);
        boardLike.setUserId("toywar1@naver.com");

        mapper.insert(boardLike);

        log.info(boardLike);

    }
    @Test
    public void testInsert2(){
        BoardLikeVO boardLike = new BoardLikeVO();

        boardLike.setBrdSn(3L);
        boardLike.setUserId("to13@naver.com");

        mapper.insert(boardLike);

        log.info(boardLike);

    }

    @Test
    public void testDelete(){

        log.info("DELETE COUNT: " +
                mapper.delete(1L,"toytoy@naver.com"));
    }

    @Test
    public void testGetBoardLikeCnt(){

        int board = mapper.getBoardLikeCnt(44L);

        log.info(board);
    }
}