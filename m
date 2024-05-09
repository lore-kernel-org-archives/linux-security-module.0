Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064314430A
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285005; cv=none; b=ZQ6qfOb6MjcDwD7eYXV7JBDNVxDoCIOOstZIvCz+8Pnbzyzxjl1BlBMBJErEXHXooRINpb0/AOj2uunVHLsIZMEDjwaP99ZQIdtisn4HUh0phNZuA4ZimgPmhvMt3XgBoZbXTfTWM+s4p3oQ9JYGskb3FrnAV5NpSOjNvRqjnOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285005; c=relaxed/simple;
	bh=FyDpjnuFxTe5yKtqyFZz53n3xSPE47XRG3FQlA/e46M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ILj/AmZaiSotiXpTZpK9fbZevhfD9JHE5xlbmn8F3UNsLUroNsvBzt6HX593sAmd3OwgDCHdQX/IBqMutO48owtroIo0CGckN88oBK8jzZxaQkNW3KgYRb/wIgiO3MUopWoXJ+o8pCw6XEcdfyJb/f/IIdeewbSaMoEglMlhIfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ObOw/Du5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ObOw/Du5"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f454878591so836117b3a.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285003; x=1715889803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKdjVpsD7cc6ntiVj0izi2eF4LCU2xu7dOzrXEQPELk=;
        b=ObOw/Du5nGGUKYz0NRjNu/35ckEHu8mqE5BhbKkykRxv4tzof9RlR3NUN/5hjSllSN
         F6h3DJyEKewVStpSw9JbaYKL+OJsv/wlikKz+3cI1cft0Ucr1w9M3TLi4yBQPQdAmCgM
         7+P/nLv+vA8V3iALDLgiL7Ie7O0dZq89kAfcnBa3kBBX486XsBEs37d67HPYc4UgTV8K
         udhY1Wx9/opy8vBtI+fKsiPO7OWdbLlXcrQgcSwvF8unAyk2VP7XeGIuuIeM4gndDEDx
         GS4urf8VgJ5owLtniY1exk0W+hVlP62GYchP6HIby61yNxs4bfwmV6qxSriMDajwmCcB
         kl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285003; x=1715889803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKdjVpsD7cc6ntiVj0izi2eF4LCU2xu7dOzrXEQPELk=;
        b=UVcOqOFDXpYiPf4hr2K5uGbgNSA64FvKe58likaAALU+7dZVjB8SD9iFGOw6Q040ta
         bTXV3RnUwwQyuNmOgJSzaSNX3CX/lEd+bbf4nVlg/tIXEFM4N266LRVA1ZcIyY1RUxe5
         qNM9VJ5gcYe4H3sZUUdq7HWI0DXMTK7XVvn/T3XSN/u2kB1vhpqsTZAWIkYUCrCDVwy2
         KCGQj+KTye6+d2bfLQkVfZjIqfKALStwZm4lW1GJHbVOP4jvi/BmGF1HfdFn+T17Bql0
         26a0vLesmlrZfRk5LI8zFjdM6IVpepTEuBzQpYBrvZgayZFnWqnZyIi6wU46cpjjza6Q
         IymQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoS3+V+yQQf/xonaUOQUGYuCigViCEssO+eRCNUvm8As1wsNbbB/OEp4G4j/RSP1EmYXIbBBfa7bW2oo3jn/72OBZsJRHCSS2D6QypEWqYhZtWGKSQ
X-Gm-Message-State: AOJu0YzbIQJNHayZEux1eSNemKB5SzMP9f4XrfrhLl4vg/1zxS1xxPFO
	qmIhAcArE8fd7jfnzBH/lqG2BrbXairQW9M97mPXpoqgzu02F2ckf62F1BN04iCffTzJthXqiQa
	4Eg==
X-Google-Smtp-Source: AGHT+IG24YrGgs9oGH55TwJXLYWUSPdxI7zBXzG/ZOnaBwcLAwEEtD/PozwH2fkQi/h91ia9Pf639lhh6mI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:a17:b0:6ec:ceb4:d9e2 with SMTP id
 d2e1a72fcca58-6f4e01b9126mr37232b3a.0.1715285003556; Thu, 09 May 2024
 13:03:23 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:45 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-54-edliaw@google.com>
Subject: [PATCH v3 53/68] selftests/rlimits: Drop define _GNU_SOURCE
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
 tools/testing/selftests/rlimits/rlimits-per-userns.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/rlimits/rlimits-per-userns.c b/tools/testing/selftests/rlimits/rlimits-per-userns.c
index 26dc949e93ea..e0b4f2af9cee 100644
--- a/tools/testing/selftests/rlimits/rlimits-per-userns.c
+++ b/tools/testing/selftests/rlimits/rlimits-per-userns.c
@@ -2,7 +2,6 @@
 /*
  * Author: Alexey Gladkov <gladkov.alexey@gmail.com>
  */
-#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/time.h>
-- 
2.45.0.118.g7fe29c98d7-goog

