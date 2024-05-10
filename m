Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB012EBF0
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299812; cv=none; b=bIDDo/84thqGc1E2oduuPbRLCZ9TlqvdmU/ovKsm711VmGhfj/8Nv34alK9e1sRMLc8m7uxm2wfzpMHWDBcvOaT0NIqaysZbddkhycQGeXczjukrKhc3yWokmRKk1WR5+tpcgmvSyDMHFdBZWA0edovE8RUA0SeSLQATe5Fsr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299812; c=relaxed/simple;
	bh=06GXIfnrY5FenXrSGQ9POcsOnMyF8JM6D0YxLBQedpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p8LJv6tRauQigrgwyRP1l0594xZvRBA8v4i1hNcB3E+dJf3t+KGje29cllUae3JyQMjrb/U/RRTifOnYKiKqlmXiQLryS/JqPNTaZJZWnJmebcon1dALLtBldpDBFl4pTCBKoyIqe2NYge2udHTmAQdlNOUOIUnbnyZN+/kIYyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2wYQAoKk; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2wYQAoKk"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de603db5d6aso2536586276.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299810; x=1715904610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1JirhXYvbIsfalfItEFO7rXY7kH5rekU7f7+XKnP28=;
        b=2wYQAoKkO7yIefW8lFqWEkzzGOHKeZGDZygTqDO24b9RHkrxVdmY6IVqKgHyDk+I+m
         F7c3htf/27Nuul8+OajYAFjginQ+MCuyUzVnwFlPjjRV4BH7RXCUwrAWJAKDVSY++xFu
         SPKUvXz/Jni8tMC5FkNKt05D+NfDbtz0sVLqpoIPfX3u4FIY7qX+6jVwx/IGEHX+6MiP
         BOErU6Lf+NUP/ZTL8iechAbps85lxzxTsjql6zLKHiBaTDNaGe5rscBiLElrDa+wh7tl
         Dd7KhMiQSPdnuVSt29zFP/jumazoJsZExeqWoe+l0LDZ0lsXhcKCYbU4CM6SqxqpqrNc
         69Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299810; x=1715904610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1JirhXYvbIsfalfItEFO7rXY7kH5rekU7f7+XKnP28=;
        b=ij9whvA1etGMCBqkkVBn0C0cQrhtZpUl/J3DzpYDoDz21Wn+Yi2F8C7UENGYVbYhNZ
         UFYZWmVQo4cUcktDgVnoT1RMAdoVLDlBYofZ1DggVc8cHt6/H/I55eSjQMKtBhoT0DSq
         HffHbbUGoVPphOG3eufkJ7I6LxF0nXTOjdOludfHTw/kL5JS5tb2RD6vzdxZGe2hXXOR
         +tJTVu2ZTkt2niHI9/kPDfjzDrp89j2cuyfGBEl0ic1dqiiHt6vgrmwJgYoww842sPg6
         Eu2kkbsHjJnvM9ZOyTyk9c+RB4h8WVCjCbrDlRFe0WsG1d+1xXXtZyYTdL1yPV6YD1U1
         y58Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXzOy2M8REJoSoFbz6wQwZhzkEZOH+RtU90EEi6v/sjPcpohDj/cYry1yXlXrP2YuYBVcegUs8hXKjJ8x2yE2eb3YW4tIMNhjdx/sPWEzJgnZQrIaU
X-Gm-Message-State: AOJu0Yw/dJeYW4ClbzXbLbLzAkGfRtxW6Ut+Hr61B9Re02yTnx3gLi5I
	21xgHs1ml3dde5UvHKNhyqyyJ9hduDK64lc9yddj0qRo0QodZbXQHUa2RVQydwipOgnsE6baSxK
	nfg==
X-Google-Smtp-Source: AGHT+IG/RWyFjoRdfpBoeWuBwpsoREtw3fEGHoJsuZVogrcMqGX9XXGJ9mAouAKS6OupGTFj8vQ5m6c7k3E=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:c01:b0:de5:2694:45ba with SMTP id
 3f1490d57ef6-dee4f104643mr309828276.0.1715299810434; Thu, 09 May 2024
 17:10:10 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:41 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-25-edliaw@google.com>
Subject: [PATCH v4 24/66] selftests/kcmp: Drop define _GNU_SOURCE
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
 tools/testing/selftests/kcmp/kcmp_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index d7a8e321bb16..f0e356139e1f 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
-- 
2.45.0.118.g7fe29c98d7-goog

