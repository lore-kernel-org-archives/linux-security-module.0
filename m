Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED08526A
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339617; cv=none; b=Tlt9TmDITTn+VXR85S3WaI2aoHeNaZJGzzqmKIAy8CNOCCnQ6tDmFrbaijchmj3WLUfUf+NM3Z7322D2QttlwO4/XhKKYC9zs5FuyTkt7J0zXMyyXZeNQvNCNNQXcWGK+Mtx4omZmwg19fHKwlQ5yzk7d31CXohzx45vB30BSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339617; c=relaxed/simple;
	bh=bwGxj56rDXZcmxX6KG1pualMpakVJVhSxYm/fRQ200M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TDRqCYX76pqxfn1A5MNCldbt189RIdBYUag5p+rJk9df1YCakSHszHR1am56X1wA61lNPh5KioYzgtecPFntBwZEVYikSlU4IrLCTjp+0E4Wq0UU6ES7Vq/hhYdjPQQsSLguVom2PCsRswc9sBJN5lsDRsycm2wT7tEZFYTj80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JAmk3JAn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JAmk3JAn"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so22514795276.1
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339615; x=1716944415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SekOhk5uN00IhSEFy2Kx0Wz+un/KHciPZvQ+RL+rSjU=;
        b=JAmk3JAnfNrgh3tRLQx5oNewyBfaUFGJko6bCu068aDSwyY/WqpBD1KPiBOFmgkZf0
         OvHd28CyFtuEvSLmUgbiwDzanC6HzvxULQDEPsl4D1AN2AD2QtV700LQ29Fzk95hyoSW
         3uzTUFqNt+wCDTQY9uKhGsiHum6NspzXYvR/9fwEPdOSaOyk2WK6j2dGiP89Ya7mTMOV
         3WBECTHP0/YhJPV434T/v4/e0Tf5/+UAYOGrnAvbkxJC9sBj1ZXAS8m417pqHXMsXhRm
         1DHQxjUfjdqFrD+6ULatygRIo8FnSuM/d+5dcYX9icHuRe2ROC/TYooC9wrwIN2JTHuJ
         ctqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339615; x=1716944415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SekOhk5uN00IhSEFy2Kx0Wz+un/KHciPZvQ+RL+rSjU=;
        b=b3FuqLlrN1dwwll7sxxM7jhNOlpaW/CaswyESU9oqriU3CSCMz7CDVWZCj4XBwsDES
         dBYFwQUt7QVEDmVPuXvbeEz935EnfavU0cynLCLMWyXTDlb+DSNH+YK9CmUKyDp18FAW
         Uu6ozS9TQ+Tdxulu2RRkGseHuE4mcWdC15f9T9kNKC5Ah1g6oCjaY7ggDlFL5b3Z3Hxu
         4b8mmN1DzeJ82SizVZ2WUEhl/TW1mNcXZ1Jf8CakHc1CBzpS/qUg3eF3Q4ecue4erZUy
         OJHlUqjUathGf6GugYGGr+MkIyE8lygaUIpVKJfaBEF78QJ60WoxoTEznWlHUj9mkT47
         RZEg==
X-Forwarded-Encrypted: i=1; AJvYcCW87VUlnzk2rPXasnGoi9aU8YuQtNb3xCrx6ThOYnnhUW3W7qf5UwYxRVqRZgT/arBGY0FrdIJPiRsP2VIs3LNlZ2ICoHHfs9YkRdZD4hRVC8KYvz5Q
X-Gm-Message-State: AOJu0Yxs7lxupD1kb+/KIOwiyVqKTdBsR21R66EbG+duvC2yzYRBNcf3
	r2OknC/DuybfbiYRB3HicoOn64+Jovs+mqaR5rfh3yjfdbERxQt6gjqQTSB35Bwxi2VUo98TVxu
	Wsg==
X-Google-Smtp-Source: AGHT+IE9bSYLh/E/LGMxrrx+sHbG1nGNJ4Z5EJs4Lw6O6tg4A/yJwqWA/HgEqsXHwdInVe2s+KZjs0ddQxY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:2e09:0:b0:dc9:c54e:c5eb with SMTP id
 3f1490d57ef6-df4e0d5b5d4mr203793276.7.1716339614945; Tue, 21 May 2024
 18:00:14 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:01 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-16-edliaw@google.com>
Subject: [PATCH v5 15/68] selftests/fchmodat2: Drop define _GNU_SOURCE
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
 tools/testing/selftests/fchmodat2/fchmodat2_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/fchmodat2/fchmodat2_test.c b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
index e0319417124d..6b411859c2cd 100644
--- a/tools/testing/selftests/fchmodat2/fchmodat2_test.c
+++ b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-- 
2.45.1.288.g0e0cd299f1-goog

