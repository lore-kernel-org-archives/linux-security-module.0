Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2513956B
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284922; cv=none; b=rq4dULxGZ+qxf1Ca3E9PPU3o0tW07eCEsG21mYaM2epb+/g8RjfvtBvYvnZLmcLj5mZg9lM9wyPsWhKtm8YWBWNeM2ujJ1oTR//04VL+KE1L0Pkdy994OVlQLzTxr6spKPOT4O7cCA1NQkGZh1XzBZMEBPeAjDPQVJiQ+wjAV4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284922; c=relaxed/simple;
	bh=WwN/b+0vohFwK2+oIb27RDmv4LoFS5SqplTVNpxiiFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rgreH8pkJ09vfevcwEpkclNnrTVmgq8p6Knrka0yzCFv4ztRxH0+QFsHdXrkd5PMRbfcSpn0SN7w+KFJ4axVMU0WwQNn7x40uUL3Epy5zBC8H2VHMnM4XHmsqotdp3pRpuBUAPN23jAYZIgqdyZDz6TggTWi+OdvY95H39cdO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGRt5TXs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGRt5TXs"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be4b79115so22778997b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284919; x=1715889719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bCAetgsy5/zofnz+8UMPVpCBKs2hhXfKubjl6/AwDCQ=;
        b=NGRt5TXshpVeXcX5sECsyA0C4hekfFpgdjPNRoq2ETsP3UL8uWirnJBvjNjbFZl+nG
         nlzssz7ymvF0NqcTOXvGMiQp6HqMKckg27BrWUBCNwfAOxAWlsEakin75jFCJEr+8xBb
         N1wfK4r6B0Sc6L0H5zna7wfCXCv38gPQIhyQ9zGN3Vn223HsqSfeaW1OSrciX0IC5okh
         1Z/lsoy4jLbtrxXmJXuHIgdef1LmyRq9+ONCro0EqqTUJiwOMnforAUELByut1kP1rMr
         bBSVyRZJEyWyzEQktaWTFAlhrRTqQ0xuk3f1NJ63S9md8hi/BxupTeO6TA94ZW1UC7Rc
         UHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284919; x=1715889719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCAetgsy5/zofnz+8UMPVpCBKs2hhXfKubjl6/AwDCQ=;
        b=gqnG17UECIMbb5xaVLrYCXGqin0XHxXY9lrAuPjIORZp8CwazyKl5QVmQQXeZPtFUH
         WTCubUaVXsHYZ1Z9i/PBxaIjbP8s1RqPH062HULe3bykGRklMmVpIuOOyNYdQUaZlOPd
         7aTX6WTzvUiMQvEfBDM9Unk8oBKET6alHskLMmYmV3+JAPqx6eZ3UnkOjDMuTuvDerGx
         5G8VaXaKL06HW/DQ6uVrgfagEIN3/KY3PPOi1U7V94JpnyknG2oWW2nXb/mS9EZMksXx
         TNqoM0exNHTeNtKURatAL2pT1zh10H/b6OfNfGyTQzAGTWLV9OffzQjWj+SnfEJlW54n
         KWqw==
X-Forwarded-Encrypted: i=1; AJvYcCUpzsfVDjvatd7Lg9kXN38bXrzzxoHrhedaJiWh9wOYzDA6Vc/Iz3ycZD3WNujlyKQHWtynK3thy4evvbzl9R7Mo3+nKvTDfjEuE3QAUbLGc3UJPcmi
X-Gm-Message-State: AOJu0YzBbjIH0OalX1NIPG3REw8t+/Ve3gee5ppzKrZxdvNHmWCjZtwV
	QlLTHVr7GU+moamXfRjR9DMbiDdV071zqXHi47y2TaZXpTajKOQlEaAVGR0QZYqZWQyv0lWXwZK
	zYg==
X-Google-Smtp-Source: AGHT+IEOccdP8zaf02kaUFiSefNhqGNYrWb2znEKmAbmEDy9741vUefYHtBjwkO9wTStl7g5XBDfQZrMi8A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6f8c:b0:61b:ea12:d0b with SMTP id
 00721157ae682-622aff85f0cmr1704757b3.2.1715284919580; Thu, 09 May 2024
 13:01:59 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:18 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-27-edliaw@google.com>
Subject: [PATCH v3 26/68] selftests/kcmp: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/kcmp/kcmp_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index d7a8e321bb16..f0e356139e1f 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
-- 
2.45.0.118.g7fe29c98d7-goog

