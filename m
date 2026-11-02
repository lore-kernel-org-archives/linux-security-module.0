Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586061;
	b=eoUNH+6BTpGu6tsx86JupQS6KOGuKESYs2QEjl92VXRZANFctHGs2EIOgFAKICgJXwq3
	 LSzw/NgGwAQLrzQ0KqqCSD0a4NTtt6K6IkTyaSjN/jALupKrGQ488+61un3xZ13zocvou
	 H0uY3wt9/Q34cIqYi1BC+ovjgfo6Nbo36nujEebT1W/krzlMMILewU6Vn/A1hVooM9yw1
	 3FuROEH7jM6XOYF30s5FAaeK9fitur5gN0jDNv4JsiDip2ER+0QxhPSdM0R5QZWedESIi
	 Zq1MHdoxLGVegyxXIuDlBAAcjtlqIG31G/lyWSCULFpyB9KaYm+Vbywtw7HY87jDdug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586061;
	h=DMARC-Filter:DKIM-Signature:From:Date:X-Original-From:Cc:Received:
	 Content-Transfer-Encoding:To:Subject:Message-Id:Mime-Version:
	 X-Lms-Return-Path:X-Mailer:Content-Type;
	bh=mV4XWV5UumWH3bqYkM0D5tKSdqz/N/kzuN7HT6Rsqyc=;
	b=JVlU/piOtngZgRJAj8V3rxtq13MxlT88cKLHJpdWJTlYAR8I8OavizXvrgzdG3LBckVD
	 iL9xtcNo669SVroKX7PKTsXcsAeYuqnBgCDlaElrCatiF5gmfRgYbvp1q3ZU6IuqOj1SJ
	 g6q6LGqB01fuOlFhZaj58+IXETDquWjspe1Z14/JSHQ3D1SrkmoW5M14g/wP6sbnjXyiC
	 O1PmCqa2hqlicY4F2v9OYzdgbMGKkr9fhqgY3xgK6oo1PQ0IueOCFp28MIVbqq8sxmgZm
	 /ppTixzlwG0d3wqsztZ+Gg6E2HGpnvU+4PzJZ2eUN8lJPFbXnbj9f8i6nmGMm0UPH9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dw1.io;
	spf=pass smtp.mailfrom=dw1.io;
	dkim=pass header.d=dw1.io header.i=@dw1.io header.a=rsa-sha256 header.s=lark2403231520 header.b=kGFU0zdr;
	arc=none smtp.remote-ip=209.127.231.53
