Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3F14A094
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339642; cv=none; b=hMJcl6TxNZswtv/QiQT60PNSb6CNdaqab5dmlGvlwgaB+o5NfN+MwBecmo2rZGTv1BqCEEYbj+ley4EFwSU8lbRjHzp/Hbhzp2NwsWyeVTpXmWei/HwnrRkZ0CEXH/a72CfVZzw2Vx2jK+hSWe6PTpHBHKIPAdxQdXzAVkciGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339642; c=relaxed/simple;
	bh=tVPDCN3nve/NDstBQKdFHgPixwYMad5HmQi2CbHH6x0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dE+6IjZlpSP3wu/qYgeMuYyYLMBFwI1Z5FmFnyabxLeLXgm6N8oVq8STNVppYppunVGgVcMBNguoOZZxbr+WcipgBZGieajGeiALMfOlnEujfBCrWVrar3q3oXa7Tp5ONI/SUKYVRrSt1SmptUALxTU9zJtetqAK+EDcwRq3zWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3OkDTAN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3OkDTAN"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df4dc93d0d3so975065276.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339639; x=1716944439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mMLRxOyMxZ1YbjHsp9Gtp1tVJ7YpTB/MrMb4PdfarM=;
        b=p3OkDTAN7UQb+smfYs+2KwdmtSlxl+TjRvwi9iZe/fq3K2wqne15MS/esn0+TOAKra
         3ngV6715hJHSHdn9I0Y0rQ2Th2fqNly93X6iBAkhx6QWz+CgomqOFZ/w6oQNRO9y9ihN
         3htvKw/jq9CSYoHLJKyjIdjPXQP/HIQzDRpFBB9jmWTEb4sOl8cfWAZqVa82B0RIbsul
         tcV1vg667zhlDYACpNtY4MwzYr0vZH5fUGgmynMZQEwoUZITxYKuHVlv7IaLrvfFnEOo
         dp9ljTSA7Q23VLmjIyXLCI8hkNwGLpLjTpRCcFc32ZWxFoZXOZpVOE0i37Sy33huuyAA
         byAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339639; x=1716944439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8mMLRxOyMxZ1YbjHsp9Gtp1tVJ7YpTB/MrMb4PdfarM=;
        b=OojuabP9O59xSRUhFCLvwmsBUVwD1GS/h6TFURzftdnz1XCMGKnL0dXDCTe5twCtMD
         OwFDMgHtyZHFA/gC83uKzApzqxdccU1bIMPORN266w7KweD0vujuEiuN00R7MSUkqvgc
         Xu7/Js+f7mYvfHa4HqbV2F+K1A/Z4ILKVOdY7mrUGCcYxRjogHnvc4brP039ASA9xVlF
         zbVxc8FGDPWRLyycyC1iM5LUnQf71KNrcTBxw/pbPrdNOR5+TqbKxbD2hL25OBvKDBMX
         qOFvM9Q6VDVVdG4o6giQwcprZ+uCgYwmg1VktQUvmd4J2D+nslpg7WIycDXE6gVxdQ6+
         xhhA==
X-Forwarded-Encrypted: i=1; AJvYcCV7fXcTKN71XnLAtl8lC5cG25HZkUxrbVMWdfQGgxHM515vDBUC+C8rkg8JBQo9NMxNIcCehkjb5Qk/erSDo8PR1BH/pODCh9bgXW+uBPGdWdvACg9D
X-Gm-Message-State: AOJu0Yz+pOKb9yxpiO8fJn6AdJ7QiMykp7PiimY4mvNKA+NrplozelCo
	uOiLmi9ovccNjoz+Rz6rvFYJqEXAO6hU5gOtWEqdMDnmnHhZXPPjs9mXmYu37EOI0XEdZoKjsKU
	MCw==
X-Google-Smtp-Source: AGHT+IGJ/NmC5MVevhEcAlb8Vh5DFH7n/e0XuYCFPdZ/GMGUx8MMz7Y1Uyzaqxg9/3KNaRheKGfY5j48R7o=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:b86:0:b0:dcb:e4a2:1ab1 with SMTP id
 3f1490d57ef6-df4e0db5b86mr217160276.11.1716339639505; Tue, 21 May 2024
 18:00:39 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:11 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-26-edliaw@google.com>
Subject: [PATCH v5 25/68] selftests/kcmp: Drop define _GNU_SOURCE
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
 tools/testing/selftests/kcmp/kcmp_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index d7a8e321bb16..f0e356139e1f 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
-- 
2.45.1.288.g0e0cd299f1-goog

