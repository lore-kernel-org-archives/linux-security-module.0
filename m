Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615065;
	b=OAMHZZHk8pz40fXFiXXAYExEqHhMigPK9L+JYGVrkL8chXROBG159MlGyW0/A69nFcGd
	 TdMtTzQBijZwUmUckEsfNKKz5WISXb3C0tGcSwLJDTE90rOmh+eKDsdPiexG7lgrOinf2
	 UCIzZ3RjnCXPev2jZMBB8qeHmBM4Zpc6fwBJQfVVpFUaqM0IjOInMMYxwwiciGBMPtVHn
	 C9RTqsE1guV05+lcuyhg8UTEaeAhD21Ny3thV9DtjeprOG5jjB7/8R0UQ4fRcVZpugEvp
	 5Y6MEW235+QDGktJRqtQbDwin4RlrS0tbxb4MANss4YZn9XZOl1FKCamPDLK2662OMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
	b=KxFGgl73nTUBEDVzfUsZQK0ZR97frLKIlusF60kC5OK8hTspR1WczZCQaJAWNZSA0ZGA
	 rZQJ2ojQbnttn95jADoHlNpZaMcA/sf8wYKGfKQWG8WP8Xg3K4DbzeSXfUWB3omYwuoEI
	 dFflLnaiuJP4vKJOC4zVIDjXoHzRrW14lVjXyIwICR4UC17ejqjQExIDICdGv8czF+OlD
	 NvvSYvfKo53pGglD4ygRok5+F3KDH0/UUVAgbZtzidE5oidAveDNDeFYXPGzJG+kcoo3X
	 XZ5CWPEQQgVwDV7tC4WLuqfgYth2QdUuS+iZf5Gfhkx30mrcB8zf1KoOyTwg73rW56A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Vyr9Ej4Y;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC1606A336
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 20:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78CC1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Vyr9Ej4Y
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91befe703c4so8743126d6.1
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792615063; x=1793219863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=Vyr9Ej4Yqcprk3WG6+TyjpghfpCld3UFXXz5MTV+9u54EvPhJ5Dm8U7OM2xPyJ5Ajf
         sKoAk1v8T8XPmdy8Pczk1OKaxmc7myCh8ylTNSozIm8pbP3xAjtvzBnK+F0nXrwrEEJw
         XVj1VaB2bF3byFB/q1Kra4xxL/Eo+GWqLOnZBtR1VTjDoA8fqn50NvwyyYTFWehTjWPO
         G55Z4nYeca34fm598MfoZnvYDikR90viUKoE7Rb3jOX7BrF1h/mLRT9xDgAwnFKIHsOs
         2+DYVoIC8OGZqc5lWLQKgITnjnCpK/hQk1ZeNpI/JmalW98BD5o6ELrjK/Hb0aEr8IQ7
         ExFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615063; x=1793219863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=OVeQqwzMlag0kRrEBbS3veGaVONitNfU+o3w93eHnqm56Zf9DAFQODDH2VAGtULpMb
         RINUbjfeJI8JyvY/7/F9X7r1iJFSsk1Lmqa7YuPmkRuvO3f09OTqx5y9WPx1KdW+LtHm
         0sHQyKpVf2n8wV4HookRj3Hecwdtq4eTretyqSvUJF0qWznyOW4OOdazDLMrzDxUE7X+
         WDuzb539pQYwcmpv17iVcccmuhZ1vUJTqgZ9Sjv0s/dEXPiDFpZ5CSuVMeihE5bOSuLr
         m7fxwjS39udpzSi9DrqK9fTrDYX+p8MZakHwhKntwzr3cnMjzt5oiL7S0TpPtb7He5Ui
         iQUg==
X-Forwarded-Encrypted: i=1; AKwUvBztes3zeZzt0pKR63TpvpeYe/PTwBuu0IF0OxeDzvPZQd765GvGZ+YHY3b6Wm44XH71drv8b9n6O43gBSUMJdByL4H7RpE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSSjYAOKtUzpKnbcBkALDzCwtqcMcIXFSk4fbrpKwpC/uMsoDu
	cTRrimes05ZqAZLL1xc3vFWfhGXzdNYrLCtm9ffjIi6fYeu9KmGZ6f5NNrhq+GTrPdg=
X-Gm-Gg: AYBFou1r4MlApZulxr3vrl7NLoAHG1tvc4hIjNwK8/FrV0eCupIFUzGl7fJbjklftEx
	LtETpSUPHKWHX3nrfkS350REvYKiu6sNlxQAoaTMuXJ0Mzk1Izv1DVmsb/9tfABe4xRUaadeN6f
	WwYgbsvOkoWo/jIPdmWFuWw1+wZVPvIS1XmMkOta6uGIP70+cE1wK8oUe3MPCtmdeI16m9k7OhZ
	a/q6zqtgvNWnAVMxrRa5uZmVwzS1QciNKn75wK9soudI2SmHvppd4hAK3XdfvEUDgYwXJ2DYaB9
	/h2VHKHeHDr/ElC4R1XtkwyTR1TH2O0mdXdgkCFwjFgkusH1GZETbudQtcxMtABAMm2P27Jtn+B
	DC/A5U/aZucFI5veQDYkYQGDUpeYe2UO6jP34R99fwQdwRr+OaOh4ZzY1G0p08kHlzycYoq6NQa
	qAamAeRdgBTmL3RDZyZXU5FaZZA7tWKkQugAu+mzgynG/E5Xs9Oem3Fdhe0j2YrrHa3dK2LOSaY
	iIbIiQmyk7gESE1Ylmfv22ILJViXRiyelLFrQw3BJ3axsKO1Hxvy6NNKtT5z5nSdXysg9Nh
X-Received: by 2002:a05:6214:1307:b0:91b:895f:1a70 with SMTP id 6a1803df08f44-91c12edd4a2mr53460076d6.13.1792615063292;
        Wed, 21 Oct 2026 13:37:43 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c45747sm33392256d6.39.2026.10.21.13.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:37:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 20:37:26 +0000
Subject: [PATCH v3 2/5] userns: don't let setns() lend CAP_SETFCAP
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
Message-Id: <20261021-b4-setfcap-userns-v3-2-97c7ed4e43e1@toxicpanda.com>
References: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
In-Reply-To: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792615055; l=6171;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=n4GgDASw93W0W4hVR9BfgOUvZQHADy8KOEbGO3+EfSU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM4P3KlqYurlWT3jkkLXjsgK30Pnk6OhCditFT1YkDA0ERB0Bbw2JzYks6wrcXMC976EgYglCcs
 uvVq02w6ahQQ=
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

