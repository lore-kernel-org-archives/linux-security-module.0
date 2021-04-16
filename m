Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48E1C433B4
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 16:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91933610EA
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 16:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbhDPQnm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 16 Apr 2021 12:43:42 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:33008
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236007AbhDPQnl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Apr 2021 12:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1618591396; bh=B0q9JgvPtmiN6vUidDkVWN4ZLV1v5kkQSvT2i5vyiuI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=fsmGVuRrpKDSwgYDtLcLrdjfCmXpCEXoVfNh4ub6H0UW6nlbuik/srT8+OcfG5h5hbK5DQmuUf2UeQr11z+PyLoHHkaHXAefuw8AloJInMrn/Ly43o9qgqwBa9lZUNaKKb2p0fulJ4hz//vwlak1BjLm+gOetSiUOIn5m7e5lR86RVM8eNwvFOoagVX95WnK2OCeWkl+KFYTX+qpgitwl+pdv2BFnX/BGvkDkB/MM/fAXHkm5TBLUL0ZpNjpIy/BUXZ2C4nItvEunaEDEaMaxUFKNMbM0VTEn/b4TBIa2D4n0EycQ522IQ50jbiEF4Lv42cn6tKr4+PMPX/hVAdqKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1618591396; bh=dSbap6MYsStlSoC8glGZc6xV4jjfGIPBgFm6Wn6tOE9=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=iYmWKbt2erZYvLG39iVgjevlZ4KzRgfDimRkGn50NMbIB6S4zkkrRev7V38MBUPS8AYwRcgBbqurP40ZssM2tqz49H6/u6BrMqoCK4KAnDHUS6wJa9L1YGepw9yaca+7IVQYmz825mU4jXPJU2ugMwkHJQaQKbMB5JXyZK7tGyNt4hOxwUtJ3vEDSxHUeI6msoB4//S0TdB6L6DIP0GUz3G+F5GeRAp5Fm4STgJ5rdkIwRj3QM84tdon1580CrPXfMDFzl/xCZ1QhaKXzODpX8rG2bVwYcVcEX+dE6PF4HsJDMMKeFZllyCBQllfAiLPKiUczDJZFuyL05zcXLUz2g==
X-YMail-OSG: f68rC.8VM1npis8oxRFTs7ITZDNKkqa5V7NKPKFmuDCMtVmPyfUbqPhxTZLxNWz
 u4t5_EilvfMnFC362xY2cH4ebIxdGpEyb7Dyn33nJ.yo36tP0aMVTg_KmSTbdhV_iv21FIMF67rH
 .E_6pCX7jJQBDrzpyVrz2BctYtNJj3HnhVd4.Z_qAGpyea.S5FD_Bor03svrkM3lHFOBPkS9n2ds
 vrEgoT_Y.Ay5zf2upi85gFphVwUD5zK3o4jQgrC5za9ZoF3tMkbKe0yteu7tGC9PEUt2Vua0sXa2
 3mkFAN2587lkWhdtVx_jV1D.k7jyFAap9k.B4NQaIWsFlK4TnR_3Say2NUNCoprT55UcnhXKy_tB
 AcBDfRndI1xsTYoM9KtL2MsCXUzQhtt_vXp2dI3TXvby7BEPz8KjnO_NQpzJPI.Btmtp7Kr.Myms
 T_PwDlDaBYPyDdAYhgB9F1jCBern72Hm_Paqx8czQkfPiGXCTV.ZoXQ0cXOB_VmnwU6wp_Vzo5k8
 PY3xMsrCMsjcj3tSQ4NHiIvB.1Hwd2R9XK1prYm47VYP8wucCek_FMnlxQJ0L3AGmlq_VNGZu2w5
 8ngnRQlY_A.bZ6qRmeVjrJ9HszhPg7p6pKFP.kDS8Kea6mGfoRkoBWxkTNCA7e_52ROStGhVXgNP
 lIn_YD0firS3zXvBYsRFT5U48D2kFfDFzzYHW.mBPq_LQmUPfF_OUXZxpgFpV9A820Xp2AjSm580
 k9TiS0qKQ3pJCIyzKSNp_i1pj3lY.LPzpFFfXW5fl48fIf7vnpUT.48fzh2xji690BIo2D3Kllgy
 FCn1waViDCc_uyIIsxQWFnl0_.bW5Y9ft94Yl_9B86n42AbSqdP9XJrU2xi97LokMQmw8DH2j4B7
 acSOBeOchcssi4yZj6qMtCdQl1kGKWZ9oFaE_U09QZexHzhiREi.JV0Gib68swNv.I9VFdNJXuLN
 VR_9Inwu.XFpUc4aTsrQg9AwEXOowtKRdUd4OKd8eDmodAQtBRUwmfdQlvabXzAOay760G7SXZPV
 V27cNDMlDvE5m1LLivecZKvSHvgdrd3uDlCSmfM8ags8J0QhxKbPHa20LEu3sRHX8BZe31lJ7glm
 QkP1os853dk6CpN4DyIcQjskwRos0EGjKnZalMrHPA0ce6tlrKfbyxwtoU13t2QBR1MKgcnKX0Cs
 DuvPjHCjbzeIWdbnkZgrZvvPr6dZybOOzwSzTI.XqWkqMlXaqz_HrRAU3iJj2HYQygK6WWBOYe.O
 cYt0yYLlDzPXins8r32JCUhC8rdKBwv6ekqAQ95erg8Y_OhrovijvGr6QyDF3e4dgLimAAxUhynb
 L35TzgAZe3iyxopeOnjv0cEXy1GCNTyzAHbvsYvB5n6LF4DN0Izz9ytueF0T4eduqaxcx1a2CazW
 S_J2TsuvFX9DQQGCxeC04aUCZCDga8eGjJbXJv1iL0lVr6U3l.7ANxUZZdDqsC7hgyLUchrlZ6NU
 XyXSPNnaw6dt5zQPrcDnUqCSgYedV_NH1ptLu7Shu9BZqNOJquqJBOdr.zaC9FLhwrQwN6qB5L2C
 dGCtd.p8PsgM6aantmum7gwLkN3OWO.WKCwzu5tvvYBdYlXdZdiuyuvjVQkp7t9z7jy5ckk6RBM0
 1rL_Q3ZMs562hTrVKQM0T46avYe3XVG8W.WrhriVRcdW3_zljFmu3KYyq5GMbKMo17UMILD9EVAZ
 qkWQpneugBYH2jtn.qpBmbZ9yZX6VAXXE3Ujmj5DjdsXRqbLy9X.fHaeHXz1EPXRgEMBHRz8TvSW
 XdJIFkJNuMy.ApDIH3nfg5JHgaZYBIsRAUPts1S5BGrSdEl_r8WakuYciWpZaOYkDxi0ZxWjrf8E
 asu7CN4Y8eEm3tr2YA2DDoZIexLphqEyajaOo7G9sy6wM.X.69CftfssoI00HVolX.Dt_xIt9Rkh
 fW2SebMFqpbGjP8PROmg9ijpiuYWOaKmFeeTIYWACuqsthHiWS3med3Ep3Rnl4F7kGH.h5524dS_
 4vDOKOB7H7aCwvECtPGrY3dS9l6n2AiBPhe2q_wMJdCZR4iHhktUclJUEfMNgTPDDDUr54nneODi
 3OmyQwwxp9iLqiLa5Qjy..YkgP9MsD9kGV0hY2RtXXoInpjgIT0rLdygN3Cd7IFgXKyCfTrMMiqu
 QaLXGGm0eGjGYWWiiR5oLENPEU52YeqCsq5V40OywcVSdU6fywqxRW6buyrIzXFShQIkdQ4fehAW
 1OWVT3nwwRoOmw.RZJ7xzjwTZ_.RXNEldXiRv2QmYRi1i6kI5euZr5ia9y0NZBHmrWoCugGGzNqU
 ZskeLDxolSqxVdoNXHtyC2nPp_A3NSCJjGeonXB.WVaM_BHnLlnymnm6cmcEh6F1k4DK11cnh6Cy
 NmpKziKSxP8jCvMkOzA0Z.nDjev6QvKYvSfImb9wlJQEAXY3AEWbI.V9WD.sbb9NP0_KfKIxN6bF
 6uxuoN_sks1E7qfu.IzWNkpN6tB5RPfWFDAYemEMamNWkJHGvYko_ilTOi9DdpS3BTRTzx_3R1Hk
 CsXhexyfO5FXCFm_NS3g70if18bEY8Z1tzqpierYPsiwctd3bjtrpuRNK2y1R3zD4lfRxbLNsbYJ
 Pp.Xs2uZ.Fdt0osLWI7.diAAAL3MaV.jkWivlqx0M93_0wipRJdjsFcb1vX6Qw.qP.jVCbKDetgA
 J0IF.071psdBTgFuIuQKZ2Vle2__rYc9x9yOA5JRBJCPRY3lGmLZ8CX_CwEiL08HK2pnQ0Gs8C9c
 uYyVhQk9JuFUgatBJ7ux11f6RAwMIMQ0AZ.e_lwqtasQf.j1XsyxPmCtXH9PYTctrxKrsRCgnHUf
 OeX.Lh7c7NVD7ipiRMDzkoW8gG9ZhQsUhWuHQ
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Apr 2021 16:43:16 +0000
Received: by kubenode502.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c1e505223bfc2d0aaa5123149f93e495;
          Fri, 16 Apr 2021 16:43:14 +0000 (UTC)
