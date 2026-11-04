Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826577;
	b=PK9BnqE1nnslD9Rgk7iiagCHd0i9oczdYChWPnq9Vlg4eUPDLrscAoxXh1ppkdCPvgqg
	 HNHWwSwzSLoCXYtDctBLRKsVNOQT3uJGtc22U97PN6tQo7RtvWqc9XEYBOgzTmpzpx7lf
	 fRGSYCe7OqD1Glphn9iG3IWZe5D8cTNYZaRG1bJMbFl4kuY1omHJYHcje+4GN5RMzLhCN
	 jv5jjQ7t2HHorLB+g5n0k0uRWmYGw3Tz2ghICf68PoQ01JiIY1l/F3AVwOVuVoUWQwGdA
	 GIYMH1jNqumk4Y/eK/3PsLFIGklJqA0PgUWWb10jpbis5jsCKuhlnor3LLiqPtwxI3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=3194YaOP0F+FMB6I5klv6B2ufzZSORnnEQ/EVm90CVQ=;
	b=eYGljtKk3v/QX9RsqwWXWyWvxT1D0NXoXdclxdaXtBo+ENZb1ijhmFgaB6Fe8Bs1SgDI
	 PsxsNIH+B5oF51o6bftmFwy2AJa89hU9O4fA5Ic+8q15Tip5ubTot5m06A5VgxrPJD4lj
	 C86tIu0hHW68AlUy8k/Op+LYufP5q9k7VkwhPCMnWDL5cBzu8o/m5R8vpacEvdR0Xv0MG
	 n77Avcf7rEeEhizNjVdnax1s5O+MA7QxH3Aqs43Z641BkQ7xSL7MzcFkgSNT5D3GkMlwl
	 AbY4EP2HwCS0jgV757WyG0tAzJ6LViMphjZ85Q7E6a1vFUh/Nr8pQAZamqV2fAEAvSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D3CiICk1;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE31C607F29F
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE31C607F29F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D3CiICk1
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4910b863b84so10493f8f.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826575; x=1794431375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3194YaOP0F+FMB6I5klv6B2ufzZSORnnEQ/EVm90CVQ=;
        b=D3CiICk1IU3LYOkkUsP513zcLWLMA5i0GRg6LkkHP7BB1EcQ9D0tGOHgvlqQic9CyG
         V9De65zZ6pPKCjXt8CLX8huiMGmVM8Inj2UUFzrZY0nCvugX/vvz5/2JWSXbVIrBdXTU
         Re0JRKL42TnXy9iCrvGCJI5MoqYTj730qvHIH19f9+ROUvad/DUzXDNEgITCVKtx2Qp+
         oYXgOh34bDIWWKeKUvRqnI7wBV449fL2F+7jYT9no/Z00SI4itNxQLWOv/DNusGaCG45
         /SHfXt9/FBavBlhJuvypvpJYwYR0aHSalFMIqYLv5/ghs3VUk1YWys0LyB9z38PfEY45
         JGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826575; x=1794431375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3194YaOP0F+FMB6I5klv6B2ufzZSORnnEQ/EVm90CVQ=;
        b=0rf3MnKVOpVeDB3MceruVpWH/WflRpFgJsk9QhtUuJ9iU8iPE6Rzzl2o1ue6sTCl5l
         zV0X8Q3EFJg2wT4Dq5l4I76YrLw+/CFHfdrmaIF/hRHB9PpIitD3ydloH1h7iPySi4AY
         UMBOQuOzBmjoryeO6c5l7ronEplK9PjygwaQi7jGe+Kn0XcCafpDKOMwtaiQMKsX+05e
         rtn82uKtpAexAZwzCoTwxbLAHXmugN6xYqHwdD0Z4FF0YxW2RKP6MOx6s0t5+HSqG8K/
         kLsChoYJY1/Fa9+1VXpIB0Jku4dvkVbY7mDMVFlUpIGDHw8TY64bRUT8SdpNh6zcSlkx
         Is5A==
X-Gm-Message-State: APuU4Z9UqKe1tQDrecJpNtalLSYDsxJ+yFmYMAz4GRMEiEHV8YvNVcj/
	eeP9SqlR826Shkiw6K53F5+1y+AoAf88mx6tWHgz2aYRl4ZSYClQrLoz
X-Gm-Gg: AYBFou1rT0TKY6dcKXdjWnm5tyywKs6yRVuSypZNbmFh12NECKIpfxXY7bsnjoOfDOk
	Xz4VpwHxqR8MnidEED6UmavZXJjAFZ5hyOfiOIveJmmagG+nUr24Exj1JHODiih1UypwD4hSNGP
	QYGp723yOgpV8bUBwN1jb0BeFwtCg7A2mYTiwBjzHjo4geQZSfSN8au7yRkTHH0kBBnJS5d2Ek4
	8KmjlE5FDPuzZhpV9Cs8ABXFw9g8jK0IAY9PsxdBJhBh89rl29232P2drRJHpkeHtHTeLFbWz2V
	KQz0AbwI/zK4msq8ODUQDrIuKxMm2BCgc8sYegUoMtjrgA+9puUzgnfk5Nb/DLKahAuRdXT09WM
	0smq6VV08E2niHUXTy4OWDFxfvnAwlHHjlpNWQhesQr4fJZMr0e7tgKkVhvZTsIgdapiLXn1WnX
	MGaa8yspCSCT3PqIEIMvM2byiE7QnsEaqEyr5UDoG3y8mCOI3Jc3J0z9gzLgVm0uXxGeVjeW4Kk
	PGSgKQp1u6MBdfDAqYi8dk477D5dXzk+tD/dZ/PtE3Tm+K8mOGz0nGkBXqqmh1dKVDj5Hc/cIdh
	QrKmCiFDfnJHhlaTfQxMou26KXesUwwL5ZlVIRKTeXgvuOJhm/Vo6Q==
X-Received: by 2002:a05:600c:46cf:b0:4b0:b9ff:1e7c with SMTP id 5b1f17b1804b1-4b55e07e569mr10214435e9.15.1793826575088;
        Wed, 04 Nov 2026 13:09:35 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4533873f0sm77710365e9.4.2026.11.04.13.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:34 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:09:03 +0100
Subject: [PATCH v2 17/27] selftests/landlock: Fix SIGURG handler setup in
 scoped_signal_test
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
Message-Id: <20261104-selftests-refactor-v2-17-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

Drop SA_SIGINFO, and rename the function to setup_sigurg_handler()
without the parameter.

* Drop the SA_SIGINFO flag: This flag implies that we use the
  three-argument sa_sigaction signal handlers, which is not the case
  here. (c.f. sigaction(2))
* Remove the "int signal" argument and rename the function:
  The function was already specific to SIGURG and this is better
  communicated through a different name.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/scoped_signal_test.c | 14 +++++++-------
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

