Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BA729428
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299768; cv=none; b=mVsk4zqEzpxgWOpg8nVdxQbwC/rXAMOWhO6vXMSUwlhBQfrk2dDp2kpYUYZmLqQjQHhGFxB/xv7HH5aTcww3Oc+/s0Cv+555s7Ou41ShIvmHB0rRAfIBAlSDCzCkKOjUeBcndv2khVhAAOKTB+e+d6iuQNTlzmyTpplcJdGMbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299768; c=relaxed/simple;
	bh=GBCHtpCNZgGcVzsMNRMUoXk8ZNVoZVPhM2UaZwCtJ0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HlVRHUiEjJ8Nh1Z2fL5+/F1pk/dlyGgeB3JWdzxnh7Si0WeescTXHxa2sOjTP5tfnXc1b5eLSbSgVjKVfrB3V2BIDw7HWGUe00VzogxSAx6iQ5ebo120O1Dc5cJiI6NzxKTPp/A3NVnIfBhvzNglQaUqMZSWjL0hCgoRZ3Y9de0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGhA3OJ+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGhA3OJ+"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so2976599276.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299765; x=1715904565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=320iwINBDe+YZC8kG822TZZWXwM0JV4KQ67hb3vAZyo=;
        b=YGhA3OJ+f1k/Hy3oTUJ+h+wqoX8rf63C7mTjhTi+W917EBcIi2lzxHQvKyPK4nFN+X
         RbFix2c4omSxLF/4WEQouTEfV9McpUedMQiGTF4Cp+38BUbpQjUK4A30EjVpfgHAxvaM
         eZIoK9P+Hq+mbRbB4ZwOaGhbc/cHcWFr+ZS+rHzniGOCff2wLA2QZpjaIVvI/RMnr29M
         OHboW9AdZfQL7ult0VQdr2q3wF/fHl8T6gVRCwY/UPNbDG6oswT/9D6LEc9ju77SeWy8
         LOmThA7iWDAK6DGDd/+slFJ7xYc5zsbRAVYefo2sxHvlKvCXpjrtNpJvWF41BJ5Tloan
         DCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299765; x=1715904565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=320iwINBDe+YZC8kG822TZZWXwM0JV4KQ67hb3vAZyo=;
        b=S3UdYt4JxvBSy4gKlYKkP6LFk3uPUr+jJJbLPj+5bxvUxii7wzjjOD2wZDyT1fvnLi
         eIpdR/xmAQB+s9pRcM7al0COhplsIQXqRV8KtdkDdQPkcm1hnDYwTt60SdvwfgIKgvuE
         cwSsVlw99xp/6JPGL66R3v7gQF6i5G2Eh2LQ9e7+99tB3XhUYUcGtTPF8RuSLexlf/23
         IKfQFK9KQ9wcTZZyWkc64UkcSQ2Ra+JGmXKU6bhIqcu7TXBZ6Wp+Kc4YjIT0lizQMuXW
         +dqJQ1m5ID1/gX0msFe+oepBh25uszCXpLzpcZb8prytFwBSSVQSnwBcDntiUfA1C8LG
         TWuw==
X-Forwarded-Encrypted: i=1; AJvYcCU0XPy+4HClNyG3ywZhf60gJGc0J99VYWe0JQIRWA5F2KNMq9VV5M5UkZUXojG5c0703eBhsez9MPxCk0S2N2j7y92wcMLVHtM1lAMbVIhL7LufTmhp
X-Gm-Message-State: AOJu0YyRqE2XyMgAhimq7nX2rpIuxnsCZ4nx2aVZITHnHoS5fzSYS0+5
	n5M8UUlpeGA04rxww1vvbX7c0fhGcUxSJa6y9nldyHsffGIKcTTNMxQf928IHd3vScJXUgDK9b+
	Qdw==
X-Google-Smtp-Source: AGHT+IHhdRVjLPgT9pC+WY2EF++s/VK65ryEcaU+G/FrBzkZfRWKSkfQV4/cEEpi+Hrs8H/1X2Pp5ybXSbw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:20c7:b0:dda:c59c:3953 with SMTP id
 3f1490d57ef6-dee4ef7b783mr307444276.0.1715299765371; Thu, 09 May 2024
 17:09:25 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:23 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-7-edliaw@google.com>
Subject: [PATCH v4 06/66] selftests/cachestat: Drop define _GNU_SOURCE
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
2.45.0.118.g7fe29c98d7-goog

