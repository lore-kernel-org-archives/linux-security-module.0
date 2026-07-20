Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5263C3F12FF
	for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545543; cv=none; b=ObSv5qOLUZ9bNVa4miZzi0givkSq9E2R0ku5uSLFDXcrpOpqSHgExG/zV4KouXGLKavax+5L67OxGsLJyp+MlnBdqTqtB7LPDkvqucV2eerFaZTdoT9jjfqQF33qmjHc7SrOp06A64iiNulJyGdPZXqzy56o19YfQCi6ByZxJZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545543; c=relaxed/simple;
	bh=5FmxGTPSLjAzpbVJra3/AV22oq8KcdUAC33gLXQJ3gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNSqhihAUDwbO7xzbRMzfKJztw6N8hKX23mQqxLjiCHt2m75WdZ4fPBqigjp4k4Y5lztMYLJQBT1OjLrEuAMukx+S678rWvUVjISSP4jPgkloG8TsJszX+8R0kTPugAyp9GbG/PiTIB+ylDC5EXqVFVuJNcitrtqkWl+vQp3Vbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=uZY3WESK; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="uZY3WESK"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h3ctq0zwGzm1N;
	Mon, 20 Jul 2026 12:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784545090;
	bh=DIhxxzzHB7rxY6OOeGRGkX93hME71THJ1moXDn7ZVFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZY3WESK+HMgEfhuZPJY5mzS2q8t6yA+YlPukRqNOboujeRgq4/F7CDdbVTSI54+l
	 iKu4395+rI83tEKA+d24CgrlR7bQ9HTW/yMcEPbo2pZb+ne20grRI1htSrQ4xYYVt7
	 U5dJVoQj5NsqoF/K5htOgkAI7mfLnnimne1H6Kyo=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h3ctj0wkJz4Bv;
	Mon, 20 Jul 2026 12:58:05 +0200 (CEST)
Date: Mon, 20 Jul 2026 12:58:00 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Serge Hallyn <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3 1/3] landlock: Require
 LANDLOCK_ACCESS_FS_MAKE_WHITEOUT for RENAME_WHITEOUT
Message-ID: <20260720.chow9ohYie5b@digikod.net>
References: <20260610092318.3868884-1-gnoack@google.com>
 <20260610092318.3868884-2-gnoack@google.com>
 <20260610.uoMee2quoo9k@digikod.net>
 <aivEo6bV_phFFJg5@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aivEo6bV_phFFJg5@google.com>
X-Infomaniak-Routing: alpha

On Fri, Jun 12, 2026 at 10:34:43AM +0200, Günther Noack wrote:
> Thanks for the review!
> 
> On Wed, Jun 10, 2026 at 03:38:56PM +0200, Mickaël Salaün wrote:
> > Making MAKE_CHAR not covering MAKE_WHITEOUT is not addressed (see
> > previous discussion).  MAKE_CHAR should not restrict whiteout creation
> > *if* MAKE_WHITEOUT is handled.
> 
> (This is option (3) from your reply to V1 [1].)
>         
> I am skeptical of this approach, because it complicates how userspace
> needs to deal with this access right.  Consider the following
> scenario: A program wants to install the policy:
> 
>  * DENY  MAKE_WHITEOUT, MAKE_CHAR
>  * ALLOW MAKE_WHITEOUT             in /foo  (path_beneath rule)
> 
> Then, if the kernel ABI predates make-whiteout, with the usual
> best-effort fallback (clearing out the unsupported bits), this ruleset
> becomes:
> 
>  * DENY  MAKE_CHAR
>  * (no ALLOW rule)
> 
> But this ruleset is incorrect, because it denies mknod("/foo/x",
> S_IFCHR | mode, makedev(0, 0)) in /foo, which was explicitly allowed
> in the earlier ruleset.
> 
> So in order to implement the best-effort fallback, I guess userspace
> libraries would now have to take into account whether there are any
> rules where MAKE_WHITEOUT is specifically allowed, and if so, they
> can't restrict MAKE_CHAR either?  I find this a bit complicated and I
> think it's foreseeable that library implementers will predominantly
> get this wrong.

I use this example below.  In this case the library should *replace*
rules' MAKE_WHITEOUT with MAKE_CHAR.

> 
> 
> Let me circle back to the other options you mentioned in [1], quoting
> them here for reference:
> > I see four options:
> > 
> > 1. Consider whiteouts as regular files and make them handled by
> >    LANDLOCK_ACCESS_FS_MAKE_REG.  This would require an erratum and would
> >    make sense for direct mknod calls, but it would be weird for
> >    renameat2 calls than move a file and should only require
> >    LANDLOCK_ACCESS_FS_REMOVE_FILE from the user point of view.
> 
> It would be weird for renameat2 calls to require MAKE_REG in the
> source directory, but the weirdness would only affect
> fuse-overlayfs-style programs and could be documented explicitly for
> them for the case that they start using Landlock.
> 
> Normal programs that just call rename() on an existing FUSE-Overlayfs
> filesystem would *not* require the MAKE_REG right, because the FUSE
> process would do that on their behalf with the FUSE processes'
> credentials.

This is definitely the simplest approach, and the compatibility impact
should be really minimal, especially because fuse-overlayfs would
probably already need to be allowed to create regular files there.

I'm now leaning toward this option, but because I though about another
one, I'll describe it anyway.

