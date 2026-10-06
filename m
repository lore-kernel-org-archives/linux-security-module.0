Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC1E49E12F
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301489; cv=none; b=LVzjw9n0qcy+2c859MAzUKWqTJVvghN+15wgAyf7KNsl3ksDHgkLmPYseWQCpoQTyaD66FAWOzKnsWqCgyyPWwbkVGhK/cFiUM2gg4sfEXzH9MbOMbrpyO9BbdmvdZDtNWUfVgdwPOBx0UVDFTTtllCV+wn2sd3t6yAPaBd8EzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301489; c=relaxed/simple;
	bh=sdkLNlSVDya289W5hT+ofNDZrviLlSEWRxEcUt7A++U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F8UEHtokbxH08qZV3CEo43eyD2XOMwRBD+4o1I3z+tG7oejrhifUBITSJywl3U8d6W37H8o9pSUtOEqUwT1xGS4nYqvPUc/8Nex53voHX9oe53WaMlZH+zoMBZAsp4LDBGDbAjM3ZKa3UdR39CpH+ujqlFPz2Tb/gGG6ZpmheI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=lB7PWSqI; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="lB7PWSqI"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-917866225aaso11851876d6.1
        for <linux-security-module@vger.kernel.org>; Tue, 06 Oct 2026 08:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791301484; x=1791906284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0NXnvsEsvD5aCUOEL9ab8m9CFmObG0rGa4FrHzgVpP8=;
        b=lB7PWSqIOxebwCcUTB+yhx/fVGCNoRgnAeEsJf8a6ncOp1+bhRuLtZAlYf/InezP9Y
         YDJomh6YWLsdMRm/jyUMnuKku8Evz8bTpBIjJOn0wSmU+/AxQAcDuD9sYARy4aCW/Qgs
         5ISz6XJ0UnuCwFX++Qsjv4KwrNWYLfWuwjMkjx9xkRko/9mZIaER9YAP8J1RoTL5Vee/
         HbgVXHjPnZtRxW52IvULHAZ1Xr68Ih8sp7g+a8k7kkolx5lD27F4BdrL5eLz9Nqzob/v
         xAvTcfCtY6EiDfHuAF5/lGVzDTXWzV/kCl2pjcZmMai7MNCousbeJQje/majeVhJqDHY
         72aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301484; x=1791906284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0NXnvsEsvD5aCUOEL9ab8m9CFmObG0rGa4FrHzgVpP8=;
        b=iOjqXrdPveAiEidIB+2ChmAylfb1DQzgUz3OlzIGmb7xalA6YiNelTXiEKzTkX6n4u
         YAiczPhQlHR5JG0fZGeIcq080uZ+hoxm3pckWreDqLi4ULUM9upmNoI7zCbhcU4nQwHL
         ftiGgIZYazGWTemQooxlk8nm7tLcqIxAn8u/SbFw/1w4+IVMg/YXQCGiCtDCpZZy2VxI
         PKI4hh2ttZCoSrAu46mXH89khiHIF3g3cAMWcKRUWqPqstIoEvTguYz16s/tPCcCfYMl
         2fHN92Ty6bAhxWWdnWaNM64Dz8JTMuNm5XiPDrSA54MvZD6p2RmrHv2E/ZWK5G9cKHCq
         t1MA==
X-Forwarded-Encrypted: i=1; AKwUvBxH+jRR+GPXx1DOCyuaqW1H6vgIfcit3GVuO3ABvmdkMNWmpXeNq/Dt6lr/V3bisXdh0DjrDcu+rSuYrZjBI4VnHtaiMXc=@vger.kernel.org
X-Gm-Message-State: AFuF++kK0CxLYy2X2VQQhfy1flVhYQtOgadsuZEYdGP5sWU6O+JZ9POF
	Z4zcrazpINPrb2Tk5u49oLybigobisZmIKYwNN7tprVz1EtCfdD/m8bfkaCXEofTUnA=
X-Gm-Gg: AYBFou2iDX4G9qaT8sf6p+3SIl3JoE25dWT/fxv8u5Kfsmj5iuF31iPB03DBx9GUqSK
	PDwf+VFMsu/tiCBbp91kCAGvBKHUO8+/HFRGlk9Knjbeh3QMmYp/K1KkP719PF6GFSDM1IBsK3M
	j8yNNhYWR1jUkuuEhRupO2MrGxCnfyKuvUNorYBHzdUTWuJ+W3oBdwFKmQ1EPTRmXEf2oRcd53l
	6vWqA7PRRWHu8hTdBFByRHqOkjDrR8yD4Qz5BwUlmawfR3wl61JEK3WgAcKsxMsbrAGbAhgkJk7
	8NpsluN08R+ZXVYEVpD/RfEz5EtmRO8j0WE+Z97qtEU0BZQwHUwXHT95N3xXz2z7XG/AcZntqEr
	XaT3/rFXLgTq832MQJJM7Kl2nUfvRVvwlKEfj/5APQRUpmskc6AhYJXRL7F9GZmq9cq/c5aexcs
	q+jIy7FO3PDCImwlm2PvkdVtSaEBBYbKdzSiYoTa6+o0TUeHrWgGX71KtA+VQpWTfnCjFD22gbY
	F4KGMxnXugP+eKuo2Lh2i9n8g==
