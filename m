Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826539;
	b=QQC///xN1KXSoBB0JRoAskYUDI+UEOFYV0l5QFICzd789DUkSobmDmdPUtW9wW16g23G
	 lSjXwNxITTiO5X4CXU3dWbffvF1CMFI+ZQWVVLHC+8vgUomeaPp8M/6K1Qz3sTPqTNFFO
	 MfGq91ugTkoR+EeK/Ky1vFD2Urjb0sN4j5xumdHghcx6xZDL2NLffLilgNwkSt3+V9o5e
	 1GoavvhDcgkv+h0b29nNJnGr1Nj988lY2cyKpmoKwFaC0lo7CwrLsyCmLRIDduO+JQUAs
	 SGhGarC5mMGRmkMnnzZ618YaX/+hQ07r6o/hXayj83uCbfIijbFgj1FgsapS8hSMHdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=wx4pJ0HLwTbcqPJBKfgxIdGigPrVHgc2rJS/1aTbB3M=;
	b=HlV6ZmoSexA6mXtkgszwgRiJFUNz9TIMMgfC3NeV4sIElFjGkyqUjRQTA+/navf+PnkQ
	 +WOndC/tQhXMO937RgSAAIhnXdEKzLVCdZ3ASAyiMJPZarV3SOzV2NEKdTi6JhCl+6zYh
	 8hJQaBOinQag7PMIWChZBjoHLafBaPcyEzy+Wnps2Hhccin6Y24XVA1NAsS0DtgmYya/E
	 4Uh2eXA3j51D9dau8aQFUWpDOTB91Dxn2d2/v9FQLl12uMdEvA+DIvHFhiIlduqmSI277
	 9u8E8jZeaiMh1KcGjOuEiB9Fo0hzQXo2U6lo1z7pTivb3jaEqSCjndP79LN9lnag/6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xPZq59FL;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C8607C0B6
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 836C8607C0B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xPZq59FL
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so10731295e9.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826537; x=1794431337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wx4pJ0HLwTbcqPJBKfgxIdGigPrVHgc2rJS/1aTbB3M=;
        b=xPZq59FL/LdAYt2ofE6opelD2ogyAljWJpR29J/hfD1ormxa7z8JKZcsOg9mr6VZa7
         3tgPHBX2oJFVcOb6FJ9kifHIO85QJrmL9rBMKdXWdFdGj//Je786Eb2pGSmf17K5RDc1
         h9rTw9B+LvhlLC0trXnS/z6K45j/yjtEmYiSn183ZNwbY6jJZ7ZtqtiRnzr78oy2lMU2
         NP2Dhj1+g1srRraqIxb8IdVpDoJPaWm4CDumcKn/t0n10pJERunxGr86/12a/k6Ebvtd
         kY0vwD0EWQ7kE7JZnDo6/5BrlJFBsdXi67+l5RlnPNgAYz1dNTr6t/7zgnOTrrLOOiAI
         y0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826537; x=1794431337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wx4pJ0HLwTbcqPJBKfgxIdGigPrVHgc2rJS/1aTbB3M=;
        b=NckBd/a7tZ4g+kz+1nNN+Q3S94rwFO3YS8ubK7nYJR0WOeAzWkOZPR/1EHAcKsaJ8T
         amE+dqgotzwj+tlNgb3LKV8UMkIlHJ+pRkl4BXohGzKyBnvSS1uQs4PVXQ9Aqv8lgAaf
         0x7mr089u7iXPjQ/PFGx3cV4MbFYxbjkCoFuG+h5XK2OEnFZw51cyULaFBy3waYKGJQC
         xWOCkIxURm0npG2EW64tdfXmhDl1L8vou/NrsTtgtdzADP01cJ2iHyUtcz7awlRfEwbW
         Sp0/e23Ft+H7cD9XvlVLvoC/eqDNJTfCjCY6ezZ4NquyvKoOfSzi6LygPx36B9Co9PAa
         5UeQ==
