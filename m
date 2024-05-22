Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B08E14E2EC
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339671; cv=none; b=d2YWA0zAYgNqzeNghXhxcSLq4Oh5SqNW0xQK8edNpEP/ep5OJChG6CdNPYUhv/MLVm75kj+BpF5NnyFmTW+BC61dp0TA6RFk5J08Xl+4p3f2Lqb9OAZRRucT+FuVfy06RP+HhtRRGheJzhroxSKBsdDcCWyOiPyE++/o7hmKOE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339671; c=relaxed/simple;
	bh=Q1DYva/UlSTqHQRTaRLSbJQbcMd716OlvRndqxIEMKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PnMsQe726+ossWeedZIre69ZCzy/ur7JpT1IMse6OcGaXH4zwaXOZx1u2L9DYencNwiAfzMx6xSUXuG9HxVQi7DV9/pUhAXfWJW1z5lFdM/ZWD328nIBVz0UieUidna9z1KF1xcl1b1Z3QUepU0RWZ8Z0ouKB3VL9ROGPr1tV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOQ8+flE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOQ8+flE"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso299838a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339669; x=1716944469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJwY8xyYNRiC1Lf/cNUb5+1Fjc+rjpWOX5XY3I8SjaQ=;
        b=EOQ8+flEjYW2CaI2fSvb/awYMRqYUEBFDBbgIJa1WJxeclbPWfA99fxmx3InrLsAn6
         cIyf7iRvqmHX0Z29WXgV2XxtF+DjVcFZi/i0q3qh0HOrtjSS5B1u1PezsFJayNzqdgSX
         xOx4tOM4AwBrB7LqkYMxkrxLXXZ5synGiD19Upix+XAdETGaIFBNiUaD/O2puLjg11ui
         KnsSIRTmc7NNmGEMWD+ISHmTw767urp6leuMLalrkIJBmZ/y4bx3OhwAgZyUyIAY7bFR
         YK7klDiLWmObuOQTtSSn/KbU3bgtZCNUaVLi63ILEB9z85JrmDLhYhjHjtAUGofpBeFN
         WUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339669; x=1716944469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJwY8xyYNRiC1Lf/cNUb5+1Fjc+rjpWOX5XY3I8SjaQ=;
        b=ZcaC+sX+87M73RXxjjOlq5NPDt5IqT3zyJ92226tRwRCU9Z2vpXDpEl+1AbvBj6ygE
         NZJiU7VC0LlerLlla55HePZPSANMF+/20yIZFIJMi5XTQ4sAwBUmqEn2Y4QxCCeKPQkM
         gFIIdIoXeMRi+KdBKd0i37tyKkBUq/+ZKmeS0FNkzMYN7A6tzzHT7P1vVjatGHrxsB4I
         B3AtwYA7rQbRJjGZE7Jun7QVo/HTHXhNz3dJ5JyJVuZnKbEEucwL73xbp/A6X2qsOUw8
         qhGffYBAo3/VWnu8V1BV7TWH+pdKYrr0sNMNFG4CbhUwS0BXO9Jt92esTGiiwpBwUcVd
         p5dg==
X-Forwarded-Encrypted: i=1; AJvYcCWTdL3mppNF91jNfP1O9vsrhGAmPU7uYX1hBFHEjLpW0wc6I/+4Sx/NKodiU2wrgsgy+ItEJ6R5fUgQygoMCzdX9w6L3EsGVYsw1Fp809RJrQDRcBRW
X-Gm-Message-State: AOJu0Yzm7QEBQzr2ki1/+eO6z5+2A2hDEppT/x2Pq3+VJO8M44+eztng
	cYiJZ+oEcXFcAJD2Uic6qka9Xl4IdpbLsP7Hg5B9rjnN/Jv6E04eLtUWeYzlS+DEMwjTa91srWY
	WMA==
X-Google-Smtp-Source: AGHT+IFZBsQUor32p70/JGSv4CxrWGq3P3/GgKt0fp8qEjq29ivxGwqV+wZBWF8r2ZaamU7fHDxr90VBVeE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:6684:0:b0:657:8a55:89b0 with SMTP id
 41be03b00d2f7-675f9b7518emr2395a12.1.1716339669398; Tue, 21 May 2024 18:01:09
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:21 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-36-edliaw@google.com>
Subject: [PATCH v5 35/68] selftests/mqueue: Drop define _GNU_SOURCE
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
 tools/testing/selftests/mqueue/mq_perf_tests.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index 5c16159d0bcd..7be29c3bfed4 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -20,7 +20,6 @@
  *   performance.
  *
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-- 
2.45.1.288.g0e0cd299f1-goog

