Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB03C00528
	for <linux-security-module@archiver.kernel.org>; Mon, 31 Jul 2023 20:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjGaUHm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 31 Jul 2023 16:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjGaUHl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 31 Jul 2023 16:07:41 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D462EC
        for <linux-security-module@vger.kernel.org>; Mon, 31 Jul 2023 13:07:40 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63d1238c300so24438456d6.0
        for <linux-security-module@vger.kernel.org>; Mon, 31 Jul 2023 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690834059; x=1691438859;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mr0jsvWUvhK60xhRYuC+cetlUrcr4WSBsNOHSmk9+vU=;
        b=gXAc1coIwIN3PBRpnTQWF+PlcWrr/GrP0Ju8QynMdyi64D4U70xjy2963/b/rm1yUi
         Ou8ZBrdBDdyfSyMiikY0XnraaBLp+o4VJZWi8aA2hB+E9ck6DWbL3AhPE3iD9m7m+Ua4
         XiTb5hbqCmNnm5bR21cjSewo2smZEWr0VZB++f5oLJM9M1xybb90XiqCOY4/qfxxE0kf
         e1gnaCU3AfjhwkZn0bNfemuRmGupe1AUMCrJ8nLZUk5NhoLB1ucSTPekozbswQWJo7xz
         EkJDGX9IA49yTflowLelifhC5Y0B8bQMyIh4G1OtNNbJLTYq/U7mynhiZJscbKIvmj8N
         Gr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690834059; x=1691438859;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mr0jsvWUvhK60xhRYuC+cetlUrcr4WSBsNOHSmk9+vU=;
        b=Gm3hsQGD6YV/NiI90hR7OvvVV4Nh7Oj7XCZ8fRvVy8BILgsBVDWdf/XYTHqjQZhVdA
         5CFNurNHlFUJkMWFyqgaB+mLN2OO1OuS5t//TQScHhOI2fSz7zCUrcycs7kr7sORJtHD
         cNewxB1fkWiwtCLo5qPZVMRiQp+chRO0h7J1vUONWZFwtgyAc+tULGoBxW3cbsVehgZH
         43aFRVLe/9EXqSvNWuu+5nZb1c7clypjJvonsnb6DUGTdnhr5ymNHM7QPpX/g+ar996C
         19f8C8g/2FvQWJGBm4vY6tgP/GQdaIJdCqtosr3xHTIsvu2l3VYdN5kn6i8VnT8f1rI4
         EBcg==
X-Gm-Message-State: ABy/qLZ1ZFMPAQB5ndMetuM915FMqf1JDD/wmz7kwJfWcLqK5d6BSMhc
        Z/HENngJVUXVlUaUxOW87Y1kCRf+6TpOGxHLxxfe
X-Google-Smtp-Source: APBJJlE4HtjBLKJpDXwsj1fQh5ag53C2HETLUhyAStqDmHgBWzYNq+3BjOOu2a/hYQPHgkFHY7475A==
X-Received: by 2002:a05:6214:ab4:b0:63c:ec3a:ad71 with SMTP id ew20-20020a0562140ab400b0063cec3aad71mr1762770qvb.11.1690834059579;
        Mon, 31 Jul 2023 13:07:39 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id h13-20020a0cab0d000000b0063d1f967268sm4100870qvb.111.2023.07.31.13.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:07:39 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:07:38 -0400
Message-ID: <abe91475c7f9e3483405c6096006b2a9.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        ztarkhani@microsoft.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lsm: add comment block for security_sk_classify_flow LSM  hook
References: <ZMfG/w5FWqCGE4pn@gmail.com>
In-Reply-To: <ZMfG/w5FWqCGE4pn@gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Jul 31, 2023 Khadija Kamran wrote:
> 
> security_sk_classify_flow LSM hook has no comment block. Add a comment
> block with a brief description of LSM hook and its function parameters.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  security/security.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks Khadija.  I did make a small change to your patch (see below)
when merging it into the lsm/next branch.

> diff --git a/security/security.c b/security/security.c
> index d5ff7ff45b77..ffc5519e49cd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4396,6 +4396,13 @@ void security_sk_clone(const struct sock *sk, struct sock *newsk)
>  }
>  EXPORT_SYMBOL(security_sk_clone);
>  
> +/**
> + * security_sk_classify_flow() - Set a flow's secid based on socket
> + * @sk:  original socket

As has been pointed out previously, there is a double-space between
"sk:" and "original socket".

> + * @flic: target flow
> + *
> + * Set the target flow's secid to socket's secid.
> + */
>  void security_sk_classify_flow(struct sock *sk, struct flowi_common *flic)
>  {
>  	call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
> -- 
> 2.34.1

--
paul-moore.com
