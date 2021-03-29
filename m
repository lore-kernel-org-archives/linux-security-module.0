Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3664C433C1
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Mar 2021 10:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB5961584
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Mar 2021 10:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhC2KUN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Mar 2021 06:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhC2KTo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Mar 2021 06:19:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45791C061756;
        Mon, 29 Mar 2021 03:19:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v23so4168448ple.9;
        Mon, 29 Mar 2021 03:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3TmfUi913hGSu3ZvDqEVjODmv0swjr1+6VGvT6E5bKM=;
        b=blBg1faRPY6sCJR6ifGvqEhMWndnvwGjRSGVSpn60NS7iymSH1GfJL/UFbZZUOn8+2
         UtU0mjfO3+KeBxgy28/OYPPduknbnXxt3Mxo9wM2GiZC3Mi6pr+TiEQSXcM8TmZT4BtT
         8LHAFcAQ/HQ9W5AnecPEvcBPiK4bFtDabwSAXd8QJG6QPQnYQ6AdNyggWYjbGGxGsLjs
         eDumJoKX78/0fL32UbSuxIU/XxLwBJIKIUtZDv1B8SHx3xFFzjFkQc/I8fmC/Oij63c8
         s0fnMdSdPEjpaFWcV2S7tYC9PWTEgoEYcJ+4IttMgMthTNtaftiwHE7iKZNsHk25s7xH
         GHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3TmfUi913hGSu3ZvDqEVjODmv0swjr1+6VGvT6E5bKM=;
        b=olgs3J6PuKZOQgU+ewcq7HyaN/OtRjoWk78oKQ4dxZ/MLaY2P7qdWyLmsvP89M9JWg
         n1AIFXRN+xjI6Q6ELA1T4pkqoDUtuFYAvd/IxPLp8mVqX+72dFfojLcV9XjiGP26O36C
         oc1NaumzDv9XrTxTKZlM8UsJa4WaslaLeyVoX7hM9HAfVA/LPVfpKr3pvnd0lDa8G3GN
         VJ8T54Gqk2FayAQi/96qLntvRVGoU98tQ8By8HSirmAF8PE2kexGdti/LnU+S9OSGWX9
         LTGimXlbikXsvPDP8kJp6WSBhssT8LSy8pEVUwDD2oIgQM8isSBuTEZqtco+N4hEfdtJ
         UC/Q==
X-Gm-Message-State: AOAM5328135gO5qc9Dc6TwwhxcT6GE1prB/HaB27Btd6Ywu3gnYcKsPb
        oA2dnODq4hOmjc4ohCz5rVDl9wphKopqGg==
X-Google-Smtp-Source: ABdhPJzlXACmwDqcN0NdMFWh8QPZ9ik9FcNe9QNS5Yz+NT/akmWqOh45PT55X6N44HADqijYhEQpuQ==
X-Received: by 2002:a17:902:e884:b029:e5:fece:3bb0 with SMTP id w4-20020a170902e884b02900e5fece3bb0mr28620569plg.61.1617013183614;
        Mon, 29 Mar 2021 03:19:43 -0700 (PDT)
Received: from [10.43.90.134] ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id x186sm16480450pfc.65.2021.03.29.03.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 03:19:43 -0700 (PDT)
Subject: Re: [PATCH] integrity/ima: Add declarations to init_once void
 arguments.
To:     serge@hallyn.com, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210323013318.296993-1-unclexiaole@gmail.com>
From:   Jiele Zhao <unclexiaole@gmail.com>
Message-ID: <62b05182-e46e-4ef8-e9af-6d2bd00784b9@gmail.com>
Date:   Mon, 29 Mar 2021 18:18:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323013318.296993-1-unclexiaole@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Ping.

On 2021/3/23 9:33, Jiele Zhao wrote:
> init_once is a callback to kmem_cache_create. The parameter
> type of this function is void *, so it's better to give a
> explicit cast here.
>
> Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>
> ---
>   security/integrity/iint.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 1d20003243c3..5f3f2de997e1 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -152,7 +152,7 @@ void integrity_inode_free(struct inode *inode)
>   
>   static void init_once(void *foo)
>   {
> -	struct integrity_iint_cache *iint = foo;
> +	struct integrity_iint_cache *iint = (struct integrity_iint_cache *)foo;
>   
>   	memset(iint, 0, sizeof(*iint));
>   	iint->ima_file_status = INTEGRITY_UNKNOWN;
