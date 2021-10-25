Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250ABC433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Oct 2021 15:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0141060C4A
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Oct 2021 15:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhJYPDz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Oct 2021 11:03:55 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:41551
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230268AbhJYPDu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Oct 2021 11:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1635174087; bh=nDEJVX7c5qxqFR5ovlbc5JwZbNIjrIBlDgbPxRQr8ng=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZuSObIoPktLjzpwoqhq8f37Jl9PcFwUd2G01VMuD6U1J/VXXM4QxsENhCGqN6LH1GSFc4Y20NGi+UZ1l/NOKi6QutbpN0d3S3Tn/lwMCUu9CobsjOsPzTSbyR/RlVYES363wqYej8/hyieq3GLqvWXXt10q3B67+B8LXgVDt9Sw2Ajnpa1qdGkPFPR9L7afTPSvbLi+jY4nD12QcEz5iYqBPIGZ3b0DLpD6DD2/xgq7F2v/WTYwIhTKC4HazDDSz64LS/v5u6irCBVeiP89HRo8yUngWiRwdmFlMLbcowccgwOjvV25NcmMtgSqXsbJZEr+4snH8cseh5c59VZYBKQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1635174087; bh=Fg5xS1ClGMpk7xTFiiaz9nI6MnbSMVKgCGfAUC0MDn1=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=kWekE45eBLWN37iGyA2FXBsbiaNLvbZH5I2qv7cTpn+GoX3ExJJtS34lUyTxB/NEE89YUFqj4y0NkzTSBkO3YsOB5VQONg/lyhC0Zabd4DgGt603sneZIXP63Xbb/zI+dTMz3lfzchujJ/tOlM+3vvkPZmuo7UEyPxhjnEe0ZwpeH9TWz07lDZ0M6/9SViDfjGr0yClRdyJAayc8dZGr7DW5ZP6XkUY6AlLOFF4sw9aFjB+jZNQiH4nr6Iuu9boiCydrx4Zw6NcsvmNWJJwd1/hIxUftErq+np4g1YnF5zQ+n3DtQhfRdjryjd/8H464cTqWUR4zNsZVstnWi4Ucwg==
X-YMail-OSG: 1nCkAXwVM1n0to_CEubE99.FLDBZNN8aEb09.bILVX3sHMOdsNaVBCyvKW77BAp
 M.vIf8k4IT_luH2HlZP_1IzAwYjL9C9LDffZVUa3FjNSlm_uqLIEcYqdS_VmC35K16ssgI7bAlhU
 qDkPDH5Ka_epo.6venQl.EBOLbAbsBX4x7aWKIU9.TNWkQppb3Ivh73NzOgxrFqpAhrkHF72JCgF
 J2MNr.cwLRTT0GJEtCoeXvFCT2Gtr3GUaYDnA.EwjszOONcLA2MHuftPmuscWoNuDZuc7FbfZbUl
 LahRdjxxlGr48n.ZfdXWamsBqigoAziuNC2JDIL2H0wuqJlVjuVOItxCu9lgECV7joyN_siPxukp
 AI1lrEV0SBrLn.VHla49ARCUxHvA6eg2J.MQbnZ50H1rBA9gmOGLgPAf89fRx55uDWX96U7Bs4z3
 0MJWcZPvtA1dRAxHP868TGxypd5ufIfpq9WBxdyiMgEEelVl_Qt7.DwnhCi8WXFZ9yxbl21zPYJn
 wrzWQf4TJBUJu_SGj6X2KbIszemrXkkJdt_yhmLmILycCNdq8u1m5abnDGABmZ9kL7JHfWRPMvBs
 M8c4ULNq7H96Bg79z5.Rrlg61Z9WmFyYpQPzjPgt6YYuzT2yMb9AUbCwAKiRZ2ZwZQWY..aBttSe
 dAMZk4bd6g0Ig4wsBSfjXh9nEwyjgShDJPrUnZIBz2pxl3e.zgZNep99javm7Oljp4kC1OS5Iuyk
 xyaeEtdEhafAniDUFidGClDSP2del1PnyfRGCt8UYwhcPqRlig8ahn5mXh_yUpfurcYxxZXMX_cL
 RpeWGWRNCoG4C32RXYBpUCJUbQntswp5LD2MEyp8qm7m3FVoqBsHQpZ5r3BpFDcPniDuNTaqGANr
 yFM9AaeJrFDg7TcixgOuNbrsvLRWr3rpXP1EIToqc3Ema4IgFIoaVxMD.fRC4eIp8u_G2GWpOGIy
 B2nMUDGbh_1UdNXiiFGXwctPchaB89loyNe4cYI6FciCf6_WrbDGpOUkv6NtMC9oVweHhBLXXPgw
 HHEoPV2fvlvRj7dxt7WWxI9_1sqpvZX8M975bnYREXG1y0DKAzJZV0dvB5gSXBYJRKSvJQY332zr
 y9XbGlOvB4oiPtqFTdTkGF.pNEIPu_fy15McVeU6ufnjZ0vau8bSYENPvy7O5jOgmRsfS3gV7N_E
 hjHgtDHZs6VhP6ctS_vV4swZcYTHVUQhKaNMigtV4McatB5PDGPFrE48Yn.jrqaVr8z83qc0nq11
 REGL4.uvn.pQGwTBmLQdma.RCrt1uMZJ3u4bRmPs8PsY17K0CdzS1rqSV8B908r85FglH5ONN1d0
 QorJgsiYgVgqwCMFJ6VPX8jAg0uKbGEqfHC4x3a0JyaZMhX5dLRziKoFuBUoP18nlF2HARritHYv
 TZot2l6JuKcMmsydLB6aCmgWCq3Ky8ke9r9qXz89xcXxTHtXuw6EWrVTkATgOEApL.BDTFhs7ac2
 aoJiTk8F89BFlMU_uUNzu2NLfp3vm65yM646_Zy4CgFoTYiIerP.fthIM1wDnVeTv10pXWt1zoiS
 evcLHo23p3yKWJz.41dQy5tZ1v_ygCYrjKheLaGJJGrLJoLBMPIZ6TerPrHMzaJbNQET4AWy9H4W
 XsalJTN8bKTz7DOJUqPzsaNsOmzwUW_y8djzxW2mJfVctxnAW049vknR2KKywWztNFCWnTVSEkbc
 Az25XuaSsI_oTr4KyIWZbivt__6kipu1FFbeTIiDyADT9zz31evRHHQNctFgJIfsQhpnPN3Zm7ic
 XSUtIfUPj4taDxsc3zD1SI3jxuw77nNG5BOu1T_X8YRQkfLaowDiYYkTfbaB9Pd6OW8G6dKsc4ZV
 jxet2YNFRLaSSFnnHMX.fiNsA70BMVkcgxvD2CIPlY.pJ0zZ1TL46ioewpYnSKQG1uV1I3SFTTpL
 oCc0Ui_Q9hg18RJAJkFeGMLXUP2iZgqPSAqhAEDXqwhyRL1JoFcGi1mnHQjcZZ6J9Ed5towCzsH_
 OgQjsvZ2lDv9HAZbjHilH6_cfeweqonzbkQWqo_7_7eGCLulOV7Uy1ZpGqNKc18DLhvVi2aVEYOq
 sRCHxqR8ZJMcfLda5jNxxweS0_mVryEJHnt8K7i1LcoQ.4n6eu48p6Tmeif00GS4bdIzYndDekjO
 slbsoMb24MSXp.oC0pMOuoQY.uXx8gSKpzIrn757EeWBSwuHbF2TnuI20i1yzAVi8iV2IlrAN3Cz
 mEz53XO.0g7gGaesFNU07Wc8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 Oct 2021 15:01:27 +0000
