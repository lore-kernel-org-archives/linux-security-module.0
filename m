Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8371C31D366
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109268; cv=none; b=pUSPC+uuPzEuhxGw8pkbXjhjOl5dnZe/dZA2j24OKufjOP3H3PRNt4jObs5SUPG3ZhUo2Zk64nyScgEvPP6Ue96Zi43VQU1EzBuO9mhBa6XUH5M354I3gnR+Sgf+XaLvjoFfkkZEXHG9DMRo91vADD2wDKiPTupAiaFJpJnD9FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109268; c=relaxed/simple;
	bh=6lMYEDk/4SORjeMQTREdR5RVJx70X24NOfnAF6DUR8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+O5xsqlMlBMezvj6XbqnrNZ4jInhI7o3/8UhatseqwoUJY3NEvIbyMcOa9Hlw8FRZSoNQPmZfm53vmqeZOgR8vblAQrNkR8UYsyKUij+E40LIM/0aojFcYuHzwyE/uLwgStTb29iEFjI+8LRiQrFY75MqxqYTdcTss7f9scwoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NO42xkJM; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NO42xkJM"
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-64edd93b666so74730d50.2
        for <linux-security-module@vger.kernel.org>; Wed, 01 Apr 2026 22:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775109265; x=1775714065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=un0TrhH26CUN0UWgks1V0cLvA+RLLEZ2+uAxYkzc7Bs=;
        b=F34PY3hV2nUqvusRShb5IHSda/iOQ0+NAICB5evxQYG68GrbGBI3YR68CG9F/fUl2e
         +SOCnQxkC9S8JtTMozK0lKnucv5O0R+YfMmvS8r7RrrCzQQNt1fiYEHYYOf0pEHUNVsP
         LuN+2a3KOS1rzpSMVERp/miKFKgWWZ1YiC+8VI3iVtZXZMLWf57PqAR2rTG9SVY1YSqA
         Nl97Plun7IgM7oZsp7ZuiE6hryyxiFxcrYXj+THuDGd6KTL23Jhu6ECvBKul14H9sDGS
         tnUhwNxodD4rOZtCg4bpdh0nlql0HNPWLocS603mDAvRVk80Lq21n8OMN/ufmYw+7JIl
         3wGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBtAK/XlMFJQrlVZqm9EbCuHMjkUs5ztlLhzPfYU6uggFpKhN9I/2tyMzw37bj6IAmsV9q5NMHZdRZDJWhs6yg7Ul+Fh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVp1jJkKOnPwCKLWkBeH4ylCbC7AswE1CH2VHRiP3FYVtBgUvs
	ELj7S/3dku2Z31Dq9Imq0iSmG4FwZUXbCiG7TDNzuEGqQkH3GGb/O4tqvMzjVLy0ytGDgyJr4iZ
	volAVPTvHV90FHXAEfjAFRykAtqW9jVEPa8wry9q8oXCU/6IZq9q0kA/zM+DwkgH3JokBoHC9kA
	UTYIY6VsgYt0swYOrzyFuXnzQBVfzIRfINsTu5jpIzYDUTigY/+WZeuQzMGzS/4CPN8jdtbuGTj
	+C2UVJ44B4eLycaxXPfDsJSB/MBw8Tc9Ii8CIM7FpYeFXkhqtY=
X-Gm-Gg: AeBDievlVn2i4GVvrXNeonDxIVncIhomlvI+KGq+cv5sw8SFsvbJXDjCWXK/kc/GE6i
	9nyGZstlEt49iCdmjI8ZKSdn+c2klfxcytSV4BlqiwIhgEPVIgCyIf3PVRLd8mt1NtQA9bpYYGm
	ST2OpGG+ITGJ8BS6vFLRCh6bAr54E4kpibkrB5qDZZ4W1025G7lcVj4M91AIgVA8komMtG51Z+S
	I6FYkfbeS5GNr8XGrNk4nf908Ep157VuzZuBtsRtkv3tNptBxJJ3lETNDwMVQ3tAD7VLOJxjd97
	pVlaskDQEAMFyBJleAdSV065742a4yjDgIjlS2chBkb/rhrsFwj5twpYdcdjnu0XBXaC5yjWedt
	dbkAEAFKj5x8UWDuPaEr0EfNMARCFHbH77PUZ4fFWOHpx8cesxV2fCestsxqusl+OpgKqOBy0jW
	ENuDEeyhbBAzJmKr7xPrEwyzbnaOFJYU+3tzSX8cQFWFgrSRhsxYDqR8G4jypZEkZ+cuYEY+gXg
	gfB
