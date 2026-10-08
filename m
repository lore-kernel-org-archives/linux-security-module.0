Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA2390985
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469630; cv=none; b=FBo6+gXGZpbVRHUyY2jgHLyL6TtuU/UHYaGH6vvoTXIFY0LO2yRv4DNUUyatngpLLSH5TQylzJZfxKRFsJRjXPHXpqjz6GJD9Zxa137WGXNghCQXdTKyaIjE38ALx+9ge2P0dVG5lp+JuU1sWiqbT4BLDz7qXXPwaXuSmoModVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469630; c=relaxed/simple;
	bh=XeLGjfK+21U6lHWRK6NjJAkvdj0dja8T2p6k2BrqbxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cw++oh0mHhY0LpyoT+JbnWysjPglGdas8fH7GZzJoC8FX7WKRmBps+HnCMCJJf8abobkdGjt6iD7dX7vebE/9duqkoVEy6/6JEzS8ZgyqnO5QvRKAqds47P4cG10cCJoPfJeccBflaoMDaQsHK2mKKItIvyOfq+yHQcV3BNwA2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhXhZsdI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhXhZsdI"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4be28b82so2782647f8f.2
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469627; x=1792074427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fpxqDP5CsmzUMOKjttGXHMSiBcLd+CV1qvWa4yOxMC0=;
        b=XhXhZsdIDTcQXESmeb68lL868Hlbzmn5TePG6i2+qw0RDjBVf/8UXho7Wky3mTkTV4
         NxY/OdUVlyzx++KomWEiG6GKpuDTmLlEzomom0sHCTvxFaHqjtcbpaRtpWcIzmW5WEUi
         P+wc2iSGaZIowkfLEcuUzKrfySOv4Q0cG6MCNq+MlMZe1A3tRprl7inKp7OYb6aaCVvH
         8cW1Q8mHuPH2KTDGJxrxmb4XUCAMYGPbWlvnJbHxpvvxEE2o3KqX8eVVWYcPi+ES54FM
         wrdwH0QRGcLJV81i1DVw6oTs+N9qx8mcto880/5iyVmKP4WUPC7I88nrHyhjy3+yA+eo
         gTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469627; x=1792074427;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fpxqDP5CsmzUMOKjttGXHMSiBcLd+CV1qvWa4yOxMC0=;
        b=nLSfj8dfObBy9j5uHdxqwB7TAoYXITfUOjEjT3ABraEE6JitNWZSsRos5DIOtkU3gU
         e123M4kd+/O0XS8eZqnUIku7MSS4SaGvhluvcInUIlwFrt1buZbijapV4PDePQ2ldVPz
         Eom5Rhw+nrPoGwwpi9GE0IbkbiwnJBqP02hulkRKOQDAR/luEYStTEjZQQtxaYo1ZuLf
         Ubr/+jpY80apADspzdW4NM+PywMhKpze7vs0VkAfGw+m+TvojS2JXlVJIMU+8+JgZeo/
         u3cqwYbcFxIeiQizhDPHhTfJ0CPFqX5W8nbFggin8bB6KyjXPB2vjIFA9294+GTzc0s7
         qsbA==
X-Forwarded-Encrypted: i=1; AKwUvBwiFIf8Mqs98yWDmAvNug/zDO+MZ6XHvoJpWjHg2M3RmqaXEd9uxeHFLrC68irXxNH5I85ngPCqsF+J0VdZULFa77rBm34=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9bswN8Zsih83WzXdG1KZBZ4wOGjZ+TIPbiZ24MKCJmGQ4w8m1
	02vjy/83rAhkqXL5dCDdAvzM5kBNa1yeWCw9vbSB5C1l3GJKD2+8WqPD
X-Gm-Gg: AYBFou0S/Hbpogl/zLIUVz5V8OlE3IHW8sQoVUL6kdHOliQERYukpEmrSf/DoJWetPN
	oM/hcaQy4jBD141CXJkRnvkcJqI0Xl30TOud8TAvUV5iSf3vJRymr50LmDVH+JnFdcCjGocYgDI
	4QHb4RG9vOJPo3GLxisDidCibRUtEzXhXHS2QOrXnkY9R4bmo3M7Z2AThWaeoJGvu60X8BvewNM
	ALwPtdiiXTbSGmCGeISTpzvXcLz8UfBgfsCGipytIHkqQHXaxsuxoob5nu/4pm4tw+cH4IoxeL9
	chpF2eU+0W6QwFTzuje4dctezPfDBQPvxwcp1qcJo/Gesh1xZDuV9CGMKiOlyzyHERS9jahhF50
	rvK2IlRvnIh6J5LycO/6/PZvkG2J+0VJMlO0sG2tZCNvaBBAidzNnLIn4Rjyo9RUXNhHJucwjkH
	uteLS8iQ6JSt/kqOZDkzywWDu2v2/QiSXZYK6cyiQNmDq52f2e5+lL4cP65Y3SBjGZXKf7qu2kH
	Wiq6HnKc0JLMmGkJf2Lx/zP
X-Received: by 2002:adf:ff8b:0:b0:48a:fd58:a7df with SMTP id ffacd0b85a97d-48c72896f38mr7829329f8f.47.1791469625397;
        Thu, 08 Oct 2026 07:27:05 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48ca8e2e627sm3241531f8f.20.2026.10.08.07.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:05 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/27] selftests/landlock: Assert tracefs_extract_field() results that are used
