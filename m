Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120233;
	b=i2zrXDteqQqcUPxHH7obzcL+iPDveecyIJTu4qNU9AKiVSjtKUtDWpCzk3rLD8hMYncR
	 oKR1Nu9Kr4X52NW6bQntiV/+NSgYJRXQSpCNAtL8MdIV8A0RIGub4gMOq4/WNDc339aeh
	 2N1qjR3uhw/0NCV2NdlrEHvRd7Dhehkvd0IRMjQ5Pu9RCgYIBV8eW8UCokiOqdrHtEF3t
	 HJvcVRGfLVEcc4D6imC9orKd3Fxoa/FALtCatwfC3U6iBsy7NuSl7FbvnGQ+Es2RCvT5N
	 zwjrO6bsY6pohG9bvkYTgaLqpZHFWzLL6p8QpiIKsBR3Hp5U6PcSI2bVvB7g4jJID6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120233;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uZfqPY3Erv/g9mQt4k+Coj1gdlGms1HCX62UMjguoFM=;
	b=CQ9iKydHjuZiwrWH2bNQWx6+IB6sV2p8wAlBjVYcYPpDOym4Unj6ZoYfEshy21YkdCN1
	 V5km8YD0D57GT2edkWO+8Ojyg4dtlAhGtsAjgAvhQ2yblExMLbAxtqe0djqYpc9PL5Xxc
	 T+phBESfS37S0VXdDDO+uRn+jGvA43MlwLtWhoJ25OI5u9ezvWRPIGEm0nfBvgZ/aAJtW
	 K97NCw6Sdp2KqSu5NQHgkPeo8ABBS7yd1Y7oNh1lJ2eX/zygNcMmrMYhlY17GZECa+/EN
	 KoefmLBQurzfZhVyQiIjhtbbB2/ygsfeBdyZ4XWdeFUq9uKkVwszjxStfAi75Qo3P7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h45kPzaH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF784606A31F;
	Tue, 27 Oct 2026 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h45kPzaH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D37E1F01825;
	Tue, 27 Oct 2026 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793120232;
	bh=uZfqPY3Erv/g9mQt4k+Coj1gdlGms1HCX62UMjguoFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h45kPzaHDhEmZmxxzBvN2+CDEbdEm0+mt6GRoI7wRvz4n1HF7cvhWDVPmaOTBnF1o
	 IFtcCipfw1D0tHcXiDt7GLPRJAu2IR48LCLriMwZItMjX9kHZGS5thjqZIPd6rC2dZ
	 3gQ1qAdTzk3RpOOpQjhCdseY4xP3ji5ToY8JRsgMlBnL2jEmS6oLZR/5FGjPDp8dEs
	 QqClY/jNpHblc8QhmWi0lQYKcjg0StU9r6AaSnDxqOa6QgIVA/5+N+OpBwkxA8OGU4
	 sXLgGWXSw77DX6FJp+7jgKHmk1Hj+8V8Pcvbipe/IpILejomUcTT8/7lsDjDUQSK2r
	 i5ljJZN00awjQ==
Date: Tue, 27 Oct 2026 16:57:04 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Andrey Vagin <avagin@gmail.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/3] mseal sysmap: Add mseal_system_mappings= boot
 parameter
Message-ID: <auDTptDQsB4xBcz7@gremlin>
References: <cover.1793094611.git.chris@chrisdown.name>
 <5bd3c89d733ad22224f296dfa8900769de937de0.1793094611.git.chris@chrisdown.name>
 <auCxjbvY3qPv1sV6@gremlin>
 <auDTMb6WMFUpxeZy@chrisdown.name>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auDTMb6WMFUpxeZy@chrisdown.name>

On Wed, Oct 28, 2026 at 12:37:05AM +0800, Chris Down wrote:
> Hi Lorenzo,
>
> Thanks for the quick and thorough review!

No worries!

>
> Lorenzo Stoakes (ARM) writes:
> > The existing implementation is a bit of a mess, so any work that extends it
> > has to put in the work to improve things first.
> >
> > I _hate_ VM_SEALED_SYSMAP. It's a hack. A tasteful way of doing this is
> > really required for a series touching this to be taken, honestly.
> >
> > See below for implementation ideas.
>
> That's fair, I'll do the cleanup first in v2.

Thanks!

>
> > (Also it's the merge window, so no more revisions until -rc1, when you need
> > to resend, thanks.)
>
> Sure, I'll wait until after -rc1.

Yup :) we are a bit inundated with AI fixes these days.

>
> > Could we have some actual justification for the use of the feature please?
> > So far I've seen arm-waving.
>
> Sure. At Meta, we build sealing into the kernel for our VM hosts, and we'd
> like it on as much of the rest of the fleet as possible. The problem is that
> the rest of the fleet also runs things which it breaks. Just as one example
> among many, Reverie (which Hermit our deterministic execution tool is built
> on) patches the vDSO of the processes it traces by injecting an
> mprotect()[0].
>
> So right now the hosts which want sealing need their own kernel image, and
> this option is one of the things which forces that. We're working towards
> hopefully running one kernel across the fleet, and with a boot parameter we
> can build it with CONFIG_MSEAL_SYSTEM_MAPPINGS=y, keep sealing on by
> default, and turn it off only on the hosts which run those tools.
>
> Let me know if you'd like more information. I can also put that in the
> commit message for v2.

Great, thanks for the background! Yeah it'd be good to include all that!

