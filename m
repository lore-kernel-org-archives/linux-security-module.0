Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945283;
	b=Hbw5/SXuZQjenI9t+8eGnEGnWyfh3DoUljxPcbmNKNhRzcnQAsV1fkGBD4E7WDBo2AVu
	 dnqep9kK6UGYr9d80VLjaykM09oau57WSJYQ6c0slGPsyNlsGjF4ZpAFmjEs0vxqHh5Bl
	 VyK6tEiZsE7Od6+XBpHTt/lL7m+oDoDVmV23F6C95iA8FJ/lXzx57MX+EfG4/eBKhQWNi
	 bc+Vi3HpsV4wclFGKjfy6BIdcybZmiFKd2uuEBEy/t3v1+OM830GcbVy4liyaYS0PVRGC
	 9p+D6Fh6AhrVfOJ8mJMEQzDXZrFKa9YHudQDnxrACiby/ZdE0oYqKIthnEL4mYnuZJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=UgyoOlhtAXFcRqYIBOM2SsXiIxJADqweX4syv/IHfy8=;
	b=yVXasU1fDASa7h9vIJvk31X8oiAtPpQZQTiNgoR5A+JMw2A0iXyPC29vQvVMp9WV7B/l
	 q4ZtH6ydWzfu7twUvGqmwmYHorIPQ55yWCgSvODZxPNFpyXfQlYfq6GQVNMSCcL6plLzY
	 UlGDn90NzfPhubGHTbkpr3re0Li1CNtgO7t1HIJNe7R3a9FwFjaeeSBED8qiHAjUpv4b3
	 jiLsGHIElWivBbk6xmW9gLbR/Ym5DeaKgXP53PpS/JQ6OSUN1d+KoQkSogolrfbeacZzK
	 KLMCKVyPHy4GKpF5YeoGcHXZZOkbqpRsCo3X+I1PAXolrLe0QRCuNm5tsJUpcquKIhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=PsPV0FbS;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281EE606A332
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 19:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 281EE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=PsPV0FbS
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-94961ed97bcso27814185a.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 11:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794945282; x=1795550082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UgyoOlhtAXFcRqYIBOM2SsXiIxJADqweX4syv/IHfy8=;
        b=PsPV0FbSoH3EBsZAiDqYx4piVy+a+VsdVn6lf6uYuC61CddilVAm/78NvIF1l8cu3j
         S9qkOZL8tbETOSF7/qX+O680lu7hbbfkK5ISAJj9KOsOEchkMxGBFySEip1YZiERAe9v
         fcqt18LHLcmcHL0YV1hR3MMkyQCGl7Pd/1ESR4EguCNCCTrNMbIWmIyoeC8ZnIFhhGJt
         OUUy+0ba4BDG6RslNg6Oupl3qrOMEWAEpFYdS0S2K/xG2sZmjm7CO8YlqvRlsGltba8w
         FHz+pmlsC1HBGfLfpREe5NPXm5AIX+O3Hja89UZocTvp5DX4cWWo4NpnMibrp2qVJwfY
         5ZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945282; x=1795550082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UgyoOlhtAXFcRqYIBOM2SsXiIxJADqweX4syv/IHfy8=;
        b=vVrBq2nUmJSbpq8BVh5dDNk49U75T6Ji4Pxkvzf2c8eq4FoM0a7cghTQOhv6LN5llj
         wl0sLfg1aEkIsEkIrc3JHJMLlpOBYOf3DQhkXv1yUKD1iZDzQO1Ssu2h2Qmm9ti7NVTa
         6nnNV+Vzb6KXdALrmwmOyricB3O9HJdIVR6w2P9jsYIuFFU/LV0Ks6/RBns/lozfBLOG
         TVjdEXXwiRqyBhpVpctW/HcwUkZ5mPrVpp51xZaWTVA7Q2SSi7DRhqcpT5OsYrE8WbE3
         T/7NieN66zIOGG/yVKU0VDE9wbFd21CrxmctXm+M8z2igJdP8sSLryucD1o5xZZqV7Nb
         mC9w==
