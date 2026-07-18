Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2F1348C4A
	for <linux-security-module@vger.kernel.org>; Sat, 18 Jul 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784383040; cv=none; b=o0r3129u8xpMB8gVKs9QUNrbFwOVR1m5eDR8MExrhtUTk7ZmFtY8PkFFKuiQXRPOOIabvjb/7QHHJQ1MakZtKwOGDCo3efom3QSp6P5pIv4U/6YXQxnt1IWX/eOesguYPFrvONqEzClYLO2pwdqVB3r7/f8MA2QYAm7mD985O9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784383040; c=relaxed/simple;
	bh=ijtvbZqc7roFlKzki1STkECadMTcktwJmuNR9/ytQKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hZKWQaP+P97sdoPmg7eU5Pl2sk6CM9T/n5xxrgZ8HKGhzqgeEVaP3CrQ23HlUJN35wpKy7Q+waWiPVo0bSK5Q4l6BxRELoW9E45s6Sv8R5BkejhHpcTqjr2c21J8kk73QXcNSVhLJNfxILBlWGy7QGKW6JtYG/pFpIWkq2Y6Vo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6B3UAmf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6B3UAmf"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceb096e675so83374875ad.0
        for <linux-security-module@vger.kernel.org>; Sat, 18 Jul 2026 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784383038; x=1784987838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4cQLSP/Wa+/IUt7M2pMIQks9lVvqgJjnfE+ck+z8y8=;
        b=G6B3UAmfZu7LYE+DPWaK+BH+qjYHzG6n2y6Uz7pP9lDvqESIInh4PGv1ODKN3xpgTW
         f2kuI1eKlHs2eCrWP0BmC1q6MGq1JJ287ly7AnzmHVvHrVVia//7LQ8mkLDi565IO6m2
         l6iS0C9MxkHoAFkf020CGzLB2VfW92GBFWoQHNh+YkA5d2Xiwzu7XC++c2dJV7zdOOOr
         K+oJUPVhEvkYepx9lp4WxCY99PV83Wbwo+drpLLmm31BAI/9CTZvVb7xdfnCjuLc7AUk
         kKJuoCBjvzg8AbLyn3cAZeHiAloaFmWOBW5QNvJ+1JftWs4Lo4tVZ+w2Xqo9W5lIdyfA
         yjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784383038; x=1784987838;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d4cQLSP/Wa+/IUt7M2pMIQks9lVvqgJjnfE+ck+z8y8=;
        b=UJY6SRUSoQDHnPtOPJb+FUO35rQAC7svNxNt7qeXHE3bG6cDkiNf1k0pF3PONAGW81
         78fO6rx3kcqhR/87et0lC66Nayf96M59bDPujdrgcUhdimiNQ0/plXp/YQECriPYZhu3
         84mTLdMTcrb1RYYAmVqsr9zVFaXGDPVXVGZyiYimvs9neYceR79/g8xUzFOfUv8ayncx
         l1qQ1bP72tIIklijEImCUDvR5uN/LCH1XvJOZgE6e9r+m270ijxRu9Bj/FnyT4kRayGX
         hB7oBRgPEwSDKF/NSDIkl6pnFCHAnlkluFNuKDT+xi9GMO5PQgGo0GJGCTjhH9wyX3U+
         HSJg==
X-Forwarded-Encrypted: i=1; AHgh+RoAyQeg5/6jiBV9TrNbeByxv1l7u58DKW65id0WedsZAj76pgiCMWDll/HoiRxTkhJt4EdGQSV8z4aPYNMVlOND3dadqdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF1GZ8oc6CVAStLhJ5qoFfU4DVis/7ZGyPeMr4JAfInHhv3TCf
	gprQP+oTClw8efFRQ2v/WiPsbutmsIpoyikRMY5OTWa6NhLyP7we4WXd
