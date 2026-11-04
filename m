Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826542;
	b=0d5+e4lcuja+YhNGtcDdta/3xl+BrV526aA3ILBoD1J8FVjPm7AW9XVRW3mjZWSKbSEH
	 CRMGo44pEKdhW3cRLFiLCjh2T2T3cmF2/V32BbYgSF0wwtcyCP6h+IYseYIotn/0wf9dw
	 QwLhE4g7iH7aqqFz1Np4YBWW2SZlisG5aDTYNo5hrQoTkZOd3BgVRGABxQKrVVrJiOrtN
	 dBGIQpswQBNuml5tcfrMNGEObCDael0T8gl+Kd8MXQ9DHxORakhXRT7XMiOz0XwKMNveS
	 Zg/89gS+lTJKPrwYqlfMiRrzuA71o7V9Px40PAHrRUfRT1+FqZfa9KDTg5H3zgV4PzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=sYT6lspbzQpjqJHvYeUI29IkxxCfKlR9BhpAlEZsBIg=;
	b=OrrTW1DuW2YkbccytQP/rVHAIMvAmhl7aoDQ9UOwYLEuUJfMt9VjNRm4PawkocKQmmsv
	 4V+BlptP4GyiF0+SH2lKydROYsgw43VfJGiQ/Lx281w8fWQqSgDFNlxu4nJndN6k46g2P
	 RErAoQGYtuLhXf7+wcvnX5m8UDbpDvQJFCP/u4rwSKzfWz6wbCsqGTgvRn7XaKBlmtjHt
	 NNxsGqtEV7yJ/O+xBM7xLo6E+aEYR0TaXxT8hp8xGVVpq9XbIs1q6xieYQv+uWd2h+ht3
	 3wOepWc6PsYsD0eYg/ZKqiQKF2yCXNoiyG64EclDvzviWg7jyhn2u4tWKF4IhUTzw7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BPN1gvko;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D559E607E723
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D559E607E723
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BPN1gvko
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so12765435e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826540; x=1794431340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sYT6lspbzQpjqJHvYeUI29IkxxCfKlR9BhpAlEZsBIg=;
        b=BPN1gvko6GfLQrNWXzFw85BLDKdxLt0yjJ41u3wB5mR5jACBa+/7D6SRxEModQ2grs
         BcWDDFnHzx469RGOfSk1f5F9VieTbJCA2rMTDw5TDsuirul0VEfo4xI2KViHy9lsDr55
         UM/mt65se7j5ld6tdYW6B7hmBQOpZAbKm67fXmgtIqIJ70jMVvMR6mMpfCUTr1PLXvaG
         QJkWN0+rLUVbWOC19DWk61+MadS/Vxx3ImXwljaFLnQ8Xk9Vcxx8oYa09WyR8kTELJbP
         60xjM88t+E7r2Ceuu4ODsC9pntz3mfF1ndTqrkDM487cve1arzYdDvbG5x5ulvWVGCEL
         eikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826540; x=1794431340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sYT6lspbzQpjqJHvYeUI29IkxxCfKlR9BhpAlEZsBIg=;
        b=QV6ppghH0upwYiELGYc8FTpRsJGYFjD/yYTiqsxBpR+cT63YqOwW+ML7Por0v4NBCU
         hUNf0hv8pp67V6SjZwEYbyRaBcDkuMze8sRvx4ZDAI4NuvHheIaXNGCubHIgMdUm5Szv
         zjSDb0RoB+ae3dtsv1JkeC+jhkNmtm5u1SDdIdXFFK7+Zejap0qQKTSarRzTuXNfl6AS
         gBqvvbdxhOLkAuh9RRAIxWSXor5sg80nQ/cIo9ywscCdbYJEtzJXNF6KBWFTFBtcGxlu
         umApTpG6U0oS5zsYzI2zw3wt0h/j8No4xJUT8CbG7/tj/Jp9uxdiKVN2mBVTWzBF5S94
         VJtA==
X-Gm-Message-State: APuU4Z/2Y2hZRUom7I04XLZ3FuYZgf/x3ams3s0cUQxUJxx138bJp9rB
	6z+ybSzh3JQtKPlzpbmAiNJkVY1fg/nDnwIFXOjOwYYQEvjxEoZhAr/M
X-Gm-Gg: AYBFou2+iPpAh/ig3qpWxuK9UEwIV7SaNlSihktJCv3LKlkr/jLU4jAnMTCVvLM4pQq
	qXRy7glwh1ZRIWuuAYGhxRUNzrrutY7OceOqKg9tK21AIjRXQo7lD5MOPfRI+30WihvPvgrQe/W
	Tx/VlztoyhoNZFozkWGf11WCIjf4a6wiXs51ZxVcYdQ91rNsahBwSZABsEKy4QG6N1lGnrd3vMy
	ZLjdVoPelYiE4F3atcDVwdGRxa4cZDCj1gzP0rS2h3m+E88N7V1TFMQxioBt3e4b4+gkGqSWP1L
	OixdamuSnbZNteBx9vm8AaIsm7yR1IVMszaCYGOBlKsixKu2uZAcbsXgHNe0xaerlXHlzKxBNor
	K40gPfYrx1p0j1oCXq6JbNBMrDr4bUd0hXnfLzN26YlXJyC7gXdxpSMak8xIKyhOn3BeWJ85JCT
	n/U3PpCrCo3/NemZhIVDePsAHspIUKWFTDOXgc7wmXaTDAKZJW6RJp44pKn3nsxuUXHsRyGeKlE
	Za9sDkD0RJ+VL3v3N6xqt86IQczfRfWatwO5xdvGYlxtF0LAU2pW9vsty4ZIkQZFMLehFAmWMfs
	4AkgVzaQN+s+lqPGB9ugoIiZhQ/ewFC+6m99ZVFMaJIzx32jDBZA+g==
X-Received: by 2002:a05:600c:4f8b:b0:4a3:5d64:df91 with SMTP id 5b1f17b1804b1-4ac17ffaf95mr390439375e9.18.1793826540343;
        Wed, 04 Nov 2026 13:09:00 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4104d600fsm78187495e9.0.2026.11.04.13.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:00 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:08:50 +0100
Subject: [PATCH v2 04/27] selftests/landlock: Zero-initialize the buffer in
 inconsistent_attr
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261104-selftests-refactor-v2-4-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

This buffer is passed to landlock_create_ruleset() a bit further down,
expecting an ENOMSG error.  This is only guaranteed when the buffer is
zero-initialized.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/base_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 89c0d96607de..0bf8632b725f 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -25,7 +25,7 @@
 TEST(inconsistent_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	char *const buf = malloc(page_size + 1);
+	char *const buf = calloc(1, page_size + 1);
 	struct landlock_ruleset_attr *const ruleset_attr = (void *)buf;
 
 	ASSERT_NE(NULL, buf);

-- 
2.56.0

