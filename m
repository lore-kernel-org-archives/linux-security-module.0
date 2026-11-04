Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802288;
	b=zt85e50NEgwqUf17TiIKlI4om7bbKMY0f0CmnC8eJmk139qPHD+VxzWHIM2hit2hUbYB
	 aPAbRbVLKbCyXVSWH1k27MC+kU1+DE2e9vdQJw3LDNS8k5+lDMmLEXy7sUqWL1qgZS9je
	 hxHvQ6m/uQMQiZPsM4nHD79xYQaeBp9FnzUSkw3AnamwIJa3naKw1azXL/baAsH7kMet9
	 0UpOH/OojgOh1Zj7Tx0ekluq7uUg8xm6i/r1NuEOCDo5Z/Q1c3k5CXAPdaaIP5icrp/mv
	 5jCUD/lne4oBIhUGuZbtTnGk74gqVy2yCJK76QPpKjqcxMUGev0VEuzmk1bWZlUOzuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=pWQrTSr1cnuN/zJhDRaCY/o7+kRntSwc8YxzyZoPN80=;
	b=vRh+WL9nMmEcrsmCA3UKrOAxOog+Mgyya9mol1AfXWtuubBN2pxhAxo2C/0hHgj0kbdd
	 TiZPhZI0zot3NH3CkRL69eej15wfusYP1QeM1dKP1iYXoCmUXFryKV+PSxC/BVLRoAaTv
	 ta1iDznW16UlQZHuqfZeO6ddnlblk5E01mxteaeOA3rNTWKIotHi/lPRC5aF0wJ/UGEpX
	 UG8GQawIBqXECKNZ0/CYAmrWk4g63EdHEAV5AJil4Tvg+VTV8eZHkOFwa/OrKZxjJgKjb
	 gh4UqkAZe3pOTPjCrzq96pJeSfoKBcB2EJVThzNTjWUAhtoY2777olRj0glfH6Fz5LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TD04l5zw;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF0606A31B
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11BF0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TD04l5zw
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-54465f79af8so6419931cf.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 06:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802287; x=1794407087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pWQrTSr1cnuN/zJhDRaCY/o7+kRntSwc8YxzyZoPN80=;
        b=TD04l5zw9rr16ERVA20YiTiZjI4cKscaNmguWGe66LNezDqqZeQ0nZ8Kk88Gelx6TZ
         JB+ILngGrxiL2QjKlo+6q+IJWcjM1asNm9xt4My5MGbOtgyVYXLXZ2Rpn5vUCaXDEcY3
         8oYkuAk44UhooQbdPGtg1CAeBzvbYCGMK/Bipn/tRnoBUSfq4p9KekU6D6Y4LLEOqQPK
         6iBxlxfvK22eQIPypii+b5WfGeOluH+4dBrFDA91vWy9iPddr/RctgKUPDitC2RtNZFq
         c9/WpQPNEAAJBge7R4mEeJ16ODNVK3iX1CuG1HTx4a1kv0IAektabyMSbxDbBngTi6+G
         7n2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802287; x=1794407087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pWQrTSr1cnuN/zJhDRaCY/o7+kRntSwc8YxzyZoPN80=;
        b=YICZErYn3U5L/QZ6wTgV/xdggF3BsghxEUbMyYor38tJC2/haJRFVBv33I2uKnex/z
         NY2w6c0+byFZHebfdYtyc49l3ePZz/s4k6iDps6gFdeuTuFkkp984+IAytXSGSWKerKx
         9R5ePucYJjstaXnYIzC+f4BdTd4E2Nd9vPmyaxQrECq4SgOkPd0AoZ463dWo7eu1NmmX
         QSAIZ7bCwJkuwdIJThsuI9xkAr4J9uhGXLH0PFpTMg0G5DEUwy7Z3TyEDnpS/+ibHXqK
         6PA0kAE5/zKvHLDyzUVpkAVTqi5BhRzwcX696+7W3ApxgU+qSsRBaebNkLShb3mVcla5
         ZNcg==