X-Gm-Gg: AfdE7ckkxJdYD7SsQ57OAqxfvwP1CIafF9udTidy43eIc11HB+EgXbpa2fIWMDtJRgy
	fnJOAgsQqoc7XfjuhCmJqggIJJjkJxjm/R8huZ/sDFypIwltStZ+fB/QifIuxxzI7gRL9Y05VNs
	Kcxic59EZZmJHBJir+yb8OMthlg0BveZD66BCxKQOcdWS0Fm8C3r0bdCDfpAVs4KL4HwFv69Hkg
	/dt5oKqC07nKIWEdd1cENbxFTfFFBZs2BIDyK0dWeorKfrQ5M3dqmqWA4wthWfymGdJ3rb+a1J0
	MjtiR0VUELKMkejwYUytqi3/Ghww9dqAxRxhyG+HGahOdrREKo5h8J+pGrqIYbEOwUHvf7RKBqk
	XPZSPT6pf+JGFtrLNWj8wxUH2YRcEBhw/QmA6Pzytk4OECqbfmREv867eI6ecluyGxFNGt/Gi/z
	DXAp8stWp4cqdn7MXkoTPtQrNOyW4V
X-Received: by 2002:a05:6a21:1506:b0:3c1:c6e:9360 with SMTP id adf61e73a8af0-3c3ad844369mr7623449637.32.1784383038242;
        Sat, 18 Jul 2026 06:57:18 -0700 (PDT)
