Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36C13CAA9
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284950; cv=none; b=OKdCT1AOBMSjJA1Tzp2fHCaAMffbffbHMewuJOEnKD12lgu4ivtfjWCTijtF2EU1sYFgONd38dK5X55DGmkdb35qwDHoqsQkpx1IFZFL+AZGZX8gSCfm03rEuJ8kENQ1sxlJp2AjDcCUwV60ryx6faLscDmW0b8ucOXsU15sONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284950; c=relaxed/simple;
	bh=WxA21+L2Zuykor9dBqpJGTKesy/LFIZkyBfJiqKwSMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WCHIGjybhuXwuWRuAmZZjwlpDfWW26IVZ7fJMVrq6FwynaGHyGsQHwL+Guetjvsrod4XoRrbRZf018DXRilNFXHFv3zGhGgwXWjC5kvakopgtJJHFLwbz6NGvSUbWehu6kfKMy9hnvnC4cg9vDXypMWlIYlIveFSDb7Ld9qYLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvilGzYl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvilGzYl"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f4755be972so881614b3a.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284947; x=1715889747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mGN3dzX1Fg/8DMWBisk+V0BflWzMHd7DBmLWWSrLzcU=;
        b=DvilGzYlCUiqWoI2SHcvhol5+mm5PgXUf1s2z+AfW15AIMFMPMxMi7FlS+JKUMVDla
         Cq6s03jYu15ot/MM0c8I6W9gaGC5FBzivKX49TJeZ4oxzmlevPtNAp/lzKhathGxcoTo
         jcpWxe0BKLn1hMaASvISxD8+Co5cBLq29a3jtrQEDdxber9nQvu4o3vg9qTDkAFKdLqX
         gRGVY2Z46bga8aMS7c+/LDfBWok2LpYga2h97f8Tkf40usWSvrE067IQwCrHJYeSZqGU
         I6fzoYai1JUyVXQZLRmqbFI/8aG15LSvy+RbTrQ1SwLiYhZy0Wbrsdht1lbRYerr6f0S
         3SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284947; x=1715889747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGN3dzX1Fg/8DMWBisk+V0BflWzMHd7DBmLWWSrLzcU=;
        b=uMYycUgTzcSqMLitx4reeQdWOmzrmKUw1GaZfVQ+SVvetTWNVohwjE/hX1CH+U/lvv
         gUEzySUJ/4h2daeG6o75yBamDUOmmGbvRSiW76dTbM9gIcE9VyDkav/q6rlm0vY8q4ip
         NakpQhHIgg7qyNvhz3vsB5lN3veBgyYgxDqMyfMOFVHRm7dIef5XVo6uuere3I6dr+AL
         h6VjvNHguRHbzLQU5tZW2ph8x+FUXIX6sppq17s6W3aLcyn8GLmZFldmd2yh8SuO1Zht
         r2Kes1R25RS1oaXD8bcDwsPz1A/ogWN80pCKAKPDAClrnZbli4hu7H1NAf9o5fXD5W/I
         6I8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYPo24A8+9MrcUbCm8ToHgz6trfapSNGZaygpmr4rPc3k1+PA7dwsW+gYDdo+Odzrcn2tdrgqVcV/GBJ1yUSaCS3RIsxUGNIH7hln8Z1uMr4lJcXwj
X-Gm-Message-State: AOJu0Yy7YF+EBWyqhj+s04D0anX8o9pwAVTStj7ltKt1vsY9ci0jFvKA
	qIiQez/MfAMArH47xZINv0C+GKlNH/u1KrBHNy2K0UZR05yvCnNDAwKFWhpivb0H8jLDNzNR7cV
	uCg==
X-Google-Smtp-Source: AGHT+IE13kb/DRTCsG66In5JbdvATNZ7UNmIfPfoP+M9Al27cmAukFzPSkQdhJiJAXpJTvsnAezDpKm1rN0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2da6:b0:6f4:47dd:5f41 with SMTP id
 d2e1a72fcca58-6f4e040fefamr9101b3a.6.1715284946869; Thu, 09 May 2024 13:02:26
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:27 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-36-edliaw@google.com>
Subject: [PATCH v3 35/68] selftests/move_mount_set_group: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
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