X-Forwarded-Encrypted: i=1; AKwUvBzQVSlScn3DgENGhhc6jfpCoYHZtVIQM9/JeS2MktaazdLuDaSGeCASsgQ4WGu1jWVOiNTrd6Uzq+j+Ykn2CTx8ONckmUk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nLcLGtnH09kdA5FOmzwVBh4oU26sVfhPcqCoMK+gml8eilKiI
	KH2WhzZu4ulgGW1v0I+TRugLGu0vUuGAtPGQd/eXSXEe8I+ESJUAvrasjLKlqlz1HTQhhEDL6gd
	jJjqPa5jYXQ==
X-Gm-Gg: AYBFou0ZNGHBEwkDbof5icFYxb+gwCjX/MrjdAr5M2WvROZ1x2Gc07p7MON7fsZXEjd
	VZAiIYCBMEovFZmsc0ud4rEVLfT7TFfG0S+ScsRKlz09tgr3QM056UNAF04crtGzh15/32qS+LX
	DSEt0RT0DBakls0zt5D0fRpbgYHJXBsmp0jhrE3nr5+Kfzc34T49g7KoTFhDhIic2SfMQe6hz/q
	0aRC8DW8QQQ2yC7EmCF2C0cHLjdjf+Hb3gWpao9ZyUO/amEDuxS11L7O/KzcPEHgBHAyfbOkamx
	mCz7sSL0tiWWGrzBFeKM/I21/AHeEjtl98tCf9pxeLx/YrW8B1dNXscs2oz1eTuJL7g+bDFEa/M
	1+2eadml9/fY9kDZpH3IYU5uF9BKO6ZcLNdgl3TiJlLpsnhaJ8ViVP4gyrmgVn0lkudJpavDSnb
	6TE7fZ+s+2UABYG+g89at6pMRAMhrAIgl/npcRp2NVXb+gxTfrdbTkaWL14Y4r0MPK3uSsCtvpM
	OIjpSA5pgcJdIBr8n4vRitGtZTsaHvNtxxejjAyjhlK/7CNUSixJiC/RVXf6AuiJPfSwiyZMK+n
	MZREmJsXL1z7KMLFEqWbIX405PI9mUasGLnbau8X8KxK/XMv2zlHvzEf+6qDP9A6Jlk=
X-Received: by 2002:a05:622a:2996:b0:533:3e09:22bb with SMTP id d75a77b69052e-542b723c1d5mr247673401cf.42.1793802286275;
        Wed, 04 Nov 2026 06:24:46 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b0d07599dsm24796651cf.2.2026.11.04.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:24:44 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:28 +0000
Subject: [PATCH v2 01/13] cred: gather the rules for acting on a task by
 uid
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
Message-Id: <20261104-b4-cred-ids-v2-1-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=11088;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=mQ7xojoozlPowG5Y6QD8FTHBjW22hFljOH5ULgt7J7c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOnFrkG7RSpBB+71aCPxSmF4LJ7xwBIZ+VGsBODvmm7en8iOVfnMHhskN0ofeOGXgfuW6Z9Ri/t
 bi+RxgVnOPAk=
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/security/credentials.rst |  19 ++++
 include/linux/cred.h                   |  20 ++++
 kernel/cred.c                          | 162 +++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)

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
index 49c26af37349..7fb1663a5fc6 100644
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
index d01df40a9a38..5e10e0bdd11e 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -19,6 +19,7 @@
 #include <linux/binfmts.h>
 #include <linux/cn_proc.h>
 #include <linux/uidgid.h>
+#include <linux/vfsdebug.h>
 
 #if 0
 #define kdebug(FMT, ...)						\
@@ -541,6 +542,167 @@ void __init cred_init(void)
 			      SLAB_NO_MERGE);
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
+		VFS_WARN_ON_ONCE(1);
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

