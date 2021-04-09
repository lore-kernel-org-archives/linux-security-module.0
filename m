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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDDAC433ED
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Apr 2021 01:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0527D610C9
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Apr 2021 01:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhDIBUj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Apr 2021 21:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIBUj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Apr 2021 21:20:39 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7D1C061760;
        Thu,  8 Apr 2021 18:20:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h20so1945931plr.4;
        Thu, 08 Apr 2021 18:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=VUM3PU+E+VHC9ih3cbEFirpKeZTUeG/FI++7dLfr2rI=;
        b=LBar/o0BPMpBGSVMwaf8sjdjB+VB7zx4QxGrqoIIGrWJayPobFHiNr+UxXmWdddfO7
         vkF19Og4VnC9vRoY4xdzymMe4PTYTlEjqYJRNwFnN/ATk1lRTHO1tosIjAUlhVT5Ov2F
         eRwnI5RFl7uKlr1x0WptyLAK1gFgZVOyRgCU69ln/dmpSwwuC9UqXKpWEZH9KVDAVepj
         L/BGXb3Bop2ZL9T+qJzrt08odp+3GS+WZYqrsgNAdCL4OVpo6cITGGjLeApBNZ3nuPRK
         6Q0fOv4Ivas8wIDsPxIxakMZfs8AJQ9nEG6YGdcm7rpFSJqQuSYbQvxVoa88ga11ry+a
         prLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=VUM3PU+E+VHC9ih3cbEFirpKeZTUeG/FI++7dLfr2rI=;
        b=aNESa2elEI5tJOnhrOkcZ9ZsGelMnu5ZrFmqsFeghABBltRXpPQdBwvy9fUhG7kzqB
         j+XesEkBbJRG182Eb43rz5U2pO0QqiN4bgihx3CM+EHnlGN5+AdbDQSuzi+WNoCVCiHl
         VEe3g840KbOXjBwvBF5ZkHcOahpAyrtqAbQLDrTjLsAWxA44ZE3Fi58owFmYd/Fb6tpg
         mxy2Po0zGNO5lA0vlGi23TXk7QKvon+GpqqYxj7Duy9H4B9yXk1S348ssGflnoD7S+9y
         /XTks5qaeurXlokObe5+DsvTGIbuDpXKAi7CsYw/Gw+7Mtp8MhwFa2E008px38U/4rOZ
         9llQ==
X-Gm-Message-State: AOAM530+3yqbbhqJ6gYlBdv8fnnxuyVMvlKuB3Z49pz6ao0WIWOxvh5U
        EXX1eOtiTm7qBPHk8guaB7qzD4a8cZg=
X-Google-Smtp-Source: ABdhPJzzzXkuqwlDa9eZ/oJpRY5iwJJRmAbxDW/M4xaePQDIneqjUbDPBPpg29D8kETveiDmkwXrcA==
X-Received: by 2002:a17:902:748c:b029:e9:3d7e:7894 with SMTP id h12-20020a170902748cb02900e93d7e7894mr10825072pll.51.1617931226779;
        Thu, 08 Apr 2021 18:20:26 -0700 (PDT)
Received: from [10.43.90.134] ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id j188sm555313pfd.64.2021.04.08.18.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 18:20:26 -0700 (PDT)
Subject: Re: [PATCH v2] ima: Fix function name error in comment.
To:     zohar@linux.ibm.com, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210406021210.2843-1-unclexiaole@gmail.com>
From:   Jiele Zhao <unclexiaole@gmail.com>
Message-ID: <c108ff27-717b-a5a0-ce02-c617667328ac@gmail.com>
Date:   Fri, 9 Apr 2021 09:20:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406021210.2843-1-unclexiaole@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Mimi,

On 2021/4/6 10:12, Jiele Zhao wrote:
> The original function name was ima_path_check().  The policy parsing
> still supports PATH_CHECK.   Commit 9bbb6cad0173 ("ima: rename
> ima_path_check to ima_file_check") renamed the function to
> ima_file_check(), but missed modifying the function name in the
> comment.
>
> Fixes: 9bbb6cad0173 ("ima: rename ima_path_check to ima_file_check").
>
> Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>
> ---
>   security/integrity/ima/ima_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 9ef748ea829f..03bef720ab44 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -482,7 +482,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
>   }
>   
>   /**
> - * ima_path_check - based on policy, collect/store measurement.
> + * ima_file_check - based on policy, collect/store measurement.
>    * @file: pointer to the file to be measured
>    * @mask: contains MAY_READ, MAY_WRITE, MAY_EXEC or MAY_APPEND
>    *

This is the [patch v2] based on your suggestion. Does this meet the 
requirements ?


