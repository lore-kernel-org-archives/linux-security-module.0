Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DA3803DB;
	Mon, 27 Apr 2026 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301857; cv=none; b=jy84YlMFi13o6DPkK4o+0RrRsvpaj2KJEK4EqAgwH1zCajTeLAk3Z2qeVf4ZcviY6JfnCPt4AkNGC2V7xsNMP0pZGqPp6/1tyamLS/PpAKc7nf9k8d0QpPOSlLv9u19ZwfXbF/aA1hlN6CrGsRo2Jv4KBAB22WQTd/wTM4xMr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301857; c=relaxed/simple;
	bh=k54AbQ273apsHSbmihG65p6CQFsiF6CH6TWTe+51Sm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhhf/ARbjR0Sk23TxbXEQ4bn/6MSfKHLfu/7OHuy+yRK2DHcizOsHOmfWgAjSHSM1TF6DbFvN+IIS0FHWd6IdZvrF0c4/haTQU/DBT6ZAIk/NfuD/hE8MD/yrZF6umvwC6Qn7hemIosbuiYMplj2GozWPV8HG3fx2S9cd+8Wx+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uw09pMTF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uw09pMTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13233C2BCB5;
	Mon, 27 Apr 2026 14:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777301857;
	bh=k54AbQ273apsHSbmihG65p6CQFsiF6CH6TWTe+51Sm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uw09pMTFeSUuI8yA10vV8LDgoUIEivaXgxIYlE6tHuSX25otvKWKs6B4rkqhNbPXh
	 oA11xKOD4AGSKUFGmnNcUdnxKwq/U77Ok0GeV7/LLHJidJPHKERaYYxWgVmRuqhqGD
	 KbXHsRIrJN5ikufTMwT6lt5z61XIqcWxqVBPUWxPbnGOsl9Mv/l+6ccZZcO6G/WZmW
	 spTkQCO80wleTOLGHzYru2IecjWEIuAorsDJVZ79HehbYpTQsPjOzZt1aNm4BIDkVh
	 55rwSyJhSrK5XNK4q6jp6kkZuTQnq6hxLef4D3J6arNyIhLkS6XqmLo0YkJ9RtM7br
	 dmfc2AgAAIcOw==
Date: Mon, 27 Apr 2026 16:57:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/11] security: add LSM blob and hooks for
 namespaces
Message-ID: <20260427-belegen-euren-997f91347820@brauner>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-2-mic@digikod.net>
 <CAHC9VhT4Cd-FMYhaKgt6Gv-Suu7YJm7YbKZ-vdMwQV7EiWDryA@mail.gmail.com>
 <20260424.ein5Aiwah6Ai@digikod.net>
 <CAHC9VhRcokUR0ZKzCuZnZAyaFEMd6EH93BE3OTTKHY9Mo9pVkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRcokUR0ZKzCuZnZAyaFEMd6EH93BE3OTTKHY9Mo9pVkQ@mail.gmail.com>

On Fri, Apr 24, 2026 at 03:28:44PM -0400, Paul Moore wrote:
> On Fri, Apr 24, 2026 at 2:56 PM Mickaël Salaün <mic@digikod.net> wrote:
> > On Wed, Apr 22, 2026 at 08:19:59PM -0400, Paul Moore wrote:
> > > On Thu, Mar 12, 2026 at 6:05 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > >
> > > > From: Christian Brauner <brauner@kernel.org>
> > > >
> > > > All namespace types now share the same ns_common infrastructure. Extend
> > > > this to include a security blob so LSMs can start managing namespaces
> > > > uniformly without having to add one-off hooks or security fields to
> > > > every individual namespace type.
> > > >
> > > > Add a ns_security pointer to ns_common and the corresponding lbs_ns
> > > > blob size to lsm_blob_sizes. Allocation and freeing hooks are called
> > > > from the common __ns_common_init() and __ns_common_free() paths so
> > > > every namespace type gets covered in one go. All information about the
> > > > namespace type and the appropriate casting helpers to get at the
> > > > containing namespace are available via ns_common making it
> > > > straightforward for LSMs to differentiate when they need to.
> > > >
> > > > A namespace_install hook is called from validate_ns() during setns(2)
> > > > giving LSMs a chance to enforce policy on namespace transitions.
> > > >
> > > > Individual namespace types can still have their own specialized security
> > > > hooks when needed. This is just the common baseline that makes it easy
> > > > to track and manage namespaces from the security side without requiring
> > > > every namespace type to reinvent the wheel.
> > > >
> > > > Cc: Günther Noack <gnoack@google.com>
> > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > Link: https://lore.kernel.org/r/20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org
> > > > ---
> > > >  include/linux/lsm_hook_defs.h      |  3 ++
> > > >  include/linux/lsm_hooks.h          |  1 +
> > > >  include/linux/ns/ns_common_types.h |  3 ++
> > > >  include/linux/security.h           | 20 ++++++++
> > > >  kernel/nscommon.c                  | 12 +++++
> > > >  kernel/nsproxy.c                   |  8 +++-
> > > >  security/lsm_init.c                |  2 +
> > > >  security/security.c                | 76 ++++++++++++++++++++++++++++++
> > > >  8 files changed, 124 insertions(+), 1 deletion(-)
> 
> ...
> 
> > > > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > > > index 259c4b4f1eeb..f0b30d1907e7 100644
> > > > --- a/kernel/nsproxy.c
> > > > +++ b/kernel/nsproxy.c
> > > > @@ -379,7 +379,13 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
> > > >
> > > >  static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
> > > >  {
> > > > -       return ns->ops->install(nsset, ns);
> > > > +       int ret;
> > > > +
> > > > +       ret = ns->ops->install(nsset, ns);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       return security_namespace_install(nsset, ns);
> > > >  }
> > >
> > > Do we also want a security_namespace_switch() called from within
> > > switch_task_namespaces()?  Of course LSMs would not be able to fail or
> > > return an error at that point, but it seems reasonable that LSMs might
> > > want to update LSM state associated with the current task once the
> > > namespaces have been changed.  This is similar to all the "_post_" LSM
> > > hooks we have for various operations in the VFS and network layers.
> >
> > What cannot be infered from security_namespace_install()?
> 
> We don't actually know if the namespace is attached to a process until
> we get to switch_task_namespaces().
> 
> Now that I'm looking at this again, why is the
> security_namespace_install() call placed after the ns->ops->install()
> call?  From an access control perspective we want the LSM hook before

See https://lore.kernel.org/20260325-filmverleih-auffressen-e897fcf8d3f2@brauner
where I requested the order to be changed.
