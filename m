Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD28C05027
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 17:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBQRWe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Feb 2023 12:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQRWd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Feb 2023 12:22:33 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0CF6EF04
        for <linux-security-module@vger.kernel.org>; Fri, 17 Feb 2023 09:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676654551; bh=7CkunMLBDG10PW5izJcMfFuP9pqfoEnyzo140aX5ZNU=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=C408/hvA7CCdes2VtMFUwGk+HdySWtrs0Ij4SH43DgbuZMDh3JTuY4OZllKgaM2XUM+LM/c8ekUoFVUNNbJBW+FJGYBzswQY5XWhzkB+0KJGavgdM0HlZeFdQRI8wRtuzBCJ2UPIaEspkcoyEDErQ9atDboiQ75P36lmqScnR07CQelBc69iftch6YgfB6WxUi9vxarQ0kZxszqqSKctp4+SzFp219R0jtaOTfI7j8mqBoW370y0ae/yKCqtEC3tTsK6RWRHsvLL+Le7PjZVvKGmk5z3GBfwGsQ1AdGvRJhF+2E/hYdLjcQAT9+qgjYqgDkA3BMn1wLelt9I9I5FIA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676654551; bh=Z1UiKOViRVVA1pjalth19ZdSS5AjPFb5R9lUJJczw8s=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uDcbZ5OiTIgA16SK1SCxUz5wG2J6lr2wWl+jI8Alu4eFCgIt6MnVszUf4QoArWlT3Yj1TGbxt0mReWrxEHomZRDkKItTCHiViTy938tFrsCQDtnsY2/AJN5KaLmSuQ0KRLAmqPKBFWaPMywOlexYSIKgfTdfVmfBO1R0i/6kmAyEP2FUh8jqZ4DMRUWeTq3A7/eb7ZzGSbUE/Es83d2/rV7Wjonwwog3fsWyW3ttuSlIlT2qafBgeIcc+gjEDOPdkIMjLbjD8zVm35O4dzE+bp6IZ4sAUzX1EIah5YVD3+//zmhxTBu5ZSvt4/Rd94QHW33GKkWVr+jXPlvt8mALbw==
