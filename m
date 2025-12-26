Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF573A1E7E
	for <linux-security-module@vger.kernel.org>; Fri, 26 Dec 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766775229; cv=none; b=nNzQfkxo//gXrN7jKpqYm9Sx1kKffwJ+z6LvfgwEdqG681MZaEwZ/v1bgOXTugDfx8xofiZ9ZbEIUnQJ11C5l3Erfn7KmyRy5RWMuuk2l7Xrtm98tHqQ/vncOYL+zb3NH8xLD5Zr3KeNAfhlScuSUdNbsBJlxtoSeg0ApdtcQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766775229; c=relaxed/simple;
	bh=xYy6cNumEmzkAg0w6m5QJYgIKQAVusT0fhDvBxcAAw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTeuLXUg13HCom1sloz0Uke9DE9gH1Erv9UDXrw4Xxfbp5leBG5e+Kf91lQ84pcxFS2lcJgfyuaYzyGDbQ0ReB81Dl+cCT28ZFMwesXXMTNSM9VTcPUZ7WEIJUM1Pj367UcLOtTeKC/OPgEuq7r2nE7UPWIFmw1VBjKLxcKpEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Z+TUfqfz; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Z+TUfqfz"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ddFBP6j6LzBmJ;
	Fri, 26 Dec 2025 19:53:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766775213;
	bh=24KKrATiCvj7p6bP6zW5F4Psi51FY5r0AM7RqqpvuDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+TUfqfzHnmoEirRejX4pi5oeCVXR2rOndeaXfCRHMQItQVCCIWtF3O3XGl9letHj
	 e0HmFLmUDinHeyYOeDUQG/kta0lbjhPBWXBh+j47cAN3W3V3hU/EDbvWt76qJquuaH
	 cMk10y2vdgi4YMCitBOmueg2nx9lDMGzyNGIN6Us=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ddFBP1mQYzxK9;
	Fri, 26 Dec 2025 19:53:33 +0100 (CET)
Date: Fri, 26 Dec 2025 19:53:27 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	gnoack@google.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] landlock: Document Landlock errata mechanism
Message-ID: <20251226.ahpooghah4Ph@digikod.net>
References: <20251216210248.4150777-1-samasth.norway.ananda@oracle.com>
 <20251216210248.4150777-2-samasth.norway.ananda@oracle.com>
 <20251223.4aaf05850b4c@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251223.4aaf05850b4c@gnoack.org>
X-Infomaniak-Routing: alpha

On Wed, Dec 24, 2025 at 12:08:39AM +0100, Günther Noack wrote:
> Hello!
> 
> On Tue, Dec 16, 2025 at 01:02:43PM -0800, Samasth Norway Ananda wrote:
> > Add comprehensive documentation for the Landlock errata mechanism,
> > including how to query errata using LANDLOCK_CREATE_RULESET_ERRATA
> > and detailed descriptions of all three existing errata.
> > 
> > Also update the code comment in syscalls.c to remind developers to
> > update errata documentation when applicable, and update the
> > documentation date to reflect this new content.
> > 
> > This addresses the gap where the kernel implements errata tracking
> > but provides no user-facing documentation on how to use it.
> 
> Thank you very much, this is absolutely right that this was missing
> and overall, this is an excellent change!  I have only some nit-picks
> and smaller questions below.
> 
> > 
> > Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> > ---
> >  Documentation/userspace-api/landlock.rst | 99 +++++++++++++++++++++++-
> >  security/landlock/syscalls.c             |  4 +-
> >  2 files changed, 101 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index b8caac299056..d1f7dd30395d 100644
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> > @@ -8,7 +8,7 @@ Landlock: unprivileged access control
> >  =====================================
> >  
> >  :Author: Mickaël Salaün
> > -:Date: March 2025
> > +:Date: December 2025
> >  
> >  The goal of Landlock is to enable restriction of ambient rights (e.g. global
> >  filesystem or network access) for a set of processes.  Because Landlock
> > @@ -445,6 +445,103 @@ system call:
> >          printf("Landlock supports LANDLOCK_ACCESS_FS_REFER.\n");
> >      }
> >  
> > +Landlock Errata
> > +---------------
> > +
> > +In addition to ABI versions, Landlock provides an errata mechanism to track
> > +fixes for issues that may affect backwards compatibility or require userspace
> > +awareness. The errata bitmask can be queried using:
> > +
> > +.. code-block:: c
> > +
> > +    int errata;
> > +
> > +    errata = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_ERRATA);
> > +    if (errata < 0) {
> > +        /* Landlock not available or disabled */
> > +        return 0;
> > +    }
> > +
> > +The returned value is a bitmask where each bit represents a specific erratum.
> > +If bit N is set (``errata & (1 << (N - 1))``), then erratum N has been fixed
> > +in the running kernel.
> > +
> > +Known Errata
> > +~~~~~~~~~~~~
> 
> I see that the following sections are based on the descriptions in
> security/landlock/errata/abi-*.h.  These header files have docstrings
> with "DOC:" identifiers -- would it not be possible to improve that
> documentation in-place and link that from the user documentation?

Yes please, if the current abi-*.h doc is not enough, please extend it.

