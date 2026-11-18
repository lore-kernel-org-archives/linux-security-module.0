Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013552;
	b=JUnl052QEKFnmsiqJFWiRkKJe/Y6AuFFe3Jci1Qn2lhTbk+nbN8j56am/hvcZB/+dv85
	 hZcipJcgfDdahywNqU/7JdmIc5pmkY5wgp913LDPHBsTLulQPekURbi7JeDiF4OK+2lnO
	 ompnp+FNorMXDxOXqYqylg6EkCeJAqBWF10Ex2BNC5x6bgiL4YAzRIL8amFyi4ITvs+5o
	 StUSsP0olY9mBys7OfGIh4p/Auks1Oc8nlzWjRMsoWo8bH6nGx4kG4uGNf48TsUe4DJxy
	 v5a99L666lWKr1NKGLxT7q6cBBrvc/4mHEZRO2YDNIYrnTmgRPtPoMjg4xzyPO366Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013552;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=zsBSk8e6/oJkNLn1IpP5IhtxydcFdIX1KS4HiB1G6KE=;
	b=dxekF37FWVsx9uFceBw+U/PVimse10eCT7Q08yvqg3I2U/QvjIju44fcBruAXfwVInLS
	 n9yRTwpW7C4sXsC/Q7XKLn5hG7FJSK2ZiZtXxiBHcXQhAlCTDA3BG5zQi/l9r23JXUEQ7
	 xFxlP+Tey3JTt2Abct3lz2az9ZyS3+57p52v6XUiRBNyGWkOCAt8Tl/Ok7k7KpbO3V6Sx
	 Ox2hQyVfSPoQvki2JZrfmtWf91b/gxU6qJl6kpnHDo1VWndSqjeDWTxih1RYcVZ7uX+HO
	 zy54Xzl6rwWZpTqMzg1DoiYF4LJ4cfY3Q6ugccSjHbSor14IW2X69Ok9F8rQKqK93EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=LpkpSkR6;
	arc=none smtp.remote-ip=185.125.25.9
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5160A2630
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DD5160A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=LpkpSkR6
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV4MF0VYNzvKM;
	Wed, 18 Nov 2026 15:52:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795013544;
	bh=zsBSk8e6/oJkNLn1IpP5IhtxydcFdIX1KS4HiB1G6KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpkpSkR6tcqCTea4pKrBlm5GqRev244ELMGAWibEyMmjzTTvd3K7zKeKLztonIoGB
	 Lnwl1NdXU+F+x9t4aZP+WwiCOppiO/h2481+wTZJhipRXmGJ6wJx3DsqUdZ7WGsAHU
	 bGT8WvK4n7ZhJOqqC+2EsruNZbNH6mDOl7CG+Kdk=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jV4MC4jNDzcHb;
	Wed, 18 Nov 2026 15:52:23 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Serge Hallyn <sergeh@kernel.org>,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 3/6] landlock: Mediate CAP_SETPCAP for inheritable capabilities
Date: Wed, 18 Nov 2026 15:52:07 +0100
Message-ID: <20261118145217.2551053-4-mic@digikod.net>
In-Reply-To: <20261118145217.2551053-1-mic@digikod.net>
References: <20261118145217.2551053-1-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

cap_capset() checks CAP_SETPCAP with cap_capable() (through
cap_inh_is_capped()), which skips the capable hook, so a domain denying
CAP_SETPCAP cannot prevent adding capabilities outside of the old
inheritable and permitted sets to the inheritable set.  Without
no_new_privs (possible when a task with CAP_SYS_ADMIN enforced the
domain), file inheritable capabilities can then grant permitted
capabilities on execve().

Add a Landlock capset hook that checks CAP_SETPCAP against the domain
under the same condition, as SELinux checks its own setcap permission in
this hook.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
Reviewed-by: Günther Noack <gnoack@google.com>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20261117101157.2520463-4-mic@digikod.net
- Describe the hook's condition from cap_capset()'s point of view in its
  comment (suggested by Günther Noack).
- Shorten the commit message.
- Add Günther Noack's Reviewed-by.

Changes since v1:
https://patch.msgid.link/20261110202436.2408244-4-mic@digikod.net
- Add Serge Hallyn's Acked-by.
---
 security/landlock/cap.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/security/landlock/cap.c b/security/landlock/cap.c
index 10e1ca772b9c..cdb95b979eaa 100644
--- a/security/landlock/cap.c
+++ b/security/landlock/cap.c
@@ -91,6 +91,36 @@ static int hook_capable(const struct cred *cred, struct user_namespace *ns,
 	return check_cap(cred, cap, opts);
 }
 
+/**
+ * hook_capset - Restrict inheritable capability changes
+ *
+ * @new: New credentials (unused).
+ * @old: Current credentials.
+ * @effective: New effective set (unused).
+ * @inheritable: New inheritable set.
+ * @permitted: New permitted set (unused).
+ *
+ * cap_capset() denies a new inheritable set that is not a subset of the old
+ * inheritable and permitted sets, unless cap_inh_is_capped() finds CAP_SETPCAP.
+ * This check uses cap_capable(), which skips hook_capable().  commoncap runs
+ * first, so such a set reaching this hook means that commoncap granted
+ * CAP_SETPCAP: check it against the domain.  capset(2) discards @new if this
+ * hook fails, so nothing is committed.
+ *
+ * Return: 0 if allowed, -EPERM if CAP_SETPCAP use is denied.
+ */
+static int hook_capset(struct cred *new, const struct cred *old,
+		       const kernel_cap_t *effective,
+		       const kernel_cap_t *inheritable,
+		       const kernel_cap_t *permitted)
+{
+	if (cap_issubset(*inheritable,
+			 cap_combine(old->cap_inheritable, old->cap_permitted)))
+		return 0;
+
+	return check_cap(old, CAP_SETPCAP, CAP_OPT_NONE);
+}
+
 /**
  * hook_mmap_addr - Restrict mappings below dac_mmap_min_addr
  *
@@ -113,6 +143,7 @@ static int hook_mmap_addr(unsigned long addr)
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capable, hook_capable),
+	LSM_HOOK_INIT(capset, hook_capset),
 	LSM_HOOK_INIT(mmap_addr, hook_mmap_addr),
 };
 
-- 
2.56.0

