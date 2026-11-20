Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214688;
	b=h9cMZ5kCuHSdvcWkAuckfpHCKvNLSoweW3lLQ9IipkY1TENvLP20BzZX2GpXkzrR9+j2
	 KCWrfnNyVOiUk1R++mOgosIKX4d7pKEDmTrKlu5532e/KDXMsm4p9beCXcRdCaQ+RmWnq
	 adNPfJ1VX/XvHDj1Efp00yKzI+sVzCE/6JjX5qhs1rgbzhoTbYmeZBxNhbMfCFRNNMWxU
	 Ugrs6U1cldp8Xi014WjoHszpc40JkqaJ6mAF1wppFG9PxTFyIzafAGhH4AFoTFExetTzB
	 8XAJzAoYuYd4Zbs7g1NdeufQI4HN8ShMH9lVtSywbvRW7RjmcXWH0akF1tn5ohfRppQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214688;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bn6mJHSwscuFX7EABuBC1QwU6RYMxp/Gn5afGYR9hiM=;
	b=DZ9BISdCc4OkebwnUO00wW7OuPUha8nmIBholIl2vb3c56nTQfudPDWz0j9v46xQ12+n
	 Ufz/LUOHRU2OoXsefG//2KCDhDF7sGPhhMKtvdYHEzPNhfJX0oOzeEgTb/lYjk4zpECM4
	 jYYko1o1scvg6UFXhWG3j95OdrO3ozFZAZ8M6Nxs1VbgvOoS0g1LO7T64uJ4FDs3CjTCz
	 IQbmga//qluA0RL0/10IZcvpTay+lyzUsdkMDewO4etKPJ0Qh7BzY9H2HQsBOaOhvl1QC
	 5eD9kazUKpGVALpHRV5enlFrLcpuEWawDxbtUgs0xWZ3nZFPX8w1L6Y7sLyk4FtT2Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1gDtaRA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841F606A69C
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1gDtaRA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2F31F000D0;
	Fri, 20 Nov 2026 22:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795214687;
	bh=bn6mJHSwscuFX7EABuBC1QwU6RYMxp/Gn5afGYR9hiM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1gDtaRAKXV2P8w+4EH9cg/ShOrrdn4aIzWA2optS29THkWlmz8GU8h+MWkoxb9ap
	 scUjfx5IeIBaS/vwrOnL2U16+GZlaIdVXmKsblT4P8+swO/x45B45CFMoItVUQ30At
	 X5D7eyaOp/3bt/WkWcRDgXjHq9uR8tASbD38IJXtB7lapOC4uBhQ4MJa4OLtNbnQVo
	 XdFI2s6gNvgxMZxtXX16BY/VNfL3qrXPP0J/iXSfnXC+2R5GGBybJMRfEv4gAM32o8
	 75i2QGX/cz7Cm69LExhTNldhPWYRXk11PAtpiCyjYgV0Y8TB1Oo/LAZhlWEjwtdFO5
	 Fc1FyiDO9oBDQ==
Message-ID: <sashiko-outbox-226300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 08/14] fs: Support FSCONFIG_SET_ROOTNS in
 fsconfig()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Andreas Larsson" <andreas@gaisler.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Andy Lutomirski" <luto@amacapital.net>, "Andy
 Lutomirski" <luto@kernel.org>, "Anna-Maria Behnsen" <anna-maria@linutronix.de>, "Arnd
 Bergmann" <arnd@arndb.de>, "Ben Segall" <bsegall@google.com>, "Borislav
 Petkov" <bp@alien8.de>, "Casey Schaufler" <casey@schaufler-ca.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Christian
 Brauner" <brauner@kernel.org>, =?utf-8?b?Q2hyaXN0b3BoZSBMZXJveSAoQ1Mg?=
 =?utf-8?b?R1JPVVAp?= <chleroy@kernel.org>, "Chris Zankel" <chris@zankel.net>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "David Hildenbrand" <david@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Davidlohr Bueso" <dave@stgolabs.net>, "David
 S. Miller" <davem@davemloft.net>, "Dietmar Eggemann" <dietmar.eggemann@arm.com>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Hallgrimur
 H. Gunnarsson" <halg@google.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Helge
 Deller" <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>, "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Jan Kara" <jack@suse.cz>, "John
 Johansen" <john.johansen@canonical.com>, "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Jonathan
 Corbet" <corbet@lwn.net>, "Josef Bacik" <josef@toxicpanda.com>, "Juri Lelli" <juri.lelli@redhat.com>, "Kees
 Cook" <kees@kernel.org>, "K Prateek Nayak" <kprateek.nayak@amd.com>, "Liam
 R. Howlett" <liam@infradead.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Magnus Lindholm" <linmag7@gmail.com>, "Manfred
 Spraul" <manfred@colorfullife.com>, "Mark Rutland" <mark.rutland@arm.com>, "Matt
 Turner" <mattst88@gmail.com>, "Max Filippov" <jcmvbkbc@gmail.com>, "Mel
 Gorman" <mgorman@suse.de>, "Michael Ellerman" <mpe@ellerman.id.au>, "Michal
 Hocko" <mhocko@suse.com>, "Michal Simek" <monstr@monstr.eu>, "Mike Rapoport" <rppt@kernel.org>, "Neal
 Gompa" <neal@gompa.dev>, "Nicholas Piggin" <npiggin@gmail.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Paul Moore" <paul@paul-moore.com>, "Paul
 Walmsley" <pjw@kernel.org>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Rich Felker" <dalias@libc.org>,
 =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>, "Russell
 King" <linux@armlinux.org.uk>, "Serge Hallyn" <sergeh@kernel.org>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Suren Baghdasaryan" <surenb@google.com>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Thomas
 Gleixner" <tglx@kernel.org>, "Valentin Schneider" <vschneid@redhat.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Will
 Deacon" <will@kernel.org>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261119224312.1037966-9-jarkko@kernel.org>
