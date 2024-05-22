Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1179139ADB
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339596; cv=none; b=FgAtowgLcJMoBxM+VZqoXVpY2Xz26xGuKNkDiwx11Iw7RGv56mUExUX2wBqIXmEElx43LLmfkmq8i5ODA0rttg0PCMFzAmi77GHc/laLGCrsYq4tm1zze1cR3G2eHY2LXcu8SdDOi9/jjmvzCtMSI6mC+V9e2mwzyx5XtAk03qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339596; c=relaxed/simple;
	bh=QlxunmI1UMNHVXdfUhGhzSfMamEMKYnucGTyrjL/sgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UYT7ZdG97xV2RRs/gjzb6sF5j21lQWor9pddRMwMMVeTMGKI9yfJ7j8lQssjY2zRTlIKy7trW37trhi/SdukoYNCNBx/3cRmlEirBbiCZP5DGEx5pEsC5Op20FzlU+5AWxuwooMwXG1saRO/ELZrUYm74n4a+ZWhYTNbBPyZe7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0GzILuDk; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0GzILuDk"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-66957d4e293so3009551a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 17:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339594; x=1716944394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWjM7OsrUPOawORB4U9wbeNgOji92nYBHhW5FcjXqmE=;
        b=0GzILuDk6a0rcZe8QWnfWkAgVqclroLk8MUjIf1ofgo/ZtfRMQruqDKViQctf6p8VH
         3DRu/aqqL/GpXn44pTejvARWwpR+gpXF6mesPrmwW98FZ3XqY4/rx4XjS8a4f9BGRwkm
         RaJn1ChHf+KhLRZ0rjySjehkKyuVMuc2SUollb07ep7hgNw+mDp/j3iHv0+3dxPQwyAs
         u1VsrICVplebkqJTHOT9F5m6hyg6/k/8PDFeTE6bn2Z7DXo2yptRraXhcM4RLyIumcmn
         LglfIc+c+Enizsoq2yy7ltSf3Uv+K2Fg3rVgbZvfbZPc5dmw+qIaiyaY+rR4WwqWD9Rz
         FclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339594; x=1716944394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWjM7OsrUPOawORB4U9wbeNgOji92nYBHhW5FcjXqmE=;
        b=fsJZ6IFa2B7VOp6mXXX0VbqfTsXJSV+zdo1guZZHD3yQwdjBCAdmAuMVAeR+5N0b7P
         9Ju1zHTCOIN1Mb35BAPY/xfZmTf6ek/l6u2yM7B5ot2886j8JVClmb1tu8ZCGfoQQ6dt
         b7iTct25uKNnWzf3Z9O9F2TzWLORoThF0FmdqRjv8wLdbGLh4DciMjgSTF6YcI1q2wUa
         zZOfCqEPC99n1DRtPdMvIw3iPKvYvTg9CMIMz/RYAA8DC2RnAgaWRy572Bu+ScuVkk+8
         heYa8cGNdJ5udrTgBrbTOVTUxwyg8mY+KDKrI2Ba+92gdoU1Ju7H36R1JhZmsgxBFYCM
         g4xw==
X-Forwarded-Encrypted: i=1; AJvYcCW17Y5eo7gKTtn/xhFk7mP1SqsHey0s21k93zXXPtl7TmKgTx/9zpHUh1+Lj/TGxLQC7RDM5BnEeQr2xiH6cUDu1OJhFZQgQGlDPxIR/saS47dyE+Tk
X-Gm-Message-State: AOJu0YyIWP2sRepGdHLRyj1iwJ3R2E8Dbpi7n2lH6izCe47ESNzlpfkb
	FejAnDPI+wSCKgbmUqUpsRSWKj14+Z7AHikJaPl5+8ZoijXxidkH1I7nu7urJo/YIPSvFwzHtLa
	MWg==
X-Google-Smtp-Source: AGHT+IF+dXCrqU49ux2SHmZgWpvGHIfsSKPUFGkKjMCQnUfR9LpuorqbJFmyzygHKtz1jlIYWFlRGrTJeR8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:da86:b0:1e5:10e5:344 with SMTP id
 d9443c01a7336-1f31c964eb8mr40835ad.3.1716339594265; Tue, 21 May 2024 17:59:54
 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:53 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-8-edliaw@google.com>
Subject: [PATCH v5 07/68] selftests/cachestat: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

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
2.45.1.288.g0e0cd299f1-goog