X-YMail-OSG: HGo4xOAVM1k.AbiYlVcEmq9ERD0TAVq0nhrwnefcFowOWz4gOpDLVaHM1BqOobR
 QqJMAd9tBF4tJFGfcnwsqH1PiK5n8s16M1c4r5FteImqONwVr0GTq0xGjDg6lEH7SQClmP6ufUIU
 IHOUrVCSPbybK3Tbrl_PEcsa2fSBhZbYRvsdjEV.wUPhgJjSCMHJCsVAMJYLgoUQ7hAhrXBP9Cuf
 dcdQ_nCIFjJx1SWqcQCIPeuoejZ6cP0KhfdPaxC1gdhuuYqIcNueQHu8Zx7GnCriCchtqTVN9gf8
 xGqYzz_4HU0gY1be8lbbdMD512Hrm_c8eeeC6RHieRgDgd12_wbobc3p91tTW0VW4gYAAuj8mgE7
 3KHwgrXfPS71hb9ltaFkduUKecuZnAD0Ah3twKDpP4gvqSwXmxmtu4It.iCu1k5c_snKgLq5cdbG
 ahrChFT9YiSTE1bjxKtJ_xuVhSaN_us2AcPvNkwsrTB.yZ_mxwDojDT8o5fEvuunuQmvYfpGN5Ry
 E7ehrvXDNKqb8vKHT_k1MPaiEZL3RORXVYFWDABYPTlNCrStA7eGtdjCPAMwVGEBOtXzxEpWN99E
 IjkARGBumfnmyqMfpkDTl7C0b_Sbn5ZcUlhWL7ofQSYEFhlxrxliUl41fPhT1pirUQz13RE8Vjq.
 yBzEZjDTcfxeXQYPiZ0lbQCg0gTlQrxskjGJe8P8gswfLTDzYAhkAF0wx2kZ4uzAZeEyc8NjeBKH
 ogeVPrTVu2nWpSF8PTvrR2_a2_D2fxHs46.zWpD5P7_bo2_mGW00dKBebmoMVUjFD9M_5xQdPrKX
 cTuwn8XYcrUojIOHjsVD9Tjwyah9xkSZ_Yz7D36n7lyjfsY6atTfPr4XA9Js.hGSVjiWu8kvyZ8d
 4CqJxcjtO2kljTRJb8hIR48tFm_KcXRAIrAJOOIplEKLLzvyftl05QO39SNlTc5EHt2QfXeTAP1L
 nizirrrLF.ozs4RP.vYbU.YUQZngBcbgioARfbrpFmyDKYSBKwyQq3Nyr_Hkg08JwPTNfhgoA88T
 ZZg11qmZte1gDL6Y5SmdVaH0o1D17vNY9q0KT0PamPiDE73P0rezFFWs3DgszWI1Od17P._LRIhY
 Z4oSsMaZzonPFBetaCLBen.cw_MCMx.BGUKp6InmUs_FL1S9s4_joHs3bsXLAGw8sYA1_dNR2a8P
 swKCJTihZJreODIm5SP.RLENu9QZHol13yGxg5YODYzUN4XiqoudUEsPV4ewyQiyEFCidzohrXET
 .IwEE3l9VBiYAHPbQqcErRJOpDueJEh5j9lnm1sD2v8dgnNUv.cCViBVn7M49QWFKqPDNynqlL_W
 cx4dWx3xJf6tU10BHaQvh0MsUxI1k4Iyyzwz41EgkXQYCAOJkLJM4bcfS__QmNC2M9vDD7YWP2al
 wGLHViQq8VLpURnNsDRclUK5.Ee2tObZDooJRlenUTm32xikNf219bve6mQQaZZ5nx8JtLCUx0Ey
 oQ6uRRh0ii4WEvmE9ifsQUscdQFs974SMyafTZRXZ.SFCgnVJoHvnaqhBn940ViyTtsH4k1TCewk
 Vu5cvMnU1stW8pHFGeTxhvEXvsQ0X6Lgcv2NZ8dJXloR09fUWekM98l4T9SfMxSuP3rMjcAvhz6t
 SoQYKXOp40LcTdTemBowSVe0qWNX50reTcMobD4E98YG0WYX59Zb5bnmCeIs0auMzAgCzvxbPuXY
 u7rSbhyv3OSKzVv80wUOPw9pOOnoTiftGIV64D4ciXwosR2rriEPkyK1fBJ7xNtw_0eiDi00DEsn
 TCV1hR4uH20ASe7MIJvabHMM8PtLOJ3MPGrJaiEHomcXz9YrmkBOsroDvMwZNogFJZ9dyTdqHuYm
 p7hhAOa45v.RfMojDwXdzG3CWo9QpROgONFTMyUYRajREcwho7oCoKf78V6ws_kf2q23mMgJ.WQi
 DP0lIwqz8vtXMk1Y3Kl6AaLO8IInYV1cThQbl9xNcK28DpmK5Yqj35U8hdpcyLwILcXy.XjQnEMt
 abQqQI6qM7oCzvZkGT1tgXeOs5bqE4vOrziLkX024Yn5.vuHOHlTihbQdtnQZmLrokaeMxEMG9go
 PPGzeOi2XHAiNMF96isDe77XTgFhOOaSbjmIb6n4RYokB2790fGJiysGjbHaYbyiNsC1A1jxCGES
 OyBC0pq7zOBWg6gIXiRBV0JxuvDlt.PQFwgr9FhZ1HI7w_MAQwrOIYa2qKjs6iXKj9tXIHpsRBmb
 T8yTUP3EHbZdkPcvHL3uCxWF72Llwh0WOrRO.RHAZH5Xn9yYcORhMP1jO_jRuykqpLmmnvJNzSus
 tLLjL2g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 17 Feb 2023 17:22:31 +0000
Received: by hermes--production-ne1-746bc6c6c4-b6fc9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 18ff0c78b8494a6812549084135ca37b;
          Fri, 17 Feb 2023 17:22:29 +0000 (UTC)
Message-ID: <2ae3ccd7-c3fc-7b6d-d5bf-d427f1baef3f@schaufler-ca.com>
Date:   Fri, 17 Feb 2023 09:22:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 00/22] Move LSM hook comments into security/security.c
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
References: <20230217032625.678457-1-paul@paul-moore.com>
Cc:     casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230217032625.678457-1-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/16/2023 7:26 PM, Paul Moore wrote:
> Hello all,
>
> The LSM hook comment blocks are a in a rather sad state; separated from
> the hook definitions they are often out of mind, and as a result
> most of them are in varying levels of bit-rot, some severely.  This
> patchset moves all of the comment blocks out of lsm_hooks.c and onto
> the top of the function definitions as one would normally expect.
> In the process of moving the comment blocks, they have been massaged
> into the standard kernel-doc format for the sake of consistency and
> easier reading.  Unfortunately, correcting all of the errors in the
> comments would have made an extremely long and painful task even worse,
> so a number of errors remain, but the worst offenders were corrected in
> the move.  Now that the comments are in the proper location, and in the
> proper format, my hope is that future patch submissions correcting the
> actual comment contents will be much easier and the comments as a whole
> will be easier to maintain.
>
> There are no code changes in this patchset, although since I was
> already adding a lot of churn to security.c, the last patch in this
> patchset (22/22) does take the liberty of fixing some rather ugly
> style problems.
>
>  include/linux/lsm_hooks.h | 1624 +++++++++++++++++++++
>  security/security.c       | 2702 +---------------------------------------
>  2 files changed, 1710 insertions(+), 2616 deletions(-)

Except for the reversed diffstat (which you point out elsewhere)
this looks fine. There's a lot of work to be done to make the comment
content up to snuff, but that's another barrel of kittens. For the
set:

Acked-by: Casey Schaufler <casey@schaufler-ca.com>


