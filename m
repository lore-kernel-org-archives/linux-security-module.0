Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1273EC3DA6F
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Aug 2023 03:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjHYDhK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Aug 2023 23:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239912AbjHYDgt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Aug 2023 23:36:49 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3683C1FEB
        for <linux-security-module@vger.kernel.org>; Thu, 24 Aug 2023 20:36:46 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-410a2925972so2770981cf.0
        for <linux-security-module@vger.kernel.org>; Thu, 24 Aug 2023 20:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692934605; x=1693539405;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUP5xV4ps2qb19CJS7E2ogVi3bHciOLw3ERo752H6f4=;
        b=HvazmlqPdb+nH9eK8qL8CZ/87mCsMQQXvKqF8t1WviydLZTvW4zDt6H5xynl2GyGqF
         QeAUzr6bmUX2QoBssb6JICuOc0KcfeWScX1Kctc1tOGqtd2liOLjCY7bRqRhjtINow7B
         jjeRYotgIsm0IqIOs4CjZWbR03qtEI32o40ck6r5CpfKea8iky6HltGBrCRaFNilW3uE
         ZnDljAhyzoufN6/pmXvgDhutZDdsI8FlfzajfXQDlqWZNMUbbyf7bbWFf6Db7+OeQdyH
         fmbqE2VKhAOAksbbpGndGXbNpyU0sL+0lPAa/orIOiHxFFuHI2MbEEmwUfDzPYWzA8SM
         yyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692934605; x=1693539405;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUP5xV4ps2qb19CJS7E2ogVi3bHciOLw3ERo752H6f4=;
        b=DsgcP1bOozMyJEV7Ye5QQh/M+WiIkuLpXtW08HkG/8oM8Jy96OXvsDOsFOuBNynbs2
         wBnwmeFG/7Up4YhazDG8pzNmNOZLHai2Kv4X+gABD+4aGhBtw4RCmP10Mqt0sRoW9KZi
         aplNkcpjR6GFTmrvX7JG//Z8/HBJycXLTCTtbiDBTHei4IIBxdKm64hBPkZkK9YCr+Lo
         hkQX4LjbEWCfRYJkwPyWhlzPTkPd+jMCk4s5MtuRdtMX+xp9EexBLzM1GNcA60EK4zOW
         W/axLHwhNrkvYQi3JDXhmIuP+CW4wOe2Pt6BHPpty4Q0/l+xix9U0bbv/CZ4V9/545IQ
         Jftw==
X-Gm-Message-State: AOJu0YyV5OX1GT/ye4Ougfdll2/kLaOFXcSepl3ZNvbxO2WnOFa4a4hv
        hbClSU2MC+ZNe+vJODzbzMih
X-Google-Smtp-Source: AGHT+IHYNhPJ58sUIqtpETLSUxXc8N0Q61g9Y0d/9tuKjWhOTTm6XvEC6DeBRl6ENKTeyR5n3fSarA==
X-Received: by 2002:ac8:5c0c:0:b0:403:66f7:ae66 with SMTP id i12-20020ac85c0c000000b0040366f7ae66mr21103271qti.13.1692934605163;
        Thu, 24 Aug 2023 20:36:45 -0700 (PDT)
Received: from [192.168.7.16] ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id b6-20020ac87fc6000000b00410a91e9f26sm276082qtk.20.2023.08.24.20.36.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Aug 2023 20:36:44 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     <linux-audit@redhat.com>, <audit@vger.kernel.org>,
        Steve Grubb <sgrubb@redhat.com>,
        "linux-security-module" <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Aug 2023 23:36:43 -0400
Message-ID: <18a2ac400f8.28a4.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <693f623f-76dd-a709-4916-6d78fe29c9b4@I-love.SAKURA.ne.jp>
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <CAHC9VhTLQjjQ0QMfBDHYCz9LOAuO=rJWSDEUqPsFE+dowFbN=Q@mail.gmail.com>
 <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
 <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com>
 <6957af54-16a2-4c28-56ff-dafe95f4e276@I-love.SAKURA.ne.jp>
 <CAHC9VhTj-PQ0qPTiphPLXyJx3bWeqgVS_GPCWNgjqFqBgH6Njg@mail.gmail.com>
 <b0b60fdc-4484-2265-7fdf-8367bf218d18@I-love.SAKURA.ne.jp>
 <CAHC9VhRaUxN=oEyKCOrfrGzJeXDGxv2EKbZH3qwAB6AhKcSfog@mail.gmail.com>
 <68a0ef90-b452-2096-3729-b5c208878ff9@I-love.SAKURA.ne.jp>
 <CAHC9VhTPgnzdn1tmEmufcbseN_Q1CyzxTEzfvZW7OCBTeAadmA@mail.gmail.com>
 <d2557f88-0cda-b0bf-5c76-7c18912798c9@I-love.SAKURA.ne.jp>
 <CAHC9VhTZE2BinivPRLJ9S_21YcmXA6tMdDtAm5w3nk0dbZ0j1w@mail.gmail.com>
 <e9c593d9-6369-2987-ce20-5832dbebd027@I-love.SAKURA.ne.jp>
 <e56ed3a6-9d82-a181-bbc7-e322ea47cb98@I-love.SAKURA.ne.jp>
 <CAHC9VhRTVsoMWhP1+j7RcUqy2EiV=Z7W_00h55PE-WezzLg=Ew@mail.gmail.com>
 <693f623f-76dd-a709-4916-6d78fe29c9b4@I-love.SAKURA.ne.jp>
User-Agent: AquaMail/1.46.0 (build: 104600328)
Subject: Re: [PATCH] audit: add task history record
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On August 24, 2023 6:24:47 PM Tetsuo Handa 
<penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> On 2023/08/24 23:26, Paul Moore wrote:
>> On Thu, Aug 24, 2023 at 9:47 AM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>> On 2023/08/24 22:39, Tetsuo Handa wrote:
>>>>>> (1) Catch _all_ process creations (both via fork()/clone() system calls and
>>>>>>  kthread_create() from the kernel), and duplicate the history upon process
>>>>>>  creation.
>>>>>
>>>>> Create an audit filter rule to record the syscalls you are interested
>>>>> in logging.
>>>>
>>>> I can't interpret what you are talking about. Please show me using command 
>>>> line.
>>>
>>> I'm not interested in logging the syscalls just for maintaining process history
>>> information.
>>
>> That's unfortunate because I'm not interested in merging your patch
>> when we already have an audit log which can be used to trace process
>> history information.
>
> It is unfortunate that you continue ignoring the
>
>  How can auditd generate logs that are not triggered via syscalls?
>
> line. I know how to configure syscall rules using "-S" option. But I do
> not know how to configure non syscall rules (such as process creation via
> kthread_create(), process termination due to tty hangup or OOM killer).

At this point you've exhausted my goodwill so I would suggest simply 
reading the audit code, manages, and experimenting with a running system to 
understand how things work, especially for non-syscall records.

> I repeat:
>
>  The auditd is not capable of generating _all_ records needed for maintaining
>  this information.
>
>  The logs generated via system call auditing is just an example user
>  of this information.

I repeat:

If you find a place in the code where you believe there should be an audit 
record, post a patch and we can discuss it.

--
paul-moore.com



