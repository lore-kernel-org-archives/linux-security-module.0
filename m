Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA7211C
	for <linux-security-module@vger.kernel.org>; Mon, 28 Apr 2025 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745882210; cv=none; b=mvcRLmL90aVPfkr7B/+8JZdHO+mMMtjEwEf2SRLU1AkXOZ7EiTb2U3f91Y9uUsOugWCiLgA3FkGRx7rriHpIdxbZ9r4Qu2B3HRsCdnECBmiLZ1nbWMynAIIkwSML6EaxY7/yvFNB3WbvVH29g4JmLbv5xNLiBE1uL6B05wTUXDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745882210; c=relaxed/simple;
	bh=t2lMuaq8tyJcgZC4+A3qtDeKact8gfQ5Qt+l0FY17vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoyJirrPlFG1FVQmP2lvREAxFmA+1roYHtfTlRndiZ4ZJt9rgVXUhYofMUAXa1jxBfdXGkQwjikD5nJOktezTKo7YIQy8pa7ISAlmddlvTLhAUaj1MVl7zR5GAibuowZnjJ99hAiQ5vur17499Eceg9XZuWTcXOhp2B2CFxt3xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=UQnlz6xa; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UQnlz6xa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745882200; bh=DKyYrtYB4Nzl6DBoUSN9LL+U+qb1NIVc4tWOH/5eAXk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=UQnlz6xalfPzrKqndld8c8RB1g8IbkLjA2H8IXpr3ZadWQ2lsqxePUEopJcZRkmiUjEgeBqG8T4CM/5mpGbVFlfLfAUobieFT1sJLoI2Pu1zMAfvPxf8y3Vvdc3KicH9u2BcuqAY85nM4b3Hy0Uh7PT0HbYDdYgu2BCXyGryEUpukrd4I75zcA0g+XNVzrwDKOZJEMY57b23Mf7j4sRy6AfLRlSwrqbftKtmzDiMoYWhd6LB77nz2BC2sG7cUKB+c85UTXQvM53EfmcmLVjtmCL9M62bXFFo/9zeFFmkw8KD+ml3tHzLJEyhwhvp4aMDCRNfH+dBkcCvf0EtA5zrkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745882200; bh=SDnFnK+P5WIDUdNXbApAvgkJx230aYY6QDevQr+ARAw=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Kj/KAYMzK1GKwfyTnFrE1qhDOsmNGhbJKPA2j3vM/KDIU/Z8P3AxYWlJK/ojHTVr4ztTeuCxGHK4PcJA8lyFT11kZBNz0eGAdUa33gXO3Ksnq0kah5qp7TBtQth+Tl+98hZZhZXIGhVTOTtPAFC+svJKQgxtgFDatE6PqSgTrjWsEb1HpBfWwT3L64zat+fBxEHaCnG8AStgYc55CnJ4/NGF6vh/2OgT6W9N1+VhIAlyT2c5YzUjx4L9jc48pzyCSLlMmIoWBr6soIf35UE+ObcAWqqOxzGOLS6k61nmesgDFukwY8CwIlrPoRXSSmE3n89ADd7wlg2BCWBhJRzQpw==
