--DDD疾風大王エグゼクティブ・アレクサンダー
--D/D/D Gust High King Executive Alexander
function c101001040.initial_effect(c)
    c:EnableReviveLimit()
    aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
    --spsummon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(101001040,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1,101001040)
    e1:SetCondition(c101001040.spcon)
    e1:SetTarget(c101001040.sptg)
    e1:SetOperation(c101001040.spop)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e2)
    --atk
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCode(EFFECT_UPDATE_ATTACK)
    e3:SetCondition(c101001040.atkcon)
    e3:SetValue(3000)
    c:RegisterEffect(e3)
end
function c101001040.cfilter(c,tp)
    return c:IsFaceup() and c:IsSetCard(0xaf) and c:IsControler(tp)
end
function c101001040.spcon(e,tp,eg,ep,ev,re,r,rp)
    return not eg:IsContains(e:GetHandler()) and eg:IsExists(c101001040.cfilter,1,nil,tp)
end
function c101001040.spfilter(c,e,tp)
    return c:IsSetCard(0xaf) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c101001040.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c101001040.spfilter(chkc,e,tp) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingTarget(c101001040.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectTarget(tp,c101001040.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c101001040.spop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c101001040.atkfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x10af)
end
function c101001040.atkcon(e)
    return Duel.GetMatchingGroupCount(c101001040.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE,nil)>=3
end
