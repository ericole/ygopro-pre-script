--召喚獣メガラニカ
--Magallanica the Eidolon Beast
--Script by nekrozar
function c48791583.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,86120751,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_EARTH),1,true,true)
end
