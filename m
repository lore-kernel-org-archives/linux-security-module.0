Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608494;
	b=XRAVAmozcqkcs6DsAyWatOaIgkC1rrbVejTHnpcOrEYCXGsvG7H7MNZEF+dEBKemjsy+
	 hJL93xea9D/P2WrjNNolvKD8KP3lwB2epBEudUc0GSP7wSWnHI8Og+u7XOfAMGWhUSn5M
	 Bt4cXaB7HZKP/3+l5HbN8CYcNIQotCeKRwPFZwfL9BCK3jLki2D103jnVGnZMhI+X0Ua5
	 rOqt7aRMHErFTxQQVB9D+aorAkiIAi0bmUDkNihQ5aQVCkQu7i3P+6U6N3gpCbl5Utaae
	 HCE6+9TAEdPAtMJVyuQNGNEYVtAvuqYe14JV+tHJZPRh04dm98nq/fSxr7pfpGZdqhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608494;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=k41VHhw91SIJ/+9kJ/zui2CNjpfyi/O9zkcP938SdjI=;
	b=lJQZyCG+dAeEnFeoxRsqz4TWif8s8CJSxTN8xwJNOLRaXSsP6vu5KkEGsy1B2QYyoe97
	 NkcNG5LrPFGKe6Km0Gjv1m1rC/4k+ksGUAkIzXTSPK83KNkiwXTUhHJKqwPhbkBAqHTgc
	 P62gV6fKrpIx9RnWzAhXh7AvE76LGBZmFyvHKyBSxBmf2V0gbMX+1I++o4L6LAddTpNll
	 glM4OzCnXmZaK8eliHcLyxAb9Fm4SkZreDTlcmeAaemrtOtiQ/QS5nSR9ZG7QjJ3Kp0Jj
	 jT+7CzkpW51xfLyauTyvRvWVXUNzv440gfDIyrUPxVxwcf+f4Mus5NOIkqgg5sQdohw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HZ/WHhN8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D82606A319;
	Wed, 21 Oct 2026 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZ/WHhN8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B971F000C1;
	Wed, 21 Oct 2026 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792608494;
	bh=k41VHhw91SIJ/+9kJ/zui2CNjpfyi/O9zkcP938SdjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HZ/WHhN8oklwMD0+O3/AocQolDLgMpBdi9zYFcrKNiszSGLT9yf9y8a0kUCCQ+nGx
	 1pLR6F91DyD/3HKpCV8uQYRKjo63mGAKsyjv39D3zxXcL4oh2Fbqkcjescn7xXfQfU
	 lvyG/rLzD5t3LMs+4xMTvZKtGJeAsH0ZrWQgbmDZ6+pCwb/1nZ2W5ZmbyQ7+r8BEMi
	 vinxjzdv6Fr3UYCojbY8hiP1rzJ7n2Q6Peb5STKiMvnDI5ZIy6Brk6zFUZmaM/fzKh
	 pw5WIjZhPCfwCBeSF/uuwZk1lW+LqQs+Kz8JWMS7dRtB56gCvo9pl7+bC/hyq7qUWz
	 fJEMRfSCB26jQ==
Date: Wed, 21 Oct 2026 19:48:12 +0100
From: Harry Yoo <harry@kernel.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, Hao Ge <hao.ge@linux.dev>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH slab/for-next 11/14] smack: specify SLAB_MAY_ACCOUNT for
 smack_rule cache
Message-ID: <atkEXgQNK05PGTMG@thinkstation>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
 <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-11-096800aa3330@kernel.org>
 <0aeea80c-e3ac-4b6f-b1c9-ef18ea2964b3@schaufler-ca.com>
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
In-Reply-To: <0aeea80c-e3ac-4b6f-b1c9-ef18ea2964b3@schaufler-ca.com>

On Wed, Oct 21, 2026 at 09:59:15AM -0700, Casey Schaufler wrote:
> On 10/21/2026 4:46 AM, Harry Yoo (Meta) wrote:
> > smk_copy_rules() allocates rules with the gfp passed from
> > security_prepare_creds(), which is GFP_KERNEL_ACCOUNT. Specify
> > SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
> > __GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.
> >
> > Path: fork() -> copy_creds() -> prepare_creds()
> >   -> security_prepare_creds(GFP_KERNEL_ACCOUNT) -> smack_cred_prepare()
> >   -> smk_copy_rules() -> kmem_cache_zalloc(smack_rule_cache)
> >
> > Assisted-by: LLM
> > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
> 
> How was this change tested?

From the cover letter:
> Each tested cache was verified with the warning in patch 13:
> I confirmed that 1) the warning is triggered without the conversion,
> and 2) specifying SLAB_MAY_ACCOUNT resolves it. However I could not test
> io-pgtable_armv7s_l2 and sun50i's pt_pool caches due to lack of the
> hardware and emulation support. So they are compile-tested only.
> 
>   cache                  tested  environment
>   ---------------------  ------  -----------------------
>   radix_tree_node        yes     x86
>   maple_node             yes     x86
>   buffer_head            yes     x86
>   skbuff_head_cache      yes     x86
>   fanotify_*_event       yes     x86
>   smack_rule             yes     x86

Good, this can be reasonably tested.
Let me write down instructions to replay this testing.

>   io-pgtable_armv7s_l2   no      compile-tested only
>   thread_stack           yes     ppc64le (64K pages)
>   pgd_cache (arm64)      yes     arm64 (64K pages)
>   PGT_CACHE (powerpc)    yes     ppc64le
>   PCI_DMA_*_tables       yes     s390x (zPCI + vfio)
>   hostfs_inode_cache     yes     UML
>   sun50i pt_pool         no      compile-tested only

