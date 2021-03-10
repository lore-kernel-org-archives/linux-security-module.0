Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAD_ENC_HEADER,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94FFC43331
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 16:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF63564FDE
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 16:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhCJQ4a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Mar 2021 11:56:30 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:37178 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhCJQ4E (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Mar 2021 11:56:04 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK27t-00E2Bv-7C; Wed, 10 Mar 2021 09:56:01 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK27s-0002lw-6T; Wed, 10 Mar 2021 09:56:00 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>
References: <20210310161000.382796-1-mic@digikod.net>
        <20210310161000.382796-2-mic@digikod.net>
Date:   Wed, 10 Mar 2021 10:56:04 -0600
In-Reply-To: <20210310161000.382796-2-mic@digikod.net> (=?utf-8?Q?=22Micka?=
 =?utf-8?Q?=C3=ABl_Sala=C3=BCn=22's?=
        message of "Wed, 10 Mar 2021 17:10:00 +0100")
Message-ID: <m1lfavt0bf.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1lK27s-0002lw-6T;;;mid=<m1lfavt0bf.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18KLsREVcGmRhumyXmrSYgLMNzBj8iNk6o=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v1 1/1] fs: Allow no_new_privs tasks to call chroot(2)
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Mickaël Salaün <mic@digikod.net> writes:

> From: Mickaël Salaün <mic@linux.microsoft.com>
>
> Being able to easily change root directories enable to ease some
> development workflow and can be used as a tool to strengthen
> unprivileged security sandboxes.  chroot(2) is not an access-control
> mechanism per se, but it can be used to limit the absolute view of the
> filesystem, and then limit ways to access data and kernel interfaces
> (e.g. /proc, /sys, /dev, etc.).

Actually chroot does not so limit the view of things.  It only limits
the default view.

A process that is chrooted can always escape by something like
chroot("../../../../../../../../..").

So I don't see the point of allowing chroot once you are in your locked
down sandbox.

> Users may not wish to expose namespace complexity to potentially
> malicious processes, or limit their use because of limited resources.
> The chroot feature is much more simple (and limited) than the mount
> namespace, but can still be useful.  As for containers, users of
> chroot(2) should take care of file descriptors or data accessible by
> other means (e.g. current working directory, leaked FDs, passed FDs,
> devices, mount points, etc.).  There is a lot of literature that discuss
> the limitations of chroot, and users of this feature should be aware of
> the multiple ways to bypass it.  Using chroot(2) for security purposes
> can make sense if it is combined with other features (e.g. dedicated
> user, seccomp, LSM access-controls, etc.).
>
> One could argue that chroot(2) is useless without a properly populated
> root hierarchy (i.e. without /dev and /proc).  However, there are
> multiple use cases that don't require the chrooting process to create
> file hierarchies with special files nor mount points, e.g.:
> * A process sandboxing itself, once all its libraries are loaded, may
>   not need files other than regular files, or even no file at all.
> * Some pre-populated root hierarchies could be used to chroot into,
>   provided for instance by development environments or tailored
>   distributions.
> * Processes executed in a chroot may not require access to these special
>   files (e.g. with minimal runtimes, or by emulating some special files
>   with a LD_PRELOADed library or seccomp).
>
> Allowing a task to change its own root directory is not a threat to the
> system if we can prevent confused deputy attacks, which could be
> performed through execution of SUID-like binaries.  This can be
> prevented if the calling task sets PR_SET_NO_NEW_PRIVS on itself with
> prctl(2).  To only affect this task, its filesystem information must not
> be shared with other tasks, which can be achieved by not passing
> CLONE_FS to clone(2).  A similar no_new_privs check is already used by
> seccomp to avoid the same kind of security issues.  Furthermore, because
> of its security use and to avoid giving a new way for attackers to get
> out of a chroot (e.g. using /proc/<pid>/root), an unprivileged chroot is
> only allowed if the new root directory is the same or beneath the
> current one.  This still allows a process to use a subset of its
> legitimate filesystem to chroot into and then further reduce its view of
> the filesystem.
>
> This change may not impact systems relying on other permission models
> than POSIX capabilities (e.g. Tomoyo).  Being able to use chroot(2) on
> such systems may require to update their security policies.
>
> Only the chroot system call is relaxed with this no_new_privs check; the
> init_chroot() helper doesn't require such change.
>
> Allowing unprivileged users to use chroot(2) is one of the initial
> objectives of no_new_privs:
> https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.html
> This patch is a follow-up of a previous one sent by Andy Lutomirski, but
> with less limitations:
> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1327858005.git.luto@amacapital.net/

Last time I remember talking architecture we agreed that user namespaces
would be used for enabling features and that no_new_privs would just be
used to lock-down userspace.  That way no_new_privs could be kept simple
and trivial to audit and understand.

You can build your sandbox and use chroot if you use a user namespace at
the start.  A mount namespace would also help lock things down.  Still
allowing chroot after the sanbox has been built, a seccomp filter has
been installed and no_new_privs has been enabled seems like it is asking
for trouble and may weaken existing sandboxes.

So I think we need a pretty compelling use case to consider allowing
chroot(2).  You haven't even mentioned what your usecase is at this
point so I don't know why we would tackle that complexity.

Eric

