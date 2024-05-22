Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6214B06A
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339650; cv=none; b=GvMqMGINLz1AFbuU52AZak8fIQ3xWqDRT6s+WS8Mi7x65ogFb9tuPTan0/q/l1jzrA27dxJSn0jLBsxdiq3tDj3iy9R1a0FzduLRRr4Rmz3MFgYQC1SiwqRMszVJAWqxQG8j1Lsqf1bZnvy7DzsVnqPAIGsZP4q2vOQVCbK1oqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339650; c=relaxed/simple;
	bh=lsQ42Y5Htgr3DTEtIEz5DolJMzdlzKLlDpLP6Gf0KXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JzgFgQRq/rm78oEZCCtmtLDqLNAqEAnQWmEnKja5uz3CdIyD90CNG/usRg7vz2EMl9uzakk+i2NL8iwfHqWUZYEQfA6RP9vG1uSLl6+CPrkQCoxMk31AmDLzw4I4As6a8sg5RZXEI++LJ9/zY0O4dZt3gVxMwwRvMCoHA5ENPR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBx+aRsG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBx+aRsG"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de0b4063e59so11933074276.3
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339648; x=1716944448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yAQSiPU3Xxpg5se1jVwrYALJE0mXKiuWYh1IlCTKguE=;
        b=DBx+aRsGrh43u1T1Bdx0RBdlDC2H0IJkLaia4U6o/JP83zOgcIEc+I4V630p2qBfVo
         MfhV94JD++lDmpnUJGolpYOa/gcikUtgEb/PUuz5u03sNsqEqtmy4DnymaQt/+U1QiU3
         H5XrO57kUalPd8+1Pg7Tv+T0s27wlP+XCVBxUzIDjroxUwTNtWWPN62oGIgn6J7wwBRJ
         KsQkRUSgoVksiiILKhosxCD6QSiateUyDkXHA6ONP8B64Wdbn75m0dHe0KQmiVwLv07E
         aCf3FkS3Q91WT9AeSSB1xiJswErFOxevLTYCyvmZ87MfJJB79ur+yhUYVZ1ZRYvUrxJC
         6KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339648; x=1716944448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAQSiPU3Xxpg5se1jVwrYALJE0mXKiuWYh1IlCTKguE=;
        b=hi6prDmi7GfJA9iy8NrGYJ3Ttn4R9E/btgdruuM03MdKfbKJ6L2zMfHr3X2jWV9hAO
         3ukyhEBJdIj1Rn2dk7wbJY2tCh/7dYhHct2pX2bC0iVIjuEuBJV2443vr/Zv4q6GmiSX
         NxvbM7m0RuijQHdiv2jVlsspsEp1n1EFBimMYLLnTn1zOVv0pLGN6tsKs7Q4jD6Fe57A
         TgwTaIjmuZEzdhJJUw+hXKEdPK795MIS8kqMAut6mmo1GUbKRz42FUGbtRe8i0DNlmAu
         Jutn4bna1jgKyMGeZ+hFYTBvJUIieC8cGa8xkbAsHsyooX+JvGUf8ygvXTLxpnAxrLI5
         ikTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmB+Qi3kDkhDBntEGcZR/frhltqLoxUZZqOQw0LXdaNSLksR/lkc0meDBVdhf6YalGlKtROuryBXKuEOCGuNuN1SenMLrL33lwL5hhMmykhPTOjBf5
X-Gm-Message-State: AOJu0YwUTPFMIczUkrrS+bhXq7OvncGLR+YJ9rYAotIJ3mTSQW6i6FbX
	qOd3GEI/bQiRy2EsaBYVajiIaK3/bOE+y0F53Jz8QZ6BualNDdXMK0La/dUxkC4fy8vWxAfBjpW
	UyQ==
X-Google-Smtp-Source: AGHT+IFjr+dMdwwjSeyKVtDvj71h4a27dlU6zI/2JB6uVxDlz76u2lFmfPLoHDWhwCSwvHwm9NN5UxukkLw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1083:b0:dcd:88e9:e508 with SMTP id
 3f1490d57ef6-df4e0ab542cmr224908276.5.1716339647973; Tue, 21 May 2024
 18:00:47 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:14 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-29-edliaw@google.com>
Subject: [PATCH v5 28/68] selftests/membarrier: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/membarrier/membarrier_test_impl.h        | 1 -
 .../testing/selftests/membarrier/membarrier_test_multi_thread.c  | 1 -
 .../testing/selftests/membarrier/membarrier_test_single_thread.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
index af89855adb7b..a8a60b6271a5 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_impl.h
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
index 4e14dba81234..c00f380b2757 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
index fa3f1d6c37a0..c399fbad8efd 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
-- 
2.45.1.288.g0e0cd299f1-goog

