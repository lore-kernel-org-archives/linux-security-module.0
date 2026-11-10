Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342295;
	b=L9YXbxHQdSiUKFDPcQcVIWswcJAF5MrVGiENxYicTMb0KGAlUmSDAYYpfBeWBOeyJjIU
	 7q9W5pOfal4TauvThklAhehOR1aimE4nFFYFI8x+cMSJWQzia/SR4T2C028eA26dCkLdz
	 ESkktZZBC0Pa9UcJoxaUeKADYKR+I4S9kRTKQ5hGtGLciZRhduSmFkLoYdHzAKbYk2CsG
	 XjCuJvSzCQ35MVyL8LpkfMxyGE8W5saKwCh14Exc+EAh4HOU/KLYb5iMaje6U4a5bAKOn
	 /D194zocpY7OHTEy5T+pbDRlY76EX8AmsfFerlOBr2tWZpMPlVWUpfwrhC0nzDn7mRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342295;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=dtQBQsLXA/8DRdTm5gm8W/QZSwqaFp+c1ZQKm9GtCgE=;
	b=aiPjy5eL3NzwksfDkzeG/GfXtloO1e6oG4HmIQ2bi6r+2wG4taUuIwLkJ64O8vrRHcES
	 tcL9J5CSyIFF8wfN/k/dEx6A933BDEoofW9bhubQJvtVvQNyRVmvqNo4GYVOYn1xjPzDy
	 gSRgQtbcGCWjIj80MB0pTwLW6B7y5hcLDEJWonNcyfSfqoFHQkDNS2CV3AI1vrKdw2VwK
	 TAIgNuTzrj7mLBOhx8xhf6oTyoFKPMK0SpKNsWFIm0oXe4xtVtJOnqBFSgiZu2r96I3Tb
	 9SBDEbEdUVmsPGd+YC3q6XW2tqQWf2sLAHJViY8prIO8S27dEfKvmbu4H+sECMsywQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=NBkm4ljE;
	arc=none smtp.remote-ip=45.157.188.14
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083C606A32A
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F083C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=NBkm4ljE
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJ6T5CnpzJg3;
	Tue, 10 Nov 2026 21:24:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342289;
	bh=dtQBQsLXA/8DRdTm5gm8W/QZSwqaFp+c1ZQKm9GtCgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBkm4ljEH55q0mZ2ImjQcErIdLPtbr/dDkniCa+E9yd44yEsE2yUsZgrR/y53j5EB
	 vNS+KIsH052IB09ZlJX08Af8I2yVnjnQivUPxeHQYPtBt5pTrQ/TbmU/XcGu5GRduQ
	 amjO2eKxkGot61nERtb8vU+MILk3Jtmd9RjQ0jZE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jPJ6S4xhlzs5Q;
	Tue, 10 Nov 2026 21:24:48 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 3/6] landlock: Mediate CAP_SETPCAP for inheritable capabilities
Date: Tue, 10 Nov 2026 21:24:31 +0100
Message-ID: <20261110202436.2408244-4-mic@digikod.net>
In-Reply-To: <20261110202436.2408244-1-mic@digikod.net>
References: <20261110202436.2408244-1-mic@digikod.net>
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

A process in a domain that denies CAP_SETPCAP could still add
capabilities outside of its permitted set to its inheritable set with
capset(2), if it held CAP_SETPCAP.  cap_capset() checks CAP_SETPCAP with
cap_capable() in cap_inh_is_capped(), so the check never reaches
hook_capable().  Through file inheritable capabilities, such a set can
grant new permitted capabilities on execve() when no_new_privs is not
set, which is possible for a domain enforced by a task holding
CAP_SYS_ADMIN.

Add a Landlock capset hook that checks CAP_SETPCAP against the domain
under the same condition as cap_capset().  As with the mmap_addr hook,
LSMs implement their own policy in this hook: SELinux checks capset with
its own permission.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Reported-by: Ada Smith <adasmithgt@gmail.com>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/cap.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/security/landlock/cap.c b/security/landlock/cap.c
index 10e1ca772b9c..c89e8d76db8c 100644
--- a/security/landlock/cap.c
+++ b/security/landlock/cap.c
@@ -91,6 +91,35 @@ static int hook_capable(const struct cred *cred, struct user_namespace *ns,
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
+ * cap_capset() requires CAP_SETPCAP to add inheritable capabilities that are
+ * not in the old permitted set, but calls cap_capable() directly, which skips
+ * hook_capable().  Check the same condition against the domain.  commoncap runs
+ * first, so this only sees requests that commoncap allowed.  capset(2) discards
+ * @new if this hook fails, so nothing is committed.
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
@@ -113,6 +142,7 @@ static int hook_mmap_addr(unsigned long addr)
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capable, hook_capable),
+	LSM_HOOK_INIT(capset, hook_capset),
 	LSM_HOOK_INIT(mmap_addr, hook_mmap_addr),
 };
 
-- 
2.56.0

