Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602509;
	b=auS6mmCYfnxb/MWdwvQMY9NamkAUo7ShEnKc4FddZba13SYJxOQWC7sYFD8EunSFjHFi
	 Upswyo+R+VSxXqKMbqbGXVfKfdG1v/IQ4MC3rFNBNBiI5O6c62sYAvDuAzh8Eq43PtrOa
	 zzKbp/ntcjiUAAGNmvGcnsj8WhlB01OmfsI/MaSXyfCZ/bZ/zyNU9BK1w1ODtj9qE0scn
	 t613xanASxmsboCP8gj09DaDNCAGtGJ8uxAY9dHGwXyFVHGk77iou8K/tRh0RKLE3tqA4
	 mpCr4FPBAEc7hy6UkG0Uj3bHkD5IFQVjWzsUeAIai8fp0/6jPnRRdGLFIT3XrrPDovQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602509;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=76yluXMIAn3m5xm1UAJva3Q2kMG+a32mXTcNzfonPos=;
	b=TvIpww9zLNslMha+CnBpfenh6l4RXwmOgjyXnj3SJUB/AxL2cldTJGWc4voJ1RDJ3R3N
	 6kR0RZLDDSoQtSmqiT/eYNuzEQpGC59XpaRfuiduBjN09U+QrIdIl7kJgaPwPMubf/8b3
	 LOzPtvY9JG6Fgzy2ugbXc4Pi/Hag5XO+VH2B/bOxV982iYbXv7MIGgfnQ+aH0N0BRgA35
	 D1WP5Ud7LgE6YkCqlOrTfN7JHnK8HjP5Ztc6uWtzw4vnNGE+AaEKNAprQSP00pTtuQf1h
	 KE1zsTilRNLuNAjopEBdDgHqEiSn8nrxIaofuwxn3UZXuUYL2WlbcCJrhO606RHg5fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ldP/wtMF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D914606A319
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldP/wtMF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3B31F000C1
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 17:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792602508;
	bh=76yluXMIAn3m5xm1UAJva3Q2kMG+a32mXTcNzfonPos=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ldP/wtMFg+7Azk0t0r+yqMOKP3VsxXFzAvnWmbCxlAt7Abw7pWNShlnDh/vbP9SBo
	 zCUnEvlVvNnNwpLUXss4TRBw9Qpwtzj58sTitkxLJBFrHgZMFgs5zAYXih/qIFbuZP
	 YuzMhOdX5DGMKld278kW421lE6LYqe1PuXGIPsQNF983tA53EaqyjX0YtWtRt29ygM
	 v9myaxPo3be0Gn62pVRdBdhpI+YPtQx234dvMHAk9cR3PWZIKTuATD7mNkyJmYAtzZ
	 TQEJb3SOOWnqkoLGRagkI4iuQZFBeliWnWYScWY+Un5ropNBHgCS05A8AAw4TGNV2X
	 E2hxaIDxYk4Jg==
Message-ID: <sashiko-outbox-180477@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] docs: security: Describe the Kernel Assurance Plane
 design
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261021165748.19304-1-ketan@armoriq.io>
References: <20261021165748.19304-1-ketan@armoriq.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:08:28 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] docs: security: unimplemented RFC ABI in testing/ and broken LSM=
 toctree
- [Medium] docs: security: flawed KAP design assumptions and securityfs ABI=
 in kap.rst
- [Low] docs: security: broken kap toctree entry in admin-guide/LSM/index.r=
st
--

commit 8daaac2e818ef2e2e92b854ad81a7ed35ca5777c
Author: Ketan Bhardwaj <ketan@armoriq.io>

docs: security: Describe the Kernel Assurance Plane design

This commit adds design documentation and a securityfs abi description for
the proposed Kernel Assurance Plane (kap) subsystem without any backing code
implementation.

> diff --git a/Documentation/ABI/testing/securityfs-kap b/Documentation/ABI=
/testing/securityfs-kap
> new file mode 100644
> index 0000000000000..89223a937410b
> --- /dev/null
> +++ b/Documentation/ABI/testing/securityfs-kap
> @@ -0,0 +1,99 @@
> +What:		/sys/kernel/security/kap/
> +Date:		October 2026
> +KernelVersion:	RFC
> +Contact:	Ketan Bhardwaj <ketan@armoriq.io>
> +Description:
> +		Kernel Assurance Plane control directory in securityfs.
> +		The ABI is experimental and intended for RFC review.
> +
> +What:		/sys/kernel/security/kap/kap.default
> +Date:		October 2026
> +KernelVersion:	RFC
> +Contact:	Ketan Bhardwaj <ketan@armoriq.io>
> +Description:
> +		Read or write "open" or "closed". When closed, a task
> +		outside the initial PID namespace that is bound to no igroup
> +		cannot start a program.

