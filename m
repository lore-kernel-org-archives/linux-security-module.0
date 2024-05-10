Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0B7E77B
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299798; cv=none; b=lKSMofc5wZITcPX06DZSCkNtgGae8wCKLXl4WcBx1+qAZ8cmm9UN/fOMXWOfFwCBv2Uz1sLGz9qhdDV8L7T/iMLsyJNGLwcnI5mzvuZjfRb4DZ8sPSW8tpb3a6tkBns+I7sB3lpdENL9L6DRVVLhOkhbxmMAJeuoiZdW6ngvVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299798; c=relaxed/simple;
	bh=V5E1tGxcFwiW0subypybbxNT7JLINL25XN24Yfq1TaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T7vlSGVSlSpb170oCewcLQAPdIc2mAVlIGh6oVFOFmUgWlcgaSzyBYTVxtR8fSrNBu7n7eNvtjJ3cQPxuicT5O3SrcWLO6NmdXnsRyDpp4AX38Ti3sXKxZJ6+um/LMWxOQQa2+Dr5USCrhM7nRSXgFgJ+lqOY7wOctTWwSLyipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbAZndvI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbAZndvI"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b2a06c0caeso1433452a91.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299796; x=1715904596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1J+0R5KvELlP/aPzu5FkXVeIoXQ70u+fel7H+7dT5J4=;
        b=nbAZndvIIkOSf2tLXqw14CLOybidung1WptYz5Mkp+wIPJ0WufJHynSFMZXE0a2UbU
         6BWquCKC2gQDrxytumhxSvruuy/v8LwzmLE+olKikTnFSKAabOJtDceDQArEyuoMc9bL
         xHLj85ClQEpL4k/DKPMlGmXpRtnJadmW8Cgtboqe17jVXjsW/kdEzONZCAIRAkDBVmN/
         LOZD6Vs/VIfTx+wPHrHJX3VRFPO5Lr+ukfDtiahvICE9Q8rw/WxsTeOlezFEj0CILMwT
         PU18tfna5Zk6fUsvXChKXCGq4PRU7jWW/zRns8oHsH4TlpVfWk5Dn91Itu9NrxYfRUEG
         yQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299796; x=1715904596;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J+0R5KvELlP/aPzu5FkXVeIoXQ70u+fel7H+7dT5J4=;
        b=PPJBHydK/JzJE9+E5JPbhLmeUjfIRFP3CLm5bJm4Fw30SUt8xFRuPi9lKM7SvP8Q7o
         7uQj515jCGwqfCE1ZeyardjLxEFkUYGz7YfzQdPH+c1p8uPpy+YdHEehRI+Guc6ih7fk
         FZCGi0HqVN+oPFPmDoSSL6OVqJ8qojxEg+V1cNJC6JeUU4QJ6XSrngi7sdMcKGmGSJT3
         YYoY+rKNLwJOeiyOwJpXm1QDsFc9vW4RKN+pqdGG6qtQ/n1PzKIZXQggbVhPfeqRRWl5
         mFZOx0gsRp1K4+gEmdx/DRngMQ8DIVbDnFRtak5M9UP8w5nQzu0O+w/L+4hg9ZfZtK6S
         CK5w==
X-Forwarded-Encrypted: i=1; AJvYcCX9Pqz92dg6hQxPBUlYmkFy7nKPytWLc/s+NcxH4u32sygnRlyWBqVJFDnOpsR4YUhp5hyCsuSjmGhRz2v+ntJ93oWzlrPWFxaSR3uNYL3fLqd1QpgR
X-Gm-Message-State: AOJu0YyiXBcShizMmX691pnCA1BpbjZ9AShHrvcgSiSxQemo97YUsTWc
	DP1IdJsYwewgVaCY4cWIhcnkafEIDSDmQFst+9pMexduRD0UFZV6hcIjveIxJhuNV72IIrWQNte
	O+w==
X-Google-Smtp-Source: AGHT+IExd15gsRZwvkH+bNW5BEjwyjUFQ6oCfGLx0KBF9mW/GpX2KB2/zfHBHHKo03HMcQ/Fo0GVALLRwzg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:d4cd:b0:1e2:6b74:2bc6 with SMTP id
 d9443c01a7336-1ef433cef41mr38795ad.0.1715299796044; Thu, 09 May 2024 17:09:56
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:35 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-19-edliaw@google.com>
Subject: [PATCH v4 18/66] selftests/fpu: Drop define _GNU_SOURCE
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
 tools/testing/selftests/fpu/test_fpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/fpu/test_fpu.c b/tools/testing/selftests/fpu/test_fpu.c
index 200238522a9d..53a7fef839e7 100644
--- a/tools/testing/selftests/fpu/test_fpu.c
+++ b/tools/testing/selftests/fpu/test_fpu.c
@@ -4,8 +4,6 @@
  * module to perform floating point operations in the kernel. The control
  * register value should be independent between kernel and user mode.
  */
-
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
-- 
2.45.0.118.g7fe29c98d7-goog

