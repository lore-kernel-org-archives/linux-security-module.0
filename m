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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0380C433B4
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Apr 2021 06:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74513610CC
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Apr 2021 06:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhDFGYY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhDFGYY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 6 Apr 2021 02:24:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E9C06174A;
        Mon,  5 Apr 2021 23:24:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g35so4871873pgg.9;
        Mon, 05 Apr 2021 23:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=l/uDzRq6DsFUhfiYI+oZNj/fXUJZPWFg6dOsJiT0E6w=;
        b=LVvUnKs+q5ao/obxTpMBvRTCkoYF9gwkdwgMFhEnF/nLQ3RBnlleuqTdpYmadAWuXB
         +Y+wjtN5LcJ1z7IWlyvQ/SCxnm/21auIpUMtWwsX6oF1W/zGS6PemeqpvDd6XmTF00rj
         J/BbYa8Mz71vHWwKx6lWRrmx64DVETuJcUFDLZa1NONxsTHoMVWA/2QRn/okN5B5v+5q
         F7KwtUtxyhS15v8AC5kEU6rRm9hHV1kj4joR2OYrQ2tiGaBCcmnh+Ggl88hVOeyo/6tJ
         NMPg6jB/2sInEfAN2v+uMzH56IODXoIP3hbclWoezDTb29e8bYKUQU63YQ31qmARiPQE
         PbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=l/uDzRq6DsFUhfiYI+oZNj/fXUJZPWFg6dOsJiT0E6w=;
        b=eoPlEXIVZFGiYYCoABR8/QiYjUokqo5aXfliyfkuivczZpSTG7ag4lOnVmn7hL646l
         UUo0dR9XyGgw8ITboZUjr5FnMoJ5V8GhxOpu+6rooksPswuFTsyMvRQanfGzNcqX88CW
         dFvqQ9mzTuJANu19jLlu2NDC+Dm72l9yMHp/gpubeReMuF6eBkIxGRJUx982ohzPrNjW
         vDxXh9PRwo71TN0pux1QmTVaj+ykyPQ8wEJhRlspez2uI+cJITviLWzv3nquCGJc+74z
         fqEva1GVLH7HSQuEj/lChX3i4vwGvUslNh1v5KLnGwscWNfzhyYD/xrbe8ja3B/Pbm1E
         l6yQ==
X-Gm-Message-State: AOAM533G8CaA0VVMCbxkpNiosqL7lEfRPIZeM2UlBi1rsE47TYi5ZOMX
        AgpQh+aiofMZYzIkcUxtSfk=
X-Google-Smtp-Source: ABdhPJxi9HZ0XPzuxV2QC75l8wPGmScNlo0MZhF70Fv2IGqV5Fyy0+npjLlzXifeFbDMfxV5Top4tw==
X-Received: by 2002:a63:aa48:: with SMTP id x8mr25953594pgo.246.1617690255213;
        Mon, 05 Apr 2021 23:24:15 -0700 (PDT)
Received: from [10.43.90.134] ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id a18sm18820235pfa.18.2021.04.05.23.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 23:24:14 -0700 (PDT)
Subject: Re: [PATCH] integrity/ima: Add declarations to init_once void
 arguments.
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, james Morris <jmorris@namei.org>
References: <20210323013318.296993-1-unclexiaole@gmail.com>
 <f97e397d-5d9f-31c3-c027-d9b89ba9637a@gmail.com>
 <c6fd4033-f4bb-40d2-9bd-c3f2d92c3a2a@namei.org>
From:   Jiele Zhao <unclexiaole@gmail.com>
Message-ID: <5bb74c3e-c91c-f070-7f8b-907b148cb958@gmail.com>
Date:   Tue, 6 Apr 2021 14:24:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <c6fd4033-f4bb-40d2-9bd-c3f2d92c3a2a@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Mimi,

Please see if this is a useful suggestion.

On 2021/4/6 10:38, James Morris wrote:
> On Tue, 6 Apr 2021, Jiele Zhao wrote:
>
>> Ping.
> Mimi Zohar is the maintainer for this code.
>
>> On 2021/3/23 9:33, Jiele Zhao wrote:
>>> init_once is a callback to kmem_cache_create. The parameter
>>> type of this function is void *, so it's better to give a
>>> explicit cast here.
>>>
>>> Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>
>>> ---
>>>    security/integrity/iint.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
>>> index 1d20003243c3..5f3f2de997e1 100644
>>> --- a/security/integrity/iint.c
>>> +++ b/security/integrity/iint.c
>>> @@ -152,7 +152,7 @@ void integrity_inode_free(struct inode *inode)
>>>    
>>>    static void init_once(void *foo)
>>>    {
>>> -	struct integrity_iint_cache *iint = foo;
>>> +	struct integrity_iint_cache *iint = (struct integrity_iint_cache
>>> *)foo;
>>>    
>>>     memset(iint, 0, sizeof(*iint));
>>>     iint->ima_file_status = INTEGRITY_UNKNOWN;
