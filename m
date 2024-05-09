Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA35146A64
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285025; cv=none; b=UMxrXioIUXrNhEHiafobUuqM+MEIpCkBc3liZmCM4DlbDvZ33O/QGSbGY6sctwE33aHnGqNzIQO7progeILo0q+7sMq2ePlThLUYqkpga/RjPzPMkb6pksCPugmcrGw3LvuSv1ONBJ7JbQj0Qvjkf7cxblg5/r4lBeMxOdlGE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285025; c=relaxed/simple;
	bh=8WAV55RFZFHdUQBb7CMCCAzXoHxBizUl8h5SsYxKlRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=REGFgh//qvIcXl2l3PVeVcXENyL3MYOKj3g+TppSOMJxwzowSL6XmpZ1PJudQV5HONKdLyq1CVN1eaY50JwWT42osBcfNK1NOr/VfvEnnfSrcbdKh3AYgR9TgXWt7DdRDj7UioLifNh3WcV4qMF4vuUwDgQnzqtH3DhBL6tAX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCn3Vs9E; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCn3Vs9E"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f446a1ec59so1127147b3a.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285023; x=1715889823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cBjkXNzK2r5lGJvUOfu3vMHyc5JfgO83lVLsEeYmChI=;
        b=eCn3Vs9EcF7qvCD6FSaFA6vYWDD0VBTaZwUwDp4AbYHaVILh5icLp4DbXI7T/AZz46
         xnDD568mGFamBHoaVFC3EeKI9cO4NT/87bheVeOHpIcIGSjBuaLzfh7k/WTjLMKQSZ78
         t2a6Lm7rimFVXQ1eaGbdgFCJz681UbPPbwkhEuqWght3+sSaT1oB33gHfvGYKm4rqMvP
         cjUNN0xe0NfcgWo2cuDp6TcZ2A3J1pziFXnqoQ0T6jfeQp9HTlsb3db7tdj4ZrrXamnl
         8dk2nPF0RVdYzPHT5eWmENBEaHvJ7H529tShmyDJB8gljo6orFc4ga6PUt4j4HpF1h67
         nZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285023; x=1715889823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBjkXNzK2r5lGJvUOfu3vMHyc5JfgO83lVLsEeYmChI=;
        b=FhhpZLDlM1gtZlfrAsoaI2ERjr3IheyCO66D5gkPqiAUyt/WUzAzOWpoapiUTk+XdN
         yXWLPvKHIitLLcNtckdVAvYzalY/nJkoOICe0+HjM2upsda0ts8baZ3QINk5orR2dB6L
         /eDAgsamgujDihIjOapTF7fCCRig68bfeIoZdxBmVB60UeIG3HbvkJ28EjNliZhs4Gun
         D5gDCOdiRM5D7EKwUidkM51kKMvfC3YepDx7PxzuQOJIg7IT18KsUQO3bd1/7HudPWh+
         /eXv56vsNQVjIjLeFtkIUbd2lXs1oO5411WbqnFbLRK1VjtqF3yDn9L2rP8z0JfrpTSp
         bltg==
X-Forwarded-Encrypted: i=1; AJvYcCUZXxuPkREBYPWVQSKDPM06oW87334gOi6XAEIiVDRCN/RORxrCZQsP2Qj4txjjHie9uRMB/Mo/Gu6Hi+4PhQl6aZb7lHcLf8fVNJrBSGvmUzohYpj3
X-Gm-Message-State: AOJu0Yzjuh1jqckRQkLVTdNIbbdtVRp6B3bfxnQpv99MnJMbtwtn0JxT
	xhwOpKYeIOB5FLeUhonnPkzh2ZnftV5/nmYYQTOVvxXs077eKfJCYhBfNlreFNT5LyAgpjTjm6v
	uzw==
X-Google-Smtp-Source: AGHT+IFZHqmGcMmIyQ8Ew9M5MvOLSCaa/rYeCHYejX3W6r2kpgzCJiC7K7sEuCco6nJD6eLOUsvfi+zaNnE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:a17:b0:6ec:ceb4:d9e2 with SMTP id
 d2e1a72fcca58-6f4e01b9126mr37287b3a.0.1715285023604; Thu, 09 May 2024
 13:03:43 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:53 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-62-edliaw@google.com>
Subject: [PATCH v3 61/68] selftests/thermal: Drop define _GNU_SOURCE
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
 .../selftests/thermal/intel/power_floor/power_floor_test.c     | 3 ---
 .../selftests/thermal/intel/workload_hint/workload_hint_test.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
index 0326b39a11b9..ce98ab045ae9 100644
--- a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
+++ b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
index 217c3a641c53..5153d42754d6 100644
--- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
+++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
-- 
2.45.0.118.g7fe29c98d7-goog

