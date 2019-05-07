Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342DBC004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DCC20578
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DTLwFHNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfEGPCX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 11:02:23 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44827 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfEGPCX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 11:02:23 -0400
Received: by mail-yw1-f65.google.com with SMTP id j4so13446113ywk.11
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2019 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ziQeB12I9bka7R/oRXnmgk2P78BgzO5WFOB34fWpTdo=;
        b=DTLwFHNhrcOq1eXo+Uw41iLaNfhEKRMOibFVdwmokqQ0rDa5mePHDFLU5WN7VQnRly
         TX3n7S2Kw49irWtn0oUvggMrfZ2PMEwL5BQmJvMF+v+6+AtNN7WiphKFH9/jSuZ8DvrC
         +bI218O1ZkmNYA/tnWy7ticiQlsnTd1AoADC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziQeB12I9bka7R/oRXnmgk2P78BgzO5WFOB34fWpTdo=;
        b=beFtqEg8BvtZCdI0td+L5LX72km46U/EprdqNX7YS3mzusHICn5rXsFPkiCw+Dydj/
         ubxr03hKgIT2Dj9PU/FoNoifx0Emt+xrZX6DOeJieltVCAhNV761W4LSJFxX1S5NJ1HC
         5d2UMl9uPLmGQ5a40lRsKmFO7SghbyCd1aqyN3FUhohMih0j5q5ItxqZv6DNsmAwk44u
         Og3aoQF1k/bVVoOoRvHFYWOVi22Bembeh4bUviLMwDVPOMpgSjSl7tC9pPWRKzYiSfOH
         mZhYFdvTUJAUPJr+7MaBZJsPZHEi9dpwBayfe/QZ2KkxT6XgdP7zvFANWT1Asx/rLLxf
         oCnA==
X-Gm-Message-State: APjAAAWvYebkrOcTe/41duVsb7u13uMAWmsFJOejl8M8RZjFhRyFaYqi
        4ikhOKaCcjS4AfqbBLG3qoYj2QkzZtaVVuBRl5VbqQ==
X-Google-Smtp-Source: APXvYqwGkUCZeYdDlZf5ELYZRc/mYdCyVct5nm8Iqd/dhUDK+bGv6+D7forubBHFb2XQpuuvF67sBUgr1inmC1UUI0E=
X-Received: by 2002:a25:14c1:: with SMTP id 184mr12021885ybu.17.1557241342621;
 Tue, 07 May 2019 08:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165605.211749-1-mortonm@chromium.org> <CAGXu5jK9tc28tsxEKOQ=R9B2AUOJ5Rt3j=VNqr1PQcAyAeNpgQ@mail.gmail.com>
 <CAG48ez0a6iyw_TCF2aY4ADbiveaAy+tZeiKjT0j7+36qC6W_og@mail.gmail.com> <CAGXu5jL8YYG-jTuQkfH1kBPSdY-FamO_YobcL_rCyNKqq3NHmw@mail.gmail.com>
In-Reply-To: <CAGXu5jL8YYG-jTuQkfH1kBPSdY-FamO_YobcL_rCyNKqq3NHmw@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 7 May 2019 08:02:11 -0700
Message-ID: <CAJ-EccPNKfGWBwR8kL6zW4i=Sn+FbTJMNOoHx=0=mve9QGJFSQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] LSM: SafeSetID: rewrite userspace API to atomic updates
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Ready for merge.

On Wed, Apr 10, 2019 at 11:20 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 10, 2019 at 10:47 AM Jann Horn <jannh@google.com> wrote:
> >
> > On Wed, Apr 10, 2019 at 7:24 PM Kees Cook <keescook@chromium.org> wrote:
> > > On Wed, Apr 10, 2019 at 9:56 AM Micah Morton <mortonm@chromium.org> wrote:
> > > > From: Jann Horn <jannh@google.com>
> > > >
> > > > The current API of the SafeSetID LSM uses one write() per rule, and applies
> > > > each written rule instantly. This has several downsides:
> > > >
> > > >  - While a policy is being loaded, once a single parent-child pair has been
> > > >    loaded, the parent is restricted to that specific child, even if
> > > >    subsequent rules would allow transitions to other child UIDs. This means
> > > >    that during policy loading, set*uid() can randomly fail.
> > > >  - To replace the policy without rebooting, it is necessary to first flush
> > > >    all old rules. This creates a time window in which no constraints are
> > > >    placed on the use of CAP_SETUID.
> > > >  - If we want to perform sanity checks on the final policy, this requires
> > > >    that the policy isn't constructed in a piecemeal fashion without telling
> > > >    the kernel when it's done.
> > > >
> > > > Other kernel APIs - including things like the userns code and netfilter -
> > > > avoid this problem by performing updates atomically. Luckily, SafeSetID
> > > > hasn't landed in a stable (upstream) release yet, so maybe it's not too
> > > > late to completely change the API.
> > > >
> > > > The new API for SafeSetID is: If you want to change the policy, open
> > > > "safesetid/whitelist_policy" and write the entire policy,
> > > > newline-delimited, in there.
> > >
> > > So the entire policy is expected to be sent in a single write() call?
> > >
> > > open()
> > > write(policy1)
> > > write(policy2)
> > > close()
> > >
> > > means only policy2 is active?
> >
> > No; if you do that, the first write() sets policy1, and the second
> > write() fails with -EINVAL because of the "if (*ppos != 0) return
> > -EINVAL;" in safesetid_file_write() (which already exists in the
> > current version of the LSM).
>
> Ah yes, thanks! I missed that check. Good!
>
> >
> > > I thought policy was meant to be built
> > > over time? i.e. new policy could get appended to existing?
> >
> > That's what the current API does; as I've explained in the commit
> > message, I think that that's a bad idea.
>
> Okay, sounds fine. It wasn't clear to me from the commit message if
> you meant "write the whole policy during a single open/close" or
> "write whole policy with a single initial write".
>
> --
> Kees Cook