X-Forwarded-Encrypted: i=1; AL+hErHC2NSf0bRXxm+ePU9OjUF1WJI/u2TYypVd4UAHEMu9Q7Wv1Ikx24sFeSdrMNUmjOIPKt/DjMr/UOw/BEkQhO+Id4JCYn8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Tmxu7sYg/sTULU0Nyy1RQBgG9SJvxoaCm9OpVa+nbnbxLmonn
	yuXd5bOvrsIEmgtXnXi0X9vW6kMhUSOrcDyE+mVXh+/0z9VpeQDx3eTpCtmQy/qYCNg=
X-Gm-Gg: AYBFou3+cl/XKhHCq9Lkb8y/wyiBo0cJYKAfxBqLfeDLPEYLpAMdDKraKqJ8LMfaaDv
	SYl/V3y/uKYaX6+oQvrPMdi5hPDw0YvcizFJLeM+s6eO6JTz202TQvD6uqdbRngrvudpA/oqluJ
	muvSgATLsQOjl5KH5JuIMvOlPNSpMKh1yNZNU2+eemi4cNcK4eCCMFaPaMrQ5AFegmXIvi8+uwH
	JjGU4znTZI9W9TUo+Sv5ReH5lgVDsR79tm8mXKKakDuKwQf80KU6PDxw2GM5vQGQqjxRP/ESNFo
	Kdl9QFiYOwl08jSUbA8LSOd8LOxOu0yZq7sNL0YeeRiD0a9Hc8DhApcDrJgEOsx6W/FK6UrZuMq
	BXd/Hu3cOoPvrq9dYWdhc1Xn4AMddVmOIQmGMmNuouY+6ZOHibc5A4fdOFF52KIXjXWed84C5ma
	wgrSauGWXWBQCz+/BjOQ5F7PU7f28suqKWMma+cjGLBL8PMObBdB6wWQ43siASZ4qf16LexMac5
	JhGhRqPJCadSU1fGhqv1THiscBFxULCoqjK7TU4n9W3hKECQZhBGQNLtN44zTfZ5cBHFPnRKeHi
	ioLwjdz69KTehhbxiVjbPdGFVpSYStcGx8vus8IVqRxX58U=
X-Received: by 2002:a05:620a:aa1a:b0:93e:7944:b869 with SMTP id af79cd13be357-9499a2e5dfamr57612185a.42.1794945281909;
        Tue, 17 Nov 2026 11:54:41 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b2892a2sm11834385a.0.2026.11.17.11.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 11:54:41 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 17 Nov 2026 19:54:24 +0000
Subject: [PATCH v11 1/3] userns: don't let setns() lend CAP_SETFCAP
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
Message-Id: <20261117-b4-setfcap-userns-v11-1-2be11a2c32f4@toxicpanda.com>
References: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com>
In-Reply-To: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1794945277; l=6359;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=32+LoADG6QT10HmGwykW7egT/CwzPpWpVKUua9+0wRk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGHyA+cL3OHHNMTJIX4UjUCtWID8KWQNCgUe9H/GKWCwJN5/vCEuCpeOxaF9ET3I/VTjk6W6sRU
 BS5KoVSvyuA0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A uid 0 task that gave up CAP_SETFCAP can get it back by joining a user
