Received: from mailgate-2.zdv.net (mailgate-2.zdv.net [134.93.178.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C19D3BD241;
	Mon, 17 Aug 2026 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.93.178.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786962323; cv=none; b=SbZ1HhU6WNKLJLwTNjGXrSdcdZZja16/vJJGJkDBskvEfmfp9c8pfgZomOjBwjLFKxGzyN1WbpzCUI1zYKnSh65oZsgimfoyFONhZa5fNQ7H9feJ7OXYX3KokKmwdwC2M6qHUJHHgItKslEqz08jgWSo+Y4EUJhYJEKs0ZfhHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786962323; c=relaxed/simple;
	bh=4HHGROo951n1Rxf6Nm5gMAPOTXQHlvWlXNnVxWQ0aNQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g3NuO4vaLxvFQbJYrnsLRziWeYKqCbZdO7Dm/Q0UIejK8/uh5lj3sUM6rvAFGrfzNQCJT7XkzVDu1IFGfW+fZFyaVvmvgVYukQ80zbyylmCGVib4UIBG9koAzRcIIih197SdCDfZu2EKN6zAQHj5yIv1H0K9LpX/NN4wIo1SPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hs-mainz.de; spf=pass smtp.mailfrom=hs-mainz.de; arc=none smtp.client-ip=134.93.178.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hs-mainz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hs-mainz.de
X-CSE-ConnectionGUID: Vj3vFjKSRza3rVBuho0Iyw==
X-CSE-MsgGUID: Oho5jCg/T+KTEdtiw3u22A==
X-IPAS-Result: =?us-ascii?q?A2B5BwBf4IJq/z72XgpSCIJbghaBM3hyHQGWLJFNjk8PA?=
 =?us-ascii?q?QEBDgE9FAQBAYUFjWwnOBMBAgQDAgMBAQEBAQEBAQEBAQsBAQEFAQEBAQEBB?=
 =?us-ascii?q?gQBgSGGCQwGNA1JAQwBhjwBRoE9DoIvWAGCdBTHeoEB3keBcgkBC4E4hXGCb?=
 =?us-ascii?q?QGFAoERhGE2gVVEgRWDaYQcCYZjBIIigQyBWyJLP4hKA4c9SIECeCwBVRMNC?=
 =?us-ascii?q?gsHBYFmAzUSKhVuMh2BIz4XNVgbBgWBHYEohDcjGTZ8gQlegSsqYQESF4EJg?=
 =?us-ascii?q?goCgnOCBgIBSQ4LGA1IESw3FBkEPm4HjhcggVUtES0GIDQ7CCQFKiFBDAMUE?=
 =?us-ascii?q?QgNBQEFDwkHGwEMIgIPCRKSQxRUgmkBjHGifTQHgjmBaIFgBgyKL5U6TYQEg?=
 =?us-ascii?q?VeSQJJQAZJOhjqOCpU0hVoCBAIEBQIYgX9QgS4zGiRPgmcJShcCD4QpigMBF?=
 =?us-ascii?q?og4Oy7GWncCOwIHAgcOAwuKTYcdLTEBgR0BAQ?=
IronPort-Data: A9a23:TKM9iKgZTNxR/utjUcpsOmeYX1612xEKZh0ujC45NGQN5FlHY01je
 htvD2+EbKneZGbxL9F2Pt+/oE4DvpHTz4RjTQU5rCxnFXwW8JqUDtmwEBz9bniYRiHhZBk+s
 5hBMImowOMcFyeA9krybOCJQV1Uj/zgqm/UUbacUsxJbVY6Dn9n1VQ7wrBRbrdA2bCRGxmKt
 c75v/rRMVqk3y8cGm8P4spvkjs21BjJkG1e5AFWicxj5geEySFFVc1HfMldElOhKmVqNr/nL
 wr85OnRElPxp38FFt6jm7DnRUwGKpa6FRSOkHdfR5+5iRFEoCEouo5jXBbLQR4K49kht4kZJ
 ORl7fRcey9wVkH/sL11vy1jLs1LFfYuFIkrg5SImZf7I0XuKxMAyhj1Za08FdVwFu1fWQmi+
 RGEQdwARkjrug64/F60Ytdu3doNLurQBpEW4Wte5yzZCq4HUI+WFs0m5fcAtNsxrtJCA7PTd
 8EZLGApXjj+JTtCJj/7CrpnxKH52j+lL2Me9gj9SakfugA/yCR30bPqNNPUPN+XQ9lHk26Yv
 SfD9mX/EFcWObRzzBLfqS/237+ewUsXXqo1FLrl9NVlx2HQ5VA+BAEXSgCm+6OQ3xvWt9V3b
 hZ8FjAVhawz8lG7C9j7QxC3un+YrzYCVNdKVe438geAzuzT+QnxLnoDTjdbQNgnstImAz0g0
 xmCmNaBLSZourCPVXXb7b6Pti6aOTUcMmIDIyQDSGMt79zivJsiyBHGVd9/E6+zptLwEDD0h
 TuNqUAWiq8ShogQ0aKk913djBqrvJHCSgNz7QLSNkq95x59TJaseojt7F/c9/sGJ4GcJnGDu
 X8egcmFxOYHCJyM0iuXT40lB7yz6PutMDTYhU9pWZIm8lyF/3+lYJAV+zx1OV1oLtdBfDjlf
 UvekR1e6YUVP3awa6JzJYWrBKwCyanmCMSgVf3OaNdKSoZ+eRXB/yx0Y0OUmWf3nyARfboXK
 5uFNMu8BnZfU+J1wCTwQeoBuVM2+h0DKarobciT53yaPXC2PRZ5lZ9t3IOyU90E
IronPort-HdrOrdr: A9a23:IT3ava3GEIWkXNXZ6EuPfwqjBLckLtp133Aq2lEZdPRUGvb1qy
 nIpoV46faUskd1ZJhOo7690cW7K080lqQFgrX5X43CYOCOggLBR72KhbGSpwEIcBeQygcy78
 pdm/8UMqyXMbEDt6bHCV6DYrEd/OU=
X-Talos-CUID: =?us-ascii?q?9a23=3AicBSimrDlGjeur2PXbUBIXHmUf4nKWPzzlTrGV2?=
 =?us-ascii?q?xUnxXYqCVTgex6bwxxg=3D=3D?=
X-Talos-MUID: 9a23:hsj8jwTuqEmUvNo0RXTLhDY/NuxnpJjtK3wgnYkHpJKZb3ZZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,228,1779141600"; 
   d="scan'208";a="23521894"
Received: from zdv-exch-2.zdv.net ([10.94.246.62])
  by mailgate-2.zdv.net with ESMTP/TLS/ECDHE-ECDSA-AES256-GCM-SHA384; 17 Aug 2026 12:24:07 +0200
Received: from MacBook-Pro-von-Nicolai-2.fritz.box (91.37.89.206) by
 zdv-exch-2.ZDV.Net (fd42:4323:8cdd:70e:9a03:9bff:fe77:8f92) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 17 Aug 2026 12:24:06 +0200
From: Nicolai Kuntze <nicolai.kuntze@hs-mainz.de>
To: <linux-integrity@vger.kernel.org>
CC: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric
 Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC] IMA: periodic runtime re-measurement of process .text/GOT
Date: Mon, 17 Aug 2026 12:23:22 +0200
Message-ID: <20260817102323.35950-1-nicolai.kuntze@hs-mainz.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zdv-exchfe-3.ZDV.Net (2001:4c80:40:70b:21d:d8ff:feb7:30df)
 To zdv-exch-2.ZDV.Net (fd42:4323:8cdd:70e:9a03:9bff:fe77:8f92)

Hi,

This is a design RFC, not a patch submission -- I'd like feedback on
the approach before polishing the patch series further. A working
reference implementation exists today for demonstration; details and
links below.

Problem

Every existing IMA hook (FILE_CHECK, MMAP_CHECK, BPRM_CHECK,
MODULE_CHECK, ...) measures once, at load time: file open, exec,
mmap, module load, or an explicit ima_measure_critical_data() call.
Nothing in IMA today re-measures an object after it's already
resident. A process's .text or GOT can be modified in memory after
load (ptrace(), a kernel exploit writing through /proc/pid/mem, or
similar) without IMA ever re-examining it -- the load-time
measurement stays valid in the log forever, even after the live
content has diverged from it.

This is exactly the gap Andre Rein's DRIVE paper (ASIA CCS '17,
https://doi.org/10.1145/3052973.3052975) addresses: periodic
re-hashing of a process's executable memory against reference values
derived from its on-disk ELF, anchored in a TPM PCR via the same
extend-chain model IMA already uses. This RFC proposes bringing that
capability into IMA's own policy-driven measurement model, rather
than as a separate, out-of-tree mechanism.

Scenario / Rational

Load-time-only measurement is a materially weaker guarantee on
systems that stay up for a long time between reboots than on systems
that cycle power regularly. Every reboot is itself a fresh
measured-boot event -- a natural bound on how long an in-memory
tamper that bypassed load-time measurement can persist undetected,
since the next boot re-measures everything from scratch.

Railway signalling and interlocking equipment is a concrete example
of the opposite case: field devices are routinely designed to run
for months or years without a reboot, both for safety-availability
reasons (a signalling function restarting is itself an operationally
disruptive event) and because physical access for a controlled
maintenance reboot is often scheduled, not on-demand. On that kind
of system, load-time IMA measurement establishes a trustworthy
baseline at boot and then provides no further guarantee for the
entire multi-month uptime that follows -- an attacker who achieves a
one-time in-memory modification (no on-disk change, so FILE_CHECK
never fires again) can persist for as long as the device stays up,
which on this class of hardware is the normal case, not an edge
case. The same shape of argument applies to other long-uptime
industrial-control and embedded contexts more generally; railway is
simply where this is currently being evaluated. Periodic
re-measurement turns "trustworthy at boot" into "trustworthy for as
long as it keeps checking," which is the property this class of
system actually needs.

Proposed design

Two pieces:

1. Policy grammar: a new interval= option (milliseconds), together
   with three new func= hook names -- RUNTIME_TEXT_CHECK,
   RUNTIME_GOT_CHECK, KERNEL_TEXT_CHECK -- added to the existing
   __ima_hooks() X-macro in ima.h, so the enum, the measuring-string
   table, and the policy-readback token array all stay in sync
   automatically, the same as every existing hook. interval= is
   required for, and only accepted with, those three hooks, enforced
   in ima_validate_rule() the same way IMA already enforces every
   other func-specific option. Example rule this grammar accepts:

       measure func=RUNTIME_TEXT_CHECK interval=30000 pcr=16

2. A dispatch engine: a new security/integrity/ima/ima_runtime.c,
   compiled into ima.o (not a separate loadable module), holding a
   delayed_work-based periodic worker that ima_update_policy()
   starts, reconfigures, or stops to track whatever
   RUNTIME_TEXT_CHECK rule is currently active. On each tick it
   walks every live task's file-backed executable VMAs under a
   locked snapshot, then hashes unlocked (a two-pass split that
   exists specifically to avoid a nested-mmap_read_lock self-
   deadlock hit during prototyping -- see "What's already been
   tested" below), reuses ima_calc_buffer_hash() for the hash
   itself, and PCR-extends via tpm_pcr_extend(ima_tpm_chip, ...)
   directly, deliberately bypassing ima_add_template_entry()'s
   measurement-list/htable path. That path dedups by (digest, pcr)
   alone and skips the PCR extend on a repeat digest -- which would
   silently break external verification, since an auditor replaying
   the log's extend chain needs to reproduce exactly what the TPM
   really did, including repeats of unchanged content across ticks.
   Log-growth from repeatedly re-measuring unchanged content is
   instead bounded by a small (pid, address)-keyed dedup cache,
   checked after every hash (never instead of hashing), so nothing
   is ever skipped without being freshly examined first.

RUNTIME_GOT_CHECK and KERNEL_TEXT_CHECK are accepted by the grammar
but not yet wired to the dispatch engine -- v1 measures .text only.
Kernel-image .text re-measurement in particular needs its own
reference-value handling (a statically-linked kernel image has
link-time-relocated content, unlike the userspace PIC/PIE case this
prototype already handles) and is intentionally left for a follow-up
rather than folded into this first round.

What's already been tested (reference implementation)

Public repo, with everything below runnable, not just described:

    https://gitlab.rlp.net/nicolai.kuntze/memory_attestation

- The full DRIVE pipeline -- runtime re-measurement, DML/SMAF chain,
  ELF-derived reference values (.text and per-GOT-slot), and an
  external OBS/VS verification split with TPM-Quote cross-checking
  -- is prototyped and validated end-to-end as a standalone
  out-of-tree module (drive_ima/) plus a Rust verification toolchain
  (drive-rs/), including real ptrace()-based tamper injection
  correctly detected in every case, and real PCR extends confirmed
  against a swtpm-backed TPM via tpm2_pcrread.

- The two mainline patches this RFC describes
  (kernel-patches/0001-ima-policy-add-interval-and-runtime-hook-
  funcs.patch and 0002-ima-runtime-dispatch-engine-v1.patch), plus a
  follow-on 0003-ima-runtime-per-mapping-dedup.patch adding the
  dedup cache, apply cleanly against v6.8, pass checkpatch.pl
  --no-tree with 0 errors/0 warnings, compile clean under W=1, link
  into a full vmlinux, and boot and dispatch for real under QEMU/KVM:
  writing a RUNTIME_TEXT_CHECK rule to /sys/kernel/security/ima/policy
  in a running kernel causes the worker to fire on the configured
  interval, correctly measure every live process each cycle, and
  correctly reconfigure after a policy rewrite -- all empirically
  timed, not just log-inspected.

- One thing not yet exercised: a genuine hardware PCR extend from
  this dispatch engine specifically. The test environment (QEMU
  8.2.2 + SeaBIOS 1.16.3) hits a reproducible ACPI early-boot fault
  whenever any TPM device is attached, confirmed unrelated to this
  patch (fault is at PID 0, well before IMA runs). With no TPM
  present, the code correctly takes its documented -ENODEV fallback
  rather than crashing; that path is tested, a real PCR write from
  this specific code path is not, in this environment. (The extend
  call itself, and the extend-chain format, are the same ones
  already confirmed working against real hardware in the standalone
  prototype above.)

Threat-model note, already accounted for

Read-write access to /sys/kernel/security/ima/policy at runtime
(CONFIG_IMA_WRITE_POLICY=on) lets anyone with CAP_SYS_ADMIN silently
remove or weaken an active RUNTIME_TEXT_CHECK rule without touching
any signed code -- which would defeat the "isolated from a post-boot
adversary" property this is meant to provide, and matters more, not
less, on the long-uptime deployments described above, since there's
no near-term reboot to force a policy re-load. This isn't a gap in
the proposed patches; it's a statement about deployment
configuration, and it's already documented as a hard requirement for
production use of this extension: CONFIG_IMA_WRITE_POLICY should be
off, making the policy write-once at boot the same way it already is
for every other IMA policy today.

Questions for the list

- Is a delayed_work periodic worker compiled into ima.o the right
  shape for a non-event-triggered hook class, or would the list
  prefer this live behind a separate mechanism (a kthread, an
  LSM-adjacent facility, something eBPF-driven) rather than inside
  IMA's own hook dispatch?

- Is bypassing ima_add_template_entry()'s measurement-list htable
  (for the reason given above -- external-verifier replay needs
  every real extend, not a deduped view) an acceptable precedent, or
  is there a preferred way to get an un-deduped extend through the
  existing measurement-list path instead of calling
  tpm_pcr_extend() directly?

- Any objection to the interval= grammar addition / the X-macro-
  based hook additions as scoped here, ahead of a full patch series?

- Kernel-image .text re-measurement (KERNEL_TEXT_CHECK) is
  deliberately left unimplemented in this round -- is that the
  right place to split the series, or would the list rather see it
  land together with RUNTIME_TEXT_CHECK?


Thanks,
Nicolai
