package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ReactionPointService;
import com.example.demo.service.ReplyService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Reply;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrReplyController {

	@Autowired
	private Rq rq;

	@Autowired
	private ReactionPointService reactionPointService;

	@Autowired
	private ReplyService replyService;

	@RequestMapping("/usr/reply/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, String relTypeCode, int relId, String body) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (Ut.isEmptyOrNull(body)) {
			return Ut.jsHistoryBack("F-2", "내용을 입력해주세요");
		}

		ResultData writeReplyRd = replyService.writeReply(rq.getLoginedMemberId(), body, relTypeCode, relId);

		int id = (int) writeReplyRd.getData1();

		return Ut.jsReplace(writeReplyRd.getResultCode(), writeReplyRd.getMsg(), "../article/detail?id=" + relId);
	}
	
	@RequestMapping("/usr/reply/doDelete")
	@ResponseBody
	public String doDelete(int id, HttpServletRequest req) {
	    Rq rq = (Rq) req.getAttribute("rq");

	    // Get the reply by its ID
	    Reply reply = replyService.getReply(id);

	    if (reply == null) {
	        return Ut.jsHistoryBack("F-1", "존재하지 않는 댓글입니다.");
	    }

	    // Assuming the author can delete their own reply
	    if (reply.getMemberId() != rq.getLoginedMemberId()) {
	        return Ut.jsHistoryBack("F-2", "댓글을 삭제할 권한이 없습니다.");
	    }

	    // Delete the reply
	    replyService.deleteReply(id);

	    return Ut.jsReplace("S-1", "댓글이 삭제되었습니다.", "../article/detail?id=" + reply.getRelId());
	}

	
	
	

}
