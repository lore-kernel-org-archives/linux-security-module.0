Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981E502B2
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299785; cv=none; b=VqRPpxQ2b1nsN+cbcpUXRjy1vR6jx+y0IWFsbl4CV4lEDHYrYM7mhxEUXOuHrVfOa+3Foot6lRe1uPwEtQACTJJpq0lurSLuFEf2Tib1MCenaYDQBBhhT9lL71QS9Jk0GAQUAKvr94lkp+IhRDzNr8mSh324qooEcZ2KtgXGRIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299785; c=relaxed/simple;
	bh=Udp2OmpXlPrvNQk3Kk+fsTuA62Oxv6sttbB301xWHNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LaxzRZXOqktHc40CkBcPUIRy+me3BPwmQWNc4lARRUbKORzhORo/7s5vNha/e/5ZC6JoYs0+fLPASFs3mw3LYF1Ji4njEcpD26/kNhhND5p5kQf2z4Yldgpge+VX4q2XhSoJ7IoTz7G5BaDlZf+f2eut+1QYs8x14GqpR4b3Hx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rF4v9Jq+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rF4v9Jq+"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b3fbed1a03so1381981a91.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299784; x=1715904584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nD4EzUbRtbWK7TkNHEGymGoceFYTK3zje1jRLglZ42M=;
        b=rF4v9Jq+ytMGciz6mwG2yUozziLG6OiICQ9rdOWAWiLQAtPXvcqCRN3H0ODjERvxQn
         b6/NbLXCYJuECI1w/mwd15kiLhO1dwwA9lJJYBcjO4v8RMeJXAYsEWIChpG20hxFSwGj
         SL8QTZ0IZWrgnBO7th1g3wYeJNWL49QcdTRExcwclXvT0Y2jyiknuMZQXubWunUMO7vF
         GVjpEmqTDOgDqtKSuCfkFjjgKNbl4tU8ZhJWOZ6nmwnZTzQe4YxhHDKdcgfaL9IkM8lx
         FYLkzDMxc8mIzOn+EAEQBpF6WsB1bisXZNWMIZIdS76hot1Z6mFogEdsI6Ea53wBblFH
         a08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299784; x=1715904584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nD4EzUbRtbWK7TkNHEGymGoceFYTK3zje1jRLglZ42M=;
        b=bSPzqzbFp3XP2AUeQZvKPK5+V6Kz5VfRhR8S+/gurB+5UH6qzMgy+/mHbeR9MMJup3
         8aRMwyiplwX1QbviVpYOfQJodKGMFMHyiXWffbEM7x6+gD8jAp4VLNfGRMEjZ5L7Y7C9
         yxGbsKuKJsiv36SH4HCcjAi7+A7N2VEn+aQcbCOBW3lS+lYyIcEOKRxR9KhbPmujPMv4
         nLeajnJ6QFQOZv5s3ajTqURgIQjjWksO3BXPiVE5is3OTIfs2ZXjsB7qn36QFfD5Zv33
         rWLoEA5Y1lqzrD7XUAjGOSJKJxX9FeBiGRIxakLT5ONn6idc7WxHmnSqqYrpT/S+fbld
         7T7A==
X-Forwarded-Encrypted: i=1; AJvYcCUg2S0F6UYDaEGDL71JQP+vy4ov8MC0aj93SZbqLtHl4Vdph77iR3mwpVNSnv4CKecCFGbPl9m484oEHL7abP9inppf3OG5tlGC6+mKwgoFV2/gAILt
X-Gm-Message-State: AOJu0YwzxGEIO65j015GXdOgmYGTIZqmaAY9K0bT9/U4kJZDsNe9fKR2
	SRgz/7F6DkqL5st0DAOzPjzAGNYymJetGHCeegSIKYnJeQK/plqUx1WD3l+W1IYWl2K5naDvCQL
	9hA==
X-Google-Smtp-Source: AGHT+IHxMR6Pp5SkTVMeBaev3opCRzONt5mntrRWzWl6NBUoxiLz/a/B8LNHqFeHKuHis4padRNmU+oftSc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:488d:b0:2a0:40df:2f57 with SMTP id
 98e67ed59e1d1-2b6ccfeee89mr2677a91.6.1715299783557; Thu, 09 May 2024 17:09:43
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:30 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-14-edliaw@google.com>
Subject: [PATCH v4 13/66] selftests/exec: Drop duplicate -D_GNU_SOURCE
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
2.45.0.118.g7fe29c98d7-goog

