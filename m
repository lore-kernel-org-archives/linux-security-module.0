Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694200;
	b=fFIJVF1Q5W+UynuKNJ0vXZ9AoJLZw0X7Y+NAnWqbR6ljVqu9lDsnM8bk55dMsFdO2gAk
	 Ss9YLH1dxPTehr5zw2W9NcYQHhFQhNzIeG+qjZE1cl4YgexFjRtbJtI6dUSCJOFMiQTDP
	 wUv45cog9Rk5OrrYVbIU8VAfA6xtCC8tezWoxV0UjqKx5Qp86zbiz59+d1PMzx0+VRhtE
	 7p6XWI+Tv/pIJkDY2StO0nlXhgNXQ0i6QcvyIBF7AXaL3osDAW0Al9UccLM3dITonY/7C
	 6Fl47X1v+5xY+/PmYABLNRF/GV0nDEfV1b3eCqqPOaGLIWBBR/ztXFYYk2inX6dneeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
	b=PM9ZIakTyxiqVi00NreEL/OKNXOLUAQBsJ8q6BocGkXJKJpxB0R0LsbxQyusTemTuoFa
	 a+ADYb02R9eaDkIRb/DaAHmHYaxTuawF9fa8keM7xDqXLroUrT3malVlVCyi70YJi4Xi/
	 BdW/DdMFZMs31he2xYovHnTY+J9NteOKYxnqRBniubYctyRXMIdVi4NCeCMMWJ3BH0UVo
	 YYgCDnAYpGSsDE60d/JNVbq/GWOQGlFHs0cnGdI+dbsEBW06VNVTe7HA1SSbjY/u0mO2q
	 Pp0BL3kh8WWSl7xzCgDl8SYfgXc8tsGQqoxSBZampn3vAPUrb7nrk5z7zkbu2nMBNTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mt6hYE5Q;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99670606A33F
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99670606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mt6hYE5Q
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e4c00d71aso212785a.3
        for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792694198; x=1793298998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=mt6hYE5Q7AhhNwO4S9N8tsyDK3PkX6HKFcbPXq/1lIAC9MK0t/JIQe4AIFPRUceKoz
         7XO+iQt+2sVnngQlwPD9BJPUdmpkz4T6QK12SBOUPRxqIMrOOTtwvYKQOPBWSNYSiKUc
         Td61bCvdpSsRJT6rEKukX+FOfjXZtIQkPbVDTN5PQKR33o0egYr8ncFP6VpAkZ7UI5ZF
         sEMos3/aerBZ+4cWHsWFSd1JMiHcTOM6ejum7T4ObjRRGjRk2AMYZDE7U9AHo6SgyX7Y
         cUjdxzu7XN5BpweLSVPOaHJxBpu2dy4JGz3qRMFsQG/jFb0b9lPiKXllErHu/dNRgmRH
         /rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694198; x=1793298998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=bYsjmqHjJ51lL+THXY6xo0E3LXCXRHiWnKRIY3umvfpOAJQb733pUwpfXr11z7mN9C
         rNaAaMhdjsXOPPPbU3D/j3jch5Q4sbhjySVIzijEWuz1DM0JqARpEDjPFTj70Gaj+9Mt
         I+nqRp4/FL3NaQnQma4h/RuZasUA9yXOLnvTe1kIBjz+pbWwPF/igGc7pFCPNoChUJVZ
         L/TNvzIDuailHN+Wai0VH6QmMYuTlNvl7xrFsrWERP/x+W6XT5hy/8Mt1jW+mfM+etgH
         NVyCylurrmMtgHr6ko4X9YjZQQvMzAKUr8XcClyI7o2fojhaDm3dOj9aJELVjFc7kYsT
         uYqA==
X-Forwarded-Encrypted: i=1; AKwUvBwMvMu3wAxAr+lKvdpTl81Xq6MYpQOS6u1R3BN44OtV7TsByzxacrLcSC1AQHBcTzhyuusVOZsEZaGMclBbkgm3oM+Dpn4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrX7RI/j1/JGbB6+wEdVEHVyuQYMfUYZux82FfquLvB4Y6TnFV
	EkxzWiHUb+hlEMH9RREevNZbiXZICee7IcsHMHGHFmZcQVrc6XGdncpz6QRPZkkGcdE=
X-Gm-Gg: AYBFou1NvlDBwChAra5MmI06Q3fI0sRHkkklZoRZJlvPCu4b+nfZZgjKAD9i7ORqXWD
	Q4JfKMl8RVB1W9uQFnpZDsjBfqQY79WXrZ8P3sCYCrWaFyio3NBa1UryTmp/O0+IoUzdfz7LZyy
	3kznlX4jaynxiEkSO4np9Zo0Xm+E3DjBDqaon4IN3uD0EGhyHjFoHFObfJ/wRlFs48SCUZ1p2q3
	dskQvHc50UmgXVSYjq17nZbONWzEafpYySjcBJVUZ/SoZNKX5JDcYmKLezwFzPG94kssSSJ5q3f
	UlIHMRAf4OjdLuIoEKO1cP5VuSNWuxR7R6qvobZtfrL4Sh5Eenbm530o3buE0eWasqDDPH1wz2k
	vSIretyaUDngs1BiD/OqG9CxEovrx78Y+usosFMhmbqxYm44D0nBGRw29fJa9uzlmvtmp+MTj3D
	kI0oNJCJ0L9OQ0jFVwPHkgi+eiqBACX7laCDQAbMjhqOS7sStcLQMq4OKKDh2HYVBK1LlUQSbga
	ZkZimlgftAFo1Y+Ttp818a9/AfRdWEotSQ3yPZuuUa+VPsC1dEPfrLocdhqeyhWae77H4Ww
X-Received: by 2002:a05:620a:261e:b0:93e:a51e:7ffb with SMTP id af79cd13be357-93f6f54da56mr69362185a.2.1792694198543;
        Thu, 22 Oct 2026 11:36:38 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f6fc33098sm17185585a.35.2026.10.22.11.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:36:37 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 22 Oct 2026 18:36:19 +0000
Subject: [PATCH v4 1/5] userns: record how far up CAP_SETFCAP reaches
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
Message-Id: <20261022-b4-setfcap-userns-v4-1-88aa0ffaa08f@toxicpanda.com>
References: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
In-Reply-To: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792694192; l=5250;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8IuY/d3QkcyzNsZWg+ftGcwOPwv9NKh0B+T0u35iHR4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGePxagh+fbAEyc1wz/hoXXG8Q9CM8gkmQHGJtfvXx4v5PnFeI78R27OfkrwTMlImXDAKQ6r4pZ
 z3pIr5riTFwA=
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

