Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16718A94F
	for <linux-security-module@vger.kernel.org>; Tue, 20 Aug 2024 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157948; cv=none; b=HEZfO27+DgOazRXbwJMVuWEOm/MICvz2WDqDdX/rRvoZiT6KdvzjzwwtfDrk5qyrS/9c6n4Rf/l5aZuE0WY/bJJVbkHdWUTCUc31Uk4Bl+0ndaCcTNCebsQZilEJvzcvmsf/VvauHYCHHmfqQX6iNpP/GXRKc6FArPqHfUPdyIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157948; c=relaxed/simple;
	bh=6nZ0fdWSnRK8LVtZlGyegkIEvCJqj+7vyDUQY2t903Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngbv6CCZPHn11K9a4/AgDcLYfeUhljOjJbV2z0UyShvj4D3BHkCeyCTv85DdTAK2etkO8Ni2tpkhfBaSbJc2+0po5Ede44aUGhfDk7dfX+x7cVe4tgM3vnljugv8TqIQPZDeKioAoxKoMAVmd73+JLiefrOeLDWYEB2r/ESBy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=KNJiIrty; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="KNJiIrty"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wp8MT6jgJzcxM;
	Tue, 20 Aug 2024 14:45:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724157941;
	bh=TjMOZKk3up8LjctHxJlNFGMdHodR88lii8lU12z22GE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNJiIrty8Rt788JK7m3oWK9hyLpQum6zQBRcazUNlRO9Q4lMig1HpswGp6jnul8K8
	 3BxrKOmA/4NReQKKFmAoe1PN/GqXIAyiUY9SOZwxzjEnFF/l/ySxkVkArDkXVfboGW
	 GAYIhZc/95WuaYK8Ov8Hc/jJ36A24E5kfJehi2a4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wp8MS6YypzsD9;
	Tue, 20 Aug 2024 14:45:40 +0200 (CEST)
Date: Tue, 20 Aug 2024 14:45:36 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <songliubraving@meta.com>
Cc: Christian Brauner <brauner@kernel.org>, Song Liu <song@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, Liam Wisehart <liamwisehart@meta.com>, 
	Liang Tang <lltang@meta.com>, Shankaran Gnanashanmugam <shankaran@meta.com>, 
	LSM List <linux-security-module@vger.kernel.org>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Message-ID: <20240820.eeshaiz3Zae6@digikod.net>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
 <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com>
 <20240819-keilen-urlaub-2875ef909760@brauner>
 <20240819.Uohee1oongu4@digikod.net>
 <370A8DB0-5636-4365-8CAC-EF35F196B86F@fb.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <370A8DB0-5636-4365-8CAC-EF35F196B86F@fb.com>
X-Infomaniak-Routing: alpha

On Mon, Aug 19, 2024 at 08:35:53PM +0000, Song Liu wrote:
> Hi Mickaël, 
> 
> > On Aug 19, 2024, at 6:12 AM, Mickaël Salaün <mic@digikod.net> wrote:
> 
> [...]
> 
> >> But because landlock works with a deny-by-default security policy this
> >> is ok and it takes overmounts into account etc.
> > 
> > Correct. Another point is that Landlock uses the file's path (i.e.
> > dentry + mnt) to walk down to the parent.  Only using the dentry would
> > be incorrect for most use cases (i.e. any system with more than one
> > mount point).
> 
> Thanks for highlighting the difference. Let me see whether we can bridge
> the gap for this set. 
> 
> [...]
> 
> >>> 
> >>> 1. Change security_inode_permission to take dentry instead of inode.
> >> 
> >> Sorry, no.
> >> 
> >>> 2. Still add bpf_dget_parent. We will use it with security_inode_permission
> >>>   so that we can propagate flags from parents to children. We will need
> >>>   a bpf_dput as well. 
> >>> 3. There are pros and cons with different approaches to implement this
> >>>   policy (tags on directory work for all files in it). We probably need 
> >>>   the policy writer to decide with one to use. From BPF's POV, dget_parent
> >>>   is "safe", because it won't crash the system. It may encourage some bad
> >>>   patterns, but it appears to be required in some use cases.
> >> 
> >> You cannot just walk a path upwards and check permissions and assume
> >> that this is safe unless you have a clear idea what makes it safe in
> >> this scenario. Landlock has afaict. But so far you only have a vague
> >> sketch of checking permissions walking upwards and retrieving xattrs
> >> without any notion of the problems involved.
> > 
> > Something to keep in mind is that relying on xattr to label files
> > requires to deny sanboxed processes to change this xattr, otherwise it
> > would be trivial to bypass such a sandbox.  Sandboxing must be though as
> > a whole and Landlock's design for file system access control takes into
> > account all kind of file system operations that could bypass a sandbox
> > policy (e.g. mount operations), and also protects from impersonations.
> 
> Thanks for sharing these experiences! 
> 
> > What is the use case for this patch series?  Couldn't Landlock be used
> > for that?
> 
> We have multiple use cases. We can use Landlock for some of them. The 
> primary goal of this patchset is to add useful building blocks to BPF LSM
> so that we can build effective and flexible security policies for various
> use cases. These building blocks alone won't be very useful. For example,
> as you pointed out, to make xattr labels useful, we need some policies 
> for xattr read/write.
> 
> Does this make sense?

Yes, but I think you'll end up with a code pretty close to the Landlock
implementation.

What about adding BPF hooks to Landlock?  User space could create
Landlock sandboxes that would delegate the denials to a BPF program,
which could then also allow such access, but without directly handling
nor reimplementing filesystem path walks.  The Landlock user space ABI
changes would mainly be a new landlock_ruleset_attr field to explicitly
ask for a (system-wide) BPF program to handle access requests if no
Landlock rule allow them.  We could also tie a BPF data (i.e. blob) to
Landlock domains for consistent sandbox management.  One of the
advantage of this approach is to only run related BPF programs if the
sandbox policy would deny the request.  Another advantage would be to
leverage the Landlock user space interface to let any program partially
define and extend their security policy.

I'm working on implementing audit support for Landlock [1] and I think
these changes could be useful to implement BPF hooks to run a dedicated
BPF program type per event (see landlock_log_denial() and struct
landlock_request).  I'll get back on this patch series in September.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=wip-audit
