Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC5B150980
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339682; cv=none; b=rdYRXFbXpgx5gZSEK4k+eK7HkSyhUKHMpFwk+04H+9nyMdxikcweM8nw/Ld6PxMNEY4a8hi4Dz2UR1tcC7UMIMQawtTom6yuXBZ2TUca0wZfeq++2yBaGwCVy0bNtlmek9dRnbUjH1r88OBFG0zNKpy4h2PBX9AFzR77pexHmPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339682; c=relaxed/simple;
	bh=rujMEFMUJCeXIRgObuSo2Y21kdZ6UmfBNUg6C13L0bU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qvoe5EbuQv1sfib0hXVr9sAUKPMqjnN1zQzM6zO6yXwwCyip8UCIxrAy/37TN+Cs6zqdcLMngkJginXLAvmMHNng3fQeKGEt7lX3B3L58g4lTEumuDqh2fJ1/33SYHJO8HnWzS0wIMAkk2FEZktZwB97aJJvDxukBa8nDt4ROkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CdguDwvj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CdguDwvj"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-65cc1422681so5444810a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339680; x=1716944480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXuQI7Rb82Ax963YHnFNfCPMg2TbL1f32XvNw+PdRZ4=;
        b=CdguDwvjabb1JP4snOxbboIlIH4CTcIy89b1j5nS8hOxKmQEV4lovuu8IX4/1ENirr
         e1KFTj9Epgi+HhlrEiKYHI7RVR+5qARtHarP5E5Y2DEO7ckzNRAJe0Fqp8VFznGFvHZ8
         Hr5PlqDkNuLGLup0b6k+rkE/jfoLJI9Mp09mSeVKDWOAhCxjFZjBkkBo1WxVSJOXzd3y
         BJwJIe7ubsnM+sy0avaOH2UfpCfOQG2BfDVdgVw3Quq9j7iHeOl9ZvsdjBb90OU9ptPa
         n/eVYy1C3ifSJlN5sqbhaDTglWCcE1+UaJ40TKCFqHwYzjvKwdzbxdapq0VRyRLmO09j
         v1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339680; x=1716944480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXuQI7Rb82Ax963YHnFNfCPMg2TbL1f32XvNw+PdRZ4=;
        b=c6jR17U0aW4/lVWAt1OO8xwsHKfj7ODoAiLLPkD+3bKfIE+HLPQlx7FH7YY9hygw6T
         +B+Zg1lQGsWxFZXmV1OvPh8bHynNZaEWWiu1/3XBTUWKAchqv5qdtF7wu1Nd6pAvwJ7q
         JZ8D7A8EuFWDrqlnLIfW5cCqo74aMP4logkinp4T2egB8ATg0Q5kz9qbhYydp5S/Isz6
         zqPKiiNMn1CK4R5/bFhUoG/lNFDdbM8Yv4PwFECqTMqB20iS7TTV4Z8kKhqWNW98FxTl
         fvboZuxcpEH2q49/LPwCsLl7VsESRh/oCbfwNJn/mJoHagz99Qn8Th8UqDC5BFnTKQNJ
         7t2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmb67R4Y2hhQX+C7TgG0zre6L3jEANt+So8ds7NvtfrPdzoAkmoNNeMcYPch2GHQ9/GxjG1vrAIrsNCnVBVUXTCXveE2qVpq5jl0cfWPfck3Apt0ns
X-Gm-Message-State: AOJu0YyEIBIXZVjDCe+GlVbq4KrXSCmPE6omJKPxR9nsWDuscfycS1cN
	6u4GRTSeGTiKiNMA5+Tes6v7JiJab7qdre9kb2LTm5nAew5az5mpN/qjETPYduAnNDjbtIe6eCQ
	pMQ==
X-Google-Smtp-Source: AGHT+IHKUKwbsVzLr9jgAiynMnCcN8AgBIIJwckaDWDAaS/0uV+IF6Nd/yvWpAr4baMiUsoE3FbLBWiXKVA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:40c7:0:b0:66c:d006:9b62 with SMTP id
 41be03b00d2f7-6764d4fcf73mr1205a12.9.1716339680511; Tue, 21 May 2024 18:01:20
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:23 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-38-edliaw@google.com>
Subject: [PATCH v5 37/68] selftests/net: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 522d991e310e..c608b1ec02e6 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -26,7 +26,7 @@ LIB	:= $(LIBDIR)/libaotst.a
 LDLIBS	+= $(LIB) -pthread
 LIBDEPS	:= lib/aolib.h Makefile
 
-CFLAGS	:= -Wall -O2 -g -D_GNU_SOURCE -fno-strict-aliasing
+CFLAGS	:= -Wall -O2 -g -fno-strict-aliasing
 CFLAGS	+= $(KHDR_INCLUDES)
 CFLAGS	+= -iquote ./lib/ -I ../../../../include/
 
-- 
2.45.1.288.g0e0cd299f1-goog

