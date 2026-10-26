Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048435;
	b=mIitDUlwj1oJWBZcqpAPWvD1VS1G/TbGz78h8dPAeAj1hbpHjT0Xvrh8fQXhGCnr4Blr
	 qWhMt1XABKpKYoU8EIqZY2bJqfawiZqY0QF5UEFYs0N+HBQHW2r/gmE9Q0drpxuFTUy3p
	 skVPJ3JdcGszID1kd96QqaGLkIzrcWDfr4Srgt4BDKRQ/SBKkRZFUNK+3r9lH1+gNGVFR
	 wDka5N8+8TZGocbckjhPevyAZg6WiwZQMa2nq07X2QdaE8AYPnVh0vTdk2hIs6sqcm1W1
	 hBf2eIuJKI6AkUADwdOnTijfojvsa2tePIVzTnQpv5Cx17f0C5dZNxtMwuN5KZ+5+sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
	b=mOXWg/+HqPlCsu/wtdMiLO49eOMN/Iy5JcqfPQsxu0RwE+6nHAeAAVKNetLueZyiTqZc
	 MU7KVgloGV80c05p29hbles3OtsLCWWf0BCW8x+pbz0haMSHUrX8BbUhgUdntB8CDzZzd
	 OVAUEAAT90q9Y+4rIQ9QZo7b+5YEGvyy3ToOlufIwi+rta5H2+jR4fZmZK6mUHyRcrwI1
	 IlK1W5P+YUXJNGGKwAsEdSBA4DLcOYd593bi6ZzWkeTKL4AeIZo7LlNhd8x4XU3U5V4iA
	 NgrxDjkbEYZbeh7g2kohYIsit1aP0suy2RAr9x3DleY3JwgtVDARUf67xfkNVxksLXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="UED2p/gt";
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D704606A326
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 21:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D704606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=UED2p/gt
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5366ae57896so37773601cf.3
        for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793048433; x=1793653233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=UED2p/gtf4O6u9c74cuXetW834czgcnqI6W31nf9lccF/t1KJir6B9tX1s6sDZAib1
         WytXWbBBLvIfNBG0keWS3HOB/q5ImE80yEbTcB9+nBVwUKWxqrrxwW5GCsTdprD2vqu4
         UizDzGbrgogujyZTam0ii/ZuibaE3FAcsubEpzjTLdu82u7Arz0ToS9Vpa7OWBr2uu36
         l0W9FF2DHg5C09YEIWoHBYzhk76Ixbmzsb3MMIhyZAQvDGYU5T/tuD4lfV/nw0uASjLH
         rwDI27s/nU4LYudlV/lUIwMcXUZ+Iz28qm3uQbyElnm3sGcU9QFHn3E2BWq9yeA1pkXD
         SjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048433; x=1793653233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=yCoMXGgjROINCxG72o7xebW8sDxHEq27+A3udvKX5/uwuV0L6kQUMbL5r2S5oSvRwq
         A6qZ4U8zcbgohssaplHo0NdSK3Ij3UwE6ZV2zLXC+Soly5/syqVdK0MXQhwiL5cQELwh
         iWfmeOdF2RmCBF8PPViEvAGVzZZGy0jUYRM742QhKbi/fcoN8d8q/pg588Q3pysDvzkl
         rjB68ZUpTBdQE54/1ZSeNtl510oDsxtFcQlE/kHOKMvTmaz/wFOZMxdofoNjml0tSPBr
         dHYsnXrjzy4WxNRgaUva7laWd5DmNqufTaDxB2p01DPDaGt3wL+YQAX9tRYzjWZnDnXM
         j5ig==
X-Forwarded-Encrypted: i=1; AKwUvBzUPSVF2TyCAGCLSg6ubvp0TWqVgX30BN3ZXBLbvLWV4rugI3K1BrVvUzbG2aXJ5e3tFam71dlIN+GLUVwnrDr07oJRlp8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLA+0KFe5wBZ3L9fPKfLAr26wxytEdZUw93SCE1RWDL6MvAhqYy
	op3ivZ3O20F+DGILzuGLQQoQU+G++3GBqKeEld66WMwlFIxLHkTzvc0Evc4EZCfrkgs=
X-Gm-Gg: AYBFou16KXrN8dx8t4DvlrsViG9HUSXdvHUJ6zpH21ATETXi4g077O1G0K0HdTVPctl
	skm1RoUJukELz6GYnOb62vxQqedqbvzKyyUtPNqRAJMx32ydnV7OxZogd9euf1Ob/SQzN7qabbX
	2AB1AFOAmsDKZjwZfrGpZZrch/MeF3JYxrxAE87LkAaIy+O9DUDO6WXHMWttMDBTB+g/CI6oEOC
	ughEBC44zjmukCcAJyo5qlDuwDnV55sTkjR8k1mM9n1Lm1aZrlsZrDd7mELLsMmMnLTWoPl+D4/
	NS0i8Ni3rJHisFeo1nVDotdNNYVOHiWTmEHLOB1iwMed6JYdDqBKtpqQ8z62zyvd7XjAU4Scyp5
	snoh/pcAoa2pMhkR5XyQ7RLb3ejs7oz1YUFzZxANMPLHTBSLLCiO0NXy9IuuVzNUesc6+y5pRwp
	WJXHnYeqpij/AV56iyu9LhzGQWsxvQLokLSWosgN8SBDCEH+sKpVpeNcad9WMhvLxqj/loiI0+y
	oXYc1adRc4os4IoE7lOxeEmyNlGWSwR7fkDJHjIVj+2hkcpJtqfDg9BZuAA3pvqBDKS49W9
