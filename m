Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE02F14AD24
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298105; cv=none; b=g5KvhFI/CodNO8KzxX8mJvTEX5UlNTugQVvZCBFfiS/bkwjWBw9klU3OIs5aK1G/lTV5sl1pO3HYq1WTQwD7ws5uHqGGhHXUi8+4z/jiphhOo+qtHGlds85fHn1iCTEEim4UAAEUcaMAN4zIdWAmBYjlaaVBgoqvNM7O5H90yao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298105; c=relaxed/simple;
	bh=m9OmoTUzfpMvAwin1ArDTIz0XOZzaCmeXFA3csU6Psw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prYnTi0l85uK3ocbixA79GJ1yYOahaFDLQnj3XO3EnDAXZwCjVVJyxNtb5h9mIizfWIKCxWye11S9otZ8XGeU83drNeRNUnuledvVeDdl65X2rmfPXUjJ0gOxEjoidpTmrdMgyS3+WC6JQDzal7MV1+uN/Qo9Uh726xTeLTNRv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHKKDO5R; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHKKDO5R"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-537a399e06dso421089e87.1
        for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727298101; x=1727902901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmv37fnnTbqMq8tpntF+COQErJm1qReD7+e8s13/jOk=;
        b=fHKKDO5RyBZgsnqr3etcA61fQ7IgFoDS2KcPavlYUwT2K6OpmdKsDqU77XxoCWU5Va
         JINu6epWRPTmoxC87t2m37rwuRquFY0EC0/6mqUyqKhTmeJUcyaz6VKkT8neYQSBmywP
         qgkwbvhup0uo+7EAbROYcC3IK+xs/M1BzXSKDdSNW1Gye5OPNjMpfNzGU/u9SOW0DOyL
         BNS1ts40hR9pchyBw873gD7mPjMJ62rmsvekXV9Ee5ercdTExvx7ynFLVybno9iIv1Qc
         KsPRGVxyri/hMa/wllF2VRbppvDel9xKgN3gAqe+8JNwpVX3OVC3HZQdhpXrqICYg6gC
         4c8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727298101; x=1727902901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmv37fnnTbqMq8tpntF+COQErJm1qReD7+e8s13/jOk=;
        b=gv4jAHsk2WNxXV9Q/n4qjC1DfF5da+s65jw/246m94Kc537RvpWAccoiYdi//ehrIl
         BQQz0twwxkjo4wjgEDNA9ideyLL6eS8dxBnWljxlNMKSRc9m18UxZLSsuSTcFPS6Wkvd
         UiiY01PqCPb+YzN/Q8nqp4njb+LLVyHxPu9iWLrFLXX6J4xvHr4dDX7zC4bmZ1Auyt6y
         1FmVFrm/LzqyhrTR86Xp/NHuVLS1CZVKJqCQGMeNbFDAZk5U6Xw9aYHzu6IDpy0yFFED
         J9KjqjuKB/bVOfeAzf9leadS174Y0rD2yX/gbOXrhLw3yRBWmpFIIJtLbNRAxi3vzdRH
         wr7w==
X-Gm-Message-State: AOJu0YxG+eP0gvNXP2Gah/MuAUgSnt3OfDqsrnhm8/lk9NoBmbkpeXkU
	INklMi4qU6IwSXbpJ5KxSWXb8ZnYE4L4GDktvqGvNwELIV/Ye3wy55CP8Jds5v8=
X-Google-Smtp-Source: AGHT+IGVzeSzpntRhL0+hxiMjSwpa94HiG/7J1qXSVCVxchp9AK0h8cDEhMbXQFFZq0535valosDKA==
X-Received: by 2002:a05:6512:114f:b0:536:7a88:616b with SMTP id 2adb3069b0e04-53877531995mr2623526e87.26.1727298101273;
        Wed, 25 Sep 2024 14:01:41 -0700 (PDT)
Received: from localhost ([82.144.39.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf496bb0sm2338093a12.28.2024.09.25.14.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:01:40 -0700 (PDT)
From: luca.boccassi@gmail.com
To: linux-security-module@vger.kernel.org
Cc: wufan@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v3 2/2] ipe: also reject policy updates with the same version
Date: Wed, 25 Sep 2024 23:01:34 +0200
Message-Id: <20240925210134.530989-2-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240925210134.530989-1-luca.boccassi@gmail.com>
References: <20240925210134.530989-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <bluca@debian.org>

Currently IPE accepts an update that has the same version as the policy
being updated, but it doesn't make it a no-op nor it checks that the
old and new policyes are the same. So it is possible to change the
content of a policy, without changing its version. This is very
confusing from userspace when managing policies.
Instead change the update logic to reject updates that have the same
version with ESTALE, as that is much clearer and intuitive behaviour.

Signed-off-by: Luca Boccassi <bluca@debian.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
v2: also update documentation
v3: fix typo in documentation

 Documentation/admin-guide/LSM/ipe.rst | 2 +-
 security/ipe/policy.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index 47323494d119..f93a467db628 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -269,7 +269,7 @@ in the kernel. This file is write-only and accepts a PKCS#7 signed
 policy. Two checks will always be performed on this policy: First, the
 ``policy_names`` must match with the updated version and the existing
 version. Second the updated policy must have a policy version greater than
-or equal to the currently-running version. This is to prevent rollback attacks.
+the currently-running version. This is to prevent rollback attacks.
 
 The ``delete`` file is used to remove a policy that is no longer needed.
 This file is write-only and accepts a value of ``1`` to delete the policy.
diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index 3a0069c6d5af..45f7d6a0ed23 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -106,7 +106,7 @@ int ipe_update_policy(struct inode *root, const char *text, size_t textlen,
 		goto err;
 	}
 
-	if (ver_to_u64(old) > ver_to_u64(new)) {
+	if (ver_to_u64(old) >= ver_to_u64(new)) {
 		rc = -ESTALE;
 		goto err;
 	}
-- 
2.39.5

