Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424601;
	b=u9j8vKpGgmTl+0QKKtAQ4LrgqaGcZALR50eg2WgFiYN1K9PFJMD8Cnw2leqhGNSDXiIf
	 OIcdMbS8g6mEoOV7jQGNGjPgyYdBjVYmBhC0DH0onWdSO845zIOCmzkcSrKeVSwolbX9Q
	 7HVB4x88RLMrRMzFTyA7UKtHt1iWTZAqtMXshjiAh5AcfSRgjZ/DOwfJdfpUO85DRUlYh
	 m7pVFhNM1BmiRRzmtEmHIMX5dmTL1AzUd6mb1yG6TX9s/v7WrHBj74gnuHiuezxun+bzi
	 T2hieBkHxNxLJnyiqbKrGMrLf+ELzdY3FA9pHdcSK1gW10pqEpUUIuWjICE+pkOQtlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424601;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID;
	bh=xGW3FnTmdbB8uuNYE75kGhqCUP64KC7XWwkoBlt2Qmg=;
	b=cYPHxpTXo4LvpgpRdro37wKHv6K9cbqWyQCIjUd9//6Kp/JgXNVn/wXxgXhgIdZSzEoe
	 QnyNJwHCkocqwhWF7O6MNOrHTa8c0o+uBlYySVgK7uM8JBUKabQcE5VvUC2qeiJFQkDXO
	 DhvIc4mjjXkfUARDxuwcjLP401ppW3VN+418LoU9/6/eDMc/QK5YXbrUsUWRznWY5qDZq
	 /VWGdGgRWauvb58QNaEjMFvJES9a7ANtT/jsOpbrAmJM6qggc9LfKiYYuXEXHQcJ7YgVI
	 hQim55mmkf5MapHAantJv2qsPMGd4g3KcomDyLwFCz3M0KH9XH86gznyE6ymvhDQc5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cow0q8t8;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881A606A324;
	Wed, 11 Nov 2026 19:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6881A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cow0q8t8
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jPtYK012yzMljk;
	Wed, 11 Nov 2026 20:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794424597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xGW3FnTmdbB8uuNYE75kGhqCUP64KC7XWwkoBlt2Qmg=;
	b=cow0q8t8VgRdWTsNPPzjhO5EzWuDqUu2bz8qH97lUlfB9TcuGtLUlNjRW/zp0hlL6nAwUF
	5BUnKPzfV81pPm4SY7ZNKQ0CbLgJg/TV/jhUZEqx4lvrUgZmhkacaI5UlAKmeYDwAiHaft
	KLB7i5k/rFoaCOfjQHg+zrmH1T1XbB1civazwAjWa34RIA6K2ehQsKo3KWaqj0B/HjXW5T
	SFAvK9PfhGrtg8CFL8t9Wu90gd54CLr3sVPlJHcf3DwbcmJUgkxnsjqz/p/LQkro1L2Q/E
	j+PmdCTfqEd4KZBX9rTOt5Vv0v26DaZLYm6RXznrqhXhHyJ0cxmVUZ9kp06Jkw==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Casey Schaufler <casey@schaufler-ca.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] security: smack: fix typo in kernel-doc
Date: Wed, 11 Nov 2026 20:15:47 +0100
Message-ID: <20261111191548.538644-1-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: urjskrpc45qrf11y3tsscownk58ftf6z
X-MBO-RS-ID: 8e34503e0a639313ebd

Fix function name in kernel-doc, fixing:
  $ ./scripts/kernel-doc --none security/smack/smack_access.c
  Warning: security/smack/smack_access.c:593 expecting prototype for smk_import_valid_allocated_label(). Prototype was for smk_import_allocated_label() instead

Fixes: 674e2b24791c ("smack: fix bug: setting task label silently ignores input garbage")
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 security/smack/smack_access.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index fb85356266..085b75ce6d 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -582,7 +582,7 @@ int smack_populate_secattr(struct smack_known *skp)
 }
 
 /**
- * smk_import_valid_allocated_label - import a label, return the list entry
+ * smk_import_allocated_label - import a label, return the list entry
  * @smack: a text string that is a valid Smack label and may be kfree()ed.
  *         It is consumed: either becomes a part of the entry or kfree'ed.
  * @gfp: Allocation type
-- 
2.56.0