namespace that another root task created.  Commit db2e718a4798
("capabilities: require CAP_SETFCAP to map uid 0") keeps such a task
from mapping uid 0 into a namespace it creates itself, because tasks in
that namespace could then write file capabilities for its root user.
setns() gives a joiner a full capability set in the namespace too, so
it can do the same there:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    setns(A's user ns)
                                      allowed, euid == ns->owner
                                    write "0 0 1" to /proc/self/uid_map
                                      A had CAP_SETFCAP -> allowed

If A's namespace already maps host uid 0, at any uid, B can set
security.capability on a file right away.  Either way uid 1000 can then
run that file with CAP_SYS_ADMIN, which the selftest at the end of this
series shows on an unmodified kernel.

The check doesn't look at the joiner's uids, which it can change while
keeping its other capabilities, and CAP_SYS_PTRACE doesn't stand in for
CAP_SETFCAP.  What gets refused is a task without CAP_SETFCAP that has
CAP_SYS_ADMIN over a namespace that maps the joiner's root user, or that
has no uid_map yet while its parent maps that root user, so that it can
still be mapped.  If that is uid 0 of the parent and the creator of the
namespace didn't have CAP_SETFCAP, the join is let through: only a
writer with CAP_SETFCAP in the parent could map it then.  Containers
that don't map the joiner's root user, tasks with CAP_SETFCAP and
unprivileged users are not affected.

Like verify_root_map(), the check is about uid 0 of the joiner's own
namespace.  The root user of an ancestor that it maps at another uid,
and a root user stored through an idmapped mount, are left to whoever
set up that map or mount.

Fix by refusing setns() when the joiner doesn't have CAP_SETFCAP and
tasks in the namespace can write file capabilities for the root user of
the joiner's namespace.

Suggested-by: Serge Hallyn <serge@hallyn.com>
Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hallyn.com/
Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h |  3 +++
 kernel/user_namespace.c    |  4 ++++
 security/commoncap.c       | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 622137f66f09..9ebcdab56937 100644
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
 
+bool cred_borrows_setfcap(const struct cred *cred, struct user_namespace *ns);
+
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 50c374ed4687..34becacaccd6 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1390,6 +1390,10 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
 	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* Don't hand back CAP_SETFCAP to a root task that gave it up. */
+	if (cred_borrows_setfcap(current_cred(), user_ns))
+		return -EPERM;
+
 	cred = nsset_cred(nsset);
 	if (!cred)
 		return -EINVAL;
diff --git a/security/commoncap.c b/security/commoncap.c
index d47ab3022343..96ac039fddad 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -131,6 +131,55 @@ int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
 	return ret;
 }
 
+/*
+ * @ns has no uid_map yet.  Could @caller_root_kuid still be mapped into it,
+ * so that tasks in @ns get CAP_SETFCAP over it?  A writer in the parent can
+ * map any uid that the parent maps.  If that is uid 0 of the parent, a task
+ * in @ns can only map it if the creator of @ns had CAP_SETFCAP, a writer in
+ * the parent only if it has CAP_SETFCAP there, see verify_root_map().
+ */
+static inline bool userns_may_map_root(struct user_namespace *ns,
+				       kuid_t caller_root_kuid)
+{
+	uid_t caller_root_in_parent = from_kuid(ns->parent, caller_root_kuid);
+
+	if (caller_root_in_parent == (uid_t)-1)
+		return false;
+	return caller_root_in_parent != 0 || ns->parent_could_setfcap;
+}
+
+/**
+ * cred_borrows_setfcap - Check whether a userns gives back CAP_SETFCAP
+ * @cred: The credentials of a task that joins @ns or traces a task in it
+ * @ns: The user namespace
+ *
+ * A task without CAP_SETFCAP can't map uid 0 of its namespace into a user
+ * namespace it creates, see verify_root_map(), as tasks there could then
+ * write file capabilities that are honoured for that root user.  Tasks in
+ * @ns can do that if @ns maps it, at any uid, or if it can still be mapped
+ * into @ns, see userns_may_map_root().
+ *
+ * Like verify_root_map(), this only looks at uid 0 of @cred's namespace, not
+ * at the root users of ancestors that it maps at another uid, and a root
+ * user stored through an idmapped mount is up to whoever sets up the mount.
+ *
+ * Return: true if @cred doesn't have CAP_SETFCAP and tasks in @ns can write
+ * file capabilities for the root user of @cred's namespace.
+ */
+bool cred_borrows_setfcap(const struct cred *cred, struct user_namespace *ns)
+{
+	kuid_t caller_root_kuid = make_kuid(cred->user_ns, 0);
+
+	if (!uid_valid(caller_root_kuid) ||
+	    cap_raised(cred->cap_permitted, CAP_SETFCAP))
+		return false;
+
+	if (READ_ONCE(ns->uid_map.nr_extents))
+		return kuid_has_mapping(ns, caller_root_kuid);
+
+	return userns_may_map_root(ns, caller_root_kuid);
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set

-- 
2.55.0

