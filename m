Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75537C4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Nov 2022 09:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiKCJFf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKCJFe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Nov 2022 05:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4006AD2D0
        for <linux-security-module@vger.kernel.org>; Thu,  3 Nov 2022 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667466281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zDq35n6R89I+Aaea6Q0FlPepC7iWCing+SCmG3mC5oY=;
        b=hEKpCOqYnZ6dTdJ3yyTUDB76r7dGk6VjlXIX72bjbVzWqmHOZtMq9jip5kqiAj4eF8VHSY
        jlEjFNKOmM3uU2KjHqzvDtRhcZmi29fq3iIk9VPiOnrzB0SOyXikG/6wi8wFtyiOCkKyiS
        G6SgtNtzf+RgXGzHVld07OQ/swf4T2g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-167-c7uEV1inNMySgni0-c_jeg-1; Thu, 03 Nov 2022 05:04:39 -0400
X-MC-Unique: c7uEV1inNMySgni0-c_jeg-1
Received: by mail-pg1-f200.google.com with SMTP id x16-20020a63b210000000b0045f5c1e18d0so667936pge.0
        for <linux-security-module@vger.kernel.org>; Thu, 03 Nov 2022 02:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDq35n6R89I+Aaea6Q0FlPepC7iWCing+SCmG3mC5oY=;
        b=PfsUlRS5zZi9GUZ1lmHydGt4MSFYbfopvBPZIIuuNixTufIh1yDzwUCx8hoFAJPT0s
         JInuiFQfljq1cMQDeOfG4Nys3xhNpjn9bPJI127R5B/Wl5iVuyrwEGDDFOhbyd9+uUYA
         plz0iBxtGQc//NzA/6xtoZ8LCMZ51UNkfKUapfz5Brgoq9X/bFjBqcJSEXMJMOP07+zf
         amOq++mp4khfYeX1M5yIMWQnnYEoC9ZNeBLbNiwFN5f4tIGKfnL/0gseJU8txbQiIbXq
         6GiNMLFxffT9JMwOH0a8HLZghZHWlAj0UDakRxRv+nRKQVW0DYvf5MyNMLa0masQrbGB
         hAUg==
X-Gm-Message-State: ACrzQf1peErZLWcWeSszoMCIFEFzpliUPWQdDgl6hh7S3D7Wi/kLJ+gv
        Coxj3iSiDdwrfZbhSpZidyqph8LkEG7TRcjy0I+q5gOOP3EIvGjPtSYp5Y0VGhO98a1HBYj5WqH
        L3cjTrg9byCnMx4NedA/rLauz1TKDvOELFIgwuC9YkMhYn0Fd8Cm6
X-Received: by 2002:a62:b40a:0:b0:56c:6c63:fdb2 with SMTP id h10-20020a62b40a000000b0056c6c63fdb2mr29340407pfn.4.1667466277847;
        Thu, 03 Nov 2022 02:04:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6XOQlonLupUwOI85H/ppJIQcX6sIKgcNNVh7P108FI/WJe10CsX84EYvQDqK4PHK5gJzbCdiQD9UiFCntuRmw=
X-Received: by 2002:a62:b40a:0:b0:56c:6c63:fdb2 with SMTP id
 h10-20020a62b40a000000b0056c6c63fdb2mr29340382pfn.4.1667466277487; Thu, 03
 Nov 2022 02:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220901152632.970018-1-omosnace@redhat.com> <20220905090811.ocnnc53y2bow7m3i@wittgenstein>
 <CAFqZXNu_jf0D8LQLc15+ZrFne5F5F5PFNbkT-EkfqXvNdSKKsQ@mail.gmail.com>
 <20220905153036.zzcovknz7ntgcn5f@wittgenstein> <20221102182451.aoos5udhf6rbb6us@wittgenstein>
