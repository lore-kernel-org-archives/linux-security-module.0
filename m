Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADC115666C
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339725; cv=none; b=SYNwRdo97qUuEWl+9mYeNtLafDhgN/SphaAikPFrakimhxePEQMVi2oqp1jpImkvZT+ND16q8McwfavrH1JMzJD2ZkJc5nB5dNxlCRxOpClXcXGp22gZD6ASAbsSmy31uRBEHnAQO64Ec+aG1rckvCrqwG7CQIM39RogsFe4OHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339725; c=relaxed/simple;
	bh=63kKOK9q7td0MhpcQUXeLupUPzT9Zvc/+i5hQx2aP5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ijfiG77aXIRdFYn2lmCtcKiAtDelPyH3SZv7ERar6ZMK5s6ZJxczY/U/oFVmrfwiHkx8FMVEW5WeZq3LAkz4WOcyTIuojoQEWDBvSD4alhfe3iJ1wfyKvCxfzV2bzDwxBFF3yx6K//lM/MJ3fgftiWoIX9vzA4at5yaCR0jyOa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F99wygNJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F99wygNJ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f475e364b7so7243396b3a.3
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339722; x=1716944522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUmmygsAekCvb1sAxXTt/LLFhqw2XmquX3PYUBGtKuc=;
        b=F99wygNJJgPP1z2gxhwQdyooccpIWRNehMq2mJtLbdgccOqIgSxkaXfGnZMoFttqgm
         siXZ7P7ICY+Rn13X/ZNVNx6pLeSkkzr1/po+lna6xr0S7T/e4rY77qVWiWucvt12+DEm
         FeDXnQw58V58c7uOE+IIqBta/8T7HV16IDq02lu9MN3MZpOCExDEP6tG4QkfKWQXIttO
         +AbIbvorkxfAdcIZzm1OPhwZD6ZhHNF8Yz3CteZGeXTMJteSWmfK8HtY7GikctroheRo
         i6+jzhdHbIETaw8QJl8iuRzkK9qYhp+e28PyxOptRopImQy/21KvC5rqEsRewPIRIPL2
         x50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339722; x=1716944522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUmmygsAekCvb1sAxXTt/LLFhqw2XmquX3PYUBGtKuc=;
        b=Rz/aINnqm4LCdYEXV3xRwPgmKcrU7sPhrjCAex3jbh3YOvA7nsjvvQf0iFyfQYSJnu
         zIfoNOfpf6qI/LASqV4n96n619Zle1hGQK85xp0pLFKrBtg5peOuiDQaCdX+t/baL5SD
         T2D/Ca/EgR1iREVqo7DpiJYZm2cijvStqlHLTLpGmcvLqGjurXcZXTQDL9sE2HIoKnBU
         J41QwE7whu29lquEsxI297gAWQ/hnfGXOmlq1+srUHFuSkKHqzgM0IesmjgKYvrwc/OA
         tuuEVF4dM2Zi+TuR9+epblywmlqyv/bK3/2pJDPWnqQjSBha9QkytvB2wxnw+nV3JSwT
         w7QA==
X-Forwarded-Encrypted: i=1; AJvYcCX7aLrMCClKmdS3tHN2KZ61MXVj3nCwvTM6peaX8F87egT2yUH+m3gy9O6Jvl8QMNIz/kE2ffToU1t3g7uwtZL0PKZNgyVs0XbUdYDK2UWTTN833PXm
X-Gm-Message-State: AOJu0YwZz5iyaAbTn0BQKQovfxjvOtTi7AAMJSCbsumHBxcfKfCTj3E+
	QuRkcBppCYls7yfQgtlLkXmBdMWZEsK1G5/CmmsNMCcw2inbdLq0rpwmcTAew+R5fo5Cms8icSb
	XyQ==
X-Google-Smtp-Source: AGHT+IG4H8QACvR6bgMlwjQZlJORskEQiHsnadZ28t0SHRUcGChmPWb+2uVYxv2B/0aMSfdVlBWp3ChsGV0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:ac2:b0:6ed:d215:9c30 with SMTP id
 d2e1a72fcca58-6f6d64c9235mr20041b3a.6.1716339721836; Tue, 21 May 2024
 18:02:01 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:37 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-52-edliaw@google.com>
Subject: [PATCH v5 51/68] selftests/rlimits: Drop define _GNU_SOURCE
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
2.45.1.288.g0e0cd299f1-goog

