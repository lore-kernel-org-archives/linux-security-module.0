Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A74134426
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299837; cv=none; b=VgRZbiYiyeHFF2PP88hAQb1eH1GeZ2M++Ce8RQNwCAO2VT0JXgkh19HGfVA+2deLgNQ0jBhEBmIVnVHKf6K0ATezNhm2zMoW3IFWBt9CCvtjFWHvUfPC3bAbOyqQ1SOCfcMWFncivD7sgfqvvVpBEWgB9egwRQisZf44G1q5uKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299837; c=relaxed/simple;
	bh=eDWuE+8ZHJTvhDSqm0UqgHUs2LzpKlCgtgR/lrBU6/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bMCv0JlrIwM7SghfNpaWGkOn0KEhH+X4RFgUiUM5ea9WPxU2sYmztYMeOswrVBG74weplbQ8uVAALNsVevKItoUoj3IT4hmMBlEgAz+NtIOwEtk5wpjgUAOD0dOQJUjua2SV+5TYo+sCq0aGEJQDo8FsMPruKbWRw9KeFRyebJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSQv2WLS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSQv2WLS"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be325413eso18611497b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299835; x=1715904635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6IDZpyB3UrvfTL2t0wE57nV4aaGR/g2u1ts2clTgN8=;
        b=bSQv2WLSopB2v+1KZm8IwOgLuHIEUVK+qZzBvEZW8TVdwSts91OolEh9nhb8DK0rJF
         yDDicW3806mNqg0SL+NQzL6WtN/R0zairyXk6vUBi1q5bF2ZisVhXu78Xx+ImgAIL0nr
         Ua7VbCTtenVKTD7atgq0SmFMZIK3eBOwuWRBKGEZfx4lt6vMIpIduZm9oJgNcg4D3LOT
         k7HonRz8SOGYaRAcj9BxgyV5m7UkZNo2pwjhv3I4C9FXPa6ci2GNthcoRHYb1jEceykc
         7VqY8+7PDjtl7GufBSi1bcWd8onQ7OANUnb8qH2ctcOms/mb202ckQh901gzOOMMjmhn
         PDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299835; x=1715904635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6IDZpyB3UrvfTL2t0wE57nV4aaGR/g2u1ts2clTgN8=;
        b=hLVocIYWCSHxXdPnvbMQu4KMsGS5T91ivzVW6fptRtWdLKVX1reDy+n9WLpnP/zlQR
         PUHQVmFT6AXxYjC0TJShcCe399kyzMH97ezfHTZGkj+QKJc3Lxu1QmH+Vga0+FCtJn49
         TdRqJsuNSuLPxx6WGHxFwXVmWjc30Vdnb+cL0GubWQ6X/Al++Et9GYd45wGoVOWfwtUh
         pPAcLJ5g3v0M7FWIgREb2XfrCeXCPlBlY77KWbVAAT0SKUYtk4EpQ9mJZEx/IgQr4RNv
         wcIUm/OfzM/c1cljBMhmj/1I5Fp8omzT3nu8ioUE4BMimszTaXCD3s0i/h+WKSn8VtUN
         bLMw==
X-Forwarded-Encrypted: i=1; AJvYcCXXXtaQSLMS8V1Orf7zNfY+Bnzi+QbrHCpKNTik9hohTKfnuHgvkjBGbscHYMlkvUPX0btwsVlCCcQkjqWi7v/z8MWS4GcCgl76cRmXDVYKVDwig6E8
X-Gm-Message-State: AOJu0YyzfFaaM7nDJMqRuB4OpqtTdlmE5qG/h04iIFdCtfn3RXc9xo/F
	rHbWn1kn1TIih7Zx8Dy3d/zmGrpmc19oUE134qhgSr05HZ64Rrm5WWmEpQOyrbrVzihsUjsahAc
	v5w==
X-Google-Smtp-Source: AGHT+IFp9arQQjLfM7uxnfZTL7Hk72AcVMd0VRlUcaVAMmNJqDm8Jb/qv8j63n8u+Ogp+M7sZzeDo1rc4Lg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a81:5b09:0:b0:618:9348:6b92 with SMTP id
 00721157ae682-620992cbc48mr10042437b3.1.1715299834767; Thu, 09 May 2024
 17:10:34 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:49 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-33-edliaw@google.com>
Subject: [PATCH v4 32/66] selftests/mount_setattr: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Seth Forshee <sforshee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index c6a8c732b802..d894417134b6 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog

