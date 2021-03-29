Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EE2C433F1
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Mar 2021 09:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48D4619DB
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Mar 2021 09:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhC2JEv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Mar 2021 05:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236105AbhC2JA5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Mar 2021 05:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617008454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrgmkciYonWeIgpgOtEXpl2RAqGvW2vNKHn+OAB2AZo=;
        b=hArpFS4vDA81KnpS6cQq5FgKneRn/1EDfuT7jwVF6YHP2CTh3EXMOyTACxBMllhqHhomz0
        b4lNdwZqK3YCPKyhV7YD1k51aM23O3yN0QDc1FSPqf318TA4hEIN1GkAKLhZ2V0iOrA2Bb
        kMr5SVvbJZHff17sdUalkPBEC7F4XMY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-M1XM4nzoNN67FsiO7UhlEQ-1; Mon, 29 Mar 2021 05:00:53 -0400
X-MC-Unique: M1XM4nzoNN67FsiO7UhlEQ-1
Received: by mail-yb1-f197.google.com with SMTP id d1so3301976ybj.15
        for <linux-security-module@vger.kernel.org>; Mon, 29 Mar 2021 02:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrgmkciYonWeIgpgOtEXpl2RAqGvW2vNKHn+OAB2AZo=;
        b=GeIyZ/l7OiArouc/3EdTFMyIBPAWQQr8b+BmM3GSm5WHQVt1fSb1A5ArWnB/vfmwCa
         TsRCFatBRnhqdkzhSYNd3DHfTEbT18NDOBWRe6UKkG/i3m8PNAhh5og2aDk+P4C6jdQN
         BzeEQ4T0LyF7RsTTzaTjuylgxrJC3KdopTSviAUvOQ0uqalW5QTu8sumVZYZOZY6WayW
         gaYnmAwhkHKUJ2vN52MSYLqPt1VhGDMRk/Ex9uRhmMggN5yjUAPKo4dlYLQRqF+pYN30
         aYAqwweXWOId1M8kA0OhWREoPFqTp6cKqojY/DPaiVVaXREhvI63rLO64Sg5H+ARAbm2
         lWtw==
X-Gm-Message-State: AOAM530wGbcccDQMHhmwVkLBEJd9YdcjTzRkCeUntcRjg5Q+wAlr+mL6
        IuxoBnB12qOtNIsGZTfSP0cRFzyPOXrU19X2v346ZvD30tcVclKIAW78lcIwzgvk6KABPSB+4Sy
        XsDMJMTrj2/wJfK+kVj/Gw8g1tci+pzZfnhzQMk4riQnAy+yqq1nA
X-Received: by 2002:a05:6902:100b:: with SMTP id w11mr37538243ybt.436.1617008452468;
        Mon, 29 Mar 2021 02:00:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOZPGnzpufs7d77ci1gXJQAUYaCR92BNk3LQXbgblDCjpbC0xVlSZTGjPKKZDZaWSaAHgVnEfYZrlpRpNdztg=
X-Received: by 2002:a05:6902:100b:: with SMTP id w11mr37538217ybt.436.1617008452252;
 Mon, 29 Mar 2021 02:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210316144823.2188946-1-omosnace@redhat.com> <CAHC9VhRoTjimpKrrQ5f04SE7AOcGv6p5iBgSnoSRgtiUP47rRg@mail.gmail.com>
 <YFEAD9UClhwxErgj@zeniv-ca.linux.org.uk> <CAFqZXNukusUPp+kO7vxPZBt5ehkpH6EUZ5e8XwUq9adOQHdMkQ@mail.gmail.com>
In-Reply-To: <CAFqZXNukusUPp+kO7vxPZBt5ehkpH6EUZ5e8XwUq9adOQHdMkQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 29 Mar 2021 11:00:39 +0200
Message-ID: <CAFqZXNtBrGVrjXAbrn30QSMFP4Gc99fRK23hMujxYu_otzu0yA@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: fix fsconfig(2) LSM mount option handling for btrfs
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Paul Moore <paul@paul-moore.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 18, 2021 at 10:42 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Mar 16, 2021 at 8:25 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Tue, Mar 16, 2021 at 02:21:45PM -0400, Paul Moore wrote:
> > > On Tue, Mar 16, 2021 at 10:48 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > When SELinux security options are passed to btrfs via fsconfig(2) rather
> > > > than via mount(2), the operation aborts with an error. What happens is
> > > > roughly this sequence:
> > > >
> > > > 1. vfs_parse_fs_param() eats away the LSM options and parses them into
> > > >    fc->security.
> > > > 2. legacy_get_tree() finds nothing in ctx->legacy_data, passes this
> > > >    nothing to btrfs.
> > > > [here btrfs calls another layer of vfs_kern_mount(), but let's ignore
> > > >  that for simplicity]
> >
> > Let's not.  This is where the root of the problem actually lies.  Take a look
> > at that sucker:
> >
> >         struct fs_context *fc;
> >         struct vfsmount *mnt;
> >         int ret = 0;
> >
> >         if (!type)
> >                 return ERR_PTR(-EINVAL);
> >
> >         fc = fs_context_for_mount(type, flags);
> >         if (IS_ERR(fc))
> >                 return ERR_CAST(fc);
> >
> >         if (name)
> >                 ret = vfs_parse_fs_string(fc, "source",
> >                                           name, strlen(name));
> >         if (!ret)
> >                 ret = parse_monolithic_mount_data(fc, data);
> >         if (!ret)
> >                 mnt = fc_mount(fc);
> >         else
> >                 mnt = ERR_PTR(ret);
> >
> >         put_fs_context(fc);
> >         return mnt;
> >
> > That's where the problem comes - you've lost the original context's ->security.
> > Note that there's such thing as security_fs_context_dup(), so you can bloody
> > well either
> >         * provide a variant of vfs_kern_mount() that would take 'base' fc to
> > pick security options from or
> >         * do all options parsing on btrfs fc and then do fs_context_for_mount +
> > security_fs_context_dup + copy (parsed) options to whatever private data you
> > use for btrfs_root context + fc_mount + put_fs_context yourself.
> >
> > My preference would be the latter, but I have *not* looked at btrfs mount options
> > handling in any details.
>
> Ack, I'll look into that. I didn't dare to try to touch btrfs mount
> handling (if it was straightforward, someone would've already done it,
> right? :), but it sounds like converting just this one
> vfs_kern_mount() could be relatively easy, would fix the bug, and
> would be an incremental improvement.

After taking a closer look, it seems this won't actually work... The
problem is that since btrfs still uses the legacy mount API, it has no
way to get to fs_context in btrfs_mount() and thus both of your
suggestions aren't really workable (again, without converting btrfs at
least partially to the new API)...

So unless you have other ideas, I'd like to put the original patch
back on the table. Note that the change can be reverted as soon as
btrfs is ported to the fs_context API properly, it's not something
that would need to stick around forever.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