[ ... ]

> +What:		/sys/kernel/security/kap/igroups/<igroup>/kap.authority_epoch
> +Date:		October 2026
> +KernelVersion:	RFC
> +Contact:	Ketan Bhardwaj <ketan@armoriq.io>
> +Description:
> +		Read or write the current authority epoch. A lower value is
> +		refused. Bound tasks whose recorded epoch is stale fail KAP
> +		checks closed.

[ ... ]

> +What:		/sys/kernel/security/kap/igroups/<igroup>/kap.events
> +Date:		October 2026
> +KernelVersion:	RFC
> +Contact:	Ketan Bhardwaj <ketan@armoriq.io>
> +Description:
> +		Read recent KAP decisions as JSON lines.

[Severity: Medium]
Should unimplemented rfc interfaces be added to
Documentation/ABI/testing/securityfs-kap?

Documentation/ABI/README states that Documentation/ABI/testing/ is for
interfaces where main development has been completed and that userspace
programs can start relying on:

  testing/
	This directory documents interfaces that are felt to be stable,
	as the main development of this interface has been completed.
	The interface can be changed to add new features, but the
	current interface will not break by doing this, unless grave
	errors or security problems are found in them.

Here, Documentation/ABI/testing/securityfs-kap registers
/sys/kernel/security/kap/ and its sub-entries with KernelVersion: RFC even
though no implementation exists in the tree (and omits kap.igfd, which is
listed under Control plane in Documentation/security/kap.rst). Meanwhile,
Documentation/security/kap.rst states that it does not add code, includes a
Questions for maintainers section, and notes that the document is not meant
to freeze the userspace abi.

Should these open design questions and unstable abi proposals live in the
mailing list cover letter, or be submitted alongside the actual kernel
implementation once the interface is ready?

> diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admi=
n-guide/LSM/index.rst
> index b44ef68f6e4da..4a299993a10b6 100644
> --- a/Documentation/admin-guide/LSM/index.rst
> +++ b/Documentation/admin-guide/LSM/index.rst
> @@ -48,4 +48,5 @@ subdirectories.
>     Yama
>     SafeSetID
>     ipe
> +   kap
>     landlock
> diff --git a/Documentation/security/index.rst b/Documentation/security/in=
dex.rst
> index 00650dcf38cb8..937193b13fedf 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -18,6 +18,7 @@ Security Documentation
>     siphash
>     tpm/index
>     digsig
> +   kap
>     landlock
>     secrets/index
>     ipe

[Severity: Low]
Does adding kap to the toctree in Documentation/admin-guide/LSM/index.rst
break the documentation build?

This patch adds kap to both Documentation/security/index.rst and
Documentation/admin-guide/LSM/index.rst, but only creates
Documentation/security/kap.rst and does not create
Documentation/admin-guide/LSM/kap.rst. Because the toctree in
Documentation/admin-guide/LSM/index.rst resolves relative paths under
Documentation/admin-guide/LSM/, running make htmldocs fails with a missing
admin-guide/LSM/kap document reference.

> diff --git a/Documentation/security/kap.rst b/Documentation/security/kap.=
rst
> new file mode 100644
> index 0000000000000..43099a5ae355a
> --- /dev/null
> +++ b/Documentation/security/kap.rst
> @@ -0,0 +1,191 @@

[ ... ]

> +Motivation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A task increasingly runs on behalf of an objective that a user approved,=
 for
> +example an AI agent asked to fix a failing test. Over hours it starts pr=
ograms,
> +reads and writes files and opens connections. Linux decides whether the =
task
> +may perform each operation. It does not decide whether the operation sti=
ll
> +belongs to the objective the task was started for.
> +
> +Existing mechanisms cover parts of this. Seccomp filters syscalls but ca=
nnot see
> +paths or objectives. LSM profiles, such as AppArmor or SELinux, are atta=
ched to
> +programs or labels, not to an objective, and cannot be narrowed for one =
task
> +while it runs. Namespaces and cgroups partition resources rather than
> +authority. None of them lets several objectives run in one environment, =
each
> +held to its own authority, or fails a task closed the moment its authori=
ty is
> +revoked.

[ ... ]

