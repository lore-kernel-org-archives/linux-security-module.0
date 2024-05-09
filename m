Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FF61411F9
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284996; cv=none; b=iEb/IYmDDWPk5REcWmf//Ce3I8+MUFDTL+zLL/JC5ynOvyahrr42CA8KL8+gPF/S6vuJSceMOB7WEEf8HHJrBDUHLDQ4Ql3Qt+XeiFO31QkEPkz5pK9DdgzyBxZ6XR8P6BJD+YJLcdyGeDFTWfboLBVpMUBOWEug0gi8/F9YKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284996; c=relaxed/simple;
	bh=mj1+9C9mGGt2xAUv+e7gPU5cUpp2meMCMmhcAJTBnKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eD1Rfff+sJifZhF/FB8bDdMNR73QQ5mobxFjohBUzI6Eg/ZZdfl7RASUEEEQ3QHtfJLn8y28Situu4pai6aaPOTrtxd8XRzm1pRAjHUIvSZQAWJSIedGPmYZtBTwxITCQzIgYH/nOYexevlQlh33oOkrbJLRhRxcZPm3fpEfY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+YyfEEy; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+YyfEEy"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f45487858eso894920b3a.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284994; x=1715889794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kj5kZHOgeTEFE9rl1cg+M+RfV2lbnnrAzPZA+2Lqy4=;
        b=F+YyfEEy24HlJ8TvMLojXarcltCLl3eql5xFMpaXaa1nfm5Ot/ODCI253Zk5l67W0Z
         TMj7Hb1ZqVDyjGE7RgYwo4wDgWKhs4HqJjuMsUg+VAY18K1Mrc9azxPRrhrmyh0jsgd1
         KIvfcXR8Q1Wmd9n+LxGtcl131g+8ujDX2dkA4pIpG0L2+6EANadHjGrFjxaGsJcdDNli
         ebUYJl33+PnI+4ciG36J4DNzwaJQijQ3zt/KuUp3FvD6iqtt4Lcy26Q+J+QIq7c2wScR
         YQhCMrenamPDwHOGZMDPFAEc5ztn0cwYPb+vdtIiMJzF1oohHls1RAdWkRmpW+lO2Nia
         kE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284994; x=1715889794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kj5kZHOgeTEFE9rl1cg+M+RfV2lbnnrAzPZA+2Lqy4=;
        b=DaB3YNQaxy3jM0o5pb90Hm7oYDqjSx9u/opRDOpLxbSGyGvndC/4KfX1YJyT+QfDWZ
         8XkeiiQjnxz+ts0xoBvOeHgaSIvBex5+EaJ2QdSbDUUKgYLpuT9S+3UB/667ub+iQ8yp
         f0B5N+52l8Z0MIYIn8ShJcIOGvQfiJcqZC7F1r1PWwwvYtgu+mkaHnUdTeEWGo7ZZQGQ
         KEmQHWqMFo+0PrPaN4kOhRKLtNfccBgWU0l8rTILC5I8bVjTFrjF4iED4YE9ykQ38Hv6
         Ggnd/PyPNPyyc7ia0qWAMLuGO28b4sP65s8DxHhfVewqLAvEoU17Yskw7+hKEqEEx4vg
         ENVA==
X-Forwarded-Encrypted: i=1; AJvYcCUwlKtZN5oX32yG9tUy55Wj2Cey0XRY4yKOMF4NFRDccYxTfvD7OIz9HOi/Lwkn59qAIe+XUKNXhfM85RkKqT1vxtOnHartNVvj/9wGlDA4XUPBMe2i
X-Gm-Message-State: AOJu0Yw5BqafuF/vQujyTAMYyH1AalIMzP3Q1Y4lPQxZVoggxGXSYseo
	24/r9OLkwLP3dlyYsCjhWCvmI7auiM8hukhsTjVid5HV3QhL3g2tKVckVkXNt8LTiBtm4R8f9yg
	YyQ==
X-Google-Smtp-Source: AGHT+IHAGY8ymc83X4QYeJVn87tCufTNrw9Kmu80cCJPzOsgO8hVIGuL67CoY+OKX3uI1QLyaTTUJozyG14=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:982:b0:6ea:bdbc:6b5 with SMTP id
 d2e1a72fcca58-6f4e029c2b1mr1517b3a.1.1715284993800; Thu, 09 May 2024 13:03:13
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:41 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-50-edliaw@google.com>
Subject: [PATCH v3 49/68] selftests/ptp: Drop define _GNU_SOURCE
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
 tools/testing/selftests/ptp/testptp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 011252fe238c..ea3c48b97468 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  */
-#define _GNU_SOURCE
 #define __SANE_USERSPACE_TYPES__        /* For PPC64, to get LL64 types */
 #include <errno.h>
 #include <fcntl.h>
-- 
2.45.0.118.g7fe29c98d7-goog