Received: by kubenode524.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 184d14f3ace445a0a5d08ae31a8f3806;
          Mon, 25 Oct 2021 15:01:24 +0000 (UTC)
Message-ID: <2f00ac71-487f-1b39-133b-5ab40cc9c3df@schaufler-ca.com>
Date:   Mon, 25 Oct 2021 08:01:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: lsm-stacking: fix broken lsm audit
Content-Language: en-US
To:     Dmitry Mastykin <dmastykin@astralinux.ru>,
        linux-security-module@vger.kernel.org
Cc:     akovalenko@astralinux.ru, Casey Schaufler <casey@schaufler-ca.com>
References: <20210806070245.26338-1-dmastykin@astralinux.ru>
 <f2eacf08-d1a1-e8a1-eae0-28e4e54b50ff@schaufler-ca.com>
 <539ad779-3dc7-91d4-4f7d-398821207356@astralinux.ru>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <539ad779-3dc7-91d4-4f7d-398821207356@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.19198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/25/2021 1:17 AM, Dmitry Mastykin wrote:
> Hello Casey,
>
> > On 8/6/21 11:01 PM, Casey Schaufler wrote:
>>> On 8/6/2021 12:02 AM, Dmitry Mastykin wrote:
>>> Hello,
>>> These patches address the problem of not processing LSM audit rules.
>>> Problem was introduced in lsm stacking series.
>>
>> Thank you. I will incorporate these changes in v29.
>>
> thank you for the v29.
> I think the following fix is still required:
>
> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/security.c b/security/security.c
> index e33c8ccc06a0..fd14064e9106 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2934,7 +2934,7 @@ int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
>              continue;
>          rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
>                             field, op,
> -                           &lsmrule[hp->lsmid->slot]);
> +                           lsmrule[hp->lsmid->slot]);

The code has the correct indirection as written. With your change
it dies horribly. The interface is not very attractive.

> if (rc)
>              return rc;
>      }
>
>
> Kind regards,
> Dmitry Mastykin
>
