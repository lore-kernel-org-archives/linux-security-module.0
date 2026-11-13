Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601443;
	b=BxZev2QHttEbsoYOLmW6AhaV3xxfe138+GZugpqSifHCXZkS/6q9HyyY1wpicEWX+Ifr
	 6UbJiD5q8jQEIemK1rhfFUHqq/40AROqgEFJLFjRNHLfhjQbbkt2jFyrpVFigrNOdV9Qt
	 OzrleYgqHBqVxgd8ZkEhvhQZjTeUwC6TLggIkfGSwfvDOMz/X8dDbxaQiN/gXFSDCs9Od
	 Tadj4PELt4YbnPw4lOsvXiImfHa3WlkWjxPKAD7dxi1DEEhmUUWW2bRXvaV6yejr08VGR
	 1DDUS+qHItabLQi3jaz/nzaf/z5+uutJ5pwiwJKU4GhjdDLKj8WiKg3c8HZ242RIfqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Dnbd2yEJPOTWVHoma+CfFfSv19z03dGOV1zOyksuwzQ=;
	b=wUbwEue3yJPxFC+utmO/KAXgBvT9lGu4geDed4FWJPtHg23wog79wBV/tU60wMwM16vx
	 ANkT1oYUmS4DW2DE89v98xqouJcXewL0ektPA3P6tjFS9q4cryUSnkA3wv4XivYO1ww8u
	 zsV3A1IBfLgimMHGWLEPghh5yQJHUVK8QYYjJdscXzES0yGfo9emnWLUaDpGhsrxXyYRn
	 r2DtCvrFWGpw0qm6gsQ80Jk6W11juFUZEqZHWh6aAT/y7Oo8iNhyUmTRwiBabRzypGKE8
	 y/bwRBX2If7GNehzZLBgmqIHPwUig+ksK9k71mjHwdbZhha/72rwsbhYsJW7Ehoycng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KFXLIUtM;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8B606A8AB
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DD8B606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KFXLIUtM
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so11134025e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601441; x=1795206241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dnbd2yEJPOTWVHoma+CfFfSv19z03dGOV1zOyksuwzQ=;
        b=KFXLIUtM6AdBysF0IcYKp2OWu/zq9uLZ05/8bsUylIrbi4Ystq3ItVsjnhScR6FdOF
         /kqebKcQZWDtzSf/QEJzaC4nbIiXFJLLq0bKCXxvSpD8G5+/TJpKMEoJtFNP2lc93/zF
         a1irRLp7AfT9LoXvJNeuiuARJMYRZNTm8COdkp6t3BX6I3XumkxIiIFQydZIXTSkHIwQ
         Zg5duJMJuxueAxmOfS+fA0IKqPtI7f1LGG8G1x8y2pn4g+pwsIhM66BXIC/tWigP1ld3
         1dKuycJgtp8J7WFOa5IhUJ1tJ5BLtMCatqpeJp58gFekHt3lDxgNcwroy9iSJsLANAGc
         WRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601441; x=1795206241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dnbd2yEJPOTWVHoma+CfFfSv19z03dGOV1zOyksuwzQ=;
        b=V5rXGF9YPI36vH67h0PDIltjlmMhYsGiXqYQKrJbSMTSP+LrfMADeNNjsyJnf0G4Y2
         LkDtILYLdWLOxXdoUWa+zI7jaGNJo7QdjrQB9dtzIuqmMt/axrOLTLhywlKw3CftVNy6
         ToyYuVIy0EbNA2Q0POVJDuhxBAZG1fO+R4HGCC0eJp4/KVIpVjJsv5qA9+Mq+ZqHiiwC
         /ebviHGbC0m+4YUbjIKxWsRxIQeDc4K3WPxnI4IX1xvppGw5b/XPNhXG9h6JACedUR9K
         asBkbzcs7q4uS3ll5NcGI8kP4AQ7iqfBUPHxEAeVTvQfjb3Pber8zVtHdBVRQOlrgRzn
         xRAQ==
