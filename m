Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640B133425
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299835; cv=none; b=paVlWDdS6dHvh1N6Hyds4o7WE5ST73OMDZIr8+wWpAwXnorLgupZnEAgbXKUlgVIRvvqGkfslWNUxEeSopmZW1tqr9lpzDc42xf5D+1LhW8ZOUQPZn5vE0fxJNp/YRMJKY3YNhoKBo/866E4sZr7ouV+zBJpgQlx2BW7KnXIsss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299835; c=relaxed/simple;
	bh=CgsUAoxPLiPX8UXSGEfYBMmnWIxR3wtc1giA2eIVBK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HW0S4gIXLVKbvidkd4STdAlAzBwhCXi5yHh9E7lF6cGgqln7nDoP+a3vjIsgOff1TsOJWvUl39891MfwsfTC5rsfRsY5kae1ZK0YvAdsIOnUj8sthRrgGVTJ3LEvJW62EMMBJp4+uVmSai3Pc9c56vSe4EXdPVBKc+4M3WiIfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vAdy8RqK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vAdy8RqK"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ec5104ce06so10848945ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299832; x=1715904632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRD5r/wA6LFuHwfkjrFKP2eh4q2idhPkvQWQq1X7Wzo=;
        b=vAdy8RqKtA8cXge89/O9eEvRkV7lAN2DSHC+Ovo7RIJu7TqcajV4Ph8hYrALLfi0U3
         FolfHCtqg3ynsgB1EY59zlZIkKjYTrJS8MDH1n8fze3VLhACdXvUWhHrZIQkoFAd3Eic
         jxgl3Wq/CKMY4WdZBmcMpPqP++26e9g2d3BBbRVgmEmKtiBQBcfV0ivRVi2jcW0HvHAw
         Hqah7fKoJqPuSQbvuz6i3F/nlMB2id58nBMb86URfK9N1MTwAt7q5lYPcnN+Qe2DEmsj
         37ZPFKL1JZHnpSAgf+alogSdg2+LMu4gfGPgaD6aKRQjq1OBLZl3adiH0Z8AD5vFKMQr
         fZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299832; x=1715904632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRD5r/wA6LFuHwfkjrFKP2eh4q2idhPkvQWQq1X7Wzo=;
        b=jsMAayxMQ+2jHS/ZGPv+THQ+EOldQCntlm7XalWag8GcEqHg6mkiBim3REqPJqmpZv
         coaO4fOzSByWrX4zpcZ8FAPGpmI4jc/Xedf+d0Q0wL/BQLFZj24AmDS663NqwbdJCAQ0
         5h3U5OFpPFFevu8c2rRNV5rOqlyjmEYQTXfsI3cwdx9//kWjisL6OFDeZ5rntXxOJwIH
         z55R8SiDE74CHJS4ZarnsJz1ZNKJk+9t895P++5viUumUTPFwg5Pnf4MHzbTXB7pNXcc
         Yt5GWODwaAiQfxWj2k1dpSz9/vNyaIov6XIdoQ4Q0U6Jstkx1PSJ2Jum6XcxkFpDwdid
         vVJA==
X-Forwarded-Encrypted: i=1; AJvYcCWBz0pVokT/rclQL19Nuum7Ujrbm136k1ljEOVNHjfazpgLZuDG/7SBmLCbfJUGPJpsrQEJAWP86xF39wtsaoWQNJJjqALlmNzo9bm2Im16MawlPw5K
X-Gm-Message-State: AOJu0YyRZoeceetNnoa7E32i/to4x75a73OTu8nCNn4cgK78W0UEPU7o
	Rce3uRV7L+QzIG7HExIeWunknXSGXkhcwVCH5RiOveCzlRFKjPyqJi9BtgOdOBTLXO9qibA8UJE
	tFA==
X-Google-Smtp-Source: AGHT+IEDzJ9OdHaeOmAYQvvoFk5BGCHVLxfMsZPnMjHHpRLYJIvs9vIsDj5Z7+M16ZLAYicM/PHIiZdIM+s=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:854b:b0:1eb:f1fd:d481 with SMTP id
 d9443c01a7336-1eefa9e32dfmr121525ad.4.1715299832494; Thu, 09 May 2024
 17:10:32 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:48 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-32-edliaw@google.com>
Subject: [PATCH v4 31/66] selftests/mount: Drop define _GNU_SOURCE
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
 tools/testing/selftests/mount/nosymfollow-test.c          | 1 -
 tools/testing/selftests/mount/unprivileged-remount-test.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/mount/nosymfollow-test.c b/tools/testing/selftests/mount/nosymfollow-test.c
index 650d6d80a1d2..285453750ffc 100644
--- a/tools/testing/selftests/mount/nosymfollow-test.c
+++ b/tools/testing/selftests/mount/nosymfollow-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index d2917054fe3a..daffcf5c2f6d 100644
--- a/tools/testing/selftests/mount/unprivileged-remount-test.c
+++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog

