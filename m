Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A856B8C
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339625; cv=none; b=mA4j+3lAElR03+ZSc5tXo9aqqdBHb95+aVAAmD6rdwv0XCtlEOWtCIb9tMDDPHSjAbFKHN+hqoBgG9EtBxRWGZc6h5rXFWolVy/bR6dNf93jGRJtoqKxp2qtPDd5f5jpAWgDQeuxt50XyC8e+1XCGKaSgcMz/7WDSY8gcVO1fuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339625; c=relaxed/simple;
	bh=h2u1MofALu0r1tYsSYukYszzEq5gHMXIX9iUm9aPpv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EO9zVv5YFsMU4wJAE29uh1fAwlXkNxiWa1+Zn3H050jKc1ojYSkrqvVaP/mZc9fvAJNgS9vcVCO1R8ZtQ35hIzMflcwOPnG6zBHXncPf1lYStbVdwYP5BGHsjr+mZlEga/I1ieaD+Mjl/27Mu1KxGHdc5jv4za22RCc7WcrAM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yLTtOhdx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yLTtOhdx"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1eec5aba2bdso117445035ad.0
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339624; x=1716944424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NK4aimLzcbzcHbun/AiqJMn6SwzGMo+GBjyX7d91cEw=;
        b=yLTtOhdxpJw7AIeqoZGxYnthyR5KhjOoSFpQitVZcURhgTCyvxMX6vR6juapy7h+9N
         f03TpNYeGMeBA2y6LMHt9QFomIFDpn+CVL194UM/v4taGt9aBvWdi3Fv2OhKx9l7uaI+
         OtycS5kol5aPsydq+GkLGiyi/ue/5wk60oWOoHBIapZR9nISOLaGLcJMwqcAPg6ToIir
         HSrVYpWNCIZlrZxgOK5i4ZfJMO2nO3W536FYc0ZRTTuBEu5wtuPSvWWCWgxn+uLmzO+n
         MpaNZX3StcGh5spUrdn+qtPWbrhTBHNNFHlsh+NNK7ZH8+slrAU9YQtfamDQgsXARoT6
         6rAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339624; x=1716944424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NK4aimLzcbzcHbun/AiqJMn6SwzGMo+GBjyX7d91cEw=;
        b=tFHusgjmNc3k0MHmXKFSWf1kYNn/GH8/vt+eFXCPmyinykNE7YZVU39Gi6uR5Pn6vO
         VDj+c5WF55ej9jpBOYxCTnyudoWw9pJJbIeC7xxfh6LK6GiSqnF71lAM6ns+GUtXOA2n
         XruWzmmczqonMFSDxvbMuCMSSBodOOUrzyPySHfr/Nvzt5Uy9kF9FRLs0YBOpCm0voa9
         ugMJx1AMtfYbTSpbAI9USNZLIJgwObyyYXZ6dGsA7uXFofTcPCIeTvIh7p+I/NP+72Gg
         0EZR5x8d8UzFosfM22s+csWmBN4RCGaPVdbfufJJMPcsGxr+HR/e1LjM1EQLpjHLeAtu
         yVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEfkzZ8Dn1NhqP+66cMa4IMssU7T0SQKKilCo+QgXh+DGaRuXw1yhdCshxESFNLudmxk+aCoDR+rSf/+3a8UL+b32BvLCf54MoZ7YZvPgrjDn2MP+F
X-Gm-Message-State: AOJu0Yzafce31o6/IKs8ENw519CPbRqPPTucjkxkkJIHrR687Co9dqCU
	2qQll/QhIgXB8WukF+HYV7yr2K+pGO6T0g7VF6y/K/yYee1JfbuWS50YqDT6iwj6sm3dH8eo8Ft
	CYw==
X-Google-Smtp-Source: AGHT+IEfubfbv0g1n6E/xjRKgWJVsI5mDRaAB3rAehbhcdlOwRi+21CKT/tu9kKkmJpP9Jll2mvLmtGZyiQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e74f:b0:1f3:135c:f70f with SMTP id
 d9443c01a7336-1f31c97ec7fmr402795ad.6.1716339623577; Tue, 21 May 2024
 18:00:23 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:04 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-19-edliaw@google.com>
Subject: [PATCH v5 18/68] selftests/firmware: Drop define _GNU_SOURCE
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
 tools/testing/selftests/firmware/fw_namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 04757dc7e546..c16c185753ad 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -2,7 +2,6 @@
 /* Test triggering of loading of firmware from different mount
  * namespaces. Expect firmware to be always loaded from the mount
  * namespace of PID 1. */
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.1.288.g0e0cd299f1-goog

