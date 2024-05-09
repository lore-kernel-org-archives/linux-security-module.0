Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CAF1494CA
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285039; cv=none; b=odqn/2rRGOMOhm1ZWj/0/TMSKQ69tvil0J0Mwk/bRq0AUG2mJkWyi0zbA+NDe6+1K8ZDFK47FHtOjyQEuq863MLaFRxRVmevBo9cYPXucjzEHcAZ44cmZkEGAYieToRT5e6k+XnrfU6uPvZscaSsl9M8KX6LKvSzS4zKoUtUsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285039; c=relaxed/simple;
	bh=YGdUWwnBUwtAPSGnv0RCxLjda7Rt/VoZWS4Vf/iu688=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bjpssFXROyxR9KZNk+Y3O6amJ4UjC0/nGX1GstE+dOQ1jG6iwMrQefOZU6g8lOx7bbTycx4Je6/Iu2oUec/NCTLKUhQMcKUwb0rVShOa4kzlZocH6SP+vq4v/P/yF3UmiwT9IZZiFh+zCvqE4OJ9ijWisvoopUuOKf0Ai7E2Gd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCORQWUc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCORQWUc"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f46acb3537so917668b3a.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285037; x=1715889837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CpR2fXzwrU5rpm47H0npQ28GT7MWJnlw5HNOpJYAkd4=;
        b=XCORQWUcXmszvPUYNj2T9+FZvDLLqqvNGl1O5aQ15WjMruZKuZBVqA7IjloyVtLG5Z
         Cy4uq1J+/oy2HoEmfuqwDJM6fPORb/n3/+soGlVqf0uYFD6T7j7gQkNnfagz+4USGQ6H
         bLgHm0zbVyWtDMgVzKNFDVxB9di5yaVzdraFKDvzNnTwBQCGXax/8uE8ZmCa7Ja3efM9
         Bz0Qhh3iE4hYwyIpEBEV2Zrbx3DaJQ5kgcpgZ7DFU6xvKRDp43KY7valBw0mlMfKOPlf
         oY9uuo63jx9osPLBk61bbpbYjoyUSBFnltkC4VA7KMeNAABo/b/LvD9OJD9q1j2b+/d9
         mmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285037; x=1715889837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpR2fXzwrU5rpm47H0npQ28GT7MWJnlw5HNOpJYAkd4=;
        b=CPs53SDCqG6inC7FawJC/7xLHlQB/GmqpiGyojUBKT2LDmKrrZCu0PybjldwAZ/PXi
         abbInAyIdgnWPS7TF5HdF+cCukOc8S3xTJPG+IK5SJXNWnEbD1syDvUcZUgifAf/zb+T
         07V/edy8D8ae4hIkLOwoYjBwQqKmEv6NfeD5rpD0cvpCb0fGSKXYIyYGjQ+nEP2lZ7Af
         EBTS0xKluBuHZAb+GH4tM6JOWXzzPqW1z5w4Yd0zbABmvxQtal6KFKIMQUeJD/odhuvu
         JOd6MDRyxtsFGColCcMPGSdWGoNfMGyhYNJpREecZGZHQnz+VMB55ZnyGqMx5ejcuPwQ
         eCWg==
X-Forwarded-Encrypted: i=1; AJvYcCVh3MfqUgSAlJvHGTV6deU08fnUSDVdZZFGrxTxvYKNw7REHXncDyepq7NOePWQ/9Z14oaUzLEKkTn8PKGLChBdPJitl068D/RyvpCOVEPk5oxOEJ1K
X-Gm-Message-State: AOJu0YxDZoVR/1d2Sji1Jc/07Q1A6zeYzffZqd9Y6xf2NGOC/0KWPF+z
	nluJq8KU+NlLPVpkkOKpIZAlzuQQczb6sA4WcEbB9/6A608mNwPED+EPqnz968hqklDTqHdOm8i
	p5A==
X-Google-Smtp-Source: AGHT+IFI874f+n8iDrukMUj0e5vTHsv4XlA10buWf+xTINM7U+orl2HvrgNvuh4I0S6pYnKJpWbZKr4P2nA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2289:b0:6ea:f425:dba2 with SMTP id
 d2e1a72fcca58-6f4df2c7942mr54587b3a.0.1715285037144; Thu, 09 May 2024
 13:03:57 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:58 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-67-edliaw@google.com>
Subject: [PATCH v3 66/68] selftests/vDSO: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c          | 1 -
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c | 2 --
 tools/testing/selftests/vDSO/vdso_test_correctness.c  | 3 ---
 3 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 96d32fd65b42..fb01e6ffb9a0 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -14,7 +14,6 @@
 #include <time.h>
 #include <sys/auxv.h>
 #include <sys/time.h>
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/syscall.h>
 
diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
index 38d46a8bf7cb..f0adb906c8bd 100644
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -10,8 +10,6 @@
  * Power (32-bit and 64-bit), S390x (32-bit and 64-bit).
  * Might work on other architectures.
  */
-
-#define _GNU_SOURCE
 #include <elf.h>
 #include <err.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index e691a3cf1491..c435b7a5b38d 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -3,9 +3,6 @@
  * ldt_gdt.c - Test cases for LDT and GDT access
  * Copyright (c) 2011-2015 Andrew Lutomirski
  */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <sys/time.h>
 #include <time.h>
-- 
2.45.0.118.g7fe29c98d7-goog

