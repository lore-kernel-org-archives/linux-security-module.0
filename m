Return-Path: <SRS0=E2Uq=NK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E62AC2BC61
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Oct 2018 19:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6AC2081B
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Oct 2018 19:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="js+vjHyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6AC2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeJaEJj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:09:39 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34245 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeJaEJj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Oct 2018 00:09:39 -0400
Received: by mail-yw1-f65.google.com with SMTP id v199-v6so5415479ywg.1
        for <linux-security-module@vger.kernel.org>; Tue, 30 Oct 2018 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=snsTm8fAPGUfSdsnB6UIfUoFWMS1wWtbb4pqgSay4sA=;
        b=js+vjHyiVy7gKOcR4aV8aB6qbFEHm1tQBHbY/tnoGr1sJ0IsCxOkyAi588iqVgxxTD
         TmOGu3y1E6hYb+duMhWiN6w6UUykrHTIDJoGIUwZJUO/JjkT8puHgjty3vDuJLXFlBqB
         K/j7WHf8RIxqYMxXPYrBZLJd7iQ6TARKKl9ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=snsTm8fAPGUfSdsnB6UIfUoFWMS1wWtbb4pqgSay4sA=;
        b=ThUqkapOqoa3xdndgLYi8qINLUINNPeKMg2BJ1mGHfisWk+tWBqv6ZMDBRHT1L4KNm
         saWugkYgRPuouBACExpWz5gtoxOKJnFSqjMHIiXmLjlON0Vwccr/i7Lcd2VDatG7v085
         8IUT6dlHVwz2BUEWxSqEBnM077T4bB1LCdkXrBNUXYcJtLgZbGoARyeKFItYDxYtrVsi
         0+zsodbfkfVpyziK/pZ+UhxqkNtwZDZhp1tgN8ccU9gsorKePgCg6jnDulq6yRImQ7Y2
         ofHTV37XZAmtlmjwDaatK30a80lapq1x03i3W59En2qCD80Cy1Db96ROUTCdhHYXb/Wm
         mWpA==
X-Gm-Message-State: AGRZ1gIMiVcvEZxMp4fn2DOuzZMKKLdxeyHMA7g7H6XNxYhqABwPLx+A
        phvgNny10w+TRrMZxX+HkHUjWuomT8k=
X-Google-Smtp-Source: AJdET5cUooH8yhNdEYWjzsZx/v852Vq2mnhAMkpUfDNCODXpqjvP/OB4GjoHX5iMw5ktLQe/wJ7KFQ==
X-Received: by 2002:a81:4901:: with SMTP id w1-v6mr7658ywa.86.1540926894573;
        Tue, 30 Oct 2018 12:14:54 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id m82-v6sm5771676ywc.67.2018.10.30.12.14.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 12:14:52 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id l2-v6so892366ywb.9
        for <linux-security-module@vger.kernel.org>; Tue, 30 Oct 2018 12:14:52 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr3973873ywg.353.1540926891605;
 Tue, 30 Oct 2018 12:14:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 12:14:50
 -0700 (PDT)
In-Reply-To: <28C8CD2A-BDC0-49A5-854E-1E18968528B8@amacapital.net>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com> <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net> <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net> <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net> <20181030175814.GB10491@bombadil.infradead.org>
 <28C8CD2A-BDC0-49A5-854E-1E18968528B8@amacapital.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Oct 2018 12:14:50 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK583zi9NPP2hwm51z6FbF2kkr5Em61eSp3EnwYFnKZEw@mail.gmail.com>
Message-ID: <CAGXu5jK583zi9NPP2hwm51z6FbF2kkr5Em61eSp3EnwYFnKZEw@mail.gmail.com>
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 30, 2018 at 11:51 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>> On Oct 30, 2018, at 10:58 AM, Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Tue, Oct 30, 2018 at 10:06:51AM -0700, Andy Lutomirski wrote:
>>>> On Oct 30, 2018, at 9:37 AM, Kees Cook <keescook@chromium.org> wrote:
>>> I support the addition of a rare-write mechanism to the upstream kernel.
>>> And I think that there is only one sane way to implement it: using an
>>> mm_struct. That mm_struct, just like any sane mm_struct, should only
>>> differ from init_mm in that it has extra mappings in the *user* region.
>>
>> I'd like to understand this approach a little better.  In a syscall path,
>> we run with the user task's mm.  What you're proposing is that when we
>> want to modify rare data, we switch to rare_mm which contains a
>> writable mapping to all the kernel data which is rare-write.
>>
>> So the API might look something like this:
>>
>>    void *p = rare_alloc(...);    /* writable pointer */
>>    p->a = x;
>>    q = rare_protect(p);        /* read-only pointer */
>>
>> To subsequently modify q,
>>
>>    p = rare_modify(q);
>>    q->a = y;
>>    rare_protect(p);
>
> How about:
>
> rare_write(&q->a, y);
>
> Or, for big writes:
>
> rare_write_copy(&q, local_q);
>
> This avoids a whole ton of issues.  In practice, actually running with a special mm requires preemption disabled as well as some other stuff, which Nadav carefully dealt with.

This is what I had before, yes:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/write-rarely&id=9ab0cb2618ebbc51f830ceaa06b7d2182fe1a52d

It just needs the switch_mm() backend.

-- 
Kees Cook