X-Received: by 2002:a05:622a:1814:b0:536:780e:8f48 with SMTP id d75a77b69052e-5383b63dad5mr126696121cf.30.1793048433101;
        Mon, 26 Oct 2026 14:00:33 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538397405edsm63971551cf.27.2026.10.26.14.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:00:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 21:00:19 +0000
Subject: [PATCH v7 1/6] userns: record how far up CAP_SETFCAP reaches
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
Message-Id: <20261026-b4-setfcap-userns-v7-1-bf8a576f7259@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
In-Reply-To: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793048427; l=5250;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8IuY/d3QkcyzNsZWg+ftGcwOPwv9NKh0B+T0u35iHR4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPMvQGkrsC6jLRBSPJ4NeGqgaTkWqQmTJWM9t1AFKSWcIYYvJ5q2j3SesTDxmd/CyhkUezPSSmc
 ++YiTsjN1cAo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

create_user_ns() records in ns->parent_could_setfcap whether the creator
had CAP_SETFCAP in its effective set, and verify_root_map() trusts that
when a task in the new namespace maps the parent's uid 0.  A bool only
describes the parent, though.  File capabilities belong to the kuid of a
root user, and a namespace that maps the parent's uid 0 shares that kuid
with the parent and possibly with ancestors further up, so what matters
is how far up the creator's CAP_SETFCAP counted.

Replace the bool with ns->setfcap_level: CAP_SETFCAP held in the
namespace counts there and in its ancestors up to the one at that
->level.  cap_setfcap_level() computes it from the creator's cred.  A
creator that holds CAP_SETFCAP passes on the setfcap_level of its own
namespace, one that doesn't gets the new namespace's own level, and the
initial namespace has 0.

verify_root_map() keeps checking the same condition: the bool was false
exactly when the level is the namespace's own.

No functional change.

Reviewed-by: Bradley Morgan <brads@mainlining.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h     |  3 +++
 include/linux/user_namespace.h |  7 ++++---
 kernel/user_namespace.c        |  4 ++--
 security/commoncap.c           | 27 +++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 622137f66f09..026974a5111b 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -34,6 +34,7 @@ struct cpu_vfs_cap_data {
 #define _USER_CAP_HEADER_SIZE  (sizeof(struct __user_cap_header_struct))
 #define _KERNEL_CAP_T_SIZE     (sizeof(kernel_cap_t))
 
+struct cred;
 struct file;
 struct inode;
 struct dentry;
@@ -222,4 +223,6 @@ int get_vfs_caps_from_disk(const struct mnt_idmap *idmap,
 int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		      const void **ivalue, size_t size);
 
+int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns);
+
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 91232053775d..f3753b6b6d29 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -86,9 +86,10 @@ struct user_namespace {
 	kgid_t			group;
 	struct ns_common	ns;
 	unsigned long		flags;
-	/* parent_could_setfcap: true if the creator if this ns had CAP_SETFCAP
-	 * in its effective capability set at the child ns creation time. */
-	bool			parent_could_setfcap;
+	/* setfcap_level: CAP_SETFCAP held in this ns counts here and in the
+	 * ancestors up to the one at this ->level, see cap_setfcap_level().
+	 */
+	int			setfcap_level;
 
 #ifdef CONFIG_KEYS
 	/* List of joinable keyrings in this namespace.  Modification access of
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 50c374ed4687..a5a94367600d 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -125,7 +125,7 @@ int create_user_ns(struct cred *new)
 	if (!ns)
 		goto fail_dec;
 
-	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
+	ns->setfcap_level = cap_setfcap_level(new, parent_ns);
 
 	ret = ns_common_init(ns);
 	if (ret)
@@ -921,7 +921,7 @@ static bool verify_root_map(const struct file *file,
 		 * the new namespace.  Verify that the parent had CAP_SETFCAP
 		 * when it unshared.
 		 * */
-		if (!file_ns->parent_could_setfcap)
+		if (file_ns->setfcap_level >= file_ns->level)
 			return false;
 	} else {
 		/* Process p1 is writing to uid_map of p2, who is in a child
diff --git a/security/commoncap.c b/security/commoncap.c
index d47ab3022343..4f49dba65426 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -131,6 +131,33 @@ int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
 	return ret;
 }
 
+/**
+ * cap_setfcap_level - Determine how far up CAP_SETFCAP of a cred reaches
+ * @cred: The credentials to use
+ * @ns: The user namespace to look from
+ *
+ * File capabilities belong to the kuid of a namespace's root user, and the
+ * same kuid can be the root user of ancestors of that namespace.  Every task
+ * gets CAP_SETFCAP when it enters a user namespace, so having it there says
+ * nothing about those ancestors.  user_ns->setfcap_level does: it is taken
+ * from the creator when the namespace is created.
+ *
+ * Return: the ->level of the topmost namespace, from @ns upwards, for which
+ * CAP_SETFCAP of @cred counts; @ns->level + 1 if it doesn't even count over
+ * @ns, which includes an @ns that isn't @cred's namespace or a descendant.
+ */
+int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
+{
+	if (cap_capable(cred, ns, CAP_SETFCAP, CAP_OPT_NOAUDIT) != 0)
+		return ns->level + 1;
+
+	if (cap_raised(cred->cap_effective, CAP_SETFCAP))
+		return cred->user_ns->setfcap_level;
+
+	/* All we have is that we own a child of our namespace. */
+	return cred->user_ns->level + 1;
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set

-- 
2.55.0