X-YMail-OSG: .SCzkoUVM1lc7a6C_tOsPiChbOo_KLkoVm13CMd2jTDlsYbE1mDL_3.LJXjE3q7
 HomZ.Do1oORPO..CJdljTGAANkcAqoJPnxanrhtADnzK8OW.UEf_6.nrgTyskx1aPGnT0zNFnSQR
 NYcqMmgZblBAePQDhqTmQ7kEGiwCZkjrDI_y3U8AVYH3UyVX4bLB5qVFQoYx3jXHR7tBlv43lBDA
 O4sgTaPUdAlgKly7658av9j2dei2msAfWzevnK9HJvBYGQQVAgXZu4O8NOwvHEpQKvqhJPNMqV47
 8TfxRWkJzR6yfMtq.sM9Ul1jJ7sGtSi5xViXriosn3oxdO0lqyZX4wTUehmYHpc85K9Noz1r7FD1
 oKMLVlSCcnuDi13YY6QjdQB2j1Oe7NlsY6txR85bDFBMEa1XCZby1STC24IYk_wE4D2031UEt2CF
 G7SrlyAgx6l9OTZKMnsqi0myf47Hp84hUq_IeWugb6TRGGOETEQtNfvHf4aZtp0kym5w9qMrrhxX
 PT_6qiH.6F24EDbnTXi0i35q.Krg2ZzYvoS.84B80kHZnkOx.fpInbdaCrkt4v1aJDrSNwCdmD0V
 bDbCkU1GcD6nBV.WBmOdd0M4Gx_lbUfRgbJZ6XcqZV3CwOAGca0_UcYW2jzqo2FArsCbfKq32b0J
 WUN2oKxrgx3jeXA4rVtT5Uo5gVZoNawzImOeDaQnYj59XJmRnmhvysPz.Uk4wgx1I1r1ihmf9uGs
 2WiPXxUyBBvIr6yrT4QPE_ATibk3eKKkqRrNker9bRbnQRJcuy6ZmtH9eDr398AixwsyzSrxR.Nf
 O5Fw2NziM1vb.SKNYyf2eHygyY2v47.FddW5S8kVWQg4zMgwtem0Z8r09walunGCES6.XqOB6WjG
 j4mLfr.y9k8Km8K0YM0GNGW_vkJNWJKz46oLOsc7jwaPeZV6C17VOV1_ZUsqMcB8MkxnhbnwKuwp
 tL5REU_47JGOanZV0jFm5XSMXpGd4kpNI1EQc4J_5Ad7ZUWYLcVr3KmbDb9pay1BUUOJxOax_KU6
 f8JZhEr.1Xte09IV4C1YdYaXq51SNLhnHGjFNGya.veXt7AzpifGgSG6UJx6ztpROjNX9raFfeMj
 Wi.GSjN0BpX7tfSCvz3exx.U.V3UzUyTi.3ZTe09tTu5c8AoIca9i4GGxHE40iRE6zWfX_P9YDRn
 suuvL6vrxZS5ckylhLMyZrYOzydPFcxoARL5t5Q1r6bRMr4bIkBiSDFbW9fGhGhsSkuTQYEHwMwl
 23Hqsx4jB9yT3A_FSxIc7Q1R8f_fyd5IZG_YXKzSVT6cY1DWQasJRzebIV7QGv12ii.pbCw0OPCF
 Yuw4D7dLdReZwJYICdkRmt73GUKu4Cauwu7qFthVx1JwQWPk9mSYgxGnm7Uykbm5DQJGXdCofxUa
 .ANwzBoVCCMP1t44O.TQNEYWsc2g1joqO.x5P4MhnWN_K1ahNXXv.Fo2jUXnEvNFP2gNp_gA9YLT
 duAVSVrrw7ocTmJgz0qVq.SLGvmnXddVU66I28DxnSrpH6qy.wTaXLjRQXGCJZJg.HtQGP0.F_AT
 PUk4Rak1kI5qsWBSpxG3.IhR0z1l5fQfNSM95_KXg6C4kappJTAnSwsSi2kU.7N35hA60i1hG3S6
 h1oyCcuJ7m9xP4E0W2PIf2dRz8TmYZrnzHtPb7zJSL.OAxghsuEP35vJVoQtEDRF7A7VPb74.T.Z
 UZhmvOwCXSgjlfvIW727ZJINkTQpI_9c5Qx32ubibkZCxGePVsqO.l8GbRTFtUWQHWCIPU87NFji
 7Wyj_ljryZplvB53Pc0CvdMcJv3NxrJpxsvYf6smvNI_pOjcbhtxf.7F1sN7MH79R4KLq_s8gUeY
 RkQ8x.KTXyI.vgd.BnLalzLnPowEUs8Nu4OkRnHinGPjCUHQamTyFG3CB1Es47fan_zcZzKFv59c
 ympp_Ex_EPbkZk21lUQrt7UBHtcDkVz9IOgX1fBcYsgWobKIkWnkyfhgaGZ6g.xVihL.VXRyuq7B
 OJ6fv1rNEzjkIxnDIOsuYkrMRsINReHIbBVUGQc7p6wehYOh6VR1_B6SbvBKMRaLSn5.zGSTlWWk
 yUjaxtRX6Y_S_beGZUz11Ab7SBDeX29jCYA4vnInZ5Fr7PUFtgpTB28wiYDDz.1yN_vNiqkp2CQ8
 wX2Hc7DaKOvI8UtTXTvNEq6_nWVI1MG0q.g445.XWWiT06mO4OFR1BILx7Xxt1yOs2xAvaqF_JYi
 uSU5Omi_sgUuYpnGwB.QFEXYjTkIiKveAPns7k8e1CrCUy25s.TuuohFL5WDMapcNnNbzzr2TvQR
 SRyyqDk6opNN0xdlgnaISqjmx2dAZ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2dfab017-9c49-4b76-8b32-275261365086
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Apr 2025 23:16:40 +0000
Received: by hermes--production-gq1-74d64bb7d7-tqd77 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d1e6733e20146bd3977696307126088d;
          Mon, 28 Apr 2025 23:16:35 +0000 (UTC)
