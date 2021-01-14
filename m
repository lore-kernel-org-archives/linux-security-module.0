Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8544FC433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Jan 2021 22:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EAD23A5C
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Jan 2021 22:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbhANWsM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Jan 2021 17:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbhANWsM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Jan 2021 17:48:12 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894D9C0613CF
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jan 2021 14:47:31 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ke15so2955297ejc.12
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jan 2021 14:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zyDFVEgfwCeZaxKwpzwQSp3ENtudOHEif4oCCEAR3E=;
        b=TqNDT0u54KKuZPvEJdgLc1BhKdSRJPLW1LJHvOvGAaBvBs4kHyzeqQHQo0Zyrkqjx1
         lzX6EDXpknEf0RoD3BqR1cWEvy7Z8uUBHF/xWiL+0I8VBjJFwRvAS/8aoouOpLGXmRa7
         R45rYHgZYLxfjqP3oOGi6u//o07lC9Rgib+kTkm+RXWb6jTjtPe2cWfwVav1JlOPw3sz
         2JCzNBccFYm//zfrDFPjG6s0COtZziTcerO1SBeMPQNem6Zxuga3Xqxf/r7TbTZqa5mp
         Rf6D14gNJ1nRU3RODPPftA61SRAPdRRR/U1Jz4R25o4tL7ChogkPHvGilIwEnRVfJoFq
         F1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zyDFVEgfwCeZaxKwpzwQSp3ENtudOHEif4oCCEAR3E=;
        b=srfG+zqdPaCybSY48eH46zD3up7gIXFdLBkBpHOr+PR/Hlwf17IkK54jZHN8ujQrKi
         0qmfC3H5FbDNlxTkUIBSWPp0nBYqhTeNF6M8i5mMbOO/e4fLkGjsNCAAOGt9/qeqxkdq
         SYIkvRVr+a+gxynxLcs4cZPZnjRGghfqKUbF3ezJhSVEcGBJ0LxUUxtl9fU1J6L3vwPJ
         5b61+hJ3CUQLhm0l0la3IYSniWnJp6QUxZsTM+oKcCDPAzMI0RtL344CKGG1n1tc8jU6
         Qo8QwhF3ubtyWg5GoNGwIywEI++Iq4gDDm2jVQefOvLyP+5dnjXtn8kZQbFfDhFDC6ri
         i/uQ==
X-Gm-Message-State: AOAM530FqU9wRlo2GERrCgmZrC6Jzam16QGlbykT8WXFVk0ptFLC6Lt6
        lIwgh5HEMQkx6ETk0dgUgcYEznh0KwuQaUAG/d/0
X-Google-Smtp-Source: ABdhPJzsSKmcY/ZVWEMyE355NLC9n/PtlEUotQjvcYcEiSbDaJnFMkRXC21GqZwdsA/4/83NkBdNe4MaxBttarJjJvU=
X-Received: by 2002:a17:906:2e82:: with SMTP id o2mr6947496eji.106.1610664450156;
 Thu, 14 Jan 2021 14:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20210108222223.952458-1-lokeshgidra@google.com> <CAHC9VhSLFUyeo8he4t7rFoHgRHfpB=URoAioF+a3+xjZP8JdSQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSLFUyeo8he4t7rFoHgRHfpB=URoAioF+a3+xjZP8JdSQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Jan 2021 17:47:19 -0500
Message-ID: <CAHC9VhRGZCRV2T6y80MXtutsZRw4hR+wxgte3__vyG50yAn4qw@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] SELinux support for anonymous inodes and UFFD
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 12, 2021 at 12:15 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Jan 8, 2021 at 5:22 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> >
> > Userfaultfd in unprivileged contexts could be potentially very
> > useful. We'd like to harden userfaultfd to make such unprivileged use
> > less risky. This patch series allows SELinux to manage userfaultfd
> > file descriptors and in the future, other kinds of
> > anonymous-inode-based file descriptor.
>
> ...
>
> > Daniel Colascione (3):
> >   fs: add LSM-supporting anon-inode interface
> >   selinux: teach SELinux about anonymous inodes
> >   userfaultfd: use secure anon inodes for userfaultfd
> >
> > Lokesh Gidra (1):
> >   security: add inode_init_security_anon() LSM hook
> >
> >  fs/anon_inodes.c                    | 150 ++++++++++++++++++++--------
> >  fs/libfs.c                          |   5 -
> >  fs/userfaultfd.c                    |  19 ++--
> >  include/linux/anon_inodes.h         |   5 +
> >  include/linux/lsm_hook_defs.h       |   2 +
> >  include/linux/lsm_hooks.h           |   9 ++
> >  include/linux/security.h            |  10 ++
> >  security/security.c                 |   8 ++
> >  security/selinux/hooks.c            |  57 +++++++++++
> >  security/selinux/include/classmap.h |   2 +
> >  10 files changed, 213 insertions(+), 54 deletions(-)
>
> With several rounds of reviews done and the corresponding SELinux test
> suite looking close to being ready I think it makes sense to merge
> this via the SELinux tree.  VFS folks, if you have any comments or
> objections please let me know soon.  If I don't hear anything within
> the next day or two I'll go ahead and merge this for linux-next.

With no comments over the last two days I merged the patchset into
selinux/next.  Thanks for all your work and patience on this Lokesh.

Also, it looks like you are very close to getting the associated
SELinux test suite additions merged, please continue to work with
Ondrej to get those merged soon.

-- 
paul moore
www.paul-moore.com