X-Gm-Message-State: APuU4Z8xPmxtb1Rfs0/q5Y7/cgRPv7B0aJMichOB/FcVsKFNsCbxIkrb
	65b8XWOpOOrUNsqHLnnDO4hOWxv4lfbnU5xYDDjUv0pHGi4U2QG2E3k1n9yY5J4Y
X-Gm-Gg: AYBFou1OJ1GZe/Rp7O0tCqTxo2V1vpGyrhgUZxYUEGRyB94NIUk3nicS9WQqWBk7wqY
	2+1RGPT4qcdmWZS/aHcxQgfY3YTGqlLGAcirFa8VNtmZCwgSBKhoi5K7b5ctLaLUso13ITiJuC7
	PSMzEScZUQiwofhkG9f7BGGNh8g6NzrUtyiVaBiFbctbI2dXxE3MHR5w0SVb1pPWELCXNE/sgFd
	L3T3DbcfmDV5k5Opm6UfqAoaDktMqLtZmOGH669O+4ru4s766+SACFuL+YoXLZ1t8tf8yOn10gB
	3umNVAaAXoBRiGYK+E9UMc5InIOxQa4qYpMP0DXm+mep1FqPYglZGaAwIpZrcmRD3lp2nvavvtM
	90QdCJWoTNsLVCBaH77ai3ZPo+S2bElNMyl+v+oM4eeaVwi3Uy1EzCVuONN6BfYuad7LwavZZ0Z
	IGJ2XFcf0DKeFMkA3mqvrKrH3EX/jkm/tlBd3jdpoFmCLlJOSAZZqcgMByLm+AuhPnkjBFJTaLF
	EJOgQASrsw1XuoAL5Yg23OTGqTcdrhoEmxtnJL+4J5BEcdSal2IwPz6vK274qJGeFs951Y6rRvu
	v/PMExKpmSoeJK0IizuQqKCM47WVwqMgs5cvXGbOxpTufKRtD8AwGg==
X-Received: by 2002:a05:600c:a00d:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4ac185bc336mr363516035e9.18.1793826536887;
        Wed, 04 Nov 2026 13:08:56 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56f02386bsm10975625e9.7.2026.11.04.13.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:08:56 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:08:48 +0100
Subject: [PATCH v2 02/27] selftests/landlock: Propagate EXPECT failures
 from forked children
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
Message-Id: <20261104-selftests-refactor-v2-2-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

A failed ASSERT in a forked child calls abort(), so the parent sees
the child die from a signal and the test fails.  A failed EXPECT only
sets _metadata->exit_code, and a child that exits with a fixed status
of 0 hides that failure from the parent.  The child in
trace_fown.deny_scope_fown has this problem.

Exit with _metadata->exit_code in that child.  Do the same in the
audit.log_subdomains_off_fork children.  They only use ASSERT for now,
but this keeps them correct when a check becomes an EXPECT.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit_test.c         | 4 ++--
 tools/testing/selftests/landlock/scoped_signal_test.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 4bea8c880a4d..502a0825d877 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -314,7 +314,7 @@ TEST_F(audit, log_subdomains_off_fork)
 		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
 		ASSERT_EQ(-1, kill(getppid(), 0));
 		ASSERT_EQ(EPERM, errno);
-		_exit(0);
+		_exit(_metadata->exit_code);
 		return;
 	}
 
@@ -347,7 +347,7 @@ TEST_F(audit, log_subdomains_off_fork)
 		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
 		ASSERT_EQ(-1, kill(getppid(), 0));
 		ASSERT_EQ(EPERM, errno);
-		_exit(0);
+		_exit(_metadata->exit_code);
 		return;
 	}
 
diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 259cdcc8aa5c..47307dd2e242 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -1090,7 +1090,7 @@ TEST_F(trace_fown, deny_scope_fown)
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
 		EXPECT_EQ(0, close(pipe_child[1]));
 
-		_exit(0);
+		_exit(_metadata->exit_code);
 		return;
 	}
 	EXPECT_EQ(0, close(pipe_parent[0]));

-- 
2.56.0

