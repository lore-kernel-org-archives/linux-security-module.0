Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32513D8B6
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299905; cv=none; b=GHvrw7vbFBC+FF1pE/HUEZEQwWZTmzWnJuMl5xTc05vcJKgrg0w1VNX0TjdnsXLbLZK127Jp2a4HWRQPTA9bDB9oFqYLlwuF6k+rKOR40UCbOvLZeS1+Cq5lkTn3SFKjgWX6xaKT4O6Z6cRlQ4bWsLLSrZLInPyfbM8fLD6su+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299905; c=relaxed/simple;
	bh=+sItl3NA1283go5M9bQJeU6wBJ4u9ILtYGKec/4SU+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FCel91AWhGhBy06JRlg73bHcM6T8UcMarnXJY5Tqlv8Abz5Nl0OspXMYkApBUGCc2/aSCHoMdF1mo1hTtxWgd+x16u3AVFEzKcYEy6UcbcisZHc2472Egd6p7jHu0qZXoRDkIiJrShuCMJ3l/fXaY+CAqKW2tktSlxKvAY+H00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/IBZDgJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/IBZDgJ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f446a1ec59so1270675b3a.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299903; x=1715904703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aFdfEWt/7k/b5Ocj8/yszbVTyEkIpeJxepTUQyb5mg=;
        b=j/IBZDgJBixITROWdSoUh3EMJl5FLq9rkLiG9WDGzdfWhLyOCsEhBBeJ0klsUnG+PJ
         mMu7w1GHXvsguldwWHKL00EEbCE0sgi0AaGaO+U4NBtq7ds/66eZG7zS7SwIQn0tfjui
         zGfe4rD0B0DfaJ0CR4O0YPfcC4iykBUlIBmkImwlpct3NkHBph7icpPOxHWsH7KMgEQR
         tRFQDb+AHAoX4II1XL8AUIsH3VaYb8UV64d0wY8N5/0X/MBJLtN/0/ay1Bvto7qyWmNw
         NC7k9ATRWDyIUTWNjZRn/1FdEDtNwLBthL9m5yA5aIkDTQE5ytft7lUEQQ4dYnr/dTT0
         PDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299903; x=1715904703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aFdfEWt/7k/b5Ocj8/yszbVTyEkIpeJxepTUQyb5mg=;
        b=ReaPEhdrep7PeRFD9xD/PmB/OxSTxmYB/LijGNiHnVmasP5g1/pXBm2PxtsL5bPFKp
         /T4H9xgGynrTSM/QXONWK+Vx4H4SQ6bVVOTF/30e5HMOt/AEXxVN/k2o3jy9JU0Hmhnl
         qL3qa7LJz4hAH+1bTe2sCsgY6kCHPTfbkTLjvJwmqpdHYuOvAs39qRgxlJYpXQRvRB+t
         xn7iNQXBRSUtwo4/wg1gqxC7k+33EVgD8N0sIWVhcC0wKqbca5gmLO1ImVVCYBnLe0Xc
         GXL/CfLL2Yln2eTjCX3gMEjeibXnfu0giXEYglvBky7u19Cg7xqZI0sAtHsfdnrHMk59
         RkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVhIJm/I57C07G2PuOO17gFdoB3F0FyYDRgrv1Wu4mpB5oBbA+IQ8zEaW+A1zZa13YwuzwYcZIItj0JzJm8V+JBzBaG/lKJa42NddwLbva42qBb2pV
X-Gm-Message-State: AOJu0YwB1QrrVEkdeMOgY5ShX78UIuAaR22ERVnRZD21dmLcT2awp+8y
	9LouFgDmVcjuU71f8o3hFXtqmnjCMAsanwVlOX61FltkkaRZn3PPmM2Sq5r04LdJiVgblOE9A8k
	5mg==
X-Google-Smtp-Source: AGHT+IGbpUeforMn4xLMD5N1hyX2TrG0gSGZyFXuPe0hRHFj81tMrWmYRZqjYHTnolVlOz0QL5y0YD27qvs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3a0f:b0:6ed:416d:f7e with SMTP id
 d2e1a72fcca58-6f4e037d8cfmr68300b3a.3.1715299903347; Thu, 09 May 2024
 17:11:43 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:12 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-56-edliaw@google.com>
Subject: [PATCH v4 55/66] selftests/seccomp: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>
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
 tools/testing/selftests/seccomp/seccomp_benchmark.c | 1 -
 tools/testing/selftests/seccomp/seccomp_bpf.c       | 2 --
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index b83099160fbc..3632a4890da9 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -2,7 +2,6 @@
  * Strictly speaking, this is not a test. But it can report during test
  * runs so relative performace can be measured.
  */
-#define _GNU_SOURCE
 #include <assert.h>
 #include <err.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 783ebce8c4de..972ccc12553e 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4,8 +4,6 @@
  *
  * Test code for seccomp bpf.
  */
-
-#define _GNU_SOURCE
 #include <sys/types.h>
 
 /*
-- 
2.45.0.118.g7fe29c98d7-goog