References: <20261119224312.1037966-1-jarkko@kernel.org>
 <20261119224312.1037966-9-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:44:43 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] fs: user_ns delegation and init_fs_context() mismatch in
  fsconfig_set_rootns()
- [High] fs: condition anon mnt_ns user_ns and seq_origin on
  rootns_bound in fsmount()
- [Medium] proc: allow pidns option to overwrite rootns binding in
  proc_parse_param()
--

commit 08909a29107ff970d2d4b5a71eaa424398baf6f2
Author: Jarkko Sakkinen <jarkko@kernel.org>

fs: Support FSCONFIG_SET_ROOTNS in fsconfig()

This commit adds the FSCONFIG_SET_ROOTNS command to fsconfig() so callers
holding CAP_SYS_ADMIN in a target rootns user namespace can bind a newly
opened fs_context to that rootns before configuring parameters and mounting.

> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 70024870fefa2..85b31af68a4d6 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
[ ... ]
> +static int fsconfig_set_rootns(struct fs_context *fc, struct fs_paramete=
r *param)
> +{
[ ... ]
> +	put_net(fc->net_ns);
> +	fc->net_ns =3D get_net(c->ns->net_ns);
> +	put_user_ns(fc->user_ns);
> +	if ((fc->fs_type->fs_flags & (FS_USERNS_MOUNT | FS_USERNS_DELEGATABLE))=
 &&
> +	    ((kuid_has_mapping(user_ns, fc->cred->fsuid) &&
> +	      kgid_has_mapping(user_ns, fc->cred->fsgid)) ||
> +	     !ns_capable(fc->cred->user_ns, CAP_SYS_ADMIN)))
> +		fc->user_ns =3D get_user_ns(user_ns);
> +	else
> +		fc->user_ns =3D get_user_ns(fc->cred->user_ns);
> +
> +	fc->rootns_bound =3D true;
> +	fc->rootns_mnt_id =3D c->ns->mnt_ns->ns.ns_id;
> +
> +	ret =3D fc->fs_type->init_fs_context(fc);

[Severity: High]
Can fsconfig_set_rootns() leave fc->user_ns pointing to a user namespace
other than c->user_ns while still marking fc->rootns_bound =3D true and
fc->rootns_mnt_id =3D c->ns->mnt_ns->ns.ns_id?

First, fsopen() sets priv from may_mount() (CAP_SYS_ADMIN in
current->nsproxy->mnt_ns->user_ns), whereas the fallback here tests
!ns_capable(fc->cred->user_ns, CAP_SYS_ADMIN).  If a task calls
unshare(CLONE_NEWUSER) without CLONE_NEWNS (so priv is false in
init_mnt_ns, but the caller has CAP_SYS_ADMIN in its new cred->user_ns U1)
and binds to a child rootns (U2) before writing uid_map/gid_map,
fc->user_ns falls back to U1 while fc->rootns_bound is true.  Subsequent
FSCONFIG_CMD_CREATE and fsmount() calls then authorize against U1 despite
!may_mount(), and fsmount() allocates an anonymous mount namespace in U1
with ns->seq_origin set to U2's mount namespace ID.

Second, a nested container manager with CAP_SYS_ADMIN in U1 that binds a
context to a child rootns U2 before U2's uid_map/gid_map are written (or
when U2 maps subordinate IDs excluding fc->cred->fsuid/fsgid) also hits
the else branch, leaving the superblock in U1 instead of delegating it to
U2.

