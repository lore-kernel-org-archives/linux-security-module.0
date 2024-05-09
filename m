Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900E1136672
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284904; cv=none; b=YDr6yCGypy9Fy9zrLz3esmKDoZm8jnwm5Nk1JnoMWTj2WW4Z2ig9xdewI+nY5iAFCDOVCFw2SYyllLuk3TU87o9CEXVMG0OC+FMbkIz0lvVoByGH9U6aVT/1gWYME3m/xj647536nKdjUnUu0pDhUnwC+LcPe1Qf6WYLPGmgg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284904; c=relaxed/simple;
	bh=IwTjZ+QkHecjItm4ac17VTR49XMvagwZXgy5gGzNQGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oL1MaLRF24CTs3Oh6Ty4+p0BoLAbcL2D1583clhFmloSf31LeimBTHo87tX7frQKj8gu7Y58gVBWbxZRSNQiztfNSsWKpGDw+v7Fz2UlTWuN69oymNMzXkiLv5g2PWPFmLCCi9/X3Dlq1KmVENp1m/EBvBRXDoHq+VRbrMVa5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZ1i/hQ3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZ1i/hQ3"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so2195874276.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284902; x=1715889702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlZHqG8GOWNVngCs0QnGJEkofrx6wgIMd4fjiXkUQc8=;
        b=hZ1i/hQ3iQYjcf2650k3wXoi0TtKjLrsTyOhLuuTzHrQfURK5hdVS4XfEvSiLsPFpM
         g/S2AeXQFJb0jMwwhSYRy/chnRePBxIJwgDq24ueEa/o5td+sslYBrmiBahvYan0jCWH
         pZlQZwu9URZtWSSo5/pvUZ8HFU8fe9aIYDYha369Y+elTzT0h8sRzFuLO4VkYAo1j+uD
         dfqa9H3Sn+OQbmG4Knz5s+MW+0xK6k6p5B9YviwXnlun2rOaQmPtHEQSbB4UTM/TV9Om
         m4fW35iF9TUfeacThNS5809727tL6HRWPgTYIqjM8PRkssbguoXYaokaJ5lRiuEQcIo+
         vOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284902; x=1715889702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlZHqG8GOWNVngCs0QnGJEkofrx6wgIMd4fjiXkUQc8=;
        b=r9mulissmGKuQQEKIJZ9bF7STtJ7UnV/zQ33kEEMAwX/dgG/eAl6Ml2aFo1TY2TDhf
         Sxoryd7K+GHpITqE4aRyagULxOSmjTu4/AqlMRoH/jJSCYaEkFvWHLIrIcm4tAUqmKJa
         YP0Nj91aSOUc9IGcHFrHEjOpZmfe0721t0rj02fbRzuQnAZ/U3m33AOX1V181xiAPW91
         3o1zD9F7URWTSHQCwqnaWld9KBxqxy0f/Fs6IN3QQVHbV7I3xvbhuCyx2WucJLviRN5y
         NXcPOAD9l/RnTutFxP4Xe22S7aWUMLvitjz1h9K1gd7xKHUQ6AtnRpie8Jk9MI5iQCzD
         Nslw==
X-Forwarded-Encrypted: i=1; AJvYcCWr4Tws5QnhAU+BQ3vpIEstd1b6hZkJsr14UqPXXyw+rUiiqxKznNryZPyc6KFL1d5Ks0MRrHDIllSSdsGCUE8eeOwCXQjK3d7fffOP3KRrV4h4VhVq
X-Gm-Message-State: AOJu0YzmXXyosrOw4iZSEwsUqaKrLPpIXbsH+tpOHOhnqhAxSSXFhFJO
	xSFKIWQgkBXRMHE9AqRlmU4HH9gscDb8/8Mw107mpDpAKWFMcmJV3H8J2fX1z+H64aJk1eIEJDA
	s/A==
X-Google-Smtp-Source: AGHT+IHyuWY5940dXI+8MYdK3cHUYO5oPq33T22zpT2ioJu3FvZMtTFAIbDVKX9sxGXi1YbC+ZrN2B4TRNI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a5b:182:0:b0:de5:4ed6:d3f3 with SMTP id
 3f1490d57ef6-dee4f2e03c0mr141982276.6.1715284901753; Thu, 09 May 2024
 13:01:41 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:11 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-20-edliaw@google.com>
Subject: [PATCH v3 19/68] selftests/firmware: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/firmware/fw_namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 04757dc7e546..c16c185753ad 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -2,7 +2,6 @@
 /* Test triggering of loading of firmware from different mount
  * namespaces. Expect firmware to be always loaded from the mount
  * namespace of PID 1. */
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.0.118.g7fe29c98d7-goog