X-Forwarded-Encrypted: i=1; AL+hErGy1LfhQ0XEEJ9Vb68a2UJNl4V6Ce3MjOFXREp1cXwfpw3eBwRwNuetgyDXuSfpeypBCvzJdjLKVNnl2a9fa6osTVpuqDY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sL2SK+oNIBc9PrEsAYDNenQ0z1J3S4WeQmhygq5ytpb5CC8Nu
	NFOnr+3eAeTBBCTsYoPFxQHNCGSDI2yMEiQbXjFLKTZ0P52HhiUy4gdm
X-Gm-Gg: AYBFou1KUJTkCDcRiXP0nYdxqIXnle6fuQcbl3Ux7xqss5SP2xnef28sw9MrRSpi+cx
	4AnM6K5qQ3tpfLEjdSZsDbukrueDnFlkddVC2f9pOiOhObGAuwO/sg/W4etUUHFTdqu3wH3Je0u
	0JijCOT0ztMN9zq3EGiShiGh5gkjfpQKseTiO+slS9BctYPR/c35pTMDpxFobp1hkMqaHdL9ktd
	rQz1VN4MW7JpUUxmGAhy76BvjYGJfVHnY6eepAJIawN0QBf1wRh3dFrRq6hqJtn3010ahyIF+JS
	atUfwC23Z43h2zJK9oLwxPpBOOoeZrQHasoIO0gcrGLk1Ms2eCbVg7dhhVXDVbrhIuym3x7qiaf
	akwUdIwW3ya3NItlals/0BLmCS/7Zc5ZLXHSqjjOL/M78HWGDdmfXJ0uF8sqBA+6jkZl3eUKr9q
	rk7X6PM7duExDSISZCwyitEPhOmMG++XdU4GJUHWTVARqNqBhkEYPyXlVTV/0AFn4yUpBw+7AYB
	hLQMEUzY4QVOjeu1IZVyPxMQ9TI31ryXF8cfXPkEVmBBYCu7/JayB6POt2LueZqdW/+eQWYAo+K
	3ReE6m4mJwn+CS0gBr9GRWFfLo2gf/G27fBnj7Tz+EjESdNOZ/7g+g==
X-Received: by 2002:a7b:ce9a:0:b0:4a2:392:9de2 with SMTP id 5b1f17b1804b1-4bb55a911aemr55130455e9.28.1794601440992;
        Fri, 13 Nov 2026 12:24:00 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5667a8aesm59505405e9.1.2026.11.13.12.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:24:00 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Fri, 13 Nov 2026 21:23:26 +0100
Subject: [PATCH v3 4/5] landlock: Simplify landlock_get_fs_access_mask()
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-b4-landlock-refer-nonfs-layer-v3-4-02d7e42bcdfd@gmail.com>
References: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
In-Reply-To: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
 Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

Return the handled FS access mask as it is, instead of artificially
adding LANDLOCK_ACCESS_FS_REFER to it.

Since commit d6c7cf84a24f ("landlock: Simplify initially denied access
rights"), the merge operation already bakes the initially denied
access rights (LANDLOCK_ACCESS_FS_REFER) into the a layer's handled FS
access rights. -- They don't need to be added explicitly any more.

No functional change.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/domain.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index d9ebf4857fce..812c324cb6ef 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -262,16 +262,12 @@ static inline access_mask_t
 landlock_get_fs_access_mask(const struct landlock_domain *const domain,
 			    const u16 layer_level)
 {
-	access_mask_t handled = domain->layers[layer_level].handled.fs;
-
 	/*
-	 * Handles all initially denied by default access rights, but only for
-	 * layers handling filesystem accesses.
+	 * Initially denied by default access rights are already included for
+	 * layers handling filesystem accesses, see
+	 * landlock_upgrade_handled_layer_config().
 	 */
-	if (handled)
-		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
-
-	return handled;
+	return domain->layers[layer_level].handled.fs;
 }
 
 static inline access_mask_t

-- 
2.56.1

