Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974713E88F
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284979; cv=none; b=R8cTzhzpdzq+9WY9WD8cO7ElW3JW1QkDWGdKPYcKXkpmEWIbcG7WM0/91ojZe702ZeiVaAyZx4lTVFXcxCQhNVZu07s5bRpJdOt78vekYW8+y+LCtDQf4g0Q4/NbNLD/IrGuNwND0yNfrPA26kEEDdsCD+aYasOMzhSbdpf+6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284979; c=relaxed/simple;
	bh=qtfxhXik4RCIYvSYFE6HURw6GVoBtbaX7K5kkbVFZRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M4hpxeA/ZccU3vAMM6WkiTXxSrBmp1zZ6qq/FTyz8pR6YbI/zVUSa9JPXvBasLNbQt34grfa2in6oqirNTrI2AUCjSolO1xbvc5+Lsu3V4TXBVHRyfcBSJt0uz1KK6esLhy4ekQ9YR2Zv0+EKl0DqbjIiUDtgMb7EppiYkgf9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=liKTRHj5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liKTRHj5"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de8b66d59f7so3014514276.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284976; x=1715889776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3CKdOXgASsJuwLQx7CbN/Z0GEpdiG1ZeUqLcW5lHOw=;
        b=liKTRHj5QIl2eeitf4x/5bWfCNGxhp8r8dnYaOIPmWI1MNDMzuNagiD05RIxM6waum
         snRusMQkRA2NUbZll+v/jKkRjAX7fQMhhcDbMIEi6cUIF/W4grtN/tlFeborPYaEzhxT
         dB0bUCjoQP88oWjnvM3vgL5Fwcfdv+qfxi+Rp2r++/EUThWJMIDzrgX/96OqgfDPlhZQ
         jXRQefFujsw3ptDjuCGpSroy56/2xURucU10FJ/QAFh3/M9S7iduGnMS2p5kUZiVCxtB
         RQJny/Lvudn6/k1t7b8JF3fGsNsH/yGPHA6WiU+z/ZkZuecScwDFUaTAMS/ONf8UPASO
         VuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284976; x=1715889776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3CKdOXgASsJuwLQx7CbN/Z0GEpdiG1ZeUqLcW5lHOw=;
        b=OzG8uWmWNkNQd5/chuG1LHed0O45oDuIRLzLF1UVhiYMpxEbhkR285Pr/h1MvZ3YTY
         V208xVHhcS4yw8NymTiKpkTC58oZ/QDINSYBp2V0+XzubO8N2TYajYyziDG0iuB9V0aT
         jhr6L4H08+HTaZv94a4V6FgDFl1vCpRDu5gLUGPGk1lpmqFInqYTfnpQ+bpNjL8bJSTG
         KTB5Lebmy+Z4/4NlAckFH3RQyqhD5kCqr+qAjsq50anWh1PutCNR7WwdEtWWLrVaGV2T
         o6bUcxVZMnQnYGGHBXd+O/M/SH1ysOf9p7LsvAvdDHZh8BlXTyYyVsL+G8RagLBoNMkX
         b/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoeF6dvdi1n3sRfBNHgCXu4kJdEus6p4IQfNeT4ot2nYY2rHA8ymD34oC2wCzS8cPx2z0xKHm/vOgesD1OHMh2n3jwBXGIGu7Nkf1ndUzoW0pk5XLj
X-Gm-Message-State: AOJu0Yx8nTPGTfhE9WStXAiZPTyRVg56yWE+gOLJtvEtK1yuCylsCWPq
	hfvJzKT+mheo8c0DsyFhq72U9/KZ2J9o9+776erNTs3Dn91mXY9uN0HrEOsO8rlba9Xw8bfIVWe
	o1Q==
X-Google-Smtp-Source: AGHT+IELNadyHUbcHsqAN3f9heAaXfLRA5Nts7egCHjZl0H5CAKpMh62vMmCQrVozei5uUelqCkPsrmDhOY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:4c81:0:b0:de6:569:325c with SMTP id
 3f1490d57ef6-debcfca9a3emr851927276.4.1715284976566; Thu, 09 May 2024
 13:02:56 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:36 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-45-edliaw@google.com>
Subject: [PATCH v3 44/68] selftests/pidfd: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/pidfd/pidfd.h             | 1 -
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 2 --
 tools/testing/selftests/pidfd/pidfd_getfd_test.c  | 2 --
 tools/testing/selftests/pidfd/pidfd_open_test.c   | 2 --
 tools/testing/selftests/pidfd/pidfd_poll_test.c   | 2 --
 tools/testing/selftests/pidfd/pidfd_setns_test.c  | 2 --
 tools/testing/selftests/pidfd/pidfd_test.c        | 2 --
 tools/testing/selftests/pidfd/pidfd_wait.c        | 2 --
 8 files changed, 15 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 88d6830ee004..e33177b1aa41 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -3,7 +3,6 @@
 #ifndef __PIDFD_H
 #define __PIDFD_H
 
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index f062a986e382..84135d75ece7 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index cd51d547b751..b6a0e9b3d2f5 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index c62564c264b1..f6735eca1dab 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
index 55d74a50358f..83af8489c88e 100644
--- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
 #include <poll.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 47746b0c6acd..518051f0c3a1 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9faa686f90e4..53cce08a2202 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/types.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index 0dcb8365ddc3..54beba0983f1 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/sched.h>
 #include <linux/types.h>
-- 
2.45.0.118.g7fe29c98d7-goog

