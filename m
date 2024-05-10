Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1738513C818
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299888; cv=none; b=Tl5+v3AuYlKwc7DizYVxWYK9nfeQsaf2m6OlHUGgOHp8l1Ts8tlS9pSlzqZrK7yRwVzrVW57dC5ssHCdnWMt+RS+o5sflBfFgRalvgiJH7e20jxJeVEescSu9f0Z6d2i66WlEUZXVmnY49I3sJkyaTXr+fZ4QQtmAwudE9IrpGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299888; c=relaxed/simple;
	bh=015fKGDJxCO3CrDnV5eDhM/cvgzAQ9buUgF1iz0PEt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XpoEx/TCdiaHCvwjbMJQRbc9BDxdfPgfG76laflR6CAebKdqLEG8r1X47+k1O/CdEtA9CRov+VK/OXXMbegwqA/8NhWdvc7Z1W/nofognhkQiH5dpA5avSNJwaLS3FAF28UYF1XdIw9MU+1isCtaRqkoqHwBa8VJnlnTQyuM3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3FScSGlq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3FScSGlq"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6207c483342so24521777b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299886; x=1715904686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3uGp0w2sme3T3nV0EQqTopwZWuCKWdcvzDVr+VeYxCU=;
        b=3FScSGlqmDGcfC8JdovJbEM9EuhrxxRbsTWucnnH3JnVcmqLWqoTGpjJUWTrCQj5pN
         dztuS4/Oeo67IjVhlqfYEmTeNIWaxy7LGvqPmZZ8Guei9EprhaBq+Dcbi8iUZaKVcBjC
         WTbJULVDyrUTKyRGaJdty9x66E4DHllvNOuXKNWvcH1lk5ZekPnz8enrJc8zKdGox/SU
         3nconxKC7RqGHpBWoi7h3uneVkAAjbf0VKq977I0OxD3aRSnalEv8GQ6S7iLtC5x4oC/
         fbXU7o9Gi8i4fQVENs159Xma+qs4ITj/qRdllxCjEg+8lAidX9yjGdprfX+1enBNv+uZ
         izLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299886; x=1715904686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uGp0w2sme3T3nV0EQqTopwZWuCKWdcvzDVr+VeYxCU=;
        b=UvNzl0/tiO4cUTyKUF3BobjzU/5dGGjm0kH3Ph+YRMA1OQYDpyvY2x7L42km3cCLS9
         H2fkAS5dYmzbYTyqkwAOUMDZ/Cz6809bI/3Uit8RKYX2xtfu8ZTgkaYP6BwqEAOU3e/C
         h9Kg/IOYTLG0uC+ig/jK8Zb7x72mrpKVTA/3aqnaWTO73swlpAmaUXc6PWIplbH9UF7W
         uGPkx/+KJn9/iV5tDO6XU/GeZ858436MXt+9J5dG6ki6EMNT3jsYkbgo8Jn75J/nSo/p
         6Q71n5yytqvYZkQSBwyEYB4EZeq4I3LEH9f7975selyM/rehHnLtgTQ0oJD5LdTklEss
         G4bw==
X-Forwarded-Encrypted: i=1; AJvYcCXp4TMN5lQKo/mES0gkOMMaCFbMSPhVykKgCY9ovzdZHWBqvBqP1O1oBQGAGwFm4RbId307NsdpyHB8eGbQEPX5fjQUFvBPHG6sfM5TaCwQT0znSlUk
X-Gm-Message-State: AOJu0Yx/6L/etvIS1CJKOXZ4AgyDFINqWybr2Qs84lXuyUHcvpzvOYiN
	oR5ssd3theyRicGvWBy2mLVV8PRD4UjKDuh8h6a8bciyWSjcNKik/DaD1m6cJ/xYqGY4vpG3Xcj
	rbA==
X-Google-Smtp-Source: AGHT+IHM1dFUhZApSrq8Qk43aou/1xK0czl+ZTNebJ0VcRvNcsT7MvbAdQNPHgT1F2os/qMJBLL/r7SojXM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:d0b:b0:61b:eb95:7924 with SMTP id
 00721157ae682-622aff8202fmr3114617b3.3.1715299886235; Thu, 09 May 2024
 17:11:26 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:05 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-49-edliaw@google.com>
Subject: [PATCH v4 48/66] selftests/resctrl: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/resctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 021863f86053..f408bd6bfc3d 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
-- 
2.45.0.118.g7fe29c98d7-goog

