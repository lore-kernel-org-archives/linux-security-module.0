Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E61318ED2
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904744; cv=none; b=Wu+UqS/Ue04/kGjkR/X9DNb0IGvqcpcpjwfV+A5BJv40LqV+K8fh5XuB/vl8spRfA2YO4Uhy/GSXQ3athpDP9GpOOJkggy2CwFdB9tcX9A2aUPDdY/14QoB2r4Z/3nJL4z1rjjffPUUNBTQ1v4NFfj8URz2LcoeYffnmH1e1rS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904744; c=relaxed/simple;
	bh=sOhkRqoNP4SDJdKP/uHZiOyrI6zb+SpOGwIaawbpOgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcVLuiCphAQJeMWHsS6snTyuT8SE1utK4qSFvXSCjI1wfymbO0xyMkW+vF5iPv65q0bdqheNkmaJSHY4CoE4Bj2uqOwEjPfn1WkHgAMtXxikCTF14tVwObE5iQjpJi5WS1EbuRwvldrqQB8uJFWh0hvsZqpbUghCGt/Lu1pkVsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwZYDp07; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwZYDp07"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47640541585so374933f8f.1
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784904740; x=1785509540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P/9Q29Swff+Xbb+XUsDxOC5AaRpO84ui7qTsGyj9Qkk=;
        b=uwZYDp07AuOc8l9SYHf7RzcRRKvRNj9v9kESyhqeltOJ8qIeknsTFOcDn+gIK+32Lk
         wfVt3faMM63Pp+vUZyFOqpZokLbOcfWJAW44+aTCh8s5JImOm4H6Z2d72bVbUlAY5DJ4
         4POOv6abmUpH1+EPURmihsvnOPJT3HHxOW72n6COE2LRycqt1CJvdWgohlDZMmniv7u4
         oMWp7d2Rn16r1b4l6EglMq2y0bKUyoJJ0cTJLX66madXkxfp1lmktnX7gBPZjdlmq/2q
         BAzeg+6WZvwAojl7yN32Rvra+qH1qaXqaVaejK6OvW2fzRc5IY/61TEw6LjHGC2Jy5O6
         Tn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784904740; x=1785509540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P/9Q29Swff+Xbb+XUsDxOC5AaRpO84ui7qTsGyj9Qkk=;
        b=AwB+56hJkBTXel+yqc94XnW0vyUkqJUclJCh8ybPpCh3guy2iZZnOwFMQ13yCQw1VW
         jzKo/1ngnEbmFpkph8eNBI4iYbsYPxStA84ODp9bWhe8kOuWT0fTMnI8/s6x7GmppG81
         l7Iictuh28jtkprMluPM0geooHnVrV/0kcF/5Zrqqg/aiaIdhVuMMn2sStqYXb/HwwSC
         bXOKA34RykSnT7mNkKhJv+41hJsyQzzgXul4Pxlcq3hyWfWVID5Fcc2kxIaNvW0VP+F9
         Vs9FBUWZ65HK53rwUNKKIwQ3IckZV55CEtNW0BV+ha/g2kqnOoQt2LAiik+5qN3qc3+q
         EsSw==
X-Forwarded-Encrypted: i=1; AHgh+RofBsCeWeEWGMWJqLoc3W16v0HAcizttnIIYSJFsvqEz88qVxzaRsxCeJw37nqsKDxNiBihSieI7g3umLMQGC3hp3neSx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/fptWiskcGhK6eqNirSfOFZEFl3OKwuu0yaIkFr34N1LgIyC
	LwpA2BaUiM4N6iSS8HIs1RpIB6H+o7NovGk3X+yMxQkTLJXMmaPP7rG3hJre9DIVQZzRFxogHEn
	ppxLkjRuL
X-Gm-Gg: AR+sD12EDtkal3qC4iZBcLefxA5cpCCCDiiSv0GrwrRHjRqTj/6N3LZtnQCEYhZNjC+
	Djh7hwdBcb21ceVS+Kd2tEBzjMyy+0G0K1dbkj8By5YrvwxFnDQRwuPlUryrfUiPCsS+z9NoWRv
	1Cz48qijLLL7nWa3J3ZTvV6Yeu0YFR/Gnv2cpvKpLsb6WbyjmxYW1dRzga7M0E02TK+r/Z94SHL
	gbnAw8B1qFemoQC+FqYFkAwB8/gal37VFDixjNdDYMliTiLX/l+9UAi0tJGqgfD/XiBEuaJ8ySD
	mv2RSoUmjY6njYrrH+hwymu3ZSjuCy+5OecnHM3Ep+GHDsaYbgtxDuLo+vb9BNdbkhFqnRYwHim
	37xqLJogeJVxuRfCoD/GMHDEiSc2IDEV6+i+hEzIFmlKZxKcxYZSxQIL/VOSbX6HFOYTic8hFiX
	mu3+j33LHl/hmiJzsMFwfh0MvEh3JMUKLN
X-Received: by 2002:a05:6000:25fb:b0:47f:9446:95a1 with SMTP id ffacd0b85a97d-47f944696b0mr5745679f8f.25.1784904740002;
        Fri, 24 Jul 2026 07:52:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:fea2:af0c:2e79:7a90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5a46sm23975793f8f.9.2026.07.24.07.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 07:52:19 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:52:13 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3 1/3] landlock: Require
 LANDLOCK_ACCESS_FS_MAKE_WHITEOUT for RENAME_WHITEOUT
