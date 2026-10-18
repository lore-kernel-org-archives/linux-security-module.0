Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5D3DDDDE
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344722; cv=none; b=rn7a0XtjQSJtLkI8ncVTIgFP7f9yeueM7JiPH0+ODgI075VtoR4Hi7lo3PXoaMHTsBBDQ+l7xLvlgkcS/gsk1ppKkwqPMnWNuuRMrR/QJnRmwzfxERdhAVKahC66DqSkq5w8Ig4HaQWnfSV7m+1OZhSdDW5O3VjKqveeiSAo7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344722; c=relaxed/simple;
	bh=3/r8Tu65TWLRzrr5/O8b+xZdBdmgApTyA8rRELAneJk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fQp1g6IKlXiwsT2g77dloq4WNloX8BiHoZp+SCNaoP7hDuFVbQLC4VodAj7LW6zweGLToCHW6Ex0GM8L4ovIYAbb0kRPGrBys3CG362RitM/JZcWzTvijQJdJSqwSnKhtkP8wXN9jeF4oPN2rwnR3ctE/e3MwdnozxlUDxDCxU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ZHOwfyfC; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ZHOwfyfC"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f20b304c0so137253485a.3
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344718; x=1792949518; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=miGht8TcvQYEfDjBL9ZxKMC6v0ya6hDvJmm8IW/qMyM=;
        b=ZHOwfyfCXxNUeYW0MyYPKFI2lfeuIZ+HPWIz2ookRdJKaVDvfec8NbweAvDhLY5b93
         MLyEvZvHZcMlKQhRKXjrPdnM7QTyqQjNzTJybH5IRg2uq0nvzCTLYmjbws3QembTa1rt
         dZgE3fJ18hhOQ/GskKxiM/nVmxvzLYszNrDj/zpVS0gj7c2iQLScuwRvCP2r8GMixHMD
         KsGLKR285nuJklj0g/h/7VWUt4/dHUMHG5Mdi3FTiU1Mqc35o2ApduLfbRFoBrgdDivR
         o+br/nslvUnQsuhM8aEgBwRpyLfc7n2lyu5CY5djbiFxqc+ImgHY4DfZwUM4psCl6Ssy
         7+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344718; x=1792949518;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=miGht8TcvQYEfDjBL9ZxKMC6v0ya6hDvJmm8IW/qMyM=;
        b=nAVQ/Q2G8iaUY4plDoDJ6DIJ+yZt8xzsjeZKbEMZug/aeJcJ4o1b3xw8iFzrS7RT10
         XWskFYxdLAVEsrpXpG3SeO68M+TL7ZR4aO6w3QrkQ+sq99/H33VcqOxngn+Pbd3RIU0u
         zMYMeDD3RuTtXODCGe3AMikBusdOrW9TjmvLztpAcE/BXDo4b/kaIeo1MMcll8wAd55g
         WD+HkQTlp5wG7Rsjq/rG7Dzpa81cfzL2OEZjG8MkWyhnTPutByHWZJwX5rztKz9UzCo1
         OVNEmb81eaYo+JdVZO9+DZmY2sFWP7lqOkGpmH7pFZIT4JfANzBT9Zh+cxrAP7Wo3izb
         BYNw==
X-Forwarded-Encrypted: i=1; AKwUvBwALKmOXfYjhqRtf/PwGDTgr6bmP3WzxU0voaurNunt5TCKI1DR/Kg/JGJLkoQO6xseaWyZaBKtfeQeLsjSnko/7Z1XG2U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhpUEk81UtCFnUDbdr9UZlpGs0GLPXu4p+WJTZETW5aKGsAcaV
	yAkIMKq8qixJ73FgljA319+Vl3Cd9JDX2GofM7DwPNjDtTaYPWSDWRhOKQ/dk0o6mfy2K8mTA7j
	InaDc
X-Gm-Gg: AYBFou1mXCjzrcO4jxRJhH8ppHiOAKSftIXttPhwPrlnksSEz5wAaQAdEG3ASRt2f5+
	xtc3Ci2rZr/oPRgQXs7gQ48db0XXAi2jfI9mVrCseiaS8H1R+TQMieM1eAdZIt9Qoip75Y2/xF6
	XThDm1znOmNipndcxtpn1oWU8pWXJ+o8MRKH4nx9RrMH0u0SRXs/HtPA8hTCwC8HlhR4UEYIPX7
	ohVdrw4WBSPMhPa+k0cTXKS1+BMx+ABw3H7BrqCqA8XhugH5TZmZohr/iUsN9sFIAGgJxaqYibu
	AgVAllyKI7AV0pfVJvinHM0xQhYBCvdQzO3UxawUKV3Xl8noVrjDehJeLqarO8GCXkE9cBdG8uQ
	QXzbhPjSS2gx6jfng2RdbcLYvXI87+JTV+5Ihe40ewq0MhCurXgt1a7K1YQMF+8IejRubQDR8wl
	SsEHagASky9/cRKLBMTP00EEfNSq2nTVVRIahlznaFsYYfJn5RsG2tR/NmkVzZFFSVJQVyx2QGO
	Dsre5JtGe3JdhTsCo77rYC3mA==
