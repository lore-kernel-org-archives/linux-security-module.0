Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC3146A6C
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339628; cv=none; b=ovuGnJ3d4GEp8UmeFaLJYaP+nXZAhNGJGHQrSBiI09YrWsRHVwz8ALcqfDlJI59epV0nbZzUCxCkiPtjUcgSbztchzAi9k8jcsqjkGmRCgQNsB+UYkiebt7qfuhT5w2gqQM5+WINhDIMw0ibW43SiUdp2iHmt8ibcmldgco7XUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339628; c=relaxed/simple;
	bh=9Nq6i/uWQL9xoyolHVYicrLpfbCuPU1Pwql11yMTJfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ai9UB8O5i/eyDjn7A7KpOKWHycLNw+PeogeA0RVbAI+I+zZjTnbxDQdzC7XgvoTG+U9eC0J+mjDFurduvqacLLPQct1Plj8l2ZuY+MkXB5BoEfBTazezgXC+GkhmGMHEdSf//f15mD4iQBvOWcB+lJQe6pq9ro2c9zGhBPuEGzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ai0w0YU0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ai0w0YU0"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso299220a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2024 18:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339626; x=1716944426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICjb8r/0X2VlW3crKp/bODhAG5H3VpO5yUTD4XwYdkM=;
        b=Ai0w0YU0mnyUczrAb7KcbsSWujAgaVUwupENoXVEaDg9PVPJRiqAVmc6woJe9/MMdh
         Ij52O3f7PbJiEcOzHWRZXM9G023l7dJZkK1RgwIhZgTEH4Ysn81IFfNMDeaOE7B+32f9
         FrPBlyNqHl+wVd/bikxxUIfisuYYzzY47kE1wpgjFA6Zm9q8SdXpATUrZjuFDgu0hDoW
         nfjn3ObYePCkbj64MRDyEDq29hXjHT9AJcdpaUFN5+jOHmKRnaecuYeT3FoY1kQry1iX
         jZWlxlac1ClsQYIN/75IRQS6V7ONRszxjKZVDS7Ns8ksfTuHd4/JHmv6BEHRmBmLI7ea
         K02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339626; x=1716944426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICjb8r/0X2VlW3crKp/bODhAG5H3VpO5yUTD4XwYdkM=;
        b=NRkWHMb6LRhosDrnOQ+Mz5tbeMoBUnMWpZrYfF+MqI2KE2mShuqp8JMvC+C+ZBK1SI
         bfPGSjzWOk0di7GZP3M6Dj/0MALkebRY0kfXHkWJQIVhy0Clp0OCE1Tx1rlTPnwa/ygy
         OjhJW8zpohLE/5VWqwBDWYFXmrV13asu/7p9Yd0Rz/gRz6C1HijedExGSUh5lYcoX4Q2
         G6+ne2tN99waktzInkqW88pmsOh6Ro8CyKtrsInzqwO1RkZ9RbwDGXuuZoUFcJIMx83k
         N4xGWFCCnBJ8NF/1lAL/hnyX+a2kraWTGcuOil3C5ozDJgAZA0KIm1u2RNxpNtPfTQc6
         +oPg==
X-Forwarded-Encrypted: i=1; AJvYcCVEKKB5zwRL+e5FWlYg3MKOI67zVzIo1ShX70rikIrWzbZ9FbZ8fMjhqGfmN5yD8qaxVh4jSoQv7KBacomKT8VOe/oxkdZ46vgbMybODcN3BfhrIa0v
X-Gm-Message-State: AOJu0YzjswuFNe9NP56eAF+/n7TKxbaayiJ03jo+Z8ZbP9n9Qe9LMufh
	7DdkTFUGKnTMYiLGI/sBxYMwT794Xw1N5xHiLihB7InBLPfI59vrciwHO4BIothVrGvANzX9EJN
	HNA==
X-Google-Smtp-Source: AGHT+IFVVN1hN+8KBf9/+c7BLP6SPEGkbks7vo1HQExRs2GPHR6ceK4qQ3u4PxzKSc59nuvr03+npLjv5V0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:491:b0:5f4:246c:1406 with SMTP id
 41be03b00d2f7-66457fb8639mr36373a12.3.1716339625682; Tue, 21 May 2024
 18:00:25 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:05 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-20-edliaw@google.com>
Subject: [PATCH v5 19/68] selftests/fpu: Drop define _GNU_SOURCE
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
 tools/testing/selftests/fpu/test_fpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/fpu/test_fpu.c b/tools/testing/selftests/fpu/test_fpu.c
index 200238522a9d..53a7fef839e7 100644
--- a/tools/testing/selftests/fpu/test_fpu.c
+++ b/tools/testing/selftests/fpu/test_fpu.c
@@ -4,8 +4,6 @@
  * module to perform floating point operations in the kernel. The control
  * register value should be independent between kernel and user mode.
  */
-
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
-- 
2.45.1.288.g0e0cd299f1-goog

