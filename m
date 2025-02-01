Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71CD19A;
	Sat,  1 Feb 2025 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738408178; cv=none; b=ePPAc4y8FKP4N2xiUOWi49RJC5aKOEIIfH0R2kiBUMRkbwZ/ZO/mjXnlL90IL4LNkqV01eJSEpYkwClcPugESWUtXsWIfpurdcv0WfEfFPJON0PMJUqbKsbIR7U847ErFMXzuSaFaSeMBAv6GpmGWcZcNm+Hmghc/N48jkYBUvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738408178; c=relaxed/simple;
	bh=9m3zXDlEBXAAkrgJzuTsf0ebEm0g3zP7/W6c7MJj/gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8CPkTbGIC+I6sCLxEayl+bDxiD2mBZq8ZRnn9ZLof4RScOy6jsJ3h8VgutidQc9mXUGcCR1IGMO0Enzq7/MJWV0PSKplaeM2BVNuNaJgegCp8+Xf4x6gQw85KpO4+JBE2EQ9bRMcStmE5uhqSlWdoW0fvkdf/dLx54j6oZ1cic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQM5aV6T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQM5aV6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C364AC4CED3;
	Sat,  1 Feb 2025 11:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738408178;
	bh=9m3zXDlEBXAAkrgJzuTsf0ebEm0g3zP7/W6c7MJj/gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQM5aV6TEZT4MYiAlT+rPTLLNejBZGWZs6MLLSa8SQ0HSHq7yajLmBhGuW+9r0m5J
	 AA0cPMLbsXXAZ7m3kH50PbcGh8qdRxrjSJg/C4eHBDsn9zG1GI8Sqoa0ZBRl+rvqbu
	 nRgOBh7w/BCIwYjjZ/nlfgJSbieuoDyoFmFfTT4+UxfzSf8ZKLas8NYE9L2BrgyPYp
	 NZ97P4dd8ITeBjmnu/KQUstx6goWW4SZd7wJYFIkSJr+g2oIvXuf3KZuBWzBTPy2xz
	 G4SwUr1DvRhGA/nIght7KCPlGN47fv3XF1bVgGYnr+zQP0wyv0CSzketXj2xXnHcB3
	 CAVBPOezErdJg==
Date: Sat, 1 Feb 2025 12:09:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Kees Cook <kees@kernel.org>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Praveen K Paladugu <prapal@linux.microsoft.com>, 
	Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, 
	Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/3] pidfd: Extend PIDFD_GET_INFO with
 PIDFD_INFO_LANDLOCK_*_DOMAIN
Message-ID: <20250201-husten-feinabstimmung-2e661fa13f14@brauner>
References: <20250131163447.1140564-1-mic@digikod.net>
 <20250131163447.1140564-3-mic@digikod.net>
 <CAHC9VhS=mMH9s2KUc2kSK7pW1yG8RB58hyJjW5oWsCK=i-1PdA@mail.gmail.com>
 <20250201.quaizoh3taeV@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201.quaizoh3taeV@digikod.net>

