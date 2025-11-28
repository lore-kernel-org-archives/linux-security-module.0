Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45A2AD3D;
	Fri, 28 Nov 2025 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764370004; cv=pass; b=W4wTAMI8/qnjcPXBDXnv7kH0w34uphLSMweU5KNYO2eRBXnnRokdFY7XUazECLHGbsu5RwCtHFJ5LZChQBtTFFxJwGz2gkygSCoq2wZU83V0RSlUmRSejTxaJwfiEK23Z+c4RrzjwVK7FN32xnyJ6zM2Eb5XTyz2Qz/uyyMqS0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764370004; c=relaxed/simple;
	bh=1RgAa5pl/ev6leLCDdyAALD3ZMkXi9XnUysqw6RF9nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lEF2gktT8xGpTW/oM2HA7nBkB8dR6fUzM9GuEPNJqpk/hc6BVtZX4AtWJD2qhw4J8GhWBCx87dtnjR7xVFId4v3VWo3IZRsBLQx/B9MrQvLam5nI+vEm7ZG2xbWNJoOnBFEiafMjeeZdPf8Phqzm6dlYM2EzgsZvj49tTxDId+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=m4QgxfkN; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="m4QgxfkN"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 711D08A1688;
	Fri, 28 Nov 2025 22:27:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-102-155-42.trex-nlb.outbound.svc.cluster.local [100.102.155.42])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EFAAB8A10DB;
	Fri, 28 Nov 2025 22:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1764368876;
	b=aC5OwX9HGVtdSxwdLy+WXcTLZVwzfyNWy30jKqPb2UTQKLppY3swjkVos5I8I3TRfbueXr
	jgpQjPI9k3qAH8zfH2pnBOjUDTmbumjkKD0NCWuBSipva3l6jR5QemoJ4WG9/h8S0a/R/6
	YqoXg9TfLGE9uLMw8nPV3vlcV2mYGaZty0tijbszEKC0E5XWsxgKSXI8dWrud6VvIq22ws
	OhP7imSvy8Hqnua3Jv+X5aPKRTnXzr6ySxqC18g1uiUFopbMUKiZzDVsUe/I3BwDLLXNg8
	pxiVakJD5uPstzhmeSEBjTEQmF9XlHfsbFrI7jXnBhpmVU3TJH4ATvcNi8X4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1764368876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ZLBeeAX2gePftxuXY5Annwc6Jf1P/PjYGYjwfzA/pUs=;
	b=qwuwC7V7IeSyw+k+BOcHIg7sYmHvakSfajzYmBPJPKlmQwbvsd3K2TxVkuFEcF36zWsqgK
	YWw6q4+6bMqj5dVUAV0T3pBAKNPPVYJEN5vEkKBtJ0SOzBYgFXP+N3s864sLd+5wAGlD2A
	tV0IdMRfPxGYK20/qMN3B15xckfsbk0a0HLkAMmCYuqNU+3j2xEp9h5X3ujihrkKLCeo6y
	8mkMMfX0tFuJkWTMTYfJ8Rv5oyjQi8uZOX2Xqugmt1oWKevWSPf2+QQ45BV/g4C+FjVbNv
	7RzVmGwNZoUMycW+/0rBHuENDMvGyvepD4ck47ujU+pAX50aUZPkj1bYSvmvHw==
ARC-Authentication-Results: i=1;
	rspamd-545f6844bd-dvp77;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Blushing-Arithmetic: 4e2d3e340d9a36b2_1764368876224_496475735
X-MC-Loop-Signature: 1764368876224:3109630449
X-MC-Ingress-Time: 1764368876223
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.155.42 (trex/7.1.3);
	Fri, 28 Nov 2025 22:27:56 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4dJ7Gg3XTxzyrC;
	Fri, 28 Nov 2025 14:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1764368875;
	bh=ZLBeeAX2gePftxuXY5Annwc6Jf1P/PjYGYjwfzA/pUs=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=m4QgxfkNgK51t7KlOP4goqWPZbFoph4eYeXxY7atD/VHjEz7ci7X8YxfnqZpkmYGc
	 F5ftglAZhmIiaIpLTmApEafpNME0oa0mcCrvKuYQd6MvzCXSp7fPnwvkc8B2Ew4bo/
	 ET6yDJcSXyBZ0LbfBAoci+AN4gTRpmBfv1yWF7sBJIapP98deOetXhoDRBX0aPYrMh
	 nPzhiwli28Ovlw3gIvxpXLfPA3huVTjcN+TSBAY8w9SAnIBRTrfUgDbX2rWmWJDmkI
	 3rPNf8Ifqk1j6kGotMQNrqGKtg6fzvp4yIwJKZn0ufRBGVXH6U+aDMrNgRxeqlawlD
	 CzsXkcyLNUvNw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: penguin-kernel@I-love.SAKURA.ne.jp,
	takedakn@nttdata.co.jp
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] tomoyo: Use local kmap in tomoyo_dump_page()
Date: Fri, 28 Nov 2025 14:27:47 -0800
Message-Id: <20251128222747.2174688-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the now deprecated kmap_atomic() with kmap_local_page().

The memcpy does not need atomic semantics, and the removed comment
is now stale - this patch now makes it in sync again. Last but not
least, highmem is going to be removed[0].

[0] https://lore.kernel.org/all/4ff89b72-03ff-4447-9d21-dd6a5fe1550f@app.fastmail.com/

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 security/tomoyo/domain.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 5f9ccab26e9a..90cf0e2969df 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -934,17 +934,12 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
 #endif
 	if (page != dump->page) {
 		const unsigned int offset = pos % PAGE_SIZE;
-		/*
-		 * Maybe kmap()/kunmap() should be used here.
-		 * But remove_arg_zero() uses kmap_atomic()/kunmap_atomic().
-		 * So do I.
-		 */
-		char *kaddr = kmap_atomic(page);
+		char *kaddr = kmap_local_page(page);
 
 		dump->page = page;
 		memcpy(dump->data + offset, kaddr + offset,
 		       PAGE_SIZE - offset);
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 	}
 	/* Same with put_arg_page(page) in fs/exec.c */
 #ifdef CONFIG_MMU
-- 
2.39.5