# Pull the b4 branch from git.kernel.org and configure the kernel

$ git clone -b b4/memalloc-prof-dont-waste-slabobj-ext-metadata \
      https://git.kernel.org/pub/scm/linux/kernel/git/harry/linux.git smack-repro
$ cd smack-repro
$ make defconfig kvm_guest.config
$ ./scripts/config -e MEMCG -e SECURITY_SMACK -e DEBUG_VM -e FUSE_FS -e VIRTIO_FS -e VIRTIO_MMIO
$ make olddefconfig

# Create a script to run in a VM
$ cat > repro.sh << 'EOF'
#!/bin/sh
mountpoint -q /sys/fs/cgroup || mount -t cgroup2 none /sys/fs/cgroup
echo +memory > /sys/fs/cgroup/cgroup.subtree_control
mkdir -p /sys/fs/cgroup/test
echo $$ > /sys/fs/cgroup/test/cgroup.procs   # non-root memcg; root is not charged
mountpoint -q /sys/fs/smackfs || mount -t smackfs smackfs /sys/fs/smackfs
echo 'foo bar rwxa' > /sys/fs/smackfs/load-self2
sh -c :   # fork -> prepare_creds -> smk_copy_rules(GFP_KERNEL_ACCOUNT)
echo "WARN count: $(dmesg | grep -c 'WARNING:.*__memcg_slab_post_alloc_hook')"
dmesg | sed -n '/cut here/,/end trace/p'
EOF

# Revert this patch, build the kernel, and test

$ git revert --no-edit HEAD~3 # Revert "smack: specify ..."
$ vng --build
$ vng --user root -a lsm=smack -- sh repro.sh
WARN count: 1
[    1.178905] ------------[ cut here ]------------
[    1.178913] WARNING: mm/memcontrol.c:3627 at __memcg_slab_post_alloc_hook+0x4a0/0x7b0, CPU#11: sh/434
[    1.178922] Modules linked in:
[    1.178925] CPU: 11 UID: 0 PID: 434 Comm: sh Not tainted 7.3.0-rc1-virtme-g121988b3e78d #3 PREEMPT(lazy)
[    1.178928] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    1.178929] RIP: 0010:__memcg_slab_post_alloc_hook+0x4a0/0x7b0
[    1.178932] Code: 86 e2 e3 ff e9 2e fe ff ff e8 7c a3 e3 ff 48 8b 53 10 f6 c2 03 0f 85 53 02 00 00 65 48 ff 0a e8 66 e2 e3 ff e9 52 fc ff ff 90 <0f> 0b 90 e9 ff fd ff ff 48 81 c3 bc 00 00 00 48 8b 0c d8 4c 8b a1
[    1.178933] RSP: 0018:ff7dde988181bbf8 EFLAGS: 00010246
[    1.178935] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ff4f87a042e55d00
[    1.178936] RDX: 0000000000400dc0 RSI: 0000000000000000 RDI: ff4f87a041828b00
[    1.178937] RBP: ff7dde988181bc80 R08: 0000000000000001 R09: ff7dde988181bc80
[    1.178938] R10: 0000000000000000 R11: ff7dde988181be90 R12: ff4f87a045b600c0
[    1.178939] R13: 0000000000000000 R14: ff4f87a04b95dc08 R15: ff4f87a041828b00
[    1.178943] FS:  00007f5efb4e0780(0000) GS:ff4f87a0de940000(0000) knlGS:0000000000000000
[    1.178945] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.178946] CR2: 0000555ab8c2dda8 CR3: 000000000594e006 CR4: 0000000000771ef0
[    1.178947] PKRU: 55555554
[    1.178948] Call Trace:
[    1.178950]  <TASK>
[    1.178951]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.178955]  ? __memcg_slab_post_alloc_hook+0x517/0x7b0
[    1.178957]  kmem_cache_alloc_noprof+0x3ac/0x3e0
[    1.178960]  ? smack_cred_prepare+0x84/0x180
[    1.178964]  smack_cred_prepare+0x84/0x180
[    1.178966]  security_prepare_creds+0x49/0xa0
[    1.178970]  prepare_creds+0x168/0x280
[    1.178974]  copy_creds+0x25/0x130
[    1.178976]  copy_process+0x6d4/0x2830
[    1.178981]  kernel_clone+0xd5/0x420
[    1.178984]  __do_sys_clone+0x65/0x90
[    1.178987]  do_syscall_64+0xda/0x4b0
[    1.178992]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.178994]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    1.178996] RIP: 0033:0x7f5efb5d30e8
[    1.178998] Code: 7d e0 e8 2b 58 f5 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 70 41 89 c4 85 c0 75 31 64 48 8b 04 25 10 00
[    1.178999] RSP: 002b:00007ffce2898640 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[    1.179001] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f5efb5d30e8
[    1.179002] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[    1.179003] RBP: 00007ffce2898660 R08: 0000000000000000 R09: 0000000000000000
[    1.179003] R10: 00007f5efb4e0a50 R11: 0000000000000246 R12: 0000555aad43184c
[    1.179004] R13: 00000000ffffffff R14: 0000000000000000 R15: 0000555ab8c37740
[    1.179007]  </TASK>
[    1.179008] ---[ end trace 0000000000000000 ]---

# Revert the revert and run the same script in a VM

$ git revert --no-edit HEAD
$ vng --build
$ vng --user root -a lsm=smack -- sh repro.sh
WARN count: 0

Hope this helps.

-- 
Cheers,
Harry / Hyeonggon
