Return-Path: <SRS0=0itc=OV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A4FC65BAF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 17:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D5F20839
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 17:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ox8TyBUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D5F20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeLLRe1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:34:27 -0500
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:44259 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727922AbeLLRe1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Dec 2018 12:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544636065; bh=NkE51u+J31z5wQUFfLisvFIJepdGzuLMjJ4ZdEBeUTQ=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=Ox8TyBUHiQ3kpBux2agj8GZ0/8l1Rmy9ezfL+UMvrwYf2vdA76c2LMISCabERwx9vNorrdUD9zWlTYwjGJmUjgxOAqsqp+wZH8fL57BCnIYo4VazoIOD+rzQ8A8qqiGxfDNE+olMiJNybhBD74FV7h2x+/0jcW38aPUfBCPEyCP8fQMiq+JnLW8mOZRJKPa7/MBeceiVoe7rnarFROfhyHclCIPnuphjvFPUNMQt6HQrr2o+1VthSAjoQCqfsFtHKd/IKbkccIhQao0rLQIV7gveJJbcdhX1Oy+nEnP+rnKU5f5Kyp596DfHywCFOtDA08S9gcfjRxDWTPu/Wljb6A==
X-YMail-OSG: l0YrHmcVM1lDlRQFBfP0RtncbZXtkp9uxwRurlrbjFgPvyJfVpZEUMwZWZZ1HnR
 2HXI0yq0wKIVbjkI0uOTYXNLhXW3ebvu2I6qz.QNIejptoYKZhRm5k_wQ_g7ZrmlbIMS3O_WiZh8
 BTeZKmurEAryhmjzOXPX23gZxf7oUnYJTEgs.QGbHFdbTNTtRPxFrdF4E1PCQrboXs7CHxnfF2tX
 hj9eh_T.V16Rk2Q3_Ys8BWZSVNuqlR7ef8bloErTwtA8ekpbRsfmyG61.hCmXTKIvJ7gJ8HDTrw6
 wJsGJpJ2Mr.pbVtinkJGCYpKGbzgy3HOBbYFP1GlJCiLubPKzyA.u1Gshpr3xmZEACLNsW6whKjT
 mmsCjDvKNATywSdn5Ll8H64c.m7aB1kAxjTBRoLVGe4tWvhyaMmQng6bsE0DEj6zYA_V_GDiYnZf
 hOpK2_8UW3J9sw0FXrXCeiA3ke_6msLojY8QMUXTh.UynGQdCkqoGBa8Sx6NIon2kc3pzg1YFw23
 ypTM6HJWh7vLg6HeKpHmf5hdmScMN4Q70vDPxidz_qeHWUaOnv4XtIRx8eW92IUMjMqVErOuCc4w
 vxoiryazFLkFETk.QfrAa9u3zU2VG5c31z.Uee9dtEcLXvGN_ofXyhERzyYoaKSKVelX2cbvUy5o
 zefdPoFjsn4RXYNIlHo6_qHEsJ_SNI3zEHLpQlPcLHT1jWRjzu3OeseAN290qk32KEs2uUckR_Hh
 ET2.4aPNGgttnjcUt_WyE60ORqxtGRut72UQuBeJCZYQ4Em7xE7T6l8o8X..34FUDDSPSjATZVCU
 QQlA_HOC0Y5EaJOC5KFmY8fwFU71.V3.xKkjuRISthCnoI.aAivuDaOB65_r2wfiHipDPtDUzpvx
 ctJN.U.Nd0xktCgQHf36rHJx.bziVSjTSY6qsd7n4c40zn.OTWWmdMw50UKQwzzKAiZwc63UOMGs
 M65dmzjeX8DD3jlIoeEpY4FsVvoGTc3Vy9cpoQmCHRBHgVH1RClu4gnpMJhVEH.iC6wZQzs.zE99
 0F.y1LDoMG_Jj5UR6ZuMxzlFN4Ujp5c4z0uFw81RxCVuUef0EBl8VMpTWgMcLSgHvXmYw4tSNyuI
 Ai.WgQR_TV0Jl
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Wed, 12 Dec 2018 17:34:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7639969d1096d06efbd9e6596e1933a0;
          Wed, 12 Dec 2018 17:34:21 +0000 (UTC)
Subject: Re: [PATCH] Smack: Improve documentation
To:     =?UTF-8?Q?Jos=c3=a9_Bollo?= <jobol@nonadev.net>,
        linux-security-module@vger.kernel.org
References: <20181212182657.45205ad1@d-jobol.iot.bzh>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <69df7223-b0c8-e0fa-bfea-ffc0417fed18@schaufler-ca.com>
Date:   Wed, 12 Dec 2018 09:34:19 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181212182657.45205ad1@d-jobol.iot.bzh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 12/12/2018 9:26 AM, José Bollo wrote:
> Add some words about the mount option "smackfstransmute=label".
>
> Signed-off-by: José Bollo <jobol@nonadev.net>

Thank you. I'll take this.

> ---
>  Documentation/admin-guide/LSM/Smack.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/admin-guide/LSM/Smack.rst
> b/Documentation/admin-guide/LSM/Smack.rst index
> 6a5826a13aea..2d5e3e79d190 100644 ---
> a/Documentation/admin-guide/LSM/Smack.rst +++
> b/Documentation/admin-guide/LSM/Smack.rst @@ -818,6 +818,10 @@ Smack
> supports some mount options: specifies a label to which all labels set
> on the filesystem must have read access. Not yet enforced.
>  
> +  smackfstransmute=label:
> +        behaves exactly like smackfsroot except that it also
> +        set the transmuting flag on the root of the mount
> +
>  These mount options apply to all file system types.
>  
>  Smack auditing

