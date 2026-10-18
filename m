Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4373FB7F1
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344723; cv=none; b=YcNzkTbjjE4hjRUBI4+y6FsKCByLQ3Sg38RLryB1IqFcDPTqmbNEcWzxfnIghugAP9sYl+OJHzOb+89stdveCaWE90Y96hJ4HNTlxEI4BqOftRQWuXK05EF1KFYP/tHFl4Pob6QRUNsDRkfGTTrzzY7+g67p8rZVfbRXrrC55pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344723; c=relaxed/simple;
	bh=ES/YmLqQpZrGDacjVmu9kckYU9i7kD21w/83zWhEjgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IAWmJCRDehGAoDIS0LX4B7o+vNnYD3JbrVkGRFYOTko0wQfoT19XlnTXwnJ8dbT0vrtUqv693r50RjZCpbEguTu6lT0cnKaIxG+5OSUDKmM6xlQGwhdXih1pzIOPXn3rV+Oo7j0NLMffD6+/zLedeS+5Bl2VT7j+YKdJPduE5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=NOq2l7hy; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="NOq2l7hy"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e64d52949so143331385a.1
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344720; x=1792949520; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdC8wlSImDPrmqS9XYi7KJjeal1kIUqQfdTwK++LY/s=;
        b=NOq2l7hy+H7ODKIRAYCmXF08mLGLbuh/lLpAoMpP6dtN8X8DOvlUmhoTzTwjPx5JNK
         B21tXWJSkk0AJ618310uKVou1jqTV8Fj0OnRGo4mXmLcpZ90LH4skU+nRoCxDg9OfqHo
         6XtLtnJJYvJAcnbBVKYYD0wl7s0aV3FXkayuPLnxI70ax0tBYP4sqaVK8F8jWxMIRKV9
         wi4WlAXuW/B4Aa05YHm2mKtokLnQh++cszXObkOx1aLM/BUEuDVOb/LTGfSnfGLLRppM
         nrU33SGuBSuWDTeGpS0cg2vbFp/G0l7BZWoM/xey5l00BDYE7aTFYsttzyGQOdCanM6N
         Aelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344720; x=1792949520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdC8wlSImDPrmqS9XYi7KJjeal1kIUqQfdTwK++LY/s=;
        b=h5f1JvjuiHl3yHhNLDU4hr23Bolfw+NtVE9ND/Fx1jK8qokyP/VFqtWJ0tE45vpqo8
         MNiSviayTF3kRiuLaAOQ36pbsj2oucns2wp0hphX0Z6N1BCgMSbK6dSFjvZ5h2kLTOtj
         zjRuh1pQqSXi4x1sN0zEZla/hG235zqKHU2Ek71Ts+CB6KPFu0Aur3K6DbRvXqdxEH/c
         GJjoFNrBEixiHswUwcbQH6fZK0tiIgdjFuuDE7Xw70iPXAKBBQ61bnPHrSiEioBVFpwf
         DUeDRjB6CmTajV03SzhRDKBYkKyB6CrNkbApeRfrtNR9TR2ReSuC2/2IjPz0XGKSATQA
         Qy0w==
X-Forwarded-Encrypted: i=1; AKwUvBw3hiJg6BSNum1mP1oy+AOTKzLiBqu7o0psdpsgbPjewnJbCb0tXB57DEGgWM9ruUP6lQfVvXsUfmeZH+MmIafu+QaIpj4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMFOrNCtNaupX8VUt4l7/Sccm4iyTrmwN4pTtrMNm0YYFKz70f
	qBqAZ9yisTpl7v8a8uiGw5acHGxsvRBi1k0yhW+FBuvrbJgxYdHrHrfDGrf3JE+cRcYxynvHN9P
	L33l1
