Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFC31C8606
	for <linux-security-module@vger.kernel.org>; Mon, 28 Jul 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753701336; cv=none; b=nG8ckSg8bTz4N0GswIO1TbSCk3KwLMfqieRGDI3LRMADGczvyvhKE2RnOUnSuOJNehP+mL5D60uByhBNGf4YIzWxpxp2S00pPcgORLWhNUjG75fb4zp9lCRZej3ITZqr0HBFuWkpKrq295Rc7IImpalZ04zSnFRhmU+mkQUYTKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753701336; c=relaxed/simple;
	bh=DQPe96cC/AU6GxtBFB12tAZOSwfyWPAvJdw6uCw9DYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L0FnXl1GIBhZESeQ/OwoN1FuNCyFf9s0C/4auzboxzyXObSvWEcpCd+UpvL9NlTmGNkLsTiMSXUNeLG6hpBrAdck08aPPFRt/0v79wkhaZaWaizHan7i2QbuJi8oY+kO6aDdWvnvnR7vqc8Wvn9cxxa1mq3nGQnhGp9SX179+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NAv2U+QC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NAv2U+QC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NAv2U+QC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NAv2U+QC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17CB31FB3A;
	Mon, 28 Jul 2025 11:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753701333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnnLl4FOeHbRc0wsnVwpr+g5jOOm1MpyAQ7c4TsW3/c=;
	b=NAv2U+QCOj71djKwiV+05/JByjUItf+4shCUhazmYH1hnyUdlMWMAlJLEmHfqNRjqS0hRn
	XgskA9XRon18ciehS7qrNtXwd2D/lPUARcO57BXG0CXTb2py92AOevJ5njYt38B7NOxUfn
	BFouxXCEQ1qSmiyUXZ7sYQQz4SbAsiI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753701333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnnLl4FOeHbRc0wsnVwpr+g5jOOm1MpyAQ7c4TsW3/c=;
	b=NAv2U+QCOj71djKwiV+05/JByjUItf+4shCUhazmYH1hnyUdlMWMAlJLEmHfqNRjqS0hRn
	XgskA9XRon18ciehS7qrNtXwd2D/lPUARcO57BXG0CXTb2py92AOevJ5njYt38B7NOxUfn
	BFouxXCEQ1qSmiyUXZ7sYQQz4SbAsiI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82A3D13A43;
	Mon, 28 Jul 2025 11:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ELKjHNRbh2i6UQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 28 Jul 2025 11:15:32 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	jmorris@namei.org,
	dan.j.williams@intel.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 1/3] lockdown: Switch implementation to using bitmap
Date: Mon, 28 Jul 2025 14:15:15 +0300
Message-Id: <20250728111517.134116-2-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728111517.134116-1-nik.borisov@suse.com>
References: <20250728111517.134116-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

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
2.34.1

