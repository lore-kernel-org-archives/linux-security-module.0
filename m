Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6E14AD29
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727296962; cv=none; b=COa8Nja5u3vivxG6LSLLBlq792q/gKx5FW1kJUHpAPVdvUTQBZZAhFrIl0BeECbTpEF66n517AseAvon2vtEzhYiYt9Q7KZGRh6jkxRo9mPuqKWnJNpxrihK3eKR23fSvpP4s6Xrk2ymG5FHdIxAAnNc8kkCb6uVNFeNrPywUQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727296962; c=relaxed/simple;
	bh=qHTmJur0aH3BILO261qBRgBIVaL9SJWh4MEeT+Ftjco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jZMVZVFkVudrAuBa4Rhco/lM/nVdKj7elN1k91bjlD3HBo/78F3CTxHIn65w+Th84QIHbXj/R8RW8ipcfrBv/Fb46ZVy57ckaAELjdwrqm19/PValvZdME74L6APqn08ZxHgl+Nucv9HyqcsKC3hZzAZcDoyK1f0ObdsKOSIvEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlPm21FR; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlPm21FR"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so215592a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 13:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727296958; x=1727901758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhgNgFnfjQvcm7pT9pBO59PaHiN4rDwtaX0ooDFw3Xk=;
        b=MlPm21FRtmS8jgEJTsp6XaqT3fElWywKOWbIbXagex0cjmAwMMsiZPnRWqFrt5hIDN
         TAk0sdYcqlbIyM0DoVz5mZgsS2PDtb1KtIiQPhwIHF7FSjIpaPkDv7VnqnhK23X6EJRh
         EXlfTG+debP05esslwqHe1nkS/4bEQyMRWhoaQL3iMPUXbdRE9qwQUBjnuTPh1XFgamX
         k/ANG3NmsCOxT8kowdghzhxo753MUuu/PCxlJUo0sn0fdB5tcde2+PzmWD/v+LXWHz4L
         /qu2VJywRgNQebP8IOzUnTOy+E8Uujih3A2vq8nBuVmebS5vAmVoZezLPNvGYQ6WjukR
         HDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727296958; x=1727901758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhgNgFnfjQvcm7pT9pBO59PaHiN4rDwtaX0ooDFw3Xk=;
        b=Khgt4xMiUe+PIKYM5AnublyhXLbL4mNAneY3NAU4GMc2rnabGKrcYsRVO9/ACVH+Zu
         odbIrTQpRDyZXrMk7JrHV1PChu4eWl9sYg+Qntuz7yCKeOhjhyNXYV7SsSOQYbC9y7wV
         5M3O/s0cNYIH2GeI09jRlfWBsBztFUMVFtWgZ49hUWXzVE8FezcVSG7sMIeGXWQIr+7V
         yYYLndt71MneGUwpshvnljUw6pTifK53M+rcwfZZYxLEJxL3pi7qfNo8dqFu1fmvZtsi
         4Vw0j17oqvYfK/tuAubmFG70jhdpk5kAQ6/UxtiBIYb3dJ9VIuoh6inKStpV0rL/gPNe
         pJEQ==
X-Gm-Message-State: AOJu0YwPFGcF28sVX0EMwhjXZTCpdr8/hK5HheZzfVWOSfbK7pwsp2mU
	Avn66d8KBWjvzN1IyHYtgOfqX5BLIF6PRH3+QESJAzUqZQdojOJ1QC2V6Kzl81w=
X-Google-Smtp-Source: AGHT+IECj72ApvBTZddGa6dvauu+thaK2N13KmMmUxs5K2sTxfHPwcBtZOwWQsK3aZXuAxpy0hhviw==
X-Received: by 2002:a05:6402:440d:b0:5c5:bebb:544b with SMTP id 4fb4d7f45d1cf-5c72060ac03mr2672932a12.6.1727296958180;
        Wed, 25 Sep 2024 13:42:38 -0700 (PDT)
Received: from localhost ([82.144.39.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf497429sm2366335a12.37.2024.09.25.13.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 13:42:37 -0700 (PDT)
From: luca.boccassi@gmail.com
To: linux-security-module@vger.kernel.org
Cc: wufan@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v2 2/2] ipe: also reject policy updates with the same version
Date: Wed, 25 Sep 2024 22:42:27 +0200
Message-Id: <20240925204227.528624-2-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240925204227.528624-1-luca.boccassi@gmail.com>
References: <20240925204227.528624-1-luca.boccassi@gmail.com>
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

 Documentation/admin-guide/LSM/ipe.rst | 2 +-
 security/ipe/policy.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index 47323494d119..7cd04d3261ad 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -269,7 +269,7 @@ in the kernel. This file is write-only and accepts a PKCS#7 signed
 policy. Two checks will always be performed on this policy: First, the
 ``policy_names`` must match with the updated version and the existing
 version. Second the updated policy must have a policy version greater than
-or equal to the currently-running version. This is to prevent rollback attacks.
+to the currently-running version. This is to prevent rollback attacks.
 
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

