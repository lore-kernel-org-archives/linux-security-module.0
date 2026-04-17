Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FD636C9EE
	for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2026 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448933; cv=none; b=rF1vIvv1ZHu8YPivm+HmCqoxd9cWnbWUBjBovTxVlrexN/MTzUNPiQoNWimHK5ein9eDspmjyw7rOAhJtqxvHOTlSjrKASurMM/wTN7fYWSW9qMxuKURhft0LaxvtyvA9M3uA87kyFblEiBtt/liPsRn25WbgiyLLYgygWtYm3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448933; c=relaxed/simple;
	bh=rSePFDHMeZxfVHKVi3pScGW0ErFh34Ga+BiLPTwp4/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dg4VeP2JaD0xkf2LL+cFz6FfS5dIR2+bKuT6NoTi4BoXrFB6tQFOrROyvkgHcvEgPixVB/hO80KZX9JTQJMS9JvAUFYthmN/EPl59VxRk7F+5akjFG4Ah7z3SrfnXC6t/ZLCejkHKy4qH59NZN0TLTe4ckZwfMnpiPuFr561lo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=X0FJahOp; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="X0FJahOp"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fy2lF14Z0z4Gb;
	Fri, 17 Apr 2026 20:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1776448920;
	bh=Lz+16VLXjCg00b0MHkrfi/NqmCMJJKDK6YyvO3rUux0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0FJahOpUZ2cviXAj22eZH7cwPDAuVwELvyogD6wucTuGAqr5LY5wbMxjRm9TtCOb
	 ynoSOXUmR2hzlsm9MmPJQJK2i8aUJCF1TEnU6Pms5bIHa8zVdycJE+m3nMKuikNmQE
	 szn4F5KmshQEvHlnlACmAvAQZib2cDRBlWZIk7a8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fy2lC2zKVzNrH;
	Fri, 17 Apr 2026 20:01:59 +0200 (CEST)
Date: Fri, 17 Apr 2026 20:01:50 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>
Cc: Justin Suess <utilityemal77@gmail.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org, paul@paul-moore.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, gnoack@google.com, 
	jack@suse.cz, jmorris@namei.org, serge@hallyn.com, yonghong.song@linux.dev, 
	martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, john.fastabend@gmail.com, 
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
Message-ID: <20260417.aeCheeru9The@digikod.net>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-9-utilityemal77@gmail.com>
 <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
 <aeFaQXkKNHFeE-oC@suesslenovo>
 <CAPhsuW648HdcCbXWMHaJ4uirPWq2WX3Ggx3AGMU6CGzhNYUREg@mail.gmail.com>
 <aeI_CXj6F-nI_DCL@suesslenovo>
 <20260417.ohgoh0Eecome@digikod.net>
 <CAPhsuW4g3Q4rK8GD=wCYi0iAGhcHcdh-ynsvC44f8rE8OuTqTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4g3Q4rK8GD=wCYi0iAGhcHcdh-ynsvC44f8rE8OuTqTg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Apr 17, 2026 at 09:10:31AM -0700, Song Liu wrote:
> On Fri, Apr 17, 2026 at 8:18 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Fri, Apr 17, 2026 at 10:09:13AM -0400, Justin Suess wrote:
> [...]
> > > > A new type of map for each FD referenced kernel type is non-starter.
> > > > It is impossible to add UAPI for a specific use case.
> >
> > This new map type is only about one file descriptor type, similarly to
> > socket FDs.  From a UAPI point of view, it looks clean and safe,
> > especially to deal with underlying object lifetime (e.g. reference
> > tracking).
> 
> We have changed the UAPI policy. New program type, new map type
> will not be added for a single use case.

Ok, I didn't know.

> 
> > > >
> > > You've convinced me. I could see a lot of problems if everyone wanting
> > > to add their specialized maps, it would be difficult to maintain.
> >
> > Is there another way to properly handle kernel object lifetime (not tied
> > to the caller) and pass them as file descriptor?
> 
> bpf_kptr gives same life time promise.

Ok, that could work if we can transform an FD to a kptr.

> 
> > >
> > > It's probably best to keep the specialized map types to core kernel
> > > interfaces only that are unlikely to change.
> >
> > File descriptors are a stable interface.
> 
> Maybe we can add a new map type that can handle file descriptor of
> any type.

Good idea, that would be much more generic indeed.  Maybe we could
add a new file_operations function specific to BPF so that each file
descriptor type can make their type supported by this new map type while
making sure only tested/reviewed FD type can be added to this map?
Something like file_operation.to_bpf_kptr(struct file *file)?

> I haven't thought about all the details. Maybe we don't need
> a new map type for this either. Instead, some new kfunc may be
> sufficient to make bpf_kptr work.
> 
> OTOH, adding a new map type just for landlock rulesets is not gonna
> happen.
> 
> Thanks,
> Song
> 
