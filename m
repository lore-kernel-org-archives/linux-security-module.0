Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773037;
	b=yg1WPt0HqfLjb2dUw5baOv1k9oWt5knWSMSxnyWsaPMucedqEWFTdrvaGcwBkUuh6mMo
	 uyRhW5P7141G6GS2TcuYGScHFzttxKCHd2T5TuhD+9tsamryEqQU24qg/ZgmH0V8oZzfA
	 Ri3iq83qCoFHp0dZjobh0gLQtODsK4tWnB56lvSI3C60AXBf1att+TzD0UBokIrFcuuET
	 2mP7X5Nx0iy1yy++jwIcXtM23GNCeVwhrbNR+r1vDL49p2DPWF3YaeyLOwZta/hPy3j14
	 H6lRKgoHrsCysAGrnchrCWz0sAhTQjxyOV370k6kl0amaV8ug62vpWdXxPbTsMl4N6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ZubeVwcSSrwC4ZpOURNYhfBws2gj2pZEaNncuu+HoEw=;
	b=nS3vRBbJlM2jSRNEh45Ov3lokj6bxNLQJ7kzSe6+CzKiwho2sXS1B9F03Z8S8NlMhMq5
	 ZYQKxKcKYTCWEaEXnoGFbCsQh3cM64e2h8BNVfFwZZgRXOB3fe7E7VAtmb/q5feu1NCYb
	 SqwSudXastZhzUtWPWwjDGkVZKdhpCUIlLKTWOOpcqqycdfRRbAT+gKeOGU23NPBntJVm
	 gFMwJn3qN1AWnOFAp/CEccxeLaNZMVcrTvZcnzy0KdFo4W8rmJHnCjgD4Cs3AmNd8Tiac
	 74bk8btYP8XyTBY63+9aG7RbGlwDv082jW1CYzBMFmGxnh5T3OtP/L3p4/TjeZz0Hhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kzFXO3oH;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E58D606A322
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 16:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E58D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kzFXO3oH
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c2fc03880so17012576d6.1
        for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792773036; x=1793377836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZubeVwcSSrwC4ZpOURNYhfBws2gj2pZEaNncuu+HoEw=;
        b=kzFXO3oHFdI0Zozf35LOrS50VMKKJq977g8DdM6fE+VjJmEDNHUpBQ3WfrKynMFhr/
         Q9Cmvc/8hLs2UK/jr6dm2Yldrs/+Z0GXJsrZC0M9hNpgOvNFRIPDxo5rNyE9tm0C4D2G
         o77PkCjuo4Zy+7BX+GyNtk0A4ioANVhIVb3t1J0Rx8yJpzg41ayOHjagydpzN70KdiE6
         41mcjqRQCh8IomJfCswQtQxBoSC4+QvvquaUlMgAQ/0LC9Ye3xyNQ6R+r+fyR6RYoPFa
         BsJRm2y9G7H4nNV/EsDowbvpmfb+D1j3hyBPnO9xv8j3E5vTv7B60DgWxhqJUySuEq3h
         +uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773036; x=1793377836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZubeVwcSSrwC4ZpOURNYhfBws2gj2pZEaNncuu+HoEw=;
        b=DFZpyUJohtsCSqmmPIfE02QRp3xqot2mZ1susghPTH+0CzKlAOgTKg5gOLxVwb/Wfl
         vCsP+df3H45yCou6CBDAVk53d/VYXrlPdZtTrGtSgX1DiEPYQqIQW8wzikY3ohTO7V7B
         zBjeoEXDt+k5o2WQrC1We6OyZiLV3/UuENL1xC4xoY0hiLXnnIG5nulruehDKFfyrFbE
         R2u1JnSLi+5LbgGWCMz8F0Oep+7KrT1O9mHFMkIu73Ka1kHRxZZDUxZNOHt1rCm6BwHv
         lC7x67UIXpX9rCtyG7an67MJsXeroWFCn9jr5B/NbXoCR42Ifm+bfQLQHbAX6Na475G2
         yEqA==