I guess I'm fishing for the security justification, but maybe that ship sailed
:) but it'd be helpful to also include that.

>
> 0: https://docs.rs/reverie-core/latest/reverie/vdso/index.html
>
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index e75344f4e0cd..b1ec9a8a979e 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -4270,6 +4270,13 @@ Kernel parameters
> > >  	MTD_Region=	[MTD] Format:
> > >  			<name>,<region-number>[,<base>,<size>,<buswidth>,<altbuswidth>]
> > >
> > > +	mseal_system_mappings=
> > > +			[KNL,EARLY] Under CONFIG_MSEAL_SYSTEM_MAPPINGS,
> > > +			whether system mappings are sealed for this boot.
> > > +			See Documentation/userspace-api/mseal.rst.
> > > +			Format: <bool>
> > > +			Default: 1 (enabled).
> >
> > You _have_ to duplicate the list of things this breaks here please.
>
> Will do.

Thanks!

>
> > Let's negate things first. Make the boot flag 'no_mseal_sys_mappings'
> > rather than confusingly implying mseal_system_mappings=1 could enable it
> > even with a config option not provided.
> >
> > Then add something like:
> >
> > static inline bool mseal_system_mappings(void)
> > {
> >        return IS_ENABLED(CONFIG_MSEAL_SYSTEM_MAPPINGS) &&
> >               !mseal_system_mappings_disabled;
> > }
> >
> > And call that in _install_special_mapping().
>
> Makes sense. I'll call it in __install_special_mapping(), since that's where
> we already have a vma_flags_t, so it can just set VMA_SEALED_BIT without
> going near the legacy flags at all, if that sounds good? Then
> VM_SEALED_SYSMAP and all of its users can hopefully go away.

Yeah I typo'd that haha, doh! And it just happens to be a function :) yes
__install_special_mapping().

>
> > The LLM overlords tell me that only uprobe trampolines would see a delta
> > from this given the ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS restriction.
> >
> > This would improve things a lot.
>
> Yes, but there is a wrinkle. Since 07c308eb2bcf ("uprobes/x86: Do not leak
> trampoline vma mapping on optimization failure"), __arch_uprobe_optimize()
> unmaps a trampoline it has just created if swbp_optimize() fails, and with
> the trampoline sealed that would now fail with -EPERM. I can see two ways to
> deal with that:
>
> One is to seal trampolines too, and just leave a sealed trampoline in place
> on that path. It's already a WARN_ON_ONCE(), and get_uprobe_trampoline()
> reuses any trampoline which is in reach, so nothing is really leaked.
>
> Another way would be to keep trampolines unsealed, but that means bringing
> back some kind of per-mapping opt-in, which is exactly what we're trying to
> get rid of.
>
> What do you think? Either way I'll Cc Jiri and Oleg on it.

I think the easiest would be to just seal them too.

>
> > > +#define VM_SEALED_SYSMAP	(mseal_sysmap_enabled ? VM_SEALED : VM_NONE)
> >
> > No, you don't use the legacy VMA flags API for new work. Sorry.
> >
> > See above as to a pointer as to how this should look.
>
> Sure thing.

Thanks, but with the proposed alternative approach, we can just yeet this from
the code anyway! :)

>
> > >  static bool range_contains_unmapped(unsigned long start, unsigned long end)
> > >  {
> > >  	VMA_ITERATOR(vmi, current->mm, start);
> > > diff --git a/security/Kconfig b/security/Kconfig
> > > index f7bf6cdc6229..d5e83af1bfc6 100644
> > > --- a/security/Kconfig
> > > +++ b/security/Kconfig
> > > @@ -67,6 +67,8 @@ config MSEAL_SYSTEM_MAPPINGS
> > >  	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
> > >  	  this config can't be enabled universally.
> > >
> > > +	  Sealing can be turned off at boot with "mseal_system_mappings=0".
> > > +
> >
> > 'With this configuration option set, sealing can...' right now this reads a
> > little like it's defaulted on.
> >
> > Also can we move this Kconfig option out of security and into mm please?
> > This is explicitly an mm feature, and it should never have been added there
> > (mm needs to know if somebody sets this default=y or something for
> > instance).
>
> Sure thing.

Thank!

>
> > Tests as separate commits please.
>
> Happy to do so, but aren't you worried about bisect safety? Or would you
> suggest another way?
>
> > This seems total overkill, you're checking whether a boot parameter works?
>
> It was mostly there so that the existing test wouldn't fail when booted with
> mseal_system_mappings=0, which meant parsing a bool. With a negated flag it
> can be a lot simpler, but I'm not sure which of these you'd prefer:
>
> One option is to skip if [vdso] isn't sealed, and otherwise expect all
> system mappings to be sealed. Then there's parsing at all, and it also stops
> failing on kernels built without CONFIG_MSEAL_SYSTEM_MAPPINGS, which matters
> more once it's in run_vmtests.sh. The downside is that it can't notice
> sealing being broken entirely.
>
> Another is to check /proc/cmdline for no_mseal_sys_mappings and expect the
> mappings to be unsealed if it's there. That's only a few lines now, but the
> test still fails on kernels without the option, as it does today.
>
> Do you have a preference between the two?
>

Yeah it's awkward, really moving the tests to mm we'd have to skip them if the
vdso isn't sealed, then assume a sealed vdso for a new process = feature
enabled.

I guess at that point it's redundant to check if disabled?

> Thanks a lot for the review!

No worries!

--
Cheers, Lorenzo
