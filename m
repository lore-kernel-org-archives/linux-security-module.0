Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAAD485CF1;
	Wed, 16 Sep 2026 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580334; cv=none; b=UCAe/W4EietTMGkhNcyQ0qQCs4LO7D0QuDf5hilRz68WgXmLAR4TZJifgyCz2cjVFvjDsUjZKSFHeZdigq+mEY8f6Ah7HYKN191AWL3H/TxnQuhOHNpQ63lGQx7CLGABt+ovI5UKbhbTrIjnxbWHA0Fu2inExAGBGtGpk83vEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580334; c=relaxed/simple;
	bh=csd2y2nYEEOCZfVox3c0d8z/t40ySqKYAVwh+i+0fGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Omh80TqMWkn0/OXSfA7ACGqCqTAxHbbhVk2VROxHS+Aa0cLsCllfoMaJdksLPj6fBi/O/eNANwNNVQj+cwe5KzP+J26fGUK2fv658SHkPAGKn8H56z0arkEHfLQNQDzZ8TjKkGmsB3fJCfkfXpAyN6Qr3uJ4jUT2hw4PCy9p7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 68GHbLf8030165;
	Wed, 16 Sep 2026 12:37:21 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 68GHbIiG030164;
	Wed, 16 Sep 2026 12:37:18 -0500
Date: Wed, 16 Sep 2026 12:37:18 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski <matt@bobrowski.net>,
        Micka??l Sala??n <mic@digikod.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        G??nther Noack <gnoack@google.com>, Jan Kara <jack@suse.cz>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Tingmao Wang <m@maowtm.org>,
        bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
Message-ID: <aqrTzoO6xF_AhuTZ@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20260909193719.518517-5-utilityemal77@gmail.com>
 <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
 <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com>
 <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
 <aqcb2eXw61LaFaqY@zenbox>
 <CAADnVQ+v9_a8Q_YOvS9fmXG+-Ga0ADKrjGDDUCiFaipo2vUDmg@mail.gmail.com>
 <aqiJrkNyGM6hYu9A@zenbox>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqiJrkNyGM6hYu9A@zenbox>
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 16 Sep 2026 12:37:21 -0500 (CDT)

On Mon, Sep 14, 2026 at 09:13:29PM -0400, Justin Suess wrote:

> On Sun, Sep 13, 2026 at 07:31:44PM -0700, Alexei Starovoitov wrote:
> > On Sun, Sep 13, 2026 at 5:20???PM Justin Suess <utilityemal77@gmail.com> wrote:
> > >
> > > Sure, in some perfect world in the future where every verifier
> > > challenge is solved and BPF has feature parity with in-tree c on
> > > a 1:1 basis, you could implement something like SELinux, or Landlock
> > > in pure eBPF.
> > 
> > Try.. give it a shot? What is missing in the verifier?

> Howdy Alexei,

> I'll stick to Landlock as the concrete case, as it's what I'm most
> familiar with.
>
> From security/landlock/fs.c: hook_sb_delete() holds the superblock's
> s_inode_list_lock, takes a nested lock of the inode's i_lock inside
> it, takes the RCU read lock inside that to dereference the per-inode
> Landlock object, and then the object's own lock, which is four
> levels of lock nesting, and even with all of that it still has to
> handle a race by re-checking inode_state_read() for specific flags
> to maintain VFS invariants.
>
> BPF cannot take any of these kernel locks, and the current BPF
> locking model deliberately excludes any nesting (bpf_spin_lock) or
> resolves contention by bailing out (trylock style); the opposite of
> what maintaining VFS invariants requires.  To do effective
> inode-based access control without TOCTOU or bailing out of a long
> path walk, you'd need to solve nested locking with colored locks:
> inode spinlocks, superblock locks, unix_state_lock, etc, and solve
> nested locking along the way.
>
> You'd also need to convince the verifier that an upward VFS walk
> (dget_parent) is bounded, and find a way to cross mount boundaries;
> getting from a vfsmount to its struct mount is
> container_of(). (Pointer is arithmetic rejected even on trusted
> pointers).  Pointers walked via d_parent become untrusted, so they
> can't be passed to any kfunc (bpf_path_d_path(),
> bpf_inode_storage_get()): inode local storage, which is otherwise an
> idiomatic inode security blob replacement, is only usable for the
> object at hand, but not its ancestors required for VFS walk.
>
> Making it string/pathname based instead doesn't help either: any
> string-based method fails because the same file can be linked from
> multiple places, the same path string means different things in
> different mount namespaces, and strings aren't TOCTOU safe (the path
> can change during the walk).  And you can't currently take
> references or locks on inodes, dentries or mounts from BPF, so any
> hierarchy walk is a lockless, unreferenced snapshot racing against
> rename, whereas Landlock's walk holds path_get()/dget_parent() holds
> the references at every step.
>
> You'd also need credential-attached storage. BPF task storage has a
> different lifecycle, and is no substitute. It does not define how policy
> is shared by threads using the same credentials, copied or replaced
> during credential transitions, propogated through file->f_cred,
> or synchronized across a thread group. Recreating those semantics in
> BPF would require explicit BPF APIs for credential storage to be
> consistent.

Excellent summary.

Alexei, for those of us contemplating potentially large BPF-LSM
projects, does this imply that eBPF may never be ready for other than
small boutique based security implementations?

Interested in your thoughts.

> (These in this patch hooks are contrary; they are giving BPF control
> over LSM policy. And, indeed, no hook is called from kfuncs, as you
> stated).
>
> The proposal is intended to add a narrow generic bridge, not to
> expose Landlock-specific kfuncs or make BPF depend on Landlock
> internals:

Based on Micka's mail that we responded to, this seems contrary to the
intent of what you are trying to implement.

We can see where you are not making BPF depend on LandLock internals.

However, from his description, the intent is to have a process compose
a LandLock policy and then hand enforcement off to an eBPF program,
which on the surface would seem to suggest that the intent is to allow
eBPF programs to enforce LandLock specific functionality and controls.

Perhaps we still misunderstand.

> All in good faith, 
> Justin

The same.

Greg

My opinions and those of my Golden Retriever Hezzie only.
