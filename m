Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013545;
	b=npYUQ9RnbQBh9c+IDhbTPiqq25YoQoUlM+Cl3Op5srZ7qcE3+v88OmIkU3bFOXkplFma
	 2BZC4pGw1mPKDZdd4/aB9Q5cU+yORvZ9zmuIeQhxaN5gQb4imcBrYYsFc+euZy5x97Dxf
	 c7BSjCv2ZryWOJgiQwTQSUTv80nFd3mlCEeSuI28am23gjxQJHfN2ivJliE7FLIBA9vPz
	 RnSfoDfeGefoA52AQb1qD89mzstzO+6CJcNo5r3TitGkSBWvqeshiZd81Z++pY9wSDDsN
	 8jqhRVLt+JqhY5y8k/IE3ZLA7pCvv9R/j2oZ9eEX8s/1p9nciaQeAVuORlev+yOSXzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013545;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=oq2Cd1yFf18VwmOtkNPlAlhRiU3WYkqjK5hmN0xUvYU=;
	b=CtiyXjn4nLYZWqVTXCs4gfP5hzKWVwpLSoQSmWZ+XxzJGtWW2fB1oHTH1atHM7Qg+CRW
	 zCodXzgaItAqHEvhqc0JQzCjqO4J3W8Riy37CmmCgzMzCt+E27flAFfhyAsAg2348je6p
	 upiMZbx33cUl4EjEqMexRb+nUa3gExzN4m7KlD/0jv64hRZRO5pqSULZ864Z3kIQvcyy3
	 u2U10z98bbvFHa/xtHM8A5qJkv8yGvnkMRIS3jkSjc3a8geYyJCVomSIraT/TxrQbK/o+
	 IN9ItYWj+QnRVNOKO8nemP5HMZIFVmhE1UKvZSz9JeIqtBc8vuiRzFuoEHI/eWCqWZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=bqm1zwis;
	arc=none smtp.remote-ip=84.16.66.172
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF511606A325
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF511606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=bqm1zwis
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV4M968WMzD6m;
	Wed, 18 Nov 2026 15:52:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795013541;
	bh=oq2Cd1yFf18VwmOtkNPlAlhRiU3WYkqjK5hmN0xUvYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bqm1zwisoguijpLPOlNZxGQiQWFJ/5GYwfA5I0b/Kc/VZMuzA7OE4a86XNVl12c97
	 I4p6qan+hUBjFsz99ONfj7qvkPulGTFY6WJnaeQ7+0Ns6MjqQYeve4Q1sLJhw9VSd9
	 HWTFl71imFlDxsvRhvlmDHg+vjDxi/xzCyDY2TTA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jV4M84tHkzcMm;
	Wed, 18 Nov 2026 15:52:20 +0100 (CET)
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
Subject: [PATCH v3 1/6] landlock: Factor out capability denial checks
Date: Wed, 18 Nov 2026 15:52:05 +0100
Message-ID: <20261118145217.2551053-2-mic@digikod.net>
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

commoncap also makes capability decisions from LSM hooks other than
capable, and the following commits add Landlock counterparts for them.
Move the check and its denial logging from hook_capable() into
check_cap() so that these hooks share it.

No functional change.

Cc: Günther Noack <gnoack@google.com>
Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
Reviewed-by: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20261117101157.2520463-2-mic@digikod.net
- Shorten the commit message.
- Add Günther Noack's Reviewed-by.

Changes since v1:
https://patch.msgid.link/20261110202436.2408244-2-mic@digikod.net
- Add Serge Hallyn's Acked-by.
---
 security/landlock/cap.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/security/landlock/cap.c b/security/landlock/cap.c
index b4f491b09baa..fa59118e3486 100644
--- a/security/landlock/cap.c
+++ b/security/landlock/cap.c
@@ -24,25 +24,21 @@ static const struct access_masks cap_permission = {
 };
 
 /**
- * hook_capable - Deny capability use for Landlock-sandboxed processes
+ * check_cap - Check a capability use against the domain of @cred
  *
  * @cred: Credentials being checked.
- * @ns: Target user namespace (intentionally ignored; policy depends on the
- *      acting credentials and @cap, not namespace ownership).
  * @cap: Capability number (CAP_*).
  * @opts: Capability check options.  CAP_OPT_NOAUDIT skips the denial record:
  *        no audit record, no trace event, and no denial count.
  *
  * Pure bitmask check: denies the capability if it is not in the layer's allowed
- * set.  This hook is purely restrictive: commoncap is registered with
- * LSM_ORDER_FIRST so cap_capable() always runs first, which means Landlock can
- * deny capabilities that commoncap would allow, but never grant capabilities
- * that commoncap denied.
+ * set.  It does not check that @cred holds @cap: only call it for a capability
+ * that commoncap already granted.
  *
  * Return: 0 if allowed, -EPERM if capability use is denied.
  */
-static int hook_capable(const struct cred *cred, struct user_namespace *ns,
-			int cap, unsigned int opts)
+static int check_cap(const struct cred *const cred, const int cap,
+		     const unsigned int opts)
 {
 	const struct landlock_cred_security *subject;
 	size_t denied_layer;
@@ -72,6 +68,28 @@ static int hook_capable(const struct cred *cred, struct user_namespace *ns,
 	return -EPERM;
 }
 
+/**
+ * hook_capable - Deny capability use for Landlock-sandboxed processes
+ *
+ * @cred: Credentials being checked.
+ * @ns: Target user namespace (intentionally ignored; policy depends on the
+ *      acting credentials and @cap, not namespace ownership).
+ * @cap: Capability number (CAP_*).
+ * @opts: Capability check options, see check_cap().
+ *
+ * This hook is purely restrictive: commoncap is registered with LSM_ORDER_FIRST
+ * so cap_capable() always runs first, which means Landlock can deny
+ * capabilities that commoncap would allow, but never grant capabilities that
+ * commoncap denied.
+ *
+ * Return: 0 if allowed, -EPERM if capability use is denied.
+ */
+static int hook_capable(const struct cred *cred, struct user_namespace *ns,
+			int cap, unsigned int opts)
+{
+	return check_cap(cred, cap, opts);
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capable, hook_capable),
 };
-- 
2.56.0

