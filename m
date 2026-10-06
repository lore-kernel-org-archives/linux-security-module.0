Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B3C49EC56
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301497; cv=none; b=K1Uh7ip1M0Q5Ycw+MgH5V65zKTSe9LMTq94+9jytUpNTyiMLVzIXS9I4k++6aU/NwsJWa88FPvKdxEry94fCtcAECwJF/HBUZokaqvDQ2M5kGvqTDtivXk3J29D3FxXrW0IsDAylapDTSj218J49Yq0+ZPhOgC7gvZ2V9VeSAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301497; c=relaxed/simple;
	bh=8vkzyF59g32RtfmPZXkdpM3bmDGASCtX3QXPvfTT0t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WxjmrFmjXmJHQhpuHyT226JF7Su6DhgWpqcEO68byscx1E3sP0pman0EwiD7q+LYbYxsn//WAFR/COCFBFMv2bRHZR8/7lfV1f4/f+gAKk7ssxr0dCAYwaiB0vhWBYY7EXlGVxVAbSVwRgKKcUzZoa5zUlwLSht5+zwryTTys0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=OS/v21t2; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="OS/v21t2"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-917a97b39e8so10726516d6.3
        for <linux-security-module@vger.kernel.org>; Tue, 06 Oct 2026 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791301492; x=1791906292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/k5W5gRBGKOnv0GDUCR5h+EZBe1kD+dGC7pkS9kRVb8=;
        b=OS/v21t25O6jQ72j2LBDZjZ8jz044uYh7yz3bYrMBeyNcGKFYyn9gWledD6gwEXQkt
         MSsaLHB3Ugl7MWDi+OQ6YF8F2UYeB47TDLpaZtGiVEXh26OHWJhV9cypO4aEbp1+JDzN
         BN/uUSjV6oRreqABPwygMn2LoJaXl3TXWTn27gurXiDMKjihDxFXLn9Cd0DqOhIp273T
         DPdDz3vkEXjU7rFSujovkgNKGzOrBNnf3WnexeseBx2+X8Lf5N7TvJklAPeBk0uAqEby
         Pu1phf3ec6qz3woHq0B1cjItldyGstAAboyuyU6iHAcDut1HCWtrlQwy/sOchQXAoSJm
         jZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301492; x=1791906292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/k5W5gRBGKOnv0GDUCR5h+EZBe1kD+dGC7pkS9kRVb8=;
        b=NY4SeNdnKy9O3imV6A3KSaEc4XnvVRHnjFOBm9dC5ILEKekLhyqQeSana8P+U+MdzT
         rvSL5M3g6KA2J2rPNgkfz+ezWVqfDLgtDjaypUKMuvWCnYnbF2IBum7ihSA7d9YFXDjz
         CCvrCafwtH6EP3e7c8h6E6VD3tYD5Nw5ABA3YQR+yAPAXUd3R1vK/i71eoZpIItVSW3P
         8/0SkLgVIPwskr8EQpyOTf1ttKxEjz9QTpxtOz7Utufme0DLUjyI+pMEip5JwLPREK2L
         z33i+NDzVOoN2xCp1LYyoWiU9YD88v3Mf3X+K6l0E7MBqr40g8PhwNzV7KudvbJVJqSK
         v1dw==
X-Forwarded-Encrypted: i=1; AKwUvBwoxePkShYkooArRYN11OeSl+5ChYBa1nLQICKWfXiHCBBkX3oo8Dut3sbAlwNL6wIvGR1xHdJG9vBEA0xeUJK/jVnKG3g=@vger.kernel.org
X-Gm-Message-State: AFuF++mFon89n+W4DYWMwEnOTIXnaoDE8FO+xAsVZzNJQJfiNa+KDskT
	2KtotlxqXIeQH697aLxBd9qqhYTL2I9WtTT1e9mHa2GX8O0ULDbe2sdNIxukTEjVAs8=
