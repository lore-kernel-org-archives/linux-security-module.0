Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029312;
	b=PyTCZg6b9x7z8BVX3ra1In/Ip8qLr3EqGFNLGk61wm46wR8SSgnI/xVxiVqog1cGH6uX
	 NBTwpVk20qrdT65qJknbWvd0S6VySDrufiPKliofWsorZlG6z8biMdDgJoxVszrGKMo36
	 2CbyiAYpAIBFFBV/N7xZOKbCBB0k0w7ExbQYsLSoMDsN+rfpMri0zqhjDXAnKSTvxW3vr
	 k+mzTHq3BPPY94gtIwkgmOUNjTUSUgIYk8RgzB1RD2ibOIDYbG6zt5W3RzNpV2kMC+/9O
	 8Hgww8VhllySSfSyWmim98v3+nrZvn5j2/meNJYCXh0yKacZRC9HPietrtVaQCYw0rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
	b=CCPnOXkWuAjgIMndsVAx/HPstAqLZe51/Xil7gr3y5wnmFVi0AWD464GWPXveEi8w3V8
	 e3GekZVbAbQ49nvfG4APCfppt1DnpMAuMXBN+o0hzun1K2O4JfJnS++8blI0wAnvJGGBK
	 H7v6UM1DEP8tpVRB8dHBB/lFnpWzjqNFe0qo4JkqsmmdW4a7joJpsuyXIX1dpGG2j4nQX
	 4p0I1Yhs6CEZDlMQGtoKlxMcqPl/VbCx/6qHBwIFiMwjwzGOi5QKwN7+pQrbKg6KZQj5O
	 CoAJwZAEfhrF1EG0Zl1oMwRiZLWqb2VdEC2i4qnmXb3i/3NaLZtET8NlOUgkfjEZvGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Q65xGQJm;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A23606A326
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 15:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87A23606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Q65xGQJm
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0e21048f8so28412977b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793029311; x=1793634111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=Q65xGQJm/Vv7a0IJSVKUyMKYI1cuAD+iyN8j/yn2ElxzvqUz1wX9AyfAmkEG6HntIm
         0en1uqkecHD5imZIDKeP/xHIvgRkCfhJouek1mzZmn74XUUO1PmKfEb0pYhDik21fO1u
         4mXTTuYgZk+03+FYZvBllPrQ/NNyhuqpvEy3Kpsgdej//YMXK0MPdmcUjbi81FbXMSHp
         AuMUB7UlEjmk41a2lse2BpWLMTqTe2qNy2x7xXRCrBSYMzcRBqletz7tcfWqb9DWJUzQ
         MQ/dZbVWYMSzMDu9W6kbNrb42EXcd/WbORX6lqSREg+Q6uW6nva/yoVSZ5U0BQ93M4WJ
         FaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029311; x=1793634111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=MuF/eILgyufyKhKov+R13LSRCkYNoopSw+zFlCxC9o/ZqHe0r/eeUyJkFzEWpVXSbK
         8x2iDV8gZmKjV20A+ru+DL3a1e8RsdEuJMYG5GwFs+w/fLUarDHaMnkjZsfVPayBbkmP
         ZRvO9BGyjkhyoPLVxA2bSHT55O4RT79w7XBpdmdokqKQ7JiN6a7IpInMjnPC/zLzlnX/
         65lL4A0F4veVZzwB4StJ7GBSZK9HCXqo/xdYn1t+npFb0o3juOnl8uUZzHavKOUGX6cl
         WlreiLRgE1ry1ToEumX8OHquV+b0sdaO6kD5/UFMglFVDJ1CMqV4qOqSQn66W72vxqkq
         TrDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpaGWb142jovgrqblMrkYoLXVHXzycZ4NhUZx5vko82ZoJsksDONc6LcDkZlczCHqIksLzG0P+MH38FxerepNsiXSfhe8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwJfNi03cCmxhNrupDD3szItwkOynSGeuigkpPU+hPQJZXnkCy
	pWyiP/jyJi7i55olBYFe6IQH0rt2AuqDnRgltKECqUpYxV1bkd2XLO/ugrHZS4sTPIs=
X-Gm-Gg: AYBFou2+4mCa8o+jKT4uq9NRrt39hqR3DLk39h44bT2D172fQJEty2HeiwPGUvY9xNN
	2f2ovLS9y90TGHu6rfbuy8LrYL0WgVvPuZMmrcywvhJ3jaFauXkyWPRqcqrIozj+jax3tSAlJt/
	tlK8xK6mcpuozcXkm3TfH5FfuJZsdQISK2m4O3UsL4WKRRtU65HKZj2g2IYD6AAwuodtXEMulED
	zgy5IcAX8K6iEVvXnvuiWTRM5yJck6c9t6rGf1eOaB35DeiH9XisO9iiWcnj2m0MWg11ePMlTk5
	o2Oajh0E5vwz8bdyL11Xg2hvB0LsmlgUJQJeQDEXuP4lsfFZgzTolJ25LC7Oyf56EeQ/bJP714l
	hBSbWqbrTY38UqzjvvUlqnjti4roCjvi0DKAuSoC3SrUMKr0/GM4R1iqxp09W2hUZNnC3Mvfb6s
	SRK/7I0NbbNedjFc7ok8c1HYSqbiuLCxhUMInM+FhxqplnEV3KsUX2tYSxDXI1yQRGZca9ud4fS
	JV48uULaxOcHBJ+1+eTHJOMssPehikxUVLSks+O593iPt4RXcj6BWlG6wvUZYoYEqyTTA/F
