Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327385C7A
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284935; cv=none; b=ObThkTZl7S1+xt8yRappKQjVzHYZ7EnRZK43DuTeoRJzEhg2eA+csCPGhI39klfD2rb9BcJCjPg4abpHtmF7wV01JHqaCJtSqLwhKIQZJ2qTGLsDvzf+1iLyyQfqJPG6eHCJ36fgcsG/mAAxb8MyrVAD3nyry5am9oUQHTlOFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284935; c=relaxed/simple;
	bh=Q8vMNdjv6oUz3ffMNcoe90QZDt2uRoBqgozhP5DTiA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d80/sMHeykQVNN7oKWeBG+MVbl0kPU9JyLPtZWoiTmWNrOfXeXiE2oUnxM+dtCHqpaOxuCzGA/wn3uJIHQlroJilJ90Nw360VZNjgpiwb5XCYPP24DrWMZe7que7NJEnfI0v7p/mGbjD91tkZ8tIvIeGBY7QkS0zFkXUDWzpX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFTp/NUm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFTp/NUm"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b2ef746c9so20915047b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284933; x=1715889733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ea0S0oR7atF2Lg5jk6+sVnhZ8gGTM0V6dmG3kMF6TeI=;
        b=IFTp/NUmnUR+jPPz4ujog3zcMgIwi3YGl67rPta55u0EYf55NSd92iDLr2zqaMJ7Ge
         a8fMNeB4LzFmiXwz34o3m+tI8GnDdJ+ie3emfW5JcPmxnXx7gYSvly1UWadyXOmY9h5v
         kDWJ8Yp5IfDhmMylqCSkgemMI4oK0PtB7qXiuB1Kb50H2b55NXwB6rtUmNpzJexISHju
         2oe0f9U4h+k54Ha7p1H16kdt5DE7mbYTMfvZpKiOy/x5QbcvoMkk8IJXCAGljyHI1G/5
         D8tN38y3Nv52Blzefk+23RURsZW2ZEM29+cf1dl8TVik3dSk5Fc+GVXMU6sDuYCo/ALZ
         lq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284933; x=1715889733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ea0S0oR7atF2Lg5jk6+sVnhZ8gGTM0V6dmG3kMF6TeI=;
        b=F0vD1e5/jrwuCHvenBvbOrR+2T1oDAz5Kbr2ntslGQDwne4QPE1nNpCuUSpGkhxxkw
         eZXbck4ZiuLJe1lJqW/z0/f5KToJOIUxy/xMM897oQcb4EHyQUR7AVZBaBxBpa+8hHfl
         g7pqLVLxWKx/R0eaahPo6bbgXyGVuVBC/+p4Xa+XSqyteRa7rpkFKd6UhMaQRxIsTmsa
         Gb3B9NcedWilxmxKfpUWL9Lb0wsbpnLAn52vsknx7m0MHhIpJxarzYD2xYfPOP+3xDcu
         9GKgjEw5sTrC+volkBA9FFu88/7HY7+vfy3IzOrquymkeVCT3mi+7/Ldie6DCzJYGhB/
         As8g==
X-Forwarded-Encrypted: i=1; AJvYcCXZE4ry5InMGsp6jrc/uR6uOFjvRyv0X3Lam8gMwkthxc4LUBRruElMLz2LJ7fpShuDSJ/xGc/nX20JUnm/XApbJhrVXrCCLj49/oxoCAso/9GXSlTo
X-Gm-Message-State: AOJu0YxSyEwpOYVjeW1R6/+BHfTDriDfM60VAi49b4QmsgvgFy0AzJYf
	Hiq43/ISiewStv3IVirkq8lDaY8lPS/iL9q1oJkEDZuXfqmufeezFP1brgWdDcJnIfQVXNsEgqX
	w7w==
X-Google-Smtp-Source: AGHT+IF/jnDS4ymNWQMUF/oWdD6iqbobUDLDZUHVjJQIP+SRjrwW5c29IOEMwIEB1XpBJKq7KUUsEHKahpI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1002:b0:de5:9f2c:c17c with SMTP id
 3f1490d57ef6-dee4f37bbfbmr149190276.9.1715284933545; Thu, 09 May 2024
 13:02:13 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:23 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-32-edliaw@google.com>
Subject: [PATCH v3 31/68] selftests/mincore: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mincore/mincore_selftest.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index e949a43a6145..e12398366523 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -4,9 +4,6 @@
  *
  * Copyright (C) 2020 Collabora, Ltd.
  */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
-- 
2.45.0.118.g7fe29c98d7-goog

