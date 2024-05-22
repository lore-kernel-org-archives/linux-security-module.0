Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF421487FE
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339638; cv=none; b=XON/yNaTAIvOaZmKMl7BdZCgu511gbNaKN9vvKyznugApPzfJlJ2xFnap8j+X5KRQr0UdRGEg9VpEgvJRkCO2t1dPJkWbBExdM3lacc86Ar3bLB81v7uCQp/LAESFzdkyaXWs9GKKYKsKJSvjF/pq4PdDqvt5OIXhLIKRp//a/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339638; c=relaxed/simple;
	bh=fCWkZIz40C66c8ZuJ4q30JGVy/DoIJa9iLkeIwQ83So=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pq+4ZVj3/yBZEquJf3ry0RcCPIFxT3xKhNB530/g7zVtckowi297oOaHBILduOOdWBPy0AMP3inKbpMvV4O3s6Do3YHJtUFnso6a0PikDTOYwU/IZ1E1N2HdNNn5MD+2PKV3kZxex20bnZJvXRowdJfQUR2NGyRbiuVe4wHFWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnJIEF4/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnJIEF4/"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61c9e36888bso235741317b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339635; x=1716944435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rW5R596XV/BhyRO+Ck1A05EK/itIG2yrmFZ6NrHh18s=;
        b=cnJIEF4/TzKTmlxcWeq8SDaB3xEPS+7PNv295XGG+jjbFJchGx8wKybyjx2eEtWSs9
         4sJHzk7/7OZPR4HN1LzuaIeO6P2wc9Q45X1NoGDSyBLXq6yrFccE/G8r/Pxwt59sWZO3
         Y49EGFjzxMpAHK1iIHBwDn9BtptkPSFqxKRoqAUAcDriRstIMUEY/Jl0O8HWMAcbAWuR
         4oh0gzodT/AGuSH9634tqx/YbZTYq2XN6AMkwe+5uq4Mer+Y+aODiQYQ+6EJ4mP5nF84
         9uYZS6VV0GhoaltI6jlCfmj1I5npFyq2IIs2RjN3p9w/FQ/drdB32glw/kUOeYPK1JMM
         dSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339635; x=1716944435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rW5R596XV/BhyRO+Ck1A05EK/itIG2yrmFZ6NrHh18s=;
        b=a6uVhhC7WyqhWkLeNHfvx0kImZcsqLlP+N4AjgjS8Jg+cPV8hZuPdRxPK1RBeI56rx
         NkWlWCUyv4EFDU36xr1k3aKtyl9y7kspp9FZxSVxWH/iLPBDvwTZgTpnrfjqItu+PU8q
         QEVFpeqeKChpFo2hkheHK4ERKwxa4uixL/gyCk6H+Vy/Pki5cyLJHFN2scdtylbF4wNm
         SexBPO3GyOavuQZ4l+pMyJpKoCVJua9/47MKxMIM56d9lauTqXHYwN41oa+RAjswu4pW
         WYY5FliQs03is72gPMGFColoDaGHGfGUOJjO4L5WZ9WUrJ9eh6JwSW5RnkMj46wIrKFu
         dFUg==
X-Forwarded-Encrypted: i=1; AJvYcCW9DGU8cEurNJQg26QFNlv0EDhAJ8o4/01yl3306S86UM+xFg6UN6Fsl/ZN1LidmvZcNpj8MoUtyzRCYumFo1maIPF5XLz/dJpY3KpUCGQ0/nT7fbd/
X-Gm-Message-State: AOJu0YxDmdO1x3BwpdayP7dvvJ0DbMR4bJhf8AoTa8vTtRcsoEtyM8/K
	Tj812HJa6HOz0SUMFM0JBiXaf7l+roIoJqGQJyo3rIphZWdH+sgj1VyUrl/K9SUM8fZxWxnmYj/
	UOg==
X-Google-Smtp-Source: AGHT+IGfBUkXH3c2aGY6dfFSwVcPLg4SGb/q7ma1iwiCk9LmStygJFAZaLHBuK+Wl9geeHgSjlAVdx8zQ2g=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:e20c:0:b0:622:c8eb:6ffd with SMTP id
 00721157ae682-627e457c42bmr1733007b3.0.1716339635044; Tue, 21 May 2024
 18:00:35 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:09 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-24-edliaw@google.com>
Subject: [PATCH v5 23/68] selftests/iommu: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/iommu/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 32c5fdfd0eef..fd6477911f24 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -2,8 +2,6 @@
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
 
-CFLAGS += -D_GNU_SOURCE
-
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
-- 
2.45.1.288.g0e0cd299f1-goog

