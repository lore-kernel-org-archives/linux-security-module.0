Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A327538F950
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469615; cv=none; b=QzHxfkVhPDYP2cibxf1Krd4+Hu8Kx5pPNbsOh/17xNrVCFJYfuXWTHLGD2BPs5ZN6KwCQlMPwGKsDpNiLDbOM/q3V8uinSQhSL2KiNCBgd1CP/niDKkJNWBlp6bLszL4CrRszqujIT/aMyKZDDQ6DgRBkPKtoBooh+0GD+Lbaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469615; c=relaxed/simple;
	bh=HS5yOBYiZ058h/wpb1UYDX2Ue4vkhWub7/TgfhV8N3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZta0GT2Dl0g3/zPQ7FuCgQ+OVbmuXhNlM5y8n7E1irLn2auqxjkG2UVjduJb16EtwJ3z75rE9DzBi6dSRa3N/6SrFNoMfBs1z9NZG9fLKyZxaJY1kNM+jGhqpmDWRGN4UVllcLg1Cxe6WZSdCIkICHJ4YmWNFL2cXtbOWt9um4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTrlFhS3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTrlFhS3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so26531555e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469612; x=1792074412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lVw1QUZuaH3ZcSzm0mPG+DaMPROlxEncr+19WY0rOvQ=;
        b=FTrlFhS3wMbJE9cajAbnJjAzZ1Mzz3wqJIkywkLpFcknf77PnbVbwoGFgD99x/gYgO
         EvKCp0qOKhFY3tm8te8GYgnh/vwsY3HGqwsT6cYQHSUGKI5rjSg33PWXs/UTSxNzcjXW
         6uNSpqNMlQ0SV5gOg4QTa1tg8U+MCi0sKvkhBULDugW++3ISRxFrJ6fdOukiQ5SNVD/C
         we/IOdGiRGmeVEfA91plRr6QSl4XE+M58PcYhIaYiEF4M68D2HgqOhUXEBY3u7XOGA4/
         k81C4iQcP/H58Kzi3Q25VULnMakQvpj7NT0EFcSUVXH1LdgNqD6Oskt7LGZm09MZenXs
         vpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469612; x=1792074412;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lVw1QUZuaH3ZcSzm0mPG+DaMPROlxEncr+19WY0rOvQ=;
        b=1xkI94jGGAP9K3jR8N9D49vuQy8gsEN3/6mSlLd2gz5B6moo+WlQIRmGkIyNmbTg9A
         hxSb+Tw6JCTT08w3S9wZAB7TTRf+4vCNQ376paKdfZXLh7n2BA9Qa/r/6N2I3UW497f+
         34bt1o7mNMj2fmTPcerdPxptmRILoGSPaNPoZr4rqzNLdocnp1YfrJ4XJ0XhnGEPPedw
         LQsR28MlL22ykgaAPFee8JAiHkIUgmGH6qn4ZEHrunaJHNoQzcCpQ7iZEYDyLUL4ZCwC
         fia21e3ju4vsZiKLTbKEbW3cHsfDsz4IDAy8IxsE0n75F48lRMcRRmp3VftlUlSFgdhF
         f/Ew==
X-Forwarded-Encrypted: i=1; AKwUvBy/SFB6yxtzO70mApZAxzuqeSaO/EUXnDHr8C28KlqOMXpmOfTa9m+BZeb74ITnZWEcxQyEBsQN9RSRzkPFMBd7uemP7pM=@vger.kernel.org
X-Gm-Message-State: AFuF++kFsL2QPxgP1C/jxqYKbQFKvxdt1f9A9h6j05O7J8UeGOPitwoS
	SxoitpTR5FX+qCXpRzdAgly2PONp3Ss/t3PTfPuRN0WfEvuW07RKwz9i
X-Gm-Gg: AYBFou2di7VtVNrq12p+v0WNlCu2X+SiA3+jW1eImTn7P9w6/8aYsFYslDBhh5HstYE
	/Lo7EeOw+jSVExj+QagqDIHiHOEtKCfTLz7e/rVmoj7qxI8vhIB4AZj26xUHuN1iW5lg2DEtuye
	LLU83ZftrmYk7aGLR8bHNMaDVf4elB6Ab4wH71hZ0Ax0AbjnlCoacJqsqJLqlwe9BrLwtMY9qgv
	0I9SmQZHTaq4LuXEvN14KPK+TDvQEnNQbKoAp+OVbcbMDUi2pUwimIiQ7UaBaNdVvK9X7YfKImQ
	x4SaTNj1WYL4da5nXlf9PKwGh/Hq7u0xusfBt51uY2nNZu/a9MVx/SuSgCg404cTRuBoch/x4pQ
	gDSpUQdOWpisQq/KAVZVB6OSVXZRhF1f2ofwEux2VpKebdgtOXehxpeBNwOShZbkYxRnJYtfxJs
	KQVTLtvscc7oiZr5x187B3FeQHLtaTeKkOCQ8YPfnyhuHF/eOl97K4MddtEsLfEXxZwhzfYe8Ez
	gjInDWxTVLCwIUQhunSHYs=
X-Received: by 2002:a05:600c:8b62:b0:4a0:c01:1902 with SMTP id 5b1f17b1804b1-4a1800d68d7mr106252515e9.2.1791469611527;
        Thu, 08 Oct 2026 07:26:51 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1842a16b2sm82107875e9.3.2026.10.08.07.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:26:51 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/27] selftests/landlock: Check the thread result in audit.thread
Date: Thu,  8 Oct 2026 16:25:32 +0200
Message-ID: <20261008142604.39107-5-gnoack3000@gmail.com>
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

thread_audit_test() reports failures through its return value, but
audit.thread joins the thread with a NULL result pointer, so these
failures go unnoticed.

Check the returned value, as the other thread-based audit tests do.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 502a0825d877..81cb31aa32ad 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -227,6 +227,7 @@ TEST_F(audit, thread)
 	__u64 allocated_dom = 2;
 	__u64 deallocated_dom = 3;
 	pthread_t thread;
+	void *thread_ret;
 	int pipe_child[2], pipe_parent[2];
 	char buffer;
 	struct thread_data child_data;
@@ -270,7 +271,8 @@ TEST_F(audit, thread)
 	/* Signals the thread to exit, which will generate a domain deallocation. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
 	EXPECT_EQ(0, close(pipe_parent[1]));
-	ASSERT_EQ(0, pthread_join(thread, NULL));
+	ASSERT_EQ(0, pthread_join(thread, &thread_ret));
+	EXPECT_EQ(NULL, thread_ret);
 
 	EXPECT_EQ(0, matches_log_domain_deallocated(
 			     self->audit_fd, 1, denial_dom, &deallocated_dom));
-- 
2.56.0

