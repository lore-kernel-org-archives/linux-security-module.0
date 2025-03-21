Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00501FFC7B
	for <linux-security-module@vger.kernel.org>; Fri, 21 Mar 2025 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552678; cv=none; b=X8WcQgHe3a46ZcClmAj9XPN1fUFomBW66IcBGNPFMfDt3msXi2zANLDnhN0ZXsdxBVygpnWKrj91SeUGbndpqGmPPeBX46TF8r5C8+Q9MlSgHgQqu0FHoteRAJebI6XdzEAOtTXzWqk9dvh4kfm+0swOapitRHsGkyspQFNcwH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552678; c=relaxed/simple;
	bh=A/rBJDhv1XB34siYUPkh+pGlsLysi6s+22W0AZ77jJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEOq3vlDFlIybc/p9UGd3OSDlVnM5IugFWpwXIYZNoiTqHTdwvhGycMwER6ZHbEx53rQ1dou4hQwNARGhcjpvyetjJUHyx7gKJZxehldfu3pMJwxW8997IjmWihh4laDLTEoT00kK6uY3Nlw8fDtbPWtSVi4TxANv8vIwjtEiKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NXNPrr1U; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NXNPrr1U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NXNPrr1U";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NXNPrr1U"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 857E31FB99;
	Fri, 21 Mar 2025 10:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742552668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvAEo4UohrjBSNtMLm9Rxs56hJ4BwIGsQOlr5elEyEE=;
	b=NXNPrr1UQjC5HlnBga1V0HYjqq72+uveDL8eKtsIMwZg51d6iAb0uRZvQa2F5JYiNGfcrF
	rym60vM2o8FDKcV26eqTAwMuPyoyhuL0n/95DSjV99YrS8+MViLwHOP/dq3p7JQwmU4in2
	ceHZvq9qMaxoX2zupavhBlxqH+HtxHU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742552668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvAEo4UohrjBSNtMLm9Rxs56hJ4BwIGsQOlr5elEyEE=;
	b=NXNPrr1UQjC5HlnBga1V0HYjqq72+uveDL8eKtsIMwZg51d6iAb0uRZvQa2F5JYiNGfcrF
	rym60vM2o8FDKcV26eqTAwMuPyoyhuL0n/95DSjV99YrS8+MViLwHOP/dq3p7JQwmU4in2
	ceHZvq9qMaxoX2zupavhBlxqH+HtxHU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0331813A68;
	Fri, 21 Mar 2025 10:24:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WCReOVs+3WcvLQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Fri, 21 Mar 2025 10:24:27 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	serge@hallyn.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kirill.shutemov@linux.intel.com,
	linux-coco@lists.linux.dev,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 1/2] lockdown: Switch implementation to using bitmap
Date: Fri, 21 Mar 2025 12:24:20 +0200
Message-ID: <20250321102422.640271-2-nik.borisov@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321102422.640271-1-nik.borisov@suse.com>
References: <20250321102422.640271-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Tracking the lockdown at the depth granularity rather than at the
individual is somewhat inflexible as it provides an "all or nothing"
approach. Instead there are use cases where it  will be useful to be
able to lockdown individual features - TDX for example wants to disable
access to just /dev/mem.

To accommodate this use case switch the internal implementation to using
a bitmap so that individual lockdown features can be turned on. At the
same time retain the existing semantic where
INTEGRITY_MAX/CONFIDENTIALITY_MAX are treated as wildcards meaning "lock
everything below me".

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 security/lockdown/lockdown.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index cf83afa1d879..5014d18c423f 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -10,12 +10,13 @@
  * 2 of the Licence, or (at your option) any later version.
  */
 
+#include <linux/bitmap.h>
 #include <linux/security.h>
 #include <linux/export.h>
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
-static enum lockdown_reason kernel_locked_down;
+static DECLARE_BITMAP(kernel_locked_down, LOCKDOWN_CONFIDENTIALITY_MAX);
 
 static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
 						 LOCKDOWN_INTEGRITY_MAX,
@@ -26,10 +27,15 @@ static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
  */
 static int lock_kernel_down(const char *where, enum lockdown_reason level)
 {
-	if (kernel_locked_down >= level)
-		return -EPERM;
 
-	kernel_locked_down = level;
+	if (level > LOCKDOWN_CONFIDENTIALITY_MAX)
+		return -EINVAL;
+
+	if (level == LOCKDOWN_INTEGRITY_MAX || level == LOCKDOWN_CONFIDENTIALITY_MAX)
+		bitmap_set(kernel_locked_down, 1, level);
+	else
+		bitmap_set(kernel_locked_down, level, 1);
+
 	pr_notice("Kernel is locked down from %s; see man kernel_lockdown.7\n",
 		  where);
 	return 0;
@@ -62,13 +68,12 @@ static int lockdown_is_locked_down(enum lockdown_reason what)
 		 "Invalid lockdown reason"))
 		return -EPERM;
 
-	if (kernel_locked_down >= what) {
+	if (test_bit(what, kernel_locked_down)) {
 		if (lockdown_reasons[what])
 			pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
 				  current->comm, lockdown_reasons[what]);
 		return -EPERM;
 	}
-
 	return 0;
 }
 
@@ -105,7 +110,7 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
 		if (lockdown_reasons[level]) {
 			const char *label = lockdown_reasons[level];
 
-			if (kernel_locked_down == level)
+			if (test_bit(level, kernel_locked_down))
 				offset += sprintf(temp+offset, "[%s] ", label);
 			else
 				offset += sprintf(temp+offset, "%s ", label);
-- 
2.43.0

