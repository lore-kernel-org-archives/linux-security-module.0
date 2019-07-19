Return-Path: <SRS0=Y89O=VQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE3CC7618F
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Jul 2019 18:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2201C21874
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Jul 2019 18:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfGSSrZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:47:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41536 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730132AbfGSSrZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Jul 2019 14:47:25 -0400
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:3aba:f8ff:fe58:9ca1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smcv)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D9A2E28C7EA;
        Fri, 19 Jul 2019 19:47:22 +0100 (BST)
Date:   Fri, 19 Jul 2019 19:47:20 +0100
From:   Simon McVittie <smcv@collabora.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: Preferred subj= with multiple LSMs
Message-ID: <20190719184720.GB24836@horizon>
References: <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com>
 <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com>
 <CAHC9VhQ9MSh5zCkhMja4r9j0RT952LwKSaG5dR-BqXzXrtEAUw@mail.gmail.com>
 <e9cf875a-0d0f-a56f-71dd-c22c67bdcc2d@schaufler-ca.com>
 <CAHC9VhQS9We1TNqRfuR_E-kV4aZddx9euaiv5Gzd5B5AkiDAUQ@mail.gmail.com>
 <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com>
 <20190718131034.GA12581@horizon>
 <45661e97-2ed0-22e5-992e-5d562ff11488@schaufler-ca.com>
 <20190719121540.GA1764@horizon>
 <720880ca-834c-1986-3baf-021c67221ae2@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <720880ca-834c-1986-3baf-021c67221ae2@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks for considering user-space in this, and sorry if I'm hijacking
this thread a bit (but I think some of the things I'm raising might be
equally applicable for audit subjects).

On Fri, 19 Jul 2019 at 09:29:17 -0700, Casey Schaufler wrote:
> On 7/19/2019 5:15 AM, Simon McVittie wrote:
> > However, I think it would be great to have multiple-"big"-LSM-aware
> > replacements for those interfaces, which present the various LSMs as
> > multiple parallel credentials.
> 
> Defining what would go into liblsm* is a task that has fallen to
> the chicken/egg paradox. We can't really define how the user-space
> should work without knowing how the kernel will work, and we can't
> solidify how the kernel will work until we know what user-space
> can use.

I was hoping the syscall wrappers in glibc would be a viable user-space
interface to the small amount of LSM stuff that dbus needs to use in an
LSM-agnostic way. That's what we use in dbus at the moment (in practice
just getsockopt, but I'd also be reading /proc/self/attr/current if there
was a specification for how to normalize it to match SO_PEERSEC results)
and it's no harder than the rest of the syscall-level APIs.

A single LSM-agnostic shared library would be the next best thing from
my point of view.

> An option that hasn't been discussed is a display option to provide
> the Hideous format for applications that know that's what they want.
> Write "hideous" into /proc/self/attr/display, and from then on you
> get selinux='a:b:c:d',apparmor='z'. This could be used widely in liblsm
> interfaces.

If the way to parse/split it is documented, then this would be easier
for dbus-daemon than continually resetting attr/display. It would be
especially good if you can document a way to find out which one of the
many labels would have been seen by an older user-space process that never
wrote to attr/display ("it's the first one in the list" would be fine),
so that we can put that one in our backwards-compatible API to clients.

Or, alternatively, we could pass it on directly to our clients and let
*them* parse it (possibly by using liblsm), the same way AppArmor-aware
D-Bus clients have to know how to use either aa_splitcon() or their
own parsing to go from the raw SO_PEERSEC result
"/usr/bin/firefox (enforce)" to the pair ("/usr/bin/firefox", "enforce")
that they probably actually wanted.

> > Do you mean that if process 11111 writes (for example) "apparmor" into
> > /proc/11111/attr/display, and then reads /proc/22222/attr/current
> > or queries the SO_PEERSEC of a socket opened by process 22222,
> > it will specifically see 22222's AppArmor label and not 22222's SELinux
> > label?
> 
> Process 11111 would see the AppArmor label when reading
> /proc/22222/attr/current. The display value is controlled
> by process 11111 so that it can control what data it wants
> to see.

OK, that's what I'd hoped.

> The display is set at the task level, so should be thread safe.

OK, good. However, thinking more about this, I have other concerns:

* In library code that can be used by a thread (task) that also uses other
  arbitrary libraries, or in an executable that uses libraries that might
  be interested in LSMs, the only safe way to deal with attr/display would
  be this sequence:

    - write desired value to /proc/self/attr/display
    - immediately read /proc/other/attr/current or query SO_PEERSEC

  and it would not be safe to rely on writing /proc/self/attr/display
  just once at startup, because some other library might have already
  changed it between startup and the actual read. Paradoxically, this
  maximizes the chance of breaking a reader that was relying on writing
  /proc/self/attr/display once during startup.

* If an async signal handler needs to know a LSM label for whatever
  reason, it will break anything in the same thread that was relying on
  that sequence, because it might have interrupted them between their
  write and their read:

    main execution path                  signal handler
    -------------------                  --------------

    write "apparmor" to attr/display
    (interrupted by async signal)
                                         write "selinux" to attr/display
                                         read attr/current or SO_PEERSEC
                                         do other stuff with SELinux label
                                         return
    (resumes)
    read attr/current or SO_PEERSEC
    expect an AppArmor label
    get a SELinux label
    sadness ensues

  Of course it's probably crazy for an async signal handler to do
  this... but people do lots of odd things in async signal handlers,
  and open(), read(), write(), getsockopt() are all async-signal-safe
  functions, so it's at least arguably valid.

> Writing to display does not require privilege, as it affects only
> the current process. The display is inherited on fork and reset on
> a privileged exec.

Another concern here: are you sure it shouldn't be reset on *any*
exec? Lots of programs (including dbus-daemon) fork-and-exec arbitrary
child processes that come from a different codebase not under our
control and aren't necessarily LSM-stacking-aware. I don't really want
to have to reset /proc/self/attr/display in our increasingly crowded
after-fork-but-before-exec code path (which, according to POSIX, is not
a safe place to invoke any non-async-signal-safe function, so we can't
easily do error handling if something goes wrong there).

Is there any possibility of having a parallel kernel API that,
if it exists, always returns the whole stack, maybe something
like /proc/<pid>/attr/current_stack and the SO_PEERSECLABELS that I
suggested previously, instead of repurposing /proc/<pid>/attr/current
and SO_PEERSEC to have contents that vary according to ambient process
state in their reader? (Bonus points if they are documented/defined with
a particular syntactic normalization this time, unlike the situation
with /proc/<pid>/attr/current and SO_PEERSEC where in principle you
need LSM-specific knowledge to know whether a trailing "\n" or "\0"
is safe to discard.)

    smcv
