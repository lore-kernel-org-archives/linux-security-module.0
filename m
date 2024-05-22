Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA615B0F1
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339753; cv=none; b=Gpi+NmsapH3tHYanNM2+9IJREl2FNZedAMuBnVmWxsESyS8MdWlyHbhugvY/VMtKDp00/zRirLY/NL9of2Z1vHOcvY498e3i3ziXVvb9fWKPSdw4sksdFVjT0yv3gQK15mQpoTTI7iNimkVjHM3rBSrCOqZzkqZQg0FwehbmCEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339753; c=relaxed/simple;
	bh=wwHClzW3HS3k2rxcD4xGD4N6MPHNqeSCS7dmFIcppCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NZJY7wEw5n3YNLZrvBcLS3US8tAbWDaNzi1pgnANN/PbIXnpXKpwcc5d3BANZq/B3YcbpkAT0are3/1PdDQF09tlNuRKp+JVLoiV3WGV2Guq6v3zZexSQYpT9gENizxdjT8odPxwzhCGXQa9xhHlD+8rMcDzoZoWg1hO3JwDgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wuX8x+Cj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wuX8x+Cj"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b58c1d014bso11288386a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339751; x=1716944551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/alAv/4/ktSZrlS0Fd5uW+NL7frJ+JSUceLln6ipw0=;
        b=wuX8x+CjchNTr9X9opshIhqVft6MqCMBCtr5VA38Gljf19w/RGAGdV7FcG84sMRt0b
         otwPYBEprSfBW7bSogSTU4p6z4TcjIWHI6oCg7OGtS2FiMEECiknKtEOd2wtvhrO3ZE0
         5i3oRS1BoD4AvPbSZ7lURZ3MlYaExtWsSOKgd1Jpa9mgj2/IApdqwFSg28PqgLwY+LrY
         JOHdv3fEqlRGcNAqsTtWlvyr0HKsapg8DggCdrFhKIE9IgRNvTOhn4xb1ih/c9l6vGKw
         uPGKwrYKrBY9Um/ntaXZ+W0Dw7ZqOR/IJfpyV1Jf9IzhxXFfU8rbli7nRikY//HXoIUe
         C3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339751; x=1716944551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/alAv/4/ktSZrlS0Fd5uW+NL7frJ+JSUceLln6ipw0=;
        b=k8N5BvDxhoJJjDlwEUFnMjtba8fZjQptCzTHWXl4psXJuX8pCNPIs5GK3N7+hkx8RW
         gsfY1urhdmBGYfio4tZ92QlPqFOEXiDypgREOLU4aBpD5WozEZYGYPTO5Mr0RjSPvdxI
         Gq/sX1qGPwfD3F6Aof9LM9rkpPiQt0eD0dT5jCZIMVZ6to0O8vwukeKZnwLCBVNsGwJj
         2cPu8IrapntMcO8mo4aqNFj2y3OM483alf14CFVhtO1vU/MJq9XgtapSMOxoks+OXMDh
         RYAHkS742QQx9zXkt4wz2+BZi8EmZUVksfuuBRt9tp2k1hMGFW66KkqK0mVM2bvm9F2z
         Ygvg==
X-Forwarded-Encrypted: i=1; AJvYcCUH3ak1QhQ37m51wNxZ8eDH3Aq1EWxCHYO3dFpbuZpmWGTF7hlsreGOkINC4gxBDxo3PlqAsy5UCJZvjtLqNtZ4buPbGvW3m9uv2rOeZKSDAMu0xhYS
X-Gm-Message-State: AOJu0YxlZqijCO9Do6KD0bSBEpBG2S5w3qLHI3vxAOX+UzKFiwuV6m+T
	3365ujhFnz9FEPiKX+PVk++QdT0I/ZhYlYITmPaNN7NfUJAu+ulDNbL6x7wO9VruSfD2XCmM1OT
	YCw==
X-Google-Smtp-Source: AGHT+IFKRYUemB9bQi8KmbkmxRhMBRRK8qY6EnK/nEzjCpEKdmTU9GKLzNY+XB779KpN4GXjVpxm8X7d6Ns=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:3008:b0:2b2:804e:fbb8 with SMTP id
 98e67ed59e1d1-2bd9f5d4c18mr2338a91.5.1716339750670; Tue, 21 May 2024 18:02:30
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:48 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-63-edliaw@google.com>
Subject: [PATCH v5 62/68] selftests/tmpfs: Drop duplicate -D_GNU_SOURCE
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

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/tmpfs/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/tmpfs/Makefile b/tools/testing/selftests/tmpfs/Makefile
index aa11ccc92e5b..3be931e1193f 100644
--- a/tools/testing/selftests/tmpfs/Makefile
+++ b/tools/testing/selftests/tmpfs/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2
-CFLAGS += -D_GNU_SOURCE
 
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += bug-link-o-tmpfile
-- 
2.45.1.288.g0e0cd299f1-goog

