Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E847A15B14D
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339755; cv=none; b=gTNS4es7pLPgxnEGM357qxoU9Nczj7RbyXR+b6bS7RFnohEIq7+sF6YgnJpUAkkVh5k5pQDeXnNCH4P41qYRGWFhwGtqB+2OZEpmbBbyhbNwoFZ/EMXvohryuWpQnMKb0Bbork4r0CJpwgkO5A1bL5LCknmTCbZlrdSKt5a+pnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339755; c=relaxed/simple;
	bh=RS7rPE8AKloHG6WzPsTg3jpXH0LcLyLyrga22Zx6Vcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGcnv4svNNJE7Q6a8y5C8D0fHc3579p4IQjDVY++ILaJyy4mzPMCYaOsMid+ZmejNybtc7IN6vEG8IL/vRB0mKISfRIFaZ7FCLK/4GUixEBrZ9Ay88FR/zK2yyBcWqkm1RaFvSSlyz4roT9j2sK8+Etixiu/LyJihFHiu+MIqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usQfgb71; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usQfgb71"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-622ccd54631so183410267b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339753; x=1716944553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxB5Ap62KVVuT4Uqpd1hkwJ0UXOFlpsGfFy42T0fhJ4=;
        b=usQfgb71T3STK152exlBiQIZrjlwDm4bMxjED0C53hFoJg2T3WHzWrGacmP+448v+Y
         guCCYaUTPt1n67Sag+1njjqoWDWdMoMMz7F75/EF5FFOxlX5NNiYJB6W14dnuEhSXRy5
         QTPUNvsQs0rhCPD+ZMijtPakju8kGwCmhiUKrj/uFbgwHlAGYrxTz5ID5vu8eJMPB+54
         Viw3uMnm3kshVvzrMEBCwYErhsjPC00VqKQI4ESh96WxRqcu0tsT/jdQqf84ejpZNygp
         IYRX8anZENkFv+87a5UeJ+JORFYylR5vaKyHMnJCXEtTQmUZT45lwXA3/YHV1ImSstXt
         NDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339753; x=1716944553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxB5Ap62KVVuT4Uqpd1hkwJ0UXOFlpsGfFy42T0fhJ4=;
        b=xCKFndrk/1czZK65QKmKQockVsdf6n9j4mJgkEMtO1Jz5aslJagJQsnvn7PfiGxiUu
         fqzK4r3st9NKvCRKn92NoHyp3i4QGIZfQbDrsmChnk+AUOBN/GkThob88mJMkCqhRaUt
         b5b8svAVHongR2KcKI2dbvRO+BTKiGiIesOG+vmf0/6HsQD80VbAZoRkHLHJPdH9oOiZ
         b3G1lf28QQ1QFPEGHxHp+Jpdai0tkoMNXh/GJaiRWvCu3el4niVdSHN0qhcgDG0pYRoh
         BnHxctsmAvvsjCnBTDdb9JtghsiXYGapwNlQIiIpD268gL62EFiaAuPI1UbtiL2vzbWB
         udfw==
X-Forwarded-Encrypted: i=1; AJvYcCXoqok5oM42aVNVCBJW1r1i6RBBa2ayv9x4+hU4e1Qm14j7OMpeATcp7dd9RbH6MiIlvlTG4cW8ovcqKsywM/g6oEk0Q8W5G1/il0wBWjZK0/nueTXI
X-Gm-Message-State: AOJu0YxyGmcbMSRKfNYN0EvUVJBp7JLxtQ94DhmHrGH5s+QqqawPCA9C
	3ytrr38QPfi1B36rNzP6uEikwfEoL8Qm5lHERojilAIOreH2ABEeFr5TRP5x0PAaGSfFJoFWin4
	c/w==
X-Google-Smtp-Source: AGHT+IE6DaOUUCz74vGUOqCerBQLQc2Nz00SvVsD82xkEGEYIxXJhZ7/jUS8DPdXT3VoOulznt1IlpyCyc4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:d895:0:b0:627:a961:1b32 with SMTP id
 00721157ae682-627e4886e1cmr1667607b3.6.1716339753056; Tue, 21 May 2024
 18:02:33 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:49 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-64-edliaw@google.com>
Subject: [PATCH v5 63/68] selftests/uevent: Drop define _GNU_SOURCE
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
 tools/testing/selftests/uevent/uevent_filtering.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
index dbe55f3a66f4..e308eaf3fc37 100644
--- a/tools/testing/selftests/uevent/uevent_filtering.c
+++ b/tools/testing/selftests/uevent/uevent_filtering.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/netlink.h>
-- 
2.45.1.288.g0e0cd299f1-goog

