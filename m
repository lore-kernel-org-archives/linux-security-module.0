Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A42985C66
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299803; cv=none; b=h5tr3a9kP6z69awLdj2haXYL4UkRP+SvULnMy/ZoV+eRLdDjta/UX415+W2nGJxoHT3OyV9bjSva+oaBNw03tl9FTVWFb3BIGxQ4gJT2RVORoUReWcO0cH+y+X18siT3nFFf2/KstD6tY+wez3+nYSRKM5HQxMe8MGNf0HcSI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299803; c=relaxed/simple;
	bh=qbmkyF0+P08/z/Fp9ZayOXH0wErOspB3sKr8OqJ3zqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cOVavpxCcTVu2lm/mtJ3zuTYXZTp5tiM/AcK0Png/8Sw7Wf9lh+ATW0cJKrqqXtBaAMtDCg1EhrBVhQuAWN9Rzk4P+czpi2WZ3KV1795wzrhM3plWfS3vngvXOz1HSek593Gi3UoWpNYHW2+qTemOf0R5RZidt+vXBpzne5K1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NfPYhVCZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NfPYhVCZ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de603db5d6aso2536398276.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299801; x=1715904601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7gmE/+1tJ7Ep2oqmr2taMm5VZCwXrcQv9eKCkUAc/7U=;
        b=NfPYhVCZw8/6vRnxi5mwooE+sTm/zS4DcErqO33jFYRyYjxzUKVdolwxgomkX2Ur0R
         l65rmdSEdY6cSGQS/D6c4smxibXHNbmVgSLEge1gTtRdZ4W68jzDEsAWU6Gs72xLTRL8
         4ouG9L5f2HTZNxuyhOd/8DyoZlA7eXJ/uJ+PlXoY9PXE6k9MRljXDE47D+2hm2wrheGb
         SmTsrODv/3QPkAQm9/qbZcqKJ6r6FtbKdH9eyRlM55uvZSBjgsF0uIPMyUejVOpn7X3T
         MZZ9Okt7kpx2w7E/mv6ekgov6pH+DfgUx7XD+sVAV1arj7MSiefc1FLNxKnGYhdow8tY
         PrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299801; x=1715904601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gmE/+1tJ7Ep2oqmr2taMm5VZCwXrcQv9eKCkUAc/7U=;
        b=h83OFN4iFBcm+4YjRAraw5B0BA7pl4AxtOcDebM2ncUrg6RGntTcGEjguq8DajIazk
         bc+4+KwMqZwnsxkyCOdE5RmEL1PxX2PwdIuQ0d5t2ov1F5A7atTE/x/0EBunixL1+jD0
         AhiGNz38y9yUlbBNSnhf8DrTuYMNa536HvpzZbdYo5nLJxA7BFULpBosC0TPuqs9zy4E
         D42T3I82BIATwyFAWQhFsDjx+JAeeiEpgjJcprCjB3xR0g8DUyUic+31+KNbv9O5jc+c
         AqXPw4CQLuWqXWngz7xJlUqLYL44UQ6FnylkESwyKfGkXeP5HS5VyI9dk81Lp1ZhI+BB
         TZLg==
X-Forwarded-Encrypted: i=1; AJvYcCW9eQthz10FJEsqEBdXby2F91+rb3Q58u93jJB2JSN0s7iSUp0saocoEouBzoloCx9ZBK4Le9kZOQDJORCRZyeMdUnIHxAuPGz4Mq4lQ9pJZ3T+fFUt
X-Gm-Message-State: AOJu0Yywjhpd8m8R6pPcZN6ZfjOqX9RdwqP7CuoN3YJcG9RDv1ZnQYJk
	TO9KzmZ/vsQfWKN61UeIi3yyRAFSdgs93eTSaLV/0SKxmYgZFkChyt2wxj9xMRmiA62M215LL3l
	AAw==
X-Google-Smtp-Source: AGHT+IEoDu0ZcQdyPuiQJKnDncyGUY3Booo+z0EW8VBY1J3sHBK3DT/V9Dd5nwidmRrvGe1vHB9FlAyGRV4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1002:b0:de5:9f2c:c17c with SMTP id
 3f1490d57ef6-dee4f37bbfbmr289205276.9.1715299800737; Thu, 09 May 2024
 17:10:00 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:37 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-21-edliaw@google.com>
Subject: [PATCH v4 20/66] selftests/futex: Drop duplicate -D_GNU_SOURCE
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

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index a392d0917b4e..f79f9bac7918 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
-- 
2.45.0.118.g7fe29c98d7-goog

