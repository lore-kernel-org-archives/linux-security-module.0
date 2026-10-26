Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029316;
	b=Y84zGVHUmZbDx0GDU7wKZidYw7NiDOwcBwRVx8B8h25PxBHRtR0eAeqviZ8DA2lkmmF4
	 NcUOAijH+g9xqMiuC9jleWAreJn5iPI853fxHBDV2zJXGj0JEJTg6QoYJTSwHW58Cw3SF
	 2AjqE7Tr4/bZT6iQAxagdgOuFBH+aMcn3SgUDvb49dq9Pjk9+uIwZSS5D0LU1JNj/oMoj
	 tM6GLv8Uox6Pk4SabcjU38kHyooblxW+z6JFbweYsQNbSIdF3yqTf8fRNkp18zGSM3NXt
	 6QOrsyphesxfbjKgAJig0NKR47ucmCsHTm1Oaj5EuVBheAg8o1qN12divcPlbW3Bahw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=SlE+GD6loY7SaEz5ltXlb5NxzrPftLvvYozFrshERGY=;
	b=NUkVgPOTj8qB0iqCBwLnE9xAqIZ+aXGXTp7PUzlWlSPXVKLUSAUYegS4jJE556VvlJdr
	 VHo8xeQ7ALqHNtyHIiba7amOtWFWW5q80kMQNqUiMbTUsgVuGdXoiJGbqgLSOvqUmL4xP
	 +9A3BItsbtxt4fCrhQlUsavCr6kUioG725EVu9z7j50hx+RPi3/gqR6LvIngcaQS9uNVn
	 gYn0f9TZZhY+XW0wl+vljJMggI5OAYbFaRXfnsXNGNMp1cr5z0KtI2PQf1h1tUGivL2Ef
	 LjDbxTlh4msxLF+lDiLAuNRVEveMvQHW00Lcw0LlQeJU/ivoHW9Ait5e3xwG/DD+vcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=DhY4OKkC;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01B606A33B
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 15:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB01B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=DhY4OKkC
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5351d76e1baso176751cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793029315; x=1793634115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SlE+GD6loY7SaEz5ltXlb5NxzrPftLvvYozFrshERGY=;
        b=DhY4OKkCdVEuySLEpvHN7qOnIoRlwGaHFIQoLxIuZRCgjCUCrPL2FNtWXVCADNHng7
         N/UA+bm2dbHQyTHU5zrPVVAPiGiQkWwOo/9QW7fXRCp+l3nNsK4MHAYEF22ho7h3yXgt
         agwCojm3FOQwLv4DxfuVrHT8ctvmKFRMNGAjZBfdwu1pcPQIA4mmB3QcLd0lRiFuGeGr
         ITUhEWN6bwHPtHTQ6EO+pcTjSCabiCc/QUFG+a68m6tJVd0Oj4JAgKWIBIj09rw8QFlG
         2L+LXCsr9KHfjI5Hm3EJJ0JPDb5VHFlpxy0Xidte48yLpBjtAGKivche2BdMH4p33UWD
         abXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029315; x=1793634115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SlE+GD6loY7SaEz5ltXlb5NxzrPftLvvYozFrshERGY=;
        b=Yzaoe95fYdfh13fihHPANeFkRmxdToc2PUPeVTt8CcqGTBQgoT7p8v+tzRrt2L+Tmv
         ldNYrkjyjFM/ZRllPYZsrAs7hkTX1JYjOpq6a+0PXxDce3sSWDrHNezrjvlx69N/DBJ3
         wb1jHDKhcAQuQIX1oKwEQcKG0EBo35JWH7UI4BMiuwEVU36MVhaqmpoVw3klw+sPVxE9
         RoI34CbFb5BvDKPzSyWsKWosthS8l46QzdjfQ03YjlgWFEmfFsnZN3t0ulL2W7v6RwZs
         uhrv63lip3uQwYv6IMYaTb+phi8iDRvMIXt1fvGzkg0W8qr5OZ8NlYYqzivbMO0iJ/A9
         t/ug==
