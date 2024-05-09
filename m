Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FBC12882D
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284874; cv=none; b=GxaalVPkDOC9D/3H3ffd72R+rdm9FzRzFpbZIjRxlWkmtqwbSfVy++QgYmJixIaAhuQdaosKqcJ2/68TW6JEEu0+PvTU8Cu05gcYbbH0daHd2DROuvJDo1fs/jHvaJeoLXYyHrJ1Rr9zjrcR6Y7Xstn6h2VLYKte57wMd0TkHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284874; c=relaxed/simple;
	bh=2/8sIPk27FSvTOSAq/0YADaOvQGisOhNEwKoHVOrwoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lCe82y241ryyAKVIOXhXC0oFcGWAy8HUSI+ywSdiG1oMHUhT8J3iu4x+fNEnhuaeceE8O2x5xw1OIscwQjoqVX8q0c8nf6eXcRWgahfboVcdZSSYzfKai04AzU5GsW1F40coFYIZlV2LgP2WvVclVtMN/ZzowFA+a2m2F2enLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQrTTZ65; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQrTTZ65"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ec3c838579so11752845ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284872; x=1715889672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dDkrD0dZYNeak58b9GqqXeIHUFk691mZ1uMk+mW0Xo=;
        b=bQrTTZ654PKwJYwymZ0RyY5x+qfOA31YaKC6jhQa17s9os3Py1XzVuKFLytTD1kkpH
         B97yslXeGW3wQBFRRryQOWSYu8jkVZq8mP+CXPA7FzgMCMJZrpOIdbEsvtaXpERtpurh
         0agaPOsG+X9ht8rFOgDQXjFWLqRaAPY0LD4erEK01habuaGK2WryZ6zfP3NfV4RpF5ST
         ASZZThuJuLPRV0TQA0upOPa66kZV0AvLMQQ03wNEt1pPxRfU9WziC5hUce8MIsjmMYKy
         HUs7sx0EkR29oQ+rkfDet7tW1d2013kWuQSS/m6Cv3rpAvTrAFSpjxaHj4fNghWwGxvG
         41Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284872; x=1715889672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dDkrD0dZYNeak58b9GqqXeIHUFk691mZ1uMk+mW0Xo=;
        b=bu1vKn/6ZGHqZZhtmHYqKZKl87Z/oLGVOP+A5gu4A9Jhdqy3jvID7F/N0YgL2Ecf1j
         W2/ZyHv4rlYG+2cYk6G65+P5KXLJ20oceX25s+2kaFB6ODZ3M7I7LlYdzmURmBt/gH/H
         ad1r9ca2D9ZoIFQtS65pziD46pCa4M0yOYoNjvsBhlZxqKcxI6qd9tneaBNSpjIrK2aJ
         Tk6pDj59qpNcUpR+wMKKC4O9pGcQvLotklCVfPiqoL96AARqjBvO8bfqX50UODY9hqKZ
         cIR4NWf8f0ozgT2uFFLZ2SX/Nws6F9Kv6neXs5kFsC7cE6XYprIQia1caXGJhx1lIUle
         r6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg3yHCR0h/Uf56T1hQDPNq9eVmuS0VeC1+Wq0/O27F/NIvY6D/yKGES9qJVcy64Mn6DVm8tcjhwEbLxCUF7RQqPeBNN//znWaYegSJJaKog2go4cf2
X-Gm-Message-State: AOJu0YzUS846dckgrex2VakKXIo1P1/jaMMOdeIFdJS3511uforFMH7U
	lO0yp/5+PIWm0G/sLx43UQjbVXPBrAxHDRVSN8tt9wNGFyxwBajWEbg1rgiHKR5kC8nkqiAmN7R
	vcg==
X-Google-Smtp-Source: AGHT+IGN4HNDJxeluOcEKuz7md9IZhJw8i2iBFbn3kCKVQqvAuS4nKMSdcwPm/QUnrOgNSxeyjub3Y+yA1A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:d488:b0:1e4:7bf1:52b with SMTP id
 d9443c01a7336-1ef43d2df8bmr270375ad.7.1715284871880; Thu, 09 May 2024
 13:01:11 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:00 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-9-edliaw@google.com>
Subject: [PATCH v3 08/68] selftests/cachestat: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/cachestat/test_cachestat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index b171fd53b004..c1a6ce7b0912 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <stdbool.h>
 #include <linux/kernel.h>
-- 
2.45.0.118.g7fe29c98d7-goog

