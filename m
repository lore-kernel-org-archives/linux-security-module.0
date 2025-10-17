Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED8354AD9
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732941; cv=none; b=Lio1FOwm+HuW3lNd23RVr0IN8tUncrQJrWc6j9H5eiKCrMdeDOgHQbi0IgHQ1KkPrzk81Z4o5932QBNEF5zsLDzojPKxHrn1guXP7BI0g3qZUSysFOLt4fCJHdcW9OnV3WJmTrI1OUTTTRgjpaW5VswdLPUgZIp5zVNwoNYwnyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732941; c=relaxed/simple;
	bh=7aTUsiwmKbCtrKN7NSA7J0u40jUw9giIeb3/tzw9PT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBEQU2W17mqALZ320v2dHtw+lki4dydO3p69mtJ36Yx/jtfKsF7Bj572BSMeq985B9CEXg8EplQ6DcLsqs7PRrYYU1n0EcpnpB21zAx1lblGtD9sn/K7AJQZCXnM/pI8ZuN7Uy33K0fxNNQp3QFFmmVvOx/ookCeHgAMKLIqojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DdrU1Ngo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DdrU1Ngo"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-87c103928ffso34162006d6.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 13:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732938; x=1761337738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IY0/eEFyWb8IrrGhciepKwySm+/JCBsBlLdpn/6WSGo=;
        b=DdrU1NgoXDrHlvHMZzXKGrpamuXPsU84JuuqG7ZJQNA/HrALC6/xXW/p58VAy8vVv7
         bzQ3h4iNnLQ2TLTuZEjk0zcS12zUPqsV9sODoHOdjAK3As6NgHoQ3oviKj3SKOyBCPSr
         AdLWRAZPi0ADO1t3N8JwxsLU5d5AU9IiX6M/+BRVU0YiGUZJzh3kirSrbu6WScysG2Uo
         lX4Gr0nKBKNhE8gLBrQvapd/ochhuvHJivt7mWEG1N1GxG1m4A/Nx6WpjseDVt/3qnMe
         YoXQFfrg7SS+TuBnqjjS1UUuUO5+i5ZlyDNfxdSYBYcj3g09xXBdBShF6P/oWugh+sJN
         t3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732938; x=1761337738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IY0/eEFyWb8IrrGhciepKwySm+/JCBsBlLdpn/6WSGo=;
        b=TiU4nYvoBuzwJRa9HvKBVj6FvzGkRf8iUt7M0SmPqSogqtkQzBQBtqcL5JS979v/WU
         FelfqKg14TC/AujHdrWdpBuMIUpkmaZQ/VGu+sJEZtHJO9Fn7fpxIPxd+uD9LzsaLZjy
         dlabHQGKL+l9tbxoZhO/iDRiAmtgSjGUmMpGw9n+HMqkn4nE4gtwwe5bT2AINEjeLlWR
         ecN0hp1e6jenw2Sv55ZiA4uyYevFXzemyQFZSPjgC1n/4MX2GYB820EtuIMawKVHHF0J
         H8+BVaLp07yeJU8AM11ejQP+PFmBp8YDz2e6EMZ7r/6t5MHmHYRrpREm24sGvCpw9Xjv
         iyrw==
X-Gm-Message-State: AOJu0YyqYs1kyFgn/5M+HSuHPa1j5gfRZ9GhohWIf4PHPZd0K9ajRPq3
	gy4xwEQAJqAWkw4jMkLzYYIvaDdZyA1HEJTG4lfSnJh1agIyYce8QUiCCZ8dRU9kMBlW5nExde0
	3Pb5n6A==
X-Gm-Gg: ASbGncsI0oNKku7stUp1zwk5nsByw5O5OXuwePvIYJ3wrd+CjZVx1Kgh4Y85zhZHU8N
	/fB7r+nevkxRkPWldJ2/sGXXDw2Eck4LYG38uD+Xhsu4TI1yggY3Mm395OiqRPzdJXgvnwYJY39
	uJiiPuG6e+o/i1fnjJ1iGb0PJdPieRBHDYDHFpGymAAA7cOA55HVWIgknv54REFfp/ePMb8osLO
	vPh/LOan+LvM6Cya9lrnzmmQnbUO25ntNRtiW6MXdGMbAnXloyZgxb1gqZyJsGkBZpbKcOCmbGi
	0XdlP+rXhOfPCB9vNt734+rmkfhLiwXbr2LTw7rJhX6Q9dPpZwwO7+xSXlc0IDaSdAnkXxhYKGO
	W71MsBtN1dsfmVil0uqczZDKPlaIsY203matzaWkLYzoXO19cI7IrRYzUG4wpPWhsdZTEiQFN3O
	lIdmzP42HH1BKqq5GkTnkJ0VcHGK3XVFoCR8NKi0SzDHlctg==
