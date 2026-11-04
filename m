Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826591;
	b=SnmJeZoS07POzd8j8MY11pcGxNPjIdmaZwOEB9sHgGPBn0SG3Ry+oBsCWNe8LYXQ8GQK
	 EXTfGFhL00uAhRMhUw3y867F34Du9AkPnVJCF5GCQFrSshdR5WEMAGcrCs7HpEwxp3H8U
	 ToEijUuUosoVkAE/q5PUAQet2JYwU5RldGMpSkTXuoOKaAusMjQIAjRlm2vJe7VhAcX8k
	 T+XSaHD1CDTcnfcTZOlZ9Ec0UiHDgSw6FFZCgdkvsplwkoZRQgY4+O1yrYMUgw/iZ06kO
	 WzCOcgREiZ2KWByBkOCd+omy8e3hhM7SKLfGN01/4LDauJ07dszTynCzcCLm1tqs97w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=4SXFwK/yqKkPhUAKqKEKto7t7U4WKvibwTpH3PVe8uI=;
	b=nHogNLd5m8M/Raq0kWvjWbfuFDJBLGpKVdQWC+YArY92YPS9Ri2ugkyd0qoFq5BeAlTt
	 Huxch7M7446k+fOjy1tTJWcOep4w310xEeBkOx0Q4KONW/XiZJgktu3cLuvUMHX9JTqw/
	 Mw6/R/BuzszrYriNE1FO2BtV9tkOVY2p+7YR32V46QxnoEvWsjuiSWdsDy9+bYUuk2fqu
	 Y78dN8qiQPLHuWCDKH+CVS8XBZOILdDEcDvcKuz+ZYOg5qVY9rq0GnlFO6o/A5bzL/Rbh
	 mesYsBCZs/SQgCOy3lYa7a7ugk6y6RH5ve6nLPM3L7AnQV+4mdMUqN3q09LLHI/e15Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ynZ/RqCq";
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E1960A0E86
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6E1960A0E86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ynZ/RqCq
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c5358fc28so1043868f8f.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826589; x=1794431389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4SXFwK/yqKkPhUAKqKEKto7t7U4WKvibwTpH3PVe8uI=;
        b=ynZ/RqCqh89OHwjvqNp+vs25vjiK4Ou7DN7zQEKZabuWvRZv4Y0j7AnYawI83cN6dH
         z1rcgOqnQgwQKNU9ghnJ9OmG3ay6wvEOeSZw/J/tpQrH1rJocOqNROCU546pI1PMoruz
         438Fs2ftK429eBbeLisQNvyR8Odbi0mpXN3m4a1/f8FFKRkyYcHCRU43gP3JKQyflUw8
         TgJro1GMnp6hkk1QdgxQ/5MB2YjmoG00ACya3Pn7/CMYA1flOgYp8HL+Ic5sWIScHbNY
         av46JXDg/8zY25s5wf/2LE7YEebsdBdm4T70v6VvWj+J2DvjboDI0Gn/KYr8ERDyrShu
         czeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826589; x=1794431389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SXFwK/yqKkPhUAKqKEKto7t7U4WKvibwTpH3PVe8uI=;
        b=0TlKSriVmsuzZNA2TpODrB1jTrkfAzmJfA6GSxRs6opfIfJzEOjb9CLyH0KG6mOydi
         /vN71AlXqzebcMZmf+D4ziVMiigREAjZ9iF/dmBIafJ68UIZ2UcPV7bu6RhW210xeDNZ
         HosqJsNY7rzwqraEKYqJzLYiSEGiEbBXiijHNeAf9K7Gqee+R34kFRT6J6H81UseHBA+
         4RQRBEbaDade4S26GUf4JTOesNI4CKRHlObJhi3QBigWBfza+f6kiB/NvbNoZejbiDXb
         s4ZSupgBn+seGwTG/f5IvL9NaJ1Y//TBt0ZaBbDAfB9RQP/ujbxJ/6cXJsXVfR8TdIm/
         Gp3A==
X-Gm-Message-State: APuU4Z+eqApPL4Hw2TrubEFlwNP4nN5j1TlABczhgheDjkG0WGDJGGqZ
	ExTvKLjsrdXMDbPNfKjnKRxeB41Nuos7XYOgJYqyviQARrbP7U6q4LD/Lg5eKX2Z
X-Gm-Gg: AYBFou2XqZ/mwJujFGsankmv9gqTHGsoiZPplf0ixH4JRpC4aOFm63ZqPwNBJLmRCWT
	d6X1Eqhq+D877ZqcJa9wXhpKub60Wkfx8jqEFzjLtYMSEgd1Y1v2URyQYr1tSpdJPCEfYWG0onJ
	1S7fGmINiJNft8ePiT+HyWsIj+q9pyH4IfVUhwRgYQEtS48cdEPT6bPKej9pTptu/tgniNRkLkS
	wZOj3P5YRkyo9PlPIbrxI04cVhBziAz8hGqUHvakRVNE7MBfzpOnZ6Jl8OiWIYsd0oYxGUJR8Xm
	7O5TNsuhXccE3Cz/K66U9+cp/waW2WlZcj5tq8CVZ27Du8s5Wxh9/g0WbJ3nMPoSMuw3HtnSQvh
	wCA/ZYMOjRJnycc3aohm0tjQYMTSKghMhHw04A0w0aRLM6cyfbwiEGDBhh7EQlQB558LpR7vm8n
	L3TIt5T0G8VxXPiPZGwE56yCnvfmI42F0PjMY1UILqn0I0MM2BWU95m+PavsBfWh4vd+gXI5XtO
	OASIWa6pxWomt/9X38Yax/PGIM5ShmRxWEcnNqfOR8WXii9XY/vEIT+emvoWi9q6FIXV+O41vsF
	eP26Lx9Hn99UWVCZd/ttNv9IPtcroGd16IWOPWqvZlfZSV0Sj7jBkQ==
