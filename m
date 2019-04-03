Return-Path: <SRS0=p2Kc=SF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EBFC10F0B
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 16:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3269B2082C
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 16:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSdJ5UOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDCQ6w (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:58:52 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54277 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCQ6w (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 12:58:52 -0400
Received: by mail-it1-f195.google.com with SMTP id a190so10751560ite.4
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 09:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogdk9ExUtLQpD5MK/aZtEqmi18+bvkqA9kfI7QDSVUE=;
        b=DSdJ5UOzE/Julis2rmo8tPbOnLYPPX80BJ5j7ayd8EzO/+GmOR9nemMAuKZXWuC1u0
         RjP/LCCJTUj9/U1WuHilKVk4Ld+UN8998Ug6AB69cFuNUvUkqEXfkfIvVZvUB3z7PfLG
         nmoRpnFTewi2u3AuiBNq++qDDqEJNXugHLWOr8YplRr1NvB6xgZ3v0+dC1BjwvhogbWI
         Ep5tXZ/+UHCpyw8c9yLZqoQoJENOW/NL0ehVkTd9M+1YtZDb+hCA/MkeIYsGPd1Xd5bX
         iq9nIoeU4bja2wF1LTuJUh5K70eH/s4v/rMw9u2owGZmCmnP5z5oyQDC4depoHWCJ1Op
         kI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogdk9ExUtLQpD5MK/aZtEqmi18+bvkqA9kfI7QDSVUE=;
        b=SW9so4eR2XSoqPcWNPodo5EFexJI5i3ztL16+ZZ/C1Jeby8JfIUCos4uXOEgoUPp+I
         JhyHlJdlZbXW32qqD/YgvucopVJBgKczdsr6DBMnHOvry5xTXilNZhKOEbwFZsC9SQ9H
         MPOU1M+hUQ6VZTaZ5TpgzUpUL2MNpKkJdI8HTjj9rLX3gbPO9CPq/ow3QZKKL5Y+2cJG
         OwxoT5FujfJ2X5Dbz+srm96EdZgInXIDCQHJDbPRGyrZuFq97ccmIECurhuT/GSccJMe
         Tpm4m7bgm7v2hDLvFJgExv5CEt9/qMUvSW6dpiH7DjwETigZFwE8Zf1qa/Q82crOGlHv
         emhA==
X-Gm-Message-State: APjAAAW0giUGnvTO6ZQCuQRMsXHYe/J0TpW68qMyGIdiooC6Vr5w9RU4
        Ivux2l7GnhsgebpoksVLh5PRuomMQsOrBezNyU9g5w==
X-Google-Smtp-Source: APXvYqwYHZp+bJO5PV8wSVwb1JOPx40NWP3a1TjcwEch7iPyJDXRHgPQt0eDpjZv9TmjgCqZziWOCdO7AVAfISjgbHA=
X-Received: by 2002:a24:7294:: with SMTP id x142mr1115617itc.7.1554310731305;
 Wed, 03 Apr 2019 09:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com> <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com> <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com> <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
 <1553167318.4899.382.camel@linux.ibm.com> <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
 <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
 <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru> <1553793463.8711.26.camel@linux.ibm.com>
 <92718382-8669-748f-10d8-02fa21225210@omprussia.ru> <1553857187.9420.49.camel@linux.ibm.com>
 <b5a89692-4c93-80b3-37e5-41265765cdc3@tycho.nsa.gov> <cb46d5ba-30de-664f-67d4-646da4592a6f@omprussia.ru>
 <CACdnJusPpis1JJgfNOrQoqPcVk0q2OGbosrXOVtZmG0cSqkotw@mail.gmail.com> <11fcd3b2-afb9-74d2-100d-449df61433d1@omprussia.ru>
In-Reply-To: <11fcd3b2-afb9-74d2-100d-449df61433d1@omprussia.ru>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 3 Apr 2019 09:58:40 -0700
Message-ID: <CACdnJusgwpcSxzwNEieqsa54_3cTYMEfuXpAeP0cW81TQ29E+w@mail.gmail.com>
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 3, 2019 at 2:59 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:
>
> On 03.04.2019 1:31, Matthew Garrett wrote:
> > Remember that many interpreted languages allow execution of code
> > provided to them on the command line (eg, python -c) and also grant
> > access to arbitrary syscalls, so there's still no guarantee that
> > you're only executing trusted code.
>
> Yes. But in some installations you can get rid of interpreters at all or limit
> the number of scripts they can open. For example you can require that all
> scripts have to be signed.

No, that's my point - if you're able to pass code directly to the
interpreter then you're not protected by file signatures. python -c
'print("hello")' will execute without the user-provided code touching
IMA.

> And having this feature as a per-process you could still limit the attack
> surface by restricting e.g. network services as they are constantly attacked.
>
> So are you saying that this feature doesn't worth to make it?

I'm saying that before adding more security code you should describe
the attack that you're actually trying to prevent. What you're doing
prevents applications from opening a file read-only and then
mprotect()ing it to being executable without IMA noticing, but what
attack are you actually protecting against as a result? You block one
avenue of obtaining code execution that isn't measured by IMA, but
there are many more. Most (but not all) are blocked by requiring that
all files be signed, but if all files are signed we don't need to
change the behaviour here - opening the file read-only will be enough
to trigger an appraisal.
