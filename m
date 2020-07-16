Return-Path: <SRS0=RuUe=A3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2265DC43457
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 20:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE0120787
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 20:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TcYH/jHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGPUfi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGPUf3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 16:35:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE9C08C5DB
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 13:35:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so11552649wmh.4
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9KKssZ/dTd5jFWuQk++quPFGpJEaxp++vXeRWFCVTYg=;
        b=TcYH/jHU1RmQBPJCKXiG0zbJbk6t8T+p4WR/fKwsA07BAUPP4VqbUfrlpPWqF+0UiM
         aslyup07dAKKGj1vxS9qXutKQzsMcEXQbXq4CTy9RwVdw9DdCJS0Ahbtc/p7cV6ngjeI
         rh6Q8XL8U+5dtOZTRfteBdf+eio7fNkRoMQr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9KKssZ/dTd5jFWuQk++quPFGpJEaxp++vXeRWFCVTYg=;
        b=WjpQLu/AflsJkYo7EDS047Nk3vvUg7QLPo8zGzZgTWkBrPgPB0VLWJD2jHoQnALD46
         X/bzMmHUKpdjCCL69X6G/0OZtPaS4JQcVTy36RDY8j6sT5ZN53C2tAWWNfCK2pk2RHKg
         FQBdbplkO5kWJ/6t+kHMtdDZG4iyIBx2NZVWA0CIU0FvC3Uc86S33YUsnus/+2f9CMp9
         4TOxKm23uEJD+e6IFOy9vl7CtVa6LHrhOEmfmeoH1mpZXPf2qv9kBYMhA5LXVCCVjH2z
         jCFVIgviNDraU+DMRs2b0/k43A5TUIW1HZQbw8ZZE6/zGy5yz4rNRXRhlNV+xRRdv1Go
         nDbw==
X-Gm-Message-State: AOAM533GreE08V8umidEnUPbhxnxWyrbd7phJl07UkY2HNugbwJJmZrP
        kz56AxCTcwZE8yTwb9EVK1ff5qrfaEztgsAURfgtAn3iQcapEUB5Gid7yY0GgcIm5PbvyzH+PPg
        vNCxNHbBPBnvjbCgwAFFwEcVH57IxftSrJqECdHcw9X7nkWi5gsDfGvSD1vUxVnuJ5N786VWL9Z
        JQEi3mQGnnIHNXnrRieHwO
X-Google-Smtp-Source: ABdhPJwP6NWxHHZE4jgbCtjpWDSnq8sR96EVizFQf4hhI6jzl9kIJSa2hoPAe1ShiSsc4DVR7x6Big==
X-Received: by 2002:a05:600c:2182:: with SMTP id e2mr5761554wme.186.1594931727116;
        Thu, 16 Jul 2020 13:35:27 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 14sm10031229wmk.19.2020.07.16.13.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 13:35:26 -0700 (PDT)
Subject: Re: [PATCH 2/4] fs: Remove FIRMWARE_PREALLOC_BUFFER from
 kernel_read_file() enums
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-3-keescook@chromium.org>
 <3fdb3c53-7471-14d8-ce6a-251d8b660b8a@broadcom.com>
 <20200710220411.GR12769@casper.infradead.org>
 <128120ca-7465-e041-7481-4c5d53f639dd@broadcom.com>
 <202007101543.912633AA73@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <9ba08503-e515-6761-63de-a3b611720b1b@broadcom.com>
Date:   Thu, 16 Jul 2020 13:35:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202007101543.912633AA73@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Kees

On 2020-07-10 3:44 p.m., Kees Cook wrote:
> On Fri, Jul 10, 2020 at 03:10:25PM -0700, Scott Branden wrote:
>>
>> On 2020-07-10 3:04 p.m., Matthew Wilcox wrote:
>>> On Fri, Jul 10, 2020 at 02:00:32PM -0700, Scott Branden wrote:
>>>>> @@ -950,8 +951,8 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>>>>>     		goto out;
>>>>>     	}
>>>>> -	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
>>>>> -		*buf = vmalloc(i_size);
>>>>> +	if (!*buf)
>>>> The assumption that *buf is always NULL when id !=
>>>> READING_FIRMWARE_PREALLOC_BUFFER doesn't appear to be correct.
>>>> I get unhandled page faults due to this change on boot.
>>> Did it give you a stack backtrace?
>> Yes, but there's no requirement that *buf need to be NULL when calling this
>> function.
>> To fix my particular crash I added the following locally:
>>
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -3989,7 +3989,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char
>> __user *, uargs, int, flags)
>>   {
>>       struct load_info info = { };
>>       loff_t size;
>> -    void *hdr;
>> +    void *hdr = NULL;
>>       int err;
>>
>>       err = may_init_module();
> Thanks for the diagnosis and fix! I haven't had time to cycle back
> around to this series yet. Hopefully soon. :)
>
In order to assist in your patchset I have combined it with my patch 
series here:
https://github.com/sbranden/linux/tree/kernel_read_file_for_kees

Please let me know if this matches your expectations for my patches or 
if there is something else I need to change.

Thanks,
Scott



