Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310263B388C
	for <linux-security-module@vger.kernel.org>; Sat,  6 Jun 2026 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780755969; cv=none; b=fn+VlMEox8x0lfFHi6iwavPgIUjspt5yzqY46VbZH3u3tZCQlBg/YRZIJuycJn04nlNJstSLl2l+PVVVtot88kDDuUWO6S9kXU0A/HwQHdBarm1doOU1w/9ItvAK8H6n9NPm56wMDMT2Z/3xBVdmT+cb6yBvTtXKmL4XcL+eYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780755969; c=relaxed/simple;
	bh=+hyM4gk1hqjvyfZgMjW1YVTkHIHEHreAZGzkhudju4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+iObn8YuWzhsHemIMGcOT6dAKcus2faZLwYNF6zeXD8Z1RlFHMOc1N4ulacsWkGnbg6/YmM5mvHij5aNVjwyPkPdQpeSrck1acdYKKadX8SuwSuqBPBVrGxwaOoSfOd4KF5tbWAds7gmuWoOU0KyBi4b3frFqT9HzfP7eT/krI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bgujt8eh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bgujt8eh"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso1325932f8f.0
        for <linux-security-module@vger.kernel.org>; Sat, 06 Jun 2026 07:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780755966; x=1781360766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi3D5Ovx/vc/M3F2YJZvJdLo/rPpgsVFqrneVPAyiLg=;
        b=Bgujt8eh/e1ASUydDqvSJl5iCcB0vX11xXdNpKXH7ikVYSzxurj5OIHEnrj9TIyE8J
         1Sy/ycHlGOFxILB4MUhYdI/axIWzAQcBLkgW1iZYVW7lqGVP55hpJ9DucLWGwIPTpHM8
         o9cmaKeUBzq/DjdKB9my5e6ca8dsJghNkMyun11VdgVnxFcMn2QIpxNZ5b2q9FMEiX+4
         qelNJRb0JZLYzHGLclBMU8sXuymVAIsimuQE1vXpVuVqGIVrQO/0+L7XhoLgxKw5ZrOi
         N31eMkIDiWfOy8BmctKxAzr+rCTHmtnNsgJpxdTPXqLwsSmSyjAoidnI1pAZORLw+VH1
         RsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780755966; x=1781360766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mi3D5Ovx/vc/M3F2YJZvJdLo/rPpgsVFqrneVPAyiLg=;
        b=rRhBsE0O2xlQFr6+1R29kEMKlJ689eXjGX5sxsAIGYbjo6s5uckUo3lsjg6V7EJ575
         +vFR+6JHmVgnK/8Y+xiSgKXTKYA6lyPqMCfr9ntb7LbbzFgfkhltsTdpmDLdbJkEcel9
         6dCPfa3NwUJQ24LKgOrpt1a7LBtN8iw5udGnMhmN4EttSp3e5wEYm6JJD2kLlaqwGX4t
         Qxfb+ntjdsWWk7Paa4t707MMk8zus/yTlZoIuQmMX3O/vfvni5SQGJhYGrFTwuO5FZBB
         +T5IdZclvDiH829B29v91+OVkIWbx6LCxbPPsjpq4Yd3KM/9PbNT2t8IiGdEixdbwhSa
         uP1A==
X-Forwarded-Encrypted: i=1; AFNElJ/fp38Sm4rXvlq5x0afY3TIZmyJNLSxUTCzz0943X0I8dsNnO+oX4JS/TREUCnx2wRTS69ZTJbZ7gQ14JC8Z5OGGWiVQEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1xVdVoLvNf6mbDJL9bjNvfWJnkEvkE8bEfWZUWPPIPlAaKc1A
	QOpqVXAz+k+UQGqt5M+2RUlVzXJR1s+X5lb9yq5FgaX4yyMNmSlbg3o=
X-Gm-Gg: Acq92OHIXBvJFeYnyX2RjSZwrtOQ19waiipChgsCTfKwqeqylvuEy1STdJn2HT8rWyW
	mPttL+ZzM3WpfafvduW7HEk9OddoFri1nhXJz6dsJuxnUG1GMHy0RbvHZ5K+IytONgU1W+ueNLK
	OfyhZ2JAV0C1YrBsfHSupbtpbXJspr9Rwk8N85H3wRzjxhq7D/b8XsOwQW1Le7/RBbop6XgnlP6
	IfEEmIsqZ31vkJ/rSjEVuNDPNuq00VZj7woE6r9/F0pZ9YLWajNx4MpcqWBrRLKgqI9qxsa7/DS
	SmvIyd+vgkZ/8oopGbqnGjP2ESQEAV64D+pP6H2ZEqbOaw4b+7+1RwY4ybTuQ4rVE/DINeuoJmd
	KdOFQ591/oNxf+yNtTrZsav7FKlyMb7BAiccZXoIAv1BpLcFoPWvc7wrfHqq7itu8zTUQDumbUX
	wJXwEG1w4u1klocKNubtaVJ9dRD4JWrZoHkaH3DXu/5oylOgRW3qd/3ELfG15lbM6IzbWrnpWhZ
	N7Gu7jc8n5pnGy729jJuIw+aGRhdDBSomfuThp6mg==
X-Received: by 2002:a5d:54cc:0:b0:45e:ea9b:edfb with SMTP id ffacd0b85a97d-46030766c2amr9776459f8f.39.1780755966236;
        Sat, 06 Jun 2026 07:26:06 -0700 (PDT)
Received: from hp-ubuntu.. ([196.119.187.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344762sm37699842f8f.23.2026.06.06.07.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 07:26:05 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kees Cook <kees@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH] cred: prevent slab cache merging for cred_jar
Date: Sat,  6 Jun 2026 15:25:58 +0100
Message-ID: <20260606142558.13809-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cred_jar slab cache holds struct cred objects, which contain
process credentials: uid, gid, euid, egid, and capability sets.
Overwriting any of these fields is sufficient for privilege escalation.

On a default Ubuntu 6.17.0-23-generic system, cred_jar (named "cred"
in sysfs) has 2 aliases, meaning 2 unrelated object types share its
slab pages (object_size=184, objs_per_slab=42).

Cross-cache heap exploitation relies on slab cache merging to achieve
type confusion between unrelated kernel objects. CVE-2022-29582
demonstrates this technique: an io_uring use-after-free is leveraged
across cache boundaries through page-level reallocation, ultimately
achieving root. struct cred is a primary target in this class of
attacks due to the direct privilege escalation that results from
corrupting any of its identity or capability fields.

Add SLAB_NO_MERGE to ensure cred_jar receives dedicated slab pages,
so that freed credential slots can only be reallocated as struct cred
objects. The memory overhead is minimal: one struct cred exists per
task, and with 42 objects per slab page, the cost of dedicated pages
is negligible. There is zero performance impact on the allocation
hot path.

This follows the precedent set by skbuff_head_cache (net/core/skbuff.c)
and key_jar (security/keys/key.c) which use SLAB_NO_MERGE for similar
isolation requirements.

Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 kernel/cred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index 9676965c0981..0e4ee60a5acd 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -557,7 +557,7 @@ void __init cred_init(void)
 {
 	/* allocate a slab in which we can store credentials */
 	cred_jar = KMEM_CACHE(cred,
-			      SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
+			      SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT | SLAB_NO_MERGE);
 }
 
 /**
-- 
2.43.0

