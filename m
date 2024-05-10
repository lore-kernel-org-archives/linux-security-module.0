Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77F11350C6
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299839; cv=none; b=dSD3ypuNyzptmz+Y4zeKbLQ2pfBb1a65JF28rQpjVhcVpSen9UtNEchKiwjYTvXtdoqXcSELHadvJfjCshhm5zfdWScBA5vJ6BfMduIGxAi4ZVhl6e2sKq+9oGENGDejw8ggpq+ELlwWH5jCc/HoBGnYy0xPPk8/9CjzdZM2Iog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299839; c=relaxed/simple;
	bh=wlmn4AObPrgDv0Hm2gKGQTYdsGtChXLgr+nGXJJY4/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hk1wUHfg8L/WMQdnu6KpIMoh4TKWYx88fGWbJ5qBz8JeBH9D3j3/IKae3mX13DqbfY/DYn8rhhZ+RCw1BH9He/bCdEuQIObsBfWT28OvP6YQvLf86vOeFwQziuo9yqzNKn4sSKaZ6aq9VTnhyR307aBMatDNkr5en4PbtZe4JlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EoerYLEf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EoerYLEf"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec620ccf77so10146355ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299837; x=1715904637; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=61ujdbgBJA7hBaMw1FTkAkRU+wKgPIJAgQZjX0EE4ZI=;
        b=EoerYLEfSDhz+3vRYhTqluz4DQmyt0SwypeMAdFtrKmaRq7lY/GyTH/C2JfgrbtO1Q
         0b8LE9LKdXmtCQBRls7tnFtmgj1ts6LZUQgCkQmnfwlw2CVyplpZKGqjzrws2jDDivla
         NdQOppy+vGz/SMO73CFxq6iM7v12KYk3FFCZAoohZipL3fkoNgE7gIhIgoW8TiCmNqqO
         3oR5APuiy8Y9l3CsmaGioz03ES8x3FIRbsT5RRw93JY0nkV/ZSw9FwJMWuoTQ5/GfJxw
         WzXMN8sRxKrcbQoTUyIx6HI3NE30Lumstm7HBYVfKKJoA+NFwiYHh2sbK/X5IZLwxHOm
         MVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299837; x=1715904637;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61ujdbgBJA7hBaMw1FTkAkRU+wKgPIJAgQZjX0EE4ZI=;
        b=VDVEe6ORIFV8NXI230jzA4BMTAYpF2B8vs5ZKYy4LYA5RnGSVmQqe7Jj2zTgemV0R3
         6vkGQxAsmoNmudIWqNyKHqbO/1CQk3IdvGEsUPuSh/slwGWj2Up8/iOYalScPPx1eHmt
         l2mO9K1AU3ynG0TSj+jEag/TKXfC6X5IE8bpUGk1yKNDaAMtZJUZhjvTp0ipA8ZUPmTY
         gLuuNcmYsUkKqyQMU0WCpEFMChrbOkEXQYMmNzWJI+r73eFuXtBLDw2xOPoTXP7X1swE
         8y0l2MZbRnsXT/z/4cTyXTCDcXvCowqOQd6uqbth66xfXvdAXNuCY9dPiUiYBzr0qQ3R
         jGgg==
X-Forwarded-Encrypted: i=1; AJvYcCXWLGB2KRvRIaEPAOb5rYqolr94bnwZMkf87TUvzIMPWBKwRY1en837MD3E/7PwGPsjn/1+769zzi9k19/jk+3e/gNS5lwpOvLTYvbJjghZovhWGOjz
X-Gm-Message-State: AOJu0YzTR/YcTzL2jc2JEVET/noIQ8vig2eHOl5WYCKtxCg1TkwfBp/f
	+9jYVAZbc72dBFqRtuaE7hq26qhNTlfdvz4aP40mAXpRlzxifq95IpMAf/dlMsarjmdBJ5nBnEh
	kwA==
X-Google-Smtp-Source: AGHT+IEX29rms0aLtTn1SZAsrDZtacJcRB8cxm1NLPKH6gECPB7aZd79XTYc9jRYmlM9BfQRpDg9N60T9ps=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:dad2:b0:1eb:53de:fb with SMTP id
 d9443c01a7336-1ef43d2a43bmr588245ad.6.1715299836952; Thu, 09 May 2024
 17:10:36 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:50 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-34-edliaw@google.com>
Subject: [PATCH v4 33/66] selftests/move_mount_set_group: Drop define _GNU_SOURCE
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
 .../selftests/move_mount_set_group/move_mount_set_group_test.c   | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
index bcf51d785a37..bd975670f61d 100644
--- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
+++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog

