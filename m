Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732737472F
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074259; cv=none; b=bR3cj33lXC/FA5NvuuLfn3qupyTSdsqoB1/b8De7Mg0j1+Nd/x142Rm0DgrGgGv1rww2L/QTZUOk00yrpM6eYD6cbUDw9Z+Dwjbced+gpOaFaQLDbPXYkoqs+UDyigGxwuG0l+VOeHoigfUScp9VZJP3DKRk5DBLV11DkTSzAWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074259; c=relaxed/simple;
	bh=79DnwxJFzJS6ztuiCswAItKY/iEYoA/hB5xT9+mHBVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hhPGdA2Ss/EmeaqXWdmp2clw1O3DanTN6yoReSGt78OKddOZG4AsCilPQs8KydxiBCU57s/cCttS1ADBe//ZWrlzdkYkUkm8EFuVQhPoYHegdgOzsmoewmgTs3r2YUnzXbFzDkrd0kP+SMbbmHiusAAWwFX9rNeWXhWBhXoOFA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frYluLQZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frYluLQZ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45efa80e0afso4961389f8f.2
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jun 2026 23:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781074257; x=1781679057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y/bLIEy6KRuoctCkoU9/pMoqja9vj+0u1Pq617vGiJU=;
        b=frYluLQZzpCw9Qj/omMLQTkeKDWA4SMnJEtf5l215JOPpOQV2iTX0ieWjG5q/47url
         ZJu3UffCYf9M6rrmyvf8EYF2eQSCoWQbRZu2Y0AxZ7a8Lcc99Klty7BLxu87G2OgoewP
         huH8o+9oxy7HsDwtce46voYMOSpQOfqxcIt5XF0uBU4CXHKgvGe7B+NO9HvWhwcusbhx
         6mh/pyblwobPdgzpv4VuMWwTNQjMsRWTZT/1J8xeZbFq/+Bo1SSNFflXfKxk6GKgoEtW
         fC1CKednRHA3GaittscWbT37SY9hzqADCcDgNNmF1SqQu5+DiuNZuf6Hl9O0rX6xsR9H
         qs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781074257; x=1781679057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/bLIEy6KRuoctCkoU9/pMoqja9vj+0u1Pq617vGiJU=;
        b=MRUOG1OBrPjY97zutnKkPKf2OYnyX7BL8roXhHzcI3Z1S5rKXCLkn/GdR8DX150dI6
         QVCE88VQH7Talm8g7oMEvHAGyg9lZFJ00fr0xvC4JTUf8DMDghfWM5cHxyDkdjjtXLn+
         OXeQLURTBt8Y7A7BKrZN7IXKrHd48Qa48Edr78j4Rhgner1TvQfrKWgfP5YpMLeZ3u82
         /SgLz5PVgkzyZMAKV7mWW3EY90ZWt23PW98WHQZiQb/JctWfW1rcw7lCwClKYJe9axcJ
         VBqPWoRSXEYhEiUBAcEeuTl+whBBs11DgEl1LsrMGULI0GbfbgIHEkvIANIU19kx4AXF
         A0cQ==
X-Forwarded-Encrypted: i=1; AFNElJ97gSYiGm2LlmupgVFQaW6BvlNy2HN2ttVX1I3iMkYzNZeco7gZFyZsKkZ0fkvsZwkUIrKt+5GnnbyzEgM+sB81RAMcFH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKiFoMTkVWgVrdU+CFI36ywIZCzENBU1jpHnb9Wslswu+DW9A5
	CTBEw2TSUGPTQffqZveLicDmxTntWPnXzrkm5MnW5BrNWSRsOA39eFs=
X-Gm-Gg: Acq92OFW1VEbwXoy7s9AkoADzS967+HPSZXe2ZJYPKnJ07pLGX8z+OSqmQqMSHbcVIm
	KLwzOD7mKuIVMQ1aKvRA7fUZbO3fn/qQL3JeZkca793ZyI6ATNX9eJjpkb/mo/Z6siKKJSLWN6w
	sBkpbDtwDys4fHIKDU2YguBpIWxPNr6B9ikMgz8yfFnko3koMczIyQnGXEoI1GlwLYnNBGbcSf9
	o9h1yBJtK/sSgXfWPmmG3XGxp99Xbur/dXouDPKqUmT6hvXPVqKFrxUD+krIDwgtSwOigvmBgFe
	R7MtZhK6Zl7vSvn+/Vub5htacG8Q+yMIWM0EQ2pWLXpZy27jCZW6QyYZTtQpCBUu8UiTBwauCOu
	abJAuVlecAeavvxEp/5fo+EWSun8xf6Ev8GRCVutv6h0Z8jri/pCYy6uaScHWD7mg6/LTuqeBEt
	7XrZyQ37vTqtZ5Vu3iNh8XWKSrKoTKenbtZZUWH3V+KjqE6wbkkZXA5x3aRO35LaM9NvEGD7Vib
	xlYta3w2UuucSpC0eTpbIWWZP09hM0b9w/aiRayNMY=
X-Received: by 2002:a5d:4b41:0:b0:45e:f3b2:122a with SMTP id ffacd0b85a97d-46030652fcemr28960085f8f.26.1781074256955;
        Tue, 09 Jun 2026 23:50:56 -0700 (PDT)
Received: from hp-ubuntu.. ([105.158.214.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm69539946f8f.9.2026.06.09.23.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:50:56 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kees@kernel.org,
	vbabka@kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH v2] keys: prevent slab cache merging for key_jar
Date: Wed, 10 Jun 2026 07:50:52 +0100
Message-ID: <20260610065052.9120-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SLAB_NO_MERGE to key_jar to prevent the allocator from merging it
with other similarly-sized caches. This hardens struct key isolation by
ensuring dedicated slab pages.

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 3bbdde778631..592b65cf8539 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -1275,7 +1275,7 @@ void __init key_init(void)
 {
 	/* allocate a slab in which we can store keys */
 	key_jar = kmem_cache_create("key_jar", sizeof(struct key),
-			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
+			0, SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_NO_MERGE, NULL);
 
 	/* add the special key types */
 	list_add_tail(&key_type_keyring.link, &key_types_list);
-- 
2.43.0

