Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D42C4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Nov 2023 16:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjKBQmS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Nov 2023 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKBQmR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Nov 2023 12:42:17 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD1F128
        for <linux-security-module@vger.kernel.org>; Thu,  2 Nov 2023 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698943330; bh=dGCBhj9hXwhmd7OROSZNBafBE08UgqqXxqZr1VH9LCY=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=fH11jjmTae8RLcKsWrNWqg1Z4R4mORrBlF3fy6WooRdToobnkR1pnQ2jeJjK9jI2NwG9kMT/s3GclQ9y4PyYaXk6/xZw55ZPcJ80fdIIjpnqcRzO5Nq7w/R4OuvXHvj4mLEjfJBFTBbd2c0LB7mAQrMkrjW6ZWMJqvVQ1VJolZJuqcLjZg4ygSVNSdR64ytTl7I/A+jb8OHPsX+Ur7FAWeznOZb7TBc2ldJ/gPgNxZ0N1ufPshsmaDB7AKkv8YJQc6aw3+b14CaLQalLbK7Yz52bI30RK/83fXIZY7sIfQVJXjKukxIpLm+I3UArK8YZ6d71AxCB32pIrXT9HJWmtQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698943330; bh=3mvC5q8s5SMnj9b9uDPU6zgZi8uqscf5SUH9Ou3mAg7=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DxkQ8pxUpD2bMuKsOwD4utPBoYWDUyPnAKtWxDSki+uFweuboM1Nl2sopQVbLnMxTzGuqvWAIf9SZwsaMeNh5cuR5jebSeCdLEREX3sA1BijPTbYwVJ+stYvN4/AmeuhCIQZ8BGkoMOALlhga+gxQaZSwKRjX/Zb4FgiwiFGZ3b/1JGqufmO3YmI9brw3mgSjDeinOb8ENyV5WLWEGelnJeoEuQVv51uJSDAsY2OgFzAgtfl/API96o/eBqxBf88Q3hlIUOBC54IYhRs+Bidun+hdgajToXp52lyX7Mymx3z+UTDfIOFywj3UzU8uNfvFic32E3GaOKFO/eCCvpi5w==
