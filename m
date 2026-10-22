Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694201;
	b=h8b5pDvXcVu3izIOIJ3GlnAmVDjB3YetnYjflKWgP2mabH0Cqm5rKfO6obe3WMYcVICi
	 jkCDLL6nDNKG3Li4tOkZ6dlOunS1x73k1oIs1gtLnnL39UVdscrSC4FB4IZprCp+KUpgX
	 aUtHEsMPSWZsP5T2+SaodZ4YG8PWvmhybU+DF+DMl0q/q6JsUZiCOQZyx9irPP1vqdcaG
	 R8Yu5pk/Aix3e9ZdNneaUwc28fMHMXyHsoOkDdOaFHAMCiWhRRkI0Cup+2A6KSNgV5XAQ
	 iJQwLj6sVY3hA8qeT9Wlk0CF2iKxZiG2Xi4ZCjiUzQT6PUGTaHZL+kzRopj4JloWVSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
	b=yZyX3cfNf+7eWSge3KZYqoiKDaB2UtXdTu0hJzi3Lebph6lsIva5gV4pvv5yjtctJkyA
	 mcwC/9YuX6V0a7MFOA+903zUsEQaCZxjN8W35dBCZBgYiA++lnrw+UBb6xVGWFXE0B0Qs
	 WrZSdQdmFk9kxL4QyzUxw/YO8zZG8NFTNVDbhXjtSu4AOZsXwBixq4gZYcukR/usYkfsn
	 gX3iGFqYnB5y3MHd+7/8hl0FnIcuqpVwYoupkmp48h5ktEwM/cP5+tivg5eKGyd2keGI/
	 joXh11UqN7/2G61Te0n81Ym4UEQTyui2boW+0zX7uik0FRz9A84zOQOx23rT5G6ZMUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Da5IpzFB;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D3C60A261D
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87D3C60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Da5IpzFB
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5361e313e63so170081cf.3
        for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792694200; x=1793299000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=Da5IpzFBl/t/AuZkBwDpYrEDlzxgAK075QWTOy5vR1dT92EbXvug/V9As/ptgfozcZ
         haeEAtO5IhBylFrwbTHUXL33EmAsO4lrjP7FSbLDlR9PB7WyyVPBZ+Ki5Ta9U9XvfDoY
         0qGlZRGo+InLkKZN2ZxFjlM6p4sJ++iSDUdWJQXQ/6ZFGfZX2XXLHux7sdPhD7VLUTeu
         OlCTJLBRCTRymblSDrRXfDp37vI2Gk0pemgrbTLE5gfokMHuYueJMV5yJ0uGGUAh5lVN
         IenLUZ475Zh2NUlpOcAu7pdEmzhxseKJFKsP/nGGAo5J0eivIq2xRfhH9qyzmsVIzuOf
         uZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694200; x=1793299000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=s8uCL+kM8ZltWpsMIbdQWJF8fimWPybXqQYe2aYLoig2f3FEvRiS3EOyeIGtTq3ij1
         QiFgFi9ySMgVVAoC54P0zi9VjBpSwCP7x4D+abdiUmdoUoRa5XWk1sRFwwYZU2YZ0Qyg
         Td+q0UArBHvOXRlz7JN776GwKwQfAlH8nNghZfaCrmxJk/hggDQtToc3z74ss/AwFqzQ
         KCn4kAvw6ON2eKFE2SVqYg+6+zmxELO/L+5IxVStocn9SN6pt2vEoLg5c3Shf45HJ/IL
         0qjn2lGWuaYUQwroxrSbA2LFDrOt1ONy04PxIa1DlXT1IZufbrbJgMYV9MLdfxLyiCFH
         /WIg==
X-Forwarded-Encrypted: i=1; AKwUvBzUjQmDY6n7j/m7eleMHeovXk0S7Kr10xDMgBNN4uYEd6IiNz18lFHrQTsv8nmMgm0wa0hI4++1Ob2s1EmNHtg+DwjPANQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkrMH1/v9EmfqPGg8aulLRA1gLjmGzBnigoeLb2kJBlmnhWI/p
	PqrcTyNJi1FBkVTMc+7t7FEEZ+90xcn7PktTjGAEe0yqM3m1B4C7UbQavjNdLzAqNhM=
X-Gm-Gg: AYBFou1zw7mKe4QCicdfjRCNGKIxPAJw07dOz/L8NHSa+pD9AZMzmIiEX4FqYBN2rjZ
	kaAJJIoQX/znjwTFwhu6iVJ5+PKsP+VKCsDrhzwVm7Iy1zu9nCoVuSOWgDa3fYEoCPjkqDF06wa
	etCRqzHBKEy6q6n3SOFB+QMzOkXTMOWSbuJOsb9AtVOnhW0Lx8Adir0+FMnEVJmurXwnfvq9HEY
	M4wZZ4jFPbi0VYow7bFIGh6H3PnoFpxbZ4YUfpvcwkLmLv++mUdyBXzN4lL8bNaAMb/NcjSGnjQ
	mNATVrNBlSwkfi4w30iHn1Xo6kLHxZy4Wmn9BW3mLWpAkPUkhNMOU8/0Pr8dWKy7c9bfu3nLUdY
	km4wylq0LNysVeKZvhvrT/+7DIrBXds+UhYrphCcYXlYu7g5eFVJjjbi3lskpwDBfKswR4gq37R
	yzVk5Zekn1BTr3+rpmkfEaEOHIoYMuJr5TUmxVkg9st9aX/75XmthJizI+1X2Um93vgs7zzk618
	gkl4BLybNu/eaRKl4ULsfdYPkk3zT4a0JbUx+J9xlZ+iub+TTpoDfYGABNL+q+Qo+T8o6/E
X-Received: by 2002:a05:622a:1813:b0:535:f9dd:cb8c with SMTP id d75a77b69052e-5369b68f86bmr96241071cf.19.1792694200389;
        Thu, 22 Oct 2026 11:36:40 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536ab6f5c9csm33898881cf.11.2026.10.22.11.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:36:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 22 Oct 2026 18:36:20 +0000
Subject: [PATCH v4 2/5] userns: don't let setns() lend CAP_SETFCAP
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
Message-Id: <20261022-b4-setfcap-userns-v4-2-88aa0ffaa08f@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792694192; l=6171;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=n4GgDASw93W0W4hVR9BfgOUvZQHADy8KOEbGO3+EfSU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM/ahjV20208az5IZRy82VEqyZ0IuWu0b9yg2I1rzhGFwGftatKCP3w0WLLSTlI160zk3va7lOg
 pPLWLMlVn9Aw=
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

