Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10201DED60;
	Mon, 28 Oct 2024 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134265; cv=none; b=lD8mPL2836lgzgtYTfbTA9LyQCy3PWv0mtIhqiouQaql8Aa5Fx+XHy/wGjx3WNHGJh+en7TfWZZ5Ucmy0YypdPmC3AZojQkP4A5v9MYs25yyJ0qMapcP1feOEwHuhSAnS4Q8krDvhrdfZ6e+eyUsOwSqHbkIhi82Mt7EOjkEcGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134265; c=relaxed/simple;
	bh=3mc0rQlOq9b8mi6tNmVCTb7CFWCY+xgZLvTGN3e6jTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZY8Ha8VY+XvAi4zt51cQjO7LxM772K/PFB7dclR9cktyAdg/DkQ01zMbF/kM9RafTfZ3JJqmyDkXNZzL1PGWwfkobHWU7C2wREXZrvB5Rj1CtGxYOM5wF6GI3L7pZ9GDWtMxjlqPpr3oSRHfdNSOjSVtjXB/X2BCP+T4b7d1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pyxuim9V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pyxuim9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87144C4CEC3;
	Mon, 28 Oct 2024 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730134265;
	bh=3mc0rQlOq9b8mi6tNmVCTb7CFWCY+xgZLvTGN3e6jTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pyxuim9VRM6PM4NQ3mg4YD2ifL86Vy4/OHWuozGp0x3L9/H1705vwboVSlAMOyKc6
	 W4kW5flPaGqNe5+eCWHX6GB5ABZ3Q8rxGB8jW0Psla5hAkMBkVCdzE4/Rzl7MZ51uj
	 yMvbFrZ+33nCUuBCsfH6fOD8dKztmEXhkOBwqO9P0M6WOPYxKzs310af79b02vOMN2
	 FxOynCM4Ea/+6Ra4wdFpQKMyYPmeygVFftMsqsUzeATEHp1sfUCCUgv95SdHDOAQBg
	 WPrvUyy5cE+56QNEhE3raD3Q3iJhgZYQBw9M4X3xo9Snr78IpXQd/sFdYA80D2MWoc
	 pjIXH3EklyDqQ==
Date: Mon, 28 Oct 2024 16:51:00 +0000
From: sergeh@kernel.org
To: Jordan Rome <jordan@jordanrome.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [v2] security: add trace event for cap_capable
Message-ID: <Zx_A9FO2XsCrWr8e@lei>
References: <20241025151128.1854905-1-linux@jordanrome.com>
 <CAEf4BzYsQsj50hJut3+a4NUenZ+6ajfaFL_31NcvBdyoeBTiPg@mail.gmail.com>
 <20241025195228.GA99159@mail.hallyn.com>
 <CA+QiOd6Ef6V2=DeAc=8VdCJhRtxG5eZCBOPiMzedob1ARnR-zg@mail.gmail.com>
 <20241026100956.GA105650@mail.hallyn.com>
 <CA+QiOd6R4VcdqtaM3LX47Vjffuk_rSsdra4bdhe1i-+NGK7NDQ@mail.gmail.com>
 <20241026130011.GA106868@mail.hallyn.com>
 <CA+QiOd7GeAaZgps80dyAFpOV=uMQssaBLuHXb-dQBBs85RWKgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+QiOd7GeAaZgps80dyAFpOV=uMQssaBLuHXb-dQBBs85RWKgQ@mail.gmail.com>