X-YMail-OSG: fSlWJpgVM1liHeU8fldUuHIEKhgPtAYUijKdpXQmV8qzrTRovNZa_5d0Xw3wMDy
 gHMTE_BwaAhWnNZrgzzrTM24DqkazxQ93wVvlrC1ky0xFp.nSPpd_ytZUykYp.8fX6jrcAMbLlbN
 H54kWvTK.g9o0oB7kKpKh0cuXiqxNYsnP.29YbgUFHL0o1lJTQT6fb75NwpDp35lCJLbXW26kUYc
 sCshPikpU2tfGNS6msS.UewqDMNQLMt8aaIutYLywDvrD6DcjLIRkHItfoEEcQsRramKEP9NU30l
 .mFsdiPbjwExdMS4JMcW0VtsCQY0_gk30ACMQwwkB2CN1m8M129tr4XbjSGbIFCOkMEaOKSUTZrO
 3amCDGQeqcb_RgzB4TSHNIqLysvOEzHfAdsmoqLCqEN83qPrLTm4jU.KWtbswwhCMyoNqO6Hcmlo
 12oKq8k9Z9rc9i8HPIwszGvUd_hMxBApTH_4h6teP2uxCgpKAOz0WuSpCrenj56kzgJCfcAl19gl
 IrkOHjNyZxoPeHW2Iu.039kH9K6xCzL4oyrzc0Sn54xvg4zIr1WZKGhV_X1p2NnqpLqzvu11Z6bz
 joQlOmhL.jJwQNBhEfyBxp.3yF4Xd19F7GC2FXsccVmdjLpyH_How_wJt0cIsf7JdJPmnKIb2AiA
 9zVDLXVDO4NuenxzzKCXbzGpb0jYTW51.2hZlRaKnvzOBAblQgRHso4dXJgI9i9EGjMkzdmX6oRY
 Tm6y61aH2SBtfVH6xWFXlu8Q3LbkI.01Pe7jX4RF6UXhE.WqOOIOFXhtvKeDJd2HTcJ1LcEh2iJV
 hI6iKgRwvFOv1NV5HstVxryx.smni8nE4TC4SLlzhQxEm0VLpqyVhmHH8IynLhYqMjY.IAFR1SEa
 LFez88KvS_Hcwhk6UdBMLt_Q1qdetq1hwLzx9lGCBg0ikpaZqtuTUJYAz2KJ6ujWTxPj.RLqosl5
 fFWebiT6h2P.6.A_0RndgtoLXSlhpGFtehVwvk3arTjFcyLqcdyfP1CzSrevb8nHxVG.YT3KM7NV
 oW1MVWMY0cm4exFfTHtYaiwqE0uEnA3_fTf6eEYJRVnGsyo_TYm2uLKW6_PmO0EH3hlK6GkdG_sp
 1AVuc2p6xJDP8K3QjFezeLZ3IIED741svsYVou2FluUD6GpTHlTR7vecPwN5UR5Kgxy0gFXi02fW
 H03Ldns7puf21.mRLMj.akHMrWQzIJ6TFNclkNfQbL.Rxhn6YnLd6cpP0HsakeTu3imkXEIW3L.N
 9BiINiguzo_ylH8JHZ5rhNpvo0gAIqc9kE65xJ4B.mhofbsTw84VFmquSUcqPfuBDVdig4MJz5K8
 21PidH_D1811aL1.1ck4v7Wf5PCY4ArLof1DOIYf61o4MxCuGuNTIO5phPRBDCu9XERHnZodRW9k
 3Xid3zJGiUHpmMolRZ9_0_dOHIezRzg9Spx33o3kICs6zkvG3Q3fqr9XlpoCPGtc7TJ1Ga7oXHHj
 WsD3vvVcCgxv9TOEBO7as3.of4aQ9KbBFnXs8n8h9QvueJdQvxf2WUYOMwVa3J3U010N995fCaK4
 L.i.G4g2TGSkRk.ENvQ.KxK_4MUnVi8gO7bPl7.RbekkriNXVZ96ralj5jj6Id_PPDOyR4gE.0ka
 ymxh8AtXnLS0AAm7gsgoxFD2B22x5np15pg8C6cMuGttjgONsiwUJvRZS3mp8a4f3zJh6asGcYCM
 AxJNXIXjRTayKXwX3mqhY0hBEcolIqM42_Ogz1llHTHdlpBPhASCeIx3lJRaCwYLolyk7f5BNje1
 nmCW5tDVglZiCwOIFasG5FEPW0bUOStflDuRM5Y3YxUVwMBYxNiob2Hv67TgJFQM9ehxu43dAUtM
 ILpx3e559nBhAkLM_aqME4JXChE4ijDzBb9h8ziq3hmUejGmVeAOS6weVArdxZRJ_TqMWGPns7J3
 P2exRx4RqcfrRByJ4kbSTdLdRBRUsOqW_S4wmAkpa5CiB72lcEF8IGuU6_p0Pfpx5QsBhOp2W4YZ
 2joDoV7MQk.0wR_SHsKfJWWbQQonVkrTghnzGqOB8rU0c5bDW5MRSYp9LZ6SQ.L6.JCwFXdjL72u
 fr9jpJ8l4k2.wsyhguEYKgU6IC9U0rWc80WMeUcvgMHf7sXh4SRbHCH8XG9.yXqPkkq1aX9LTkCP
 eD_taLc3_ZNmu673xbVQGPRFswkoik4rh.yrqkhGBM8wY3eXAfF8gIwigfwoXiq7mG3TEiVqAzs5
 FuKvi_PTV8uMe_fpuUvk1GPVMNE1H3BGB.SttAhv1_7uoXUCrntlwrBSZlAe.VVPq4eM.85vHYt4
 E4Wa_T00-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 20037128-f0be-43e9-a2a0-4dacdff6f384
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Nov 2023 16:42:10 +0000
Received: by hermes--production-gq1-59b5df67b6-s2hhd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e04410f4de43048b4adf47b81b4640ca;
          Thu, 02 Nov 2023 16:42:05 +0000 (UTC)
Message-ID: <83804f7b-a2ea-4929-b6a9-b18c4a6af1df@schaufler-ca.com>
Date:   Thu, 2 Nov 2023 09:42:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: align based on pointer length in lsm_fill_user_ctx()
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
References: <20231102015337.510827-2-paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231102015337.510827-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21890 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/1/2023 6:53 PM, Paul Moore wrote:
> Using the size of a void pointer is much cleaner than
> BITS_PER_LONG / 8.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/security.c b/security/security.c
> index 86f7a1995991..a808fd5eba6d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -792,7 +792,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
>  	size_t nctx_len;
>  	int rc = 0;
>  
> -	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), BITS_PER_LONG / 8);
> +	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *));
>  	if (nctx_len > *uctx_len) {
>  		rc = -E2BIG;
>  		goto out;