X-Received: by 2002:a05:600c:3e05:b0:4a2:cbe:bebc with SMTP id 5b1f17b1804b1-4ac1765e5c8mr385324485e9.23.1793826589271;
        Wed, 04 Nov 2026 13:09:49 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae73csm12083535e9.1.2026.11.04.13.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:48 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:09:11 +0100
Subject: [PATCH v2 25/27] selftests/landlock: Assert WIFEXITED() before
 checking the exit status
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
Message-Id: <20261104-selftests-refactor-v2-25-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

WEXITSTATUS() is only meaningful if WIFEXITED() was true (see
wait(2)).  Check WIFEXITED() with ASSERT, as most tests already do, so
that a signaled child does not also produce a misleading exit status
failure.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   | 10 +++++-----
 tools/testing/selftests/landlock/net_test.c  | 14 +++++++-------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index b1a729b94e7b..4cb30b943aa8 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -637,7 +637,7 @@ TEST(cred_transfer)
 	}
 
 	EXPECT_EQ(child, waitpid(child, &status, 0));
-	EXPECT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(1, WIFEXITED(status));
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	/* Re-checks ruleset enforcement. */
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index fe1ca9c2d949..183dfc42895c 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4640,7 +4640,7 @@ static void test_connect_to_parent(struct __test_metadata *const _metadata,
 
 	/* Wait for child. */
 	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
-	EXPECT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(1, WIFEXITED(status));
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	/* Clean up. */
@@ -4739,7 +4739,7 @@ static void test_connect_to_child(struct __test_metadata *const _metadata,
 
 	/* Wait for child. */
 	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
-	EXPECT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(1, WIFEXITED(status));
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 }
 
@@ -5409,7 +5409,7 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 	}
 
 	EXPECT_EQ(child_pid, waitpid(child_pid, &status, 0));
-	EXPECT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(1, WIFEXITED(status));
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	ASSERT_EQ(0, rename(dir_s4d2, dir_s1d3))
@@ -5431,7 +5431,7 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 	}
 
 	EXPECT_EQ(child_pid, waitpid(child_pid, &status, 0));
-	EXPECT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(1, WIFEXITED(status));
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	/*
@@ -7985,7 +7985,7 @@ TEST_F(audit_layout1, resolve_unix)
 	}
 
 	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
-	EXPECT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(1, WIFEXITED(status));
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	EXPECT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 51bcb4740dde..e194fd78d8a1 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -903,7 +903,7 @@ static void test_bind_and_connect(struct __test_metadata *const _metadata,
 	}
 
 	EXPECT_EQ(child, waitpid(child, &status, 0));
-	EXPECT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(1, WIFEXITED(status));
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	/* Closes connection, if any. */
@@ -1274,7 +1274,7 @@ TEST_F(protocol, connect_unspec)
 	}
 
 	EXPECT_EQ(child, waitpid(child, &status, 0));
-	EXPECT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(1, WIFEXITED(status));
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	/* Closes connection, if any. */
@@ -1373,7 +1373,7 @@ TEST_F(protocol, tcp_fastopen)
 	}
 
 	EXPECT_EQ(child, waitpid(child, &status, 0));
-	EXPECT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(1, WIFEXITED(status));
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	if (client_fd != bind_fd)
@@ -1528,7 +1528,7 @@ TEST_F(protocol, sendmsg_dgram)
 		_exit(_metadata->exit_code);
 	}
 	EXPECT_EQ(child, waitpid(child, &status, 0));
-	EXPECT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(1, WIFEXITED(status));
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	/*
@@ -1571,7 +1571,7 @@ TEST_F(protocol, sendmsg_dgram)
 		return;
 	}
 	EXPECT_EQ(child, waitpid(child, &status, 0));
-	EXPECT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(1, WIFEXITED(status));
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	/*
@@ -1642,7 +1642,7 @@ TEST_F(protocol, sendmsg_dgram)
 		return;
 	}
 	EXPECT_EQ(child, waitpid(child, &status, 0));
-	EXPECT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(1, WIFEXITED(status));
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	/*
@@ -1677,7 +1677,7 @@ TEST_F(protocol, sendmsg_dgram)
 		_exit(_metadata->exit_code);
 	}
 	EXPECT_EQ(child, waitpid(child, &status, 0));
-	EXPECT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(1, WIFEXITED(status));
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 }
 

-- 
2.56.0

