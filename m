Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910340;
	b=UBqKyN9zH2avWl4HERLnYAY4q0yaGwiOOqOnLZZjWEvuL0E5LDogOWsThAS7CWAHkkMP
	 oKjrrY69BFHSnhtoMIdzYzL1aJZeyQgMdnth0goElnVgMOTwKMDX5WErWEKjDsspml/kG
	 lDZyJ83aH1hbsWB7ADGzEvtj09nbGcAxhxIlYd7aohihsXrxJyYGyCpjNzzWIik3NHE70
	 Q0y/kRrMS+B2v+C5Ze9GZxMB9jeuIcb8V0LSWFsczkm71LFxhO5W4ONbFuaDfD7KGW6YW
	 6bwnFgVNgKIr3OEjeyW336X2Lx9FHikq8sqz1RtKb8GgXXj4DPNy9tNZEoxXgdpRO6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910340;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=C7ne1k0orVWRjmlFW4sVuF7FBtjjR/e6ipSJaB4Qbc0=;
	b=eo3GgjHzn+lCCxisQaumbyxM15qibeVSk746KqwrTZTf3ZaVvGX3eldMkryZbBi/x/1O
	 CHkjWjSsBhHaRWp5zH2/ApvzL6auql6RcORicmLXrdV2kfMWImtCnjEi58ri2zXYkdGzi
	 p6HIwq8hR9KKOQDeM22Vz5pmcfUSmrforUW/9jTjocJWZJkDeu0KxqFC8NR5Mz/wV0r9I
	 qpp5eJ4ijx559MDvi8kgIuuFCl20kOexN8VPULYqPocojAHSIssOdnBX/iY9BtoSx4cM7
	 Kw6kd/ouL4oMi7+InVQDGDRdyPR5+nGpaVnqix3YFVMVzD8rOkoLMyE9zfKbWuRGxaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=trRiSzlf;
	arc=none smtp.remote-ip=83.166.143.173
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B45606A333
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78B45606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=trRiSzlf
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLBM6Qw0zPdy;
	Tue, 17 Nov 2026 11:12:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910331;
	bh=C7ne1k0orVWRjmlFW4sVuF7FBtjjR/e6ipSJaB4Qbc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trRiSzlfkkmC1+s6k/SkbWdOl5wgO/e7i56k3Qp8FD3Cwd1Ebaucw+Zgv0uDeU/f1
	 kpFe+vb1+Xv74YMnUGm82zGG7i8vwjOyIJLuL1L4qAVVr+pyHLOoHSFi1d5lSQuF2O
	 mTG2PXtHfvFzrWFn1X/4+JBnky2UYTvZ6VkcEUbY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jTLBL2X0NzF5p;
	Tue, 17 Nov 2026 11:12:10 +0100 (CET)
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
Subject: [PATCH v2 3/6] landlock: Mediate CAP_SETPCAP for inheritable capabilities
Date: Tue, 17 Nov 2026 11:11:53 +0100
Message-ID: <20261117101157.2520463-4-mic@digikod.net>
In-Reply-To: <20261117101157.2520463-1-mic@digikod.net>
References: <20261117101157.2520463-1-mic@digikod.net>
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
Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://patch.msgid.link/20261110202436.2408244-4-mic@digikod.net
- Add Serge Hallyn's Acked-by.
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

