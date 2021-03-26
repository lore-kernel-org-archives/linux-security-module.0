Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10E2C433C1
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Mar 2021 16:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8449061A36
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Mar 2021 16:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhCZQEA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Mar 2021 12:04:00 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:37923
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229945AbhCZQDh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Mar 2021 12:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1616774617; bh=yweyPIQxB6tNIQRaZ4kmohXRZpEBW8WADXHNPI6KWio=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=YPZ7OT5AStWiWvCRLW8ZscRADUNn3Je83HwAZklwwLMwoyqud4+GbDQ6sqI1fwWA05+CaGZQzpDNZ2Q8fEs9oSEydLQgGUhYKb7ubAvXz+YBz9R6/loGomhDax6uDgL9vP0PFintbIwwrA5nP3MfMiT29258LrO7+Zu9ugbq/GXoh4kvms4ulOzZT02itrYVjx+VtJ0sDamSrC/w45SAOFvV8rfthd2ipLX+0nSrFDUSIlUWjs6O9UnjeETPTYQeW2m7DDpXb/WOPtql66d1Ma/zsNjYaeHOcMSVXU9gbWVDYTrzpH5HkwtOCLy/uFBWtNuFHppbCPRDOlaYr5l19A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1616774617; bh=YSZqyoh+6vzbCJl/3JG8peAld9hKZeAGUH6kB+otKGb=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=YosILa7g6HasccAGUDXGje7O5rbRFlKbnYUKoiY6wyA/XPH87MESsJm9FhGb507pS7xkGzwgn9R/fkb+yBqAShCrc+4X/9qHiveN6/k81yosuz77gOqYKZL16nyZ2j6LUwuAe04NbOWo5n8BpdVtUSYFNNJqZRYRdb2EO19YzhAQFPbIpX/6YsEADtRZ/UKkd94NNo4hYJkELQqn7Y+V9Qp6G4VmYXsi1Te1uenUqxHxqvKYbua58pcrIUiIzgTmt5rGQF8Z7X1893I1OMk1AJvvox/h6o2gpFlge63xzYlwfbSpBI7C+8uwxYjqXkopDD0TMlC0SIb+obgnbFjLAg==
X-YMail-OSG: tu9mErQVM1lcS5UMzS1Wf8UWRrIm7DjlFSHatGf_bKNuLAr_GjWjnOLckWgmbo7
 5ddtPqZlC.fHthbtG59vZXK01qLlaaw4wzDplpETBaJIdK3uXOENs88DrPfeGBukmb3E1dR6YgcT
 XTym7uljqvSsF.L2rvRpn9X7NlGlg0QzFYe0SRsKd_MFDV.g8tiZW0R.GoIh1ivZWbNC4qACmRhP
 EyDW6471xfN0GDOwNP5pgLtBhEWunLfLeYvGmgsXS.YNZcLVGfk1hLEK.MUj9wdKSyU_XlM1qtA3
 wGM6eN1fhCtSuz3cuPeoz1evBQMehUAYc8Ma75ZJDdtgjbKRBr82WEepdkfhHIVv5b2pSbvFsNmT
 jzn6PARyo_3K0HAuGaVAwXVNuv0ZF3Uf0Sxtpv6pGSkKYe1VmXCzQxM8Fy299an9Y1QN5xQmtOCO
 HJkOLbD3cRMWx8MFHF_68.z4JffYBUe2NrAb4bMbY49rxKbujeqCY0Y0HGFQ2iYszQSAc5yainpq
 mOJeS6qEFrFJTl8txe4ar05HaaH2hghQgon957mGPpLWV3_Wx0ev_zRH_pSfb2mxFgFKxgJo5Un0
 Uu0.7vPuZKPxoaUTfSXI3gjnq5bfOfz2kgZACG0siwiLoak0aWIp77xI4KCu0O30gtWhjuFYsWcr
 BxnTGRH.fSb_oKLZ0ktbE1oKYQ6e359ZAstd11nI9IijXQQlQLHuV.cCnHC6U454.UW2xrJT78ko
 cla7sbUsYS7S3eWjsltodhGCfaE5SI3ELqKpnRHNpK5IXzGTDsXi7d5CQzTtLohNHRYrdZagM7iC
 DrGjC_ox0lOzEQ_7Ae6r2g1nLjB3B4yfk73VEQRRJtCGxNPUSHBsZUTVEXOy3cLHXmykNUW0RU3L
 arIv.9zh.kde4VtdnI0l5s2Ev934ee_TqpzPIAnM9Zr..cQHtp.VuU9KZ17YprRyDoR.9AGVriCM
 oO.LIQezP2UAATkrIstNVkGvdfaspN07W5EKvuFFIewoP0f2M.Z1uAajaLCw18X32siNhAxBXqCr
 2jbONvGXCFhxG1pDda.hTSB.E3NROlKMPAEk4H2r4Lcu4_deE.Hv3R90_7oyK5rqOZdzbS.gqvxs
 1PK.cNKAyQxIbMQykrjHVMPE6DxbO5zfw3iCGeYa6QtfMFVlMPaEe1tK0csNg7PqkUv_2sTQTKIV
 cdRc5Xhh_eg1Rhs6pUck15hi3IxUv3C9XExEqpQPb0jSZUsezk6luM4s_bNa16rybUUxJWbsR_jz
 xLEW.IH4H.jhJ37MsAyb1QGP3wILG96FfsWyEsciS2esO7rGYve2.Th56F5fQ.QRUyaske5Y8en1
 2hEpu1my1t6FEx0ItT_LsMEeb_aLEXR8f8HiOaWqaxSDYyIcCMBmQc7HTNYc.DIj2tHYi8ZgkdHT
 dJ5SoobwXLyKkKCG8edcFx_jYfDHB.5xL6WTrA1_mNXw585JWQlBlU7_ys.4ApvM.8oLhYjKb4YU
 MQqf1rGJhnUz7gBJbwQUN05e__htqmAOiqlJLvcR9LB94zXnCZi9yVcMBBp5XONo1TGmp7_RXZVZ
 nMPeyrdT5prlmAWlgVfa7g7tc.dVWBzUjH.jSLc83pu4_hgGCsKKKc1Ygua2Tr3cbSjDweIzMzbK
 FKvFv.E42dYqqCHNhnR2E.Bl8MGjpDxWceNYLjExddgeH7gwL_oon7SwmnDWmDYOm4N0up9TyWtN
 ED0qASPIYJ8C1L2HJ0MrooLPlelGWNBRwWTfajDrSLNyjcfD.x7fIOwwHm__HY_94ldgCDPre5y7
 XGQB8SzWdycpY2LO.5b_uiG0SWBv.wFO6LzgrEQ7IOf9mgT646lF4TtOF3orwAVcuqhdonaQTldq
 B56v50JUHj7MzSo3vXFNG8byXx9LKXKST81n9EYksvGXKZi87Z1Jl7ttgFzv7ThROX5p1QfI5BB5
 22n3wzW2PlgNOv5S23EZuBTqBiGqf83b5AwnkuKnQIHEOnLGyazSAXQ_4YedPnDmew4Y8_TbuNsf
 M5jQZTBswPhZUrkMSkAF4bEZ9wtGUxgWESNK59qOSLvWOdPhKLsInMiLcDAOL5ikDWno1ohXS2lo
 8es53VCfZsAc_tc1MKKCnE_RZXzeKUho2yrYOZnmUDoHnJ_HAPV8M_pVeGm_UxkY6LtdxqIIlQ.v
 TFh15UUjXyBViHjxOWQqT3kvoBSY3558KApQ8Ybt.qYtFbKx160yVKvlLggY3pBTeHRFndiVcMvk
 d2x_cjeT9d7ZqYp5DC4wcQN3m_W2tmEG6E.J.dRSqNohII1nTscFv9Rv8Eqrri4StSF0P5TCjs5V
 nOVxOF7gPm3FjxJq4TBSvmQdQu.XDYDxvAAczbqul6iKBgVABVxJK.FVrocCh3lKlIwFsDSmIw23
 0_IJpUrFeoaHGKktsD2rodWROGRssl6W6OEiaSNbtzr5pAtYMwugnRRevizG0a64Cn0j2kkDF7wC
 SqftkcgG3Idn.KRGak48X_lex3e92KGxTwmI9COyGdempnnwEE.U9Un8eJ4m3S4P3FA2vr4pl6i6
 w3evaSMxH_9FLIlCI_OMJV6fdDxVrHAYq4Gs7WicggHIjVMuXT1iNZHvRU.cDY2PT9Fen83qCdxJ
 XWMDP9xIiTmLcE04jACMp6oZfu_j1U3OvAB7xLCv4UcCxX0afdoLizftD.KoqIQI7djc2dk5vlfA
 nMiupLnT_RW3y2.k5GcIB90IFRyaY7w--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Mar 2021 16:03:37 +0000
