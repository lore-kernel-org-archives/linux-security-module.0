Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611436166B
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630154; cv=none; b=o6AdghEjgecJtyw4yXS3XI6IsXOrrYN0sFpoicMzdkLqTiKVH7I0wyQ+rCtEc0RD1oscwcI8orAzqH1u70mO+Oq8ubDcGvl1lvM3x5v4lJwnTI4LyFJN/OiYxeGUS2g16CJSxFsCZX8b5BBDxKk6u+VFEVOZKP9iRAr5uHE64Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630154; c=relaxed/simple;
	bh=XOhmZdaF7YO3oVy0Q127mfYQCk2+a4YqBdamo+/+bXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugqed6JZkACrvaK1Qek6vWtFeXFA7vx08+XnrjH6dDnDerb3WV25Bl0CPTHGuMj6zAAT2Nfuk7i/bOVk3rv9uf5JX2MfpKHPAL/Ye/OkcLTC266CuLX3kDC+hIMi9J8HtUMp4EjmqTtmDB7Nbg/NCihnnESsrg/KvV206VUx4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF+uul2D; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF+uul2D"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b9b190easo1637504f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630152; x=1775234952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6GNZVpZjm5xJQUilsdA8tqgDknwml6/qVABbPDsVog=;
        b=KF+uul2DmV/m55L9CaP/UUWyQmksoEj47a8a3KO9opUESYtHeFSrBAjRmJdgwYCHCa
         KhxndvNMLoZUCUXkRT5e2QKjkM+1DmNS2hQ7rD5jVPcGVXgDrds2xG7iQKSXYt6GbRTp
         +GUmFRm19dE1/Do1QqnfWa4DmOQrFv0uv02n7sG+kEm6zEh6EsX0R2QC+NrDED/lrtZO
         +jnFkrS6ueNUQtP8RyohweI9Ri46GXWqb5UxuegnFGHtr4Y/e2YfspRR9YUzYea+bcyI
         5glghY+wg2oqj8ChPHQkkefqx0MBzlMzvWgZMnbBQ0ibO7RgfW29wQ3ulCQ8LVTZnfBZ
         7X7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630152; x=1775234952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U6GNZVpZjm5xJQUilsdA8tqgDknwml6/qVABbPDsVog=;
        b=YVnfPpELBD1EurfW15dophQlvX+UKblpwyVULMwRgDJLqvdqtkwQ/ztI7446rLIecM
         8WKiBmWnvRe4poP8f/Jjz247I1UGEPEi4EtYoKd78tkVjBLeT55dQeuln88glUaT3kEc
         vArr4A0ZMpJGxnb/CEHXkKmIYpyeQ6JWOaZmUPSupHNesIFiHZhBS8bMy83I1ULW7yNz
         WHxrZ9xZZLRfVLZJWUNEi++t0f6emTDDO2OZpRNTs5+xApX+qFw0gdDoBWu3eGQm6ZOE
         hNQw8EgK/UFTIaRrJEFEJOm3gqatmfcPnCPtirucs0fAivPwxGyh9SylycICm4d6rSiY
         ZXew==
X-Forwarded-Encrypted: i=1; AJvYcCX44IVnBqvIdghsuT8zcnSYMkmv5A+RwLT4FfCbfJtN1DaUagp+qR6zDuItZrTw9Q4l8G5rRigcsWs0leuhZ0NkdRhvPWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl4R4u7PNpXOCfgPKFEd5b3FaY/rl4iyCQ89Eho7vRTaHoDt4b
	E7VTdgXE7l3V4sV5mVEcE86p0o3Lc0lJSFLQe2lRlBkGPeWgZNsqT13k