X-Forwarded-Encrypted: i=1; AKwUvBwCJYOTiQ+0q0WxfVWOgIIBSxUF3dShhRwqfxkucmTES1oGqyfFHYUyTbil0hBv1YcKw4lbKPF9FMp1MDbL8f/sSKU3TCw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvOwzajApQq44ClqcuBBJ1wgA2bTlwNrw8k/mhFBg3KEg9GpcG
	dzgM3wiWLBH0AU1D8lonvA0FGtxBAtPajMtpjkJPWWkR+MZKxq96iAJLWZPG/pCVqQY=
X-Gm-Gg: AYBFou17WBhHCqAc78pNdGzLSy4Qq6d3ZXQwSpZXn+BhPgn9108DTMkV3GqFX/LXLAs
	9tOAf3aXCOYoYN36HVeKcGwz6BHqxCFloQ6QC903I/h+lzjM1d4nYwPjEkqCngxqQ5JIiv4w3xC
	eGHPfZuF/YsEKIsQLQTfDQ0ATtDqxRc6fAD+RE/a7IyIOm+2u3+aF+PVPzdoGquindkXdJ/u6dK
	h4IuCQRJqcCiOwaMuNHQxttLe/w1fbXTyouZmrK+ajs8pm1xHemGnwFpe8UrvuXNKlDxLd8u0+g
	YJkPo+CXX+oylyi0oVXsKF+N44TLRzSYF8k06j0T4JbFpaG1IFkcMkfBpIY0EJDZASlPLVcTPfF
	5ERwpDUnmOX5zQk1hFMHVAYRpuKrWwo4yNdtOe8xY01HoMmP7Lizow4AT2vEd022/u8411niQTT
	MKzzibHoSrt5iduAnDl00OL9Vb7DLVZAvYZ5Zj87/vzBozvRt/WOz/A7xlbnNXVlAUuBI636zP+
	UzAc+TfAZlY0jPYm5BMOmZP9vEvSEGB6yj/8/G9pyG4lhhFYsThzSjU8KbCNn/5O7E3mMu73QNR
	VBED+mj7slMlpzFdaA==
X-Received: by 2002:ac8:690d:0:b0:536:7f96:915c with SMTP id d75a77b69052e-53e3bd83418mr1024811cf.5.1793029314726;
        Mon, 26 Oct 2026 08:41:54 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7e0esm56960091cf.12.2026.10.26.08.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:41:54 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 15:41:40 +0000
Subject: [PATCH v6 4/6] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
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
Message-Id: <20261026-b4-setfcap-userns-v6-4-25f10b7ca497@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793029305; l=5703;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=FDChG0bx+cXxkkBT6UYSsvtNifUZi0Mew1bpibNMRUo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QL5JEkNWRRPTBTugyMQIJBAY+L4bDDBZTREONlyXP8JVBrk+kpRccn98YkJHvFaZ8BOfaPmade7
 YdcObfcDORwg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
keeps a root process without CAP_SETFCAP from creating a user namespace
that maps uid 0, in which it could attach capabilities to a file that
are then honoured outside.  But the map doesn't have to be written by
that process.  A privileged task can write it from the parent, and the
file capabilities are not checked against the outside at all:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
                                    unshare(CLONE_NEWUSER)
                                      ns->setfcap_level = 1
  write "0 0 1" to B's uid_map, gid_map
    A has CAP_SETFCAP -> allowed
                                    setxattr(file, "security.capability")
                                      rootid = kuid 0
  uid 1000 in the initial namespace:
  execve(file)
    file capabilities apply

The map doesn't even have to show uid 0 of the parent as uid 0, since a
v3 xattr can name any mapped uid as the root user.

Check at the place where it matters, in cap_convert_nscap().  On an
idmapped mount the root user named in the xattr has two identities: the
kuid seen through this mount, and the kuid that is stored and seen
through every other mount of the filesystem.  If either of them is the
root user of an ancestor of the caller's namespace too, CAP_SETFCAP has
to reach up to there, which ns->setfcap_level tells.

