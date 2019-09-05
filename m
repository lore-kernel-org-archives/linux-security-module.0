Return-Path: <SRS0=QiH2=XA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B489C43331
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Sep 2019 20:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9DD20828
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Sep 2019 20:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567715962;
	bh=RSkSn9n0VYq6sHsxkptF3DWqaIDhNkIX2gQgyw9ZrNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Rs+GV6YMofRg7IepLB6Wyr6wjakPNqXZC3jxRaE9XYYkKdWO7XnOUWSnXRF5rwc9k
	 N9XPrpp6QHE7fynNmEDkEeSCIKlkJlnj/RQq/MBMl4jXiocvaC78oFzE5CuThpj0K5
	 J9SB2GrirChWAlOoucFxkGXAB4uJM3HYExFsr9s0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391442AbfIEUjV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:39:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42753 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731823AbfIEUjV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Sep 2019 16:39:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so3879744lje.9
        for <linux-security-module@vger.kernel.org>; Thu, 05 Sep 2019 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JszmXlgx1+xgmZVB9Ngs6u7Ky/QX8naYvJJhJ3ScXns=;
        b=dUEsT8ouSuhTdLO9XeIJ7j2pUQ/Jzy9iWK7dNbuhxCeiK9q0D7pXpiEMTKij3qFmLF
         /0ePwe6D4PLTWPKkntRM1vtWtPyFUYzwKF5X1Vep8dqqrs4xqpQeioJiw+0evrb+dVxs
         mvw4lOCfYV3TKiH7AH5TB6rlYwT5QQmegELDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JszmXlgx1+xgmZVB9Ngs6u7Ky/QX8naYvJJhJ3ScXns=;
        b=q2REAMJokvE3C8M6+Y3YSjob3AgI3BvpBA7mkEJRi10kiglrlHFSvhBrnYmWHst8rU
         w4eM5zYPuGXQ4UZ8CC5sXhKoobsVqU4rJwtFiXNr9n+59fVppKGmprvRxC9yfZe8VQS3
         lqioRbMm55sGeXJrpeVWs1sU3YH+8b15sUW+Rbber1y67XZVM8Cc3RtHg7tlVzsLtQZg
         jrrjvZwN0f0/hz6mJo/xh+FCQ/quHjrWmj6ayfQ+7F4qze07k+pFjOqF3lILT1BYUvry
         o9ShTZ67ezeHLVDacVMx8X6Xo7MP5kuJ9+u8/YaanZtvVi+T2wDMzwObs3NMz5xFvgLk
         WezA==
X-Gm-Message-State: APjAAAWLLGVKRADs0cUgnnBrCV4ggLsxJM0KhR/530Pra7zLU7CWmtSz
        RPmufzMDEoT5rkATU6eE6Pw2pR0GhPI=
X-Google-Smtp-Source: APXvYqwEsnbGzJB7n9rgQTRK2gDFQdOknwBvwelg2OTVXdX698/kDXMCPfWf/NDtjm3dcktCvFH1DA==
X-Received: by 2002:a2e:9ac5:: with SMTP id p5mr3416755ljj.46.1567715958782;
        Thu, 05 Sep 2019 13:39:18 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id t1sm552279lji.101.2019.09.05.13.39.17
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 13:39:17 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id z21so3171786lfe.1
        for <linux-security-module@vger.kernel.org>; Thu, 05 Sep 2019 13:39:17 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr3791028lfp.134.1567715957179;
 Thu, 05 Sep 2019 13:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
In-Reply-To: <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Sep 2019 13:39:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
Message-ID: <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     Ray Strode <rstrode@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 5, 2019 at 11:33 AM Ray Strode <rstrode@redhat.com> wrote:
>
> Hi,
>
> On Thu, Sep 5, 2019 at 1:20 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > You've at least now answered part of the "Why", but you didn't
> > actually answer the whole "another developer" part.
> It's certainly something we've wanted in the GNOME world for a long time:
>
> See for instance
>
> https://bugzilla.redhat.com/show_bug.cgi?id=991110

That is *way* too specific to make for any kind of generic
notification mechanism.

Also, what is the security model here? Open a special character
device, and you get access to random notifications from random
sources?

That makes no sense. Do they have the same security permissions?

USB error reporting is one thing - and has completely different
security rules than some per-user key thing (or system? or namespace?
Or what?)

And why would you do a broken big-key thing in the kernel in the first
place? Why don't you just have a kernel key to indirectly encrypt
using a key and "additional user space data". The kernel should simply
not take care of insane 1MB keys.

Big keys just don't make sense for a kernel. Just use the backing
store THAT YOU HAVE TO HAVE ANYWAY. Introduce some "indirect key"
instead that is used to encrypt and authenticate the backing store.

And mix in /proc/mounts tracking, which has a namespace component and
completely different events and security model (likely "none" - since
you can always read your own /proc/mounts).

So honestly, this all just makes me go "user interfaces are hard, all
the users seem to have *completely* different requirements, and nobody
has apparently really tested this in practice".

Maybe a generic notification mechanism is sensible. But I don't see
how security issues could *possibly* be unified, and some of the
examples given (particularly "track changes to /proc/mounts") seem to
have obviously better alternatives (as in "just support poll() on
it").

All this discussion has convinced me of is that this whole thing is
half-baked and not ready even on a conceptual level.

So as far as I'm concerned, I think I want things like actual
"Tested-by:" lines from actual users, because it's not clear that this
makes sense. Gnome certainly should work as a regular user, if you
need a system daemon for it with root privileges you might as well
just do any notification entirely inside that daemon in user space.
Same goes for /proc/mounts - which as mentioned has a much more
obvious interface for waiting anyway.

User interfaces need a lot of thought and testing. They shouldn't be
ad-hoc "maybe this could work for X, Y and Z" theories.

                    Linus
