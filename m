Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21383932CE
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469649; cv=none; b=jfhW9LUdOWFkkdtbfHY2bC9/8zXqQhXpBInzUfz2I3DKqoOTtDPKLnqEDZg2wAoFVqw5IuvSFjvCBPXT/Ku9zXWVyRMkIhHEesz579mEqavN8E+HnmGGP+u0LKDdsGFfSJtVyf5LVG1mUrwI/ML5HUhu9PXuNZhLO1nXyLadhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469649; c=relaxed/simple;
	bh=locUOrrUBXD+IkEnjF+pPczV2ZY8/LR/N/JNMLQi/Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtH7On0krYKL2xspiTfuIp7u8JHI0ekL0YoPhhKBJRAJSgDMgjZtcNcBmOiL7GAbV6hHUbtEkkChNyIYHdd88NId0BxaZdGugG6RTV2BOLenY6eZD3B4AEf7GU92V2JtMSUpwnK82IjKbHbew0mHxvcdKPsOy+fUxFT3a1iUrgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7j/DWRc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7j/DWRc"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so4580312f8f.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469645; x=1792074445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1T3CR3Az3SHwtFPkIUQDc5fFYC6Qe7UYCDR3mM1BBgY=;
        b=J7j/DWRc2hP1HPxrXMHUsDrZ7BOTIuOIXr13KqQ+sZ6CTkMNMuB8akrHPWsnfe75BH
         FzuJU9ccSV+Vb0HAzRtdRVjQLdy2NnorMu//6QxWYp9Qv6Yl8OqcWUSwN0acqSBFR7jw
         IaFv9f8z+HK0YdsA38m1yBxV5yS81O0YpHYnng3UJqQHZmguHIwrcHjv3yiUvZojshqK
         D0Po5Sl1UE8S/pn07zt3e0ERjmdWTGUm2c3auGVf5OU1fQa0TxM1YrtNQ0sfq1KPI7Zt
         BLR0XSspWwmajSFmmhAWKlsZl7IP0WNxtEkdXK1w3nUzobTCCiF8gcf8z4vAApD5Gs6P
         fqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469645; x=1792074445;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1T3CR3Az3SHwtFPkIUQDc5fFYC6Qe7UYCDR3mM1BBgY=;
        b=praFXko0IxDtkA3v95MHxKRhziYqIzQToDde+5xUQTBOnZLUUMARGvYp/u93lg9yZS
         Jw/kIQtx0Ol4IqXZ6Wk2Q8afA1wNNfrP1OtiaicQTW0xFgY9j3NaloQPPq6kBB9Z1FSr
         EmBKUt6nEgYqKtdKdfae+CHX11pdKjNBhr4H+vZpkvhr7Pwy7hrQOEOsLpvg4cwtX79/
         U7uW+v4I4GUNokRGOFihWQpMsLcn26YaZykmNZI950a3WxMHIv0sXWBOwkZhoev6212G
         5zyju7pxplLiubxO3BFEryJjvwScv7AYwISTOnsntstQAiqt2lsn9frd8Ku51jUr6GHX
         cWSg==
X-Forwarded-Encrypted: i=1; AKwUvBwcAfpVfLjNr+tvop4dDucv/1LOfTvwUos3Sw4zQHRY2Fm8wpbNqah5BSTnOcAR2X1qTMnFvbfRrn2xV/XLQZl60U45EVg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHAI9IPuANCCmzzoC/cdSQd+WQq5clA65pXRNFYiqE7gc1l0fl
	YDqRfXsEEIwoJn92/fSAmWwqB0tdGC6KHH9xBePuH3eRIOcs3+fi59Ys
X-Gm-Gg: AYBFou1LVyaA8DQdOx8BVcOa3SzSV430DucNk3q2COwFLDCzmKAK69K9oBVh41VSKjf
	1hidIOwDY8EJgTkilEry+YrzyMOrwOiokRCUXMke5/7UMqktHN6+MTsRVLIenC/sImCSTwRFrEf
	BO1w6/1wB4OHJA4C6sRMX0X57lbT9+k1cuBPAVjPwtwpzORBfdDDFUOXx53hhhAEceTztMJw62l
	8bHJ0j1YKIMmgoB8lJdbUAdwpSMq3bmiRSDir4pVLkriwoi2k3kxl2KZeeRRVFTPdNaBGfqB4M5
	WASwiQ/V2334HyJYN4lq7HB1GjHl28jzvyZ29FA7KnEvEYyB5PFF8N3TeMLD1KNGEPUkX9NEkSk
	ij0VI3z+5hou71gRDPn5JcK+fno4xGHzKU9gMgblDjnYl4hkXc8F2S6C7eNZEq3Jyps0aNVzzjM
	WpfTirAmRbW6czqwlTWcv+N5WvvteEUP9MGcLJgb/gPAnrk5OEJRuZrvxuiBfVkGvG8f45TUDDM
	/QyUwtOsWMLM+sKa4WOXaPzOnsp/Q4oAw==