A v2 xattr skips the conversion when the writer has CAP_SETFCAP over the
filesystem's namespace, and belongs to that namespace's root user.  It
gets the same check: if that root user is out of reach, the xattr goes
through the conversion instead, which names the root user of the
writer's namespace and refuses it when that one is out of reach too.
Otherwise a task that unshared without CAP_SETFCAP could mount a tmpfs
in its namespace, write a v2 xattr on it, and have it honoured through
an overlay mounted from the initial namespace.  If the filesystem's
namespace doesn't map uid 0 at all, the v2 xattr has no root user and
nobody could run the file with it, so it is refused with -EINVAL instead
of stored.

Tasks in the initial namespace, tasks in namespaces created by a task
with CAP_SETFCAP, and file capabilities for a root user that only exists
in namespaces within reach are not affected.  That includes everything
an unprivileged user does in its own namespaces.  The rest gets -EPERM.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 8a9d998b1897..4e0b00b7b1a3 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -216,6 +216,29 @@ bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns)
 	return !top || cred_setfcap_reaches(cred, ns->parent, top->level);
 }
 
+/**
+ * cap_root_level - Find the topmost namespace in which a kuid is the root user
+ * @kuid: The kuid to look for
+ * @ns: The user namespace to start from
+ *
+ * Return: the lowest ->level among @ns and its ancestors in which @kuid is
+ * uid 0, which is how far up file capabilities with that root user are
+ * honoured; INT_MAX if there is no such namespace.
+ */
+static int cap_root_level(kuid_t kuid, struct user_namespace *ns)
+{
+	int level = INT_MAX;
+
+	for (;; ns = ns->parent) {
+		if (from_kuid(ns, kuid) == 0)
+			level = ns->level;
+		if (ns == &init_user_ns)
+			break;
+	}
+
+	return level;
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set
@@ -671,19 +694,46 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EINVAL;
 	if (!capable_wrt_inode_uidgid(idmap, inode, CAP_SETFCAP))
 		return -EPERM;
-	if (size == XATTR_CAPS_SZ_2 && (idmap == &nop_mnt_idmap))
-		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
+	/*
+	 * A v2 xattr belongs to the root user of the filesystem's namespace,
+	 * which may be the root user of ancestors of our namespace as well.
+	 * There may be none, then nobody could ever run the file with these
+	 * capabilities.  Only write it unconverted if that root user is
+	 * within reach, the checks below handle everything else.
+	 */
+	if (size == XATTR_CAPS_SZ_2 && idmap == &nop_mnt_idmap &&
+	    ns_capable(fs_ns, CAP_SETFCAP)) {
+		kuid_t fsroot = make_kuid(fs_ns, 0);
+
+		if (!uid_valid(fsroot))
+			return -EINVAL;
+		if (cap_root_level(fsroot, task_ns) >= task_ns->setfcap_level)
 			/* user is privileged, just write the v2 */
 			return size;
+	}
 
 	vfsrootid = rootid_from_xattr(*ivalue, size, task_ns);
 	if (!vfsuid_valid(vfsrootid))
 		return -EINVAL;
 
+	/*
+	 * The root user may be the root user of ancestors of our namespace as
+	 * well.  CAP_SETFCAP that we got for entering it doesn't cover those.
+	 * On an idmapped mount the root user is vfsrootid as seen through
+	 * this mount and rootid as seen through every other mount of the
+	 * filesystem, so both have to stay within reach.
+	 */
+	if (cap_root_level(vfsuid_into_kuid(vfsrootid), task_ns) <
+	    task_ns->setfcap_level)
+		return -EPERM;
+
 	rootid = from_vfsuid(idmap, fs_ns, vfsrootid);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
+	if (cap_root_level(rootid, task_ns) < task_ns->setfcap_level)
+		return -EPERM;
+
 	nsrootid = from_kuid(fs_ns, rootid);
 	if (nsrootid == -1)
 		return -EINVAL;

-- 
2.55.0

