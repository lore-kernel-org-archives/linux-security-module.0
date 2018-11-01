Return-Path: <SRS0=OxMS=NM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745AFC0044C
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 16:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E542064C
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 16:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ef0CTfW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E542064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeKBB0T (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:26:19 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33877 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKBB0T (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Nov 2018 21:26:19 -0400
Received: by mail-yw1-f65.google.com with SMTP id v199-v6so8133252ywg.1
        for <linux-security-module@vger.kernel.org>; Thu, 01 Nov 2018 09:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlatHY+JLNvfMrNkHD1V69dg3f+LUj/tzOwix1mIVf0=;
        b=Ef0CTfW8rbBsMlRRgh3H047+vA6W5WPH+9oqCNhez9mMPFvQthiNah+Gw0jrESMisz
         JhZ1h/B1p5Lk1++EQd7W61Als0Gq5NEDxQRbxxRDYHzlfuafTCXIN9lRRbi47bZM5QYt
         DhJwql6Hl55rNR98XfGwWy5lAi3ivno7c5EUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlatHY+JLNvfMrNkHD1V69dg3f+LUj/tzOwix1mIVf0=;
        b=fuPK7kKEgSKgwkLP+HXFkAa2HQBvAt59gHpV6emzOFUjS3KZ2bywxWOgLKAYst20GF
         U1BuP+rjImG5SfxsrQa8BLWs8uax8OTpwfcDe9/8qEOFF8+tv1Zv7f9ZzFZKR+H//5DY
         wEKXbJ1OuYiH0HXedYBXnCxlSMD34VIfCFSOh/oxZCxV26vTE8iEsqW9L/vy3Nk/HhiD
         3+pAv4Pqw7j8KuJs//7tDzwxiAKDWHDfQra4ivoW3vnLfp+lQdoXBJg3FYF/aL1RHgBZ
         3AlOtjIR7RrgaUE9ZzuMiD76ywkuJsajFN2/q4nY8XrfBchmvILZWv5sUraBD4uBUCeo
         10BQ==
X-Gm-Message-State: AGRZ1gJtAL6bW99siFKtzL20TOIpqXo8YFTXTA4+DyU4K6E7cflVLQar
        0FuJuV8uWohdQK0YVLlMFEvQO2Tb9TMiLyVk2AOECCrh
X-Google-Smtp-Source: AJdET5ciBdzn28+k3xsMTjJeCYDMjjQoM/0o0m5a4udljbBmFsi05TrK8bVmmItFIBiKvpMWJcrPMkf4DT5o8sRPOx0=
X-Received: by 2002:a81:7b0b:: with SMTP id w11-v6mr8042830ywc.167.1541089359802;
 Thu, 01 Nov 2018 09:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181031152846.234791-1-mortonm@chromium.org> <20181031210245.GA3537@mail.hallyn.com>
 <20181101060737.GA7132@mail.hallyn.com> <CAJ-EccMaAu+g55Nuh1nZqt3Ld-YEgDiT_ewdQzGtFGmzRgXckw@mail.gmail.com>
In-Reply-To: <CAJ-EccMaAu+g55Nuh1nZqt3Ld-YEgDiT_ewdQzGtFGmzRgXckw@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 1 Nov 2018 09:22:28 -0700
Message-ID: <CAJ-EccMgObaz-=aN1_GQWrS2PPRLXjw-SRQe6_gtquTsSt+DuQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     serge@hallyn.com
Cc:     jmorris@namei.org, Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 1, 2018 at 9:11 AM Micah Morton <mortonm@chromium.org> wrote:
>
> On Wed, Oct 31, 2018 at 11:07 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Wed, Oct 31, 2018 at 09:02:45PM +0000, Serge E. Hallyn wrote:
> > > Quoting mortonm@chromium.org (mortonm@chromium.org):
> > > > From: Micah Morton <mortonm@chromium.org>
> > > >
> > > > SafeSetID gates the setid family of syscalls to restrict UID/GID
> > > > transitions from a given UID/GID to only those approved by a
> > > > system-wide whitelist. These restrictions also prohibit the given
> > > > UIDs/GIDs from obtaining auxiliary privileges associated with
> > > > CAP_SET{U/G}ID, such as allowing a user to set up user namespace UID
> > > > mappings. For now, only gating the set*uid family of syscalls is
> > > > supported, with support for set*gid coming in a future patch set.
> > > >
> > > > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > > > ---
> > > >
> > > > NOTE: See the TODO above setuid_syscall() in lsm.c for an aspect of this
> > > > code that likely needs improvement before being an acceptable approach.
> > > > I'm specifically interested to see if there are better ideas for how
> > > > this could be done.
> > > >
> > > >  Documentation/admin-guide/LSM/SafeSetID.rst |  94 ++++++
> > > >  Documentation/admin-guide/LSM/index.rst     |   1 +
> > > >  arch/Kconfig                                |   5 +
> > > >  arch/arm/Kconfig                            |   1 +
> > > >  arch/arm64/Kconfig                          |   1 +
> > > >  arch/x86/Kconfig                            |   1 +
> > > >  security/Kconfig                            |   1 +
> > > >  security/Makefile                           |   2 +
> > > >  security/safesetid/Kconfig                  |  13 +
> > > >  security/safesetid/Makefile                 |   7 +
> > > >  security/safesetid/lsm.c                    | 334 ++++++++++++++++++++
> > > >  security/safesetid/lsm.h                    |  30 ++
> > > >  security/safesetid/securityfs.c             | 189 +++++++++++
> > > >  13 files changed, 679 insertions(+)
> > > >  create mode 100644 Documentation/admin-guide/LSM/SafeSetID.rst
> > > >  create mode 100644 security/safesetid/Kconfig
> > > >  create mode 100644 security/safesetid/Makefile
> > > >  create mode 100644 security/safesetid/lsm.c
> > > >  create mode 100644 security/safesetid/lsm.h
> > > >  create mode 100644 security/safesetid/securityfs.c
> > > >
> > > > diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentation/admin-guide/LSM/SafeSetID.rst
> > > > new file mode 100644
> > > > index 000000000000..e7d072124424
> > > > --- /dev/null
> > > > +++ b/Documentation/admin-guide/LSM/SafeSetID.rst
> > > > @@ -0,0 +1,94 @@
> > > > +=========
> > > > +SafeSetID
> > > > +=========
> > > > +SafeSetID is an LSM module that gates the setid family of syscalls to restrict
> > > > +UID/GID transitions from a given UID/GID to only those approved by a
> > > > +system-wide whitelist. These restrictions also prohibit the given UIDs/GIDs
> > > > +from obtaining auxiliary privileges associated with CAP_SET{U/G}ID, such as
> > > > +allowing a user to set up user namespace UID mappings.
> > > > +
> > > > +
> > > > +Background
> > > > +==========
> > > > +In absence of file capabilities, processes spawned on a Linux system that need
> > > > +to switch to a different user must be spawned with CAP_SETUID privileges.
> > > > +CAP_SETUID is granted to programs running as root or those running as a non-root
> > > > +user that have been explicitly given the CAP_SETUID runtime capability. It is
> > > > +often preferable to use Linux runtime capabilities rather than file
> > > > +capabilities, since using file capabilities to run a program with elevated
> > > > +privileges opens up possible security holes since any user with access to the
> > > > +file can exec() that program to gain the elevated privileges.
> > >
> > > Not true, see inheritable capabilities.  You also might look at ambient
> > > capabilities.
> >
> > So for example with pam_cap.so you could have your N uids each be given
> > the desired pI, and assign the corrsponding fIs to the files they should
> > be able to exec with privilege.  No other uids will run those files with
> > privilege.  *1
>
> Sorry, what are "pl" and "fls" here? "Privilege level" and "files"?
>
> >
> > Can you give some more details about exactly how you see SafeSetID being
> > used?
>
> Sure. The main use case for this LSM is to allow a non-root program to
> transition to other untrusted uids without full blown CAP_SETUID
> capabilities. The non-root program would still need CAP_SETUID to do
> any kind of transition, but the additional restrictions imposed by
> this LSM would mean it is a "safer" version of CAP_SETUID since the
> non-root program cannot take advantage of CAP_SETUID to do any
> unapproved actions (i.e. setuid to uid 0 or create/enter new user
> namespace). The higher level goal is to allow for uid-based sandboxing
> of system services without having to give out CAP_SETUID all over the
> place just so that non-root programs can drop to
> even-further-non-privileged uids. This is especially relevant when one
> non-root daemon on the system should be allowed to spawn other
> processes as different uids, but its undesirable to give the daemon a
> basically-root-equivalent CAP_SETUID.
>
> >
> > I'm still not quite clear on whether you want N completely unprivileged
> > uids to be used by some user (i.e. uid 1000), or whether one or more of
> > those should also have some privileged, or whether one of the uids might
> > or might not b uid 0.  Years ago I used to use N separate uids to
> > somewhat segragate workloads on my laptop, and I'd like my browser to
> > do something like that.  Is that the kind of uid switching you have
> > in mind?
>
> "N completely unprivileged uids to be used by some user (i.e. uid
> 1000)" is the closest description of what this LSM has in mind. For
> example, uid 123 is some system service that needs runtime
> capabilities X, Y and Z and a bunch of DBus permissions associated
> with uid 123, but also wants to spawn another program without any of
> these capabilities/permissions. In this case we would like to avoid
> giving the system service CAP_SETUID.

To clarify: "spawn another program *as a different uid* without any..."

>
> >
> > -serge
> >
> > *1 And maybe with one of the p9auth/factotem proposals out there you
> > could have a userspace daemon hand out the tokens for setuid, but that's
> > getting "out there" and probably derailing this conversation :)
