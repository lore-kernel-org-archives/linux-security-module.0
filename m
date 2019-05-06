Return-Path: <SRS0=99o1=TG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9FFC04A6B
	for <linux-security-module@archiver.kernel.org>; Mon,  6 May 2019 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B56320B7C
	for <linux-security-module@archiver.kernel.org>; Mon,  6 May 2019 15:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z79gGrrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfEFPxd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 May 2019 11:53:33 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:38825
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbfEFPxc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 May 2019 11:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1557158011; bh=9BXGFLGnKgvKmjPZlYLKVao35qCG8s0UOS68QAozH9Y=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=Z79gGrrbrlsmVftbNGfQezrjM3PVfiZoijbAzX8WdeebGNX3V/2nRbr1uvWWxKm3WeGqWZ/RjBs7rCxhVseb8klRaP2rIbgV2njaiEn6EVsWlS/wKqdEv2SyFzwSEBtOSXZXDNEIIC7xcDYa3M63ZM22TqNhTDQrX/rbCR6raUeRGvublNay5Htc2zQUiG0WqPsQQWwzwbtId5i49w9Ke/VOsMzqOPrqKpMzQzq/YGmR5XJovqQOEe7/vmM+AvdYdPCkuR3D4tgamNqqZTYew4WBLn2A4cSEB1RwsPG3OfilLoxQUwP4GiakvfA83EyGoKDJ5BYRU7+qKGPaPVaydw==
X-YMail-OSG: bWmwtPAVM1m6gkDcDo5yfxSZ3c5iqNQCZsnSTLQH8e.yAZKGKknKS2h11QVtmck
 s8LHl_f0i.2RYaT7fJX36FtbmecRIA.yxWCZntxOsJo.Kt3SJdtBJX9IFYvINic8uhKkCaJqZnaT
 MXaoqDRGTEErqNughra_P3rS5Uj9UbO7UIyQ9.rmZvfKTJvNbuRJmj6t8iNi67SPOyQ.4Kl5cWjM
 XfZhlkW4WWocC5B1d5OWNSIyJV8qehz6BAcbh7lXqweSGvt7S7pp9BDI3_MCQPWBifxjW7dHJBPP
 VELj6YJ_Z7tUXzAOpzE.XHp69jVJBSv1Sf1_WZkv9Dx7CHO4CE1vwfRl2SYWaVY5bkeGk54s.50i
 Y9WUdS5MC5IogRv6YaM.vPJkArQj9nfakejZ6WEZe2YoY19E9WZsM5XemFmJ67vfysO0WiuKptqT
 eQCECNXzS87nC7bKKgTiYS.mndH2TWVWge9s9UWrpEraRRb.O7v6v3Hj0o5F_lKc9NjuwVJtXaij
 hZCczKL.SLzPfsw2Z5wxbjXbt6l0RAx4tS7tAeGadL6rktrKPmtMBSSqUH_KsQx6ef7802k4VCdP
 aOrtf_u3BoaUrasXlrLKLdLE_jhO64hrzMovK1cbTOcW4aM96ueE.I2Fk2G2msORsZAjJnm4_QAp
 rp54UAo5rW10WnuJFhlGxorOWBJeyo1v1GP.5y3Tt1mSVXOxLcQFtgV_anJ5zAN70MKOoU.dHHBa
 i5U9vntnQEO6zlpedA.iXOtNzmfzQ6WF3JfLUzj8MFtqMuuKRPz62OtUfvaWFq6XL4XtmyEJbvpL
 7.yAuLhhjmNNtvLLXuREbDg0v.Umee18Pqk3y_kSDnvw16qFHEpnC.Xoh7EvFcIZ4IlUz_iIYbv0
 Y.d_02KdCGb2SA27wpve7B.YQH10h.s0lKqTGGKpVAE3_ySULjZSLiBdTIA6JIDFrtRyXBkFfZE0
 Y3gRTQFasq4.Le1J7UaTniRHszsrsUntciQjr4fagAusjNSaiH2r93wi32vDCiNIsXWprJpplIhB
 tDHrpF1NgZGI6xcSuhVC1WMaodlzm2mkd_xwEMTd0TxIelVZju_pT71NHl1sWdpItfCRFgG6.SK6
 WWMjkI8wOAWY6u18EhRsms2BKTKFx9tnfLE2WZNR5Awj_6K3.0CjtP_Kl6tXZqlKVk249HU1whZ4
 PMEJP.dA4eTi.IlYwjoeAP9iOhvD3tKM.mVN5yt.b7x8cAtmbVAETsRJRQNHIoczOtTqLO0j4KoE
 eBQYttH_Dyt5RnpyLCuLwZJyLYJYq9Kw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 May 2019 15:53:31 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID bc63aee47df5cb7a625619b03821585e;
          Mon, 06 May 2019 15:53:28 +0000 (UTC)
Subject: Re: [PULL] Smack: Repair for 5.2 build issue.
To:     James Morris <jmorris@namei.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <b1d1d0b8-51cb-657b-c8be-aa365a29c8a5@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c028ab99-c042-191c-8a18-d34b8ecfc3bd@schaufler-ca.com>
Date:   Mon, 6 May 2019 08:53:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b1d1d0b8-51cb-657b-c8be-aa365a29c8a5@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.13583 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/30/2019 2:29 PM, Casey Schaufler wrote:

> James, please pull this repair for a build problem with the last change.

James, did you get this request? It's an important build fix.

> The following changes since commit b9ef5513c99bf9c8bfd9c9e8051b67f52b2dee1e:
>    smack: Check address length before reading address family (2019-04-29 17:32:27 -0700)
> are available in the git repository at:
>    https://github.com/cschaufler/next-smack.git smack-for-5.2-b
> for you to fetch changes up to 619ae03e922b65a1a5d4269ceae1e9e13a058d6b:
>    Smack: Fix kbuild reported build error (2019-04-30 14:13:32 -0700)
> ----------------------------------------------------------------
> Casey Schaufler (1):
>        Smack: Fix kbuild reported build error
>   security/smack/smack_lsm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
