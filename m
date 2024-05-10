Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB313E05C
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299912; cv=none; b=AX/lpUbLqAcLZClTmp9anEwgjHuI6wmKtZSL9mdggmLtxy8MCiDo7ArObr8nbV15t/ynRPSl+rlJHi8NizP3mDgYDBvkSl2+Arj10ikndIsmUMNUukgtsJQOmkKRabqx9EP9W6jKCologCB51RwfVIgZ4w5YoT0v3mxc0n+rEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299912; c=relaxed/simple;
	bh=wdMuWYdMwrgMerE8WeS63hJz18n5JDaZO1VLefXTz14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mhqgaH56+HZc4GxikPuRSO5OoQ3N21BuBRW1ex+8HQL7gxUri/8gl0D1lI+FJtb1h7grSJQp+pG+1wgOeiVNSh214Q4INQNh3IxjgtW2r9NvQ6wV/fCzlgWPm/vbjohYkd9PlOfVJTtKXzqnzirXbO1Y+6CjdxfzUON2oszdRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WntSC0/A; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WntSC0/A"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f472477050so1079781b3a.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299911; x=1715904711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lfjY9RujMMfudpJuG3AQZBDh8vReKDVIi2txg8s68yI=;
        b=WntSC0/AJawdU1hccYk/aSmL9ab4AHfclF+40PNoJ4ylJqg+FxEJX5R4F/EZzO5WR4
         jXhqyIQ6FrpmQkHhiMeMsOKRPetkLPnnZb4S79PqSYFOM37lV93GT2kFTNeE6exCsOhf
         iFB3F3ZTB6bngDKby6PLhK9OP3y+gS+ZlEiAE61wWI4YfmNZIHmhaBUFaVHswaUVsu2x
         gNH0qr56GRkVicMbuIvHRTbWPLO5aVbvYjZwBfAAdRwrEC5H9nzSxvoKh5GL8JN9qX5A
         bnVFqHWBwUS/SaP+00dtLZ614BEC830hXLLrEOJdVdVZDWl1E5cOA1ovVHoJ+KiX6bkN
         p8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299911; x=1715904711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfjY9RujMMfudpJuG3AQZBDh8vReKDVIi2txg8s68yI=;
        b=uHNCJZUBCUAUA3lI77d0VZ6WfABy8EV69l00t5DmsD1EAY1yqJCdeEk11Q5xK8X8jj
         AYjp+nYRwwzophlPucKltzsHpVtu3uMxaaejwRxDrbpVifGj45dFGnFoAxcNb+YHA8OT
         xbwrGy1XpGo+GCBZEdnbFaWuDyFTelE3dR1yTedHelOZlxrRzQxRV7fhNE6wz1WuJxhV
         4wDu+QTd8dhQ5MK3eJt7bGYnejILpTg3LxW3oAAsUxX0dkQO4m4SUUCe5IHMSoXy+75n
         QFgV7qm8udy53Joo6NtgoivWNb/M0u58pN68xVHXfquE7M1UeUBdn+omBvjwGxMtXuGt
         vkVg==
X-Forwarded-Encrypted: i=1; AJvYcCXkRfO9xTEHxIIdrsCH4TtFiU2TtmoggqaBjyzHVdVx3ArYbK8vIoTy9QwPBY0lzdeN0wrPC2zkKh2idP4feQxjZKvgpEZiahjF38d4AVD5DQo5Mwy7
X-Gm-Message-State: AOJu0Yxo93F7MYyVKbkoGCl8RXmta9gWuQvWRcOHdcYOEQE41hpiLXjj
	5kBElMLOeVRWlG7fVhOZXk58Qv7/sqjMtaBkuKRbAPnO+f9zfll3zAZlYk/1DlQbzUrP7vHTYwy
	Jog==
X-Google-Smtp-Source: AGHT+IGMEDSh6n8JDhyUnrx8edlpa1/0ciKq5L6J3NGl7hDudyZ1Z9szb8Ek4WrJWFhP303EsBUN1+aLv5o=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2da8:b0:6f3:ea4b:d232 with SMTP id
 d2e1a72fcca58-6f4e01b953cmr21227b3a.0.1715299910911; Thu, 09 May 2024
 17:11:50 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:15 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-59-edliaw@google.com>
Subject: [PATCH v4 58/66] selftests/syscall_user_dispatch: Drop define _GNU_SOURCE
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
 tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c | 2 --
 tools/testing/selftests/syscall_user_dispatch/sud_test.c      | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
index 073a03702ff5..758fa910e510 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
@@ -4,8 +4,6 @@
  *
  * Benchmark and test syscall user dispatch
  */
-
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index d975a6767329..76e8f3d91537 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -4,8 +4,6 @@
  *
  * Test code for syscall user dispatch
  */
-
-#define _GNU_SOURCE
 #include <sys/prctl.h>
 #include <sys/sysinfo.h>
 #include <sys/syscall.h>
-- 
2.45.0.118.g7fe29c98d7-goog

