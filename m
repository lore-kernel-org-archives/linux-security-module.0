Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162880C1C
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284872; cv=none; b=OU8azg4/3Wqf2n39i5tEqQOcwCRTu5kzIiIItuLxjswJrehTYgz3eTNI7iGQ98UzdwKPJsmo5OYz+Hh4vuP63eeKD8sNs+7PCc0s4bGgvvmEWkQ7qroFXkIJk8RAllM1BOF6ios3ZL0wq0jSi1QqCAb9w0Z5d0tWFIk1P0VqKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284872; c=relaxed/simple;
	bh=FoY+8htLD+tcBfSG58OctRNszBURt/6xq3bm1HJ3AsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LS8/KajDnbdVZ3yvr4l9rPmlZ81mzHh15ZcXRe6LpXODznaQqh89qoL3zutZ+xHdzmvAVNor0+bbXmJNz4PwmzcxAuAUREM1/xtcR8zKNcZW10h+XoWvwoEtU/30i8VFgniUKLS8MnYE8GVqiDsQerEmA3hCkIoQIxmcvwGRQzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QM5pMXYv; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QM5pMXYv"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6292562bac4so1661667a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284870; x=1715889670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0i1BJHEHfvwlJBsnQikq6I2sYMm72umBUDvidl3EP0=;
        b=QM5pMXYvuIjT+hJwvm7ZqbR2i7wUFCbW0Lpb/KmQCl7s/7e5Q6AJI/F5oeWeS+S4Kt
         L51nrwbkKa2XnPeWPS3B7KES9Lox3Xld0m0X9D+qln5QOXtAgynPOE12zxD+4H2NlVup
         PjqrEFtqN3rtn/SNK4k9lJINHVKe8tHNcHYR1ZTadGtRUBwhz/LizigH19dz70NOnjJ5
         cCFbvInbXf3KkBlzXnGh9kUAmLDSrbBZogLV8P/eLRpnMYd6+dJ5TSJulBratq8aUqYw
         5XdIwsSBEe5dbdgsHnmW9JqTuEaQXlZwih4GBMU6/nmD//hJyOrBLihZrTAyejzHLkOb
         bx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284870; x=1715889670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0i1BJHEHfvwlJBsnQikq6I2sYMm72umBUDvidl3EP0=;
        b=htVhLTo+79fDu2fBQuzp8sRwcZToN89HWt3sCUOFHTtRcJrqsfCz+gj0pXMYGQSdPL
         G9lZbabHp7UxBO3nCyS9Ib6VcVMJpCB121eMCBJzRvZNQwIiSPfb+rGaNBuuvaXdv1nQ
         MeZjogqwWjWQn6SWtmCJ9LeVKNyHUFiQnEje8tYpjKl2IMqiE3AnszOzG3O5Nwk8JoqC
         /bWphfIxwNp9qtauIvIOwpXThlIqp8ozGvGXzQWBMDdK6q5sdosVBA3jJIFPrHt9ffLj
         fLHjdGmFeDHO8Y5HlSre2xKdfipuBK1vtFGy2l6NZesLiDx/P7qvggtJ+ecYakQ0H6d7
         8+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfvuAEO6jSOLfSdU/wtLg75ulgXr/Ga+hWZwzPj3G95jxdrH5cd3Ee3GGf7lXvCLpy+PWRIlNX1FwiKZxd3qoh6bqCxG1qCflyj7iXjK1wMz+dTpxB
X-Gm-Message-State: AOJu0YwzKMlSKK8sDJuttnReE3qCkq5KuxEiXUihcWkI1PPdJ7bGKfMP
	QsSpNq9W28R+W7nN9GmyKBNyjmUhRDrUSmJC9AKyySSndD8+uxUGfC7Q9t4r0uJfltPyu6FN2Qi
	9yA==
X-Google-Smtp-Source: AGHT+IFudhQt1fRt6J0kI3URdQQI5Scuqc2zHiG+e3HEB09m93On8QGiFupoq3VY6GmzMw99gIVvhuFAdzI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:7749:0:b0:5f7:651b:fed8 with SMTP id
 41be03b00d2f7-637427ab755mr973a12.12.1715284869580; Thu, 09 May 2024 13:01:09
 -0700 (PDT)
Date: Thu,  9 May 2024 19:57:59 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-8-edliaw@google.com>
Subject: [PATCH v3 07/68] selftests/breakpoints: Drop define _GNU_SOURCE
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
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c   | 3 ---
 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index e7041816085a..e5a95187ac12 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -7,9 +7,6 @@
  * Code modified by Pratyush Anand <panand@redhat.com>
  * for testing different byte select for each access size.
  */
-
-#define _GNU_SOURCE
-
 #include <asm/ptrace.h>
 #include <sys/types.h>
 #include <sys/wait.h>
diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index b8703c499d28..695c10893fa4 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -2,9 +2,6 @@
 /*
  * Copyright (C) 2016 Google, Inc.
  */
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
--
2.45.0.118.g7fe29c98d7-goog

