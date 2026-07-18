Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1F212FAD
	for <linux-security-module@vger.kernel.org>; Sat, 18 Jul 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386936; cv=none; b=hBEIlIiDE1uwXLxtH4QjDQWjItQPn/qAUDRjlaHROxc13hK/Su4afXgT/DPHCkNoaH5zaAqgkhQZPqkFCBRd220iTbMzrIOkQxaABOw5xFLUY+7ktQi+4HQ5UE+sgmQD7IKIb3rjQECOeEgpr9MVrq8xKE3FmiuUCYktoZcznhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386936; c=relaxed/simple;
	bh=lwaMk2X2WnYfBfv2d6bgyeRnoiP9lmxyOdanHFCrroE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BI946ItRO0mdkDe95BE5YKNNCBukmQNTlZB/+Oy8MsSXpPEShZap1K+jd/pPhKY4RdiXyj3Tx33e688owW519atAg8dQIdQ20SqbNijJOGquz1vq2LwbBFlZaqcDuQX8dwh3D0k2WIyTRRXDhXbBdjZO5K2iehEcFw0L0qMLoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=GXqBrfqG; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="GXqBrfqG"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h2VP60Qp2zgrb;
	Sat, 18 Jul 2026 17:02:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784386921;
	bh=wgbxaJJBq+vgSPqQfR1fqNrE+bD/rMeCOEYCGCF1Fgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXqBrfqGVtI+mzmYzWgEdAmaDPihftSr+PktbG/vV8SM3L0dXZrZuxgQmlp03MhNX
	 +vDJjiuoKEHCtEL7yYbZTpmaEtlos9I3BhsXjkMWp/7F8oAN+2wTBvivo0CTrWeQCS
	 NjSEFlbVWcAzPjvXWKmAPo+zgqvv0G01rqG0BvYY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h2VP51tq2zcHP;
	Sat, 18 Jul 2026 17:02:01 +0200 (CEST)
Date: Sat, 18 Jul 2026 17:01:56 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Vivek Parikh <viv0411.parikh@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV is bypassable via
 io_uring IORING_OP_URING_CMD (confirmed on real NVMe hardware)
Message-ID: <20260718.pie0Adeerohx@digikod.net>
References: <20260718135650.380643-1-viv0411.parikh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260718135650.380643-1-viv0411.parikh@gmail.com>
X-Infomaniak-Routing: alpha

Hi Vivek,

Similar reports were already sent:
https://lore.kernel.org/all/20260616201633.275067-1-hexlabsecurity@proton.me/

Please take a look at the Landlock threat model:
https://lore.kernel.org/all/20260707210336.2060040-1-mic@digikod.net/

This is not a bypass.

Regards,
 Mickaël