Message-ID: <amN8Hb2pxhXr8drB@google.com>
References: <20260610092318.3868884-1-gnoack@google.com>
 <20260610092318.3868884-2-gnoack@google.com>
 <20260610.uoMee2quoo9k@digikod.net>
 <aivEo6bV_phFFJg5@google.com>
 <20260720.chow9ohYie5b@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720.chow9ohYie5b@digikod.net>

On Mon, Jul 20, 2026 at 12:58:00PM +0200, Mickaël Salaün wrote:
> On Fri, Jun 12, 2026 at 10:34:43AM +0200, Günther Noack wrote:
> > > 3. Add a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right and, when handled,
> > >    make LANDLOCK_ACCESS_FS_MAKE_CHAR not handle whiteout.  This would be
> > >    a bit weird from a kernel point of view but it should work well for
> > >    users while still forbidding direct whiteout creation.
> > 
> > Except for the best-effort fallback, which is IMHO prone to
> > implementation bugs. (see above)
> > 
> > On the side, the implementation of this is also non-trivial: In order
> > to check for mknod(..., makedev(0, 0)), we need to check
> > layer-by-layer whether the layer handles MAKE_WHITEOUT and then either
> > check for MAKE_CHAR or MAKE_WHITEOUT.
> 
> Canonicalizing MAKE_WHITEOUT at domain creation time (similarly to how
> unhandled access rights are actually handled) should make this much
> easier, and the following proposal would enable that:
> 
> First, a backportable patch would make MAKE_CHAR also control/deny
> RENAME_WHITEOUT to be consistent with direct whiteout creation (i.e.
> MAKE_CHAR control any S_IFCHR file, including whiteout ones).  This
> would be a real "Fixes" patch (without erratum).  We should keep in mind
> that whiteout creation doesn't require CAP_MKNOD, so in most cases,
> sandboxed processes shouldn't be allowed to create real character
> devices in the first place.  Also, current fuse-overlayfs processes need
> both ways to create whiteouts, so the current state is inconsistent to
> them too.
> 
> Then, to be able to differentiate real character devices from whiteouts,
> a new patch would add a LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right,
> controlling only whiteouts.  As with this third option, when this right
> is handled by a ruleset/layer, MAKE_CHAR doesn't control whiteout
> creation.
> 
> The best-effort compatibility is handled by userspace libraries.  The
> tricky part is when a policy handles MAKE_CHAR | MAKE_WHITEOUT, and has
> a rule with MAKE_WHITEOUT but not MAKE_CHAR: when running such policy in
> an old kernel (not supporting MAKE_WHITEOUT), the library should replace
> the MAKE_WHITEOUT in the rules with a MAKE_CHAR.  For the other cases,
> simple masking should work as expected.  This pattern could apply to
> potentially future splits of existing access right.
> 
> I find this approach good to add a new dedicated access right, but I now
> think it's overkill for this whiteout case.  Anyway, this pattern could
> be used if we want, one day, to split an access right.

Agreed, this is an approach which would have simplified the implementation
complexity for option 3. - Mapping old invocation variants onto the
more modern but compatible internal representation at an early stage
during ruleset enablement would be an elegant way to keep the
backwards compatibility concerns out of our core logic.  (Maybe we can move
the "refer" implementation more in that direction as well?)


> > Revisiting this discussion, I'd lean towards option 1 or 2 -- could
> > you be persuaded towards one of these?
> > 
> > I have a slight preference for option 1 (using MAKE_REG) because it
> > would be a narrow fix that could be backported to older kernels as
> > well and would not require a new access right.  Given that the use
> > case for RENAME_WHITEOUT is really only for FUSE-OverlayFS and given
> > that FUSE-OverlayFS anyway needs MAKE_REG permissions there, I have
> > trouble imagining a scenario where a separate access right for
> > MAKE_WHITEOUT is needed in a policy.  It seems like a pragmatic
> > choice.
> 
> I was reluctant at first but I now think it's the best approach.
> whiteouts are technically S_IFCHR but they are handled by the kernel/VFS
> as regular files wrt access checks (unprivileged: don't need CAP_MKNOD),
> so it would be inconsistent for Landlock to diverge from that.
> Whiteouts are safe (no device can bind to them), and the goal of
> LANDLOCK_ACCESS_FS_MAKE_CHAR is really to restrict the creation of new
> interfaces to the kernel (through an arbitrary device driver).  This
> case and rationale should be explained in the doc (also see other VFS
> replies wrt what are whiteouts).
> 
> So, LANDLOCK_ACCESS_FS_MAKE_REG should be the *only* access right to
> restrict whiteout creation, either directly with mknod or indirectly
> with RENAME_WHITEOUT.  fuse-overlayfs already needs MAKE_REG, so this
> should not change much its current status, but fuse-overlayfs could now
> drop MAKE_CHAR.
> 
> Let's go with option 1!

Awesome, sounds good.  I'll go and implement option 1, where MAKE_REG guards
whiteout creation directly from userspace, for both the mknod() and
RENAME_WHITEOUT case, and also introducing an erratum for it.  This will be
simpler than introducing a new access right and also benefit users on
older kernels when it gets backported.

—Günther