> 
> > 
> > 2. Add a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right to handle whitout
> >    creation (direct and indirect?) and keep LANDLOCK_ACCESS_FS_MAKE_CHAR
> >    handle direct whiteout creation (and don't backport anything).  It
> >    looks inconsistent from an access control point of view.
> 
> MAKE_WHITEOUT to handle rename(RENAME_WHITEOUT) and MAKE_CHAR to
> handle mknod(chardev (0, 0)) -- This is a bit inconsistent, but it
> does not make a difference for any programs other than the ones
> calling rename(RENAME_WHITEOUT) (i.e., overlayfs-fuse), and it could
> be documented for that one use case.
> 
> I find this a pragmatic balance, and it does not require special logic
> for the best-effort fallback either.  Could you be persuaded to go
> this route instead?
> 
> > 3. Add a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right and, when handled,
> >    make LANDLOCK_ACCESS_FS_MAKE_CHAR not handle whiteout.  This would be
> >    a bit weird from a kernel point of view but it should work well for
> >    users while still forbidding direct whiteout creation.
> 
> Except for the best-effort fallback, which is IMHO prone to
> implementation bugs. (see above)
> 
> On the side, the implementation of this is also non-trivial: In order
> to check for mknod(..., makedev(0, 0)), we need to check
> layer-by-layer whether the layer handles MAKE_WHITEOUT and then either
> check for MAKE_CHAR or MAKE_WHITEOUT.

Canonicalizing MAKE_WHITEOUT at domain creation time (similarly to how
unhandled access rights are actually handled) should make this much
easier, and the following proposal would enable that:

First, a backportable patch would make MAKE_CHAR also control/deny
RENAME_WHITEOUT to be consistent with direct whiteout creation (i.e.
MAKE_CHAR control any S_IFCHR file, including whiteout ones).  This
would be a real "Fixes" patch (without erratum).  We should keep in mind
that whiteout creation doesn't require CAP_MKNOD, so in most cases,
sandboxed processes shouldn't be allowed to create real character
devices in the first place.  Also, current fuse-overlayfs processes need
both ways to create whiteouts, so the current state is inconsistent to
them too.

Then, to be able to differentiate real character devices from whiteouts,
a new patch would add a LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right,
controlling only whiteouts.  As with this third option, when this right
is handled by a ruleset/layer, MAKE_CHAR doesn't control whiteout
creation.

The best-effort compatibility is handled by userspace libraries.  The
tricky part is when a policy handles MAKE_CHAR | MAKE_WHITEOUT, and has
a rule with MAKE_WHITEOUT but not MAKE_CHAR: when running such policy in
an old kernel (not supporting MAKE_WHITEOUT), the library should replace
the MAKE_WHITEOUT in the rules with a MAKE_CHAR.  For the other cases,
simple masking should work as expected.  This pattern could apply to
potentially future splits of existing access right.

I find this approach good to add a new dedicated access right, but I now
think it's overkill for this whiteout case.  Anyway, this pattern could
be used if we want, one day, to split an access right.

> 
> 
> > 4. Add a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right and make
> >    LANDLOCK_ACCESS_FS_MAKE_CHAR never handle whiteout (and backport
> >    MAKE_CHAR fix with an errata).  This would be consistent but backport
> >    a way to directly create whiteouts (e.g. with mknod).
> 
> It's mostly theoretical, but lifting the mknod(chardev (0,0))
> restriction for normal mknod() calls and calling it an erratum seems
> surprising as well, because it would relax security guarantees for
> existing programs.

Agreed

> 
> I also pondered the alternative of creating an erratum but
> intentionally *not* backporting it, but even in that case, that
> surprising erratum still affects older programs which are deployed on
> newer kernels.

Yeah, that would not be useful and that's not the role of an erratum.

> 
> 
> Revisiting this discussion, I'd lean towards option 1 or 2 -- could
> you be persuaded towards one of these?
> 
> I have a slight preference for option 1 (using MAKE_REG) because it
> would be a narrow fix that could be backported to older kernels as
> well and would not require a new access right.  Given that the use
> case for RENAME_WHITEOUT is really only for FUSE-OverlayFS and given
> that FUSE-OverlayFS anyway needs MAKE_REG permissions there, I have
> trouble imagining a scenario where a separate access right for
> MAKE_WHITEOUT is needed in a policy.  It seems like a pragmatic
> choice.

I was reluctant at first but I now think it's the best approach.
whiteouts are technically S_IFCHR but they are handled by the kernel/VFS
as regular files wrt access checks (unprivileged: don't need CAP_MKNOD),
so it would be inconsistent for Landlock to diverge from that.
Whiteouts are safe (no device can bind to them), and the goal of
LANDLOCK_ACCESS_FS_MAKE_CHAR is really to restrict the creation of new
interfaces to the kernel (through an arbitrary device driver).  This
case and rationale should be explained in the doc (also see other VFS
replies wrt what are whiteouts).

So, LANDLOCK_ACCESS_FS_MAKE_REG should be the *only* access right to
restrict whiteout creation, either directly with mknod or indirectly
with RENAME_WHITEOUT.  fuse-overlayfs already needs MAKE_REG, so this
should not change much its current status, but fuse-overlayfs could now
drop MAKE_CHAR.

Let's go with option 1!

> 
> 
> > Specific tests should check that all
> > these cases are proprely handled.
> >
> > There is no documentation update related to the new feature.  A note
> > should also explain what exactly is a whiteout and why it is not
> > considered a character device (see previous discussions).
> > 
> > The sandboxer is not updated.
> > 
> > There is no audit tests.
> 
> Acknowledged, these were missing.
> 
> (I was initially hoping that this bug report wouldn't expand into a
> full-fledged feature with its own access right constant, but it is
> correct that this is all required in that case... :-/)
> 
> Will add this for the next patch set revision if it is still needed.
> 
> —Günther
> 
> [1] https://lore.kernel.org/all/20260414.Lae5ida1eeGh@digikod.net/
> 
