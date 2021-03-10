Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D09C433E9
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 19:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C1264FD7
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 19:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCJTdy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhCJTdl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Mar 2021 14:33:41 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B2CC061761
        for <linux-security-module@vger.kernel.org>; Wed, 10 Mar 2021 11:33:40 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id q14so27141672ljp.4
        for <linux-security-module@vger.kernel.org>; Wed, 10 Mar 2021 11:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C0lOxwjMEr6SWX1hFkOaQGtQdtdGB5FiXwich6XA348=;
        b=NM0J3hx50vHdC/p5h3lzfZtYNUEYEEEUohjNigiA0KbbFneszGz381/p3GLd6yhcWu
         1KuK6TsD+n34eVK+nnQVCLf7Ie1gBju2CVq9ZLZdvETqSzALoCaMBhnofjKv/3sNUuYN
         Q+U9UAUcm9S3x+gB24/4Dfqmv17Vzecl9QcOThzFQv18IpgBij82+yGRMQkEuNTIH62P
         CHqkLGTcxXMX4XVmnYWQNqi/lUVZXi/3hSoVBkV7dSo11C67xn4g9eGuGxYzntTDETq0
         gZmbcBXsEeXMzgX7wVy0G9U7fO0WveTk3yR14wSE1t3VhTeVYQHPwgmWcjKqCHW98c+d
         QxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C0lOxwjMEr6SWX1hFkOaQGtQdtdGB5FiXwich6XA348=;
        b=iuvZyklEkpy2/OYbXKvdxtX5VgaiL/bUd0xziNmuda6f6MuPXJOQg8nKbRZG42LApS
         kS9J9FY2HPIor5sIDmdNIMxFWdlGBiyHCATvGiZt7tlYIE8C2EEB7t+1Vm0FwJugqSEW
         d46JHBYzJbryH+CZYpy3jAou9pCSUxxrhGyM3lYyZAAuow67BchIvhFsbq04Ic5mU5Hc
         UvbGXvGBVUOfKH/thrOG2S7FWfeY5TDUP/l/znBrYxvb/BsVdXZhq0AQWu3cojfkJ1xD
         MuGA0D4/i2935QyIEXiRjXlJioYQGTGGSRlgHZYackszrJg9dnLW6X5viO0TPyGE3laO
         qedA==
X-Gm-Message-State: AOAM532ZcPTY++VDgJVymbrhYke1H1DczjBgOJFUcATb3eq38mq4yYUi
        UOvDXN9DywEHUaKKEk6mk3lCw6OuSFujrgtu2n1yDQ==
X-Google-Smtp-Source: ABdhPJywfvsHOIz0NkR2nMiYoKEhfTkPo9yaeevm6MgBPXJj4NmO1bY3FBXA9+0DF6QnwYxqUt/SZcMZ24QK6nH4d6g=
X-Received: by 2002:a2e:9bcd:: with SMTP id w13mr2643039ljj.43.1615404819005;
 Wed, 10 Mar 2021 11:33:39 -0800 (PST)
MIME-Version: 1.0
References: <20210310181857.401675-1-mic@digikod.net> <20210310181857.401675-2-mic@digikod.net>
 <m17dmeq0co.fsf@fess.ebiederm.org>
In-Reply-To: <m17dmeq0co.fsf@fess.ebiederm.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 10 Mar 2021 20:33:12 +0100
Message-ID: <CAG48ez2gVdyFT3r_wVuqePWGQAi6YuYYXZcRJ7ENNdnpfpvkuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs: Allow no_new_privs tasks to call chroot(2)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 10, 2021 at 8:23 PM Eric W. Biederman <ebiederm@xmission.com> w=
rote:
>
> Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> writes:
>
> > From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >
> > Being able to easily change root directories enable to ease some
> > development workflow and can be used as a tool to strengthen
> > unprivileged security sandboxes.  chroot(2) is not an access-control
> > mechanism per se, but it can be used to limit the absolute view of the
> > filesystem, and then limit ways to access data and kernel interfaces
> > (e.g. /proc, /sys, /dev, etc.).
> >
> > Users may not wish to expose namespace complexity to potentially
> > malicious processes, or limit their use because of limited resources.
> > The chroot feature is much more simple (and limited) than the mount
> > namespace, but can still be useful.  As for containers, users of
> > chroot(2) should take care of file descriptors or data accessible by
> > other means (e.g. current working directory, leaked FDs, passed FDs,
> > devices, mount points, etc.).  There is a lot of literature that discus=
s
> > the limitations of chroot, and users of this feature should be aware of
> > the multiple ways to bypass it.  Using chroot(2) for security purposes
> > can make sense if it is combined with other features (e.g. dedicated
> > user, seccomp, LSM access-controls, etc.).
> >
> > One could argue that chroot(2) is useless without a properly populated
> > root hierarchy (i.e. without /dev and /proc).  However, there are
> > multiple use cases that don't require the chrooting process to create
> > file hierarchies with special files nor mount points, e.g.:
> > * A process sandboxing itself, once all its libraries are loaded, may
> >   not need files other than regular files, or even no file at all.
> > * Some pre-populated root hierarchies could be used to chroot into,
> >   provided for instance by development environments or tailored
> >   distributions.
> > * Processes executed in a chroot may not require access to these specia=
l
> >   files (e.g. with minimal runtimes, or by emulating some special files
> >   with a LD_PRELOADed library or seccomp).
> >
> > Allowing a task to change its own root directory is not a threat to the
> > system if we can prevent confused deputy attacks, which could be
> > performed through execution of SUID-like binaries.  This can be
> > prevented if the calling task sets PR_SET_NO_NEW_PRIVS on itself with
> > prctl(2).  To only affect this task, its filesystem information must no=
t
> > be shared with other tasks, which can be achieved by not passing
> > CLONE_FS to clone(2).  A similar no_new_privs check is already used by
> > seccomp to avoid the same kind of security issues.  Furthermore, becaus=
e
> > of its security use and to avoid giving a new way for attackers to get
> > out of a chroot (e.g. using /proc/<pid>/root), an unprivileged chroot i=
s
> > only allowed if the new root directory is the same or beneath the
> > current one.  This still allows a process to use a subset of its
> > legitimate filesystem to chroot into and then further reduce its view o=
f
> > the filesystem.
> >
> > This change may not impact systems relying on other permission models
> > than POSIX capabilities (e.g. Tomoyo).  Being able to use chroot(2) on
> > such systems may require to update their security policies.
> >
> > Only the chroot system call is relaxed with this no_new_privs check; th=
e
> > init_chroot() helper doesn't require such change.
> >
> > Allowing unprivileged users to use chroot(2) is one of the initial
> > objectives of no_new_privs:
> > https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.html
> > This patch is a follow-up of a previous one sent by Andy Lutomirski, bu=
t
> > with less limitations:
> > https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1=
327858005.git.luto@amacapital.net/
[...]
> Neither is_path_beneath nor path_is_under really help prevent escapes,
> as except for open files and files accessible from proc chroot already
> disallows going up.  The reason is the path is resolved with the current
> root before switching to it.

Yeah, this probably should use the same check as the CLONE_NEWUSER
logic, current_chrooted() from CLONE_NEWUSER; that check is already
used for guarding against the following syscall sequence, which has
similar security properties:
unshare(CLONE_NEWUSER); // gives the current process namespaced CAP_SYS_ADM=
IN
chroot("<...>"); // succeeds because of namespaced CAP_SYS_ADMIN

The current_chrooted() check in create_user_ns() is for the same
purpose as the check you're introducing here, so they should use the
same logic.
