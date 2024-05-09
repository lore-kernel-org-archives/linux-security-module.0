Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A112D757
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284885; cv=none; b=WepViluCDys9Xja1nOEEae3n+Daxf2oJv1bGrYzDwgVBXZt3ez2fW0t5YMx7MtNSwXUauAMGDM4+bFpJqiI87m3Byh8hmAIReSDED/YxJ1qVti/HyocBz6S84TdBtAvICk+vnr9niuZ0UIuIBzMiVugUu1fxy1lHntSEuJL6+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284885; c=relaxed/simple;
	bh=1K0xCZRVD3vn54vwOcfFPXDF9T0L4kexPHQ9ePKy6Kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GNo2m2pqlUTSDrp9sXpXXhuynifeU4OLIsWl1y2NdRwlZX5xoPKJhoL6mcYLCDeCHZbQWt8yakfX/M9Kx9oHGfblwZEMGYeUU78Uco9BBCUpDD/kzogIsPTJSZVqZ9BDEBx/L7Yqwk4/TD96Y4WKxM+QzQFhNedJecjlh+BzbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yuy2xw9z; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yuy2xw9z"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f467b9e948so1252857b3a.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284883; x=1715889683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TU/vpufr9a9ZUHQPOG3JePKH031tzM2+5PrrIqHPNIs=;
        b=yuy2xw9zJxR0T90PEJcbIfBYa4md0HVAwOlsng3ZA8QNPP5v8ZXCGsUNTqKpJU9DHz
         Jz7MqlxMY+JfBQBdvjuHBjmIvUAa/bPUF9Nge3DC8oijKARoygZ/DOQt72njtY9PMaBg
         fqKoCNhRCHh85tISlcnnyaZqDyVaIkgHkLZZ0Uy1cnsrD4Nul36lya5dm2iR/g+xKJ7V
         iudhx/3GAtRnNTm1TqyuYeUCn2uk0b9d2wCwxtaP9XAYFyfZZujsyX6UNRWckrh/D39K
         kIXqoTaxhGiKIJS2oYupSUUQ0AOvMre3tLCw5++Xofo3KjmsjULAegRdpGOaPetFoqv2
         tnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284883; x=1715889683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TU/vpufr9a9ZUHQPOG3JePKH031tzM2+5PrrIqHPNIs=;
        b=T6UmediBi5gM8RcGiwkfDE40LV8UCH8Glhhvi1eOeenb0mC4gJGoBqPtgva7vDOezk
         x89RpBkbpWWZ6q23vlkcgT+t/QbgYNfJFtcyXre3nzi34YhsH4XXMDoO+F/x+EtGIfRk
         MMH0CmxBoC7PUI6UKV6DwykzBkkitmkqLscAEuY+XZwSohNK+k1zR7j0hZHcJiRU4xOG
         ecLmqTIpnOXn7H/pIHaw6d0vv8vC/pzHKGxRx/ykuH1KIVg2kRKSmY2ikYUc8ocOhLO4
         wOGIveuw6VLMr4NeE6cRoEf2bL/eMF3ZnMJKgBzU4R2gx9Kh181h5fFoerebEpBvjw1E
         JQYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV+7574CpWuxwIGoEnzcyT32fgqiuAKD6u7l+SHIWv/KgrFXsRCqPuyTYDKPP2NDDvkaq427+DDjF3efPH34F4Cxiy5sK/UjA0UqfK/wdilQsDqdg5
X-Gm-Message-State: AOJu0YzPaifG1nb10rO0f2k3nNuBo3wvBot5/84+PNcDBzS1l85w3fKn
	gF6CTD98HZocPscesyV9QnMV3TK6aIGef7pM+HFY7XxQXgQAPj0tRFqZ4QDrNjWnQVeCBZ6bumI
	9aA==
X-Google-Smtp-Source: AGHT+IF1zeNl7G2mrY5GSol57Wmpqj9CLyOfkFGR2ecW54/KxC4a46reBAyc7WewMqRKduaOo7Ktdkz2CAY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:98b:b0:6f3:ead3:c280 with SMTP id
 d2e1a72fcca58-6f4e027813amr25753b3a.2.1715284883459; Thu, 09 May 2024
 13:01:23 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:04 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-13-edliaw@google.com>
Subject: [PATCH v3 12/68] selftests/core: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/core/close_range_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index c59e4adb905d..1c2902bcc913 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/kernel.h>
-- 
2.45.0.118.g7fe29c98d7-goog

