package com.game.draco.app.pet.config;

import java.util.List;

import lombok.Data;
import sacred.alliance.magic.app.attri.AttriItem;
import sacred.alliance.magic.base.AttributeType;

import com.google.common.collect.Lists;

public @Data
class PetAttribute {

	private final static float FULL = 10000;
	protected float petAtk;
	protected float maxHp;
	protected float breakDefense;
	protected float atk;
	protected float rit;
	protected float critAtk;
	protected float critRit;
	protected float hit;
	protected float dodge;

	public void init() {
		this.petAtk /= FULL;
		this.maxHp /= FULL;
		this.breakDefense /= FULL;
		this.atk /= FULL;
		this.rit /= FULL;
		this.critAtk /= FULL;
		this.critRit /= FULL;
		this.hit /= FULL;
		this.dodge /= FULL;
	}

	public float getValue(byte attriType) {
		if (AttributeType.maxHP.getType() == attriType) {
			return this.maxHp;
		}
		if (AttributeType.breakDefense.getType() == attriType) {
			return this.breakDefense;
		}
		if (AttributeType.atk.getType() == attriType) {
			return this.atk;
		}
		if (AttributeType.rit.getType() == attriType) {
			return this.rit;
		}
		if (AttributeType.critAtk.getType() == attriType) {
			return this.critAtk;
		}
		if (AttributeType.critRit.getType() == attriType) {
			return this.critRit;
		}
		if (AttributeType.hit.getType() == attriType) {
			return this.hit;
		}
		if (AttributeType.dodge.getType() == attriType) {
			return this.dodge;
		}
		if (AttributeType.petAtk.getType() == attriType) {
			return this.petAtk;
		}
		return 1;
	}

	public List<AttriItem> getAttriItemList() {
		List<AttriItem> list = Lists.newArrayList();
		this.append(list, AttributeType.maxHP, maxHp);
		this.append(list, AttributeType.breakDefense, breakDefense);
		this.append(list, AttributeType.atk, atk);
		this.append(list, AttributeType.rit, rit);
		this.append(list, AttributeType.critAtk, critAtk);
		this.append(list, AttributeType.critRit, critRit);
		this.append(list, AttributeType.hit, hit);
		this.append(list, AttributeType.dodge, dodge);
		this.append(list, AttributeType.petAtk, petAtk);
		return list;
	}

	private void append(List<AttriItem> list, AttributeType at, float value) {
		if (null == at || value <= 0.0) {
			return;
		}
		list.add(new AttriItem(at.getType(), value, false));
	}
}
