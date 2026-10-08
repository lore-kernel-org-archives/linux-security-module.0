Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655F393DDD
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469624; cv=none; b=KJB96q/twZMBGbuK1BJtw/lUeYLW1Znin69ElPc2fd60GTDTQco+6jryQrtsolbDzO0uBMUSzUo9B7KY4xiZ+AJCRvQgHysx9anwtgDk667r9o353vIUZZXoTDTwWVXOgBcFaH9qD4X3mK9K4CHrzsZC3evQzJPjWMbfJQAi7QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469624; c=relaxed/simple;
	bh=80WLb0++Uodb+4HiLcuHEuMzL3GSkL5XLfok3SaeWwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLv6q4KVnOp+YOCJhTj0PHzhejjR4OJI8j8rGw53NgtZTUjtueNgESBqjoDZ/Y4wMXgYh7g/praUbaLIyGkTLamS8yIq40SHw+N9+C3VgsO1d9DMNzL6/QhCJvBxSo3wLC7sd+Ek/vOr3xIi3nYfeLMHikwP16obshKpwzP3os0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObPQuQKy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObPQuQKy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c5358fc28so3363746f8f.0
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469621; x=1792074421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k4xn0TmzK0MZPrjSNCHFh+ucQ9eOJKWbaR6JNjvd9qA=;
        b=ObPQuQKyHd4VirgpIztB2jiZE5Vg58xIYx8MrUDcvQtU5w4HmeZFG/V6wG6jRpCJyF
         Qt1lC0++QDJc6BJu1tPJWLv6kc1/43ZGND/zy1lzLXbi+uZDG893m7bG8ikCpixZgzCx
         2X9kkHMX4sE3GBuiiNFHHpeM4b3wr9fKn9YtLKFLJO3VuQNnfgX2gG0TD0P2YF6ybDcX
         +mcxMQiiDzNDSUSOg7J/A+d9nleBqHg2l8y9oVFBKpz8ZfSDSQbqmV0pvzfe6lXI7XJi
         sQJjv9arKKGSL3yBjz08lVp6FjTrih1UbpjPzsaexrAJtikd55TZcXTSR8iTj02+lEbq
         FglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469621; x=1792074421;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4xn0TmzK0MZPrjSNCHFh+ucQ9eOJKWbaR6JNjvd9qA=;
        b=VrTBKsxM6u8o6FDoWbpm2p0FQY2fW6DX4p6BlQ1YoipJGIJoUxYudlJxFKRTGLG6Qh
         nztdTYG6nIE7WRwja+h0OyaDA0yqW93c9el8OiOClMHLNvmFAw1mI/0nhYj+SekUGK4W
         paqYX2mXhlGBXAaaSUiXVRQCPNoHOctAjwJZ/tBLe/tsCPz5/QBfJFKkbJnBQr1CzUrn
         5LNkKRzsT0ttFlaugHAjRLTlGdbHdLnyHtY6F3DB+GBEPbk903LXj9OfSS+Om2KMNRKv
         g9CRg8HTqa9LG0E5U6cqdrTlsFPikqUDQ6jF176eJlG9I71LMPmKcbIFzQwVsaQTndV4
         Dokw==
X-Forwarded-Encrypted: i=1; AKwUvByYXhC4Lf7yfYdEC0/0YpVMnQ+fpIJpw52vjEOTh8vIj1rZtMSyWVuUZSENM/3x6bg2aNN7CrA50NKVtD6EAVeOOxsadY4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2dm+C64MYVTYJMCvF5KE7HXRUM3TeaHECnarLT/f4Lwk4i6OL
	Mg2FM6zQpRA04OCc5QIyFLdhLBzzXZSqLz0PgC4v8dS6CfXXwZqwMKRI
X-Gm-Gg: AYBFou3toGqWmGsDPIIkxCMTwY4mJSgvriC2fKwsP+wglSUNi1majlTq7hEzT8H6Ax9
	cBUw33Vqm1KkwxgrOMwu7aWYStha5FBWWW+6JEmbNRHs9sWa/2ArOX1r+uecDsHsrv82ns67n1G
	wnsFAgi0AhpK0oEW9I/pYZfiutMbtxfvWScNBmsTgCxCA/vidneZ77POXbgDNswttWORGnS4JgJ
	8jv6HVxgoyhitVHlIgCIcaR2T34s/CleUfQI6uDur8m2m9rlR58YyiGjfOgSbBk2k6jb5J0Nco0
	FaoV4IOl+bP5it8ZIFoxFU/z6rq1sYhe9LbHPwK57NPeGum0wDxsZwsewD862AA/xhZpNRXdvyp
	BmsKtNu6e1OMU81Ro+0q92WC2hO5WMgq1v3bY8eBff0QBaxGRU0Q9J0DdSQgjv1OSSS4KkVXRb+
	lzXM/IH+PypmZOAUfCv2qqW9ctaY32U5+GKBIHJhAmZMQSimnbsxDhyURSp3FeOwtJJTdv//EG+
	moAFt7xqo1WdZtMrjT31oQ=
X-Received: by 2002:a05:6000:4a09:b0:488:8a5d:ffbe with SMTP id ffacd0b85a97d-48c7278924amr11804538f8f.33.1791469620339;
        Thu, 08 Oct 2026 07:27:00 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c75b53fb7sm8530232f8f.58.2026.10.08.07.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:00 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/27] selftests/landlock: Fix the ruleset_fd check in empty_or_same_ruleset
Date: Thu,  8 Oct 2026 16:25:36 +0200
Message-ID: <20261008142604.39107-9-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008142604.39107-2-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ASSERT_LE(-1, ruleset_fd) is always true, so the test does not check
that creating a ruleset with an empty handled_access_fs fails.  Check
for -1 instead.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 6e979cef884d..9884ce9917db 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1463,7 +1463,7 @@ TEST_F_FORK(layout1, empty_or_same_ruleset)
 	/* Tests empty handled_access_fs. */
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
-	ASSERT_LE(-1, ruleset_fd);
+	ASSERT_EQ(-1, ruleset_fd);
 	ASSERT_EQ(ENOMSG, errno);
 
 	/* Enforces policy which denies read access to all files. */
-- 
2.56.0

