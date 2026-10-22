Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694207;
	b=gwoWJo34H4jdm7PF+K/bmDt8dUUMuBiTNNF0gNsbiTuU12X/s4WZbWn4I+xdPCfzcMj8
	 g3wndSKOyzVecDZBcMW9I7yjgOctt2bbaKkmMVWLUl1tw9GfLrzmJ3i56Cpu/xPOUTjgf
	 v7SvRUTcmKgyaRAxfXDO0FklZaE5+CfpNxduLh5oFDZdoHasJz0NAIi1/xVA1iRKb83zo
	 NkEZSX36G4bp5UrGxGAGOJBpXlu+o4QBHUuK+bTo5DmuMyjQiLCVha/aN7kNxUbooSPhL
	 3mgqQ+tU3Kpb08Sm0vA2cy9CaJRY8j166Gy8Fb+9RhF5/IL7Rhro4q6praVrW+dkc8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8r5BCsxmHZxLH4Un1fs3O+/5YNLq5p7F1V9jPnaSk70=;
	b=PKHXdVuuL59SjsG2Oi064yc4OTUDzKWou3383ru4A4gQc6B/x/xoyeRN69hy+4B+LGqa
	 ek22NYRzIJkQmaAiFFJTJ2VHE8GXuKW3RYgvLABHMy/5eRXES/A57LKJlIF3EyNmP71NX
	 Oi9apnSFgE3KxFQgXXjciQPdcUf4jbr6JS8aE272mTHJqniekt7CRuBTE4Xcc1nWy4AdW
	 bCb/MW11X5oEIISa+nPerdfZNQ6+111G7kLaR2gbTZm85xVDExbbhfj0OXr81ncMJDhuf
	 D6z40jtadu4jLt0of9JqAdoG1EOlKgfRwhk5/MkzzTSnIRRsRaqsm6srnvNNlW9gGmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EPvKwcer;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158FB60A3835
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 158FB60A3835
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EPvKwcer
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-917bab38b14so1966366d6.3
        for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792694206; x=1793299006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8r5BCsxmHZxLH4Un1fs3O+/5YNLq5p7F1V9jPnaSk70=;
        b=EPvKwceruooaSpEuq/d9NX/0RSTGjLoIvN4dwmjNQmOXxeAaL4IM/5oldx2Sjjn6Cl
         Vt8X0TF2zGvQ/2Xo/wPc3NP0TdVg5dgUioEEpXkoK8T4zTqYy093PAdzQHYxj31XkNcI
         YAC9SiPa/W6r5KPG5tJmlr/s67mWff6xG94T610ScxVAunagFyCVQtv1NjCTwwSR1iEw
         C1CkL/Yiz2rILac3GOQXbGDhm/wPk9qG7CEK0JVbXNw/rAwsgJKmCh7vp9HXBcNHoGJk
         dwYOasHp7zDAj3a0RjFOziC5q7nG21er6io8cvoCkjzeXseHjHPwk77zO7moU05RFyJm
         36gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694206; x=1793299006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8r5BCsxmHZxLH4Un1fs3O+/5YNLq5p7F1V9jPnaSk70=;
        b=TAfNNtYCr4/numaUGKAeesHXMBggLjfjdzxxQrYLIfTcjBQJsfAImFo4SjDD68DCQO
         0/VfR8DwruGFu9nc7uRQOT0QJB3sCbYPQBC2ch1lpDHosKDPlHiuagfAXsSpNHmsqRsc
         rHsqs2AVk1TpoNRtqtV/hJ9vBLWYw3AzyvjE1KAH1qckPccWC9MdfuTrOVucQBX7/NH2
         K+bAyxppPJfthB/QpvANVLxo/Uma/g1SO7YJFvH2/2xH964mEZ61QhuzIKOexz9hHxxB
         /dvha7VXSnHStHlTiDyAqDO94fEWzhsRF7SeK1Fgxg0RSJ+3V/SE1hJvomg02YXVuyIy
         mr3A==
X-Forwarded-Encrypted: i=1; AKwUvBw5FsqZUNB95z6KuyIXMrFBlRSj694Ia+kT1Wy9SFGEqbQebMYVk9T0/9MFldjfeN0H8sRRkHz5H8vGXwfZ6oj060whORM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAULVUbYKhfzw46yDaXV7bV7HJT2Bmx4rfbjskoeOBNh5yAV5/
	4o0LLZ7uPQLWi+PZGXbsvZPY7oEzPGX/fhd6RCRASgAf/mSdS9Gaxby4NwAdbJZRAXXXpsPPSVo
	BGCMoRUo=
