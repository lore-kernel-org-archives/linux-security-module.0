Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C416FC433ED
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Apr 2021 15:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F9361006
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Apr 2021 15:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbhD1Phk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 28 Apr 2021 11:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240344AbhD1PhX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619624197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pG5pwOUgg892glFsUccSS4Ot1zsI7mcT+KpkcWM44lQ=;
        b=SohgRZU0rNTanpN9U2JOiSPyASSpl4F/ov9BWdYpNMuVAlNq4WTCXC4y6FggjNeJuo+jfE
        gmr5YgnqgH4cBAbCdrwh/kOzygcWsf6pfqWhntVnMe1xvP8i5PXoHqGXwlmFt1u73L7SCl
        97NqXwG2mQ3x43NuoN2WCUS09BXTDT4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-Uc7eCMBVPqW4Ubtg2MxzbQ-1; Wed, 28 Apr 2021 11:36:31 -0400
X-MC-Unique: Uc7eCMBVPqW4Ubtg2MxzbQ-1
Received: by mail-qk1-f199.google.com with SMTP id y9-20020ae9f4090000b02902e4caf24229so5149389qkl.4
        for <linux-security-module@vger.kernel.org>; Wed, 28 Apr 2021 08:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pG5pwOUgg892glFsUccSS4Ot1zsI7mcT+KpkcWM44lQ=;
        b=HXKKl2GZ+4cPxZ7uIRHFZIBsYjQSIaXXLiJIjeJtndqp8bp/nma7bsL3hl73MYSUWw
         fwKAC8+F7a//5NsmNV7ybHAfA1gyHB5yiA6mhoqRarwVBSbGw1dEPf/H6H0gwu+qGiuS
         0DTkIGXlMlnbRIvwbs39PYqyAY75Jns60iYrVymAcvLTLGRTNtNvmflHiq9NDAzPUas0
         fSNnJHLcI9uX6YHQCLG+EL9kn+BADs9C4chxh0woy3eMsgolzH94C/qqrMajaB3vhUJH
         9UKuTMQIvwqv0ZWDoJ21xnUnaFGjwf7BPdU8fRPLqnwSu88gDGSC/wnXW4AcIcRuf0OD
         oZ6A==
X-Gm-Message-State: AOAM532AzV5d9tPaQVQPkaDjf3AfyK4JdW6k1f8xLCel1MAJdwcwbiGn
        OjFcXAMYtcGmrexrj+dUq7yL+XPs7b36IKRytnM3CHmiVeEgFKPifNlGpQT12uxkv+QgEt38tnr
        A0L8styKJeipJvARprxylPcpzz9TOgVMB/C46
X-Received: by 2002:a37:5f41:: with SMTP id t62mr29451306qkb.458.1619624190593;
        Wed, 28 Apr 2021 08:36:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+naGLpqAAopTlTZbQTPCAVHulsI7tDqz+zkw7UWnc7YVzu6jS0fCGmeR9jCcwK9+IV75HsA==
X-Received: by 2002:a37:5f41:: with SMTP id t62mr29451285qkb.458.1619624190406;
        Wed, 28 Apr 2021 08:36:30 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e15sm21640qkm.129.2021.04.28.08.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 08:36:29 -0700 (PDT)
Subject: Re: [PATCH] samples/landlock: fix path_list memory leak
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210427183755.2790654-1-trix@redhat.com>
 <CAKwvOdmj5YvWZZWwcq1G7JgRALwPbqwiROiedMeEbBst2sGeiQ@mail.gmail.com>
 <6108e69b-0470-cd71-e477-ba64641cbf58@digikod.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4ece80d4-16fe-1938-7eba-2046840881f6@redhat.com>
Date:   Wed, 28 Apr 2021 08:36:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6108e69b-0470-cd71-e477-ba64641cbf58@digikod.net>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 4/28/21 2:58 AM, Mickaël Salaün wrote:
> On 27/04/2021 21:13, Nick Desaulniers wrote:
>> On Tue, Apr 27, 2021 at 11:38 AM <trix@redhat.com> wrote:
>>> From: Tom Rix <trix@redhat.com>
>>>
>>> Clang static analysis reports this error
>>>
>>> sandboxer.c:134:8: warning: Potential leak of memory
>>>    pointed to by 'path_list'
>>>          ret = 0;
>>>                ^
>>> path_list is allocated in parse_path() but never freed.
>>>
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>> ---
>>>   samples/landlock/sandboxer.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
>>> index 7a15910d2171..4629d011ed61 100644
>>> --- a/samples/landlock/sandboxer.c
>>> +++ b/samples/landlock/sandboxer.c
>>> @@ -134,6 +134,8 @@ static int populate_ruleset(
>>>          ret = 0;
>>>
>>>   out_free_name:
>>> +       if (path_list)
>>> +               free(path_list);
>> I don't think the conditional is even necessary? By our first `goto
>> out_free_name;`, `parse_path` has already been called/memory for
>> `path_list` has already been allocated. `parse_path` doesn't check
>> whether `malloc` has failed.
> Indeed, no need for the path_list check. In practice, this memory leak
> doesn't stay long because of the execve, but I missed this free anyway.
> Thanks!

Ok, the general problem of not checking if malloc and friends succeeds 
is a different problem.

So remove the check and keep the free ?

Tom

> Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>
>
>>>          free(env_path_name);
>>>          return ret;
>>>   }
>>> --
>>> 2.26.3
>>>
>>

