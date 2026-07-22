Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91601336897
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723409; cv=none; b=bVbZCuXBJp2uo8XcKrvvTr4K53BEygBDo6JzXBQlavd6M8xGbg2EPZH81o6pWQzz7F//WPoYgQUWkQVIdQXswmcMhEIU9mk43nbUITlK4hjlGjhrD4j+QLDIEbcRG85ZuvSSJ+QzpumoPqjFUTWWf16g4A43iuDyOyBYoAbzq2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723409; c=relaxed/simple;
	bh=JAKHu8YyBELteSv8ooj1Pp3j9g6YVHHeCe1BMryEs6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6WSn8mPd3tt46wNREYN1Fo1SqjiO/k/jAWh+M/52yiDUzaHOftZqmWe0LJka67uPG8NCmz1vqGhRqdtWPEtpMtjGVkXdH/lVkLphtNmWRrwKT+p0vAlMBNm5Uzy4G/gh1uLsw+8vEOO+ZJ0BD8PQVdta6fedJkuBwDMB3rI40Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Q7EDhFzL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Q7EDhFzL"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15cd3fd760so1406181666b.2
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 05:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784723406; x=1785328206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zbtWhBehxkVPlnfWLUPZXxKYcYCTq6s9Hilnw7lNtrM=;
        b=Q7EDhFzLq0BUjEzbs327ym00ev6EGesE9NmxaxStxDVRojFfYslNn8V+HoApNu2tyf
         U+tZDMwZ1sv5sz0SHREGjZ1bnUgR5ru+KAf3YB+TlMNT1HW6LpFgqY881uaSjmP/tpUq
         8nve/jd237y8oz0K2YK405+p7pg8+w1qpiApyS1SO5HEEdJ0nL4tevHfiUus08wLhP4f
         mZhxzK1WsCCBWgbk2LiLqu7ynSO65OtTEGkz7s3d+vynjKrNbItJZwAYyqLUCqP1xbXT
         NNcTp32f/ApMzW3/KfhHQ/9OAhyiDkqfQ7329CwnNOeAakQKzzkL3obK67diwDzClzjy
         P/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723406; x=1785328206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zbtWhBehxkVPlnfWLUPZXxKYcYCTq6s9Hilnw7lNtrM=;
        b=Ej/yHaVfYWZoVR7CP+ycE7dGsBJ9SCj3SZs9zq0n67TngrKuzKYpj/ROY7MVgMXwpz
         q+PZLi25fcv3ti3gtSkztQgjOOd63qYM5OD2XEHq+DrXBZElx9VnnI/y/hISHQEo6Pcv
         HjMdz7pOXDKwyKLp6uOWxpwBkHDuuLxi4xsnbDRbeXvTQIszayAKP+p+LN39DVb0Kxv8
         ucpS6NijLcasMt8LhM1N4QI2HZR80qy8iHF8DGDkyJpPRnNd+sdvCD0WQJryS71V62JG
         EPhw+JLACTviAaGB3NKFWBGevNn6vtCWy/s5I9QKv8pzZ+l/Is+vvJ5y4DufuvyZfHPp
         FA3g==
X-Forwarded-Encrypted: i=1; AHgh+RrKDY8rNIECwBMldLVMGDK6QpQAPueljOZEcyvYwEBKhrEBRIQlQWZ6344UMHpevX+x2nPlJN0h1Nosmb/1w4OxzbvdPtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKljc7/Q2c83M2mU5Von4N0v2WelgJwTiaCL3tOZXGK0hY8v9m
	Rns8B98PPwz33rb5emywjDbMzkyGqwugjNZRvXw1NJN+jgx1FsEm8tQiSc2lhibrum1rldipORO
	Rcgkdh5Tw9A==
X-Gm-Gg: AR+sD13Zcv/Ilo8sIGAQ631Gu0UHd0tb0fdoPWRYL+DoRC3KLgk4k2XP+HIQAiATTMV
	mi9IS5WfWdJsmL9v7lVnrza0juZg1NkCFYQj3RTZ1DOEyU9PUY5LWhtpNGpTJCz6f9mK0wsIwcZ
	vWKJtF4bmANF98626s5VmcWqfg5t0SXyhdrl8f7KTk3NQk0YUZvT41mX7NgrvvK6o3cet9WFqVr
	66nbSsOKgLN6cur0lnU5Q+AbG6j1CL2Dx2s1CN0SnTFefyt375HilskkWRJkpLfmb5B1zaS/qb9
	3F+PsP0X25VsqITPc0DfdmOGKLmk8Tp5gvm+HF+hthbJ6pPV8b/J3ubJDiTbpsDia6n1EWbefxL
	JZkuru+QQtNVShvveaiN9OVthxvcWL7DnETee4n/ls+xKl/mlV6avB+rj0S2GCNc=
X-Received: by 2002:a17:907:980a:b0:c16:2f5d:6153 with SMTP id a640c23a62f3a-c16b46d2c3dmr987958966b.20.1784723405581;
        Wed, 22 Jul 2026 05:30:05 -0700 (PDT)
Received: from DW927H4LGF ([2a09:bac6:37e6:1e5a::306:2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34f1b867sm835007a12.14.2026.07.22.05.30.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jul 2026 05:30:04 -0700 (PDT)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: paul@paul-moore.com,
	jmorris@namei.or,
	serge@hallyn.com,
	wangyan01@kylinos.cn,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	landlock@lists.linux.dev,
	oxana@cloudflare.com,
	webprosto@gmail.com
Subject: [PATCH 3/6] landlock: Bump ABI for LANDLOCK_SCOPE_POSIX_MSG_QUEUE
Date: Wed, 22 Jul 2026 13:29:39 +0100
Message-ID: <20260722122952.42149-4-oxana@cloudflare.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722122952.42149-1-oxana@cloudflare.com>
References: <20260722122952.42149-1-oxana@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase the landlock ABI version so userspace can detect support for
LANDLOCK_SCOPE_POSIX_MSG_QUEUE.

Signed-off-by: Oxana Kharitonova <oxana@cloudflare.com>
---
 security/landlock/syscalls.c                 | 2 +-
 tools/testing/selftests/landlock/base_test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 36b02892c62f..84521a31bf75 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -169,7 +169,7 @@ static const struct file_operations ruleset_fops = {
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 10;
+const int landlock_abi_version = 11;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index cbd3c1669951..b8b5fa1042ba 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(11, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
-- 
2.50.1 (Apple Git-155)

