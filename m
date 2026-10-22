Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694203;
	b=xtWMxVuZ7CC9XCFPBsstL69xIuEIZvTNFDp16KKGQCQFM3gws1hbl7mllxZsF6i847qX
	 xxu/7Ql0EfmxYvS7eJSFT1/WOOrc3iE6cQzoQhGx04qaXHJPJ/J/8fr2kMqgS8FGWdptD
	 bxalyiBU/Cq15qjYsIvJsCTPrg2eykS13YCOZsEg2+NNEbnpjLUgwrEE22KuVYKbAh983
	 QTWJpCL3PR/1T/CHDhrUAOq+XseTxoPHHbIXhqxyPei+Zh37TacuGhFbzSBUWF8Wkle31
	 FG4Oqh6QjPpw10A+GcWsbYQtukkzVyy/m0qmvSq8dzFGu2MlCDZfGVyZkEaBoczJe2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=rtdA4gx5VZ7RaqR6oCB1/OWC7pUugQwtuvImmW2LRwY=;
	b=I5/tt0OIdNsUlwJQAmwu0p+qrSPG87y6l69+oD1uYwsiuvZyFFiUmb6BjOCvRZO/Lp4N
	 fDPxPqFbDkf6MmpV2Q3nxka/luYJMMoHgeLIvKnFStTqm4Y2tcinAt/GT7o0hu9RyGNx5
	 AlsGy/cUAul80VQfQw01GKBCj6jIdV12YzeBaBjDCHvmJ2eCW7djnloYz3y62a/sDKAe8
	 ++eTuPNVskbHiZW870DBfAxnbpp86bU/WTTCvk/sBGfn0HfO2Duh4VHwHdO8Jb+yED5RY
	 W8fXFKurOMCSSx3R4HpL1a2BPhqGwcWRsvBJ3dNNJ+n325kaablXscai1JAbX405psQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=JzXuEEwM;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DC60A2630
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 785DC60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=JzXuEEwM
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5364648ae07so293731cf.1
        for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 11:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792694202; x=1793299002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rtdA4gx5VZ7RaqR6oCB1/OWC7pUugQwtuvImmW2LRwY=;
        b=JzXuEEwMJHVHUsoLn6PZAmToEgyPoadHiCvF96nVjvMpBf/Qos+nv0UlUWEP2cIxs7
         lXmlFRWq8o9DGsZkIhG/8HnrLwVjSbqa9ddURbHH6x4stiB6JHMqfu1BIn1e8Q2Yh82f
         37REdRICnrdQkBZUAY3al2INo6pCU0oklTH6vkQ1E5onlFMkzEGn+Yti1wAdWnDJhix7
         RG8xq0NKReK5F2MzTGU+aM+HLwdWpmUnQuvOq6mRFTrS/SPQoM56bM2x6tojoRYawF2F
         lzGIVXMahldxpa+6MoVX0VVFigHXuq5H40+7f10g6jWMgz/v9mSAksssRsA4dEe83PNY
         q8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694202; x=1793299002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtdA4gx5VZ7RaqR6oCB1/OWC7pUugQwtuvImmW2LRwY=;
        b=CPNGsYWd3upFss4WXrA+UqFLLn1I7bgDwIZsYTZWO1LzL/auN9FLEulc1gwmb5WyW3
         YaQYQkpVCBqEKGg0QPkymMD7qigWJVsAmdTAKwefeSrtXkfm82P5c9/XP0eUE7RxgVMM
         Ev5dI92HaKd4T33JUvNJVJBWyK0M4QYPeKHn7n8Bom9dToziK6TIbIfETaOqk8YsgzR5
         rEeE/NQ1PegLNxzN5pulhDAOB28hRTCO6MpAOVCzjtFaFcTOm+q3+gHhHaOaVBATkoLi
         7rZVWLGhQubxDsyeFD9mjKcZRG6OknDlX9/LTXz8H9UVFIiNPxn5vvKtqaqZSVRKE0CF
         DvBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxV9P1f4/7jo4h0nW3uPy0q7S7jvKCkIQgO3TUiM9H6+748/MjyJMXS1QX3AGTas+JfqPIDb5Ko2JQwuTKc2DW4trAYlhg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKok6o/p5RjmXGmO9P8v5oaqQhJdV3YU8cSmnPo3YEVEbJPx7GF
	zBN7zpBYQ0tb7nMhZCxtk8aQnxTwVeVQr4F+FWG4j+fFPfruqYvI1fNqQb73TPViJ/g=
