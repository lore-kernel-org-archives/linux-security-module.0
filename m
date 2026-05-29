Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A73812CD
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081668; cv=none; b=huCMfZjj8tW+s3bNEagUNAswItFVWLfhJv6tmgyPZv1pArqhDK7SAtYSm7UmaizVbzEek7KWIkqxXi2PN883qfcp08lx2kEvKV7O2bcoCtkuupWXmFJr4mcCJE/EtstF8UyS3dN3lceDptA9nGmuVv42fvsaSgk9KpDhdDgrpn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081668; c=relaxed/simple;
	bh=9Knp7eknG8Hf0NCMMDVCwin6Qa9hITGRKVhniVc+xt8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XQHROdi7JVO5oWCP1zrrTXRrNkvEpIFg2PFIgURXn1lGkGOMrwVUDR9PrXuA3m7UWN5FNye1an121wwODnzPSVDqYdQxP5/nlGQELQcLMcQIhrEDLqvZBp2xx6zgNDkQT7oLqo0JHVyxTrM+jJuGJmmHkpoR8GEL1QZYHZtn52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VdevuVAs; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VdevuVAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=o2cwkjzz2zemxbfasfglysqqvy.protonmail; t=1780081656; x=1780340856;
	bh=9Knp7eknG8Hf0NCMMDVCwin6Qa9hITGRKVhniVc+xt8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VdevuVAsQm1f/41th3gpmNf3jFrhSJcdT1lXG+/OaKr1oB6+dTEppDGg87rlJLDoN
	 YCDWghgqmvUXwwCHpxWgOu0Jacsm/d4qWEofhYPRgaAEO4kyqibAmfYuavZrhLjglm
	 t1FbfJhYmrr6NE2dCcqYGo4Uk/MwpA663IeYeY8VwJyJge37/7tDSA+XNjwoUuwUax
	 ZZKI/+/2oJXS7kKDKY1MDvFATzPeKHcMO8OU/tH3t2sH7DjUYQwQEvmVfoDimgWD49
	 AZjimqRPpwnuz+CfYx8gihzhik3V5eu8QNmhctAyEtbVICijfX/tHz8VmPKxOWHcKX
	 pvSricqt4p7ow==
Date: Fri, 29 May 2026 19:07:30 +0000
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
From: hexlabsecurity@proton.me
Cc: Justin Suess <utilityemal77@gmail.com>, "gnoack@google.com" <gnoack@google.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via F_SETOWN to invoker's pgid
Message-ID: <7rvmLIHR1Zh8RDF1IY1-SYRHzErgw9gPHq0k98RLYVsmHqAejjxcuJi8V3QaSbW-SnNvY5tfM2Xn_S1dEajKV_f7iyitoPwJgOSTZQ0nytc=@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: b9b20d077289ff690bb836e70c188ab1ae8e0ba4
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From b5fdc79ce1cb2881d59dfed01d3d9170306be9e8 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Fri, 29 May 2026 12:49:41 -0500
Subject: [PATCH v3 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via
 F_SETOWN to invoker's pgid

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
single task sharing current's cred. It is unsafe for PIDTYPE_PGID and
PIDTYPE_SID: when current is at the head of its pgid hlist -- the
default placement after fork(), hlist_add_head_rcu() in kernel/fork.c --
pid_task(pgid, PIDTYPE_PGID) resolves to current itself,
same_thread_group(current, current) is true, the capture is skipped, and
fown_subject.domain stays NULL. hook_file_send_sigiotask() then
short-circuits at "if (!subject->domain) return 0;", letting the kernel
fan the signal out to every member of the group, including tasks outside
current's Landlock domain that SCOPE_SIGNAL is supposed to protect.

The direct kill() path (hook_task_kill) is unaffected: it evaluates
current's live domain on every call. Only the cached SIGIO path is
broken.

Tighten control_current_fowner() to apply the thread-group exemption
only when the target identifies a single task whose Landlock cred is
necessarily shared with current (PIDTYPE_TGID, PIDTYPE_PID). For
PIDTYPE_PGID and PIDTYPE_SID, always capture the current Landlock
subject so the consumer's scope check runs against every member of the
group at delivery time.

Stable kernels before the fown_subject conversion store the domain in
landlock_file(file)->fown_domain; control_current_fowner() is identical
there, so the same exemption and the same fix apply.

Fixes: 18eb75f3af40 ("landlock: Always allow signals between threads of the=
 same process")
Cc: stable@vger.kernel.org
Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Tested-by: Justin Suess <utilityemal77@gmail.com>
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
=20
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
=20
--=20
2.43.0

