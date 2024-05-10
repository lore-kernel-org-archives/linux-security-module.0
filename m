Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE8617722
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299750; cv=none; b=G1M8V4uCv3aNFfNyBmcZz4q0Yz5xay8hKVkOnlhHZNg5jXOgvAHuruYXxHFYmDcRBgaFW173TE9DdoksFpbYH/wijQowz5MtAi35oArceyHMjvq1gc1DM4kW9l7VRopoP8UEZje2Y529tTBUY+Gxysyebe0w3lkwqVII67RDix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299750; c=relaxed/simple;
	bh=euHNwBS6Epsw1wGiLajK2FBLzSmnArw8M3ba7LO9eJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n2PMmZ61X0xgo/sK01otNW10tk3lr8c+IxUMqyqTjBK2OkDBRID/IFLdtVUIlx3JDtrnkMu33X8ITkMOhfO72s94hyXivLMzuJGWPUC1rlFBzf0t4YPFB41actMSzfTPdoedH1wHRgXR4RIwkxgQGj9nu6ywBqGlpLRUCekgVhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZ6RUIAR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZ6RUIAR"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b5bc0952a3so1343322a91.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299749; x=1715904549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSnXkY+i8xBz8FisUXSmsQkSZaie1U2SXlbBYlPacTk=;
        b=vZ6RUIAROp4TeZVIOsBzL+Wq/esP4F5Ptb0waSrED95Do9vKJdY7Pmm+SwTDdlxv1Q
         A7QGcisSKcDaqVY6mZswZWJUOYl9BlBm5+++3jPqFCG08CKoZhrIBOHvpCIoEdYwjtdf
         CqlmY7ZrriAaaE/Xpy8Wa7W4uGiJBCVMbaunAcgrzhC3v7Z4v4f9mnhJhO6VZbvOMZ64
         MQkdJExyAgkO/7hmSs5lw/IJ6dEi3icChbWPwKc9EqAv9SKKtzWu4ZVH7EdudB7jGWcW
         HkaIImw79HjdMNOrRIcRLpXm/HbjcXgP59CJjqgMpguGqZ7BmU5oKEaiMXE4DcBNueyW
         yU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299749; x=1715904549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSnXkY+i8xBz8FisUXSmsQkSZaie1U2SXlbBYlPacTk=;
        b=tTiISO0CrsgEOZcoHWpUU207HQQCjsmJngy0/1WvSEvD1C95tpaYEMX4HonLjMFCKj
         PZiipPdIozL9qJHPyOI32rH41/JdDn3dh282x+VNomgtAEItBxYuXWM0Akgo9vDYqM0V
         j8ooSqmCGxNIjaCRmpr1ZNBfCwimGz/QxCoZ7dcBBvg0q0e5ni3x1UriDTg95EEU5hW1
         yFJlzdyfheQF41pvbIAk6LmHzxD6hV7idl8xVxgyd4NPw1sb0F88KlLFV1dhTFiKHHFT
         gstuLCRmpreWLCHXmmSNBrjc/6laN6RvQeg0aVeVSk1Hb0yAn5JmtH2KEEFK+dGFRDPl
         /C0w==
X-Forwarded-Encrypted: i=1; AJvYcCVrGUTX/OqhTK+WYaPJOxhcDxyMYXK4KGv2jzi2hngxU5WWKz5UFWozqcCApnnhJkSSI97K6ZjYJa2F2mbAd008p2lh4FMziimN6hB6bTPEl3EriXS0
X-Gm-Message-State: AOJu0YxJULtU06LwdcI5F5kjpMdmXjV+VfCCzwHFxvzSj0TShKe/MCBa
	Pc2+feXm90gmX3b5C2kQc6cefoklew01LYydjZ0IDc1DEaaszIjz4KodVvwspQMvFlhwt5bxO3t
	nZw==
X-Google-Smtp-Source: AGHT+IHrf8Ip06EWjJVaznBkpYP2PcAGdeazjj+Ng12mTejT5b1sQiTOfSMabgEBTdHLaeObK490rYSR9aw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:f2d2:b0:2ad:5fb9:16e9 with SMTP id
 98e67ed59e1d1-2b6cc247cb3mr2716a91.2.1715299748321; Thu, 09 May 2024 17:09:08
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:20 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-4-edliaw@google.com>
Subject: [PATCH v4 03/66] selftests/arm64: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/arm64/signal/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index 8f5febaf1a9a..37c8207b99cf 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -2,7 +2,7 @@
 # Copyright (C) 2019 ARM Limited
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
 PROGS := $(patsubst %.c,%,$(SRCS))
-- 
2.45.0.118.g7fe29c98d7-goog