On Sat, Jul 18, 2026 at 07:26:48PM +0530, Vivek Parikh wrote:
> Hi Mickaël,
> 
> Note: this was found with AI assistance, so I am treating it as public per
> Documentation/process/security-bugs.
> 
> While continuing the LSM-mediation audit I found that Landlock's
> LANDLOCK_ACCESS_FS_IOCTL_DEV right can be bypassed with io_uring's
> IORING_OP_URING_CMD. Unlike the mount_setattr(2) gap I reported earlier,
> this one is fully unprivileged and squarely inside Landlock's documented
> model. I have verified it on real NVMe hardware (output below).
> 
> The mechanism
> -------------
> Landlock enforces IOCTL_DEV through the file_ioctl / file_ioctl_compat LSM
> hooks (security/landlock/fs.c: LSM_HOOK_INIT(file_ioctl, ...) /
> file_ioctl_compat -> hook_file_ioctl_common ->
> LANDLOCK_ACCESS_FS_IOCTL_DEV, security/landlock/fs.c:1854/1865).
> 
> io_uring's IORING_OP_URING_CMD dispatches driver passthrough commands
> through a *different* hook, security_uring_cmd(ioucmd)
> (io_uring/uring_cmd.c:249), before calling file->f_op->uring_cmd. Landlock
> implements no uring_cmd hook -- it has no io_uring hooks at all (only
> SELinux and Smack implement security_uring_cmd). So for the same device
> fd:
> 
>   ioctl(devfd, CMD, arg)      -> security_file_ioctl -> Landlock: DENIED
>                                                         (IOCTL_DEV not granted)
>   IORING_OP_URING_CMD(devfd)  -> security_uring_cmd  -> Landlock: NO HOOK
>                                                         -> f_op->uring_cmd runs
> 
> uring_cmd is the async twin of the device ioctl. NVMe makes the
> equivalence explicit (drivers/nvme/host/ioctl.c): the ioctl path handles
> NVME_IOCTL_ADMIN_CMD and the uring_cmd path handles NVME_URING_CMD_ADMIN
> -- the same admin/IO passthrough commands. Both the controller char dev
> (nvme_dev_uring_cmd, core.c:3841) and the namespace char dev /dev/ngX
> (nvme_ns_chr_uring_cmd, core.c:3946) implement ->uring_cmd, as do ublk
> and drivers/char/mem.c.
> 
> Impact
> ------
> A Landlock-sandboxed task that is denied IOCTL_DEV on a device but holds
> an fd to it (opened under a granted fs right, or inherited) can issue the
> equivalent device commands via IORING_OP_URING_CMD, defeating exactly what
> IOCTL_DEV exists to gate. On NVMe -- the most common storage device on
> Linux systems -- this means arbitrary admin passthrough: the same code
> path carries FORMAT NVM, SANITIZE, and firmware-download commands, not
> just reads/writes. The realistic scenario: a sandboxed storage workload
> is given an NVMe namespace fd for fast IO with the expectation "it can do
> IO but cannot send device-control commands" -- the expectation
> LANDLOCK_ACCESS_FS_IOCTL_DEV was added (ABI 5) to express. It is void.
> 
> For ublk devices the gap is total: ublk's control plane is uring_cmd-only
> (no ioctl equivalent), so on ublk char devices IOCTL_DEV currently
> mediates nothing at all.
> 
> Documentation/userspace-api/landlock.rst presents IOCTL_DEV as the control
> over device ioctls; a sandbox author reasonably expects withholding it to
> stop device control commands. io_uring is unprivileged, Landlock is
> unprivileged, and no capability is required anywhere.
> 
> Affected versions
> -----------------
> This is not a regression -- it is a coverage gap that shipped with the
> IOCTL_DEV right. LANDLOCK_ACCESS_FS_IOCTL_DEV was added in v6.10
> (b25f7415eb41, May 2024); NVMe/ublk ->uring_cmd predate it (v6.0), so the
> first kernel to support IOCTL_DEV was already bypassable. It is present in
> every kernel from v6.10 through v7.2-rc3, including 6.12 LTS. (SELinux and
> Smack implement security_uring_cmd and are unaffected; Landlock and AppArmor
> do not, but only Landlock exposes IOCTL_DEV as a user-facing right.)
> 
> For completeness on scope: exploitation requires a Landlock policy that
> handles IOCTL_DEV, a sandboxee that holds/opens a ->uring_cmd-capable device
> fd, and io_uring not otherwise blocked. Sandboxers that also seccomp-filter
> io_uring (e.g. Chromium) are not affected via this path; the exposure is for
> the growing set of tools that adopt IOCTL_DEV without blocking io_uring.
> 
> Reproducer (confirmed on real hardware)
> ---------------------------------------
> Three self-contained PoCs (raw io_uring, no liburing) are available on
> request; I am not inlining them.
> 
> PoC 1 targets /dev/null (null_fops has no ->unlocked_ioctl but has
> .uring_cmd = uring_cmd_null) and needs no special hardware:
> 
>   [*] Landlock enforced: READ/WRITE granted on /, IOCTL_DEV denied
>   [1] ioctl(/dev/null, dev-cmd) = -1 (Permission denied)  <- Landlock DENIED
>   [2] io_uring URING_CMD(/dev/null) res = 0 (OK)          <- Landlock did NOT mediate
> 
> PoC 2 targets a real NVMe controller (/dev/nvme0, WD PC SN740) with
> IDENTIFY CONTROLLER (admin opcode 0x06, read-only), on
> 7.0.0-27-generic:
> 
>   [*] Landlock enforced: READ/WRITE granted on /, IOCTL_DEV denied
>   [1] ioctl(NVME_IOCTL_ADMIN_CMD identify) = -1 (Permission denied)  <- Landlock DENIED
>   [2] URING_CMD(NVME_URING_CMD_ADMIN identify) res = 0 (OK)
>       IDENTIFY data: vid=0xb715 model="WD PC SN740 SDDPMQD-512G-1101"
> 
> The same PoC was also confirmed on AWS EC2 (Ubuntu 7.0.0-1008-aws, stock
> cloud image, default settings, real NVMe EBS volume):
> 
>   [1] ioctl(NVME_IOCTL_ADMIN_CMD identify) = -1 (Permission denied)  <- Landlock DENIED
>   [2] URING_CMD(NVME_URING_CMD_ADMIN identify) res = 0 (OK)
>       IDENTIFY data: vid=0x0f1d model="Amazon Elastic Block Store"
> 
> PoC 3 targets /dev/fuse (world-accessible, 0666) as a fully unprivileged
> user (fresh uid, no group memberships, Landlock ABI 8; also reproduced in
> a Docker container with seccomp relaxed). No fuse module parameter is
> needed for this signal: fuse_uring_cmd() (fs/fuse/dev_uring.c:1217) calls
> fuse_get_dev() *before* its enable_uring check, so a never-mounted fd
> returns -EPERM even with enable_uring=N (the default). The full
> queue-registration scenario does need enable_uring=1; NVMe and ublk have
> no such gate at all.
> 
>   [*] Landlock enforced: READ/WRITE granted on /, IOCTL_DEV denied
>   [1] ioctl(/dev/fuse, FUSE_DEV_IOC_CLONE) = -1 (Permission denied)  <- Landlock DENIED
>   [2] URING_CMD(/dev/fuse, FUSE_IO_URING_CMD_REGISTER) res = -1 (EPERM)
>       <- reached fuse_uring_cmd; Landlock did NOT mediate
> 
>   (-EPERM can only originate inside fuse_uring_cmd on a never-mounted
>    fd, proving the call passed security_uring_cmd into the driver.)
> 
> The ioctl admin passthrough is denied while the identical admin command
> executes via io_uring. (Note: NVMe uring passthrough requires
> SQE128+CQE32, per nvme_uring_cmd_checks.)
> 
> Mitigations / not affected
> --------------------------
> The bypass is neutralised anywhere io_uring cannot be reached:
> 
> - kernel.io_uring_disabled = 2 makes io_uring_setup() return -EPERM for all
>   callers (io_uring_allowed(), io_uring/io_uring.c); value 1 restricts it to
>   io_uring_group / CAP_SYS_ADMIN. Where an admin has set either, this path is
>   blocked. This is a hardening knob, not a universal default: RHEL 9.3 / Rocky
>   9.3 ship io_uring *enabled* on the host (Red Hat documents the syscalls as
>   succeeding or returning EPERM per configuration).
> - Many container runtimes block the io_uring syscalls in their default seccomp
>   profile (e.g. Docker/Podman -> io_uring_setup fails with EPERM/ENOSYS inside
>   the container, verified with Docker 29 on Fedora 42), so a sandboxee confined
>   by such a runtime is protected. Likewise application sandboxers that
>   seccomp-filter io_uring (e.g. Chromium) are not affected via this path.
>   Additionally, on SELinux-enforcing hosts, containers without a relaxed label
>   are denied io_uring_setup by selinux_uring_allowed -- a second independent
>   gate (verified: the same container run fails with EACCES until
>   --security-opt label=disable is given).
> 
> So the exposed population is: io_uring-enabled kernels (the desktop default,
> and RHEL/Rocky on a bare host) running a Landlock sandbox that handles
> IOCTL_DEV without an io_uring seccomp block.
> 
> Fix direction
> -------------
> security_uring_cmd(ioucmd) gives the LSM the io_uring_cmd (and thus the
> struct file). Landlock should implement a uring_cmd hook that, for a
> device file, requires LANDLOCK_ACCESS_FS_IOCTL_DEV -- mirroring
> hook_file_ioctl. The uring_cmd command is driver-specific rather than a
> standard ioctl cmd number, so the is_masked_device_ioctl() allow-list
> (FIONREAD etc.) does not apply; the safe behavior is to require IOCTL_DEV
> for any uring_cmd on a device file. I am happy to prepare that patch
> (LSM_HOOK_INIT(uring_cmd, ...) + a tools/testing/selftests/landlock test)
> if you agree with the direction.
> 
> CCing Jens and io-uring, as the io_uring side is involved (a new LSM hook
> consumer, no io_uring behavior change expected).
> 
> Thanks,
> Vivek
> 