Received: from vivek-LOQ-15IRX9 ([2401:4900:8ff9:29ed:7266:cb8f:1472:70bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9bb62sm17333492eec.2.2026.07.18.06.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 06:57:17 -0700 (PDT)
From: Vivek Parikh <viv0411.parikh@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-security-module@vger.kernel.org,
	io-uring@vger.kernel.org,
	viv0411.parikh@gmail.com
Subject: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV is bypassable via io_uring IORING_OP_URING_CMD (confirmed on real NVMe hardware)
Date: Sat, 18 Jul 2026 19:26:48 +0530
Message-ID: <20260718135650.380643-1-viv0411.parikh@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël,

Note: this was found with AI assistance, so I am treating it as public per
Documentation/process/security-bugs.

While continuing the LSM-mediation audit I found that Landlock's
LANDLOCK_ACCESS_FS_IOCTL_DEV right can be bypassed with io_uring's
IORING_OP_URING_CMD. Unlike the mount_setattr(2) gap I reported earlier,
this one is fully unprivileged and squarely inside Landlock's documented
model. I have verified it on real NVMe hardware (output below).

The mechanism
-------------
Landlock enforces IOCTL_DEV through the file_ioctl / file_ioctl_compat LSM
hooks (security/landlock/fs.c: LSM_HOOK_INIT(file_ioctl, ...) /
file_ioctl_compat -> hook_file_ioctl_common ->
LANDLOCK_ACCESS_FS_IOCTL_DEV, security/landlock/fs.c:1854/1865).

io_uring's IORING_OP_URING_CMD dispatches driver passthrough commands
through a *different* hook, security_uring_cmd(ioucmd)
(io_uring/uring_cmd.c:249), before calling file->f_op->uring_cmd. Landlock
implements no uring_cmd hook -- it has no io_uring hooks at all (only
SELinux and Smack implement security_uring_cmd). So for the same device
fd:

  ioctl(devfd, CMD, arg)      -> security_file_ioctl -> Landlock: DENIED
                                                        (IOCTL_DEV not granted)
  IORING_OP_URING_CMD(devfd)  -> security_uring_cmd  -> Landlock: NO HOOK
                                                        -> f_op->uring_cmd runs

uring_cmd is the async twin of the device ioctl. NVMe makes the
equivalence explicit (drivers/nvme/host/ioctl.c): the ioctl path handles
NVME_IOCTL_ADMIN_CMD and the uring_cmd path handles NVME_URING_CMD_ADMIN
-- the same admin/IO passthrough commands. Both the controller char dev
(nvme_dev_uring_cmd, core.c:3841) and the namespace char dev /dev/ngX
(nvme_ns_chr_uring_cmd, core.c:3946) implement ->uring_cmd, as do ublk
and drivers/char/mem.c.

Impact
------
A Landlock-sandboxed task that is denied IOCTL_DEV on a device but holds
an fd to it (opened under a granted fs right, or inherited) can issue the
equivalent device commands via IORING_OP_URING_CMD, defeating exactly what
IOCTL_DEV exists to gate. On NVMe -- the most common storage device on
Linux systems -- this means arbitrary admin passthrough: the same code
path carries FORMAT NVM, SANITIZE, and firmware-download commands, not
just reads/writes. The realistic scenario: a sandboxed storage workload
is given an NVMe namespace fd for fast IO with the expectation "it can do
IO but cannot send device-control commands" -- the expectation
LANDLOCK_ACCESS_FS_IOCTL_DEV was added (ABI 5) to express. It is void.

For ublk devices the gap is total: ublk's control plane is uring_cmd-only
(no ioctl equivalent), so on ublk char devices IOCTL_DEV currently
mediates nothing at all.

Documentation/userspace-api/landlock.rst presents IOCTL_DEV as the control
over device ioctls; a sandbox author reasonably expects withholding it to
stop device control commands. io_uring is unprivileged, Landlock is
unprivileged, and no capability is required anywhere.

Affected versions
-----------------
This is not a regression -- it is a coverage gap that shipped with the
IOCTL_DEV right. LANDLOCK_ACCESS_FS_IOCTL_DEV was added in v6.10
(b25f7415eb41, May 2024); NVMe/ublk ->uring_cmd predate it (v6.0), so the
first kernel to support IOCTL_DEV was already bypassable. It is present in
every kernel from v6.10 through v7.2-rc3, including 6.12 LTS. (SELinux and
Smack implement security_uring_cmd and are unaffected; Landlock and AppArmor
do not, but only Landlock exposes IOCTL_DEV as a user-facing right.)

For completeness on scope: exploitation requires a Landlock policy that
handles IOCTL_DEV, a sandboxee that holds/opens a ->uring_cmd-capable device
fd, and io_uring not otherwise blocked. Sandboxers that also seccomp-filter
io_uring (e.g. Chromium) are not affected via this path; the exposure is for
the growing set of tools that adopt IOCTL_DEV without blocking io_uring.

Reproducer (confirmed on real hardware)
---------------------------------------
Three self-contained PoCs (raw io_uring, no liburing) are available on
request; I am not inlining them.

PoC 1 targets /dev/null (null_fops has no ->unlocked_ioctl but has
.uring_cmd = uring_cmd_null) and needs no special hardware:

  [*] Landlock enforced: READ/WRITE granted on /, IOCTL_DEV denied
  [1] ioctl(/dev/null, dev-cmd) = -1 (Permission denied)  <- Landlock DENIED
  [2] io_uring URING_CMD(/dev/null) res = 0 (OK)          <- Landlock did NOT mediate

PoC 2 targets a real NVMe controller (/dev/nvme0, WD PC SN740) with
IDENTIFY CONTROLLER (admin opcode 0x06, read-only), on
7.0.0-27-generic:

  [*] Landlock enforced: READ/WRITE granted on /, IOCTL_DEV denied
  [1] ioctl(NVME_IOCTL_ADMIN_CMD identify) = -1 (Permission denied)  <- Landlock DENIED
  [2] URING_CMD(NVME_URING_CMD_ADMIN identify) res = 0 (OK)
      IDENTIFY data: vid=0xb715 model="WD PC SN740 SDDPMQD-512G-1101"

The same PoC was also confirmed on AWS EC2 (Ubuntu 7.0.0-1008-aws, stock
cloud image, default settings, real NVMe EBS volume):

  [1] ioctl(NVME_IOCTL_ADMIN_CMD identify) = -1 (Permission denied)  <- Landlock DENIED
  [2] URING_CMD(NVME_URING_CMD_ADMIN identify) res = 0 (OK)
      IDENTIFY data: vid=0x0f1d model="Amazon Elastic Block Store"

PoC 3 targets /dev/fuse (world-accessible, 0666) as a fully unprivileged
user (fresh uid, no group memberships, Landlock ABI 8; also reproduced in
a Docker container with seccomp relaxed). No fuse module parameter is
needed for this signal: fuse_uring_cmd() (fs/fuse/dev_uring.c:1217) calls
fuse_get_dev() *before* its enable_uring check, so a never-mounted fd
returns -EPERM even with enable_uring=N (the default). The full
queue-registration scenario does need enable_uring=1; NVMe and ublk have
no such gate at all.

  [*] Landlock enforced: READ/WRITE granted on /, IOCTL_DEV denied
  [1] ioctl(/dev/fuse, FUSE_DEV_IOC_CLONE) = -1 (Permission denied)  <- Landlock DENIED
  [2] URING_CMD(/dev/fuse, FUSE_IO_URING_CMD_REGISTER) res = -1 (EPERM)
      <- reached fuse_uring_cmd; Landlock did NOT mediate

  (-EPERM can only originate inside fuse_uring_cmd on a never-mounted
   fd, proving the call passed security_uring_cmd into the driver.)

The ioctl admin passthrough is denied while the identical admin command
executes via io_uring. (Note: NVMe uring passthrough requires
SQE128+CQE32, per nvme_uring_cmd_checks.)

Mitigations / not affected
--------------------------
The bypass is neutralised anywhere io_uring cannot be reached:

- kernel.io_uring_disabled = 2 makes io_uring_setup() return -EPERM for all
  callers (io_uring_allowed(), io_uring/io_uring.c); value 1 restricts it to
  io_uring_group / CAP_SYS_ADMIN. Where an admin has set either, this path is
  blocked. This is a hardening knob, not a universal default: RHEL 9.3 / Rocky
  9.3 ship io_uring *enabled* on the host (Red Hat documents the syscalls as
  succeeding or returning EPERM per configuration).
- Many container runtimes block the io_uring syscalls in their default seccomp
  profile (e.g. Docker/Podman -> io_uring_setup fails with EPERM/ENOSYS inside
  the container, verified with Docker 29 on Fedora 42), so a sandboxee confined
  by such a runtime is protected. Likewise application sandboxers that
  seccomp-filter io_uring (e.g. Chromium) are not affected via this path.
  Additionally, on SELinux-enforcing hosts, containers without a relaxed label
  are denied io_uring_setup by selinux_uring_allowed -- a second independent
  gate (verified: the same container run fails with EACCES until
  --security-opt label=disable is given).

So the exposed population is: io_uring-enabled kernels (the desktop default,
and RHEL/Rocky on a bare host) running a Landlock sandbox that handles
IOCTL_DEV without an io_uring seccomp block.

Fix direction
-------------
security_uring_cmd(ioucmd) gives the LSM the io_uring_cmd (and thus the
struct file). Landlock should implement a uring_cmd hook that, for a
device file, requires LANDLOCK_ACCESS_FS_IOCTL_DEV -- mirroring
hook_file_ioctl. The uring_cmd command is driver-specific rather than a
standard ioctl cmd number, so the is_masked_device_ioctl() allow-list
(FIONREAD etc.) does not apply; the safe behavior is to require IOCTL_DEV
for any uring_cmd on a device file. I am happy to prepare that patch
(LSM_HOOK_INIT(uring_cmd, ...) + a tools/testing/selftests/landlock test)
if you agree with the direction.

CCing Jens and io-uring, as the io_uring side is involved (a new LSM hook
consumer, no io_uring behavior change expected).

Thanks,
Vivek
