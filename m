Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB7E1D5176
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797341; cv=none; b=Wk/R/awbpoVb8G0widZe9awCXk972WtdblJPMw24m25CG/C8GIj1Zlc/9m9iVCCs7wuMWfkZDH5J7ckdUcpduBEIKJ56oyyGMK7fkhcCXatYWhb1dwtnIu8/1mf+quHZS3msx7r9RBA1kw4DtKloxDVmi5F/ddlVrbri0rQNg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797341; c=relaxed/simple;
	bh=1PHUVzzaiBYgz5npELLE/NTHEwbh0ZgAFoEjtFfjE7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqnHYHJuq+L75PRvojY7ggYzJ9Js65A3kxSk8+hHDYI2ZxTiwej8igc5QN34CiynH97xLPNZYPzZhMEn/xGNz3C/jIiuQgkJXdIzWyRnUGKuiJFEUSoOHzlNYbaIa4IteX+C+Zs6wB5kV+KnEFJLXNPkUC/i8QnxQCahHV2BOP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=I3aqfiI/; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="I3aqfiI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741797332; bh=OnFLpODjASut6A2ge/hSbA7JxNiRbK+quw7LVPBuPjQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=I3aqfiI/P8bggg+jeqq3joVHbOIbSSrhwjB1+0mzENlkn/XV5bVygBHYnBTtfHNxOtzllspiczvOM4y7yWF6gTb7BqmrVAb/quUOZ+wwG+QAT0OK26isntaW3T3CKpIc+dNXPzX0J5A6f0CjjGd6JL2FnRPmDvJHEpJypzl8suMiZuq5sIhrb1BYB/jZnSW/BNajkYS3NLIHecwnbMDMn666AdjPuD4/Xq1etU7xpSofepkU5Vo663FB+ApMpS79MqwoNX09yoc24FjU/VMrJnROSIChxUawJbDH3jvUsrTW982eZmtIJF+qI4GTWePMEX93SMSxej7j3RfnH6MMxw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741797332; bh=D7YnPpxqCeVBV0qeTReMZr/mNe71lVBpbTrzrVc8Znb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=T7KPkLGvD4RwcQqYE9umfyIKGr+DQ8gVVou6ri1P7k90GH5ZaG1sMPu6cmvKtb5anXOWmVDNZvYuwxUvJ0X3ceYMExDwoU5RKarG1YkVePdgYmA9Q4QyxXW7ctPi0EiORxcn0yi+j5JvAmf/eSz6cdkaGXH6MKoRsPIiPB7aT3ZQKF2owKE/1Zy2S5vKoYMct5EU/jjsDmMU4TE8PA53MxDqZF04hhZcsnYEfIB+ebz3vgDvuQeoSfmrQ/tH94K3WLB0T/CWMffA7zkXclE9jFS6zNus7tUTVG3lBzolwwgbKuD6jW1fKO5SnjknxiifTbJkao9oZuAYoxeVW41PWQ==