X-Received: by 2002:a05:690c:d86:b0:891:c494:1a99 with SMTP id 00721157ae682-8b166c1b116mr63073737b3.24.1793029311467;
        Mon, 26 Oct 2026 08:41:51 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.248])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e29c09sm34036287b3.24.2026.10.26.08.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:41:50 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 15:41:38 +0000
Subject: [PATCH v6 2/6] userns: don't let setns() lend CAP_SETFCAP
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
Message-Id: <20261026-b4-setfcap-userns-v6-2-25f10b7ca497@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
In-Reply-To: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793029304; l=6171;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=n4GgDASw93W0W4hVR9BfgOUvZQHADy8KOEbGO3+EfSU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAduIA7MDe6n5fZa/BuYfTurd3us4JNl8xtwtQZxMgvZuy4a4dvc4NNGVNmJX7mOWu4c6a/54ur
 zlqoGiFV2IQA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
because a task in such a namespace can write file capabilities that are
honoured in the parent.  A task that is already in the namespace has a
full capability set there and can't be asked any more, so
verify_root_map() goes by what the creator had, now ns->setfcap_level.

But setns() lets other tasks in, and they get the full set as well:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    setns(A's user ns)
                                      allowed, euid == ns->owner
                                    write "0 0 1" to /proc/self/uid_map
                                      ns->setfcap_level is A's -> allowed

or, if A's namespace maps uid 0 already, B sets security.capability on a
file.  Either way B ends up with file capabilities that are honoured in
the initial namespace, which it could not have written there, nor in a
namespace it created itself.

Refuse setns() into a user namespace whose tasks can write file
capabilities for the root user of an ancestor that the joiner's
CAP_SETFCAP doesn't reach.  That is the case when the namespace maps
such a root user, or has no uid map yet and its parent maps one.
cred_may_setfcap_userns() checks it, and cred_setfcap_reaches() is the
comparison it and the later checks use.  Then every task in such a
namespace is entitled to what its setfcap_level says, and the checks on
the way to file capabilities can go by the namespace.

An idmapped mount can store a root user that the namespace doesn't map,
for example a "0 100000" container whose rootfs maps 100000 to host uid
0.  That is a deliberate setup and up to whoever creates the mount, so
it is not considered here.

The change in behaviour is that a task without CAP_SETFCAP gets -EPERM
when it tries to setns() into a user namespace that maps the root user
of an ancestor, and was created by a task whose CAP_SETFCAP reached that
far.  Containers that don't map host uid 0, tasks with CAP_SETFCAP, and
unprivileged users joining their own namespaces are not affected.

Link: https://lore.kernel.org/all/20261021-bioenergie-allheilmittel-undurchdringlichen-35666eb62cff@brauner/
Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h |  3 +++
 kernel/user_namespace.c    |  6 +++++
 security/commoncap.c       | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 026974a5111b..e4199b03668b 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -224,5 +224,8 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		      const void **ivalue, size_t size);
 
 int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns);
+bool cred_setfcap_reaches(const struct cred *cred, struct user_namespace *ns,
+			  int level);
+bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index a5a94367600d..7bd3692c2f3e 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1390,6 +1390,12 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
 	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* Tasks in the namespace may have CAP_SETFCAP that counts outside of
+	 * it, so only let in tasks whose own counts as far.
+	 */
+	if (!cred_may_setfcap_userns(current_cred(), user_ns))
+		return -EPERM;
+
 	cred = nsset_cred(nsset);
 	if (!cred)
 		return -EINVAL;
diff --git a/security/commoncap.c b/security/commoncap.c
index 4f49dba65426..8a9d998b1897 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -158,6 +158,64 @@ int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
 	return cred->user_ns->level + 1;
 }
 
+/**
+ * cred_setfcap_reaches - Check how far up CAP_SETFCAP of a cred reaches
+ * @cred: The credentials to use
+ * @ns: The user namespace to look from
+ * @level: The ->level of the ancestor of @ns it has to count in
+ *
+ * Return: true if CAP_SETFCAP of @cred counts in @ns and in its ancestors
+ * up to the one at @level.
+ */
+bool cred_setfcap_reaches(const struct cred *cred, struct user_namespace *ns,
+			  int level)
+{
+	return cap_setfcap_level(cred, ns) <= level;
+}
+
+/*
+ * The topmost ancestor of @ns whose root user tasks in @ns can write file
+ * capabilities for: within @ns->setfcap_level, and mapped into @ns, or into
+ * its parent while @ns has no uid_map yet.  NULL if there is none.  An
+ * idmapped mount can store other root users, but that is up to whoever sets
+ * up the mount.
+ */
+static struct user_namespace *setfcap_top(struct user_namespace *ns)
+{
+	struct user_namespace *seen, *p, *top = NULL;
+
+	if (ns->setfcap_level >= ns->level)
+		return NULL;
+
+	seen = READ_ONCE(ns->uid_map.nr_extents) ? ns : ns->parent;
+	for (p = ns->parent; p; p = p->parent) {
+		if (p->level < ns->setfcap_level)
+			break;
+		if (kuid_has_mapping(seen, make_kuid(p, 0)))
+			top = p;
+	}
+
+	return top;
+}
+
+/**
+ * cred_may_setfcap_userns - Check whether a cred covers what a userns can do
+ * @cred: The credentials to use
+ * @ns: The user namespace
+ *
+ * Tasks in @ns can have CAP_SETFCAP that counts in ancestors of @ns, see
+ * cap_setfcap_level().  Check that CAP_SETFCAP of @cred reaches as far up as
+ * tasks in @ns can make use of theirs.
+ *
+ * Return: true if it does.
+ */
+bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns)
+{
+	struct user_namespace *top = setfcap_top(ns);
+
+	return !top || cred_setfcap_reaches(cred, ns->parent, top->level);
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set

-- 
2.55.0

