Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08EE2F260C;
	Fri, 17 Apr 2026 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439105; cv=none; b=u3MrNHPUiFM8B7T7EVHiIWE51FAzcRL4a/8sTn5Snr1O+L0i0W9ObTVaq9//2zVlm0ppzG30r3xTcYzqYHv8aCNz0HcGuUe1w5LFcpsNwUlr8D97sbLp3AjQnhUmtpnDZ3C/S2d+O/2h6BXU2pODz7lNaTgC99nJCIJTTTNQwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439105; c=relaxed/simple;
	bh=WUoIk2YrUtGxyINUDnF36G5a2VmwxFchcmghsjAdP54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2wc0g3AoMliZUmHQwRFGtVz8udD+Kz5eOyKcCKYJbxVryjudLd0Vk5/YxRCD013GfVXqQKYZ8osgGXBzQtO6SZQ0/pdPLHKeObZDePOd2LbjgrCf6HGszjvpdrJ8dWOno6geqlikRQnawihUsFbYY6VzpHPnKawTChtyWDzivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cm5NGpNp; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cm5NGpNp"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fxz6D1VT1zMhp;
	Fri, 17 Apr 2026 17:18:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1776439091;
	bh=fBTJ6d+x4OlIr1oVwOfzUtW9SrmNkEZwqchmlYFYgSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cm5NGpNpzxUwuAf8Vg+rCleQaZxv8svbEblwFBlJQyCNBeb12A/X+Ts/7ZYiwqCSy
	 /Z689+YK8ZdAP5FMwpVHeDwl+rpm0M4tyaNinzoqJlgPxP+HWXH9Ya/TLPKIo4RWn7
	 LEQEOfhLJzVE++rDXp1k8+HPvPOgwnfR2DH9+4eY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fxz6B13VWz9Tb;
	Fri, 17 Apr 2026 17:18:10 +0200 (CEST)
Date: Fri, 17 Apr 2026 17:18:05 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, kpsingh@kernel.org, paul@paul-moore.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	jmorris@namei.org, serge@hallyn.com, yonghong.song@linux.dev, martin.lau@linux.dev, 
	m@maowtm.org, eddyz87@gmail.com, john.fastabend@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
Message-ID: <20260417.ohgoh0Eecome@digikod.net>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-9-utilityemal77@gmail.com>
 <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
 <aeFaQXkKNHFeE-oC@suesslenovo>
 <CAPhsuW648HdcCbXWMHaJ4uirPWq2WX3Ggx3AGMU6CGzhNYUREg@mail.gmail.com>
 <aeI_CXj6F-nI_DCL@suesslenovo>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeI_CXj6F-nI_DCL@suesslenovo>
X-Infomaniak-Routing: alpha

On Fri, Apr 17, 2026 at 10:09:13AM -0400, Justin Suess wrote:
> On Thu, Apr 16, 2026 at 04:47:40PM -0700, Song Liu wrote:
> > On Thu, Apr 16, 2026 at 2:53 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > [...]
> > > I don't think we can pass the FD number via a map, since the FD is
> > > process specific. And it needs to be done in a way where we can lookup
> > > the specific ruleset the FD points to safely.
> > >
> > > So we'd need some other way to load the ruleset from a file descriptor,
> > > either through a new userspace side BPF call or similar mechanism.
> > >
> > > Is there some other common pattern for FDs --> kptr I can follow?
> > 
> > I didn't find an exact example like this. There must be a way to achieve
> > this. In the worst case, we can add a kfunc for this.
> >
> 
> I think new kfunc is a doable approach. I could make a kfunc taking a struct
> *task_struct and an FD that looks up a landlock ruleset within a given
> task that returns a trusted kptr.
> 
> Something like:
> 
> struct bpf_landlock_ruleset* bpf_landlock_get_ruleset_from_fd(struct
> task_struct* task, int fd)

That looks like a hack that would not handle FD's (object) lifetime
(e.g. what happen when the task is gone?).

Why not using proper typing with a dedicated map?

> 
> And tagging it with KF_ACQUIRE + KF_RET_NULL.
> 
> Then keep the existing kfunc for putting the ruleset and enforcing it on
> a struct linux_binprm.
> 
> The BPF program would need to get a reference to a task struct
> of the program creating the rulesets with bpf_task_from_pid for
> instance. Then they could use the task_struct with another plain integer
> map to store FD numbers and then use the rulesets or store them in a map
> of __kptr objects for later usage.
> 
> Would this be more acceptable?
> > > Basically the pattern I need is userspace must create the file
> > > descriptor, BPF converts that FD into a refcounted kernel object, and
> > > even if userspace closes the FD BPF needs to hold a reference on the
> > > underlying ruleset structure.
> > >
> > > (In this patch this was accomplished through the map_ops)
> > >
> > > Let me know what you think Song. I do understand the benefit of having a
> > > __kptr instead, the refcounting is all there, and it would allow storing
> > > rulesets in multiple map types. (and one less map type to maintain).
> > 
> > A new type of map for each FD referenced kernel type is non-starter.
> > It is impossible to add UAPI for a specific use case.

This new map type is only about one file descriptor type, similarly to
socket FDs.  From a UAPI point of view, it looks clean and safe,
especially to deal with underlying object lifetime (e.g. reference
tracking).

> >
> You've convinced me. I could see a lot of problems if everyone wanting
> to add their specialized maps, it would be difficult to maintain.

Is there another way to properly handle kernel object lifetime (not tied
to the caller) and pass them as file descriptor?

> 
> It's probably best to keep the specialized map types to core kernel
> interfaces only that are unlikely to change.

File descriptors are a stable interface.

> 
> > Thanks,
> > Song
> > 
> > > Mickaël, do you have any thoughts on this? I have v2 basically ready,
> > > although it uses the BPF_MAP_TYPE_LANDLOCK_RULESET it changes a lot on
> > > the Landlock side.
> 
