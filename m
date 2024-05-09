Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F7C811E6
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284898; cv=none; b=Yv386aFtAihR57CIqZN5fpAsq8+7UiE35wxl12+/jSrQT/OjjqwMfZdrQpxnb0CHmKl4mCuwuVIaY+3BObkuQ96dLDcHzi8V4VzmaN6+07DtE7yuiQsN9CspURPBdwh8munqXEkoqJ1feeC0fiCl3ovik3h2kStn3NLNiwT8/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284898; c=relaxed/simple;
	bh=C3bR+kpQ/pwvE2T/NJgOdT8P13gcI63yQCJySRf7IgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OJMrSEHyc3w6xR0KSrWtRjgo0Ct2z9klocsKu/FPCD+vhO4q8qk5oRx4Y3FQZCrTz6I/+FqzPW5LFHUkncGnxUEYRfZfKzxwaIqy6xjfmMoKaYhrrXG9MVhqYPLZUx/5M5ozLgqmRhK6UiE6LSRh5Jq/ak1fShXYSqbe6C6PX5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mjzgm3TO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mjzgm3TO"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso2212916276.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284895; x=1715889695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G57nowh4j3zc6dZ0oWotSbgcBjSXunvHMbYgrgfrS5s=;
        b=Mjzgm3TOINzFdHhbrwACivH+nHRKigNcSDM/W5emIwk5hFZng5JqVxMukE9UJNyIHS
         UIfysBaSrRE+oR3Yrhdb+Pn0gVptaVI9ut75QJcSgH4o28o5wIYQHuB3t0sSQ9BhY4Ws
         bxV3TTZcp2egKigvfuT4jr943PYV4KExGZDOdKuJ0Ni1iKYWszINgwbwTeA+gHyxnIcw
         UROpmOQvoMWPzeiuwQV7aPlOVgDhzM9vvaUGsS4yirS7ITy0gd1JmUvdDFNL6oYQDH2l
         4nFPZ1fX6Bx3WB/w9Joc4HA5toouLN3CGi0yb5dHXRcmd7Sn5ZOn/4wfDtvwG9kiiR05
         MDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284895; x=1715889695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G57nowh4j3zc6dZ0oWotSbgcBjSXunvHMbYgrgfrS5s=;
        b=eiZDF2DrebkaFXDUpth7Z9mnzUDpQSpXlFlW5FSLVHMD9S+nPZfTDkVWvEfI+2waFK
         VPwoRMp5qv06qI9F9xjqfAmFsqb8B4F/8E6996F2vUoyHv57+e6era+x2xuaZch/cFPV
         Y0iPXnO1qqLhXeSj4J/F9fnzpFi53R85YlEvDH8lqux9eVt8nTcpFyOZVUI+Kq6G95Lq
         ASBn5FVdDqs8lNg40YMl0PSm1Rii9Etvw5QtCO/r9NP2HsUOKdTE5gAmxUZYFJAxOP+Z
         0J+TjguNO56WJSZzbb3h3Xyt408BgM6N1tJx7Ydo0pGB7XBZ3DyEUveSq75/cA2hev6/
         eElA==
X-Forwarded-Encrypted: i=1; AJvYcCX0/bpgx3XmHG1f+jHD99qLal8cQFEWDPj5AcEbQ6cBKTQ0LVBfHyacjcwLkWJEc3CdInzsgVQs8hxIvgS/LrGkddGJ/SmDxsIqFcTXMJ53U8eqZtdB
X-Gm-Message-State: AOJu0YwPQmMeCfUwF1IClGvbKAWbJ1fAKjjhkdgK9WAVxUnOgkvWZQfH
	uV2SFvZXxbC97cGiuQQXNeHRSpZW2mxPTKA68COOevETp62Jt0i+2cvQgc3a0NjJi0nGERiQYlM
	mkg==
X-Google-Smtp-Source: AGHT+IHoch+jGmejTUt/KWjoMuZe6CHm+ujySJjPOe4GFGCIUbS8DO634gokWfmQQFi6/Nyn5DWYlXv4Q1Q=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:c11:b0:dd9:2a64:e98a with SMTP id
 3f1490d57ef6-dee4f30134amr46466276.9.1715284895465; Thu, 09 May 2024 13:01:35
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:09 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-18-edliaw@google.com>
Subject: [PATCH v3 17/68] selftests/filelock: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/filelock/ofdlocks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index a55b79810ab2..301c63ddcceb 100644
--- a/tools/testing/selftests/filelock/ofdlocks.c
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <assert.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog

