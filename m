Return-Path: <SRS0=+lL4=5Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1971EC2BB55
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Apr 2020 21:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85B020692
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Apr 2020 21:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PzE0eKJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgDIVAS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:00:18 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:44182
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbgDIVAS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Apr 2020 17:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586466017; bh=i6dQubm4eW55xOW2CHC5ihX3T7Nv1NxSndsDNtFfxzQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=PzE0eKJcAfZ/dqy1GX2F7bw3KIFpq6QHdkejRchwIZsfLubHTcA0NDmmOO42qhxvoRwbVKaHEs03tjH+/ra869bFTA4C0R9UdBoaBCxxiZhZt5IYuZlRM8SzeiA1TRcQ5U7zQt6AWIguM6aXAaa2TExNPrKJBJz2ez+mmjU89e7q9jY6UiGWJtG3VvMybl/wu3Hp/FvkQ+xwZTDfwhtbmEjy/2NUQyOf1o9Nfin6j/4Dp5lKNl6KvSur2zHk9AMf1rVineUBUidJd1mBhA/7fAWDJFo0Ld4oZe70pClD5/z/QTg5iVN3A/OLAeWsAcqXcyjP7mA3VvO1uwd6v44r0g==
X-YMail-OSG: C5hNu1EVM1loB1ekDhNsJO2A4G6GesNj8.wNoJRN4Kgb9QjEPv4Pq3DDWfGnmUU
 4b..CP9aEpy_bchcVoIP6aMcK6..NQmnk5HH9Dmud4su9RFC2UQmS6F7bwpAH.tQOMGyOxzwj7Sb
 3lJrxWBJxGJZnX_mJEOig1oTyd3O1aYOoyq7zYLcgBf8MHsNaXEYd2Hs8UC9K7cBbTWErt39_dAs
 AkERexTxYTtx.9YHnL4VbmgCOTTT6YXCVyMbbi4yH.fdRMTpDCKmXvy1Zf07a.jAyF9zcVZzDK9r
 tOEj5ImIbxWTVeg2BdIJE9Ww3TFghf.KCwwkl0S3zynWudSetvUkU5UGwTfYvnjHNQS2OTyrr3Nv
 LNbbF0f5DU3ueOyM71pzpSz196cYNYBH9f7EtwG2BnKSczVQ1_tfG84jf5Bxcxrr4AliEdkBcZGN
 XXKlWGr8YjzFiv19Uf5GdtQtJ0kjvCGcoOcuW7SE35GjxBwI26hB1j52EBNnzHqxGQxrs51DO4Ok
 giOQHLWB2QRHl4ztXFSjmgc32hGtt6wN3zcl3C_TSusmhOslhyoV7I8djO7RUOVDd4LCl95AIESp
 g3sTmrrxngaIIKwo6TgfOOEbvwJtUerZY1YD7AKtPhHxTQfF701Damf.jQUNvAdlmQ1P9UJX4JBL
 BrrjJwRHo._uXw1COrvcO2xM05RnU146hImGbhbi0OjtcxFPwbmNlPT_P2d4lgB0qfRt3xiWDe52
 HLYF0jlf465ePy2So8x_RD0x1.taCspFczxMDu1RxMs4bLncB93CgQSuzr5NU0t6joQQZKHcQqRB
 FxwWDH0xS2CFhvCP0pR4kcjhvYmEWwQ75k_HyNggi2l8THz.hSWrSEOY6EyJsva0eSpUOkmohcIJ
 Tw80WCz6NmMZlLW5k6zI1vb48ZALMSJNElNL5iXjS.iHFiDEPQVu8yi85BEKU_C7Fbz04VPcfrrJ
 6379YT1M0S3aekR0Kz3j_byVyRLDgeF_NaYR4EELoVJ4eRw4JcTQqxHl4CyAni0W.6PTHtRDKTx0
 twdXy2lJibIvigWOoR0kh6HS95NNb.yn0xLkF6BMBfLCGCA5qUMi5uX4u5ENHqtVO3AJIsQR2HYM
 vrNr1L4Q3qTlHdoD5Wg4KS6feIQuwk7Csdzc0Uz9XQ3bHF7KL1VSP9Rfg33CW30SpyoK5ZwBQrrm
 1KyFDD2j1fm95niQeAxmUKeaXJqPFRW5gx2OGcrzyDMm.HDatUchD5rV1x2l79uX4VJ6JX6dKLqA
 o3D7HdPW3mEC.bLGrlcIgfXklUHAvxvDa0Qmqo3qcJvjprtJwiCBlYoQO_g0wNapcKdh7heEfVVM
 AH0i7H1mFStFpoWrDENc0nAih.Og9t_6qVVXMRAK1w8X5iYZLVmM2t4QUemr3no_wHNxf_CGs0xa
 w_SLomTDJGFQ3TGJT7Xu5Kd3C6nBtiAqJ5ziTnAU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Apr 2020 21:00:17 +0000
Received: by smtp428.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9a9f5023a1c147644711e2ec456bbe3d;
          Thu, 09 Apr 2020 21:00:13 +0000 (UTC)
Subject: Re: [PATCH 1/1] smack: remove redundant structure variable from
 header.
To:     Maninder Singh <maninder1.s@samsung.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        v.narang@samsung.com, Casey Schaufler <casey@schaufler-ca.com>
References: <CGME20200409124013epcas5p33036c008f30327378a6ff02050261626@epcas5p3.samsung.com>
 <1586435998-18921-1-git-send-email-maninder1.s@samsung.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <91af6ae1-919a-bc48-1f62-6ba3b4c62dac@schaufler-ca.com>
Date:   Thu, 9 Apr 2020 14:00:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586435998-18921-1-git-send-email-maninder1.s@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15620 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/9/2020 5:39 AM, Maninder Singh wrote:
> commit afb1cbe37440 ("LSM: Infrastructure management
> of the inode security") removed usage of smk_rcu,
> thus removing it from structure.
>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>

Thank you. I will take this.

> ---
>  security/smack/smack.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 62529f3..5ebd0bb 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -111,7 +111,6 @@ struct inode_smack {
>  	struct smack_known	*smk_mmap;	/* label of the mmap domain */
>  	struct mutex		smk_lock;	/* initialization lock */
>  	int			smk_flags;	/* smack inode flags */
> -	struct rcu_head         smk_rcu;	/* for freeing inode_smack */
>  };
>  
>  struct task_smack {
