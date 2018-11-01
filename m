Return-Path: <SRS0=OxMS=NM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51878C0044C
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 06:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D690320820
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 06:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D690320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeKAPJN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Nov 2018 11:09:13 -0400
Received: from mail.hallyn.com ([178.63.66.53]:58814 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeKAPJM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Nov 2018 11:09:12 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id AE78F100A; Thu,  1 Nov 2018 06:07:37 +0000 (UTC)
Date:   Thu, 1 Nov 2018 06:07:37 +0000
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     mortonm@chromium.org, jmorris@namei.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
Message-ID: <20181101060737.GA7132@mail.hallyn.com>
References: <20181031152846.234791-1-mortonm@chromium.org>
 <20181031210245.GA3537@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031210245.GA3537@mail.hallyn.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 31, 2018 at 09:02:45PM +0000, Serge E. Hallyn wrote:
> Quoting mortonm@chromium.org (mortonm@chromium.org):
> > From: Micah Morton <mortonm@chromium.org>
> > 
> > SafeSetID gates the setid family of syscalls to restrict UID/GID
> > transitions from a given UID/GID to only those approved by a
> > system-wide whitelist. These restrictions also prohibit the given
> > UIDs/GIDs from obtaining auxiliary privileges associated with
> > CAP_SET{U/G}ID, such as allowing a user to set up user namespace UID
> > mappings. For now, only gating the set*uid family of syscalls is
> > supported, with support for set*gid coming in a future patch set.
> > 
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > ---
> > 
> > NOTE: See the TODO above setuid_syscall() in lsm.c for an aspect of this
> > code that likely needs improvement before being an acceptable approach.
> > I'm specifically interested to see if there are better ideas for how
> > this could be done.
> > 
> >  Documentation/admin-guide/LSM/SafeSetID.rst |  94 ++++++
> >  Documentation/admin-guide/LSM/index.rst     |   1 +
> >  arch/Kconfig                                |   5 +
> >  arch/arm/Kconfig                            |   1 +
> >  arch/arm64/Kconfig                          |   1 +
> >  arch/x86/Kconfig                            |   1 +
> >  security/Kconfig                            |   1 +
> >  security/Makefile                           |   2 +
> >  security/safesetid/Kconfig                  |  13 +
> >  security/safesetid/Makefile                 |   7 +
> >  security/safesetid/lsm.c                    | 334 ++++++++++++++++++++
> >  security/safesetid/lsm.h                    |  30 ++
> >  security/safesetid/securityfs.c             | 189 +++++++++++
> >  13 files changed, 679 insertions(+)
> >  create mode 100644 Documentation/admin-guide/LSM/SafeSetID.rst
> >  create mode 100644 security/safesetid/Kconfig
> >  create mode 100644 security/safesetid/Makefile
> >  create mode 100644 security/safesetid/lsm.c
> >  create mode 100644 security/safesetid/lsm.h
> >  create mode 100644 security/safesetid/securityfs.c
> > 
> > diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentation/admin-guide/LSM/SafeSetID.rst
> > new file mode 100644
> > index 000000000000..e7d072124424
> > --- /dev/null
> > +++ b/Documentation/admin-guide/LSM/SafeSetID.rst
> > @@ -0,0 +1,94 @@
> > +=========
> > +SafeSetID
> > +=========
> > +SafeSetID is an LSM module that gates the setid family of syscalls to restrict
> > +UID/GID transitions from a given UID/GID to only those approved by a
> > +system-wide whitelist. These restrictions also prohibit the given UIDs/GIDs
> > +from obtaining auxiliary privileges associated with CAP_SET{U/G}ID, such as
> > +allowing a user to set up user namespace UID mappings.
> > +
> > +
> > +Background
> > +==========
> > +In absence of file capabilities, processes spawned on a Linux system that need
> > +to switch to a different user must be spawned with CAP_SETUID privileges.
> > +CAP_SETUID is granted to programs running as root or those running as a non-root
> > +user that have been explicitly given the CAP_SETUID runtime capability. It is
> > +often preferable to use Linux runtime capabilities rather than file
> > +capabilities, since using file capabilities to run a program with elevated
> > +privileges opens up possible security holes since any user with access to the
> > +file can exec() that program to gain the elevated privileges.
> 
> Not true, see inheritable capabilities.  You also might look at ambient
> capabilities.

So for example with pam_cap.so you could have your N uids each be given
the desired pI, and assign the corrsponding fIs to the files they should
be able to exec with privilege.  No other uids will run those files with
privilege.  *1

Can you give some more details about exactly how you see SafeSetID being
used?

I'm still not quite clear on whether you want N completely unprivileged
uids to be used by some user (i.e. uid 1000), or whether one or more of
those should also have some privileged, or whether one of the uids might
or might not b uid 0.  Years ago I used to use N separate uids to
somewhat segragate workloads on my laptop, and I'd like my browser to
do something like that.  Is that the kind of uid switching you have
in mind?

-serge

*1 And maybe with one of the p9auth/factotem proposals out there you
could have a userspace daemon hand out the tokens for setuid, but that's
getting "out there" and probably derailing this conversation :)
