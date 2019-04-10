Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E57C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 18:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13412077C
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 18:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YDvKeFjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfDJSUe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:20:34 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39477 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbfDJSUd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 14:20:33 -0400
Received: by mail-ua1-f66.google.com with SMTP id d5so1113978uan.6
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBTp7lh6tYXvdqLS4lszTvQkcWRmCBJ1NeQp+ZeTNdk=;
        b=YDvKeFjADNQJ2e9BS+Y/Ffh5qwINfNMMOBFUQF5XKEf0Abj8kpFMlDyWOKCbjXF+OH
         nJMlBHcPquNRHC8nZjwNnqZM+VdCuh9MSTNqZT6GFIjNAZPSa/UOavlzRT7v5DJhXBXQ
         mrV5dE9M/hxpkZkmYjPj5pEL82HkGVc3KPR+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBTp7lh6tYXvdqLS4lszTvQkcWRmCBJ1NeQp+ZeTNdk=;
        b=Z+13ip3SZNsqOei8BzkZpNwkNPwAIVvQ5waHQfEiv1zx2+p8/pFRxryCWlNywGdIfd
         IXXN2UVroogGrWMz8HrUyUpk24k/5qjI06xpNmF30GPsj2/Z0lkeHMFp7dIMh+CaQ/6k
         5Qa9NkW8H8PgS0ahqpVrz38oL8lR5aV2XvOln+tdy2cVZ0PmC5RHvAVxtOwHRDslBgL8
         HifpCbLkIqIjFf7sbsVcmECZBcfxH4U9hJrW4k1FDgNHgcv60b8nM0JNmJNdqgQOK8hs
         Q3MCZeIOgUgD8Vu+AZlYG03Zm2GjysM8MfQ3diiLZjGRV/QJAtZzqe9VvXTGD/g2pMin
         vwZQ==
X-Gm-Message-State: APjAAAUK3Ca0wFOX8c5n3QeFiV8Us3aVDLLGI+Pyn/wFwngnzfbUcfPA
        A7cRCggdbCHIGkiKCDuN4nLtCrOk1Is=
X-Google-Smtp-Source: APXvYqzB8wZQ4IUA0xJp6HbpsbYamNYLuuk/p3rbnQ3gQ08o48UhMkWouufX3zb1uQlKRYoHCQ1faQ==
X-Received: by 2002:ab0:72c2:: with SMTP id g2mr23854015uap.112.1554920431106;
        Wed, 10 Apr 2019 11:20:31 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 2sm14845891vke.27.2019.04.10.11.20.30
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 11:20:30 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id l22so1106335uao.8
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 11:20:30 -0700 (PDT)
X-Received: by 2002:ab0:154e:: with SMTP id p14mr23199085uae.48.1554920429661;
 Wed, 10 Apr 2019 11:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165605.211749-1-mortonm@chromium.org> <CAGXu5jK9tc28tsxEKOQ=R9B2AUOJ5Rt3j=VNqr1PQcAyAeNpgQ@mail.gmail.com>
 <CAG48ez0a6iyw_TCF2aY4ADbiveaAy+tZeiKjT0j7+36qC6W_og@mail.gmail.com>
In-Reply-To: <CAG48ez0a6iyw_TCF2aY4ADbiveaAy+tZeiKjT0j7+36qC6W_og@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 11:20:17 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL8YYG-jTuQkfH1kBPSdY-FamO_YobcL_rCyNKqq3NHmw@mail.gmail.com>
Message-ID: <CAGXu5jL8YYG-jTuQkfH1kBPSdY-FamO_YobcL_rCyNKqq3NHmw@mail.gmail.com>
Subject: Re: [PATCH 07/10] LSM: SafeSetID: rewrite userspace API to atomic updates
To:     Jann Horn <jannh@google.com>
Cc:     Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 10:47 AM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Apr 10, 2019 at 7:24 PM Kees Cook <keescook@chromium.org> wrote:
> > On Wed, Apr 10, 2019 at 9:56 AM Micah Morton <mortonm@chromium.org> wrote:
> > > From: Jann Horn <jannh@google.com>
> > >
> > > The current API of the SafeSetID LSM uses one write() per rule, and applies
> > > each written rule instantly. This has several downsides:
> > >
> > >  - While a policy is being loaded, once a single parent-child pair has been
> > >    loaded, the parent is restricted to that specific child, even if
> > >    subsequent rules would allow transitions to other child UIDs. This means
> > >    that during policy loading, set*uid() can randomly fail.
> > >  - To replace the policy without rebooting, it is necessary to first flush
> > >    all old rules. This creates a time window in which no constraints are
> > >    placed on the use of CAP_SETUID.
> > >  - If we want to perform sanity checks on the final policy, this requires
> > >    that the policy isn't constructed in a piecemeal fashion without telling
> > >    the kernel when it's done.
> > >
> > > Other kernel APIs - including things like the userns code and netfilter -
> > > avoid this problem by performing updates atomically. Luckily, SafeSetID
> > > hasn't landed in a stable (upstream) release yet, so maybe it's not too
> > > late to completely change the API.
> > >
> > > The new API for SafeSetID is: If you want to change the policy, open
> > > "safesetid/whitelist_policy" and write the entire policy,
> > > newline-delimited, in there.
> >
> > So the entire policy is expected to be sent in a single write() call?
> >
> > open()
> > write(policy1)
> > write(policy2)
> > close()
> >
> > means only policy2 is active?
>
> No; if you do that, the first write() sets policy1, and the second
> write() fails with -EINVAL because of the "if (*ppos != 0) return
> -EINVAL;" in safesetid_file_write() (which already exists in the
> current version of the LSM).

Ah yes, thanks! I missed that check. Good!

>
> > I thought policy was meant to be built
> > over time? i.e. new policy could get appended to existing?
>
> That's what the current API does; as I've explained in the commit
> message, I think that that's a bad idea.

Okay, sounds fine. It wasn't clear to me from the commit message if
you meant "write the whole policy during a single open/close" or
"write whole policy with a single initial write".

-- 
Kees Cook