> 
> I like the structured approach with the "Impact" section.  This seems
> useful for readers who want to evaluate whether they are affected.
> 
> > +
> > +**Erratum 1: TCP socket identification (ABI 4)**
> > +
> > +Fixed an issue where IPv4 and IPv6 stream sockets (e.g., SMC, MPTCP, or SCTP)
> > +were incorrectly restricted by TCP access rights during :manpage:`bind(2)` and
> > +:manpage:`connect(2)` operations.
> > +
> > +*Impact:* In kernels without this fix, using ``LANDLOCK_ACCESS_NET_BIND_TCP``
> > +or ``LANDLOCK_ACCESS_NET_CONNECT_TCP`` would incorrectly restrict non-TCP
> > +stream protocols.
> > +
> > +*How to check:*
> > +
> > +.. code-block:: c
> > +
> > +    if (errata & (1 << 0)) {
> > +        /* Erratum 1 is fixed - TCP restrictions only apply to TCP */
> > +        /* Safe to use non-TCP stream protocols */
> > +    }

This "How to check" subsection should be common to all errata.

> > +
> > +**Erratum 2: Scoped signal handling (ABI 6)**
> > +
> > +Fixed an issue where signal scoping (``LANDLOCK_SCOPE_SIGNAL``) was overly
> > +restrictive, preventing sandboxed threads from signaling other threads within
> > +the same process if they belonged to different Landlock domains.
> > +
> > +*Impact:* Without this fix, signal scoping could break multi-threaded
> > +applications that expect threads within the same process to freely signal
> > +each other, as documented in :manpage:`nptl(7)` and :manpage:`libpsx(3)`.
> 
> Maybe to help explain the impact: The problem only manifests when the
> userspace process is itself using libpsx(3) or an equivalent mechanism
> to enforce a Landlock policy on multiple (already running) threads at
> once.  Programs which enforce a Landlock policy at startup time and
> only then become multithreaded are not affected.
> 
> > +
> > +*How to check:*
> > +
> > +.. code-block:: c
> > +
> > +    if (errata & (1 << 1)) {
> > +        /* Erratum 2 is fixed - threads can signal within same process */
> > +        /* Safe to use LANDLOCK_SCOPE_SIGNAL with multi-threaded apps */
> > +    }
> > +
> > +**Erratum 3: Disconnected directory handling (ABI 1)**
> > +
> > +Fixed an issue with disconnected directories that occur when a directory is
> > +moved outside the scope of a bind mount. The fix ensures that evaluated access
> > +rights include both those from the disconnected file hierarchy down to its
> > +filesystem root and those from the related mount point hierarchy.
> > +
> > +*Impact:* Without this fix, it was possible to widen access rights through
> > +rename or link actions involving disconnected directories, potentially
> > +bypassing ``LANDLOCK_ACCESS_FS_REFER`` restrictions.
> > +
> > +*How to check:*
> > +
> > +.. code-block:: c
> > +
> > +    if (errata & (1 << 2)) {
> > +        /* Erratum 3 is fixed - disconnected directories handled correctly */
> > +        /* LANDLOCK_ACCESS_FS_REFER restrictions cannot be bypassed */
> > +    }
> > +
> > +When to Check Errata
> > +
> > +Applications should check for specific errata when:
> > +
> > +1. Using features that were relaxed or had their behavior changed (like
> > +   erratum 2 with signal scoping in multi-threaded applications).
> > +2. Relying on specific security guarantees that may not have been fully
> > +   enforced in earlier implementations (like erratum 3 with refer restrictions).

This is correct but it should only be useful to a few programs.  We need
to be careful to avoid making developers feel that they should check
errata, whereas in 99.9% of cases it is not required, it increases
complexity, and potentially decrease protection if misused (e.g. if
erratum is not applied, a program could erroneously disable the sandbox
or some restrictions).  I think we should have a warning note to
highlight that (i.e. in doubt, ignore errata).

> > +3. Using network restrictions and need to ensure other protocols aren't
> > +   incorrectly blocked (erratum 1).
> > +
> > +Most applications using Landlock's best-effort approach don't need to check
> > +errata, as the fixes generally make Landlock less restrictive or more correct,
> > +not more restrictive.

It's not related to the best-effort approach.

> > +
> 
> This section looks good to me as well.
> 
> >  The following kernel interfaces are implicitly supported by the first ABI
> >  version.  Features only supported from a specific version are explicitly marked
> >  as such.
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index 0116e9f93ffe..cf5ba7715916 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -157,9 +157,11 @@ static const struct file_operations ruleset_fops = {
> >  /*
> >   * The Landlock ABI version should be incremented for each new Landlock-related
> >   * user space visible change (e.g. Landlock syscalls).  This version should
> > - * only be incremented once per Linux release, and the date in
> > + * only be incremented once per Linux release. When incrementing, the date in
> >   * Documentation/userspace-api/landlock.rst should be updated to reflect the
> >   * UAPI change.
> > + * If the change involves a fix that requires userspace awareness, also update
> > + * the errata documentation in Documentation/userspace-api/landlock.rst.
> >   */
> >  const int landlock_abi_version = 7;
> >  
> > -- 
> > 2.50.1
> > 
> 
> I think this is a very good change.  My main open question here is
> whether we can link this with the header documentation instead of
> duplicating the documentation in two places.

I like it too.  We should leverage the comments to avoid duplicating doc
though.

> 
> Thanks!
> –Günther
> 