Received: from va-2-53.ptr.blmpb.com (va-2-53.ptr.blmpb.com [209.127.231.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9927606A324
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 02:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9927606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dw1.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dw1.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dw1.io header.i=@dw1.io header.a=rsa-sha256 header.s=lark2403231520 header.b=kGFU0zdr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2403231520; d=dw1.io; t=1793586055; h=from:subject:mime-version:
 from:date:message-id:subject:to:cc:reply-to:content-type:mime-version:
 in-reply-to:message-id;
 bh=mV4XWV5UumWH3bqYkM0D5tKSdqz/N/kzuN7HT6Rsqyc=;
 b=kGFU0zdrWk767YRVwf176cqH6sRADfHr1xyjecxohx27v1cimjFvWberMDLKRY+oePEpBi
 fPicbEVel3BUlUYEcB95QsxixngARgJcV/tqbZ2Q5wVBu/HSJYnXLAEqLWO3pNxjMUXywV
 g6v2tJN+cGybZuls0UgcYPLw/g7bXrhkTuYdb0zIH6RgNs5dccLW6fw6fU1lCTu2507Ld+
 jcLo3igPe45ZOPC4L/vG4LjvVwMFhdJiaQpTF8IUw6knMaJygLTcY1aRWQl1Klv9hCSqsu
 asjRiJ+MEY/2XLEM2Pnze602+ag5kGMlzR3fzf5BrhmNhvMYzl09fzhLDcVZgg==
From: "Dwi Siswanto" <me@dw1.io>
Date: Mon,  2 Nov 2026 09:20:12 +0700
X-Original-From: Dwi Siswanto <me@dw1.io>
Cc: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	"Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Received: from dwis-macbook-pro.tail904ed7.ts.net ([168.107.87.239]) by smtp.larksuite.com with ESMTPS; Mon, 02 Nov 2026 02:20:54 +0000
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Subject: [BUG] landlock: get_current_exe() WARNs on long exe paths
Message-Id: <20261102022018.73143-1-me@dw1.io>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26ae7f386+2abfaf+vger.kernel.org+me@dw1.io>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8

Hi Micka=C3=ABl,

Summary
=3D=3D=3D=3D=3D=3D=3D

get_current_exe() in security/landlock/domain.c hits WARN_ON_ONCE() when
d_path() returns -ENAMETOOLONG for the calling task's executable, and
landlock_restrict_self() then fails with that error. Any local user
can trigger it without privilege. 1d636984e088 introduced the bug in
v6.15, and it is still present in mainline master.

It affects every kernel from v6.15 on with CONFIG_AUDIT=3Dy. Since
v7.3-rc1 it also affects CONFIG_AUDIT=3Dn kernels that have
CONFIG_TRACEPOINTS=3Dy. I reproduced it only on v7.3-rc5; the other
versions, master and the CONFIG_AUDIT=3Dn case come from reading the
code. See "Affected versions".

I prefer to drop the WARN and record a placeholder such as
"<too_long>" in exe_path instead of failing the syscall.

The code assumes that d_path() of the executable always fits in
LANDLOCK_PATH_MAX_SIZE (PATH_MAX + 11) bytes; its WARN_ON_ONCE() check
carries the comment "Should never happen". The assumption is wrong: the
absolute path of a file is not bounded by PATH_MAX, and d_path() returns
ERR_PTR(-ENAMETOOLONG) when the path does not fit in the buffer.

The failure occurs when a task whose executable's absolute path is
longer than LANDLOCK_PATH_MAX_SIZE - 1 bytes (4106 bytes, or 4096 bytes
if the executable has been unlinked) calls landlock_restrict_self():

  - the WARN_ON_ONCE() at domain.c:523 fires (once per boot), which
    taints the kernel, and panics it if panic_on_warn is set;

  - landlock_restrict_self() fails with -ENAMETOOLONG, which is not one
    of its documented errors, so such a program can never sandbox
    itself.

Audit already handles this case: audit_log_d_path()
(kernel/audit.c:2215-2224) uses the same PATH_MAX + 11 buffer and logs
exe=3D"<too_long>" without a WARN, and Landlock's own trace code
(fs.h:173) maps -ENAMETOOLONG to "<too_long>" too.

Only the AUDIT_LANDLOCK_DOMAIN record reads the executable path, so
enforcement fails because of logging metadata. The path is captured
at domain creation regardless of the LANDLOCK_RESTRICT_SELF_LOG_*
flags and of whether audit is enabled at runtime, so neither avoids
the failure.

Affected code (at 72d3fcf802c4, v7.3-rc5)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

security/landlock/domain.h:80-81:

  /* Adds 11 extra characters for the potential " (deleted)" suffix. */
  #define LANDLOCK_PATH_MAX_SIZE (PATH_MAX + 11)

security/landlock/domain.c:518-525, in get_current_exe():

  buffer =3D kmalloc(buffer_size, GFP_KERNEL);
  ...
  exe =3D d_path(&file->f_path, buffer, buffer_size);
  if (WARN_ON_ONCE(IS_ERR(exe)))
          /* Should never happen according to LANDLOCK_PATH_MAX_SIZE. */
          return ERR_CAST(exe);

The error then propagates unchanged to user space:

    domain.c:549-551    get_current_details()
    domain.c:586-588    landlock_init_hierarchy_log()
    domain.c:477-479    landlock_merge_ruleset()
    syscalls.c:620-624  sys_landlock_restrict_self()

The call chain is as follows; the splat shows get_current_details() and
get_current_exe() inlined:

    sys_landlock_restrict_self()
      landlock_merge_ruleset()
        landlock_init_hierarchy_log()
          get_current_details()
            get_current_exe()
              d_path() -> ERR_PTR(-ENAMETOOLONG)

The documented errors for landlock_restrict_self() (syscalls.c:527-538)
are EOPNOTSUPP, EINVAL, EBADF, EBADFD, EPERM and E2BIG.

Impact
=3D=3D=3D=3D=3D=3D

- Local and unprivileged. landlock_restrict_self() needs no capability,
  only no_new_privs (or LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS), and the
  executable only has to sit in a directory tree the user can write to.
  Landlock must be enabled (CONFIG_SECURITY_LANDLOCK=3Dy and listed in
  lsm=3D) and CONFIG_SECURITY_LANDLOCK_LOG must be set (see
  "Affected versions").

- With the default panic_on_warn=3D0, the effect is one WARNING splat per
  boot and the 'W' taint flag. There is no memory corruption and no
  information leak; KASAN reported nothing in my runs.

- With panic_on_warn=3D1 (used by some hardened and fleet deployments,
  and by fuzzers), any local user can panic the machine, i.e. a local
  denial of service. I did not test with panic_on_warn=3D1; this follows
  from the WARN semantics.

- landlock_restrict_self() fails with -ENAMETOOLONG on every such call,
  not only the first one. This fails closed (no domain is installed and
  the caller is told), so it is not a sandbox bypass. But a program
  installed at such a path can never restrict itself, and callers that
  expect only the documented errors may misreport the failure or, if
  they apply Landlock on a best-effort basis, carry on unsandboxed.

- The result of the syscall depends on the kernel configuration: with
  CONFIG_SECURITY_LANDLOCK_LOG=3Dn, landlock_init_hierarchy_log() is a
  no-op stub and the same call succeeds.

Affected versions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- 1d636984e088 ("landlock: Add AUDIT_LANDLOCK_DOMAIN and log domain
  status") introduced the bug. It added get_current_exe(), the WARN,
  and the error propagation through landlock_init_hierarchy_log(), and
  was first released in v6.15 (git describe --contains:
  v6.15-rc1~127^2~18, merged through the landlock-6.15-rc1 tag).
  get_current_exe() has not changed since, so every kernel from v6.15
  on with CONFIG_AUDIT=3Dy is affected.

- Since v7.3-rc1 the code also runs on CONFIG_AUDIT=3Dn kernels that have
  CONFIG_TRACEPOINTS=3Dy. Two commits changed the guard and its default:

    e761a88cedeb ("landlock: Split denial logging from audit into
    common framework") changed the guard around get_current_exe() and
    the real landlock_init_hierarchy_log() from CONFIG_AUDIT to the new
    CONFIG_SECURITY_LANDLOCK_LOG. That symbol defaulted to "y if
    AUDIT", so the commit did not change which kernels are affected.

    b4540a72be41 ("landlock: Add create_ruleset and free_ruleset
    tracepoints") changed the default to "y if AUDIT || TRACEPOINTS".

  CONFIG_SECURITY_LANDLOCK_LOG has no prompt, so it cannot be turned off
  separately. Up to v7.2, CONFIG_AUDIT=3Dn kernels used the no-op
  landlock_init_hierarchy_log() stub and were not affected.

- Still present in v7.3, whose domain.c is identical to v7.3-rc5's.

- Still present in mainline master at abf8c33470f7 (2026-10-30), which
  I checked with a fetch from git.kernel.org. get_current_exe() and
  the Kconfig default are unchanged (the WARN is now at domain.c:524),
  and ENAMETOOLONG is still not among the documented errors of
  landlock_restrict_self(). The head of your "next" branch
  (3e271a27c46f) is already in master, so as far as I can tell no fix
  is pending.

Testing status
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- Reproduced at 72d3fcf802c4 (v7.3-rc5) in an x86_64 QEMU guest: KASAN
  build with CONFIG_AUDIT=3Dy, CONFIG_TRACEPOINTS=3Dy and
  CONFIG_SECURITY_LANDLOCK_LOG=3Dy, booted with lsm=3Dlandlock,... audit=3D=
1
  panic_on_warn=3D0. The test task ran as uid 65534 with no
  capabilities.

- At an absolute path of about 4350 bytes, the WARNING below fires and
  landlock_restrict_self() returns -1 with errno ENAMETOOLONG (36). I
  reproduced this in two separate boots. Control: the same program at a
  short path gets 0 from landlock_restrict_self().

- Not tested: panic_on_warn=3D1; a CONFIG_AUDIT=3Dn, CONFIG_TRACEPOINTS=3Dy
  build (that claim comes from reading Kconfig, the Makefile and
  domain.h); kernels other than v7.3-rc5 (I checked older releases and
  master only by reading the code); and any fix.

Splat (timestamps stripped; "Code:" and irq event stamp lines elided):

------------[ cut here ]------------
WARNING: security/landlock/domain.c:523 at landlock_init_hierarchy_log+0x42=
6/0x560, CPU#1: p/95
Modules linked in:
CPU: 1 UID: 65534 PID: 95 Comm: p Not tainted 7.3.0-rc5-g72d3fcf802c4 #1 PR=
EEMPT(lazy)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
RIP: 0010:landlock_init_hierarchy_log+0x426/0x560
RSP: 0018:ffffc90000bffe40 EFLAGS: 00010202
RAX: ffffffffffffffdc RBX: ffff88800a427a00 RCX: ffffc90000bffd0c
RDX: 0000000000000000 RSI: ffffffff85a37ce0 RDI: ffff88800b7e047c
RBP: ffff88800c8c4000 R08: 0000000000000000 R09: ffffffff81b67d30
R10: 0000000000000005 R11: ffffffff81b66e73 R12: ffff88800c8c4000
R13: ffffffffffffffdc R14: ffffffffffffffdc R15: ffff888009df2380
FS:  0000000023ec23c0(0000) GS:ffff88811c9fd000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdbb58b968 CR3: 000000000d54a005 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 landlock_merge_ruleset+0x65b/0x9f0
 __do_sys_landlock_restrict_self+0x1c3/0xca0
 ? do_syscall_64+0x56b/0x5f0
 do_syscall_64+0x116/0x5f0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x4498ad
RSP: 002b:00007ffdbb59b928 EFLAGS: 00000246 ORIG_RAX: 00000000000001be
RAX: ffffffffffffffda RBX: 00007ffdbb59bb90 RCX: 00000000004498ad
RDX: 00000000004498ad RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000004 R09: 0000000000000004
R10: 0000000000000004 R11: 0000000000000246 R12: 000000000049a022
R13: 00007ffdbb59bb78 R14: 00000000004c4790 R15: 0000000000000001
 </TASK>
---[ end trace 0000000000000000 ]---

RAX/R13/R14 =3D 0xffffffffffffffdc is -36 (-ENAMETOOLONG); ORIG_RAX 0x1be
is __NR_landlock_restrict_self (446).

Reproducer
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A reproducer is available to the maintainers on request.

Thanks,
Dwi