X-Gm-Gg: ATEYQzz2WrxopyE39HFuNF2G9zl6oKoDU2T1PsjuAK2USRE3u8qUnaZo2c3NxOQ6oN8
	EXAm04BJKcvXYRGZf8+CLJvaR+SV7CZEsDIaLqpf++R1exq2tJWnU6w14OlWLVzrbUGROzL5kHs
	I3Yy5hrM77f/GkQFCOrWEj4IGglQVnq67Ta0onhfcEpM3IpdRZD7kDBAcW6CCd4AycGrLwv0ScX
	/zYb70FdiZRpOOqmHsbewJE25nBYvvBtSi2lOcya7Ro9QVVIGe/a4rEBOAs6iYpkWBaljTR36OW
	HpzmRt182evalC0jU0AuouzyNCWrHae6865ADVxwFioyi12dobMx1HYryZjWoD1SHMo/pFbGbCz
	Hn/8lDAuVJnma8GtrVFDh4L1wUUFvkMdgq5mLPxkVtCqH6K3qvkj1KmWg0LYR/GpCMZoM4D7RqM
	n2yaFLSG+HjabdkgOFMtmC5glFEw4BXSTmkbxWFQJDUtASGx0g
X-Received: by 2002:a05:6000:290e:b0:439:ac8f:5db1 with SMTP id ffacd0b85a97d-43b9e98ff0emr5658246f8f.15.1774630151689;
        Fri, 27 Mar 2026 09:49:11 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919588e6sm15194195f8f.16.2026.03.27.09.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:49:11 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	kernel test robot <lkp@intel.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>,
	"Georgia Garcia" <georgia.garcia@canonical.com>
Subject: [PATCH v8 03/12] landlock: Replace union access_masks_all with helper functions
Date: Fri, 27 Mar 2026 17:48:28 +0100
Message-ID: <20260327164838.38231-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327164838.38231-1-gnoack3000@gmail.com>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Stop using a union for access_masks_all.
* Expose helper functions for intersection checks and union operations.

The memory layout of bitfields is only loosely defined by the C
standard, so our static assertion that expects a fixed size was
brittle, and it broke on some compilers when we attempted to add a
17th file system access right.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603261438.jBx2DGNe-lkp@intel.com/
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/access.h  | 21 ++++++++++++++-------
 security/landlock/cred.h    | 10 ++--------
 security/landlock/ruleset.h | 13 ++++---------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index 42c95747d7bd..277b6ed7f7bb 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -52,14 +52,21 @@ struct access_masks {
 	access_mask_t scope : LANDLOCK_NUM_SCOPE;
 };
 
-union access_masks_all {
-	struct access_masks masks;
-	u32 all;
-};
+/* Checks whether two access masks have any common bit set. */
+static inline bool access_masks_intersect(const struct access_masks a,
+					  const struct access_masks b)
+{
+	return (a.fs & b.fs) || (a.net & b.net) || (a.scope & b.scope);
+}
 
-/* Makes sure all fields are covered. */
-static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
-	      sizeof(typeof_member(union access_masks_all, all)));
+/* ORs the bits of @src into @dst. */
+static inline void access_masks_merge(struct access_masks *dst,
+				      const struct access_masks src)
+{
+	dst->fs |= src.fs;
+	dst->net |= src.net;
+	dst->scope |= src.scope;
+}
 
 /**
  * struct layer_access_masks - A boolean matrix of layers and access rights
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index f287c56b5fd4..207a6db1c086 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -123,9 +123,6 @@ landlock_get_applicable_subject(const struct cred *const cred,
 				const struct access_masks masks,
 				size_t *const handle_layer)
 {
-	const union access_masks_all masks_all = {
-		.masks = masks,
-	};
 	const struct landlock_ruleset *domain;
 	ssize_t layer_level;
 
@@ -138,11 +135,8 @@ landlock_get_applicable_subject(const struct cred *const cred,
 
 	for (layer_level = domain->num_layers - 1; layer_level >= 0;
 	     layer_level--) {
-		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
-		};
-
-		if (layer.all & masks_all.all) {
+		if (access_masks_intersect(domain->access_masks[layer_level],
+					   masks)) {
 			if (handle_layer)
 				*handle_layer = layer_level;
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 889f4b30301a..9f8b33815c2c 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -229,18 +229,13 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 static inline struct access_masks
 landlock_union_access_masks(const struct landlock_ruleset *const domain)
 {
-	union access_masks_all matches = {};
+	struct access_masks matches = {};
 	size_t layer_level;
 
-	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
-		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
-		};
+	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
+		access_masks_merge(&matches, domain->access_masks[layer_level]);
 
-		matches.all |= layer.all;
-	}
-
-	return matches.masks;
+	return matches;
 }
 
 static inline void
-- 
2.53.0