X-Gm-Gg: AYBFou2Ejhb7jteUVYHNvYJUzE6lyz1Yrq4XkTwA9YQ5+pNE2HM+lWr3qHj5fJ5bm1z
	DJ99OUYQ1yh85zCjNIbNSf+wFjHlmG3ld31zMYGnTo3PQkQmyelIJq6cG24NOynA70H+qfgvUhV
	pMcYzLhUhsznPMV+hgLtwWWgSkfucpcjybceSpoGMoMX+E8TVxZEJJXcVHdrjIpiXRctre5G3/R
	79P1btfytucT99/LYYM7ly9XzFEeCMnA2jMZberO7Hai1xMSmoFZ+aSEUY6wCa9RoWHYebhFLAC
	T2XlUorz4+bVWqcgDUC4cpG0LDIdn53iV0a+9RDb5BocUjhpWRisuopZ3giBuvuWMh5ATqfFShK
	BschXuWS5sY1gbuPbuGumCQ2Ct6gk3wu6fYv2gN7E5r19da5LWBWv75JOp7l4WkiqSjtFhYwgOc
	CExeYngUYHBJyTQdEu7OKZ80IS3uCuleCMQHekNYwrAlWpCoMmQojkBAWVjV3vbDGpFd2nDZ8NT
	Pm7KeKknK6LubQ=
X-Received: by 2002:a05:620a:170e:b0:93e:9292:1b9e with SMTP id af79cd13be357-93f29b61deamr852644085a.1.1792344719776;
        Sun, 18 Oct 2026 10:31:59 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbacfcc6sm76417456d6.23.2026.10.18.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:31:59 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:43 +0000
Subject: [PATCH 01/13] cred: gather the rules for acting on a task by uid
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-1-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=10935;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ES/YmLqQpZrGDacjVmu9kckYU9i7kD21w/83zWhEjgo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFsfH4ZFn4MmoVsMNdW5NIKEi+3XLLs8vgWlNrJoe/oLxST1lxwA+mJZYFAHYDulVMG8/U8Tcnf
 Gy0KkGLw01QU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A number of operations let one task act on another without any capability,
because the two belong to the same user: signals, scheduling attributes,
priorities, resource limits, ptrace and more. Each of them compares the
ids of the two credentials by hand. There are twelve such places, in six
flavours that differ in which ids they look at, and nothing says that they
belong together.

That makes them hard to review and hard to change. Nobody can tell from
one of them whether it differs from its neighbour on purpose. Whoever
wants to know what an equal uid is good for has to find all twelve, and so
does whoever has to change it. A place that is overlooked is a hole.

Gather the rules in kernel/cred.c, side by side:

 rule     of the subject    of the object      euid 0 used for
 signal   euid or uid       suid or uid        no     kill()
 sigio    euid or uid       suid or uid        yes    SIGIO, SIGURG
 sched    euid              euid or uid        no     scheduler, nice
 ioprio   euid or uid       uid                no     ioprio_set()
 move     euid              uid or suid        yes    cgroup v1, resctrl
 control  one uid, one gid  all three of each  no     ptrace, prlimit, keys

Where it says so, a subject with euid 0 may act on anybody. That is a
capability by another name, from before there were any, and it belongs
with the rest: it is a uid that decides whether one task may act on
another.

What each operation means by "the same user" has grown separately and
cannot be changed now, so every rule is kept as it is. The functions only
speak for the ids. A capability that does as well, and the LSM hook that
goes with the operation, remain with the caller.

The callers are converted one by one in the patches that follow.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/security/credentials.rst |  19 ++++
 include/linux/cred.h                   |  20 +++++
 kernel/cred.c                          | 160 +++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)

diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
index a39a2a2f67aa..b095c03b4531 100644
--- a/Documentation/security/credentials.rst
+++ b/Documentation/security/credentials.rst
@@ -422,6 +422,25 @@ magic.  This may not be used for pointer members as what they point to may
 disappear the moment the RCU read lock is dropped.
 
 
+Comparing the Ids of Two Tasks
+------------------------------
+
+Whether one task may act on another because both belong to the same user must not
+be decided by comparing the ids of their credentials by hand.  The rules for that
+are kept in one place:
+
+.. kernel-doc:: kernel/cred.c
+   :doc: One task acting on another on the strength of its ids
+
+.. kernel-doc:: kernel/cred.c
+   :identifiers: cred_ids_allow_signal cred_ids_allow_sigio
+                 cred_ids_allow_sched cred_ids_allow_ioprio
+                 cred_ids_allow_move cred_ids_allow_control
+
+.. kernel-doc:: include/linux/cred.h
+   :identifiers: cred_ids
+
+
 Altering Credentials
 --------------------
 
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 6ef1750c93e2..c92031269f76 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -171,6 +171,26 @@ extern int cred_fscmp(const struct cred *, const struct cred *);
 extern void __init cred_init(void);
 extern int set_cred_ucounts(struct cred *);
 
