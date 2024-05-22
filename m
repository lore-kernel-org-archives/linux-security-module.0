Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAE6156C5F
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339726; cv=none; b=axXsGbtoN/eprDVGm5AyAfwShPESa5lIHvFLL5UCg2asulG7sOR3Lmj4EdZptbdBfLKmX7FrmHFbd+I8/vH5Y8AecQH15uOTFRdAQr5QDT97iLvjR0e7/Ig/sSigl02ENEfpKORqvFtJ4gAS/gSHWxVyBB/afawtETOiiKTpku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339726; c=relaxed/simple;
	bh=6hz7C6NjuqdewI/N0OqvnGYc8W68MC32bXsXgTGesTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iRQ6v6D0Ylid+msXM5KmtooCjan0HLITfUhGDzoGGD3vv106N/SE7FHkPCfQm7m+Pm0RoS/Q0WKV5eE+QzroG159MDxJ7DAmsCuVxzx7zupf0+uT9jgEddBiDJ3vchZePGfbzfuT5RLECFfZ10SHlOuMLtSP+Ips+g8RWKYwKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NgpBbs3W; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NgpBbs3W"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ee128aa957so12938938b3a.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339724; x=1716944524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kP/Knjhf4SFsVRwH8LUfRCgMeG4hW/KVD/lToAICAlg=;
        b=NgpBbs3W0IubFnKyfy02RLs+H0QGhOyig0/voue5TdlDjjL2IeXCsxKLyu1h0t77SE
         IF0p0nvFyqN2emgx9BFVy/Ts99EM+6U+R9DyqdWUvhhRXLNy7YbJp/FAMhdsKwS+B8i4
         /CPuOFMObF/+b3SMwuAeakAe5ZnhGmXb4wI4Fu9+H22qQk4Ci/LBZM8mqzWPqKTWfnyF
         xlfsCNFpIvw87OFdLh6f1mZzn+F4AdavXaJJ6Xz5l8zv0fpeMFxNnyBFUMAnq5G2XYCH
         2ZchouZG76xIyMMhGK2TxuXqHFs+8ghi0aACE0MwdfUeYawzIJ2sVEVFcWo9BCriNr/z
         7fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339724; x=1716944524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kP/Knjhf4SFsVRwH8LUfRCgMeG4hW/KVD/lToAICAlg=;
        b=eM16cr6CRmHTaxD8a06Rj+NU6Id5ktyOsL+trlbHwMcGNHZDNPPi2sjR3uRuAgsPT2
         JqWsai3PlHLE88FqgP0/UjNY2mxdJ/QJ8sgaVPgC7Iv2k/OKUIYZ1M0MD7k6/Abg/4Ia
         bz2emxzoC5j7bWUWTF4MMmyNAIkGPrSDZzcHEqmLwyPLSzD8gEwmg8UUNUlLEy+5A0GR
         RikmI6D+fnCkf1lA9nAbyloh5SKsa09ICQvqf3cNfYgB0NXHVISet1RqCLdOYWqD2epg
         8AcNX9MXCjG0yVu4ceJYNZpw0ZkSRewkzXxsPVInpQU2FhzXxaFRI/J+C15Yd21n9Zb/
         go1w==
X-Forwarded-Encrypted: i=1; AJvYcCU0i2bDOQqcRAqNFMr2YuzOr5i2HQemvSwHlmjV3W8utO+TXNBfRrLUAFT/dN1xee73ZS+tHGbfEt/yENk9thhdEtnu6VXA+ZUaX1FlEfo25GLGoFz5
X-Gm-Message-State: AOJu0YykQoBAm5eMCVpbS5vDxwwTqU15ao6fcojhfGJ8bBvJQsMCgCyd
	gK17U8wKh+Q2BwQW2gxiYscr158CkIJ0LdWY1vwMTV843KlqiVF2yRZwSjxjXwhNPdEuv1JcztW
	Zag==
X-Google-Smtp-Source: AGHT+IEvDtPSiLTFtlvXPIFv99iXZCCztGsx6QawF9KvaqVTg7Gq0oD4ITtqI3Ma5EdV2kw2opd39yOFaLc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2d1e:b0:6f0:b53c:dfa5 with SMTP id
 d2e1a72fcca58-6f6d64d913cmr1965b3a.5.1716339724459; Tue, 21 May 2024 18:02:04
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:38 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-53-edliaw@google.com>
Subject: [PATCH v5 52/68] selftests/rseq: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
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
 tools/testing/selftests/rseq/basic_percpu_ops_test.c | 1 -
 tools/testing/selftests/rseq/basic_test.c            | 2 --
 tools/testing/selftests/rseq/param_test.c            | 1 -
 tools/testing/selftests/rseq/rseq.c                  | 2 --
 4 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index 2348d2c20d0a..5961c24ee1ae 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: LGPL-2.1
-#define _GNU_SOURCE
 #include <assert.h>
 #include <pthread.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/selftests/rseq/basic_test.c
index 295eea16466f..1fed749b4bd7 100644
--- a/tools/testing/selftests/rseq/basic_test.c
+++ b/tools/testing/selftests/rseq/basic_test.c
@@ -2,8 +2,6 @@
 /*
  * Basic test coverage for critical regions and rseq_current_cpu().
  */
-
-#define _GNU_SOURCE
 #include <assert.h>
 #include <sched.h>
 #include <signal.h>
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 2f37961240ca..48a55d94eb72 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: LGPL-2.1
-#define _GNU_SOURCE
 #include <assert.h>
 #include <linux/membarrier.h>
 #include <pthread.h>
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 96e812bdf8a4..88602889414c 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -14,8 +14,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * Lesser General Public License for more details.
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <sched.h>
 #include <stdio.h>
-- 
2.45.1.288.g0e0cd299f1-goog

