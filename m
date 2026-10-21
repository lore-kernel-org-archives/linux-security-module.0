Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615063;
	b=wxjuKmt7Yf15xs/L242qx6Z3fyG5aowAKtv5+w6DrUFsOag8UkOCDvast7th4UZnbBsZ
	 dlX4SYTEJQ6fLj7bDXvkahyMmA5sYqUgIuNTm+nPwPCLjPhdgKuVfDBGCIKyAWwZRB3ES
	 eEj/d5Hk0nM8b9Zoc3sX1p+TYodRwsWMpTrvmd/jlL2CV1KWa1Ah04oyHhQSUGoYswxvh
	 1ssVPJ4sXTcauwLcKnpZq+I258aQ0KMKt2yAS3f+5NgYNT8nGBcELbAkbvplydQC/x0X5
	 whXKUDcD1AXxX6XkgmLj4DIa0zad0dk7dO6bBMiZhKRos/QxniOdltoT29xae830gEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
	b=oplRkAtLcj8widfvzq5TlQpe6EM1st3nBWUzH4+NtfEnTFGPwVmmYlt6PUJ5zHTemnMO
	 dFB4sG7s5klOqneXqa5LYWUx3upLfV4/aATmt92TbR6aDpTEQ765PtOH1atE+O3s2QwmV
	 Yq0OXRwSc6ng4cYgOLeZBr3CzOKmUIvrjEu5vR6hkgRsvtveX1b0Nk6fgVjT14WGwThJ2
	 cWHrMeFNaoUUuuOxKRC31CxJQSX29Bo/HXy7eQS9yGXy+vwACwO/PC42Cr32qHQ4+od8h
	 b/dA/c4devZQwQKWFfQrt3W62GnHi78o0v4FhQMbofYfEpC/FNJYqBPvU8v/6VUFbrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mNl8cqV4;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A5606A32C
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 20:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA6A5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mNl8cqV4
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91c162febb9so9665326d6.3
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792615061; x=1793219861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=mNl8cqV4R/oYmQC8R8wfJ2B5aJT/dlSx4Vh7ZGrIPkhrIK2xxjJDH3dVYYzvI6y5lX
         U5xDAYo8aaA1OhZBdaHgTFzDnUlRS2lpGvVeDMtAoQ6F/ByMQ7siq9/Vn/HDjTD7etSf
         0ajUiAtOLr5GAV7e+yuln32DfgCP6b9TCQVzX3K/KfNDlfBQmN9hdqL1ju7uf87uKIvk
         xBPH42PPhvmjGOYRZ6l1G4RBPOGgNR1DIszGrI9K8MFXzUWnNqZAPKG7vJobgE+Xs5Zn
         29JRu0S6CjCtZEOIwMBRKgslmFEjgHk+riOOURXxXTDqGgdEIqxakZlmWkdHIb2P9jZ+
         nDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615061; x=1793219861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=d8l4NrWjF2ZX/fg+EmdZRjaEq5E211c+qKhK4AWQ1Z6LknwBRy5HbEgi15hdgAST2L
         Yi2GTneBH49Umys2RHPRvUPuN4K/2p2zGAAMILP/GBTMp1flOvZCRULzF+ZyCcXst9d5
         q6PMaxmzJiPRHMapUutnTSWHa+/xh+V2TguZGajoBTZ9oZvDcelBxUvHcCgYytFsne7Z
         03iSOomZozmrKIRrD1TekbwT0rrRrJXZhADb/G7QOEQdUbNbi3MJzuhO4X6C8VX2o+f7
         NYnDbXzbX1iLYqsB52ghWPfQb2xrlk1ppnfVOBlCMGMaNUc1D4onane3E5rW5EzBv/xe
         ELJA==
X-Forwarded-Encrypted: i=1; AKwUvBzaWMWVlir91rXJe4BBkLL6D52G2fiCeXvHa+8R24pf/MDSXHj+/13+SBwLy2+t+OZxruKEsMKmbrrY4bxjNnntxSRDCcc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKIokaRVP1e1R2irurA/lRnnQl6UB7ius9PH47T9JcSCYzyKRk
	8s3xCcDmxYo2yy4UrkE+vrOPF7shgheNLLrw9ulLbe6vnEQNZecRpYXjIG8+eYcoSW8=
X-Gm-Gg: AYBFou2cKGI1GPvsNh0/HbPHKefbidPltrJhhqntlSaYEbCtu1ctTBs7+PRWk5lCuMl
	NBwigl0t61LO/PuidLWd+wOvzjRv8FGaZOIx9Us29n7EUoB+2H7r0Zi01m6ossPSDOd6jTRplZ2
	fP7B2Llrnv2eTYa0txGhfF+2SOcmfhyf24z+bDhZVCoyOvu26ZIdBC0Kl5dudw63BNM+yur6LRX
	98ujHBSES3G91ZNWBIPO3qrCLd1UCLbmEt5G1VZfEuYoBL6dupDa5xVrm8kybZYkFMSVyJp7ht+
	RxNvGxzQgJnF/LmdZWiJIN3a06j50LJPeJ81LQh79FfkUlymuRKoVPxDyO6H3q3xksJ12rQ8Ayi
	jZ0WxwmgAcnV9f2nsWNBHsfUKl4glKRANfRgoR8He0g5cTDxgd26CJEtWCbKBxujqirBBMKGB4d
	Q+cADCnoDPJozzPBXT4kaqIHuYVWr/toWZgaHRzxcPNrwNYk6XmWGSNF9ANoV5mwueD6AoDJf6C
	inhT/HZHBVUIjwnE+Nmitu3QpgLFXYAcJjIygPU78rc9HN4FaV4IhWLGp9/jkmELybtEiLl
X-Received: by 2002:ad4:5aaf:0:b0:915:4229:17a3 with SMTP id 6a1803df08f44-91c12ed418dmr52373626d6.25.1792615061400;
        Wed, 21 Oct 2026 13:37:41 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c3b500sm33488216d6.35.2026.10.21.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:37:40 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 20:37:25 +0000
Subject: [PATCH v3 1/5] userns: record how far up CAP_SETFCAP reaches
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
Message-Id: <20261021-b4-setfcap-userns-v3-1-97c7ed4e43e1@toxicpanda.com>
References: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
In-Reply-To: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792615055; l=5250;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8IuY/d3QkcyzNsZWg+ftGcwOPwv9NKh0B+T0u35iHR4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKbSKM/tdvHe5/+I2XkJlJrp2g2fCVDMwEPnWI34EErQ7FG+MOuQ4nePzXiBN8cxRMaO34b0HLL
 bJup859UUTgE=
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

