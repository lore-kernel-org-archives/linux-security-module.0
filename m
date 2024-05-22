Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC5158A32
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339742; cv=none; b=lKarXJlbfuQwakvtt0ErO3c9illzo0Wsu3ns38cUyegjznipz5SySMr664gYvKUd+sSwPfqofmZJtb58O7cLb/k/ioaGHhSrFrz804BW2C2m5NfGeHvXUxmyzRSyAwvsl75YFz/nF68mNntmD9rvqWsyuIu+ld+FMT6CBglyzgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339742; c=relaxed/simple;
	bh=2dSdaIUHKNYU9NiBlewrj4o0rP0Zi7R4nXCaVD5vxM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tr0c6HpzTKxVX1GSo1wbKWSOUcR9Gall42A+G+xJoKmCousSe+xrrUMSBPxdxX2IZZ2JVbwyeg0O83fVLLgQiIUKyxNth/HxiXv8ZGojvxKtN0N1zNQ+Ufd1NRAMumHQufCepDj/5sT9G2pAXVV7JEJMEAYJ0VKfxIIJU6xHZ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4SDcbe0h; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4SDcbe0h"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be23bb01aso284702497b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339740; x=1716944540; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlialQE3WRWR1pwtVktV/TGzvnI/Kx+cCanCgGp3ksk=;
        b=4SDcbe0hzncIgFzft9f25PlT5YoFOqLxQm1RpCrUsB7e+NhlSTvilpS4DZm9K91DbD
         mz9AX/qIxYaSa4QgEV3jCAd1XoxrCXEgFxA2whFOdqzA/9cQNVetH+DgF/27+nXIEx9G
         pvjXv+sAzaza5oMO0ztavyMwkIEg7xEuVXDkpDTV/wHcJnvHV+iYN0QVmd3WLCZ0MqBh
         cymV/4Fchs4WjoGhdYj5RYmVX7OO1iFqnmdSuGEa646qF/uCnkNzsBHVTMgF3HGy5XjV
         cdkV9LxYrSc7QRLcr28I1WZwHOB8nxVhvXCW3Ii1KPb6eSOU7z0OPqqxHm3ZsjPuezUJ
         44Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339740; x=1716944540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlialQE3WRWR1pwtVktV/TGzvnI/Kx+cCanCgGp3ksk=;
        b=CfWvat+wu+8lkNCmLvB03BmLgBKB06uDTaZmayw6EJG0znYMhhixUKBinsW0RDrL98
         G0ohd7ToYNeWeQCCK/UFrPmNitQqpun5NXBOcEnfubVTr/iD5AXMuvQmnl+iV6AxmRO8
         UXJeXYeZcv2mZcNQ2XjH6aoLOjkLiQ1hTXHi8cnLIOSk/oT4/kCye/4fe9EFWEIFkkA9
         EYh6Q7cMGzhFFuQvCOYizYHloW+OXEAYrdc1JQkwC7/9bfv5LMjXnKyaXAgTxhvhOnis
         IM128868XL/+9Lhw4L0JQhrFzuMQLr8yWz67PBO4If2T+Ra1o9RMZ+n6GuaG9r1ZiwV8
         GQ7g==
X-Forwarded-Encrypted: i=1; AJvYcCUmhcfkyNhrdwmFtTTpp8o9b/BFbbe4epJIBW8zXeYSpaLhDbBElyGlT2KgDvTqJo30ixy/pNlxlvHlSU7wuwCOsAHiXvujEBx+v1JRFy+yhrVC5z82
X-Gm-Message-State: AOJu0Yyi/suo1fTNNalxldm1KFylp7JtebaiTPDlAm3s4TV2QVpNMgs+
	RLUu2VhdXhigi9pKtXBeHT5BfZvDXpAU3mVCaYfPrCoW8/5vWGdylcnguxW1NDYY1AnO/lLFMds
	eBg==
X-Google-Smtp-Source: AGHT+IHHzL4YxLE2AEcSk2fAIkbtuKw7ZK5BSNmkghB0hZ3ZZbutYPAUIbkCPCupmeXDdyNkLsvPeNDVP3A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:df15:0:b0:61d:ece5:2bf with SMTP id
 00721157ae682-627e46ca886mr1794187b3.4.1716339740171; Tue, 21 May 2024
 18:02:20 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:44 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-59-edliaw@google.com>
Subject: [PATCH v5 58/68] selftests/splice: Drop define _GNU_SOURCE
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
 tools/testing/selftests/splice/default_file_splice_read.c | 1 -
 tools/testing/selftests/splice/splice_read.c              | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/splice/default_file_splice_read.c b/tools/testing/selftests/splice/default_file_splice_read.c
index a3c6e5672e09..a46c5ffb573d 100644
--- a/tools/testing/selftests/splice/default_file_splice_read.c
+++ b/tools/testing/selftests/splice/default_file_splice_read.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <fcntl.h>
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/splice/splice_read.c b/tools/testing/selftests/splice/splice_read.c
index 46dae6a25cfb..418a03837938 100644
--- a/tools/testing/selftests/splice/splice_read.c
+++ b/tools/testing/selftests/splice/splice_read.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
-- 
2.45.1.288.g0e0cd299f1-goog