X-Gm-Gg: AYBFou05j1ikTAWuyjCZc8Tqufgwd1Nb4y2G5k4GgBxVF994ApXg7I+1qvar1eWOsun
	J+B1gNO1XU8PTWavOSVFcaebtVW/Bfgjjx/d967giGqvViQnxQberHypgjE0gPBtH+DeimycLLe
	KIz5ucyJ8sttmbcfCpkZVjlsVKB9fwGSZgG1bieKjUvG4AC/0YsyMKMMnXnjAvkgGO5rWNkttZK
	Fu52730AaxbyOAgayyVjrwxMTKYMsXqSCilAnzxDtvm3qLAhQLd72dEKCJFEKtDULQPxOqS9fOT
	n5XkQpsO3uMMKBs/XDJlcmoq2Lr8DovHAsUd4MbHaA1TX1HGX64NQxAXO/3EjFj5ENnXdNXMhmb
	KIU0YKjaES3ov7qR7QLeYR7vW++yIPQMg2jB9Y81NlY5d6SdAEDdOPvMhEBVgoCDqol0HOCbR+S
	qVzkOcNvoC7JZrXW1ClQnj3Pe2654DJj/GeqcqiZTKEah6aSZ42JCteK43h4kPMcsxrOskYvGiH
	nUSYUYUy/uVOhZtZ8nXcFz1Zd/cTOrO83XKM8AUVaGLZFrsh/KzmxH/PfhymkPsJfq6L3sdGn7S
	i/gnmBCWfFOm/n4nR6E=
X-Received: by 2002:a05:622a:4885:b0:536:986f:e97e with SMTP id d75a77b69052e-5369b8c68c9mr93154871cf.63.1792694202226;
        Thu, 22 Oct 2026 11:36:42 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536ab76a446sm33092181cf.20.2026.10.22.11.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:36:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 22 Oct 2026 18:36:21 +0000
Subject: [PATCH v4 3/5] userns: check the opener and the writer before
 mapping uid 0
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
Message-Id: <20261022-b4-setfcap-userns-v4-3-88aa0ffaa08f@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792694192; l=6487;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=gou9ZlC4AH/3zuuFb+dZz8p975sbGmavF7hL2edIjO4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO27RZtp8G8yFF9TkSixWV8X4A25/eIAXEebsQAoS5oaEmqwpoLAkkzsqR1ft0aBOiHq0zpHMCU
 nPzD9fFdo9Qo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

verify_root_map() looks at the cred that opened the map file: it asks
whether it has CAP_SETFCAP over the parent, or, for an opener inside the
namespace, whether the creator had.  Two things are missing.

The writer isn't checked.  For every other privileged mapping
new_idmap_permitted() wants the capability from the opener and from the
task that calls write(), but a map that consists of the single line
"0 0 1" takes the unprivileged branch, where only the opener's euid
counts.  So an open uid_map file is a token for mapping uid 0:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  fd = open("/proc/<pid>/uid_map")
  B gets fd by inheritance
  or SCM_RIGHTS
                                    write(fd, "0 0 1")
                                      opener had CAP_SETFCAP -> allowed

