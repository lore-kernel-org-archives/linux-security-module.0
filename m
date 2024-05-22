Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC55314D70A
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339664; cv=none; b=ZrNWgTXsm0s53pZVyJKWQX4NQU6unNgp9ys6TjccxT3nciywMDMFIKST88k931/MiYumaA8E0O41rjjCJBO1/KEoZdvav2j7k3w71FaX7+ePmtAzMYuOWqjzhf0V7LG/gbpDnrFOc6JP7tXkiK98RsRY6E7aDttAH6MEEeTnt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339664; c=relaxed/simple;
	bh=L1CR96I/OKaP1P4IlG6D5+TQKAt/OUSZ/m3bvebvktY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZOlWENiyAwS7tPgN4I/hgngWPCWDPxzEAYtWI6qvynn6/ZgG5PykSZtKOOPbBe181vykZ6Z5UuAoRdSYwkp+x/aGDdyg311AJNBM9DXrsvcLzC7AwjFqEaPHxcJAN45PdnlMC9sAec7hGXgDoVrlGHcjoGMqUNkOxXHDI9NzshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ptrc7+D; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ptrc7+D"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627e6fe0303so2048017b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339662; x=1716944462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNYd9WLAMtXto9r5wZywfmnRKL4Xp7DbTMTwTIIZc1U=;
        b=3ptrc7+DHpo5Z2uFFxCCvdB1yQWxjrxuEPtnBbt9Q9Wv1v9opF2N3VND/L1e+LqNDK
         7ZAfSaEKw/70QeLNwcMwmoqqDnZyachMI61+0SMNs4XHriOb6P6eFZknFiVaa1UPVBkY
         f3OGZvuOzmNu+x/t4vaJ2nJBZzZZ1GyHfFmrOeqp+Uf/+mnTrPvUmwP7UNaRvYFBVjMW
         I7wK6uk1x++3P+99G/6ZHKThJqtmga1VJvOwGp5XZJxwHYCQZb/h0UQSPUpU5pUVcraq
         rQHBayJuW5boc1bhKQaSg/JpZc5eBpH1ylB+55gQbmexAdQ6ArdvQeBQXotXRynD89H8
         TFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339662; x=1716944462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNYd9WLAMtXto9r5wZywfmnRKL4Xp7DbTMTwTIIZc1U=;
        b=IMr8w5HF12MMdwXcqd8iE9i5ghdltbOte3cafUpRJ3Qb31PE5tEH6rPquvK/G7gd0S
         2wicV6AlbRiATSYqnU19veV86/deu7ihTMoIs0P95feYisc6EsBKfuGhdQFl3C0KIXMn
         +9y+2ksXKPONSXauQaW/2whd7Y/pC0CD5R6tJXi9pia2eQZhudPnsulVY+G30d1aj66N
         lw8dxKbmhsO399LtW2qh59MEqgQ3wL/GH3CYEZt18wJXrbgXCFrGonWJvS4ZBQLlNfwx
         MzNkp+Wzhx3PnIO3eRB5JKXpWmkxQlCWE4cblutjwDb8vgp0yF6/nSJK/iOWdqgskxWs
         NPbw==
X-Forwarded-Encrypted: i=1; AJvYcCXOxvm5r8H718Uzr/m87wUlpCeNbJyPFQur1mq5f88kvuEettkYiLyCNGsXH32zmTzFvG45vnstXXsqol9pkZn6UEKseFYKi+p2hSWZw2R3vqMrIfk8
X-Gm-Message-State: AOJu0Yw0qwF2H33FF7hwXLI8HBh0W5okFRTMB1OpEYLhxNAFJn5B+ha6
	/BGKNzjSuxo038HYiDgzL8SLUx0wPc1gyKliCv+yZBEp6YS2JAKZVIwIIFJNKoyUrt/LHkLlVEy
	T1A==
X-Google-Smtp-Source: AGHT+IGvJ489QQDb0KgifWCogWHmTsAg74XgHxgtSKVsW0Rsdv0Ifz5z25Fo5jer52C2SyPHmPiOLDqfRaQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:db4f:0:b0:627:dd6a:134 with SMTP id
 00721157ae682-627e46f6335mr1764617b3.3.1716339661939; Tue, 21 May 2024
 18:01:01 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:18 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-33-edliaw@google.com>
Subject: [PATCH v5 32/68] selftests/mount: Drop define _GNU_SOURCE
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
2.45.1.288.g0e0cd299f1-goog

