Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45DCC83F01
	for <linux-security-module@archiver.kernel.org>; Sat, 26 Aug 2023 14:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjHZOrz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 26 Aug 2023 10:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjHZOrv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 26 Aug 2023 10:47:51 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74682117
        for <linux-security-module@vger.kernel.org>; Sat, 26 Aug 2023 07:47:48 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-64b3ae681d1so9581996d6.0
        for <linux-security-module@vger.kernel.org>; Sat, 26 Aug 2023 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693061268; x=1693666068;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nViQWLFd9G19TwFRhrWwk6czyiLSpZ+QmjfzziUuEJM=;
        b=IZ4kCHdnNlpzxveE/XoSIDUjPL9+GjpH4qFOCqerqxTgquSkhesowbiOgxyGx2e3Rw
         ejX8Rjnoza5jU+l+u4eN+V48j4rDFGWNdoWIzw0lroTKFoBwHeMGhbAdgRi7AQN7ENv4
         03xPtG1Ah3GZWVsb9qgVvWkMLyd1O20CMK5h+kaJs3x9/yQt1+830JtEeL6RfbPk1HPJ
         4eKUEaV2CyH3d+vGt+LyVtPCPiAzOYbSqGaqNbBC1PD8mCkhL4yAq2M6kSbooY2Q/zD0
         Md2OJenVi/kDdVh+I0oP5HKLg3SMIDUZQFxb8Z/mtOoDHYdJvYEnhWPZoVdi8w+9TBvG
         zxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693061268; x=1693666068;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nViQWLFd9G19TwFRhrWwk6czyiLSpZ+QmjfzziUuEJM=;
        b=J96/CYhliJ08V+vVMl0Aki7rIkQ4aQ5fJbVBewYapWhIQmxyN7MnDvomiQqAp7Tdt4
         /cngKGInBg5sN041kSpgRRBC+TyQ9bqW9ugpHlE5fL+l4j/PJ8uyLlehHLIL9XTsshIb
         sZpPYno4CYoFBF2/hGXiI+emYP5jMySt6tbz5QAGM2VQQwm9FC9U+KyQ7sm21RSThb9i
         E+EL/79S46l/u4VItivKWF1qyY1ldk64L6Neo94u5YNAExScVrwE7APVL8U861W64zcG
         C2Tla/vBLbhixyv46EVErcv4WsPdIJBPexU5fL8QtlHlJLsx7jLT+Ski0ZrOHGmKXhel
         58lw==
X-Gm-Message-State: AOJu0Yz3oLA+Mab/E/ndQzHFWxlRLSZIEuDWOZJDLd4gjcmDFAlitxC0
        KlrDBUNU/XYQajeFJhSl5V8Z
X-Google-Smtp-Source: AGHT+IFILZuWdsRqZ8xcfYMqguqfPfxA3pbiq8v+sCn7BGUVwUxFuGx8LTC0kimYIhVaOTkyNrPg2g==
X-Received: by 2002:a0c:f8d1:0:b0:647:1993:92da with SMTP id h17-20020a0cf8d1000000b00647199392damr20279071qvo.48.1693061267840;
        Sat, 26 Aug 2023 07:47:47 -0700 (PDT)
Received: from [192.168.7.16] ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id pj47-20020a05620a1daf00b0076cddd12aa4sm1192611qkn.77.2023.08.26.07.47.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Aug 2023 07:47:47 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     <linux-audit@redhat.com>, <audit@vger.kernel.org>,
        Steve Grubb <sgrubb@redhat.com>,
        "linux-security-module" <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Aug 2023 10:47:45 -0400
Message-ID: <18a3250b668.28a4.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <6e4603ea-3ce8-5b9e-0ddf-9ec893ddd32e@I-love.SAKURA.ne.jp>
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
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
 <18a2ac400f8.28a4.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <6e4603ea-3ce8-5b9e-0ddf-9ec893ddd32e@I-love.SAKURA.ne.jp>
User-Agent: AquaMail/1.46.0 (build: 104600328)
Subject: Re: [PATCH] audit: add task history record
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On August 26, 2023 2:38:55 AM Tetsuo Handa 
<penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> On 2023/08/25 12:36, Paul Moore wrote:
>>> It is unfortunate that you continue ignoring the
>>>
>>> How can auditd generate logs that are not triggered via syscalls?
>>>
>>> line. I know how to configure syscall rules using "-S" option. But I do
>>> not know how to configure non syscall rules (such as process creation via
>>> kthread_create(), process termination due to tty hangup or OOM killer).
>>
>> At this point you've exhausted my goodwill so I would suggest simply reading
>> the audit code, manages, and experimenting with a running system to understand
>> how things work, especially for non-syscall records.
>
> Are we on the same page that non-syscall records include process creation via
> kthread_create() and process termination via send_sig() ?

I'm not confident that we are in agreement on many of the issues in this 
thread, some of that is likely due to disagreements in what functionality 
is worthwhile, but I believe some of that is due to misunderstandings.  I'm 
not going to merge the patch you posted at the start of this thread, but as 
I've mentioned *several* times now, if you find a kernel code path that is 
missing an audit logging call submit a patch with an explanation of why the 
audit call is needed and we can discuss it.

My initial thinking is that we do not need, or want, an audit call in 
kthread_create(). I'm less sure about send_sig(), and as my network access 
is limited at the moment I don't have the ability to look into it further 
right now. If you feel we do need an additional audit call, create a patch, 
test it, write a good commit description explaining why it is necessary and 
we can review it.

--
paul-moore.com
>




