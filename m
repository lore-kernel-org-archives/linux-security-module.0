Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43FF1F1512
	for <linux-security-module@vger.kernel.org>; Fri, 21 Mar 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552672; cv=none; b=O48h0WSF6Y/PtrVQKRomTOBbOTJeqZWdaPaluqApGsMBaOUq1dLc3w4Rn1Oz8+IJhqF/o7CngWIyv1Yah0sdgIlib9Oy0chFh7k5m3NNOkGHWSgTp7SUwaBqx72ZnmUKGwVCOlAqsvnFuJEL/r4v8p7QeNF6cDZ2cWLXpcYCZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552672; c=relaxed/simple;
	bh=zSxV7n0+Ibej/HcUkLb/Ni7Bj2XB10ovlpZxrPUW51M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8QmZ5mHGvZadEWP2vh139MH3Ol3INOPX7KQVX7eQhm5Wjftaf30aXPudSP+9qoAV3UwFhtOnlpyajT4ok7ygrCBy6UCYYFEHqaEdl+L/kpxJ87AsDptz9LGMWAGlbEWDgXf487VR0kTGaL0z/9q9wuNU3hk47WzGqSV7+flkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lzlkxGZN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lzlkxGZN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lzlkxGZN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lzlkxGZN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E308F1F805;
	Fri, 21 Mar 2025 10:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742552667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Dn2O2mmtl/xizoePRAGekbdgff6shdA/fkvJ7bqBsKI=;
	b=lzlkxGZNwo8w14o926SUBTewMCCvqlifMGei91n0KQ+C62t8Cmm3+68rC7HO5oCgCCFQwY
	SAFrHl71vOH7sDC3qWwF1rhfrMLm/TIGUi0pu7LWTn4pI3g2H7MXPxPLtV3gZOvMq9X+hf
	eFQ4snQXqav6EoFhcSYkX7za60SZkiw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742552667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Dn2O2mmtl/xizoePRAGekbdgff6shdA/fkvJ7bqBsKI=;
	b=lzlkxGZNwo8w14o926SUBTewMCCvqlifMGei91n0KQ+C62t8Cmm3+68rC7HO5oCgCCFQwY
	SAFrHl71vOH7sDC3qWwF1rhfrMLm/TIGUi0pu7LWTn4pI3g2H7MXPxPLtV3gZOvMq9X+hf
	eFQ4snQXqav6EoFhcSYkX7za60SZkiw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 527B213A2C;
	Fri, 21 Mar 2025 10:24:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +nQQEVs+3WcvLQAAD6G6ig
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
Subject: [PATCH 0/2] Allow individual features to be locked down
Date: Fri, 21 Mar 2025 12:24:19 +0200
Message-ID: <20250321102422.640271-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This simple change allows usecases where someone might want to  lock only specific
feature at a finer granularity than integrity/confidentiality levels allows.
The first likely user of this is the CoCo subsystem where certain features will be
disabled.

Nikolay Borisov (2):
  lockdown: Switch implementation to using bitmap
  lockdown/kunit: Introduce kunit tests

 security/lockdown/Kconfig         |  5 +++
 security/lockdown/Makefile        |  1 +
 security/lockdown/lockdown.c      | 24 +++++++++-----
 security/lockdown/lockdown_test.c | 55 +++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 8 deletions(-)
 create mode 100644 security/lockdown/lockdown_test.c

--
2.43.0