> +Control plane
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +KAP state lives under ``/sys/kernel/security/kap``::
> +
> +  /sys/kernel/security/kap/
> +    kap.default
> +    igroups/            created with mkdir, as cgroups are
> +      <igroup>/
> +        kap.install
> +        kap.procs
> +        kap.lineage_root
> +        kap.authority_epoch
> +        kap.authority
> +        kap.expires_at
> +        kap.transition
> +        kap.mode
> +        kap.events
> +        kap.igfd
> +
> +``kap.default``
> +  ``open`` (the default) or ``closed``. When closed, a task outside the =
initial
> +  PID namespace that is bound to no igroup cannot start a program, so a =
bind
> +  that failed cannot leave a workload running without authority.
> +
> +``kap.install``
> +  Write the lineage root, epoch, optional expiry and transition, and the
> +  authority as one ``key=3Dvalue`` document in a single write. They comm=
it
> +  together or not at all.
> +
> +``kap.procs``
> +  Write a pid to bind a task to the igroup. Reads return bound pids.
> +
> +``kap.lineage_root``, ``kap.authority``
> +  Read or write the lineage root or the compiled authority snapshot.
> +
> +``kap.authority_epoch``, ``kap.expires_at``
> +  Read or write the epoch, or the expiry in seconds since the Unix epoch=
 (0 for
> +  none). A lower epoch, or an expiry already in the past, is refused.
> +
> +``kap.transition``
> +  Write transition records with monotonically increasing sequence number=
s.
> +
> +``kap.mode``
> +  ``enforce`` or ``revoked``. A revoked igroup refuses every operation.
> +
> +``kap.events``
> +  Read recent decisions as JSON lines, each with the decision, operation,
> +  target, reason, igroup, epoch and lineage root.
> +
> +``kap.igfd``
> +  Reserved for future igroup file descriptors.

[ ... ]

> +Igroups rather than a cgroup controller
> +---------------------------------------
> +
> +Considered: making KAP a cgroup controller, since igroups are created li=
ke
> +cgroups and follow the process tree.
> +
> +Chosen: a separate hierarchy. A container usually places all of its task=
s in
> +one cgroup, while several objectives can run inside it, each needing its=
 own
> +authority. Tying authority to resource partitioning would prevent that, =
and
> +authority must also follow setns, which cgroup membership does not.

[Severity: Medium]
Are several of the architectural assumptions and control-plane semantics in
Documentation/security/kap.rst and Documentation/ABI/testing/securityfs-kap
accurate?

First, the Motivation section states that AppArmor or selinux profiles cann=
ot
be narrowed for one task while it runs, and the Igroups rather than a cgroup
controller section states that authority must follow setns(), which cgroup
membership does not. However, in the kernel:
- setns() (via commit_nsset() -> switch_task_namespaces() in kernel/nsproxy=
.c
  and cgroupns_install() in kernel/cgroup/namespace.c) does not strip a tas=
k's
  cgroup membership (task->cgroups), and setns() takes namespace file
  descriptors rather than an igroup object, so it is unclear how setns() wo=
uld
  transition a task into a target igroup.
- Existing lsms already support dynamically narrowing a running task's
  authority: Landlock via sys_landlock_restrict_self() in
  security/landlock/syscalls.c, AppArmor via do_setattr() in
  security/apparmor/lsm.c (supporting changehat, changeprofile, and profile
  stacking on current), and selinux via dynamic context transitions on
  current.

Second, under Control plane, setting kap.default to closed blocks program
execution for any unbound task outside the initial pid namespace. Because
non-initial pid namespaces are routinely created by unprivileged sandboxes
(such as Bubblewrap, Flatpak, and browsers), systemd services with private =
pid
namespaces, and unrelated containers, wouldn't keying global enforcement off
!init_pid_ns break unrelated workloads across the system while leaving unbo=
und
tasks in the initial pid namespace unrestricted?

Third, in Documentation/ABI/testing/securityfs-kap,
/sys/kernel/security/kap/igroups/<igroup>/kap.authority_epoch states that
bound tasks whose recorded epoch is stale fail checks closed, while
kap.install atomically updates the authority snapshot together with
authority_epoch. Because no mechanism is defined to transition or re-attest
already-bound running tasks to the new epoch, wouldn't installing an updated
policy with a higher epoch immediately fail all existing tasks in that igro=
up
closed, making an epoch update indistinguishable from setting kap.mode to
revoked?

Finally, kap.install accepts a multi-field key=3Dvalue document, kap.author=
ity
parses text predicate arrays, and kap.events formats json lines in the kern=
el
through securityfs. Could this avoid complex string parsing and ad-hoc json
formatting in securityfs, and use the existing kernel audit infrastructure
(include/linux/lsm_audit.h) for decision logging instead?

> +
> +A static LSM rather than BPF LSM programs
> +-----------------------------------------

[ ... ]

> +Questions for maintainers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +1. Is an internal filesystem linked under securityfs, as AppArmor does,
> +   acceptable for a control plane that needs userspace mkdir?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021165748.1930=
4-1-ketan@armoriq.io?part=3D1