Third, calling fc->fs_type->init_fs_context(fc) after setting fc->user_ns
allows filesystems without a ->set_rootns() hook to overwrite fc->user_ns
from current->nsproxy (for example, cgroup_init_fs_context() resets
fc->user_ns to current->nsproxy->cgroup_ns->user_ns).

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 781380945d784..dfe0ee9ecdcd0 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
[ ... ]
> @@ -4658,6 +4661,15 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int,=
 flags,
>  	if (ret)
>  		return ret;
> =20
> +	if (fc->rootns_bound) {
> +		if (flags & FSMOUNT_NAMESPACE)
> +			return -EINVAL;
> +		if (!ns_capable(fc->user_ns, CAP_SYS_ADMIN))
> +			return -EPERM;
> +	} else if (!(flags & FSMOUNT_NAMESPACE) && !priv) {
> +		return -EPERM;
> +	}
> +
>  	/* There must be a valid superblock or we can't mount it */
>  	ret =3D -EINVAL;
>  	if (!fc->root)
> @@ -4699,9 +4711,12 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int,=
 flags,
>  		return FD_ADD((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0,
>  			      open_new_namespace(&new_path, MOUNT_COPY_NEW));
> =20
> -	ns =3D alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns, true);
> +	ns =3D alloc_mnt_ns(priv ? current->nsproxy->mnt_ns->user_ns :
> +			  fc->user_ns, true);
>  	if (IS_ERR(ns))
>  		return PTR_ERR(ns);
> +	if (!priv)
> +		ns->seq_origin =3D fc->rootns_mnt_id;

[Severity: High]
Should alloc_mnt_ns() and ns->seq_origin be conditioned on fc->rootns_bound
rather than priv?

When a manager process already has CAP_SYS_ADMIN in its own mount
namespace (priv =3D=3D true) and uses FSCONFIG_SET_ROOTNS to prepare a mount
for a target rootns, testing priv allocates the anonymous mount namespace
in current->nsproxy->mnt_ns->user_ns instead of fc->user_ns (causing
attach_recursive_mnt() to lock the mount with MNT_LOCKED when moved into
the target rootns) and leaves ns->seq_origin at 0 instead of restricting
the detached mount to fc->rootns_mnt_id.

> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 7fbbe92bf73a7..323296b030892 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
[ ... ]
> @@ -323,6 +325,21 @@ static int proc_get_tree(struct fs_context *fc)
>  	return get_tree_nodev(fc, proc_fill_super);
>  }
> =20
> +static int proc_set_rootns(struct fs_context *fc, struct rootns *rootns)
> +{
> +	struct proc_fs_context *ctx =3D fc->fs_private;
> +	struct pid_namespace *target =3D rootns->ns->pid_ns_for_children;
> +
> +	if (!pidns_is_ancestor(target, task_active_pid_ns(current)))
> +		return invalfc(fc, "cannot set pidns to non-descendant pidns");
> +
> +	put_pid_ns(ctx->pid_ns);
> +	ctx->pid_ns =3D get_pid_ns(target);
> +	put_user_ns(fc->user_ns);
> +	fc->user_ns =3D get_user_ns(ctx->pid_ns->user_ns);
> +	return 0;
> +}

[Severity: Medium]
After proc_set_rootns() binds a context to a rootns, can a subsequent
"pidns" mount option overwrite ctx->pid_ns and fc->user_ns?

fs/proc/root.c:proc_parse_param() {
	...
	case Opt_pidns:
		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
			errorfc(fc, "cannot reconfigure pidns for existing procfs");
			return -EBUSY;
		}
		err =3D proc_parse_pidns_param(fc, param, &result);
	...
}

proc_parse_pidns_param() replaces ctx->pid_ns and sets fc->user_ns to the
new PID namespace's user_ns while fc->rootns_bound remains true and
fc->rootns_mnt_id retains the original rootns mount namespace ID.
fsmount() then checks CAP_SYS_ADMIN and allocates the anonymous mount
namespace against the overwritten fc->user_ns while pairing it with
ns->seq_origin =3D fc->rootns_mnt_id from the original rootns.  Should
Opt_pidns also be rejected when fc->rootns_bound is set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119224312.1037=
966-1-jarkko@kernel.org?part=3D8
