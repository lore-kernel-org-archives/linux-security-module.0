Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDCD2BEFF6
	for <linux-security-module@vger.kernel.org>; Sun,  9 Aug 2026 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786285823; cv=none; b=L1oCOT1tt+uG4EaPCCuEghCniu5R4YATDksEgJhyYNY5fCwU8kZYV9uiyy37xwidUKg9QjWC7tT/HLY/JUEuB5fAViYxrNxmr/uDGrF+4brM6PPd/c2SajDUozNEAk3YUDNBPGoPahdcSyPMAmzgpxku9PVrspoIO5kZQ2nR9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786285823; c=relaxed/simple;
	bh=GgGQjPsX+yQZSZW8eaE9FrEmKScuZDm9zykCeNuo3iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMI2k+JgCyER/ZhTFvD9m99vN95EcfT7LPwKNZGRxAKEHmWFU7bstpi5joV3v882EnCvGQJ+yOzSgr2zCZZzRtgI1VBV0bmN9GmA4Dkl10dfmEOjmXh7Id9j6eVZuqMpd+jBoVai300PyfbBEuudEF/FnXCNGooq8e2QQdSsKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=GGlROlOh; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="GGlROlOh"
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C9A9A3F290
	for <linux-security-module@vger.kernel.org>; Sun,  9 Aug 2026 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786285811;
	bh=ryrs5UQkPZgUuMMheNYAMmmTUebD55JOYiWxoS1X3rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=GGlROlOhit6K9MnS1hhMqTdjSQeL8SSfaClIf1Koost++xHDRFvIUNaQrnocrc9Ct
	 xq3yA5sLpjyrPwBMcFmgLIPWiOs7ZmKLYT6I/DebwozQ9FKnkkgSpVX4yfra84m+Ym
	 nTTLUKolZ+ArDkC5z2ix239doXHoGzz8aoLr1V5eK0saa+vjGrxYuvSlRwH0kiGApI
	 4am3c2l5JVgl+oj5VQZwX6mcR2BIivhAyTUkuzINCyqyrQI1gZ2+pm5T49VX/cb+sM
	 HDTgk3oGcgS973DEfGpRsaHHY98huh4vItvsYW0XNX7pqNxNYW8zomiSyRpVecrs/Y
	 X0SVWKDk2Aa258Dqff9KayrxzY08fw5Qk5b7kctb6kywuzSrWqHEM7kPKzlT8n+Bjk
	 /Kx2RHQxdkLIcIGQPiyxvu1QPHee8eDAflvSMPH/el3S6RBwsdiueLfZCfb19vE3B7
	 dac2g2b6mbLT3llmwExEb7yJY1l8rhaZ6r64WYrHYM0We5aYKOHQZgjyw67p1T3r9n
	 Nmrj7HFgC0gp79K1lm7DMXtDruzvTEcGBF9crvIIzOctNn1AnRhK3wgn7m9aqdWsu5
	 8OLOsrLAdqw+OvLfxvx6NO0wncRJKkfxrLZ2cmjP2fesb8bEHDn2R37FV9Z6u40vdo
	 R+HQKgMqNoRmufUlCtswyMMQ=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4956c1655c3so6035435e9.0
        for <linux-security-module@vger.kernel.org>; Sun, 09 Aug 2026 07:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786285811; x=1786890611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryrs5UQkPZgUuMMheNYAMmmTUebD55JOYiWxoS1X3rc=;
        b=DFvuonOki7dAiujOW0+VMovcmyfF9kBfqouKsIzVahLt1CScav5c/FcjFewZeIKa4p
         likBNnuftGy8P9YoeCsCJU+ynLtPST43nxW5oT1eUznXg24OAPTdjKlMJVjKO11R6Ewg
         tdgIda9OPvdJ9euaFViYDqletSIgpredxuuLEcSXSme+hDTmDpMmpaXqxmBAahUU+GMM
         hY/BLCZESw1gpzCxCv+OOugtC7kRlYu2a4ef3rZxQEWZzJNI8KHdxlvh7WdUY5MHUreo
         OMjX301fcTGo08sJy/MP5kkIaGapR5ZWTatUAVMIVvNwuA0pv9KocTvoOWLi3hBbQnjR
         mtTA==
X-Forwarded-Encrypted: i=1; AHgh+RpvKz4/NN+hNrH51NlYSo8EiqexiFSMCRNRhk58gcgYRNglDwP1Ky8i3f9pO/0dHNL/RmfWWoyl2tFbbNRd33BW9+uqcDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0kE/ElsMbaL1JdO2xPpi+U9wUnP5iQxVjnEZmQ374vxLnGmIJ
	fIqWRx9B/AW26cOI9y/ZJz/HWEJhQpvJD5VwXlovhrdAY1ewzC2q+xFhe3UakbgpK+krQ2ENva2
	bijRrlpEm3CA1HZSVitkKLwWc3ttCUvyTX+VqCc1yPnH8gTtPncp+crmbpYNztGWVqDqrc0nuMg
	Tq0iPOmIhogAqDPgbForKNLnjUYA==
