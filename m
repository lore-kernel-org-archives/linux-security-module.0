Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378291487CD
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285034; cv=none; b=Mc9bWyhn0PbLLpvwl2nKH6u0KDOOSMVXLcb0D2r3hys15gNbF0ALWk3Q9mkTZeBa4m+3tmZAQqxkFXim4J5WTIyAjO0tnJogZLh1rc9PVN+Sqpqiuy3kX5Sy3emf+ovcdirXfkL4XaUTPYalva+mireFSlkTp0RKd/RtSjlxiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285034; c=relaxed/simple;
	bh=7wiquuIy2HmiwVC4XjxmaNtMUrPxv9NbPSe9jY3hsTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UcU3O+6p0AmV5DlzajbvGGRYAEPFLGg1WgRnMX0Wa6Bb2ECgV6gtjkI371YQljoviR0ehotgF/9YoWBgQMne0VdrFM9o+L5EwNAdZPo2qr6UAjXoDVJY5uGNCOC32CO06UdsKvc6h8mef6bYlIrfN0uVVRWMDAkDBp85hKwKGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxx88+Sz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxx88+Sz"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be4601434so22627777b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285032; x=1715889832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Da34EKHnCK9seOvE3VE8u71Ty/vHaksZJ1GNDYeo1pk=;
        b=oxx88+Sz06v0naCCHlb+wF1AFD/ZlK/nZgHB2P5R883k43PyqkciXYpMWsHNzUfQFb
         9YDTZ0R0dUufh2t+MGIaTh3upc6aBY+vt0tiwi2JjsRAy2oj4unxNfx/+ao0l36PGQnA
         XccK//KAWUWEj/9acPBtxcyxsNn5pVxvEItprfCSgEL5PZL53cLGIoUjn4Ch3AGuIHbH
         Wh22gBBw7HdKJefhBsIH0738te4x3w3eqkuyrb6gCI43c/Kshd1xZ25xSC6HCIX1HbNv
         H+rKWRVV7CPvqrM5EwUNSxxHcxlFPgm+BGJkBNOUwbwjwBIBtxmY0/udU5Ap4/U1fGkZ
         7d9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285032; x=1715889832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Da34EKHnCK9seOvE3VE8u71Ty/vHaksZJ1GNDYeo1pk=;
        b=Nx/CsoNdwcIEORKo6v55HrQD1e6j9gXRtkf01I4FVXS8Jvj4272rsdlV7j9LKKwtj+
         hwMNRUKWlgP6eWxZvX49kzAsDjCzZJ2jOrYbFx9v826qJMx3nUzvVWWrvQSu2B8dmUg7
         RlqX6nfpF9BnuCV7hyCKxpxTZSf0VaGTsLQvh3LaWGs6jF55i1CBk0zqNL821Kb9PypK
         5yRhZEBQN8F8vvyZ3Qx78Rygd7rfYyymPJieIO1qqBGzVpu5clIz1O3uxYXNA7ksY5Ep
         n9zVbgE0YEXJmak13yyHrImucIPGATSKRL7hj3/sKGVOrAOOrzwlDzVT4VeF1wtOSOcc
         7t7w==
X-Forwarded-Encrypted: i=1; AJvYcCVaTS6EYdVg7ldBDxK6KWjrqhUBIegPvegw+bg5Q5waeGW4SYB+Zy+iIBbr28j0RVKcRUVCiLqphEJVsSl1T2Z0AwBNRS/s4H0+SZ3/0KfN2C1N7fSE
X-Gm-Message-State: AOJu0Ywpb0rxfVpamYpMNIL55OK2ZxHFzapRDNGWfB5SAD4j5ZHX+ugp
	jGm5ZGIDkBggzQKrwYE/kta1jqG5UHVkh5Nk/Ugxn0gCI91zxY+Pw8E/yXrOcCmRbgeV4wQkGrq
	cVA==
X-Google-Smtp-Source: AGHT+IEcrTSWOKSKP/8y5gSbqy8Cg7jq9XxevNNU1pb6k757xhbvcE9eORBsQpvoCyyV8uYdVeGH/q8F0hU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1081:b0:de5:53a9:384a with SMTP id
 3f1490d57ef6-dee4f53a18emr149007276.13.1715285032313; Thu, 09 May 2024
 13:03:52 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:56 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-65-edliaw@google.com>
Subject: [PATCH v3 64/68] selftests/uevent: Drop define _GNU_SOURCE
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
2.45.0.118.g7fe29c98d7-goog