X-Gm-Gg: AYBFou2u2CLfC8SOQ8DTotxoZHUenYpBrX3ty49omjl8DpIo5se0kiyWVn2zOm/gtS6
	v87Gj2FJ6GNIdXmu17k1G327ZnS6Ftbp+AsrpXwp8/aQmrQCkGX0BFaom+osIJXE5bDTsridGy+
	8t2VZ4zGFr5m3W/zKo7QGzjctholi4ylOPiuVOsGEkJsLWsH+U0S2d+OFRiW3RR4jpGcXqMZmpI
	zDrRfQWvI1U80lgOHdjO0G6ECPiQv+vryfAFEGbheg3Li6JMKd9WKvZKjWd9RaPvZCUyhs9/GyF
	adN9ceD/iismKC/3e7VA/kzv6qGQSR4a8yM+akYaiM4HB+L1lLp/+UeGnhOpEhqn8lD42WeUw6t
	G//QwzDSLODzOpGhwgWRU3NpLf1GXZoHnDSTEtmWcL3l6hJ9bW05bJnaelLtPsRVxOystb8NMpO
	irYaCMJDKv3Ttsakavei4D5SL7tvv2FcboudSFoCdsOJCZPttHah3RNRohXdBCt+32v/kkDN5uA
	0x2vTZyQvqfAF8=
X-Received: by 2002:a05:620a:1786:b0:93e:54d2:2285 with SMTP id af79cd13be357-93e8f37a03dmr301921185a.33.1791301491617;
        Tue, 06 Oct 2026 08:44:51 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca1a7a40sm1142936285a.7.2026.10.06.08.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:44:51 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 15:44:21 +0000
Subject: [PATCH 5/5] capabilities: don't let ptrace borrow CAP_SETFCAP
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-setfcap-userns-v1-5-f47e7ed66072@toxicpanda.com>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
In-Reply-To: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791301478; l=6195;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8vkzyF59g32RtfmPZXkdpM3bmDGASCtX3QXPvfTT0t0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHNGGw1vUwvXcplc29Z3TsCoIHmp/GbPMb9KUsV94Rc3EGWtTYg/cXaPnamHbE91Nwb4n74qJXR
 0+AE3tg1rkwU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A task that entered a user namespace while it held CAP_SETFCAP outside may
map uid 0 of the parent and write file capabilities that are honoured
there.  That is the one privilege it keeps outside of its namespace, and
the ptrace checks don't know about it: for a target in another user
namespace cap_ptrace_access_check() is satisfied with CAP_SYS_PTRACE over
the target's namespace, which the owner rule hands to any task with the
right euid, and inside the namespace everybody has a full set.

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    ptrace(PTRACE_ATTACH, A)
                                      uids match, euid == ns->owner
                                    make A write "0 0 1" to its uid_map,
                                    or set file capabilities
                                      A is entitled -> allowed

The same goes for /proc/<pid>/mem, process_vm_writev() and pidfd_getfd().

Require for PTRACE_MODE_ATTACH and PTRACE_TRACEME that CAP_SETFCAP of the
tracer reaches as far up as the target can make use of: to the topmost
ancestor, within the target's setfcap_level, whose root user is mapped
into the target's namespace, or can still be mapped because the namespace
has no uid map yet.  CAP_SYS_PTRACE over that ancestor is accepted too,
since it gives control of tasks there that have CAP_SETFCAP anyway.

Targets in the initial namespace, in namespaces that were entered without
CAP_SETFCAP (what unprivileged users create) and in namespaces that don't
map the root user of an ancestor (the usual container) are not affected.
What remains is a tracer that gave up CAP_SETFCAP and CAP_SYS_PTRACE and a
target that didn't, in a namespace that shares its root user with the
tracer's.  PTRACE_MODE_READ is unchanged.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 26798d62e6b1..7263c78b6397 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -195,14 +195,52 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
 	return 0;
 }
 