Received: by smtp404.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 62db9f694879b4a95d7db21f4d7e3752;
          Fri, 26 Mar 2021 16:03:32 +0000 (UTC)
Subject: Re: [PATCH] tomoyo: don't special case PF_IO_WORKER for PF_KTHREAD
To:     Jens Axboe <axboe@kernel.dk>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <46f6e3cb-cc96-d214-e183-71dd238da075@kernel.dk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <935b000c-77df-fa88-6e2e-daffc256a11e@schaufler-ca.com>
Date:   Fri, 26 Mar 2021 09:03:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <46f6e3cb-cc96-d214-e183-71dd238da075@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17936 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/25/2021 5:44 PM, Jens Axboe wrote:
> The io_uring PF_IO_WORKER threads no longer have PF_KTHREAD set, so no
> need to special case them for credential checks.

Could you cite the commit where that change was made?

>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  security/tomoyo/network.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
> index 478f757ff843..8dc61335f65e 100644
> --- a/security/tomoyo/network.c
> +++ b/security/tomoyo/network.c
> @@ -613,7 +613,7 @@ static int tomoyo_check_unix_address(struct sockaddr *addr,
>  static bool tomoyo_kernel_service(void)
>  {
>  	/* Nothing to do if I am a kernel service. */
> -	return (current->flags & (PF_KTHREAD | PF_IO_WORKER)) == PF_KTHREAD;
> +	return current->flags & PF_KTHREAD;
>  }
>  
>  /**
