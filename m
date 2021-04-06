Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5F7C433B4
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Apr 2021 02:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D34613C5
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Apr 2021 02:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbhDFCQZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 5 Apr 2021 22:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhDFCQY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Apr 2021 22:16:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BF5C06174A;
        Mon,  5 Apr 2021 19:16:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so518516pjb.0;
        Mon, 05 Apr 2021 19:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3TmfUi913hGSu3ZvDqEVjODmv0swjr1+6VGvT6E5bKM=;
        b=t7WS9sG8PQeiSfkASPQaYoPl/uSTynldhpGbQPtB0/kEM9/0zM6PIGpoiBHzZwDcgK
         fvvJCFntmIejETB3podNbAvKPRig4PklyRQDaxpbS9yduIrUM97Zl2bawLgtFXsZKIME
         VU5WoS8YGTF+q1a4UZS5Ok7FB25I6lGoag0BwHe6tjR699psWFEk0T2t8UWwMknYgsln
         XRp7pvtjqcBUwrPkRUNODh//+VKygNwao7f2yHhSDqITZUdgSk8XzOGuoNrqUYchplsy
         wcOR1NwKXmr3oUNkypx08U8velXcvyRxR32ZPL40hLANpKTXaR7rj7xmkOgrRwaG/40/
         F0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3TmfUi913hGSu3ZvDqEVjODmv0swjr1+6VGvT6E5bKM=;
        b=IYuhtXPjY/NWDMIxnwsmWnmLVPz5OlhzDCNRcrA6aUwjv4fRUKruKaoEEXoldA/5Fy
         3w4PyMyrLq6JT3vdmP1mn/CokQYgp50xrxA7yTLXwgsFpkwJ9am8EvRQPoQWqs685Cie
         XaBtq6+CmtJEzT2+U6d5uodwplfrvcfAjp+sDPrD7kSAACdMh/mnclcGUJ5m3EISuYdG
         ZFQb9in2D3kYlw3fEVcSSnU0N0oo2CrqKWgpommiZsBlt61QpFIvX09xlAPr+li8wWhR
         qjdv8BfvhA6JogWyE6rz801uJWqNQkYBDV43hf4BBJCRMTD15NAeY2reZH497yis7Vtb
         t5BQ==
X-Gm-Message-State: AOAM530R2rcQc/NP+3NFOVISCS9h6yM5BmihV+bSXEYrGCs4Hga32+Ph
        SnU2ciUnhw2ywydyLMc+St0ni2th0kUe+g==
X-Google-Smtp-Source: ABdhPJz8qrHwRwTHzcMqT0HI5HoLf9ZzdSQAKV9+bEdXeU1rQW8QfzDQH1Ea4JJieivHFbPFmS0tbw==
X-Received: by 2002:a17:90a:cb0a:: with SMTP id z10mr691091pjt.20.1617675377179;
        Mon, 05 Apr 2021 19:16:17 -0700 (PDT)
Received: from [10.43.90.134] ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id y68sm17905608pgy.5.2021.04.05.19.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 19:16:16 -0700 (PDT)
Subject: Re: [PATCH] integrity/ima: Add declarations to init_once void
 arguments.
To:     serge@hallyn.com, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210323013318.296993-1-unclexiaole@gmail.com>
From:   Jiele Zhao <unclexiaole@gmail.com>
Message-ID: <f97e397d-5d9f-31c3-c027-d9b89ba9637a@gmail.com>
Date:   Tue, 6 Apr 2021 10:16:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
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
