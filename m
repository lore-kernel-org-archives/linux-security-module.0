Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEAB142907
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284998; cv=none; b=qlCXQuwC0IFGSUxdNnv+PjdqgZL2emuXb3bNGo+wzoQ/yKGBuhoig1j9zTXKQmBwZOn4Z1kZuVRZ2Le+lyJQf8D7gAJUHWezhAa0l1xFDGiWtfuE42cFE6eJkQqtkWBtP9oV9ebTLv5PmNVRicp/ZlqrTA9vSG6uErejatWJV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284998; c=relaxed/simple;
	bh=5eCs2dGnvyXJyHpHcW99rKbYfAt3cSCAPK72Lv3waNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ErHUPR3Xi/WQ2eArp8BNz0UgZvlbxkCaRFBdsEIHQR1/f6NSwmBoDJ1YHzmrnnFdmG/jNYdNYDGKTgbbcXqNpkaAmpSi3qaIP5QADZmaWYnQCz1Pcu+EE5hYoaYxrmYeXIPOFITXZusO/7lzs6urOXVGbExoXQnwnDZhpHGXqH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmwdionV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmwdionV"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f441afba80so1381876b3a.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284996; x=1715889796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oiy7DTv1aGKmws/cPGkTZCbrHaB1ocI0/bjdksGN1y4=;
        b=RmwdionVv+lFDdu+RyCiQO9pHTCDcpsKoCMy/Hm4k/KSBu265s17AubvIt1b4FHP+E
         hBrHCt4GUddE1rzxZMhYrBI63XQW7/NFsoSnuCxOncp44vi8Q56oIGH6IYkNYJjyr65P
         JIKXXiGR2ARHR3NmCoW3KWOzWwlMNMbNeezpnRUruSAm1s7GMCuLb7vclVgZYDwZO3hr
         EAQZDdTbwVSdgd6t1WBFU8yz5yJlvA8925kaGbnDyZ5X0CiEja230arE8/dFqBKZw4Nq
         vnPEzjPCnL4qsW2BfsGnAJXqp1gFYEGQJnA6cDgX1Qu8T4YvvSAdD3Cngedwll6ekYnK
         rWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284996; x=1715889796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiy7DTv1aGKmws/cPGkTZCbrHaB1ocI0/bjdksGN1y4=;
        b=h4gJdmEPSbrfzUcFrFa6ywHrp/42gkkfCEmBAlIjZNe9Gu0fqITX0v2qZ3D9f0BRRN
         jG55V2F5qQts9Y4ANVTYFrllbndx+GrJx4T3u1AA46MJSjdTw8K1CTsHbWYQhv+EI/t5
         NO8f/cR99QbkOCY74xEiFidnXmYERwQwBDaU819o2jx+OgP0hFrNXC7jl1suoY7BqU8+
         xTh+28vRl1O3kC6nlawSxCihn99VtEskXmfieA6wuW7JjBuAOOpbtDnOR5J6phlpDTSS
         ghT+CThwohc3eKMcJVtI3VO12sWXDqdnUPTA0zVmDJzJlGF2rGq19da/YPbB93QqojDT
         GVnw==
X-Forwarded-Encrypted: i=1; AJvYcCW2gKu1wmZhCsATK29Q0QqZoOqmd35dNMgGMkbmz+kVtFuM7OoXvIAkoZupIzileHx1Soh5z5XjazMHYUU1HW2RNJ9uMi1MN2fPQg2cOjCujcFGHdhZ
X-Gm-Message-State: AOJu0YyyszQsp7+hiyJ62HvG5FR462P5rcXl/jV1gGgcsxED/xDUkFAN
	qR92VVkU3fGFy6lDnUkzg3UDsF2oZPdSjTzDF0iN4iFz0o4jK+3dyINzjGEggrYVm29xrHJn0e3
	8QA==
X-Google-Smtp-Source: AGHT+IEJ/rJS6p21P2/qhLYsQGGVjwiajthmzURaTvAjOCnE9jf3eBCmxwF6D/Wet0iEWq9F++qDVmCDiHs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3d54:b0:6ec:f406:ab4b with SMTP id
 d2e1a72fcca58-6f4e03a195cmr28293b3a.4.1715284996043; Thu, 09 May 2024
 13:03:16 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:42 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-51-edliaw@google.com>
Subject: [PATCH v3 50/68] selftests/resctrl: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/resctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 021863f86053..f408bd6bfc3d 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
-- 
2.45.0.118.g7fe29c98d7-goog

