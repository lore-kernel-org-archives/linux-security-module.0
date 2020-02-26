Return-Path: <SRS0=xMUB=4O=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5849BC4BA24
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Feb 2020 20:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2055121556
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Feb 2020 20:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Je4LMvYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBZUGr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:06:47 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:39320
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727277AbgBZUGr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Feb 2020 15:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582747606; bh=E4K1LY+1aquESiiHNLDlCUyjtqDEEIWFmSg+AwNzfWI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Je4LMvYQ/iDOTjx28VcRmVizVDlYcDhKuQ4mkY5M3fu1nRbTl3UxpH3e//oi9di5Wtlzvxk9qDW/BUgUl0uCzl4V8asX5CGWF93FCvXpHxj2oAf2Qymd3uWBKz8Ir8fYjn3OOZBZxJXUgs6ekcGOlbF/9j6W4JuueMhsslWZSEWGCMgzmHiAFP7ivigsD+igk1t47/aChPOHRxxjBRxnRan6UBgXN99aANN6qaYOB6ZqTd+AHqG0eYVIdjtXq1ffBsAao4U+c9ifN+Pg6uREdkuHbC8WNave1ofFWSBDRRPHjd3VzWm3g21C7pxYjBoGUlp/J6Ook1zAJ25m2mwKBQ==
X-YMail-OSG: LmK6EVgVM1lhjK5GbC7JAPhlbj2JHX.KKZTH0lS4IGkMQlcaVSnPKGpJlQRy6xP
 b6Yx0RxFvJgyKRyBuMXrbiJQbhWzsniii9076X5czQx68fDkmMVcAxQoxHrazW2gnjmyi5Wnciz7
 mBDiuCgkevRLyOQHRygV80doDslOXXSF7XN5XXM7BnOvDnzTk61S4nsK12C55gxcVanmedDeucIz
 3uWg.XX4lK5b7y3ByDko38muFgxCXv4urY6FCmaJ0Py0e7kt6zuoOZlgE5Jg8BTZaH2SWkpssctL
 DYVsElBXZv2bnqnwMDB2b3tSS_kDmGrq60rnlbABSBAEl2wksEHbuRQdOP9t7eWlwwwicQmWR2L1
 TICX3ZVKvFa3np7DVpNypyk0pqo0VeRZFu0MYGk2Wew_pH76A56qVSVOzqPCXpKaUmUXa81lwys4
 MyQdHtSq_WFMcuDjl_Ss3lLXJ7F83wdzsqfDbCu8Hnqk9fITkWZKpWXXVhGbS4UmkUSzWkv_jnfV
 YteMCIZQw3puwj4eTnf3MYWpUaPSuwdEMpeSwOreB5U9DwoHjsh34kw9SyZdxYV38vRXZ4DTX9tX
 iZluhvfK.uvxxEmXw7aaL3mZebwmi3EzUqUrZiqtzSF4KN3Wrc1c8PmEQN5zormsVdc5BjBIw0lX
 xY6JW0EP9OB4ccHp00NQhsmC748p71sjXQ8vV2xYTgy7UEUZvOslrDlJiy96EHCS8VazWIVhSt.Y
 b2nuKO_.CzdWL5B3OPTDlIDaOMjV5cC1tIU.9gd81FWV8oGvE8bxhdrY_rDjQzcxutxHucf6fCQx
 pv7fWr2MXxECGIygqWDcs277bBnnnJmtVhg7em7V.sPOJu7FRFijkKhP5zhEH7ZAAzy9Fp2C30Ti
 W86MFdt6gILXZBtW9H8MQGpo1xU7hJePJoFx6eMsh9Pg2uepT_f0.uL_00Uk4nlCDQ5Rq3Lp44nR
 JGvV8EATKankDDFHKezJznMgQYlbVQyQpIZuPkYNjRSJ0OPRjg0x7JlVPUHg_LlhxrwJKOegmKs5
 eLprnkoSrb7qCyt5vO2CzGSIUknhjDLSvxxbYg6uMCQJaL75J.xEt5hZ2eCdBx7gOOJOZxIDSWUQ
 8x6bkX6IjIc3REefGMFawj4WmudYLaeIUpo.8BXRKFEeULMBUwovmV7drRLvZnPOgbcfkh0xIFZT
 MEjQ2rTIIpxdHgJ.tBUYlxEricR5OUmWKnqKg9vVjPpRgsEH1VcIozmM5y3Ww_qqh6H15uCqVcCH
 iRcrqubgT0lo1ZSlYmdOGWmeGNwTVEJcIXDOHRj98LNG0f59SYzRWE0RcZq5m3YhSr1ZiG.SOQdl
 Y0qsS0tR6ohahaCsSC1RArdnMaz_J6S16yXi1GZE5D9nWUUPWJ9mtB.ZdMPEMQ7QF56qrMGAGCfu
 mAY8b7lsMVwu1X.wgTYJPIYUud90EVZwt
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Feb 2020 20:06:46 +0000
Received: by smtp412.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6c4cfb89c46ba96d6c56e874a1660e0e;
          Wed, 26 Feb 2020 20:06:40 +0000 (UTC)
