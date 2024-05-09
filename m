Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD39412D759
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284888; cv=none; b=sV7198SC+snwo97QAXFoohlxo2xdq/yDeOXYpHPcS4zuPbbYhVFie+O23OeWal7rXVLUDn3CaQHFb2sjUqvwv1lv29LjjRaeI50mCIVCrGjpps84uRNwDKCvV0CPJZLqkfW+j3fna3eBqSTNWoqjEf2ijdR9fWBLGHx/radeDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284888; c=relaxed/simple;
	bh=H0xNOT4MYx4yQ3KHHxBXKyqMMscf8BIYORk36eDuIO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U2QDgVa4t1YRu8TWryG7+iWk9NRfZVQjQHagtF62PrBULeciNHcCVFgUPdebFs7WbHlmCWQFpWqEXNXslzDxVn4MmxWc8oaGjWJo14lrSfnN1cZuimdrsRvsNfv4j4OGXhe7i36d8hS2AdbRh6+dRflMv3VHvsunKlSl+/pWjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FCwUYfrI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FCwUYfrI"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ee2f06e652so12177815ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284886; x=1715889686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Od8ki9QAqD1fUhM/c9ehfUOTPfP0DcxD+whg8mbh4TU=;
        b=FCwUYfrId6z54JrRqF5cV0StvlVLJTB0VHNWy2rtbqOgyBQBd0IsCxgU8QYRAEbd0y
         erm4+Gzp23EjsRxbGj88oBKYzxSSn+UE0T+3LnYJgjAyK84I1UUH4QJ/6G8B9ZFVWMKY
         G0Qh/eDc4+0KI5t0I9vVCXuNmFTm/WF9wsaS81w7MJCIhNNDJYlJrpcsLBeMQYYaEtxO
         HDxV2tikjkOxggYVoLn91NkJVEpVtITYhGhHX/4kIZ8v+N9eXCNKZd5hTWiMlEE75IxH
         WXy39lGXRViNrtVCCtZAu3Fg2nwX8vDeO3mZ1oPpzeDNZkJXpLkDjydYMAnOw3yZ0pPr
         dhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284886; x=1715889686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Od8ki9QAqD1fUhM/c9ehfUOTPfP0DcxD+whg8mbh4TU=;
        b=KllhjOal2WkjIp8R+GCOeD/bNIMhMmXJri1TJsuV9V4uOjY5wF5Ld3BH6rUT6fj2IW
         LhnI6Y16Jqc8If6BQ7ssnUcdK1WDv8/utyL3Thl23z6vPU/jC1V8djZc1Mwu1XtLjK/C
         LjNEkB+RQh8S0GuHIf+DonzSicoioyuwzd6lst3urQI60hSg27Jj7o9t0vyJ3Hx7JRJx
         DFzFNl9KP56l+hnKx+sYKw/943TW+mx9zNmFKLzBA7PdKcTrCDvX75YSjErNvGvRc4zF
         HJv1g7ZvEnmmfiSfSS7l6iYqE7/0eOmcpR8NW1q4qqqiJRMEUaLFyDlNNGALhG8j4GdA
         z7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVSILd/TzDAQnQQOIiR2usagfGamiWIcWzh8H3Ycxtf89Mgivdta5qiElX/yobtoy9ez8xgzMbCtDmcVcF1sdfMeUqBsIceQ4QCvhtBIJgCDyWVoC59
X-Gm-Message-State: AOJu0YwbYpIyv1xODnReidhIfVq2idhxh55ISct2O2yrFWeVhLwUgnLT
	EJChwZJAMznmqNvyfG4SL0MxDTsMAl12nloj7lmY8ORqLcRilc4wv+dIyCytulnz6PRBAeKFGU3
	yiw==
X-Google-Smtp-Source: AGHT+IF+9O8AdOrC0sfYwymi9nDgS8P3uCdoKz+tbRqRCiftF6S/rlAyRlPcJO8FmcCJmXEqc5hw6LgYks4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:cecc:b0:1eb:62c6:98b0 with SMTP id
 d9443c01a7336-1ef44049854mr17265ad.11.1715284886040; Thu, 09 May 2024
 13:01:26 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:05 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-14-edliaw@google.com>
Subject: [PATCH v3 13/68] selftests/damon: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	SeongJae Park <sj@kernel.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c    | 3 ---
 .../damon/debugfs_target_ids_read_before_terminate_race.c      | 2 --
 2 files changed, 5 deletions(-)

diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
index 0cc2eef7d142..7a17a03d555c 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
@@ -2,9 +2,6 @@
 /*
  * Author: SeongJae Park <sj@kernel.org>
  */
-
-#define _GNU_SOURCE
-
 #include <fcntl.h>
 #include <stdbool.h>
 #include <stdint.h>
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
index b06f52a8ce2d..4aeac55ac93e 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
@@ -2,8 +2,6 @@
 /*
  * Author: SeongJae Park <sj@kernel.org>
  */
-#define _GNU_SOURCE
-
 #include <fcntl.h>
 #include <stdbool.h>
 #include <stdint.h>
-- 
2.45.0.118.g7fe29c98d7-goog