X-Gm-Gg: AR+sD11Rn5llINc2U2qAszKhzuAmveHrWMOFQ4A0YCH4Alr0geKanC4gPYolS7GojOK
	Y65WdPG7ybp7qws2XaB6TqTbL/0WS3teuxhGc7HdsjniCctQOYsqsPwbFXwIzF65W8CTqhFasd3
	bvSjotX23GAQzp6xRSzrlaNIV0XhxqpWPUyjE56QmNhxeU6hAeB8fVgD6Cczg+PsTVy1nSFuEQ2
	Ipxcv+531F9xHPImHnqdUJ0jno/ey1pKoetlbr5965ovbezAWw0UMTwFIx6wma3q4ytfh24U0FC
	ZYznov7TkK64yxHzBXgLw7QHp6aqfCm4iovKJCVHmK8+WYl9kKEifd+RRKbqfBYvH+ZPmj9mC72
	MuRXBxCwuTkmhzbHwuEBkbqqcZ6sFJAQUYTl1rQKotLe6rQSCoqzM9JJ7rUR7ATouHkgXfEUCTQ
	KY54qNi5Gle82YC1v4/amLVTy+
X-Received: by 2002:a05:600c:3b9b:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4994e7ba85fmr470133905e9.9.1786285810731;
        Sun, 09 Aug 2026 07:30:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3b9b:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4994e7ba85fmr470133295e9.9.1786285810273;
        Sun, 09 Aug 2026 07:30:10 -0700 (PDT)
Received: from t-14 (2a01cb0008832300d6ffb79ddafcf3ca.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:d6ff:b79d:dafc:f3ca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4813ccea399sm8659386f8f.13.2026.08.09.07.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 07:30:09 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: John Johansen <john.johansen@canonical.com>
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH] apparmor: fix integer overflow in verify_tags() bounds check
Date: Sun,  9 Aug 2026 16:29:45 +0200
Message-ID: <20260809142947.548440-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

verify_tags() validates the tagset table unpacked from a policy blob.
For each set it reads a count and checks that advancing the index by
that count stays inside sets.table[]:

	u32 cnt = tags->sets.table[i];

	if (i+cnt >= tags->sets.size) {

i, cnt and sets.size are all u32, so i+cnt is evaluated modulo 2^32.
sets.table[] is filled by unpack_tagsets() with aa_unpack_u32(), so
every entry is a raw unbounded 32-bit word taken from the policy blob,
and verify_tags() is the function that is supposed to validate it.  A
count close to U32_MAX makes the sum wrap to a small value, the guard
passes, and the inner loop then walks sets.table[++i] past the end of
the kcalloc(size, sizeof(u32)) allocation.

Note that sets.size is bounded by 65535, because unpack_tagsets() reads
it with aa_unpack_array() as a u16, so the wrap cannot be reached by
growing the table; it is reached purely through the attacker-supplied
count.

With sets.size = 2 and sets.table = { 0, 0xffffffff }:

  i = 0: cnt = 0, guard 0 + 0 >= 2 is false, inner loop does not run
  i = 1: cnt = 0xffffffff, guard (1 + 0xffffffff) mod 2^32 == 0 >= 2 is
         false, so the guard is bypassed and the inner loop reads
         sets.table[2] -- one element past a two element allocation

The walk continues until an out-of-bounds value happens to be >=
hdrs.size or the access faults, so a crafted policy yields an
out-of-bounds read on the policy load path
(aa_replace_profiles -> aa_unpack -> unpack_policydb -> unpack_tags ->
verify_tags).  unpack_tags() runs before the perms and DFA tables are
unpacked, so no other table needs to be well formed to reach it.

Policy load is gated by aa_may_manage_policy(), which checks
CAP_MAC_ADMIN relative to the subject's own user namespace rather than
the init user namespace, so with the default
unprivileged_userns_apparmor_policy=1 the path is reachable from an
unprivileged task in a matched-level nested namespace, not only by a
globally privileged one.

Perform the addition in u64 so that it cannot wrap, restoring the
intended i + cnt < sets.size guarantee.

Fixes: 3d28e2397af7 ("apparmor: add support loading per permission tagging")
Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index d9dcff1..15b5e92 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -730,7 +730,7 @@ static bool verify_tags(struct aa_tags_struct *tags, const char **info)
 		/* count followed by count indexes into hdrs */
 		u32 cnt = tags->sets.table[i];
 
-		if (i+cnt >= tags->sets.size) {
+		if ((u64)i + cnt >= tags->sets.size) {
 			AA_DEBUG(DEBUG_UNPACK,
 				 "tagset too large %d+%d > sets.table[%d]",
 				 i, cnt, tags->sets.size);
-- 
2.43.0