X-Received: by 2002:a05:690c:4a11:b0:79a:62a2:b37a with SMTP id 00721157ae682-7a211c422d2mr48829907b3.3.1775109265523;
        Wed, 01 Apr 2026 22:54:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7a36e224fa8sm1349147b3.1.2026.04.01.22.54.24
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2026 22:54:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-128b8fa9e7cso85432c88.2
        for <linux-security-module@vger.kernel.org>; Wed, 01 Apr 2026 22:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775109264; x=1775714064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=un0TrhH26CUN0UWgks1V0cLvA+RLLEZ2+uAxYkzc7Bs=;
        b=NO42xkJMI3wMShk5W+8m8CIF/dAKDcMS8HmLOqjB0FM2Xvk0evmkcw5lceZNpkRBfe
         KxvYrJckhLAXNWjrLxFYNHJ0vJShpXb2VmQBiYSyqOgl8JrRovfcRQbF+COK7x/TFQFZ
         gTjyN0EWMjxmohIsV2W8lw7coLEv2D6ynVlyE=
X-Forwarded-Encrypted: i=1; AJvYcCXFSmGCLQb8NYUwSIZghL17Yxru5qArcaBe+ecsX06bbxjP6zncn83x4TMeEsnQlUYeZ2ixHUm+1l5xKSYO+cIoriEsIyg=@vger.kernel.org
X-Received: by 2002:a05:7300:d50c:b0:2be:681:91b2 with SMTP id 5a478bee46e88-2c9326ad3c3mr1519632eec.6.1775109263579;
        Wed, 01 Apr 2026 22:54:23 -0700 (PDT)
X-Received: by 2002:a05:7300:d50c:b0:2be:681:91b2 with SMTP id 5a478bee46e88-2c9326ad3c3mr1519610eec.6.1775109262899;
        Wed, 01 Apr 2026 22:54:22 -0700 (PDT)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cf126c9sm1634662eec.27.2026.04.01.22.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:54:22 -0700 (PDT)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	georgia.garcia@canonical.com,
	cengiz.can@canonical.com,
	sashal@kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Qualys Security Advisory <qsa@qualys.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v5.15] apparmor: fix unprivileged local user can do privileged policy management
Date: Thu,  2 Apr 2026 05:47:31 +0000
Message-ID: <20260402054731.2798726-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: John Johansen <john.johansen@canonical.com>

commit 6601e13e82841879406bf9f369032656f441a425 upstream.

An unprivileged local user can load, replace, and remove profiles by
opening the apparmorfs interfaces, via a confused deputy attack, by
passing the opened fd to a privileged process, and getting the
privileged process to write to the interface.

This does require a privileged target that can be manipulated to do
the write for the unprivileged process, but once such access is
achieved full policy management is possible and all the possible
implications that implies: removing confinement, DoS of system or
target applications by denying all execution, by-passing the
unprivileged user namespace restriction, to exploiting kernel bugs for
a local privilege escalation.

The policy management interface can not have its permissions simply
changed from 0666 to 0600 because non-root processes need to be able
to load policy to different policy namespaces.

Instead ensure the task writing the interface has privileges that
are a subset of the task that opened the interface. This is already
done via policy for confined processes, but unconfined can delegate
access to the opened fd, by-passing the usual policy check.