X-Forwarded-Encrypted: i=1; AKwUvByx+p/ctt+OmFxxM5eFVEaPO7Tkxxt9XZEbcvltoOs3UyefNgMNgDYpuFZ9t3M08e/o6BuDyepfPAs1vYKIlQN8wTE3KiA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLawiQtUD/dfN9oYYvcHPysM372Pda8IfYXs9Jvk883/kWGBmkJ
	rdSWPdT3R7VaC4kBSgLexu3nOQPrBtXNF2pEVUcMSCn2lSmaXS3YAWeOwVf5AoaHi8o=
X-Gm-Gg: AYBFou1E89ctCLCRlS9OHedRz9wWEqQldDjK2mqhyyXNrlN8ok55w/rh/k+eqYg5a87
	4bRnK+tRT3i+WfLt199X9zsOt0hRbk4DkCk/EKriopLGNswHyd8CqvLNkIuKqxuh/kpSEqNtDnJ
	67hKKOlH8izXiDKTLk2Wn95doMSmsSckbgfnr04AZh/W3EJadT3aR8u0ctu4GNynULCnz89rIyo
	wtz+LwDTRsbC+lszuUKg4SzqDeDvqVbIizY4+qkMZsg72sgX69CoCAGYTO1ZNGly+6QlENA1sQG
	cWRO/cefBZhhVEN6NKgVZZpjcalpuBCtIMvO2RNhs+wWl3rhtD16FJCNTBCgiool9f0pBNDnWKJ
	Nm2XGJh+4fbT0SgkbbeIAA6yaGUILbp0ShNiSUQEHEfH6xYIkgoXemwo4v/QpopsFIe61avzGB4
	tGfX0ouxqus+EqnucIUhWi63zH1RQhiH8PnC8p2XStysQJGeK3haM579pL2gn37KWUW1GLw5drl
	l+mifuF0jBUfbxwZLDRdV7OYDhRccuQ5louSwApjX6zwNw9m69NwePIz9NHj9befBkpTH5a
X-Received: by 2002:a05:620a:4104:b0:93f:5304:422f with SMTP id af79cd13be357-93f626da712mr975867185a.9.1792773036248;
        Fri, 23 Oct 2026 09:30:36 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b1c97esm56189085a.30.2026.10.23.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:30:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 16:30:10 +0000
Subject: [PATCH v5 4/5] capabilities: limit fscaps to where CAP_SETFCAP
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
Message-Id: <20261023-b4-setfcap-userns-v5-4-0620223be951@toxicpanda.com>
References: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
In-Reply-To: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792773019; l=5344;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=/O9bS0ON7NDi1eFWDO2d4FUpDMW0l6ZmsSOp/+5oH7g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLOB40AYzMuO276rGBVj32RlrfQWWtaiGFlNBPbISDKxkkHMnwLuii9VlVvai8rH4pvQQQF0Obi
 z9qaMTYNE4QQ=
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
through the conversion instead, and is refused there.  Otherwise a task
that unshared without CAP_SETFCAP could mount a tmpfs in its namespace,
write a v2 xattr on it, and have it honoured through an overlay mounted
from the initial namespace.

Tasks in the initial namespace, tasks in namespaces created by a task
with CAP_SETFCAP, and file capabilities for a root user that only exists
in namespaces within reach are not affected.  That includes everything
an unprivileged user does in its own namespaces.  The rest gets -EPERM.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 8a9d998b1897..3551ce9b046a 100644
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
@@ -671,19 +694,41 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EINVAL;
 	if (!capable_wrt_inode_uidgid(idmap, inode, CAP_SETFCAP))
 		return -EPERM;
-	if (size == XATTR_CAPS_SZ_2 && (idmap == &nop_mnt_idmap))
-		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
-			/* user is privileged, just write the v2 */
-			return size;
+	/*
+	 * A v2 xattr belongs to the root user of the filesystem's namespace,
+	 * which may be the root user of ancestors of our namespace as well.
+	 * Only write it unconverted if that root user is within reach, the
+	 * checks below handle everything else.
+	 */
+	if (size == XATTR_CAPS_SZ_2 && idmap == &nop_mnt_idmap &&
+	    ns_capable(fs_ns, CAP_SETFCAP) &&
+	    cap_root_level(make_kuid(fs_ns, 0), task_ns) >=
+	    task_ns->setfcap_level)
+		/* user is privileged, just write the v2 */
+		return size;
 
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

