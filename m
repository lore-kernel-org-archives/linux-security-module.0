Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C41146D78
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285029; cv=none; b=kCrKAOoJlE1ersHiTBadMfuJ2Hg8kLji6d6ePDtP9PMJMbbbgHOYC0OC2ChzO2C1XszbB1vwLj6hl/VIxbeEp2PXfApz+88XCCyKkgdTvyvENjqFZMbWUkDyAZ6bTVCDAuJ87ZqotKxrJeURY2jViuvQufFJ7uIQR9Sn866QBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285029; c=relaxed/simple;
	bh=Jk9WlsOAEnwbmnHRW1QFCXzqP1dOARmd0dJyp3x2RB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EGEd1uzf6ey7SqnPX022rRRx1jU49nk2ydEvePT9vuARjXBcfHgC7GefQhFEiHPsZoOpbzYoY8nPxVdhsQ/SF4srV6U1FX9HeqiWDAONyE4i0FX8mR74RZf2jMJAxOX4elxv5NWyT8s/1FfmuErkpnJELX7bCbddx/+PUUEXh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGdVhBkX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGdVhBkX"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ee13ebef37so12067095ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285027; x=1715889827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrH27rGPbpomBrMwjXFw9TPUN7Jl3Ae++I8KKaa1ZHU=;
        b=oGdVhBkXE6V+l6B1ZgbolcieIh40J+k5lT4HKLueJ1rTppb4IfvzoPDPcxHzhbS+28
         RqISanvJ58jnNGVpC+mLkwuFP7anyIs0N684iQm2BKGaasptH8VMMClQV6nvPSx00IDw
         ZidgBjAq3LJi5suqoJlnuFI00Ld7fNdCBSrWti9LAHSYBnNiVDINWxi82REh5DKsBxbJ
         ym0w3A4Bf9rNaG0Lyk/RlDg3AWHVlY80Fiuw3u+DfFCWGT7A4qcga+I9sQ4rkrSgL80O
         geGmviCbUH/je6VWq3VQuZA7xSR/BXp9+jydg+j6InNrSEGrxVEo+/nsXboZA4sOsynv
         eZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285027; x=1715889827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrH27rGPbpomBrMwjXFw9TPUN7Jl3Ae++I8KKaa1ZHU=;
        b=OZ3i0fJmNyRvqPJMOAq/QzLD2s5qmdDUEasduIPGpT/hR/AapKbTDKMXchOttE1YcX
         14Ylkrw7TB+i30LHh3QCHq8zloZ0uqbKiZHKIfIITauvk4SP+kr2gweTH32IzNDcp45M
         x/KT26qhnLJW/W42McgPW9G4UQeVGr1oKs6/8rEux347wh25AvHjbDuKpzsckATsk5jY
         lgaINwdZ5ds0f7H8LerA2mmvy1hU7eukFzxDw9urkUwfCG9NA9QF0/hp3inUj9mHoM3L
         7fwTPupeBjebycrpyzigMJWlqS2XtCqFcFcTGoLae6MxnVA5oLdJl+S6bMQpw9eRmjZz
         RPjg==
X-Forwarded-Encrypted: i=1; AJvYcCU4LbhYIZ43HTfqVaae6mSJSHabm1XLz7iNrC5CbxYwFHT1kumMfrvtXz/cHd+8T6V0KdhIG7JaSZM59PN761JxVZE9HOhl+SHoFjtrIyR/lCJ+6xIx
X-Gm-Message-State: AOJu0YxX//pRFfmVmbvHEm0VHxmy+iQ01wGkIEJxYqCd3gnXG8GpkWV0
	uMU8jAC6Vq2mP+8tjrnuXaPbTPJD61mcPZP62ZExFraq8dIKAsQM1NT+U1U1c0siyjP7YjOkYa1
	azQ==
X-Google-Smtp-Source: AGHT+IEuE3KvkQE4fBcoS4/aejH8+5T9BJ8+Tcefhf/wjiyYj040WpgbcuK7JYXdw/yXkY1WQk04Fq+Ou3U=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f548:b0:1eb:ac97:6c35 with SMTP id
 d9443c01a7336-1ef43f41477mr266155ad.9.1715285027301; Thu, 09 May 2024
 13:03:47 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:54 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-63-edliaw@google.com>
Subject: [PATCH v3 62/68] selftests/timens: Drop define _GNU_SOURCE
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
 tools/testing/selftests/timens/clock_nanosleep.c | 1 -
 tools/testing/selftests/timens/exec.c            | 1 -
 tools/testing/selftests/timens/futex.c           | 1 -
 tools/testing/selftests/timens/gettime_perf.c    | 1 -
 tools/testing/selftests/timens/procfs.c          | 1 -
 tools/testing/selftests/timens/timens.c          | 1 -
 tools/testing/selftests/timens/timer.c           | 1 -
 tools/testing/selftests/timens/timerfd.c         | 1 -
 tools/testing/selftests/timens/vfork_exec.c      | 1 -
 9 files changed, 9 deletions(-)

diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
index 72d41b955fb2..5608f2b519e1 100644
--- a/tools/testing/selftests/timens/clock_nanosleep.c
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <sys/timerfd.h>
diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index e40dc5be2f66..7f718a3bb043 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/timens/futex.c b/tools/testing/selftests/timens/futex.c
index 6b2b9264e851..0a5a81939220 100644
--- a/tools/testing/selftests/timens/futex.c
+++ b/tools/testing/selftests/timens/futex.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <linux/unistd.h>
diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
index 6b13dc277724..9fe6690edd2a 100644
--- a/tools/testing/selftests/timens/gettime_perf.c
+++ b/tools/testing/selftests/timens/gettime_perf.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
index 1833ca97eb24..7bc389b05799 100644
--- a/tools/testing/selftests/timens/procfs.c
+++ b/tools/testing/selftests/timens/procfs.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <math.h>
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
index 387220791a05..7941a43155a8 100644
--- a/tools/testing/selftests/timens/timens.c
+++ b/tools/testing/selftests/timens/timens.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 5e7f0051bd7b..378e058359c1 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <sys/syscall.h>
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index 9edd43d6b2c1..807edb9d83c9 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <sys/timerfd.h>
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
index beb7614941fb..675c6a8b2eed 100644
--- a/tools/testing/selftests/timens/vfork_exec.c
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.0.118.g7fe29c98d7-goog

