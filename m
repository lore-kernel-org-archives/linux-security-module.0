Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AB6C433F5
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Mar 2022 08:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348946AbiCXI7L (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Mar 2022 04:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245463AbiCXI7K (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Mar 2022 04:59:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8EA9D0C4
        for <linux-security-module@vger.kernel.org>; Thu, 24 Mar 2022 01:57:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r22so7706831ejs.11
        for <linux-security-module@vger.kernel.org>; Thu, 24 Mar 2022 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZ6s65rDvN8Tqn0qDZEB8Ijp4jvPh0GyNpSk/ZtB3pI=;
        b=m8uvN3vl8Uzj9zAwWsZQwJeD4SgdTCd74DSTmwxQoZYwKcDUMIa06VjnueJ49ViSg6
         AH6m1oASGMxV+L7gbdqnZl0DsC1kLdBlx0tkhj9scA0ROyULs+xnhqKjG+EjiECTe9v9
         fHLplZ4INS5E2/hQbGf40wOuvgjoBCnl4uueQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZ6s65rDvN8Tqn0qDZEB8Ijp4jvPh0GyNpSk/ZtB3pI=;
        b=7yLPKRQcaUKVgj2fug/Zp70VNIfsclD41PvAYxGOGQJTAyh91NOSIY5mEjr/5klXV/
         wkzz1tlEZZNxxwRcMiiRm5WmS3bx/mQ78rZ6cNWh58Wq3kZmxeALyxRdhNUIS68iEX7d
         reWQKoVQw3bSYL/TbeS9xct0XcNIgHsfgZRZZuEDa3dbqU4F2xYQHNit0oFlGAzg3l+v
         WoKxJ1HxSPC/eK2iqgvPTX9EWNb52pV6LyYA/swzGCyWQ2N/y3/Mk9ZB3vOAzAxppsQA
         cnNWTmjAsq57xY/TbOO5bR7H5xhVYm78F9hHctX0/5t5gk1ZjRDN0WUmC7YxGlNWqxST
         oa0Q==
X-Gm-Message-State: AOAM531WgQJRE142qmlF9qcdex0w6SjdhIf931uUorJ9EZ0XdDQSLcA1
        aBlCg95rSHmobCm3NDW+cQtk5+1JsaKch8/Kua6TM/ephSk=
X-Google-Smtp-Source: ABdhPJz7TgZDeh0+kDj2ymXCRjzBF8dMmiYeu1yauoVqNwsy2kRkXd9LUCYEVYbpcsr51BEAZ9P7D4i0qDYXH2dm+jA=
X-Received: by 2002:a17:907:c16:b0:6db:1dfc:ca73 with SMTP id
 ga22-20020a1709070c1600b006db1dfcca73mr4602838ejc.192.1648112257373; Thu, 24
 Mar 2022 01:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220322192712.709170-1-mszeredi@redhat.com> <20220323225843.GI1609613@dread.disaster.area>
In-Reply-To: <20220323225843.GI1609613@dread.disaster.area>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 24 Mar 2022 09:57:26 +0100
Message-ID: <CAJfpegv6PmZ_RXipBs9UEjv_WfEUtTDE1uNZq+9fBkCzWPvXkw@mail.gmail.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
To:     Dave Chinner <david@fromorbit.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 23 Mar 2022 at 23:58, Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Mar 22, 2022 at 08:27:12PM +0100, Miklos Szeredi wrote:

> > - Interfaces for getting various attributes and statistics are fragmented.
> >   For files we have basic stat, statx, extended attributes, file attributes
> >   (for which there are two overlapping ioctl interfaces).  For mounts and
> >   superblocks we have stat*fs as well as /proc/$PID/{mountinfo,mountstats}.
> >   The latter also has the problem on not allowing queries on a specific
> >   mount.
>
> https://xkcd.com/927/

Haha!

> I've said in the past when discussing things like statx() that maybe
> everything should be addressable via the xattr namespace and
> set/queried via xattr names regardless of how the filesystem stores
> the data. The VFS/filesystem simply translates the name to the
> storage location of the information. It might be held in xattrs, but
> it could just be a flag bit in an inode field.

Right, that would definitely make sense for inode attributes.

What about other objects' attributes, statistics?   Remember this
started out as a way to replace /proc/self/mountinfo with something
that can query individual mount.

> > mnt                    - list of mount parameters
> > mnt:mountpoint         - the mountpoint of the mount of $ORIGIN
> > mntns                  - list of mount ID's reachable from the current root
> > mntns:21:parentid      - parent ID of the mount with ID of 21
> > xattr:security.selinux - the security.selinux extended attribute
> > data:foo/bar           - the data contained in file $ORIGIN/foo/bar
>
> How are these different from just declaring new xattr namespaces for
> these things. e.g. open any file and list the xattrs in the
> xattr:mount.mnt namespace to get the list of mount parameters for
> that mount.

Okay.

> Why do we need a new "xattr in everything but name" interface when
> we could just extend the one we've already got and formalise a new,
> cleaner version of xattr batch APIs that have been around for 20-odd
> years already?

Seems to make sense. But...will listxattr list everyting recursively?
I guess that won't work, better just list traditional xattrs,
otherwise we'll likely get regressions, and anyway the point of a
hierarchical namespace is to be able to list nodes on each level.  We
can use getxattr() for this purpose, just like getvalues() does in the
above example.

Thanks,
Miklos
