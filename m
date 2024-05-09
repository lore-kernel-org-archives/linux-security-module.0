Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09D147C61
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285031; cv=none; b=h7WT/PuH4Gb5ABGh1qZ41Yv/WX6BaZa2UpSZceBiLQCFFdY4Khx8UQad4j3k/hXfTQ3ziNqsTVrCKbLAKcr6V/iTbO0ca3FAyNreVODaXUDf+pBb8Xh0iD2fh+yfhX8ijkqYrdVMKciyZd4Yiv+vhaPbRO2rz5Bfz6SY3fLCrJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285031; c=relaxed/simple;
	bh=BYMEuhcBRYdrdeW7LE9Reeo43EZwSWrRoGWRRX0Ndg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Djqpvi6+S+X133WWnNJsZ61RqpOB32NqDjBW506yGaaO3IB7d2Z98nXFQuSYqqTbgvkvHZAwiEqfys7p1fCvKHRPk56oEa4z3mJY4OZFeh2rHMkYRsWV2HCicNU9paNzY2DteRMG+wsgoEnBhbS/rA0+G6MNQMwMGHSqPeBjnSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1m59eiKz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1m59eiKz"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec48e36217so10468775ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285030; x=1715889830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYMEuhcBRYdrdeW7LE9Reeo43EZwSWrRoGWRRX0Ndg8=;
        b=1m59eiKzHQE9r8P8Cbk4EeNRnPxmuKZoft75Yqkd3YujNHTQuZuZTdJBthlVTdhZ79
         och+bX86LBA3SiR9lZgssnmcS5bDoxVWeBpJc0IZfdPWn8LYL6iCtqy0/CjUd1nmr+Y1
         ZXl3qtbs30xLvFBIUNDt/O8NBX3CidJccgkld+91aAFhpmAvziTe4otsbZpl9zVsFR8P
         nM/u+icmcxO1Go7Ss8lPIwHeQevu8F3inRx4ctKcH6L5CMEYqzmCcPsU4tJAwfEHR3/3
         ET2kFFwKfImqUN5P0bl6vufBOsnuEqqXlMfICg+rz3QvcC415RvfS56U44TQo0Xe6jxH
         U36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285030; x=1715889830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYMEuhcBRYdrdeW7LE9Reeo43EZwSWrRoGWRRX0Ndg8=;
        b=tD02RaDUxHwXpR+XXewmHn3uGYwaKI+ILnKtXjj8FBvAD+0rA5X/bDMrOleWcOQ03P
         G8/OwwLCSdiJLQesDKpenMnj5K2CV/AEXiQRi+5oOp9KVTSZRhahlfBIjYEq8zKf47kw
         1AjYr9Ecmuam6sEWoTmRjDYz1BPionILEBVycLgAX41ncV2RbcacKElruzGhYoWKj94o
         u2S7FnBLZlTQKBpkag99+NYfGQp7FJ3z1GrYcibJMrLLf62W+cM+qkd0ZfUuQXol+eXI
         sip2SGM8h781FlrmMQIoL9Tp1hsLYn+YFHxQvwIrJnIoVY7A2aWfXxjU/JNVGnjc9nqu
         yKzw==
X-Forwarded-Encrypted: i=1; AJvYcCU+sjI5S51ud7eBHxg96JIAVpzXj1HdLqBgdlr3I6dZBO+koOYf7CAcJG1nOo6tzbWpMuWzKzoCbMXEvaY466L6QqQNZw8PsDFtA/+xhZ62Yzus0fuI
X-Gm-Message-State: AOJu0YweVMoPNxVUJUUKnqSeBBxsT44PJfsMApICr5RtEfQPFxqAwUhx
	r3S8dhG47xFNyRTDLMU4tqmnbl1Fsl+G8bzjK0I9VeRiO3iffN/zh59svbEwzoMjooJrkfJoN6Z
	9lg==
X-Google-Smtp-Source: AGHT+IFK4/DhkdFo2+zYDUlJPAtp8Ut0S4wXPjECFM86q7sbokHSPV+dZI7pDpMCgQzT+UzCnASUoNwUkRo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:eccc:b0:1eb:5b59:fab8 with SMTP id
 d9443c01a7336-1ef43f4cbe8mr20555ad.9.1715285029544; Thu, 09 May 2024 13:03:49
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:55 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-64-edliaw@google.com>
Subject: [PATCH v3 63/68] selftests/tmpfs: Drop duplicate -D_GNU_SOURCE
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

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/tmpfs/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/tmpfs/Makefile b/tools/testing/selftests/tmpfs/Makefile
index aa11ccc92e5b..3be931e1193f 100644
--- a/tools/testing/selftests/tmpfs/Makefile
+++ b/tools/testing/selftests/tmpfs/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2
-CFLAGS += -D_GNU_SOURCE

 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += bug-link-o-tmpfile
--
2.45.0.118.g7fe29c98d7-goog

