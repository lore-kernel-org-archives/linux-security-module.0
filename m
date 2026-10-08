Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5933396B70
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469633; cv=none; b=HN0kzhbz07q2vnBT5zF3s0TwLSg1Ba2OxYex++3ARDJhbcwPKKNk8rcz9513FFXIK77JOWGMWijqUtCNl+8y6wfa995l4OzAMcTD5b9lbbQHYSgX7yMceHcd7kQ8MQi5Mm0XAdLEZeblnwzpaKjisXzn0sJ9TcDSGHrr27agG1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469633; c=relaxed/simple;
	bh=hnOcYXmh5LhX3pi9rEvfebreY5Ug5jrveF7e2aFcLPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Igmmq32CRD/uJdn8XM1I+ATqrkFvc4aqvLF0S6tPJSUAJKhqUbBUJuJZP7bJlLsi/do92BEUtarZB1l6pP/uq4yaE6PbN1SAXJFkF8FXdh0UHubqIALK63DkfQXMQC9kZi8gg91zxBoybQRvzhFOOieKC4pgo5wHN0iCJsa28kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3j61rCX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3j61rCX"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2035382f8f.2
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469630; x=1792074430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YS63s2McwxMm+pKW8R+B1o0zb20mvAwoCWQOqk3C4/k=;
        b=C3j61rCXK1RRSwPAY2ofnpIb/Jq6sP20nt8/MmC5JZvyiGu+k4AiIy0u94+SpVaRRh
         4yrgU6s+nfcsx1kVQxKMTE+43zgOUrFm6owpk1XLk7PrYz8mZ15P3Dk+MhtbiyQd5/Q+
         OpKBGMY7vp89wFf+QKoKcZ0ii0spdoQf+KheVjiEAyEJTahosNoYuOC3Nt8w9wftY2ig
         WoMDv/QfGGxtQfy00x25MFTW6un0wpX3oHbIlEj7JigTxWwLiCh64VOJtmPjutUjT14E
         oI239kZUFMRIxs4csB10gzPg1gN87m4JrR42EeDmunn26gIuHz2vk4XWFwxdnmUcq1eK
         H+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469630; x=1792074430;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YS63s2McwxMm+pKW8R+B1o0zb20mvAwoCWQOqk3C4/k=;
        b=FzIzwpVBg+KwViiSGTQ0QcXNULFgnjirLM7XX0ZtVeC5L66qkBYMcz1MI2bt5Io79N
         0a+GIvkrmcf2MdNWOojfL79xeRVYEta8zI2dzsn5VI+E8pWu/cpgEiPwrwjjPOhmQNTn
         7y/RXS9CAtBKVh1Qrkn/oAXmwAWaXwa6pdrWt5L5wsqm8YGbARtSyupUwxa/zdCw89aN
         RN7iRKxK0kWMeW81GaniHSsoolroMUOFhL+E2Bf7HO6aHhVVzCrbevJVoAC16ICqZJd4
         O+ENLRiedOLOMuGkepDqz34/kYeaXWGcuO/9E8FY6khvNfdI7Z6kNI03GPMmrecqyJpE
         +m8w==
X-Forwarded-Encrypted: i=1; AKwUvBxUQKJX7eFmAs5CvSovyjXGcHVlbmDDqwWaqAicBXuxfBr0oG9dRU13YIddAcTXHs5uO1gpaIN7Cx6HZCYhFtUBFLEHo6w=@vger.kernel.org
X-Gm-Message-State: AFuF++kS5pPIC/uohYeHAawvXW+X7SAA8knO027P80TeJIjrZumBSTfH
	YuXLsnNV8Ct4kiB7Y+fF1h6VkDKmB6XYmxptHNDlpIO+PqW7aw5KFEPx
