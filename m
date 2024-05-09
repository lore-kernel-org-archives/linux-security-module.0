Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56F13C3F4
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284944; cv=none; b=aAqoqJlsJ54EjpykouB5hGUcNI/2F/n6lcQ6s2ehIBQ11PeXd7FrUr64/7fWwJOedWLTsMoYz+CiAyatc86+4rFVt3zHs3xQuAibI3HtKTrXtmLqrZ9papT8tEIh5ooTSVl4RPyWVpH5NRHDzVM75OsCM9RG1jGmdXMYyZx1qvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284944; c=relaxed/simple;
	bh=WE+AR6jouAPRHEvvVzrby5R77phYzayRUTXYm2QB4lA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=unxGkAyVzyGW+Pjg+9XcUaNwJBgf4ZzUpJWH8QiJK7ZIWE0QZOKO8/hF5d5P+aKogyRINwIfdaqD0gsey6cMkn7fH+Ylcx+bsICnHBaz12HzQ5cHB02fppWRof945bnm0X0sxzPppD+fsaDHwkJ5qbedQ9QGlCERkdVPwKeB2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gssulq3W; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gssulq3W"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61d21cf3d3bso21283397b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284942; x=1715889742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/Pst5TQmmPDAJyMHgqtrqTxRb697RB0f9O6Gjfco/Q=;
        b=Gssulq3WpORjjD4vxfH4Z40X+EaJC4itFJDq6Gm51rxmxNX20+yOnAl+suHO1MypeU
         nSyWvrqm8VKH7ZxaZ90ca3DBdl/cthV7aqSqD+daEgZjw3YzYBEMrTupp+WB9xTQ0Kym
         nHtCW8Ok/u0g0C8RtnHodDvZSaYc6GPWfcgN3XUfbK/Hb0L+x/btgUT81en1gWL+Fo2u
         kY5HabqyPG+iClxgy/iJQVtpRANIHg9XZfEcz6EErxeXrIJzHQ5M6dQSuJcJxYjDbEc8
         +9SDHaDkIjiLDTOvw72ZkW9S8mRP9S64FvzlIGyqX7ULZa2dhyBFVa//r1QpsG9tMHl0
         4uoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284942; x=1715889742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/Pst5TQmmPDAJyMHgqtrqTxRb697RB0f9O6Gjfco/Q=;
        b=PZfwjWcITEI8DbqRAoBYV4upf8kdYeU/ylsoNBBj/at/V0NpzUjxkX6gwO600m2heY
         pPK3NZtRkn0lTEtdXOTivRhF7ESIPQ2sIUdqwqztwKoK86AUQlwH+g53lMPPSAqLQLpx
         yGCJiX1P89GuUz4u4uuo3xvfwQT+qsFnlLqRlQhh2oqv1lq5EPWdNXNYYtluScwfzcLg
         D7ORWn9d74imxhKc2ncXaos2dOCD47hqv4Trtha237e2vxJa8FvboqX095YoectPWOQX
         21vqrqaaNqDIxo09rkQ0XP4uz5fOTcwyyXUcowscVlh0V1HwKD3L3xXQuBlJfMZ9Jy0w
         QjFA==
X-Forwarded-Encrypted: i=1; AJvYcCXSqD5uUsutmvF4OsEJl0zanfQxfao3/FMY1mEyNgf7O/Z1xoW5cNcJJhYSmyUSvklYHaI9UnvPli+eCN4+sBH+l1yENMkaKrfCTkAoMoLhH2t/S7hj
X-Gm-Message-State: AOJu0YxuJXWQbujIB5k9tEYObuH7iLPsCHxM4W0jFdMdIW8MGsH2UWLH
	1YPf5tZ2euBLJbr8zGvp7flrIZt1/svmV1YPgE6g+8okr/7+ya8tq1V4ojdZ2NyqFhnFqWmU5w0
	qpg==
X-Google-Smtp-Source: AGHT+IGMbs/JaF926sFyfnviZMWe9jqmOtpPzNvsiWM98FusLZCSeXAn1EjPRZgQVmyQ81yz73NAnaM90ZA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:154a:b0:deb:88f5:fa0e with SMTP id
 3f1490d57ef6-dee4f1ca69dmr59044276.5.1715284942280; Thu, 09 May 2024 13:02:22
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:25 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-34-edliaw@google.com>
Subject: [PATCH v3 33/68] selftests/mount: Drop define _GNU_SOURCE
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
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mount/nosymfollow-test.c          | 1 -
 tools/testing/selftests/mount/unprivileged-remount-test.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/mount/nosymfollow-test.c b/tools/testing/selftests/mount/nosymfollow-test.c
index 650d6d80a1d2..285453750ffc 100644
--- a/tools/testing/selftests/mount/nosymfollow-test.c
+++ b/tools/testing/selftests/mount/nosymfollow-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index d2917054fe3a..daffcf5c2f6d 100644
--- a/tools/testing/selftests/mount/unprivileged-remount-test.c
+++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog

