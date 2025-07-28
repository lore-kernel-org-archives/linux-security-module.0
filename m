Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABED14A82
	for <linux-security-module@vger.kernel.org>; Mon, 28 Jul 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753701336; cv=none; b=is1OmZ3bByX+R8KM/4FVc2Z0ZBGLxmLVWRdx3SuJIZDL6zuGLKK50w+Ei/FEeGpWL3LQnIrbWIa8Ud+1pSAA3yLyRdp9LmzUH5CFxPFP5ZVB3A9mZgkoJilWKQ1JSrJBGyLShKEGkE9/XrwWQ1dSZvpa0xTKAIVeCGJYigZCLH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753701336; c=relaxed/simple;
	bh=93sNPM/4s7K4kReFvCaQy4ZZmkhC719pcrI8HtxHqLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DenXDFM051ei9kDhW/1/V+AWbtUqBqBwVMLNRIgnv81gB86sTf6hmrrBwi/sA+DrPEuKVFxFaBqoQT4efcMP/GG5/UTutPUTMQBPNKUVtvplhcPXAvmHQzCycW/sI3dbwIiVx+SQZ042FifFreNUxxx9FCTHTjTH5qqY/jupXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DD2LLyLi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DD2LLyLi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DD2LLyLi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DD2LLyLi"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6AF7221257;
	Mon, 28 Jul 2025 11:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753701332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hFYhmpVt0lVo4yEgbgZDlEu20ZMZ3BrJkIkAc1VGUQY=;
	b=DD2LLyLizr3Ki8NoHz2nPwKO8TO1ANXJ3dWAimui+tfOCg5ePhKWWKbB3Clpg9BglR/oDg
	nt7twFv4Y6bDVvw46RVVF4NvMnDgA+uBFhfsV543B9/MChuEGlSZSaUoGDzdLeV6NEW/Gv
	/coVLkc9S/GPMVqrzgGKPfK8UkDg3BI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DD2LLyLi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753701332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hFYhmpVt0lVo4yEgbgZDlEu20ZMZ3BrJkIkAc1VGUQY=;
	b=DD2LLyLizr3Ki8NoHz2nPwKO8TO1ANXJ3dWAimui+tfOCg5ePhKWWKbB3Clpg9BglR/oDg
	nt7twFv4Y6bDVvw46RVVF4NvMnDgA+uBFhfsV543B9/MChuEGlSZSaUoGDzdLeV6NEW/Gv
	/coVLkc9S/GPMVqrzgGKPfK8UkDg3BI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF260138A5;
	Mon, 28 Jul 2025 11:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AthDL9Nbh2i6UQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 28 Jul 2025 11:15:31 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	jmorris@namei.org,
	dan.j.williams@intel.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 0/3] Allow individual features to be locked down
Date: Mon, 28 Jul 2025 14:15:14 +0300
Message-Id: <20250728111517.134116-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6AF7221257
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

This simple change allows usecases where someone might want to  lock only specific
feature at a finer granularity than integrity/confidentiality levels allows.
The first likely user of this is the CoCo subsystem where certain features will be
disabled.

Changes since v1:
 * Added Patch 3 to incoroporate Serge's hardening suggestion

Nikolay Borisov (3):
  lockdown: Switch implementation to using bitmap
  lockdown/kunit: Introduce kunit tests
  lockdown: Use snprintf in lockdown_read

 security/lockdown/Kconfig         |  5 +++
 security/lockdown/Makefile        |  1 +
 security/lockdown/lockdown.c      | 36 +++++++++++++++------
 security/lockdown/lockdown_test.c | 54 +++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 10 deletions(-)
 create mode 100644 security/lockdown/lockdown_test.c

--
2.34.1