X-YMail-OSG: RbMg4TkVM1k3QwwOLn1yX1o8S_h0P2Bfgjer_3a8VMZXiGVFNPamtif0tsGI8E_
 Mz_S4Dj5nYV3rv2YwJAK1Bru1If5aPt_6idnfGmvE1K088N5AloItOl25l2BgK5ZZV4sRlijDLk5
 8pN3R1lpO5ZmM6ZqPGfSzBqFKAuzmUVyeSfPC7B2OakOwUNy8DQDxvaEaAiDWYZ8NbTrSVUc7gXr
 wrRO7BcFOQbiXIwCwiqks8Aspr.pt32ehoSuHyQNaLMTCHU5dz3uxRoHpNv3715rI.VhnpowuMUG
 _cfORFs2rhemXDEnOYqfIlYCCN9g1U_.Jj72TiORuoa6cDIR5QUB.bZL4dap1ym2UNrQFXO2zqem
 YjdUXba.xrfQ_kPrN_3crm.DlrB40p1_wL21bukPryzulK0TkvZ_3NRdorg3i8FJZm..6fbubpt9
 xk5RYwXJFXlGoPAks.nBdznX5A424eOBEava6WtJBhkJFT398WZ7ssgo_XN77aEQlaPeaA_uP3i5
 TSkaidFGJvtKTWbTTXHu80Wlo6OE4XAcO.kLj2qWHlr6OOGxa9Dd74l4lMh3FUrF6SRLd.bSiYHo
 8LHWC63pp8452SnfspTaWWuwMLbQbC2MbUEi99hwWPZvCiEn3c8WWYjdz5dvXdoncYmred7ZznYe
 hJ7AuaT0Qvv18K6XGoJpdbZg0C3pOyIRhpKAaL4JHcLT4jI884NHv3FoZL.sk4f54RZh4yYnYVRP
 VlY305KnWVFSyOTA5NWxfCzUnW0pBHKP3pUMGMy6Y.IkXxJqHqpXk6TmgHrQtGrKlDkRIqwath1h
 I.bWQuXOeI6kX3Qj4t0DMczGxoUUwn3mWNJ.m9U2M3nw1hZGAqfLI04UWkgMVOfOyotohgXhS35n
 cj1H_o.M9vDGVrmjJ64De2mkWNrBLDSP6BESu9JRIYler9gjdYmyYozy0JUN1JIJpblrTvwC9F0H
 LBgCmZbESz072CWlNlai1OyhJWfBm5f90Z1mGaSnCuI94sBPlMV3FLdhymc2T6Ts9DFNR2BcOzFj
 W.wyFds7eLnWaTqiB116hd6CjGYejbDdh5uRZMQwm8IERPDb3QkO0iBfncCrl5Dj1os_qvW8gdGG
 mr2SvZr9RJW7IkPJPPH9c9fRt91.DZJX6x4XgDoKGkLx61Qu0WXOeIl0ii2z_xg5mSzQ43hACDBW
 Ek0kEKOK2.bIK6vYfARXSgWq7X7Y9QNrRNCROJCsxm.9cqb5ny9yeM7TyRacIARHKfJhfWibCBWW
 rcBp0HaDLJiu6.6v7yOEZyK9hTziRq174eR9NaEbUG4jHCeIKP462npJgtrue9BdpcoKj3klIpJd
 2xADG4R9bu.ZEql5.CHUuaE.nnpzXLptVF5SQ7JLKkq_vQoj7xodcacp4lxaTdmO.8jIRCMoZa_H
 Yq7Xgu7GRXnnihMVBOFK8CRbbhL8syWR.Sdp7Bk4LOB9Yhn_rRmYI0j13DThMtLcf7JZKOpNPhkU
 gETrZecFcwvqeuzV8T0sCtgTOarB3cqLax6CJEIJad4QffRwQXAqGFGuwuqL_vzkJ9tCPAxtpHFK
 _Q1kqBI3Tzfb2wTPIEwz8JS8AfLN1cmrcgNcGVSd0.5Xx9ejQiox8v8h.pvOTsEZD06XZpL4JxvH
 nPNNzSprwxRAl3h9XwyMrn_BRWtlOvmrqeccYIsmFrtigqLZwSNDtGnCb6qTvy0VnAsHf0meF4H7
 UHgdoLqVskZDT7xc2Yu4bO2pj869BrMFE2RvwedB0BoT1WtMfyY8X242msltzUkklAlT_zA6LL2y
 Ks0sZCEw7GVFGnhIe5YSxUogU5pZQTEvPdBVS2TPRPczoVDnm6xovhTmM0nOLX76Tzq8jRFUadUk
 DC09RupPs.Ox2W244ov4SUcaejumLZntayubPIbe6ZMG1YxSX6rGKoSs0U9.HTGq2b9xx27HP2LU
 Vs02mSf42Pn0GQi.AlpWDb2ZcjzSXPVdW2B6YUp8sjsdjDwZzt4vPZyVWfyVpr5d5GNhx8udTRFC
 udfH9hgT2e8nRKFZ9B3qCUvd3.tjr0Mem0ngN8ggyN_1e8a83Wx6cdH4yJSb.Rxk3rZ8gDk20WFB
 90S8tu1.DFCto12b_5bnT2vDDm6mabjEh2YcjBL5egm6mMRhORizXJsgVo.SEj_dgYGr8YxcAYxq
 IsEzVcROrfCdpMU5jDP0EIQMCHfWARVRaaJMwp46wH6gFDpyE4DjPTfudN44jBHLosNzDMbFHcVR
 IBU29Su1xJqvi2QX85Rm_wvRPoVHWoJyre7utkeiD4N1cgEjIXfSD4TltL34scyZcDSK4xerOPdK
 3ZBAB
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ee1fbb01-4f62-4b6b-bacc-2cce61442f64
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Mar 2025 16:35:32 +0000
Received: by hermes--production-gq1-7d5f4447dd-jx67d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 05fa7ba5da5c0e0eaa57f438ffca73d3;
          Wed, 12 Mar 2025 16:35:31 +0000 (UTC)
Message-ID: <b0bb8c6b-0e68-4c71-8476-9f8b0f229dbe@schaufler-ca.com>
Date: Wed, 12 Mar 2025 09:35:30 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] smack: fix two bugs in setting task label
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250306224317.416365-1-andreev@swemel.ru>
 <b3b4585b-c9f3-4c87-9a9b-bc4137ecea47@schaufler-ca.com>
 <593b1df7-062b-4751-a8b8-6e83f7091987@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <593b1df7-062b-4751-a8b8-6e83f7091987@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23435 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/12/2025 2:30 AM, Konstantin Andreev wrote:
> Casey Schaufler, 11/03/2025:
>> On 3/6/2025 2:43 PM, Konstantin Andreev wrote:
>>> These two patches have distinct subjects,
>>> but work on the same object,
>>>    security/smack/smack_lsm.c`do_setattr()
>>> and the second patch partially overwrites first,
>>> so I combine them in a series.
>>>
>>> Konstantin Andreev (2):
>>>    smack: fix bug: unprivileged task can create labels
>>>    smack: fix bug: setting task label silently ignores input garbage
>>
>> There is a problem with this change. Some applications include a
>> trailing '\0' when writing to /proc/self/attr/smack/current, which
>> fails with this change. It may not be "correct", but it is expected.
>
> Understood. Given this, for any "label"
> three input variants should be accepted:
>
>   "label"    (5 bytes)
>   "label\0"  (6 bytes)
>   "label\n"  (6 bytes)
>
> but not
>
>   "label\0\n"

I agree that this should not be accepted.

>   "label\n\0"

It's sloppy, but I can see a someone using strlen() + 1 inappropriately.
This should be accepted.

>   etc...
>
> right?
>
> Thank you for paying attention.

I'm the maintainer, paying attention is why I get the big bucks.
... ok, in truth, I don't get paid anything, but it's the principle.

> -- 
> Konstantin Andreev
>
