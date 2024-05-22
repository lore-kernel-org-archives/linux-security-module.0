Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FB14E2E8
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339666; cv=none; b=JXKCwvGMdvw6LkqWgRnzedGrQ9rxw+Jw3imJzAANb4ffTOTWPos5zHuMeuNyEnNdBYk9s1D+bHPleQ2QkZiT3b6F8SIBZSNwN571heit2ffzsMto+dWEF3HCJJvl6qS7UdRXV8A84V8gFmuGoIRVhsfy+8xt3RN1GBLpiQWatSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339666; c=relaxed/simple;
	bh=D6pMabfdWOjYC/LSqUawpi3nlFHWIIN86xOHz+bpvM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SyXI+8kwrG3rQ2QwW++Dxno89NRJXaSo64t//e3QYD0MLhoM73JXYHY+J2L4EyxCBJdeVCCwzxLEExXh+7VwGF9T6HAonkNK5iildW6Vi64aOaJCptZIWk43TbMFHxtWvaOhyHVGugz4Oz4UnIOK39wAwUHeTq48Gpc+7zj9ssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2bO7ccy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2bO7ccy"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-604bad9b2e8so12371518a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339664; x=1716944464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=li4cMkwFpL+HSmSEXdVX350c2G+5+gkC9h0B1FeGGvM=;
        b=R2bO7ccyqs3tXPEKzxf4XjEhbrnu5r+YFZqHPax25EnIdejevjilIkRoyRZh5kATHu
         mj4e7Z5cyf7DC0Ggo0XqtiGBl/rzk54xQbgEsBE1fXps/ghIdm9t8Z6Wv73c31vzJMhj
         U4+wFZTG1by73Qof6XSsP6OcWwSnYmtfbddc6WIxgX6X8n5gnIJqCqAAvQzFRjM4HTwe
         MYu2cm7AIg8LLV4og13cd7Jo0YBdZH36XnI45XngbkueucjswSwycjSEyDdnVOz+mDPF
         FmhEzaw7GBKPHo/oJefHNVrIHRXLtMXzSbVIBmxxmSfe9eZUxedJ6hCUAjaMngmsaFKm
         D90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339664; x=1716944464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=li4cMkwFpL+HSmSEXdVX350c2G+5+gkC9h0B1FeGGvM=;
        b=AKs7U+tzFsE89FavtZW9tH+uI4vhRguUVUtl4+4qs8K3zjwbJvS2o8srQ5wMlyhUPY
         qhRjVeJoQaA/w6dui89bnV2lTjm/VLT2NRLKLo0cu3H0xpIiwqpLyH8Rju7VdM4lM7cl
         vJokH9kqRBFwtkOgfpDtzwA6YW8imlqZHCh3Bf2h8G5FAdSx+2+6fnnswu/FtYhDFq+3
         NHpiL3N8BE391aXFLfwAdVKsuLeH7Pyz3pIRBzZdizORLOeWpxtg+4dc60Zj5IHXQ6j9
         voLwyh+hsMWbDtErhyUuWCE67LhdbW7+Lx4xiKXziq/+DORX+lw/mY6IbsWjSHZr2E10
         YbBA==
X-Forwarded-Encrypted: i=1; AJvYcCXUy98Y9fE0Fw+Crmv4cCipWzxVi2tpRK0HkUJ2me9dYBtuf9CJbjo1MLIZbvXLE3ZQzy2ElbMkOdsV4Md/BqAmjauMfENY3sviJZlrmgEj9C5dDY11
X-Gm-Message-State: AOJu0Yw6g9EPBh2I0ryqXybeKAd7uOtcTWdIeLAIj1AS++649XxlHO9K
	cPw2TdVuuZ1ONdk+go9uFqPdGE6PvmnwEqYzG+9aDi/mZtyH/LmXLQxWaycqwSa4Sm/IBM0GoPy
	XnQ==
X-Google-Smtp-Source: AGHT+IEaH9w2a57rqCwXzXPT6DdBOoiiolYlPL4GLEwkxrskFIkwJojwmD2tTcosE6e+p+FZJxRnCD+/8cU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:2644:0:b0:633:af0f:16aa with SMTP id
 41be03b00d2f7-676492d62abmr1177a12.5.1716339664339; Tue, 21 May 2024 18:01:04
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:19 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-34-edliaw@google.com>
Subject: [PATCH v5 33/68] selftests/mount_setattr: Drop define _GNU_SOURCE
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
2.45.1.288.g0e0cd299f1-goog