X-Gm-Gg: AYBFou13JCxaWimrD2apzYeOayJnHSdx47wpULKvEMaSxcsZIm9K9vu+pR8/2lXEknd
	rlYgMEQoSmNJnaXyeKoQ79TmuGBcqwAWJOsqGrJqkUXdwTch30Fn8OpkC9Xq5UfJWT1lstHDY1C
	HXDs2+GKwSybc45jGaWqKj7frtFnSxfcdKcfJSBKEPaMGFVeKixXd9nFAuys6JLQMkrs92Bamh8
	KIITm9TXc586bJS98UvBsKnZ+GQ5ttlKLEsaM9iQYGVrebsY/fEiy+psL/0+s+WFb7qMvwtVKQ4
	2UH1Np/C9CXlu2WnSrQ26UkjEcYs/97JJpwXq4LdnHrKTtfQQMJ2mH7JVI0daTggvtUZRdsFl3Y
	nt+r/M55Rd+jNC9on85vFW6kye88liPFHfJU62a/RKIr1048/2L7cV9rEFTkuVoeUkZ45I+Fvcb
	AawPESdey/oO3a8APQIbTFvrrCmFQAsZw6l+0bOqLWGRRThNNkrmBk/alEwshzPmL4chLVDRL8g
	S5COvAyFEcbkvzhV5p5nNM=
X-Received: by 2002:a05:600c:1551:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-4a18043cac2mr101930475e9.22.1791469629879;
        Thu, 08 Oct 2026 07:27:09 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843bd060sm92830635e9.14.2026.10.08.07.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:09 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/27] selftests/landlock: Assert helper results that are used afterwards
Date: Thu,  8 Oct 2026 16:25:40 +0200
Message-ID: <20261008142604.39107-13-gnoack3000@gmail.com>
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

Some helpers check a result with EXPECT_*() and then use it:
cap_get_proc() in _init_caps() and _change_cap(), and
landlock_create_ruleset() in drop_access_rights(), create_domain() and
create_fs_domain().  On failure they pass NULL or -1 to the next calls,
which then fail with misleading messages.

Use ASSERT_*() for these checks, as create_scoped_domain() already does.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/common.h                   | 6 +++---
 tools/testing/selftests/landlock/ptrace_test.c              | 2 +-
 .../testing/selftests/landlock/scoped_abstract_unix_test.c  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index e195c0f48eb3..e1aa0ec02c96 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -53,7 +53,7 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 		EXPECT_EQ(0, cap_set_secbits(noroot));
 
 	cap_p = cap_get_proc();
-	EXPECT_NE(NULL, cap_p);
+	ASSERT_NE(NULL, cap_p);
 	EXPECT_NE(-1, cap_clear(cap_p));
 	if (!drop_all) {
 		EXPECT_NE(-1, cap_set_flag(cap_p, CAP_PERMITTED,
@@ -89,7 +89,7 @@ static void _change_cap(struct __test_metadata *const _metadata,
 	cap_t cap_p;
 
 	cap_p = cap_get_proc();
-	EXPECT_NE(NULL, cap_p);
+	ASSERT_NE(NULL, cap_p);
 	EXPECT_NE(-1, cap_set_flag(cap_p, flag, 1, &cap, value));
 	EXPECT_NE(-1, cap_set_proc(cap_p))
 	{
@@ -214,7 +214,7 @@ drop_access_rights(struct __test_metadata *const _metadata,
 
 	ruleset_fd =
 		landlock_create_ruleset(ruleset_attr, sizeof(*ruleset_attr), 0);
-	EXPECT_LE(0, ruleset_fd)
+	ASSERT_LE(0, ruleset_fd)
 	{
 		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
 	}
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 10371c1830ad..b951889cd6ca 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -37,7 +37,7 @@ static void create_domain(struct __test_metadata *const _metadata)
 
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
-	EXPECT_LE(0, ruleset_fd)
+	ASSERT_LE(0, ruleset_fd)
 	{
 		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
 	}
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 5e8224623780..55a1599819c8 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -40,7 +40,7 @@ static void create_fs_domain(struct __test_metadata *const _metadata)
 
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
-	EXPECT_LE(0, ruleset_fd)
+	ASSERT_LE(0, ruleset_fd)
 	{
 		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
 	}
-- 
2.56.0

