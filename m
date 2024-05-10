Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7523D393
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299769; cv=none; b=lyJyyk6lcQ70GEB/ThaWNVJDjrY5cBuUMJsX7fvESJxyBVvfTBBJS3EV8B01rcnnMDKuWNmU52DCGqI88jmcjQbRhQL2rMO9YymJDTnrdSYrTHNuAgD4BAblAy+orU5x+R1uADBbNRb4Y//akmDPF3xw4CnKFWXWKFoqiPW0gdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299769; c=relaxed/simple;
	bh=Fdnw/LwGdQmMqFSFPRAfRPo2jqnRXRxdYj1IDRwmLsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hxKgxfQJOAE3F/ylRWIpCSZ0FlQh9IMZ9rS9UYRUht24f8Jc03TH5rTzjZCgja6F9f78A4RNlDgYfLpRqNa+6qshh1U+bIrbiaw+JooyT16C/CAWXplho4jnRiySN51donrNMhiGEaLazW8yl/1XdtgVVcVIlBbFnFgqAK5DJeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RtOIeBtv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RtOIeBtv"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b3717c5decso1382900a91.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299768; x=1715904568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmsZ7SnLiO3MTUumcGwO6/3xrY/wF9JsS2sT8ar9LKE=;
        b=RtOIeBtv8mdcccxowCto+UU6PjW/3sFZ4bKzPPgp/8moiiFsgtEIxyCuvBm+9bXqkX
         GpfkrM10ldOpKd/mz7GGceV/glKmzTrM3X/4aVt8z9rRWee8rQztzoVbHAH1UkPfM570
         T+e13MoVnQYr8DCcY+XS8wbkVe5Kvr+qyHXd/nTjfCllifWaotWX39y2VV5OsSzNChGN
         Snf+pJyQDqICdPPzXtEu1y1qVGJJ7oSxaJJgyUBOiayHFNKm71aIl32m43xc8Tgnnxyz
         6/gtOBexJC4LQnVbKmRl0ix4dJ197SwMAzee2QizIbu3Pr/jiz6XI+b5QX6zc9ea5zPE
         nQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299768; x=1715904568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmsZ7SnLiO3MTUumcGwO6/3xrY/wF9JsS2sT8ar9LKE=;
        b=BLUPOTHCHafNR1xpAvpD16ZFFlVSDESwe5C00d75iO/SnCO7gzA4lXLzbFyjst4Mj6
         pAp5Kb3GjsJZwBT6hE69Yb10kw7bbBW/Zlj74x7317sSse1HjjNwQKBp85FzEb9HmIH4
         rb6mSoitpa/dAeLKqQ8uzXuXkSaeKo4JwdEMDBi5LnM55y1VTkuYo7ng9r50QBrocNkl
         m+CMaQoyYUvs17OJ5DXDlFbhRl9RUD9TivNlVm6duczNlVCIcdg7OFxTHIO3R/i6UsFa
         oGvrJ7+Yt1gb62PPI2mCYbyj11xDeco+yE/gi6Aqy9TLPC+QZC/e1VXfnhSrx6chKiIW
         CLXg==
X-Forwarded-Encrypted: i=1; AJvYcCW3e936J9DsLlq/934w0Ot7vulu8mGYx9QsLYC4eS7aINZdKsjSNi5GzzgsedqcAA2aOaaDA0blkSTDSVE8Ok3X56lhE0KzShrVQfqREzndZ/RYzXBn
X-Gm-Message-State: AOJu0YwbgRlJeAaMQE9pY65DnNUovpxz+qRGsS2vAEmtct6Y3bcWp9JQ
	/2mKaBh0IGee4i+OmadNJS/quGTRAAEtlkM7Nc6jmdtPsXaIF8idWrbbfN9WanbK7Jm6CVbmEd5
	vmA==
X-Google-Smtp-Source: AGHT+IHvQVIM4JeR4ZgqjanMvc47tQdjM0e3oJXcocG1JkFtADLA104qts/GHMikYPcxHp/Zb6DHY6Ww0pM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:f695:b0:2b5:af18:6465 with SMTP id
 98e67ed59e1d1-2b6cb7d0d50mr2811a91.0.1715299767774; Thu, 09 May 2024 17:09:27
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:24 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-8-edliaw@google.com>
Subject: [PATCH v4 07/66] selftests/capabilities: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/capabilities/test_execve.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 47bad7ddc5bc..7c37ae2407c6 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <cap-ng.h>
 #include <linux/capability.h>
 #include <stdbool.h>
-- 
2.45.0.118.g7fe29c98d7-goog

