Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F4BC4361B
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Dec 2020 20:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA71C22473
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Dec 2020 20:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388497AbgLNUzo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Dec 2020 15:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503250AbgLNUzf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Dec 2020 15:55:35 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1C0C061793
        for <linux-security-module@vger.kernel.org>; Mon, 14 Dec 2020 12:54:54 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l11so33742650lfg.0
        for <linux-security-module@vger.kernel.org>; Mon, 14 Dec 2020 12:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yjX3o6xsyCaRUXsi679rrY59nTFovxClxEsS5QsmetY=;
        b=XjtwLkAai12lTlnZPVGu410mAuM6h7pvrrsWQtnfyC+fVZDlR06SHMnbqxBQ7mlCD2
         O5QFsMoATEz1Fg1a2rba6L5kRW7vKfPSB+6Y8bNbfs6TnHzYFEiYTpk0nFnuKI8a/45V
         EP/9F3u3S9UlH8OTDO0A6KqVZinxKJN52Ny+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yjX3o6xsyCaRUXsi679rrY59nTFovxClxEsS5QsmetY=;
        b=AQhx379SLEZ3P1w1blMUL8SCY7n1nN45e01wUjq/4NPNqCYrZQYKpZjforAibUlxxe
         MLJj5kYXIVHYjmB7/aGJ+/44xv3i6bcQPmAjnhB02UbGUw5lusbHWwsc2+roav/aUexh
         +HEQmQANKcqO0RQju7JvJSj6TbgMwGhAJqSIhhRjtWOQ6f7jUMUoJ0Dmy7ygL8oU7Ft5
         47U68e+rCju7Fel1+hbkTfbzY6A6LdlXf76jK+R2at8yqpFLvK85U3PnEOqtpq1MRSC6
         dq7JWTk8gpstPdeS3KOeDXrtv+X3XcVMlBynqV04Lc2RNkx+YukHQcDe9uL8Pl7I/t71
         Q5pw==
X-Gm-Message-State: AOAM5328gA4C4V5bMo8VuS3wN2y0vTE0uBLe/y/uv55iIrY9x/PggRM6
        mUW9rD8JSqz4iJb4dWPbguFqIjdSqabH2w==
X-Google-Smtp-Source: ABdhPJztZw7UTHjIVlELgHO6YBfjbV6UbDrzASDDcWzV8RLdy7HlDYfBDZhJQtV4lvjLX8ZxCr/AAQ==
X-Received: by 2002:a05:6512:38a5:: with SMTP id o5mr6415398lft.116.1607979292929;
        Mon, 14 Dec 2020 12:54:52 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id t1sm1424229ljg.44.2020.12.14.12.54.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 12:54:52 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id o13so10539757lfr.3
        for <linux-security-module@vger.kernel.org>; Mon, 14 Dec 2020 12:54:52 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr11323303ljm.507.1607978983041;
 Mon, 14 Dec 2020 12:49:43 -0800 (PST)
MIME-Version: 1.0
References: <2659836.1607940186@warthog.procyon.org.uk>
In-Reply-To: <2659836.1607940186@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Dec 2020 12:49:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wido5stGfFtRzmW19bB1w2XQAuY8oxUtFN2ZWdk2Grq-w@mail.gmail.com>
Message-ID: <CAHk-=wido5stGfFtRzmW19bB1w2XQAuY8oxUtFN2ZWdk2Grq-w@mail.gmail.com>
Subject: Re: [GIT PULL] keys: Collected minor fixes and cleanups
To:     David Howells <dhowells@redhat.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Ben Boeckel <mathstuf@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jann Horn <jannh@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Tom Rix <trix@redhat.com>, YueHaibing <yuehaibing@huawei.com>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 14, 2020 at 2:04 AM David Howells <dhowells@redhat.com> wrote:
>
> Here's a set of minor fixes/cleanups that I've collected from various
> people for the next merge window.

This doesn't even build.

And no, that's not because of some merge error on my part. Just to
verify, I tried to build the head of what you sent me (commit
1b91ea77dfeb: "certs: Replace K{U,G}IDT_INIT() with
GLOBAL_ROOT_{U,G}ID") and it fails the same way.

  In file included from ./include/linux/cred.h:13,
                   from security/integrity/ima/ima_mok.c:12:
  security/integrity/ima/ima_mok.c: In function =E2=80=98ima_mok_init=E2=80=
=99:
  ./include/linux/key.h:292:29: warning: passing argument 7 of
=E2=80=98keyring_alloc=E2=80=99 makes pointer from integer without a cast
[-Wint-conversion]
  .. ten more lines of warnings..
  security/integrity/ima/ima_mok.c:36:26: error: too many arguments to
function =E2=80=98keyring_alloc=E2=80=99
     36 |  ima_blacklist_keyring =3D keyring_alloc(".ima_blacklist",
        |                          ^~~~~~~~~~~~~

so these "fixes" have clearly had absolutely zero testing, haven't
been in linux-next, and are completely broken.

The bug was introduced by commit 33c36b2053de ("certs: Fix blacklist
flag type confusion"), which changed the IMA code without actually
testing it.

I suspect the fix is trivial (change the "," to "|"), but I will not
be pulling this - or anything else that hasn't been in linux-next -
from you this merge window.

The pain just isn't worth it, but more importantly, you simply need to
get your workflow in order, and not send me completely untested
garbage that hasn't even been compiled.

               Linus
