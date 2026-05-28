Received: from mail-24427.protonmail.ch (mail-24427.protonmail.ch [109.224.244.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84733F390
	for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003329; cv=none; b=NPynDofyOGDo3En0w/pIEZr7NFcEldDeuMRjck+b/6mnC5cO1pv8n5azAVGP/pse3JaqBFhgmzG3uLFAn4V5qEO5qBdLzqGmwl0Y2QCilHEfHsfBf/2sYjL21LblCDDMAwohd/+uKj6vk+oRG0VHIXrBjHVdU4sXVgDZ530CXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003329; c=relaxed/simple;
	bh=8anQ8x+9w88e/HCIFKHmvRQZ82fYS9BPTNKdMKd1o80=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=t7lRlmSRr0U9tXBsKlYFdgSxtEITjxKFpg4++CR584gAwGlfMca1fesdFpt78aVUwvM7cSy6XkBzeKhZrBVKqlcf0LQn1FgyrNc6E/UpM3ztlEofOlITkRDunk04qfpDffEO7VX0+S+GzmCwgDtEHzlbXaRHnm9njNgyH5Badfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=frzfSGVF; arc=none smtp.client-ip=109.224.244.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="frzfSGVF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780003314; x=1780262514;
	bh=Ocdwdp818KRICNMyNvofIyBu1lbIAUpLoNWLdxSoG9A=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=frzfSGVFpxmfP2Yl9o3tW3+t+5upmWxviQP7kamMuTKSEUyt0XeHp21lE1v0FdviI
	 SYzKI66MZTXMb3UvwG7a5HQvY3jbQ69u+Op86GwKP+412kRiqWNwoEIERC+5+X/sGt
	 xsTmK/7M3ckh5XArqs7BsjBmhz8jiYCFslWnISKJ6dx/pdgColYzB8rfK4aTQHxpwI
	 YYdm6TrkaZXkswFuVYD4uP3QgWUrHgTaq3dBsybFqLbMtOOGMXL2uS1R7AsNhZLg8Z
	 /S2Kg4uo8V1dbQ01sk8/IyBFklnslK2N5ahb5et01K6f4PlWZAube1QPpaGyfB5d/R
	 1TtEeRVRVAvQQ==
Date: Thu, 28 May 2026 21:21:50 +0000
To: "mic@digikod.net" <mic@digikod.net>
From: hexlabsecurity@proton.me
Cc: "gnoack@google.com" <gnoack@google.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via F_SETOWN to invoker's pgid
Message-ID: <cFjmBkbTY-D5pYl66NixBeqbhWBzS7kBEUHCWbhTQwkiuvKg8xNkSEf9rYqDQiD76er1gK8Q6t1YOJ4nIPuvILuwG42d8_rfMZpQ5VmJru0=@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 0a30a4b1ef55abd0ca2fc1993287d9fade02e02c
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From 22a0086b44beaaef01883e047dd4a8b8bc3153e9 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Thu, 28 May 2026 01:30:00 -0500
Subject: [PATCH] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via F_SETOWN to
 invoker's pgid

A Landlock-restricted process can bypass LANDLOCK_SCOPE_SIGNAL on the
SIGIO delivery path and deliver arbitrary signals (including SIGKILL via
F_SETSIG) to non-Landlocked targets that share its pgid, by exploiting a
producer-side cache-vs-live evaluation gap.

The SIGIO path in hook_file_send_sigiotask() consults a cached subject
stored in landlock_file(file)->fown_subject at fcntl(F_SETOWN) time
(via hook_file_set_fowner()), instead of evaluating the live Landlock
domain of the invoking task at signal-send time. The capture is gated
by control_current_fowner(), which returns false (skipping capture)
when pid_task(fown->pid, fown->pid_type) is in current's thread group.

This is correct for PIDTYPE_TGID / PIDTYPE_PID, where the target is a
single thread or thread-group leader sharing current's cred. It is
unsafe for PIDTYPE_PGID and PIDTYPE_SID: when current is at the head
of its pgid hlist -- the default placement after fork(),
hlist_add_head_rcu() in kernel/fork.c -- pid_task(pgid, PIDTYPE_PGID)
resolves to current itself, same_thread_group(current, current) is
true, the capture is skipped, and fown_subject.domain stays NULL.

hook_file_send_sigiotask() then short-circuits at
"if (!subject->domain) return 0;", allowing the kernel to fan the
signal out to every member of the group, including tasks outside
current's Landlock domain that the SCOPE_SIGNAL contract is supposed
to protect.

The direct kill() path (hook_task_kill) is unaffected: it evaluates
current's live domain on every call. Only the cached SIGIO path is
broken.

Repro (ordinary unprivileged user; sandbox active in the child):

  int pfd[2]; pipe(pfd);
  landlock_create_ruleset(&{.scoped =3D LANDLOCK_SCOPE_SIGNAL},
                          sizeof(attr), 0);
  prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
  landlock_restrict_self(rfd, 0);
  fcntl(pfd[0], F_SETSIG, SIGKILL);
  fcntl(pfd[0], F_SETOWN, -getpgrp());           /* PIDTYPE_PGID */
  fcntl(pfd[0], F_SETFL, O_ASYNC);
  write(pfd[1], "X", 1);                         /* trigger SIGIO  */
  /* every pgid member receives SIGKILL, including non-sandboxed
   * parent / supervisor / sibling workers */

Tighten control_current_fowner() to apply the thread-group exemption
only when the target identifies a SINGLE task whose Landlock cred is
necessarily shared with current (PIDTYPE_TGID, PIDTYPE_PID). For
PIDTYPE_PGID and PIDTYPE_SID, always capture the current Landlock
subject so the consumer's scope check runs against every member of
the group at delivery time.

Empirically A/B-verified on a 6.12.90 lab kernel (same .config, only
the patch hunk differs): pre-fix build exits with "BUG PRESENT --
SCOPE_SIGNAL BYPASSED", post-fix build exits with "SANDBOX HELD".
hook_task_kill's direct-kill enforcement and the intra-thread-group
F_SETOWN cases continue to work post-patch.

Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 security/landlock/fs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c1ecfe239032..edaa52572cbd 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1909,6 +1909,18 @@ static bool control_current_fowner(struct fown_struc=
t *const fown)
 =09if (!p)
 =09=09return true;

+=09/*
+=09 * For PIDTYPE_PGID and PIDTYPE_SID, signal delivery fans out to
+=09 * every member of the group at SIGIO time. Even when pid_task()
+=09 * resolves to current itself (e.g., current is the pgid hlist
+=09 * head post-fork), non-current members of the group are still
+=09 * valid targets that must be checked by hook_file_send_sigiotask().
+=09 * Always capture the current subject for those types so the
+=09 * consumer scope check runs against the live fown_subject.
+=09 */
+=09if (fown->pid_type =3D=3D PIDTYPE_PGID || fown->pid_type =3D=3D PIDTYPE=
_SID)
+=09=09return true;
+
 =09return !same_thread_group(p, current);
 }

--
2.43.0
