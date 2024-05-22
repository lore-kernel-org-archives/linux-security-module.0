Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440114AD02
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339653; cv=none; b=DhEFnZkDhsWIfhtP0JYIpYZahJdUZT7WxzmbcHLQ4i2GMc0iI/Fso2oukk+IVn/LoC4dvGa6RKKFbSgN+RkayHgf+FjPcCSWhGYWGvtkkcEriyaEq8KpU1rj+q3VM8ZBvod2SzkgbDezC0rqe5+lyhH9U3iP3JMO4CFEZi72bl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339653; c=relaxed/simple;
	bh=7z2cK/G7kUfriq3IqJdcywskZOy0/wDKMEFNF/o0umk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LO9msjF5ewl9Ycc0GbQx56QddhgSz5Id6o8qsM1g7sPMcaS6KFwTw9c5pnScvgbRmaSM9QrqyK6MKUOhSZdbZngfioMAO9nDHtRC6dqzOGem3CUV1Plzsz1iVqtN26ClACJG5HBss0FDkfPArZNquYBZ9GFuvzRZYQ8+6wVE/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+aoStCl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+aoStCl"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627e4afa326so5025067b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339651; x=1716944451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N8L5ENa9saWnWy7VMZgJQvy8O2UHKdWgDS9fdPg7qj8=;
        b=k+aoStClS1UiazscDoVQLOM1WVf0RmO5j3vCzdBb4D8uC0FairiuHEy4kDINYQG92Y
         5Yk4v7MdtvSR1nCWWK9aibo9JsUKXyXIe14d+RHL8dNZkKw4toInGYos+KiTJTOIEWPi
         tb+uRifwGfehat5dUl2AyYXhlw1MuLA/gYufpEuJifwEF8OMZdgZJXjOebj7ygE6tTSi
         22Rji/im/i2tUWn57HaSd1sFPousoaAvCyWrUJS8oa5yfLdY1RZ8/8q2cdLUSbsLWYuA
         AaN+29Eo+pEOyivrB6z0OQDnXxKLMUg9Kjcok0QYXhpwuUZ5RiNvrGspG2yEGUMEs18W
         Dbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339651; x=1716944451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8L5ENa9saWnWy7VMZgJQvy8O2UHKdWgDS9fdPg7qj8=;
        b=XncD1zWPQitcdB+gtwM1NdPiIJ5AKO2lceneOoKd60whOk0VSt6FF24G/hjw5SrucL
         d5vS6C3OrYXgTaEj4nw/X2xLJ4vumHtBhTGKsl74t2RN7c55Vxxc/hdWlpnOq7XFU5MQ
         vVGdN2upTUmkg8wRYYAWDrOqw1l3X64mTPdqFxjjV5ihsPuqnjPCQNu2nBD/TYTwsW6U
         qLbeYlgrkb46SVApPDItsuEpYDbr3weXZJb3Sle3drmEX/org/eUgTR3iUaBcTvqnJkw
         SlqwKFMACniEoOws6bSFFtEYLXHApcpbUB813LFJOMUBExth4uhE7jKmBO4Oxgis19+U
         Ftsw==
X-Forwarded-Encrypted: i=1; AJvYcCX46CDegIEnMKFY9ZhII5jwH/WxKlpdWrsMsyB2DsPGTpGd0gxZ1SdPDD0QejQlrV3dfrVFGTCT4xea8t/c2yTMBB9R1hm8DbyvQQ7zs7IBbokX7vpt
X-Gm-Message-State: AOJu0YxSXLKwgJLuMTEU9jIlE0y9zYCZuWbl4FljtkpzOHSBzWODo5/9
	MbVC8DlRj5wbLf50lDry3kE3V4QlKahEXl5adlbeW97MPzeVwt9CQzCAe9BFivfd03ra/OThMx/
	0uw==
X-Google-Smtp-Source: AGHT+IFS/IZw7uE/6kkYjIq+Ri8WqRBtijmIEiJcIQSsTtS4Ny9KcGMsd6Vyi/YUNyZQw3Hok9pzmfMHEIg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:d5c7:0:b0:627:8b31:e81 with SMTP id
 00721157ae682-627e484a333mr1542497b3.5.1716339650801; Tue, 21 May 2024
 18:00:50 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:15 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-30-edliaw@google.com>
Subject: [PATCH v5 29/68] selftests/memfd: Drop define _GNU_SOURCE
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
 tools/testing/selftests/memfd/common.c     | 1 -
 tools/testing/selftests/memfd/fuse_test.c  | 2 --
 tools/testing/selftests/memfd/memfd_test.c | 1 -
 3 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/memfd/common.c b/tools/testing/selftests/memfd/common.c
index 8eb3d75f6e60..879d4f4c66fa 100644
--- a/tools/testing/selftests/memfd/common.c
+++ b/tools/testing/selftests/memfd/common.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <stdio.h>
diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index dbc171a3806d..e35c6909f0bb 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -12,8 +12,6 @@
  * the read() syscall with our memory-mapped memfd object as receive buffer to
  * force the kernel to write into our memfd object.
  */
-
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <errno.h>
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 95af2d78fd31..ee019b57bb98 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <errno.h>
-- 
2.45.1.288.g0e0cd299f1-goog

