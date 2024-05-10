Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF213C9B4
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299891; cv=none; b=rPZI/78V3vKSwF+CbwEQtWbMhNrPB5WldSYDJeFDNM1KXZ0hzvclgUJK9kwRCvQrZ6iE82wbNYlzbiyiNLjriqhlUXDHoUbvx7VxBp0xqTK4q3LrCsipn1zUnRNsi1leLaJPEMMIBenOl0CUCk/Lo9YDVvo5PGxHlGTDf8N0bg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299891; c=relaxed/simple;
	bh=IBU/NuSGvQtjM8xGos15Pkr68BKEzjA0BEJAs909nTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T/2NX7gK7XNpN3i4c7i7C7FZjER9VbdiydneUg1gvwd/bm0G4rNo4/alp7pqpxiTO/jwONxnOZEb5fGI/0oYOtzK9kVduiQz74sw+iFTMe7c12GjMGbeCbG9j78lcZdjjroTUO5PF86qyHmAf4tbDwSe8+zGD6NnAmfneP4mt3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GfM7kvCO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfM7kvCO"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f472477050so1079577b3a.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299889; x=1715904689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LuB3m194wkKvY0eVyf5M25YoLPjrODu7ClV5j+qOpls=;
        b=GfM7kvCOBA9/dKGcofNiFfZocY514k7KcpzoNTeRBieYuGGyhM37brP1/5JhohyINc
         X5CcpBXdfp1ThXXZAxHknsprfCxSjkdouXqmQespoZxCr8jyr7w7qSMkkvecmYBz8q1x
         9Ph5mBF6oxLGXIR1DpoyVkwEaUF4lNhtwMfAaF6i3k+Hq0dTBRvqyf1KMnvefUO0HfG/
         O7n0BAJLUqbHKkH46HUYtimlIzgoFR/8HpuFAq4FY6wW1W0SolxM4rygOW7Glng0cu93
         G5OctfToxuib0eiZfpuZ/Fzyt4xhLnRmRqCopHR5z/qQcP6V7H46voGGCO+kBGyqtSvc
         LSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299889; x=1715904689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuB3m194wkKvY0eVyf5M25YoLPjrODu7ClV5j+qOpls=;
        b=BrgL55YkE1SYogSZ5q8Ibpj0ODwtl1pfJX0iIl5GEYhuWTWbya+ju3AX1LMRdCxW9D
         84zxYbWIQ79eNLASIqexNrZjZxtfpJh1dYNnMsfYToY3KRi57oWYTOGpZxOcmyqSzhhS
         PVV2a+eEx6+FrUdSnNaeiADwa+JElenfaY0hCi0skkKCB2RvweR6PBEpiHpPh2BL8I7i
         mEwUYgddjIhbY6l4b59Y0CkEFGpRdpGWGYZa9ABYNJ8CK0om8JkGyHMM5iClS4kP21E9
         Q7CSRA5pSP7E2uaZfq0KnDRMeq7egaD0czGx4DO/cyI2rdCVfhYWVlmfWG+eeWZQiwCw
         lJdg==
X-Forwarded-Encrypted: i=1; AJvYcCXGw9FqJOa2wCwcN8AQVQGLlO2MiJp0SQGo5ylPWbp8+sdw8HZYSwMnzqKc/s6oT2ehfPvkuzbPR/P3Tg7Vmotnp5NjT9HlHpbVWYY7mmqrtBl0FFSD
X-Gm-Message-State: AOJu0YyaLvzUUtR96ocMxU7cAbofRdA3z+m7Qg5Pw/JHoG6gVOvSadBZ
	bkY8BuFWugJQeqHVVs4+sZTOi6Zw5N0APGzqOVVQxJcuPiAFrqJmzdeGxSjwc0yo+2lA3WblMPX
	FJQ==
X-Google-Smtp-Source: AGHT+IEAPDmiCGGPRhY6JBRoUT6dlR+CkZjrxhOj+xsSstNk+8V5LsggLR8ug+7H1pKBdhGr0v4AK8MG9gc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:17a0:b0:6ec:ee42:b143 with SMTP id
 d2e1a72fcca58-6f4e02ad1f1mr31327b3a.2.1715299888557; Thu, 09 May 2024
 17:11:28 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:06 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-50-edliaw@google.com>
Subject: [PATCH v4 49/66] selftests/riscv: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/riscv/hwprobe/cbo.c        | 1 -
 tools/testing/selftests/riscv/hwprobe/which-cpus.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index a40541bb7c7d..4de6f63fc537 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -5,7 +5,6 @@
  * Run with 'taskset -c <cpu-list> cbo' to only execute hwprobe on a
  * subset of cpus, as well as only executing the tests on those cpus.
  */
-#define _GNU_SOURCE
 #include <stdbool.h>
 #include <stdint.h>
 #include <string.h>
diff --git a/tools/testing/selftests/riscv/hwprobe/which-cpus.c b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
index 82c121412dfc..c3f080861c06 100644
--- a/tools/testing/selftests/riscv/hwprobe/which-cpus.c
+++ b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
@@ -5,7 +5,6 @@
  * Test the RISCV_HWPROBE_WHICH_CPUS flag of hwprobe. Also provides a command
  * line interface to get the cpu list for arbitrary hwprobe pairs.
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.45.0.118.g7fe29c98d7-goog