X-Received: by 2002:a0c:f08a:0:b0:919:952d:92ef with SMTP id 6a1803df08f44-919952d987cmr2712816d6.55.1791301483777;
        Tue, 06 Oct 2026 08:44:43 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b1aee5sm117062566d6.10.2026.10.06.08.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:44:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 15:44:17 +0000
Subject: [PATCH 1/5] cred: record how far up CAP_SETFCAP reaches
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-setfcap-userns-v1-1-f47e7ed66072@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791301477; l=5608;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=sdkLNlSVDya289W5hT+ofNDZrviLlSEWRxEcUt7A++U=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKGswJT56I7Yy/r65WjH9iIY0qscagsXWIMNmBZ+N+axFtZjdL/NsNVK9L7Ft5euTmysR1ybmgT
 jQraWTAuVgwM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

File capabilities are tied to the kuid of the root user of a user
namespace, and a namespace that maps uid 0 of its parent shares that kuid
with the parent.  So CAP_SETFCAP in such a namespace is worth as much as
CAP_SETFCAP in the parent.  But every task gets a full capability set when
it enters a user namespace, and from then on its credentials say nothing
about what it was allowed to do outside.

The only trace that is kept is ns->parent_could_setfcap, which describes
the task that created the namespace and not the ones that use it.

Add cred->setfcap_level: CAP_SETFCAP of these credentials counts in
cred->user_ns and in its ancestors down to that ->level.  It is 0 in the
initial namespace, where the capability sets speak for themselves.  When
credentials enter a namespace, set_cred_user_ns() keeps the value if they
hold CAP_SETFCAP, and otherwise raises it to the first namespace on the
way down over which they have it: the child they own, or else the
namespace that is being entered.  cap_setfcap_level() computes that.  The
value can only grow, and it is inherited over fork() and execve() like the
rest of the cred.  key_change_session_keyring() copies field by field and
has to carry it over.

Nothing looks at the new field yet.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h   |  3 +++
 include/linux/cred.h         |  1 +
 kernel/user_namespace.c      |  3 +++
 security/commoncap.c         | 26 ++++++++++++++++++++++++++
 security/keys/process_keys.c |  1 +
 5 files changed, 34 insertions(+)

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
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 6ef1750c93e2..b95119099993 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -123,6 +123,7 @@ struct cred {
 	kuid_t		fsuid;		/* UID for VFS ops */
 	kgid_t		fsgid;		/* GID for VFS ops */
 	unsigned	securebits;	/* SUID-less security management */
+	int		setfcap_level;	/* how far up CAP_SETFCAP counts */
 	kernel_cap_t	cap_inheritable; /* caps our children can inherit */
 	kernel_cap_t	cap_permitted;	/* caps we're permitted */
 	kernel_cap_t	cap_effective;	/* caps we can actually use */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 1b23d819d398..6b45df3a8d82 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -44,6 +44,9 @@ static void dec_user_namespaces(struct ucounts *ucounts)
 
 static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
 {
+	/* The last chance to see what we can do outside of the new namespace. */
+	cred->setfcap_level = cap_setfcap_level(cred, user_ns->parent);
+
 	/* Start with the same capabilities as init but useless for doing
 	 * anything as the capabilities are bound to the new user namespace.
 	 */
diff --git a/security/commoncap.c b/security/commoncap.c
index d47ab3022343..513473f859be 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -131,6 +131,32 @@ int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
 	return ret;
 }
 
+/**
+ * cap_setfcap_level - Determine how far up CAP_SETFCAP of a cred reaches
+ * @cred: The credentials to use
+ * @ns: The user namespace of @cred or one of its descendants
+ *
+ * File capabilities belong to the kuid of a namespace's root user, and the
+ * same kuid can be the root user of ancestors of that namespace.  Every task
+ * gets CAP_SETFCAP when it enters a user namespace, so having it there says
+ * nothing about those ancestors.  cred->setfcap_level does: it is handed down
+ * from namespace to namespace for as long as the capability is held.
+ *
+ * Return: the ->level of the topmost namespace, from @ns upwards, for which
+ * CAP_SETFCAP of @cred counts; @ns->level + 1 if it doesn't even over @ns.
+ */
+int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
+{
+	if (cap_capable(cred, ns, CAP_SETFCAP, CAP_OPT_NOAUDIT))
+		return ns->level + 1;
+
+	if (cap_raised(cred->cap_effective, CAP_SETFCAP))
+		return cred->setfcap_level;
+
+	/* All we have is that we own a child of our namespace. */
+	return cred->user_ns->level + 1;
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index a63c46bb2d14..f9cf3ce2426f 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -939,6 +939,7 @@ void key_change_session_keyring(struct callback_head *twork)
 	new->group_info	= get_group_info(old->group_info);
 
 	new->securebits	= old->securebits;
+	new->setfcap_level	= old->setfcap_level;
 	new->cap_inheritable	= old->cap_inheritable;
 	new->cap_permitted	= old->cap_permitted;
 	new->cap_effective	= old->cap_effective;

-- 
2.55.0