Subject: Re: suspicious RCU usage from smack code
To:     John Garry <john.garry@huawei.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <9d97e54f-a7d3-30fa-de4c-ae8d70dee087@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <ad2427b1-b23b-ffab-7752-f4dec5e20824@schaufler-ca.com>
Date:   Wed, 26 Feb 2020 12:06:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9d97e54f-a7d3-30fa-de4c-ae8d70dee087@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15302 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/25/2020 9:59 AM, John Garry wrote:
> Hi guys,
>
> JFYI, When I enable CONFIG_PROVE_RCU=3Dy, I get these:
>
> [=C2=A0=C2=A0=C2=A0 0.369697] WARNING: suspicious RCU usage
> [=C2=A0=C2=A0=C2=A0 0.374179] 5.6.0-rc3-00002-g619882231229-dirty #1753=
 Not tainted
> [=C2=A0=C2=A0=C2=A0 0.380974] -----------------------------
> [=C2=A0=C2=A0=C2=A0 0.385455] security/smack/smack_lsm.c:354 RCU-list t=
raversed in non-reader section!!
> [=C2=A0=C2=A0=C2=A0 0.394183]
> [=C2=A0=C2=A0=C2=A0 0.394183] other info that might help us debug this:=

> [=C2=A0=C2=A0=C2=A0 0.394183]
> [=C2=A0=C2=A0=C2=A0 0.403107]
> [=C2=A0=C2=A0=C2=A0 0.403107] rcu_scheduler_active =3D 1, debug_locks =3D=
 1