X-Gm-Gg: AYBFou2VPBjiq8bazn7epsWycrYhdjX7+lpdHCNddowbYpCz1FUopHyYwix8xH0xZZi
	BtoR7YV3cLGXREMbFmNPSlCYQeA1ZZhgO8Opdudcup55TgawYgN01ZLXdXQYGCWx23GhhDEqZxN
	gJyB9iZw0bjqtOXu4/Gof4Pnx28dze3txkUaad3a0lEvWGpFNdAJORRc6tnme+s9ih2FB2NsDtO
	lLY9Un/c7Gb4egXukrjaDLyuaPY0GaCjW8iOHWNxtLQBtthcvg2P7ry03F5fZ9ASO29XR5NeO9I
	atpTmd9qnQS2xzhYBvizsmZfIkWH1KMvb9cSbFauby3K9AdXJtchIQHeVHK8sjLbnWHxMNQoa9R
	c4y/JikcgYHLR2xGmXKUkaNAeSAm8Gst6R49kpiR4h2ETKIm3ZUY/jkUd5qj/AHlvr6HASShOYD
	BAXQ3EPwns96MTfC2+iM8+c+AJvK/RZpog4Ya0dkSlOrtBMOXomiMUrp8BEPhs92SGu4VHDTC55
	IqRIFZzvce7n39apCIrpdTU5Bc5FC9trUYsWj5cHtwbtoWusN/HxcyleUiYaBjWnz0gFY40aLnG
	W8p4Qc5Zo/zr8jCf/A==
X-Received: by 2002:a05:620a:261e:b0:93f:1445:82a5 with SMTP id af79cd13be357-93f6f8ebd8fmr54802785a.79.1792694205890;
        Thu, 22 Oct 2026 11:36:45 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f6fbd9609sm18480285a.26.2026.10.22.11.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:36:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 22 Oct 2026 18:36:23 +0000
Subject: [PATCH v4 5/5] capabilities: don't let ptrace borrow CAP_SETFCAP
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-b4-setfcap-userns-v4-5-88aa0ffaa08f@toxicpanda.com>
References: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
In-Reply-To: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792694192; l=5986;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=BQlhhPSD1xeXj+53MhIV4kladVTv5N+1sZePBcGqCkU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLlUqTvveTNAy2Vwzfj2AVuzq5DWs6LaLqZu1uqxd6QgwxWGmeDSq57SHyihZaSFAHmCPOlDRGm
 +dBr/StnVGQ8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Tasks in a user namespace created by a task with CAP_SETFCAP may map uid
0 of the parent and write file capabilities that are honoured there.
That is the one privilege they keep outside of their namespace.  setns()
no longer lets anybody in who doesn't have it, but the ptrace checks
don't know about it: for a target in another user namespace
cap_ptrace_access_check() is satisfied with CAP_SYS_PTRACE over the
target's namespace, which the owner rule hands to any task with the
right euid.

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    ptrace(PTRACE_ATTACH, A)
                                      uids match, euid == ns->owner
                                    make A write "0 0 1" to its uid_map,
                                    or set file capabilities
                                      A is entitled -> allowed

The same goes for /proc/<pid>/mem, process_vm_writev() and pidfd_getfd().

Require for PTRACE_MODE_ATTACH and PTRACE_TRACEME what setns() requires
to get into the target's namespace: CAP_SETFCAP of the tracer has to
reach the root users of ancestors that tasks in the namespace can write
file capabilities for, or the tracer has CAP_SYS_PTRACE over the topmost
of those ancestors, which gives control of tasks there that have
CAP_SETFCAP anyway.  As in setns(), root users stored through an
idmapped mount are not considered.  A tracer in the target's namespace
got in with as much and always passes.

Targets in the initial namespace, in namespaces created without
CAP_SETFCAP (what unprivileged users create) and in namespaces that
don't map the root user of an ancestor (the usual container) are not
affected.  What remains is a tracer that gave up CAP_SETFCAP and
CAP_SYS_PTRACE and a target in a namespace that maps the root user of
an ancestor and was created by a task that didn't give it up, which the
tracer can't setns() into either.  PTRACE_MODE_READ is unchanged.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 655e822c8e76..b33b10b444bf 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -254,14 +254,41 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
 	return 0;
 }
 
+/*
+ * Tasks in a user namespace have CAP_SETFCAP that can count in ancestors of
+ * the namespace, see cap_setfcap_level().  That is a privilege outside of the
+ * namespace, so capabilities over the namespace are not enough to take
+ * control of such a task.
+ */
+static bool cap_covers_setfcap(const struct cred *cred,
+			       const struct cred *child_cred)
+{
+	struct user_namespace *ns = child_cred->user_ns, *top;
+
+	/* setns() only lets in tasks whose CAP_SETFCAP reaches as far. */
+	if (cred->user_ns == ns)
+		return true;
+
+	top = setfcap_top(ns);
+	if (!top)
+		return true;
+
+	/* CAP_SYS_PTRACE up there gives control of tasks with CAP_SETFCAP. */
+	return cred_setfcap_reaches(cred, ns->parent, top->level) ||
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
@@ -282,11 +309,15 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
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
@@ -297,8 +328,11 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
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
@@ -314,11 +348,14 @@ int cap_ptrace_traceme(struct task_struct *parent)
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