And CAP_SETFCAP over the parent isn't always enough.  The parent may map
its own parent's uid 0, so its root user is the root user of ancestors
further up, and the capability has to count there too.  A task without
CAP_SETFCAP that unshared a namespace, which a privileged task then
mapped "0 0 1" for, has CAP_SETFCAP in it.  It could unshare again and
pass on uid 0 of the initial namespace one level further down.

Find the topmost namespace that shares the parent's root user with
cap_root_level(), and require that the opener and the writer both reach
that far: by ns->setfcap_level for a task in the namespace that is being
mapped, by cap_setfcap_level() for one outside it.

This only affects maps that contain uid 0 of the parent namespace.  A
write by a task without CAP_SETFCAP to a file opened by one with it, and
a map by a task whose CAP_SETFCAP stops short of the root user it passes
on, now fail with -EPERM.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h |  1 +
 kernel/user_namespace.c    | 29 +++++++++++++++++++++--------
 security/commoncap.c       | 23 +++++++++++++++++++++++
 3 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index e4199b03668b..2eaef87748e9 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -227,5 +227,6 @@ int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns);
 bool cred_setfcap_reaches(const struct cred *cred, struct user_namespace *ns,
 			  int level);
 bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns);
+int cap_root_level(kuid_t kuid, struct user_namespace *ns);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 7bd3692c2f3e..f948cf31ecdf 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -888,8 +888,9 @@ EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_sort);
  * @new_map: requested idmap
  *
  * If a process requests mapping parent uid 0 into the new ns, verify that the
- * process writing the map had the CAP_SETFCAP capability as the target process
- * will be able to write fscaps that are valid in ancestor user namespaces.
+ * process that opened the map file and the process writing the map had the
+ * CAP_SETFCAP capability as the target process will be able to write fscaps
+ * that are valid in ancestor user namespaces.
  *
  * Return: true if the mapping is allowed, false if not.
  */
@@ -897,7 +898,7 @@ static bool verify_root_map(const struct file *file,
 			    struct user_namespace *map_ns,
 			    struct uid_gid_map *new_map)
 {
-	int idx;
+	int idx, level;
 	const struct user_namespace *file_ns = file->f_cred->user_ns;
 	struct uid_gid_extent *extent0 = NULL;
 
@@ -915,24 +916,36 @@ static bool verify_root_map(const struct file *file,
 	if (!extent0)
 		return true;
 
+	/* The parent may in turn share its root user with its ancestors. */
+	level = cap_root_level(make_kuid(map_ns->parent, 0), map_ns->parent);
+
 	if (map_ns == file_ns) {
 		/* The process unshared its ns and is writing to its own
 		 * /proc/self/uid_map.  User already has full capabilites in
 		 * the new namespace.  Verify that the parent had CAP_SETFCAP
-		 * when it unshared.
+		 * when it unshared, as far up as that root user goes.
 		 * */
-		if (file_ns->setfcap_level >= file_ns->level)
+		if (file_ns->setfcap_level > level)
 			return false;
 	} else {
 		/* Process p1 is writing to uid_map of p2, who is in a child
 		 * user namespace to p1's.  Verify that the opener of the map
 		 * file has CAP_SETFCAP against the parent of the new map
-		 * namespace */
-		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
+		 * namespace, and as far up as that root user goes.
+		 */
+		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP) ||
+		    !cred_setfcap_reaches(file->f_cred, map_ns->parent, level))
 			return false;
 	}
 
-	return true;
+	/* The file may have been handed to someone else since it was opened,
+	 * so the same goes for the process that is doing the write.
+	 */
+	if (map_ns == current_user_ns())
+		return map_ns->setfcap_level <= level;
+
+	return ns_capable(map_ns->parent, CAP_SETFCAP) &&
+	       cred_setfcap_reaches(current_cred(), map_ns->parent, level);
 }
 
 /*
diff --git a/security/commoncap.c b/security/commoncap.c
index 8a9d998b1897..b06914223039 100644
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
+int cap_root_level(kuid_t kuid, struct user_namespace *ns)
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

-- 
2.55.0