X-Received: by 2002:a05:620a:1a1a:b0:93f:184d:ac13 with SMTP id af79cd13be357-93f29d61ffcmr968844785a.51.1792344717847;
        Sun, 18 Oct 2026 10:31:57 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1688aesm748041385a.8.2026.10.18.10.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:31:56 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 00/13] cred: gather the "same uid" checks between tasks in
 one place
Date: Sun, 18 Oct 2026 17:31:42 +0000
Message-Id: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIAC1WoC/zWMQQrCMBBFr1JmbWiSRileRVxk0tGOSCwzVYTSu
 zepuHyP/98CSsKkcG4WEPqw8isXcIcG0hjznQwPhcFbf3LW9QaDSUJD0WoIrUOPXX/0AcpjErr
 xd69drj/WNz4ozTVRFxiVDErMaazqObUY2l3+o7CuG5PSm82VAAAA
X-Change-ID: 20261018-b4-cred-ids-eb01b2b38524
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=4112;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=3/r8Tu65TWLRzrr5/O8b+xZdBdmgApTyA8rRELAneJk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLfiNe/XEAhKg37+zLG6F0ujv7yFxq/R2F9fyumoJiTURz6277wXdxg6S9l+QOwDxBa0DOBfwBZ
 cYcF8unfsrwQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Hello,

We have a dozen places in the kernel that let one task mess with another
because they belong to the same user: kill(), SIGIO, the scheduler
syscalls, setpriority(), ioprio_set(), prlimit(), ptrace, moving a task
around in cgroup v1 and resctrl, and KEYCTL_SESSION_TO_PARENT.  Every
one of them open codes a handful of uid_eq() calls on the two creds.
They come in six flavors that differ in which of the real, effective and
saved ids they look at, and in whether euid 0 gets a pass, and there is
nothing that tells you whether two of them differ on purpose or by
accident.

I tripped over this working on something else that needs to change what
"the same user" means.  I kept finding another copy I had missed, and
for this kind of check a copy you missed is a hole.  So this pulls all
of them into kernel/cred.c, side by side, with a table that says which
rule looks at what, and converts the callers one at a time.

Nothing is supposed to change.  What each of these means by "the same
user" is ABI at this point, so every rule is kept exactly as it was,
warts and all, I have not tried to unify them.  The capability checks
and the LSM hooks stay with the callers.

The one patch that isn't a straight substitution is the fcntl one.
F_SETOWN copies the uid and euid of the caller into the fown_struct, and
the helpers take creds, so it holds a reference on the cred instead, the
same way struct file does for the opener.  That means the cred sticks
around until the owner is set again or the file goes away.

For testing, patch 2 is a KUnit test that holds each helper against the
expression it replaces, verbatim, over every combination of a few ids. I
also ran kill, setpriority, ioprio_set, sched_setaffinity,
sched_setscheduler, prlimit, a cgroup v1 move, SIGIO and PTRACE_SEIZE
for all 64 combinations of real, effective and saved uid of the two
tasks, on a kernel with and without the series under KASAN and lockdep.
All 576 results are the same on both, and they match what the table
says.  The resctrl and usbdevfs (kill_pid_usb_asyncio) callers I have no
way to exercise, and the MIPS patch is compile tested only.

This is based on vfs.all only because that's what the other work sits
on. Thanks,

Josef

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Josef Bacik (13):
      cred: gather the rules for acting on a task by uid
      cred: add KUnit tests for the id rules
      signal: use cred_ids_allow_signal()
      fcntl: use cred_ids_allow_sigio()
      sched: use cred_ids_allow_sched()
      MIPS: use cred_ids_allow_sched()
      sys: use cred_ids_allow_sched() for setpriority()
      sys: use cred_ids_allow_control() for prlimit()
      block: use cred_ids_allow_ioprio()
      cgroup/v1: use cred_ids_allow_move()
      fs/resctrl: use cred_ids_allow_move()
      ptrace: use cred_ids_allow_control()
      keys: use cred_ids_allow_control()

 Documentation/security/credentials.rst |  19 +++
 MAINTAINERS                            |   1 +
 arch/mips/kernel/mips-mt-fpaff.c       |   3 +-
 block/blk-ioc.c                        |   3 +-
 fs/fcntl.c                             |  19 +--
 fs/resctrl/rdtgroup.c                  |   4 +-
 include/linux/cred.h                   |  20 +++
 include/linux/fs.h                     |   4 +-
 kernel/Makefile                        |   1 +
 kernel/cgroup/cgroup-v1.c              |   4 +-
 kernel/cred.c                          | 160 ++++++++++++++++++++++++
 kernel/cred_kunit.c                    | 218 +++++++++++++++++++++++++++++++++
 kernel/ptrace.c                        |  16 +--
 kernel/sched/syscalls.c                |   3 +-
 kernel/signal.c                        |  10 +-
 kernel/sys.c                           |  10 +-
 lib/Kconfig.debug                      |  13 ++
 security/keys/keyctl.c                 |   7 +-
 security/landlock/fs.h                 |   3 +-
 19 files changed, 459 insertions(+), 59 deletions(-)
---
base-commit: ac311bf4f20e614d8e94cae4c62f075f2e5ef16c
change-id: 20261018-b4-cred-ids-eb01b2b38524