In-Reply-To: <20221102182451.aoos5udhf6rbb6us@wittgenstein>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 3 Nov 2022 10:04:25 +0100
Message-ID: <CAFqZXNuG0gjRjSMpaMJQqmmwtqr5Yx1r6Eg0YpJ4DQ6u9CWqRA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fs: fix capable() call in simple_xattr_list()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Vasily Averin <vvs@openvz.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>, rcu@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 2, 2022 at 7:25 PM Christian Brauner <brauner@kernel.org> wrote:
> On Mon, Sep 05, 2022 at 05:30:36PM +0200, Christian Brauner wrote:
> > On Mon, Sep 05, 2022 at 12:15:01PM +0200, Ondrej Mosnacek wrote:
> > > On Mon, Sep 5, 2022 at 11:08 AM Christian Brauner <brauner@kernel.org> wrote:
> > > > On Thu, Sep 01, 2022 at 05:26:30PM +0200, Ondrej Mosnacek wrote:
> > > > > The goal of these patches is to avoid calling capable() unconditionally
> > > > > in simple_xattr_list(), which causes issues under SELinux (see
> > > > > explanation in the second patch).
> > > > >
> > > > > The first patch tries to make this change safer by converting
> > > > > simple_xattrs to use the RCU mechanism, so that capable() is not called
> > > > > while the xattrs->lock is held. I didn't find evidence that this is an
> > > > > issue in the current code, but it can't hurt to make that change
> > > > > either way (and it was quite straightforward).
> > > >
> > > > Hey Ondrey,
> > > >
> > > > There's another patchset I'd like to see first which switches from a
> > > > linked list to an rbtree to get rid of performance issues in this code
> > > > that can be used to dos tmpfs in containers:
> > > >
> > > > https://lore.kernel.org/lkml/d73bd478-e373-f759-2acb-2777f6bba06f@openvz.org
> > > >
> > > > I don't think Vasily has time to continue with this so I'll just pick it
> > > > up hopefully this or the week after LPC.
> > >
> > > Hm... does rbtree support lockless traversal? Because if not, that
> >
> > The rfc that Vasily sent didn't allow for that at least.
> >
> > > would make it impossible to fix the issue without calling capable()
> > > inside the critical section (or doing something complicated), AFAICT.
> > > Would rhashtable be a workable alternative to rbtree for this use
> > > case? Skimming <linux/rhashtable.h> it seems to support both lockless
> > > lookup and traversal using RCU. And according to its manpage,
> > > *listxattr(2) doesn't guarantee that the returned names are sorted.
> >
> > I've never used the rhashtable infrastructure in any meaningful way. All
> > I can say from looking at current users that it looks like it could work
> > well for us here:
> >
> > struct simple_xattr {
> >       struct rhlist_head rhlist_head;
> >       char *name;
> >       size_t size;
> >       char value[];
> > };
> >
> > static const struct rhashtable_params simple_xattr_rhashtable = {
> >       .head_offset = offsetof(struct simple_xattr, rhlist_head),
> >       .key_offset = offsetof(struct simple_xattr, name),
> >
> > or sm like this.
>
> I have a patch in rough shape that converts struct simple_xattr to use
> an rhashtable:
>
> https://gitlab.com/brauner/linux/-/commits/fs.xattr.simple.rework/
>
> Light testing, not a lot useful comments and no meaningful commit
> message as of yet but I'll get to that.

Looks mostly good at first glance. I left comments for some minor
stuff I noticed.

> Even though your issue is orthogonal to the performance issues I'm
> trying to fix I went back to your patch, Ondrej to apply it on top.
> But I think it has one problem.
>
> Afaict, by moving the capable() call from the top of the function into
> the actual traversal portion an unprivileged user can potentially learn
> whether a file has trusted.* xattrs set. At least if dmesg isn't
> restricted on the kernel. That may very well be the reason why the
> capable() call is on top.

Technically it would be possible, for example with SELinux if the
audit daemon is dead. Not a likely situation, but I agree it's better
to be safe.

> (Because the straightforward fix for this would be to just call
> capable() a single time if at least one trusted xattr is encountered and
> store the result. That's pretty easy to do by making turning the trusted
> variable into an int, setting it to -1, and only if it's -1 and a
> trusted xattr has been found call capable() and store the result.)

That would also run into the conundrum of holding a lock while
(potentially) calling into the LSM subsystem. And would it even fix
the information leak? Unless I'm missing something it would only
prevent a leak of the trusted xattr count, but not the presence of any
trusted xattr.

> One option to fix all of that is to switch simple_xattr_list() to use
>
>         ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)
>
> which doesn't generate an audit event.
>
> I think this is even the correct thing to do as listing xattrs isn't a
> targeted operation. IOW, if the the user had used getxattr() to request
> a trusted.* xattr then logging a denial makes sense as the user
> explicitly wanted to retrieve a trusted.* xattr. But if the user just
> requested to list all xattrs then silently skipping trusted without
> logging an explicit denial xattrs makes sense.
>
> Does that sound acceptable?

Yes, I can't see any reason why that wouldn't be the best solution.
Why haven't I thought of that? :)

I guess you will want to submit a patch for it along with your
rhashtable patch to avoid a conflict? Or would you like me to submit
it separately?


--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

