Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44948129A93
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284876; cv=none; b=Hqge0U8xCsqssdIaaXdGSqFLHc7QRprch3QOj7Wi8nfilEwGeshPlnA5rGvOu2v7w37r+d/Kt0yAz4vQRfxXsvT0brPtNc1jkX6F3xLotN//g7ObeomeW0bfFGTQKA3FGFBYAyUAxDc9RZSGQdqr/BYqFAsN2ecmXhlUY7B2UjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284876; c=relaxed/simple;
	bh=nVA7WynaYFBVsnuTAeEB3HhV8hTaJ/3V0zzotuqqx3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WhN77aRs2CZz0eoWJPN8Dh2ewjkYDfbjLInyQRIYDZLnJdWEXRoc6fNNk0r9leq1RauNLaOb8Uez40YFZCQ2V4A2HY7Oa4Zb8Wi7P6v/jqCqZ1kFpYVc+V3OnXSN+pOYPLyLxf+ug2anbAjMCYMy0f093RhVkcO8l3R3xYfGxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N2E5/RyY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2E5/RyY"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6202fd268c1so20919517b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284874; x=1715889674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vKajnWgRPRIusaCsN3ehDRoTdZ5to7bBmZ+li5CBaYY=;
        b=N2E5/RyY3Sofe4tQmN1U7Texo3jUIp41vSmRp3qfu64rUQJKWKqDmhYjuWVvpModnd
         blvx/c0WoXXJFilyGK01v7JPVbZki13roJgOBEm+U+K/NALmNJVVLN94OJGysuENYjvH
         AMGezGUtvHA+mlhev1JOwEEKXGmGpuSuT+WzfNl6S/DN+OmMBCfdtApJBLlzkpfXui1W
         yo695cblr5w9R01mYtxWRvKKu/v4aT4clsVekRna6C9AApMADKj6hK5ohHF+C4X6AB7V
         5BY95UjMSYr5f3PE46CyYKFQmw1nd7qJjfEUhwLQwB1sDg3CJr6fiGmvH0UKXH3RiecZ
         S69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284874; x=1715889674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKajnWgRPRIusaCsN3ehDRoTdZ5to7bBmZ+li5CBaYY=;
        b=Mzx9BuQnykrxVkBpS1IHd3WevuODjrCNp6nLgmX/ahAePrXz+kLRjRpaHlGsZFeQRg
         gmuZGtbPN+P8g2aLinRMEUlDQJW3kzadsiqlq7EFhghs5sU6R9TVCnIOgz3nT1EpByWm
         gY4lbPEVwBzjDRpL09DJPn1XBtwRaw+DMAiftmePhIF5LxkO74DuntiYBgERXGeVT8fx
         OCuoKc2o8fjswV3T/yKRLMKURM7Tk84YWu7Lwf7ghNrNCnZKA+cR/Vk4CUymErTWpJEQ
         BZaMP6KfWAEQ887HghEh3bprqR3aTtUeHB02Ne/4ouX0JkPcYrW97lGsGfKzEkvxkDwp
         db1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOZS33OufH0bXXQS9KThSW1pS+jbPTIkfMxZHUQUC2bK3mz474RMai6v11PsF6UEWPyD+fUQqx0pUUXZ4ybWRtn2QTXatG7Hg3zQuOOy6X6o7axsrX
X-Gm-Message-State: AOJu0Yy06qKTOEbLgkgtjZPSHUGLqBv2EdKQarNT6/AIx00obi2qu+Tl
	lf2RPk9FxiRBbL5aoX4JojlLZSy//1x8ytHl58MgU1q/Bf0EvQKZ1vVwLcrw7sdP3P6f8jc9hrk
	YZQ==
X-Google-Smtp-Source: AGHT+IG8BlqL9c7H6gT7HJqAjPMzqcZbchjuSJZoZPXFaFuFxFzRUA/yGwhzK4FApgVn7UGcsEa39MLwACI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:4508:b0:615:e53:1c1 with SMTP id
 00721157ae682-622afff693amr1508007b3.7.1715284874424; Thu, 09 May 2024
 13:01:14 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:01 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-10-edliaw@google.com>
Subject: [PATCH v3 09/68] selftests/capabilities: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>
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
 tools/testing/selftests/capabilities/test_execve.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 7cde07a5df78..e3954b88c3ee 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <cap-ng.h>
 #include <linux/capability.h>
 #include <stdbool.h>
-- 
2.45.0.118.g7fe29c98d7-goog