+/*
+ * CAP_SETFCAP of a task can count in ancestors of its user namespace, see
+ * cap_setfcap_level().  That is a privilege outside of the namespace, so
+ * capabilities over the namespace are not enough to take control of the task.
+ */
+static bool cap_covers_setfcap(const struct cred *cred,
+			       const struct cred *child_cred)
+{
+	struct user_namespace *ns = child_cred->user_ns, *seen, *p, *top = NULL;
+
+	if (child_cred->setfcap_level >= ns->level)
+		return true;
+
+	/*
+	 * It is of use only for root users that are mapped into the namespace,
+	 * or that can still be because there is no map yet.
+	 */
+	seen = READ_ONCE(ns->uid_map.nr_extents) ? ns : ns->parent;
+	for (p = ns->parent; p; p = p->parent) {
+		if (p->level < child_cred->setfcap_level)
+			break;
+		if (kuid_has_mapping(seen, make_kuid(p, 0)))
+			top = p;
+	}
+	if (!top)
+		return true;
+
+	if (cred->user_ns == ns)
+		return cred->setfcap_level <= top->level;
+
+	/* CAP_SYS_PTRACE up there gives control of tasks with CAP_SETFCAP. */
+	return cap_setfcap_level(cred, ns->parent) <= top->level ||
+	       !cap_capable(cred, top, CAP_SYS_PTRACE, CAP_OPT_NOAUDIT);
+}
+
 /**
  * cap_ptrace_access_check - Determine whether the current process may access
  *			   another
  * @child: The process to be accessed
  * @mode: The mode of attachment.
  *
- * If we are in the same or an ancestor user_ns and have all the target
- * task's capabilities, then ptrace access is allowed.
+ * For PTRACE_MODE_ATTACH, if the target task may make use of CAP_SETFCAP in
+ * an ancestor of its user_ns that our CAP_SETFCAP or CAP_SYS_PTRACE doesn't
+ * reach, then ptrace access is denied.
+ * Otherwise, if we are in the same or an ancestor user_ns and have all the
+ * target task's capabilities, then ptrace access is allowed.
  * If we have the ptrace capability to the target user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -223,11 +261,15 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 		caller_caps = &cred->cap_effective;
 	else
 		caller_caps = &cred->cap_permitted;
+	if ((mode & PTRACE_MODE_ATTACH) &&
+	    !cap_covers_setfcap(cred, child_cred))
+		goto deny;
 	if (cred->user_ns == child_cred->user_ns &&
 	    cap_issubset(child_cred->cap_permitted, *caller_caps))
 		goto out;
 	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
+deny:
 	ret = -EPERM;
 out:
 	rcu_read_unlock();
@@ -238,8 +280,11 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
  * cap_ptrace_traceme - Determine whether another process may trace the current
  * @parent: The task proposed to be the tracer
  *
- * If parent is in the same or an ancestor user_ns and has all current's
- * capabilities, then ptrace access is allowed.
+ * If current may make use of CAP_SETFCAP in an ancestor of its user_ns that
+ * parent's CAP_SETFCAP or CAP_SYS_PTRACE doesn't reach, then ptrace access
+ * is denied.
+ * Otherwise, if parent is in the same or an ancestor user_ns and has all
+ * current's capabilities, then ptrace access is allowed.
  * If parent has the ptrace capability to current's user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -255,11 +300,14 @@ int cap_ptrace_traceme(struct task_struct *parent)
 	rcu_read_lock();
 	cred = __task_cred(parent);
 	child_cred = current_cred();
+	if (!cap_covers_setfcap(cred, child_cred))
+		goto deny;
 	if (cred->user_ns == child_cred->user_ns &&
 	    cap_issubset(child_cred->cap_permitted, cred->cap_permitted))
 		goto out;
 	if (has_ns_capability(parent, child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
+deny:
 	ret = -EPERM;
 out:
 	rcu_read_unlock();

-- 
2.55.0