X-Received: by 2002:a05:6000:4284:b0:48b:910:35c3 with SMTP id ffacd0b85a97d-48c7289cb70mr9367096f8f.35.1791469644945;
        Thu, 08 Oct 2026 07:27:24 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1f3f7sm11321874f8f.32.2026.10.08.07.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:24 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/27] selftests/landlock: Fix SIGURG handler setup in scoped_signal_test
Date: Thu,  8 Oct 2026 16:25:46 +0200
Message-ID: <20261008142604.39107-19-gnoack3000@gmail.com>
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

Drop SA_SIGINFO, and rename the function to setup_sigurg_handler()
without the parameter.

* Drop the SA_SIGINFO flag: This flag implies that we use the
  three-argument sa_sigaction signal handlers, which is not the case
  here. (c.f. sigaction(2))
* Remove the "int signal" argument and rename the function:
  The function was already specific to SIGURG and this is better
  communicated through a different name.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 .../selftests/landlock/scoped_signal_test.c        | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 0f88a6af9c72..66fec3822812 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -392,7 +392,7 @@ static void handle_sigurg(int sig)
 		signal_received = -1;
 }
 
-static int setup_signal_handler(int signal)
+static int setup_sigurg_handler(void)
 {
 	struct sigaction sa = {
 		.sa_handler = handle_sigurg,
@@ -401,7 +401,7 @@ static int setup_signal_handler(int signal)
 	if (sigemptyset(&sa.sa_mask))
 		return -1;
 
-	sa.sa_flags = SA_SIGINFO | SA_RESTART;
+	sa.sa_flags = SA_RESTART;
 	return sigaction(SIGURG, &sa, NULL);
 }
 
@@ -506,7 +506,7 @@ TEST_F(fown, sigurg_socket)
 		EXPECT_EQ(0, close(pipe_parent[1]));
 		EXPECT_EQ(0, close(pipe_child[0]));
 
-		ASSERT_EQ(0, setup_signal_handler(SIGURG));
+		ASSERT_EQ(0, setup_sigurg_handler());
 		client_socket = socket(AF_UNIX, SOCK_STREAM, 0);
 		ASSERT_LE(0, client_socket);
 
@@ -612,7 +612,7 @@ TEST(sigio_to_pgid_members)
 	ASSERT_EQ(0, setpgid(0, 0));
 
 	/* The non-sandboxed parent is the protected (out-of-domain) target. */
-	ASSERT_EQ(0, setup_signal_handler(SIGURG));
+	ASSERT_EQ(0, setup_sigurg_handler());
 	signal_received = 0;
 
 	ASSERT_EQ(0, pipe2(trigger, O_CLOEXEC));
@@ -629,7 +629,7 @@ TEST(sigio_to_pgid_members)
 		EXPECT_EQ(0, close(sync_child[0]));
 
 		/* In-domain positive control: the child must be signaled. */
-		ASSERT_EQ(0, setup_signal_handler(SIGURG));
+		ASSERT_EQ(0, setup_sigurg_handler());
 		signal_received = 0;
 
 		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
@@ -737,7 +737,7 @@ TEST(sigio_to_pgid_self)
 	ASSERT_EQ(0, setpgid(0, 0));
 
 	/* The non-sandboxed thread-group leader is the SIGIO target. */
-	ASSERT_EQ(0, setup_signal_handler(SIGURG));
+	ASSERT_EQ(0, setup_sigurg_handler());
 	signal_received = 0;
 
 	ASSERT_EQ(0, pipe2(trigger, O_CLOEXEC));
@@ -1062,7 +1062,7 @@ TEST_F(trace_fown, deny_scope_fown)
 		EXPECT_EQ(0, close(pipe_parent[1]));
 		EXPECT_EQ(0, close(pipe_child[0]));
 
-		ASSERT_EQ(0, setup_signal_handler(SIGURG));
+		ASSERT_EQ(0, setup_sigurg_handler());
 		client_socket = socket(AF_UNIX, SOCK_STREAM, 0);
 		ASSERT_LE(0, client_socket);
 
-- 
2.56.0

