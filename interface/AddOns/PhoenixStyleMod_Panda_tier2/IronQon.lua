﻿psbossfilep510=1




function pscmrbossREPORTp5101(wipe,try,reset,checkforwipe)
if reset==nil then
if checkforwipe==nil or (checkforwipe and pswasonbossp510 and pswasonbossp510==1) then

	if pswasonbossp510==1 then
		pssetcrossbeforereport1=GetTime()

		if psraidoptionson[2][5][10][1]==1 then
			strochkavezcrash=psmainmgot.." |s4id119414|id ("..psmainmtotal.."): "
			reportafterboitwotab(psraidchats3[psraidoptionschat[2][5][10][1]], true, vezaxname, vezaxcrash, 1)
		end





	end
	if pswasonbossp510==1 or (pswasonbossp510==2 and try==nil) then

		psiccsavinginf(psbossnames[2][5][10], try, pswasonbossp510)

		strochkavezcrash=psmainmgot.." |s4id119414|id: "
		reportafterboitwotab("raid", true, vezaxname, vezaxcrash, nil, nil,0,1)


		psiccrefsvin()

	end




	if wipe then
		pswasonbossp510=2
		pscheckbossincombatmcr_p2=GetTime()+1
	end
end
end
end


function pscmrbossRESETp5101(wipe,try,reset,checkforwipe)
if reset or wipe==nil then
pswasonbossp510=nil


table.wipe(vezaxname)
table.wipe(vezaxcrash)



end
end



function pscombatlogbossp510(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)





if arg2=="SPELL_AURA_APPLIED" and spellid==119414 and name1~=name2 then

  if pswasonbossp510==nil then
    pswasonbossp510=1
  end
  psunitisplayer(guid2,name2)
  if psunitplayertrue then

    pscheckwipe1()
    if pswipetrue and pswasonbossp510~=2 then
      psiccwipereport_p2("wipe", "try")
    end
    addtotwotables1(name2)
    vezaxsort1()

    pscaststartinfo(0,spellname..": "..psaddcolortxt(1,name2)..name2..psaddcolortxt(2,name2), -1, "id1", 1, "|s4id"..spellid.."|id - "..psinfo,psbossnames[2][5][10],2)
  end
end




end