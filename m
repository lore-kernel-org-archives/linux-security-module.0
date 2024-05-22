Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD3584D09
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339614; cv=none; b=lEw8Jmhsud2AU4P70emr975ktlXVcl5OegAdVRJ5yJ+djicYUk6NKxaTxXtBFhm8IZK7VnjDndWnImwkFbbwmhgjkOvIELvQv/x/MeNBXl52G6HERTiifCMlbi4m3cWGrYGZgO97Xsng3PXgdMSPgwpLi00ApMV0YEH9d0pW1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339614; c=relaxed/simple;
	bh=wsyMQnSJoz2Wb99bdxmDTEHWi5oTqZOWO4XctcEHfZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kh5ebPJ2+hC9i2YnWzv5JuzDOU1KYiCXVOKPpw9kk4uCsQMUrNkHq2NRefWP/kA8uVo+6C/akElleu5x75WpXOFBrdznZne0FzWddgKH4v2Jc/DrClRf+Cvuc/R34/lgAN8OCWwEPDohIJU2u7Hm9yBttZttAApv9GMTW03lEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XkQhF8xT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkQhF8xT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ee2f06e652so141375645ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339612; x=1716944412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsA+RTqEPsjVoyQz5htVdcF3IiHZQEx5aOWSYNx99Ok=;
        b=XkQhF8xTBH7x+fZzve2HF0FQepqr47zFBURLol2odjLRMjJqtHznQZ8//+43psjXO/
         yu+wQrPAQJq+Z8NKmfPeiEI/hQV/+O1kfH/8jzOA0SA3xw8wY7eCnP19UxRxMDekdA5s
         thFu7ZMGchQr5p1x4w8Z03G/pxEqpikRev7OVrVjKCiVv19Qz9aHxRNMu46uiqcxb9wh
         TIWKD80Tnp/TjacnGOKNZjFgu0GG5RNwDOYiecQix+va28C8FtBUK3FLF+pU1mJoscOw
         QrmtrWBFDDS+KNhyTHozakubWiv3OxSBtAO8ODJPfdgqGtKF7KWNrdEBFIsti0WJnpgv
         BoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339612; x=1716944412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsA+RTqEPsjVoyQz5htVdcF3IiHZQEx5aOWSYNx99Ok=;
        b=ikZSnqTfTJJo1b858/rJ7paLzBB5EEnrpH5fe2vx90y3sWHvT8FcfH/XcwJDxHsQuV
         1Z0Kirm+MxyNc2mxNnt8prVIABmiEVKQVe7ke0YcH6pufFdM+5exF8YSOajsjwTCXZMk
         +CWzoHQT0e6ENKh51cf+/1ojdP1BaSkWCWXivH99gWIlVLzUqUa9ansEHZSWb/vrF9aR
         n03+HVTu/Sf8NxEZ/fa3x44/y85v3fakMfi+CRJRIYO/rSOP17i1puBda+4pcs5vTCJn
         xIwlvnW2MYgI1jyL7xjaDi39xFLQIjEQA8IiOoFhOcB+gjAtRgjNB7ep0CNNn+rXnqTr
         GCuA==
X-Forwarded-Encrypted: i=1; AJvYcCWXYLJHQIPFzEdGYzvRzyQ4E4qbV/GbtCj8CHII9L3VtVlMUHF6aPpMuYZ/h4DXAJxnF/Aj7tAKk+O62SFdZ06mABO5lAZATN5ZO9zlJ5+DcXkVBFng
X-Gm-Message-State: AOJu0YxfVqoBFuwO4YatV4cvk5zf01/nOKVzQwOcJ02fxbpdTtxuWqej
	Qy8NbBBSNJRxcu/zk027C/4P9l7X+/VwyvHSanUdgaFClfaj+uXxyMtuRWqycTX9Wu2XrUriK0Z
	7pw==
X-Google-Smtp-Source: AGHT+IEcD4R5LAcOkQ6bfXkqs31q98gBsHVg7hM3ofLnT8WyE84ISOt6pDCwS+T69u05hB7J0k9BXfKJ8Es=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:c40e:b0:1e8:37ea:d17 with SMTP id
 d9443c01a7336-1f31c948c7emr89065ad.1.1716339612406; Tue, 21 May 2024 18:00:12
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:00 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-15-edliaw@google.com>
Subject: [PATCH v5 14/68] selftests/exec: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/exec/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index fb4472ddffd8..c5bdb653422b 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
-CFLAGS += -D_GNU_SOURCE
 
 TEST_PROGS := binfmt_script.py
 TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
-- 
2.45.1.288.g0e0cd299f1-goog

