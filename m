Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC537D124
	for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379623; cv=none; b=ul4idBv/HRQ2yV9b3MTbqd5z3Xaaz0o5jHMbH54cXwQaVNPKBOTOQNV1QXgVYiCpypKyBS4J7qzAAWg+J2eYeteQKOCzLBo9+RPiXov3e5oT38zLV/0W1qc70k/jAdWeFvtcu8/Z07S/JhSTWD3KLpdcecDltAKlXTjPAKNUmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379623; c=relaxed/simple;
	bh=znmD3jxer5HnR1uXhUrMxkukQCBwP6GV+vspk1LdGqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvrv/kiLs2W84uqyT4bn2M5/ZhLtRLDZQPEq80aPvqYX47WRpJulzbIf23UHNCDutRNTWAaTivaPpbEZYBtyfnc9RwkaKSWwy/IHogE21OoLxHRF/afQHCAv2p4EVBmtFDh4g8lw2ecKNPmDiCqdfx9aKrXqNF8U5kPKPDc+fl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXYcbku2; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXYcbku2"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7bdc947aaa3so60367897b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779379621; x=1779984421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQ05UihKfoEYJIZZpuqxvSGy6ymSc4dbTnes7yhWqD8=;
        b=OXYcbku2r/YxFsQHmyROC3tmEKBCikAcMvNb7DAHo9G5KCIWhP6ALQpGPhNKs5lNlb
         3aDU5TgRWFKK8iO95FrpH6UbAedoSeHxXzoB7+nziXT8uHZeWL23g9GVENXg887g9D+Y
         KfJzi8fyUKaz+KbjWL+jh0rsliAf7kD73VlMm0qZrLblyoL1/RRwl11JWsfByPmxnIHN
         rTKTdMlDV8o+E1j62ouggZX6ArJTtoIAeNWO3T+6fvOmSZDil6nPVLPHQCs8Z3lAeWlX
         9yU7wUu0PScb3Vqw2fJPGgO8XuZVvhUV6+ryFLUt3oy/cSQ2w9VQ2rVb+HPbbizBDURK
         Jc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779379621; x=1779984421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gQ05UihKfoEYJIZZpuqxvSGy6ymSc4dbTnes7yhWqD8=;
        b=r3d8AYndzKZxaMPtrsEWu5llhBzv9//8Ab+2ZizCFBSeRv96s6nJWkbl01SNfCiT9s
         Mj9YuDkF4+NP8f+UXFIRbVdj8XUdOiO3ufCCyDFOnGGPAxHCWGbyrBC/XAVdMKibptzG
         7gjQoFbnArUNcTwkVMyDjP69R8rePtrwcLdzVqhUh5Uf0rAyV7uji2mVIZxrWgGfiqoH
         mWlOCm2cFJ7kMQeOEQmLdMjvOQcioM7rSNt3hBoICaL9YFAYK3bQdhHbPKSJU2lqCdwH
         h1kwxCaX7wi6penwQwu5acNb3F9W5EP2ytRf6df9TJ8l662mey6Zf+IEDMogAtfyImAG
         sOwg==
X-Forwarded-Encrypted: i=1; AFNElJ+l+Y7AQ0zvwoNMv1PDb4lYcQdxyi2Y3re6R+4KULvlfWyWuDd/wAgg5AgKxx8m217qPZQruxPLSo7j20e7dMzFfOYNmPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxC+zmMQpjUaJqbT3n0GhyzWLJXZIBpcmfcMtWp7RgC2LtvO8
	WcGMgE70+sQoJEiITdlklqJAC8oTIZNtbENdbs7Sj1QYDJDTJeUomSEa
X-Gm-Gg: Acq92OGFcunoUGa9dNpjpGPtNzPLTjOV7PMOtBkBly8kOLbLKIJn6gtoY/MOQ2pavMG
	R5qWyiH/P4ayiY4IRcfWbdQDsQXycdpXU1c5Uo0kylCBra/Spy4NHRO7WuZGVLLxblNGuEJ1cte
	gQYTEyTlbx2/HU5RRw4Mznnqf8NIKiei2J8p0A3oy4ZpTURD7pmcr5zRPFQ331KyMpi4HYd2ghW
	fVKBuD3ghisalPxIhB2/x5Wqq/DaHVout+i4JFxcyOpjBk7ptTtZZqY76T/X/oSzv2+XlJl67TR
	EJAmxKj+3LB4fmqzCBkNq6jSP7L/16msj4L66A4mpLEPUqnJRHwl5AmOwnM4SsBsN0wI+1+SOJC
	1C6NilG+QVK5trj13vbSt5sncgweXrtwLyx114toDVPGxX/Q9uoM2/Lhhl5dDecBdadTQWP/AEf
	TzINm4JfHsksOkV/Ja2vFVkIrFNgebpRBcmYcQr71ZMPnHgYI6/S2geyFOhdVjmpcqupvWXuI=
X-Received: by 2002:a05:690c:9a13:b0:7c0:deb6:ce36 with SMTP id 00721157ae682-7d20b378a03mr40619737b3.22.1779379621080;
        Thu, 21 May 2026 09:07:01 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:c2cf:2e92:9a48:97a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d2c7abad87sm4657587b3.2.2026.05.21.09.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:07:00 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 3/6] landlock: Bump ABI for LANDLOCK_SCOPE_SYSV_MSG_QUEUE
Date: Thu, 21 May 2026 12:06:37 -0400
Message-ID: <20260521160640.1716746-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521160640.1716746-1-utilityemal77@gmail.com>
References: <20260521160640.1716746-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bump the ABI version for Landlock SysV message queue scoping.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/syscalls.c                 | 2 +-
 tools/testing/selftests/landlock/base_test.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index accfd2e5a0cd..d45469d5d464 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -166,7 +166,7 @@ static const struct file_operations ruleset_fops = {
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 9;
+const int landlock_abi_version = 10;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 30d37234086c..6c8113c2ded1 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,8 +76,8 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(9, landlock_create_ruleset(NULL, 0,
-					     LANDLOCK_CREATE_RULESET_VERSION));
+	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
+					      LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
-- 
2.53.0

