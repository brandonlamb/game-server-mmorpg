package sacred.alliance.magic.action;

import com.game.draco.GameContext;
import com.game.draco.message.push.C0003_TipNotifyMessage;
import com.game.draco.message.request.C0567_WarehousePutReqMessage;
import com.game.draco.message.response.C0567_WarehouseTakeRespMessage;

import sacred.alliance.magic.app.goods.RoleGoodsHelper;
import sacred.alliance.magic.app.goods.behavior.result.GoodsResult;
import sacred.alliance.magic.base.OutputConsumeType;
import sacred.alliance.magic.constant.TextId;
import sacred.alliance.magic.constant.Status;
import sacred.alliance.magic.core.Message;
import sacred.alliance.magic.core.action.ActionContext;
import sacred.alliance.magic.domain.RoleGoods;
import sacred.alliance.magic.vo.RoleInstance;

public class WarehousePutAction extends BaseAction<C0567_WarehousePutReqMessage>{

	@Override
	public Message execute(ActionContext context, C0567_WarehousePutReqMessage req) {
		RoleInstance role = this.getCurrentRole(context);
		if(role == null){
			return null;
		}
		if(!role.hasUnion()) {
			return new C0003_TipNotifyMessage(this.getText(TextId.FACTION_NOT_HAVE_FACTION));
		}
		
		C0567_WarehouseTakeRespMessage resp = new C0567_WarehouseTakeRespMessage();
		String goodsInstanceId = req.getGoodsInstanceId();
		
		RoleGoods roleGoods = role.getRoleBackpack().getRoleGoodsByInstanceId(goodsInstanceId);
		if(roleGoods == null){
			resp.setInfo(Status.GOODS_NO_FOUND.getTips());
			return resp;
		}
		if(RoleGoodsHelper.isOfflineDie(roleGoods)){
			resp.setInfo(Status.GOODS_OFFLINEDIE_NOPUT_WAREHOUSE.getTips());
			return resp;
		}
		if(RoleGoodsHelper.isActivate(roleGoods)){
			resp.setInfo(this.getText(TextId.GOODS_DEADLINE_ACTIVE_WAREHOUSE));
			return resp;
		}
		
		GoodsResult result = GameContext.getUserWarehouseApp().put(role, roleGoods, 
				OutputConsumeType.goods_warehouse_add);
		if(!result.isSuccess()){
			resp.setInfo(result.getInfo());
			return resp;
		}
		resp.setType((byte)1);
		return resp;
	}
}
