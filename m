Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26D3F7897
	for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056988; cv=none; b=cXOP2vYrdlHgXusJA3C+dAUFKgzOnvODIk2qeoZmIpGiXpo4n2dCZhKrdn7m7rQfM/Kc0asilvXI1g41HpPu/pj67cn+zPc1Sxlnx6ZPPsbBapIxuugK1C2KGRryO83i7eXfwk43xyaWw/j0AqTtkkDlPlX22nkshUdGtLGJJLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056988; c=relaxed/simple;
	bh=KVVVGzA3n6MMJsqhwCsBZ0VRZ+BD7xZJa/yFcAbXjKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrLyjyjWuVkpMEir2mGBk7UgxRnIoVqgrDC6rQod9PGvRUIkvQZMF1aXzRq6eHXFFRQ9tB29d9KQicdnQjr0OThDcazQ5mrPGnOQfk6qGgwjONxwwl3v/gzMDRyjBS7TnGOmHxamNW/d5/HkH80cL/lIqRI/subE09zVHtpIMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vf5ANPdS; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vf5ANPdS"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g2Mcf3Wt2zhss;
	Fri, 24 Apr 2026 20:56:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1777056978;
	bh=VxH1Tt4dyMOqOJAkq4W5TU3Gk8WrdXWzZZN/fwS5uZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vf5ANPdSCwelcyQIi+DWS7ne2F9ByMB7kQkIY88OIhycn5nfdVIf6GaoN1EVOmLmM
	 3gGrD8ZVj1ocUjAE8+wI7gccerii4k+eYWa87p8qlPVAUgjN7dwlEez6Ezgm8NqNBl
	 7efc3a/ZhizZtExgekx4E9qw0pxtfU7yhSkblMes=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4g2Mcc5xGlz8TR;
	Fri, 24 Apr 2026 20:56:16 +0200 (CEST)
Date: Fri, 24 Apr 2026 20:56:12 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/11] security: add LSM blob and hooks for
 namespaces
Message-ID: <20260424.ein5Aiwah6Ai@digikod.net>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-2-mic@digikod.net>
 <CAHC9VhT4Cd-FMYhaKgt6Gv-Suu7YJm7YbKZ-vdMwQV7EiWDryA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT4Cd-FMYhaKgt6Gv-Suu7YJm7YbKZ-vdMwQV7EiWDryA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Apr 22, 2026 at 08:19:59PM -0400, Paul Moore wrote:
> On Thu, Mar 12, 2026 at 6:05 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > From: Christian Brauner <brauner@kernel.org>
> >
> > All namespace types now share the same ns_common infrastructure. Extend
> > this to include a security blob so LSMs can start managing namespaces
> > uniformly without having to add one-off hooks or security fields to
> > every individual namespace type.
> >
> > Add a ns_security pointer to ns_common and the corresponding lbs_ns
> > blob size to lsm_blob_sizes. Allocation and freeing hooks are called
> > from the common __ns_common_init() and __ns_common_free() paths so
> > every namespace type gets covered in one go. All information about the
> > namespace type and the appropriate casting helpers to get at the
> > containing namespace are available via ns_common making it
> > straightforward for LSMs to differentiate when they need to.
> >
> > A namespace_install hook is called from validate_ns() during setns(2)
> > giving LSMs a chance to enforce policy on namespace transitions.
> >
> > Individual namespace types can still have their own specialized security
> > hooks when needed. This is just the common baseline that makes it easy
> > to track and manage namespaces from the security side without requiring
> > every namespace type to reinvent the wheel.
> >
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Serge E. Hallyn <serge@hallyn.com>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > Link: https://lore.kernel.org/r/20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org
> > ---
> >  include/linux/lsm_hook_defs.h      |  3 ++
> >  include/linux/lsm_hooks.h          |  1 +
> >  include/linux/ns/ns_common_types.h |  3 ++
> >  include/linux/security.h           | 20 ++++++++
> >  kernel/nscommon.c                  | 12 +++++
> >  kernel/nsproxy.c                   |  8 +++-
> >  security/lsm_init.c                |  2 +
> >  security/security.c                | 76 ++++++++++++++++++++++++++++++
> >  8 files changed, 124 insertions(+), 1 deletion(-)
> 
> ...
> 
> > diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> > index bdc3c86231d3..de774e374f9d 100644
> > --- a/kernel/nscommon.c
> > +++ b/kernel/nscommon.c
> > @@ -77,6 +81,13 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
> >                 ret = proc_alloc_inum(&ns->inum);
> >         if (ret)
> >                 return ret;
> > +
> > +       ret = security_namespace_alloc(ns);
> > +       if (ret) {
> > +               proc_free_inum(ns->inum);
> > +               return ret;
> > +       }
> 
> Since this is an RFC, I'll make the nitpicky comment that it would be
> better if the LSM hook is called security_namespace_init() instead of
> security_namespace_alloc().  This fits better with the convention of
> aligning with the caller's name, as well as to helps to indicate that
> the LSMs will be initializing the LSM state associated with the
> ns_common instance.

Looks good.

> 
> > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > index 259c4b4f1eeb..f0b30d1907e7 100644
> > --- a/kernel/nsproxy.c
> > +++ b/kernel/nsproxy.c
> > @@ -379,7 +379,13 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
> >
> >  static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
> >  {
> > -       return ns->ops->install(nsset, ns);
> > +       int ret;
> > +
> > +       ret = ns->ops->install(nsset, ns);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return security_namespace_install(nsset, ns);
> >  }
> 
> Do we also want a security_namespace_switch() called from within
> switch_task_namespaces()?  Of course LSMs would not be able to fail or
> return an error at that point, but it seems reasonable that LSMs might
> want to update LSM state associated with the current task once the
> namespaces have been changed.  This is similar to all the "_post_" LSM
> hooks we have for various operations in the VFS and network layers.

What cannot be infered from security_namespace_install()?

> 
> I think we would want to pass both the task_struct and whichever
> nsproxy instance is not stored in the task_struct to the hook.  I
> prefer placing the hook after the task_struct has been updated, but if
> anyone feels strongly that it should be the other way that's okay with
> me.
> 
> > diff --git a/security/security.c b/security/security.c
> > index 67af9228c4e9..dcf073cac848 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > +/**
> > + * security_namespace_free() - Release LSM security data from a namespace
> > + * @ns: the namespace being freed
> > + *
> > + * Release security data attached to the namespace. Called before the
> > + * namespace structure is freed.
> > + *
> > + * Note: The namespace may be freed via kfree_rcu(). LSMs must use
> > + * RCU-safe freeing for any data that might be accessed by concurrent
> > + * RCU readers.
> > + */
> > +void security_namespace_free(struct ns_common *ns)
> > +{
> > +       if (!ns->ns_security)
> > +               return;
> > +
> > +       call_void_hook(namespace_free, ns);
> > +
> > +       kfree(ns->ns_security);
> > +       ns->ns_security = NULL;
> > +}
> 
> The "namespace may be freed via kfree_rcu()" comment in conjunction
> with the standard kfree() in the function above raises a red flag.  Do
> we need to take an approach similar to
> security_inode_free()/inode_free_by_rcu() here?

I though at that too, but the key point is that once the namespace is
being freed it is not reachable, which is not the case for inode being
freed (i.e. because of path walks).  So I think the current approach is
fine even if the comment might be a bit scary.

> 
> -- 
> paul-moore.com
> 
