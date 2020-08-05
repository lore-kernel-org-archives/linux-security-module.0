Return-Path: <SRS0=iE4T=BP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97322C433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Aug 2020 17:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD1F2177B
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Aug 2020 17:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="PoP10f4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgHERXR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbgHERTs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Aug 2020 13:19:48 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111CDC06174A
        for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2020 10:19:48 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m20so23626117eds.2
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2020 10:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ggWm0T5pBn7JnigTAPRbmUTfRdvzxQl+mpQ72rR0fUs=;
        b=PoP10f4tjqT5dS5d/uwUo+sqOTBfpYa07l9Dp61aeW+rv082Wx5BtKN+1bCLsTJF1U
         nUbzGtQNIwu2lxwjJRDipJ2qANYW9dxqDIcqBjZ++7ZQUP3W/BTxTY/e3PVATg5z5PlD
         fovDZooeuStLnEv4MVI4Zsu2xoFIEnyOrC3BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggWm0T5pBn7JnigTAPRbmUTfRdvzxQl+mpQ72rR0fUs=;
        b=imzwmZnkdHSYYwf4zkOZTNyibZ9eXpfmJOreSss3gPF4tgSoCLDUfLaJVVsgJ91nKx
         enz7KpQYVfYz1+CEPHbI0wLP/HEwSco2f6ed9NMVdTyKRRUtyxmuhs8+li5bS35oGDTX
         1qaUafZXdru9sAXWVHs5csrpQcEOr1fGtGHRGsV8OnFqzE2hLjWunNrTxksUzLu4IAoK
         pERrjkS7gZiVzACsTChzFbYTs2dNkDY3O4zdj8m8s8uWl8cYUwwFXpfpgQoZrZLupILg
         XtKs5MG4vQskTw3+5OdIF7PYfV7zNzdyYpb0D5lMGVMZ+w/qElmbDDBldi6K/YqTDAQ3
         ODfQ==
X-Gm-Message-State: AOAM532OwqhEv2xFeXSn96V4BciKpKqW/NfgoCYXxMkeThISgBDPgodT
        6blWk39X1ujTmkWzKzzFUhAWvMf3V1ePzb5P5R4nAg==
X-Google-Smtp-Source: ABdhPJxDf4TG2ZDbOcy/ueJc/nhD6cuCUKJp/4SEeu6p3T512+TCDX0Q15WYk1mR9VBwMmf6ImGgphnQt/h+li9HEKQ=
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr288635edx.358.1596647986830;
 Wed, 05 Aug 2020 10:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646185371.1784947.14555585307218856883.stgit@warthog.procyon.org.uk>
 <20200804133817.GD32719@miu.piliscsaba.redhat.com> <2316806.1596641851@warthog.procyon.org.uk>
In-Reply-To: <2316806.1596641851@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 19:19:35 +0200
Message-ID: <CAJfpegvZqZBFb2--W315CXX40F=jLNxYK1EpVRRnn8crGUuLDw@mail.gmail.com>
Subject: Re: [PATCH 08/18] fsinfo: Allow mount topology and propagation info
 to be retrieved [ver #21]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 5, 2020 at 5:37 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > +   __u32   shared_group_id;        /* Shared: mount group ID */
> > > +   __u32   dependent_source_id;    /* Dependent: source mount group ID */
> > > +   __u32   dependent_clone_of_id;  /* Dependent: ID of mount this was cloned from */
> >
> > Another set of ID's that are currently 32bit *internally* but that doesn't
> > mean they will always be 32 bit.
> >
> > And that last one (apart from "slave" being obfuscated)
>
> I had "slave" in there.  It got objected to.  See
> Documentation/process/coding-style.rst section 4.
>
> > is simply incorrect.  It has nothing to do with cloning.  It's the "ID of
> > the closest peer group in the propagation chain that has a representative
> > mount in the current root".
>
> You appear to be in disagreement with others that I've asked.

Read the code.

Thanks,
Miklos