> [=C2=A0=C2=A0=C2=A0 0.410389] no locks held by kthreadd/2.
> [=C2=A0=C2=A0=C2=A0 0.414770]
> [=C2=A0=C2=A0=C2=A0 0.414770] stack backtrace:
> [=C2=A0=C2=A0=C2=A0 0.419636] CPU: 0 PID: 2 Comm: kthreadd Not tainted =
5.6.0-rc3-00002-g619882231229-dirty #1753
> [=C2=A0=C2=A0=C2=A0 0.429204] Call trace:
> [=C2=A0=C2=A0=C2=A0 0.431924]=C2=A0 dump_backtrace+0x0/0x298
> [=C2=A0=C2=A0=C2=A0 0.435990]=C2=A0 show_stack+0x14/0x20
> [=C2=A0=C2=A0=C2=A0 0.439674]=C2=A0 dump_stack+0x118/0x190
> [=C2=A0=C2=A0=C2=A0 0.443548]=C2=A0 lockdep_rcu_suspicious+0xe0/0x120
> [=C2=A0=C2=A0=C2=A0 0.448487]=C2=A0 smack_cred_prepare+0x2f8/0x310
> [=C2=A0=C2=A0=C2=A0 0.453134]=C2=A0 security_prepare_creds+0x64/0xe0
> [=C2=A0=C2=A0=C2=A0 0.457979]=C2=A0 prepare_creds+0x25c/0x368
> [=C2=A0=C2=A0=C2=A0 0.462141]=C2=A0 copy_creds+0x40/0x620
> [=C2=A0=C2=A0=C2=A0 0.465918]=C2=A0 copy_process+0x62c/0x25e0
> [=C2=A0=C2=A0=C2=A0 0.470084]=C2=A0 _do_fork+0xc0/0x998
> [=C2=A0=C2=A0=C2=A0 0.473667]=C2=A0 kernel_thread+0xa0/0xc8
> [=C2=A0=C2=A0=C2=A0 0.477640]=C2=A0 kthreadd+0x2b0/0x408
> [=C2=A0=C2=A0=C2=A0 0.481325]=C2=A0 ret_from_fork+0x10/0x18
>
> [=C2=A0=C2=A0 18.804382] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [=C2=A0=C2=A0 18.808872] WARNING: suspicious RCU usage
> [=C2=A0=C2=A0 18.813348] 5.6.0-rc3-00002-g619882231229-dirty #1753 Not =
tainted
> [=C2=A0=C2=A0 18.820145] -----------------------------
> [=C2=A0=C2=A0 18.824621] security/smack/smack_access.c:87 RCU-list trav=
ersed in non-reader section!!
> [=C2=A0=C2=A0 18.833544]
> [=C2=A0=C2=A0 18.833544] other info that might help us debug this:
> [=C2=A0=C2=A0 18.833544]
> [=C2=A0=C2=A0 18.842465]
> [=C2=A0=C2=A0 18.842465] rcu_scheduler_active =3D 1, debug_locks =3D 1
> [=C2=A0=C2=A0 18.849741] no locks held by kdevtmpfs/781.
> [=C2=A0=C2=A0 18.854410]
> [=C2=A0=C2=A0 18.854410] stack backtrace:
> [=C2=A0=C2=A0 18.859277] CPU: 1 PID: 781 Comm: kdevtmpfs Not tainted 5.=
6.0-rc3-00002-g619882231229-dirty #1753
> [=C2=A0=C2=A0 18.869138] Call trace:
> [=C2=A0=C2=A0 18.871860]=C2=A0 dump_backtrace+0x0/0x298
> [=C2=A0=C2=A0 18.875929]=C2=A0 show_stack+0x14/0x20
> [=C2=A0=C2=A0 18.879612]=C2=A0 dump_stack+0x118/0x190
> [=C2=A0=C2=A0 18.883489]=C2=A0 lockdep_rcu_suspicious+0xe0/0x120
> [=C2=A0=C2=A0 18.888428]=C2=A0 smk_access_entry+0x110/0x128
> [=C2=A0=C2=A0 18.892885]=C2=A0 smk_tskacc+0x70/0xe8
> [=C2=A0=C2=A0 18.896568]=C2=A0 smk_curacc+0x64/0x78
> [=C2=A0=C2=A0 18.900249]=C2=A0 smack_inode_permission+0x110/0x1c8
> [=C2=A0=C2=A0 18.905284]=C2=A0 security_inode_permission+0x50/0x98
> [=C2=A0=C2=A0 18.910412]=C2=A0 inode_permission+0x70/0x1d0
> [=C2=A0=C2=A0 18.914768]=C2=A0 link_path_walk.part.38+0x4a8/0x778
> [=C2=A0=C2=A0 18.919802]=C2=A0 path_lookupat+0xd0/0x1a8
> [=C2=A0=C2=A0 18.923871]=C2=A0 filename_lookup+0xf0/0x1f8
> [=C2=A0=C2=A0 18.928136]=C2=A0 user_path_at_empty+0x48/0x58
> [=C2=A0=C2=A0 18.932590]=C2=A0 ksys_chdir+0x8c/0x138
> [=C2=A0=C2=A0 18.936366]=C2=A0 devtmpfsd+0x148/0x448
> [=C2=A0=C2=A0 18.940146]=C2=A0 kthread+0x1c8/0x1d0
> [=C2=A0=C2=A0 18.943732]=C2=A0 ret_from_fork+0x10/0x18
>
> I haven't had a chance to check whether they are bogus or not.

This is the case where a process with local rules is forked,
requiring that a copy of its rules be made for the child. The
local rules are not used in any production environment that I
know of. It was done for MeeGo. The local rule list really ought
to get moved from the cred to the task blob, now that we have one.

If this turns out to be real it's unlikely to cause any harm as
no one is using local rules. The real fix would take take it out
of the cred blob, and that's a significant change. The RCU details
should be reviewed at that time.

Unless this is worse than it looks.

>
> Thanks,
> John

