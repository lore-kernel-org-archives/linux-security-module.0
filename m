Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5587D8626C
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299801; cv=none; b=hcX5kyRT1vAepx8Zcnu5ZhUEm0WNZj8mhvqEzwYTZqMkjPP6nhcR6+7doXVX8bZ3cgNSfPH8KvLXoVUe/HG+Upi3TJOi6hmDx28wxGV3EKL34cgs69tblm/77hNv7FGQ4evmaCPSAZ4ua6UphqzMRGfAyl+tIlp1q5IEJVnbf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299801; c=relaxed/simple;
	bh=NS+QgDPuHwkS/IkUVppos2L/t0CSidNHyGZCykoSTr0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fUf0f3epVNGSk/vsqrd1QQwxp6Mt0IWmnsfNI5OXF6ouEN8joaXJjQJjGMN2n0gVYju7DoBHtzoN0j+kpo79OWSeE5BtNSziTffAt/wke30AdIagH2dXi89picOe2ZSt5eGSW//qMU2SzR7ZG4/b1TLQXxZjhrCfTUpIfb9eBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBckDuJk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBckDuJk"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f45487858eso1034607b3a.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299798; x=1715904598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6h0yxxJBIGq2jf0OFxRdvAuf0GSm4XtFP+RSMXkmCzo=;
        b=EBckDuJkh5fKVjGASYD3bXdmJGCL9jIZqYxIU++1Mi/S+jL7wN6/AKYOb8vLaYA/7U
         y2DRhRRUE9KH7lr9LjWrlXPuyEba6ToYnckGhrC+QyW93LU8QAj0QRpFslqVQnli3WcP
         I2gPICU/WKRuGCFPPl4Z5j8iDB2zqeGqczV/dksLIQoDNJ1ko+ksEr4C1bREumloY053
         rKDbyXTFkAoiiEZ7ue3KR7v8IXbCJdva9DC1mrK7NoJ6Jph0rsVP6vBStgrSDC0PJNjS
         kKbnYTjJ1i1iNkCGGerVMwTfiXlPBvGuhsQCp/0ZtpLiawPX1vFeKe4qrs7lbXSUYez9
         HQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299798; x=1715904598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6h0yxxJBIGq2jf0OFxRdvAuf0GSm4XtFP+RSMXkmCzo=;
        b=He7G1YKmKhRYzr1ISVfyqwS1clUHdG8vYohjOrgjZXLMVDCrPJbseOx9xnmnKxsrNg
         fZsiwQHJjB6kftPHMRTZU4lL00mbB3lSMMpiM+he3fusW8f3Duu63QpCP/2ZMcuELDwL
         hmXTTHaDUb24HhVliy0pAPKFWO31hflKg/x85p7UoascKCAaUjoUmw0FdAAgvnOjbFl8
         xyslQ8cDSK/Y5ObhAGhMGDugunmnDVFNQh85UvdwUZUUqZPgeh/9p3VL4P01samy+yix
         Zsma6GneBUTneCfdXYTat884NTo19wmhy853KmJGbNVJHQSZrzhv2R8bVeAuyWqGNmom
         tzsw==
X-Forwarded-Encrypted: i=1; AJvYcCUiPg3KpI0onDnXbWjeY10KhG8ncegZ8FI4HsF1WCmSUK4YUlI57q35HuCTu11SX0Z5DNVJ80NXPqC2yV89EqvUF/incHJbqE5inJtObR5R7ImKfVsV
X-Gm-Message-State: AOJu0YyyTADvSLquIUVjHzcGPTvaNHyfNoB/1pxThSAxCBYhed5DHeD3
	H4PXqZr/+HM6Ro0tRNM3gQVR2R3P6MXanSkTGZzjfxLRIMUyt0BaHZlxUTEPev+2I/JGXrzFFwW
	B8Q==
X-Google-Smtp-Source: AGHT+IG39H4pksU0ri/+4ci/+CMifWOpp212NwWMPxr1jqe+yuMoJVZrhw9Tl2uxP+3cDEXB3PYnzZeCYzw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:1d26:b0:6ed:d215:9c30 with SMTP id
 d2e1a72fcca58-6f4e0415f96mr2708b3a.6.1715299798449; Thu, 09 May 2024 17:09:58
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:36 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-20-edliaw@google.com>
Subject: [PATCH v4 19/66] selftests/futex: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>
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
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 7f3ca5c78df1..8e41f9fe784c 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -16,9 +16,6 @@
  *      2009-Nov-6: futex test adaptation by Darren Hart <dvhart@linux.intel.com>
  *
  *****************************************************************************/
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <limits.h>
 #include <pthread.h>
-- 
2.45.0.118.g7fe29c98d7-goog