X-Google-Smtp-Source: AGHT+IHpX8OibrpzYGCeP7eEksQpkDmvuQrBS0W9CNYbUeqDSF5apaXgTyG/9kswr9nLLCP39ZACyQ==
X-Received: by 2002:a05:6214:1c81:b0:87c:f97:7acf with SMTP id 6a1803df08f44-87c20653c2emr68359206d6.62.1760732937757;
        Fri, 17 Oct 2025 13:28:57 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028b2ebfsm4746136d6.52.2025.10.17.13.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:28:56 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v5 07/34] lsm: rename ordered_lsm_init() to lsm_init_ordered()
Date: Fri, 17 Oct 2025 16:24:35 -0400
Message-ID: <20251017202456.484010-43-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; i=paul@paul-moore.com; h=from:subject; bh=7aTUsiwmKbCtrKN7NSA7J0u40jUw9giIeb3/tzw9PT8=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qYsjQhmdV2HIqAthiIAMEJRnPP8jaTgLxGF9 gJpJjsQuZWJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmLAAKCRDqIPLalzeJ c6AiEACMWFNEhx0T00DePaPtIEUwgBp9dYCSDcvq5zTTK28uyq5ClsSHb1Esx2ZYvl0thzml+uI xbAkHYGv2dm8d2QoJXwwHGs520cjczcWg8zssgwJbqFsN5kYonKm8OxFLR0eh49NSAfHmqfexD/ fikbV2a3oi+ru4ybkg1cFTDx4RDZ+A4CqDBij91Tvg6PNNCKij9FnbruNIbtKC3zO8H6vEdFhGM ogCmWORl6hTHMqeh+p6WskA0Vto+kVlBGRHuNSgxct0Djb3m2wWrHlbGQATKkfloLJ2/KIO7OCk cQ+PZ9oOzW6QtKFDWyz6fpQoyVrnTAo1CKJGgAP5KjKCZsSmGwMIsNWrfBUvoFpiikzXp2SEX2h RO7sAif+pZ8CoBcGEmVd+G9tgLu1+PwYJIcNQzMmET7M6xqIqHfT09mzXcsx0IzbrFIVo2GnyYr ueErq6vu0FxLGmf/xWQQAaKdZdMbdbApMnVFyHG1YpYJ/jvpC4WGVV/Vw6mPlQjWX2ysVG0Vxei OqOFvri7Quz+na0yA6bZPjuHDsGpz8A7u6NlZ82JmkGmS8vQ5bNG3dcNvkFBxv8BNtYchoV1GS+ Nbmc5Eqp8ndOLuu9YYuxC6Pneyn3KbEzwBXkxHTg0FgNwBDuv/5IVO/F/pcX9wmPNkRpJLysGWb BVuwJ/5ly57l4pA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The new name more closely fits the rest of the naming scheme in
security/lsm_init.c.  This patch also adds a trivial comment block to
the top of the function.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 8bb473aca113..9249d5f37ae9 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -291,7 +291,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
-static void __init ordered_lsm_init(void)
+/**
+ * lsm_init_ordered - Initialize the ordered LSMs
+ */
+static void __init lsm_init_ordered(void)
 {
 	unsigned int first = 0;
 	struct lsm_info **lsm;
@@ -342,9 +345,6 @@ static void __init ordered_lsm_init(void)
 	init_debug("bpf prog blob size   = %d\n", blob_sizes.lbs_bpf_prog);
 	init_debug("bpf token blob size  = %d\n", blob_sizes.lbs_bpf_token);
 
-	/*
-	 * Create any kmem_caches needed for blobs
-	 */
 	if (blob_sizes.lbs_file)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
 						   blob_sizes.lbs_file, 0,
@@ -498,7 +498,7 @@ int __init security_init(void)
 	}
 
 	/* Load LSMs in specified order. */
-	ordered_lsm_init();
+	lsm_init_ordered();
 
 	return 0;
 }
-- 
2.51.1.dirty