Message-ID: <4689f3d0-5c5a-4736-9e09-e40712a53e08@schaufler-ca.com>
Date: Mon, 28 Apr 2025 16:16:35 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: how are new CAP_* added? CAP_{DISPLAY,DRM,GPU}?
To: Luigi Semenzato <semenzato@google.com>,
 linux-security-module@vger.kernel.org, serge@hallin.com
Cc: Jann Horn <jannh@google.com>, Daniel Erickson <danerickson@google.com>,
 Dave Hill <davehill@google.com>, Alex Glaznev <glaznev@google.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAA25o9THx_+SzE_+DMjCeSRE28s3kxZ0OkXgSib3tU3svdQPzA@mail.gmail.com>
 <CAA25o9Q24atyK5M6BQaVx5sVq_ZouwRdhXEo3UPa5pE4XVqxQw@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAA25o9Q24atyK5M6BQaVx5sVq_ZouwRdhXEo3UPa5pE4XVqxQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23737 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/28/2025 3:19 PM, Luigi Semenzato wrote:
> I have a use case for adding a CAP_DRM, or similar, to replace the
> CAP_SYS_ADMIN in drivers/gpu/drm/drm_auth.c for the purpose of
> becoming the DRM master.
>
> I am not an expert on either DRM or capabilities, and I am wondering
> how one can decide the appropriate level of granularity for a new
> capability.  Is CAP_DRM general enough (but not too much), or should
> it be CAP_GPU, or CAP_DISPLAY?  Or perhaps capabilities should be
> discouraged for this case?

There are a limited number (64) of capabilities available, so we're
being careful about handing them out. My first question is one of generality.
If there is only one case where the capability is useful, there's really no
way to justify it. If a process would need another capability (typically
CAP_SYS_ADMIN) in all cases, there's no point in a separate one. If the
use case isn't going to be around more or less permanently, or it is unique
to a hardware platform, we won't approve it. Without knowing what a "DRM master"
is, it's difficult to say for sure, but I'm guessing you are going to be up
against all these criteria.

>
> Thanks!
>
>
> On Mon, Apr 28, 2025 at 3:16 PM Luigi Semenzato <semenzato@google.com> wrote:
>> I have a use case for adding a CAP_DRM, or similar, to replace the CAP_SYS_ADMIN in drivers/gpu/drm/drm_auth.c for the purpose of becoming the DRM master.
>>
>> I am not an expert on either DRM or capabilities, and I am wondering how one can decide the appropriate level of granularity for a new capability.  Is CAP_DRM general enough (but not too much), or should it be CAP_GPU, or CAP_DISPLAY?  Or perhaps capabilities should be discouraged for this case?
>>
>> Thanks!
>>