On Sun, Oct 27, 2024 at 02:21:26PM -0400, Jordan Rome wrote:
> On Sat, Oct 26, 2024 at 9:00 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Sat, Oct 26, 2024 at 07:22:29AM -0400, Jordan Rome wrote:
> > > On Sat, Oct 26, 2024 at 6:10 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > > >
> > > > On Fri, Oct 25, 2024 at 04:24:05PM -0400, Jordan Rome wrote:
> > > > > On Fri, Oct 25, 2024 at 3:52 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 25, 2024 at 11:37:59AM -0700, Andrii Nakryiko wrote:
> > > > > > > On Fri, Oct 25, 2024 at 8:15 AM Jordan Rome <linux@jordanrome.com> wrote:
> > > > > > > >
> > > > > > > > In cases where we want a stable way to observe/trace
> > > > > > > > cap_capable (e.g. protection from inlining and API updates)
> > > > > > > > add a tracepoint that passes:
> > > > > > > > - The credentials used
> > > > > > > > - The user namespace of the resource being accessed
> > > > > > > > - The user namespace that has the capability to access the
> > > > > > > > targeted resource
> > > > > > > > - The capability to check for
> > > > > > > > - Bitmask of options defined in include/linux/security.h
> > > > > > > > - The return value of the check
> > > > > > > >
> > > > > > > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > > > > > > ---
> > > > > > > >  MAINTAINERS                       |  1 +
> > > > > > > >  include/trace/events/capability.h | 60 +++++++++++++++++++++++++++++++
> > > > > > > >  security/commoncap.c              | 31 +++++++++++-----
> > > > > > > >  3 files changed, 84 insertions(+), 8 deletions(-)
> > > > > > > >  create mode 100644 include/trace/events/capability.h
> > > > > > > >
> > > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > > index cc40a9d9b8cd..210e9076c858 100644
> > > > > > > > --- a/MAINTAINERS
> > > > > > > > +++ b/MAINTAINERS
> > > > > > > > @@ -4994,6 +4994,7 @@ M:        Serge Hallyn <serge@hallyn.com>
> > > > > > > >  L:     linux-security-module@vger.kernel.org
> > > > > > > >  S:     Supported
> > > > > > > >  F:     include/linux/capability.h
> > > > > > > > +F:     include/trace/events/capability.h
> > > > > > > >  F:     include/uapi/linux/capability.h
> > > > > > > >  F:     kernel/capability.c
> > > > > > > >  F:     security/commoncap.c
> > > > > > > > diff --git a/include/trace/events/capability.h b/include/trace/events/capability.h
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..e706ce690c38
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/include/trace/events/capability.h
> > > > > > > > @@ -0,0 +1,60 @@
> > > > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > > > +#undef TRACE_SYSTEM
> > > > > > > > +#define TRACE_SYSTEM capability
> > > > > > > > +
> > > > > > > > +#if !defined(_TRACE_CAPABILITY_H) || defined(TRACE_HEADER_MULTI_READ)
> > > > > > > > +#define _TRACE_CAPABILITY_H
> > > > > > > > +
> > > > > > > > +#include <linux/cred.h>
> > > > > > > > +#include <linux/tracepoint.h>
> > > > > > > > +#include <linux/user_namespace.h>
> > > > > > > > +
> > > > > > > > +/**
> > > > > > > > + * cap_capable - called after it's determined if a task has a particular
> > > > > > > > + * effective capability
> > > > > > > > + *
> > > > > > > > + * @cred: The credentials used
> > > > > > > > + * @targ_ns: The user namespace of the resource being accessed
> > > > > > > > + * @capable_ns: The user namespace in which the credential provides the
> > > > > > > > + *              capability to access the targeted resource.
> > > > > > > > + *              This will be NULL if ret is not 0.
> > > > > > > > + * @cap: The capability to check for
> > > > > > > > + * @opts: Bitmask of options defined in include/linux/security.h
> > > > > > > > + * @ret: The return value of the check: 0 if it does, -ve if it does not
> > > > > > > > + *
> > > > > > > > + * Allows to trace calls to cap_capable in commoncap.c
> > > > > > > > + */
> > > > > > > > +TRACE_EVENT(cap_capable,
> > > > > > > > +
> > > > > > > > +       TP_PROTO(const struct cred *cred, struct user_namespace *targ_ns,
> > > > > > > > +               struct user_namespace *capable_ns, int cap, unsigned int opts, int ret),
> > > > > > > > +
> > > > > > > > +       TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
> > > > > > > > +
> > > > > > > > +       TP_STRUCT__entry(
> > > > > > > > +               __field(const struct cred *, cred)
> > > > > > > > +               __field(struct user_namespace *, targ_ns)
> > > > > > > > +               __field(struct user_namespace *, capable_ns)
> > > > > > > > +               __field(int, cap)
> > > > > > > > +               __field(unsigned int, opts)
> > > > > > > > +               __field(int, ret)
> > > > > > > > +       ),
> > > > > > > > +
> > > > > > > > +       TP_fast_assign(
> > > > > > > > +               __entry->cred       = cred;
> > > > > > > > +               __entry->targ_ns    = targ_ns;
> > > > > > > > +               __entry->capable_ns = capable_ns;
> > > > > > > > +               __entry->cap        = cap;
> > > > > > > > +               __entry->opts       = opts;
> > > > > > > > +               __entry->ret        = ret;
> > > > > > > > +       ),
> > > > > > > > +
> > > > > > > > +       TP_printk("cred %p, targ_ns %p, capable_ns %p, cap %d, opts %u, ret %d",
> > > > > > > > +               __entry->cred, __entry->targ_ns, __entry->capable_ns, __entry->cap,
> > > > > > > > +               __entry->opts, __entry->ret)
> > > > > > > > +);
> > > > > > > > +
> > > > > > > > +#endif /* _TRACE_CAPABILITY_H */
> > > > > > > > +
> > > > > > > > +/* This part must be outside protection */
> > > > > > > > +#include <trace/define_trace.h>
> > > > > > > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > > > > > > index 162d96b3a676..12c3ddfe0d6e 100644
> > > > > > > > --- a/security/commoncap.c
> > > > > > > > +++ b/security/commoncap.c
> > > > > > > > @@ -27,6 +27,9 @@
> > > > > > > >  #include <linux/mnt_idmapping.h>
> > > > > > > >  #include <uapi/linux/lsm.h>
> > > > > > > >
> > > > > > > > +#define CREATE_TRACE_POINTS
> > > > > > > > +#include <trace/events/capability.h>
> > > > > > > > +
> > > > > > > >  /*
> > > > > > > >   * If a non-root user executes a setuid-root binary in
> > > > > > > >   * !secure(SECURE_NOROOT) mode, then we raise capabilities.
> > > > > > > > @@ -52,7 +55,7 @@ static void warn_setuid_and_fcaps_mixed(const char *fname)
> > > > > > > >  /**
> > > > > > > >   * cap_capable - Determine whether a task has a particular effective capability
> > > > > > > >   * @cred: The credentials to use
> > > > > > > > - * @targ_ns:  The user namespace in which we need the capability
> > > > > > > > + * @targ_ns:  The user namespace of the resource being accessed
> > > > > > > >   * @cap: The capability to check for
> > > > > > > >   * @opts: Bitmask of options defined in include/linux/security.h
> > > > > > > >   *
> > > > > > > > @@ -68,6 +71,7 @@ int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
> > > > > > > >                 int cap, unsigned int opts)
> > > > > > > >  {
> > > > > > > >         struct user_namespace *ns = targ_ns;
> > > > > > > > +       int ret = -EPERM;
> > > > > > > >
> > > > > > > >         /* See if cred has the capability in the target user namespace
> > > > > > > >          * by examining the target user namespace and all of the target
> > > > > > > > @@ -75,22 +79,32 @@ int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
> > > > > > > >          */
> > > > > > > >         for (;;) {
> > > > > > > >                 /* Do we have the necessary capabilities? */
> > > > > > > > -               if (ns == cred->user_ns)
> > > > > > > > -                       return cap_raised(cred->cap_effective, cap) ? 0 : -EPERM;
> > > > > > > > +               if (ns == cred->user_ns) {
> > > > > > > > +                       if (cap_raised(cred->cap_effective, cap))
> > > > > > > > +                               ret = 0;
> > > > > > > > +                       else
> > > > > > > > +                               ns = NULL;
> > > > > > >
> > > > > > > This is a bit unfortunate :( so maybe all we needed was `ns =
> > > > > > > ns->parent` for that one use case, and keep the original `ret ? NULL :
> > > > > > > ns` inside trace_cap_capable().
> > > > > >
> > > > > > Yeah, that would be fine with me.  Or maybe just doing
> > > > > >
> > > > > >         /* in case of an error, trace should show ns=NULL */
> > > > > >         if (ret)
> > > > > >                 ns = NULL;
> > > > > >
> > > > > > right above the trace_cap_capable() call would be clearer.
> > > > >
> > > > > I feel like having less trace specific logic in this function would be
> > > > > a good thing,
> > > > > so I'm for Andrii's suggestion of doing the ret check there but also
> > > > > fine to do what security folks prefer :)
> > > >
> > > > I think a comment is needed to remind us (me) in 2 years why the
> > > > seting of ns to NULL is there.  But the comment of trace_cap_capable()
> > > > probably suffices, so sure, go with Andrii's suggestion.  And then
> > > >
> > > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > > >
> > > > for the capability code.
> > > >
> > > > thanks,
> > > > -serge
> > >
> > > I think we're suggesting to not set ns = NULL here and instead
> > > check the ret value in the trace code e.g.
> > > `__entry->capable_ns = ret ? NULL : capable_ns;`
> >
> > Perfect.  Was originally going to suggest this, but then thought well
> > the rest of the ns logic is purely capability not tracing related.
> > But since the comment is in trace_cap_capable(), putting the assignment
> > there makes sense.
> >
> 
> Actually, I had another idea. What about just having a separate
> variable in the `cap_capable` function for `capable_ns` that only gets
> set if ret is 0. Then we're not changing the `ns` variable at all for
> the purposes of the trace function.

FWIW that sounds great.

-serge