Subject: Re: [PATCH 0/3] LSM Documentation - Render lsm_hooks.h for
 kernel_docs
To:     Richard Haines <richard_c_haines@btinternet.com>,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20210416122843.4752-1-richard_c_haines@btinternet.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <7e0691d5-02bf-9d07-6331-c7402c6c652e@schaufler-ca.com>
Date:   Fri, 16 Apr 2021 09:43:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210416122843.4752-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18121 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/16/2021 5:28 AM, Richard Haines wrote:
> This patch series updates the LSM hook text defined in the comments
> section of inlcude/linux/lsm_hooks.h. This enables the hook functions to
> be rendered in kernel_docs html or pdf format.
>
> Note that no text has been changed in lsm_hooks.h, only formatting
> to render the text.
>
> For reference two hooks have been marked as deprecated: sb_copy_data() and
> sb_parse_opts_str()
>
> Tested using 'make pdfdocs' and 'make htmldocs'
>
> Change from RFC patch: Rebased on 5.12-rc7

For the series:
Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thank you. Thank you very much.

>
> Richard Haines (3):
>   Documentation/security: Update LSM security hook text
>   include/linux: Update LSM hook text part1
>   include/linux: Update LSM hook text part2
>
>  Documentation/security/lsm-development.rst |    5 +-
>  include/linux/lsm_hooks.h                  | 2365 +++++++++++---------
>  2 files changed, 1364 insertions(+), 1006 deletions(-)
>