On Sat, Feb 01, 2025 at 11:28:28AM +0100, Mickaël Salaün wrote:
> On Fri, Jan 31, 2025 at 02:02:49PM -0500, Paul Moore wrote:
> > On Fri, Jan 31, 2025 at 11:43 AM Mickaël Salaün <mic@digikod.net> wrote:
> > >
> > > Because Landlock enables users to create nested sandboxes (i.e.
> > > domains), we might need to identify the domain with all restrictions
> > > (latest), or the domain we created (i.e. closest domain).  Indeed,
> > > because any process can create its own domain, the latest domain may not
> > > be known by the requester.
> > >
> > > The PIDFD_INFO_LANDLOCK_LAST_DOMAIN flag enables user space to get the
> > > latest (i.e. most nested) Landlock domain ID related to a sandboxed
> > > task, if any.  The domain ID is set in the pidfd_info's
> > > landlock_last_domain field according to the related mask.
> > >
> > > The PIDFD_INFO_LANDLOCK_FIRST_DOMAIN flag enables user space to get the
> > > closest (i.e. first hierarchy relative to the pidfd's credentials)
> > > Landlock domain ID related to a sandboxed task, if any.  The domain ID
> > > is set in the pidfd_info's landlock_first_domain field according to the
> > > related mask.
> > >
> > > It is only allowed to get information about a Landlock domain if the
> > > task's domain that created the pidfd is a parent of the PID's domain.
> > > Following the object-capability model, the pidfd's credentials are used
> > > instead of the caller's credentials.  This makes this command
> > > idenmpotent wrt the referenced process's state.
> > >
> > > If Landlock is not supported or if access to this information is denied,
> > > then the IOCTL does not set the PIDFD_INFO_LANDLOCK_*_DOMAIN flag in the
> > > returned mask.
> > >
> > > If PIDFD_INFO_LANDLOCK_LAST_DOMAIN or PIDFD_INFO_LANDLOCK_FIRST_DOMAIN
> > > is specified but the provided struct pidfd_info is not large enough to
> > > contain the related field, then -EINVAL is returned.
> > >
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Günther Noack <gnoack@google.com>
> > > Cc: Luca Boccassi <luca.boccassi@gmail.com>
> > > Cc: Praveen K Paladugu <prapal@linux.microsoft.com>
> > > Closes: https://github.com/landlock-lsm/linux/issues/26
> > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > Link: https://lore.kernel.org/r/20250131163447.1140564-3-mic@digikod.net
> > > ---
> > >  fs/pidfs.c                 | 24 ++++++++++++++++++++++--
> > >  include/uapi/linux/pidfd.h |  4 ++++
> > >  2 files changed, 26 insertions(+), 2 deletions(-)
> > 
> > While there are exceptions, mostly for legacy things, we try very hard
> > to avoid having the kernel call directly into a specific LSM,
> > preferring to use LSM interfaces, both so that all LSMs can benefit
> > from the change and also so that we can avoid having a lot of very
> > similar, but LSM-specific, calls in various parts in the kernel.
> 
> Making life easier for LSMs by sharing common code is a good thing, but
> making life easier for all kernel components by sharing common code is
> even better.  The PIDFD_GET_INFO IOCTL was design to be very flexible,
> and it follows the principle of "pay for what you request" thanks to the
> "mask" bitfield.
> 
> Users specify a set of properties they want, and the kernel returns
> these properties if they are supported and allowed.  Each of this
> property is well-specified and has a clear semantic.  This patch series
> implements two Landlock properties, each clearly identified and
> independent.
> 
> One important difference between the current LSMs attributes and these
> two new Landlock properties, is that the Landlock domain IDs are u64
> values instead of strings.  This makes the implementation quite forward
> and it fits well with how PIDFD_GET_INFO currently works, so there is no
> need for a new (PIDFD_GET_SECURITY) IOCTL handling complex data
> structure composing a set of strings such as what is required for
> current LSMs' attributes.
> 
> > 
> > There is an effort, albeit a slowly moving effort due to interrupts,
> > to add LSM support via a PIDFS_GET_SECURITY API:
> > 
> > https://lore.kernel.org/linux-security-module/CAHC9VhRV3KcNGRw6_c-97G6w=HKNuEQoUGrfKhsQdWywzDDnBQ@mail.gmail.com/
> 
> This effort is good, but it is a separate effort which is independent
> from this patch series.  This will be useful for LSMs (or hopefully
> other parts of the kernel as well) that deal with string-based
> attributes.
> 
> Even with a common hook and data structure, any LSM need to implement
> their own attribute management.  This patch series just makes a call to
> the Landlock implementation the same way UID, cgroupid, and other
> properties are retrieved.  There is no need for a wrapper interface for
> simple data types that are already handled by PIDFD_GET_INFO.
> 
> Simple property types should all be queryable with the PIDFD_GET_INFO
> IOCTL (compared to a dedicated LSM's PIDFD_GET_SECURITY IOCTL), which
> can batch queries, making it more efficient and easier to implement for
> user space.

Hm, I agree with Paul here. I'd rather see a unified PIDFD_GET_SECURITY
ioctl rather than plumbing bits of some LSMs into PIDFD_GET_INFO
directly. You can design the PIDFD_GET_SECURITY in a way that you can
get properties such as the landlock ids without any string handling.
There must be other security properties that don't want to be strings.