Fixes: b7fd2c0340eac ("apparmor: add per policy ns .load, .replace, .remove interface files")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Keerthana: aa_may_manage_policy() does not take a subj_cred
parameter (added in 90c436a64a6e, merged in v6.7). Pass current_cred()
directly to is_subset_of_obj_privilege() in place of subj_cred, which
is equivalent since all call sites pass current_cred() as subj_cred.]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 security/apparmor/apparmorfs.c     | 16 ++++++++------
 security/apparmor/include/policy.h |  2 +-
 security/apparmor/policy.c         | 35 +++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index e736936f4f0b..3053e5731b02 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -409,7 +409,8 @@ static struct aa_loaddata *aa_simple_write_to_buffer(const char __user *userbuf,
 }
 
 static ssize_t policy_update(u32 mask, const char __user *buf, size_t size,
-			     loff_t *pos, struct aa_ns *ns)
+			     loff_t *pos, struct aa_ns *ns,
+			     const struct cred *ocred)
 {
 	struct aa_loaddata *data;
 	struct aa_label *label;
@@ -420,7 +421,7 @@ static ssize_t policy_update(u32 mask, const char __user *buf, size_t size,
 	/* high level check about policy management - fine grained in
 	 * below after unpack
 	 */
-	error = aa_may_manage_policy(label, ns, mask);
+	error = aa_may_manage_policy(label, ns, ocred, mask);
 	if (error)
 		goto end_section;
 
@@ -441,7 +442,8 @@ static ssize_t profile_load(struct file *f, const char __user *buf, size_t size,
 			    loff_t *pos)
 {
 	struct aa_ns *ns = aa_get_ns(f->f_inode->i_private);
-	int error = policy_update(AA_MAY_LOAD_POLICY, buf, size, pos, ns);
+	int error = policy_update(AA_MAY_LOAD_POLICY, buf, size, pos, ns,
+				  f->f_cred);
 
 	aa_put_ns(ns);
 
@@ -459,7 +461,7 @@ static ssize_t profile_replace(struct file *f, const char __user *buf,
 {
 	struct aa_ns *ns = aa_get_ns(f->f_inode->i_private);
 	int error = policy_update(AA_MAY_LOAD_POLICY | AA_MAY_REPLACE_POLICY,
-				  buf, size, pos, ns);
+				  buf, size, pos, ns, f->f_cred);
 	aa_put_ns(ns);
 
 	return error;
@@ -483,7 +485,7 @@ static ssize_t profile_remove(struct file *f, const char __user *buf,
 	/* high level check about policy management - fine grained in
 	 * below after unpack
 	 */
-	error = aa_may_manage_policy(label, ns, AA_MAY_REMOVE_POLICY);
+	error = aa_may_manage_policy(label, ns, f->f_cred, AA_MAY_REMOVE_POLICY);
 	if (error)
 		goto out;
 
@@ -1796,7 +1798,7 @@ static int ns_mkdir_op(struct inode *dir, struct dentry *dentry, umode_t mode)
 	int error;
 
 	label = begin_current_label_crit_section();
-	error = aa_may_manage_policy(label, NULL, AA_MAY_LOAD_POLICY);
+	error = aa_may_manage_policy(label, NULL, NULL, AA_MAY_LOAD_POLICY);
 	end_current_label_crit_section(label);
 	if (error)
 		return error;
@@ -1845,7 +1847,7 @@ static int ns_rmdir_op(struct inode *dir, struct dentry *dentry)
 	int error;
 
 	label = begin_current_label_crit_section();
-	error = aa_may_manage_policy(label, NULL, AA_MAY_LOAD_POLICY);
+	error = aa_may_manage_policy(label, NULL, NULL, AA_MAY_LOAD_POLICY);
 	end_current_label_crit_section(label);
 	if (error)
 		return error;
diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index b5aa4231af68..f6682a31df23 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -304,6 +304,6 @@ static inline int AUDIT_MODE(struct aa_profile *profile)
 bool policy_view_capable(struct aa_ns *ns);
 bool policy_admin_capable(struct aa_ns *ns);
 int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns,
-			 u32 mask);
+			 const struct cred *ocred, u32 mask);
 
 #endif /* __AA_POLICY_H */
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index e59bdb750ef0..f2bc865bc7b6 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -671,14 +671,42 @@ bool policy_admin_capable(struct aa_ns *ns)
 	return policy_view_capable(ns) && capable && !aa_g_lock_policy;
 }
 
+static bool is_subset_of_obj_privilege(const struct cred *cred,
+				       struct aa_label *label,
+				       const struct cred *ocred)
+{
+	if (cred == ocred)
+		return true;
+
+	if (!aa_label_is_subset(label, cred_label(ocred)))
+		return false;
+	/* don't allow crossing userns for now */
+	if (cred->user_ns != ocred->user_ns)
+		return false;
+	if (!cap_issubset(cred->cap_inheritable, ocred->cap_inheritable))
+		return false;
+	if (!cap_issubset(cred->cap_permitted, ocred->cap_permitted))
+		return false;
+	if (!cap_issubset(cred->cap_effective, ocred->cap_effective))
+		return false;
+	if (!cap_issubset(cred->cap_bset, ocred->cap_bset))
+		return false;
+	if (!cap_issubset(cred->cap_ambient, ocred->cap_ambient))
+		return false;
+	return true;
+}
+
+
 /**
  * aa_may_manage_policy - can the current task manage policy
  * @label: label to check if it can manage policy
+ * @ocred: object cred if request is coming from an open object
  * @op: the policy manipulation operation being done
  *
  * Returns: 0 if the task is allowed to manipulate policy else error
  */
-int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns, u32 mask)
+int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns,
+			 const struct cred *ocred, u32 mask)
 {
 	const char *op;
 
@@ -694,6 +722,11 @@ int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns, u32 mask)
 		return audit_policy(label, op, NULL, NULL, "policy_locked",
 				    -EACCES);
 
+	if (ocred && !is_subset_of_obj_privilege(current_cred(), label, ocred))
+		return audit_policy(label, op, NULL, NULL,
+				    "not privileged for target profile",
+				    -EACCES);
+
 	if (!policy_admin_capable(ns))
 		return audit_policy(label, op, NULL, NULL, "not policy admin",
 				    -EACCES);
-- 
2.43.7

