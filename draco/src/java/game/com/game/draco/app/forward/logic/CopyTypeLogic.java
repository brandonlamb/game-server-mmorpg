package com.game.draco.app.forward.logic;

import sacred.alliance.magic.vo.RoleInstance;

import com.game.draco.app.forward.config.ForwardConfig;
import com.game.draco.message.request.C0256_CopyPanelReqMessage;

public class CopyTypeLogic implements ForwardLogic{

	@Override
	public void forward(RoleInstance role, ForwardConfig config) {
		C0256_CopyPanelReqMessage reqMsg = new C0256_CopyPanelReqMessage();
		reqMsg.setCopyType(Byte.parseByte(config.getParameter()));
		role.getBehavior().addEvent(reqMsg);
	}

	@Override
	public ForwardLogicType getForwardLogicType() {
		return ForwardLogicType.copy_type ;
	}

}
