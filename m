Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D596825A320
	for <linux-security-module@vger.kernel.org>; Mon, 28 Jul 2025 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753701351; cv=none; b=AGDv5nSSamqR3tYAaYSdiwIGcpPfNGSjsMzZ4PQHffGkw8q4BY+9aMWeI5QJgQJ6UkzIXsUBh291v6NJUHgVTWWqrn4w5+lY7/ciusfJmx8Ws5HibvmsbVIIXILcX7E+kWQzxYTfTVPIsli6IOU31zYrcksnrTY2CDkR1PK28Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753701351; c=relaxed/simple;
	bh=LoR8Qe1OcISSqRYy+kwwG9v9txQCqrLE7FQmtOtv4u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XdnpRswGH9H+bCEaT7ZahwAy47RrAtecVf32XLP+AA6i1ojKzT4jYgM/yjRWjEh4Gb5CRtTBjgdrTj/E5DP8rZecLgLFFKTlKM0PnL8X/DumVtS07zRGCfIBkLr0+AvwE+zV+5KH2NmtuuCxbqVtng6VFH2EZngLj5MyiyqL8oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WyZw2efq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WyZw2efq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WyZw2efq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WyZw2efq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7282A1FB45;
	Mon, 28 Jul 2025 11:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753701334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsEIW97hNDziQTk5D+L84bIA7JFzMCdRBZosIOFA4+A=;
	b=WyZw2efqrlS+gdhzknof16M3vBfRm7r26yt00o+h57ZCxW7PUIvNzO9DhYPYgMo6UcnbP9
	2UoK8elk1yo8MYmB3eBPTHrqrlO/yyiRU92uAT1L0K+l1IR2eySSuLiTHVYrLhRNfcH1Vq
	0ai6ItT1nVhW2kGMDZhxLYFdGIVcoTE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753701334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsEIW97hNDziQTk5D+L84bIA7JFzMCdRBZosIOFA4+A=;
	b=WyZw2efqrlS+gdhzknof16M3vBfRm7r26yt00o+h57ZCxW7PUIvNzO9DhYPYgMo6UcnbP9
	2UoK8elk1yo8MYmB3eBPTHrqrlO/yyiRU92uAT1L0K+l1IR2eySSuLiTHVYrLhRNfcH1Vq
	0ai6ItT1nVhW2kGMDZhxLYFdGIVcoTE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D232613A43;
	Mon, 28 Jul 2025 11:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iMr6L9Vbh2i6UQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 28 Jul 2025 11:15:33 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	jmorris@namei.org,
	dan.j.williams@intel.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 3/3] lockdown: Use snprintf in lockdown_read
Date: Mon, 28 Jul 2025 14:15:17 +0300
Message-Id: <20250728111517.134116-4-nik.borisov@suse.com>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Since individual features are now locked down separately ensure that if
the printing code is change to list them a buffer overrun won't be
introduced.  As per Serge's recommendation switch from using sprintf to
using snprintf and return EINVAL in case longer than 80 char string hasi
to be printed.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 security/lockdown/lockdown.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 412184121279..ed1dde41d7d3 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -112,11 +112,19 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,

 		if (lockdown_reasons[level]) {
 			const char *label = lockdown_reasons[level];
+			int ret = 0;
+			int write_len = 80-offset;
+

 			if (test_bit(level, kernel_locked_down))
-				offset += sprintf(temp+offset, "[%s] ", label);
+				ret = snprintf(temp+offset, write_len, "[%s] ", label);
 			else
-				offset += sprintf(temp+offset, "%s ", label);
+				ret = snprintf(temp+offset, write_len, "%s ", label);
+
+			if (ret < 0 || ret >= write_len)
+				return -ENOMEM;
+
+			offset += ret;
 		}
 	}

--
2.34.1

