From: jmorris@namei.org (James Morris)
Date: Mon, 28 Aug 2017 13:48:41 +1000 (AEST)
Subject: [kernel-hardening] Re: [PATCH net-next v7 02/10] bpf: Add eBPF
	program subtype and is_valid_subtype() verifier
In-Reply-To: <607ceb21-5aa5-678b-4438-0d8dcb69fc3c@digikod.net>
References: <20170821000933.13024-1-mic@digikod.net>
	<20170821000933.13024-3-mic@digikod.net>
	<20170823024452.zvizovwfd7xjucsx@ast-mbp>
	<607ceb21-5aa5-678b-4438-0d8dcb69fc3c@digikod.net>
Message-ID: <alpine.LRH.2.20.1708281347090.8842@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 23 Aug 2017, Micka?l Sala?n wrote:

> >> +	struct {
> >> +		__u32		abi; /* minimal ABI version, cf. user doc */
> > 
> > the concept of abi (version) sounds a bit weird to me.
> > Why bother with it at all?
> > Once the first set of patches lands the kernel as whole will have landlock feature
> > with a set of helpers, actions, event types.
> > Some future patches will extend the landlock feature step by step.
> > This abi concept assumes that anyone who adds new helper would need
> > to keep incrementing this 'abi'. What value does it give to user or to kernel?
> > The users will already know that landlock is present in kernel 4.14 or whatever
> > and the kernel 4.18 has more landlock features. Why bother with extra abi number?
> 
> That's right for helpers and context fields, but we can't check the use
> of one field's content. The status field is intended to be a bitfield
> extendable in the future. For example, one use case is to set a flag to
> inform the eBPF program that it was already called with the same context
> and can skip most of its check (if not related to maps). Same goes for
> the FS action bitfield, one may want to add more of them. Another
> example may be the check for abilities. We may want to relax/remove the
> capability require to set one of them. With an ABI version, the user can
> easily check if the current kernel support that.

Don't call it an ABI, perhaps minimum policy version (similar to 
what SELinux does).  Changes need to be made so that any existing 
userspace still works.



-- 
James Morris
<jmorris@namei.org>