+/**
+ * enum cred_ids - which of its ids a subject acts with
+ * @CRED_IDS_REAL:      uid and gid
+ * @CRED_IDS_EFFECTIVE: euid and egid
+ * @CRED_IDS_FS:        fsuid and fsgid
+ */
+enum cred_ids {
+	CRED_IDS_REAL,
+	CRED_IDS_EFFECTIVE,
+	CRED_IDS_FS,
+};
+
+bool cred_ids_allow_signal(const struct cred *subj, const struct cred *obj);
+bool cred_ids_allow_sigio(const struct cred *subj, const struct cred *obj);
+bool cred_ids_allow_sched(const struct cred *subj, const struct cred *obj);
+bool cred_ids_allow_ioprio(const struct cred *subj, const struct cred *obj);
+bool cred_ids_allow_move(const struct cred *subj, const struct cred *obj);
+bool cred_ids_allow_control(const struct cred *subj, enum cred_ids which,
+			    const struct cred *obj);
+
 static inline bool cap_ambient_invariant_ok(const struct cred *cred)
 {
 	return cap_issubset(cred->cap_ambient,
diff --git a/kernel/cred.c b/kernel/cred.c
index 3df4e15bd67f..c067ef72b563 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -540,6 +540,166 @@ void __init cred_init(void)
 			      SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 }
 
+/**
+ * DOC: One task acting on another on the strength of its ids
+ *
+ * A number of operations let one task act on another without any capability,
+ * because the two belong to the same user. What "the same user" means has grown
+ * separately for each of them and cannot be changed now. All of it is kept
+ * here, side by side, so that there is one place to read it.
+ *
+ * =======  ================  =================  ======  =====================
+ * Rule     Of the subject    Of the object      euid 0  Used for
+ * =======  ================  =================  ======  =====================
+ * signal   euid or uid       suid or uid        no      kill()
+ * sigio    euid or uid       suid or uid        yes     SIGIO, SIGURG
+ * sched    euid              euid or uid        no      scheduler, nice
+ * ioprio   euid or uid       uid                no      ioprio_set()
+ * move     euid              uid or suid        yes     cgroup v1, resctrl
+ * control  one uid, one gid  all three of each  no      ptrace, prlimit, keys
+ * =======  ================  =================  ======  =====================
+ *
+ * Where it says so, a subject with euid 0 may act on anybody. That is a
+ * capability by another name, from before there were any.
+ *
+ * These functions only speak for the ids. A capability that does as well, and
+ * the LSM hook that goes with the operation, remain with the caller.
+ *
+ * Do not compare the ids of two credentials by hand to decide whether one task
+ * may act on another. Use one of these, or add one.
+ */
+
+#define CRED_RUID	BIT(0)
+#define CRED_EUID	BIT(1)
+#define CRED_SUID	BIT(2)
+
+static bool cred_euid_is_root(const struct cred *subj)
+{
+	return uid_eq(subj->euid, GLOBAL_ROOT_UID);
+}
+
+static bool cred_has_uid(const struct cred *cred, unsigned int ids, kuid_t uid)
+{
+	return ((ids & CRED_RUID) && uid_eq(cred->uid, uid)) ||
+	       ((ids & CRED_EUID) && uid_eq(cred->euid, uid)) ||
+	       ((ids & CRED_SUID) && uid_eq(cred->suid, uid));
+}
+
+/*
+ * Is any of the @subj_ids of @subj any of the @obj_ids of @obj? No rule looks at
+ * the saved uid of the subject.
+ */
+static bool cred_uid_match_any(const struct cred *subj, unsigned int subj_ids,
+			       const struct cred *obj, unsigned int obj_ids)
+{
+	return ((subj_ids & CRED_RUID) && cred_has_uid(obj, obj_ids, subj->uid)) ||
+	       ((subj_ids & CRED_EUID) && cred_has_uid(obj, obj_ids, subj->euid));
+}
+
+/**
+ * cred_ids_allow_signal - do its ids allow a subject to signal an object?
+ * @subj: the credentials of whoever sends the signal
+ * @obj:  the credentials of the task it is for
+ *
+ * Return: true if the euid or the uid of @subj is the suid or the uid of @obj.
+ */
+bool cred_ids_allow_signal(const struct cred *subj, const struct cred *obj)
+{
+	return cred_uid_match_any(subj, CRED_EUID | CRED_RUID,
+				  obj, CRED_SUID | CRED_RUID);
+}
+
+/**
+ * cred_ids_allow_sigio - do its ids allow a subject to have SIGIO sent?
+ * @subj: the credentials of whoever made the object the owner of a file
+ * @obj:  the credentials of the task that SIGIO or SIGURG is for
+ *
+ * Return: true if cred_ids_allow_signal() says so, or the euid of @subj is 0.
+ */
+bool cred_ids_allow_sigio(const struct cred *subj, const struct cred *obj)
+{
+	return cred_euid_is_root(subj) || cred_ids_allow_signal(subj, obj);
+}
+
+/**
+ * cred_ids_allow_sched - do its ids allow a subject to schedule an object?
+ * @subj: the credentials of whoever asks
+ * @obj:  the credentials of the task whose policy, affinity or nice value is
+ *        to change
+ *
+ * Return: true if the euid of @subj is the euid or the uid of @obj.
+ */
+bool cred_ids_allow_sched(const struct cred *subj, const struct cred *obj)
+{
+	return cred_uid_match_any(subj, CRED_EUID, obj, CRED_EUID | CRED_RUID);
+}
+
+/**
+ * cred_ids_allow_ioprio - do its ids allow a subject to set an I/O priority?
+ * @subj: the credentials of whoever asks
+ * @obj:  the credentials of the task whose I/O priority is to change
+ *
+ * Return: true if the euid or the uid of @subj is the uid of @obj.
+ */
+bool cred_ids_allow_ioprio(const struct cred *subj, const struct cred *obj)
+{
+	return cred_uid_match_any(subj, CRED_EUID | CRED_RUID, obj, CRED_RUID);
+}
+
+/**
+ * cred_ids_allow_move - do its ids allow a subject to move an object about?
+ * @subj: the credentials of whoever asks
+ * @obj:  the credentials of the task that is to be moved to another group of a
+ *        cgroup v1 hierarchy or of resctrl
+ *
+ * Return: true if the euid of @subj is the uid or the suid of @obj, or is 0.
+ */
+bool cred_ids_allow_move(const struct cred *subj, const struct cred *obj)
+{
+	return cred_euid_is_root(subj) ||
+	       cred_uid_match_any(subj, CRED_EUID, obj, CRED_RUID | CRED_SUID);
+}
+
+/**
+ * cred_ids_allow_control - do its ids give a subject the run of an object?
+ * @subj:  the credentials of whoever asks
+ * @which: which of its ids @subj acts with
+ * @obj:   the credentials of the task that is to be traced, limited or the like
+ *
+ * The strictest of the rules, for what amounts to taking the object over. It
+ * fails for an object that has changed any of its ids, a set-id program say.
+ *
+ * Return: true if the uid @subj acts with is the uid, the euid and the suid of
+ * @obj, and the gid it acts with is the gid, the egid and the sgid of @obj.
+ */
+bool cred_ids_allow_control(const struct cred *subj, enum cred_ids which,
+			    const struct cred *obj)
+{
+	kuid_t uid;
+	kgid_t gid;
+
+	switch (which) {
+	case CRED_IDS_REAL:
+		uid = subj->uid;
+		gid = subj->gid;
+		break;
+	case CRED_IDS_EFFECTIVE:
+		uid = subj->euid;
+		gid = subj->egid;
+		break;
+	case CRED_IDS_FS:
+		uid = subj->fsuid;
+		gid = subj->fsgid;
+		break;
+	default:
+		return false;
+	}
+
+	return uid_eq(uid, obj->uid) && uid_eq(uid, obj->euid) &&
+	       uid_eq(uid, obj->suid) && gid_eq(gid, obj->gid) &&
+	       gid_eq(gid, obj->egid) && gid_eq(gid, obj->sgid);
+}
+
 /**
  * prepare_kernel_cred - Prepare a set of credentials for a kernel service
  * @daemon: A userspace daemon to be used as a reference

-- 
2.55.0