Date: Thu,  8 Oct 2026 16:25:38 +0200
Message-ID: <20261008142604.39107-11-gnoack3000@gmail.com>
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

Several trace tests check tracefs_extract_field() with EXPECT_EQ() and
then compare the extracted field.  If the extraction fails, the field
buffer is left uninitialized and the following comparison reads it.

Use ASSERT_EQ() for these calls, as the other trace tests already do.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/trace_test.c | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/landlock/trace_test.c b/tools/testing/selftests/landlock/trace_test.c
index f9b293a9dd56..a331df746dbc 100644
--- a/tools/testing/selftests/landlock/trace_test.c
+++ b/tools/testing/selftests/landlock/trace_test.c
@@ -175,19 +175,19 @@ TEST_F(trace, create_ruleset)
 	}
 
 	/* Verify handled_fs matches what we requested. */
-	EXPECT_EQ(0,
+	ASSERT_EQ(0,
 		  tracefs_extract_field(buf, REGEX_CREATE_RULESET(TRACE_TASK),
 					"handled_fs", field, sizeof(field)));
 	EXPECT_STREQ("read_file", field);
 
 	/* Verify handled_net matches. */
-	EXPECT_EQ(0,
+	ASSERT_EQ(0,
 		  tracefs_extract_field(buf, REGEX_CREATE_RULESET(TRACE_TASK),
 					"handled_net", field, sizeof(field)));
 	EXPECT_STREQ("bind_tcp", field);
 
 	/* Verify version is 0 at creation (no rules added yet). */
-	EXPECT_EQ(0,
+	ASSERT_EQ(0,
 		  tracefs_extract_field(buf, REGEX_CREATE_RULESET(TRACE_TASK),
 					"ruleset", field, sizeof(field)));
 	/* Format is <hex>.<dec>; version is after the dot. */
@@ -357,7 +357,7 @@ TEST_F(trace, create_domain)
 	}
 
 	/* Extract the domain ID from create_domain. */
-	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_CREATE_DOMAIN(TRACE_TASK),
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CREATE_DOMAIN(TRACE_TASK),
 					   "domain", domain_id,
 					   sizeof(domain_id)));
 
@@ -365,7 +365,7 @@ TEST_F(trace, create_domain)
 	EXPECT_NE(0, strcmp(domain_id, "0"));
 
 	/* Verify parent=0 (first restriction, no prior domain). */
-	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_CREATE_DOMAIN(TRACE_TASK),
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CREATE_DOMAIN(TRACE_TASK),
 					   "parent", parent_id,
 					   sizeof(parent_id)));
 	EXPECT_STREQ("0", parent_id);
@@ -381,7 +381,7 @@ TEST_F(trace, create_domain)
 		TH_LOG("Expected check_rule_inode events\n%s", buf);
 	}
 
-	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_CHECK_RULE_FS(TRACE_TASK),
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CHECK_RULE_FS(TRACE_TASK),
 					   "domain", check_domain,
 					   sizeof(check_domain)));
 	EXPECT_STREQ(domain_id, check_domain);
@@ -615,7 +615,7 @@ TEST_F(trace, free_domain)
 	}
 
 	/* Verify denials count matches the single denial we triggered. */
-	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_FREE_DOMAIN(KWORKER_TASK),
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_FREE_DOMAIN(KWORKER_TASK),
 					   "denials", denials_field,
 					   sizeof(denials_field)));
 	EXPECT_STREQ("1", denials_field);
@@ -900,7 +900,7 @@ TEST_F(trace, non_audit_visible_denial_counting)
 	{
 		TH_LOG("free_domain event not found after 10 retries");
 	}
-	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_FREE_DOMAIN(KWORKER_TASK),
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_FREE_DOMAIN(KWORKER_TASK),
 					   "denials", denials_field,
 					   sizeof(denials_field)));
 	EXPECT_STREQ("1", denials_field);
@@ -949,7 +949,7 @@ TEST_F(trace, add_rule_net_port_fields)
 	 * (landlock_net_port_attr.port).  On little-endian, htons(8080) is
 	 * 36895, so this comparison catches byte-order bugs.
 	 */
-	EXPECT_EQ(0, tracefs_extract_field(buf,
+	ASSERT_EQ(0, tracefs_extract_field(buf,
 					   REGEX_ADD_RULE_NET_PORT(TRACE_TASK),
 					   "port", field, sizeof(field)));
 	EXPECT_STREQ("8080", field);
@@ -959,7 +959,7 @@ TEST_F(trace, add_rule_net_port_fields)
 	 * net access bits are unhandled because the ruleset only handles
 	 * BIND_TCP).
 	 */
-	EXPECT_EQ(0, tracefs_extract_field(
+	ASSERT_EQ(0, tracefs_extract_field(
 			     buf, REGEX_ADD_RULE_NET_PORT(TRACE_TASK),
 			     "access_rights", field, sizeof(field)));
 	EXPECT_STREQ("bind_tcp|connect_tcp|bind_udp|connect_send_udp", field);
-- 
2.56.0

