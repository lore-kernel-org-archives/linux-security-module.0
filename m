Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826540;
	b=mAZfw1WOR3zNYC0MmdWcgiNep3zHsjcupoPGmoANXHqTexGTaIHS9Qc9vPyA5xGXYpoM
	 1kJ/sPuD/NaPGuFL+mP8W7p1msxIQkxfW0D7euo4/S75qXx1DUD9Md5gJqZgsVvyDs+yG
	 swnI2/ZmCfyiMKTT10AUtx0JZumyj6gJ75soSCiBZZUBp37QT3SEXoGqupDKePZjIsq4D
	 gYuMbxLTf4GBtfFS6CwLZY216NeCsU+PnFe4P99pf9JoIspFqP3Uwi/3fm1laEfzkLLXu
	 codGKk0NT31SZGspjS5ImL4AuOlsm5Ur47ADiQ+nNGtRMCeXyxJyUmaHZTts9BDpK3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=eVQTW/JXU3QoFsiEVwefLqQuHI3QztXWs28WnRbhTu0=;
	b=A97qKWLbV7AJw6gDw622cgLJnrVB6Jv2GZ+u74TrNhsmnAF8N7LiFK8EG8EEpjb78HSC
	 U3xve8+WFVy63AuqistEceRU/xTV/D8coIhYQ6CA59FpesnqUIjz14MhUiGmFf8yxOApB
	 BG9t1edLTu32tZzAGIOg64n2lbb+ioMVP0vZPFi4iCiPsXZoGj6TSE1ouqlziobhPuwLB
	 vKetwD8Ediq9QOLphVoQy40mAVT2rnPUrwKMaTqKtY1fKJBc2czZlFVvjqzOzrXWsvH/C
	 /fnIFRp+J0HVyf4UQvMeB8Z/dHdZhZHhqjz/om2Q2zRyXAeMBF6dNlrpMIJHHbNTC4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fLSgcH4i;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7349F607E70F
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7349F607E70F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fLSgcH4i
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so8560985e9.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826539; x=1794431339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eVQTW/JXU3QoFsiEVwefLqQuHI3QztXWs28WnRbhTu0=;
        b=fLSgcH4i/dzvkJSRKSDMNrc6SjSUPCpo58LZ4L7HayI6Xp9uXKaWbXBFNzxdk/xC7l
         74+r684UMRnZgko5aoMtN2Ip+omTLmmoZFPmOKhHWZRjAcTyUL65zl/E6yX7suI4ayuN
         a3mCtguZb1xBJoR9OZ/FJBTc487bLDZxdUFgeddjL7dxYAj4IsPdTZ827tLQEPkTBypI
         JARrhXiSsJ2v0KK+y4KhZv679QGGdPXapFc+0h4jdISXOspNpbIrCOW/bdwqjhcRP4MT
         h4M06dT/S5UWD0LwmIwN88BpRoAt/s29QO1DQYvz/wyQPem648MgJVTyF0ZakMSMyZyd
         15tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826539; x=1794431339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVQTW/JXU3QoFsiEVwefLqQuHI3QztXWs28WnRbhTu0=;
        b=MGjwEWImvtZM4g7qpQlHPGgDAndz8hkYQREacgvNvtwnFNbgyq7M4DPjeaV+kOWs/V
         Lr0gQ84AwvAzKFlygP6h1NnST8knDdOLoehm8GWKGnQB/zdOCVtSbrOzQZrVMOKeFLDS
         biSkLpsxWe6HkL8TZ9JQ6jA3ADvb7mOzYFuSh9XDvk4Nf4TG1KwOEx+OBZRARvYxnO/h
         ZSOqsmeAs7O+reMcFdhoCIeB3qgWoyf58pO808QLufUhDynP5qGRJY9JkrO1264DSCN1
         0b4lrfEw5G4aT2/eb6wFLQOiLcFyGrjBiW0KBRua7Dpq9N+erPwisbwuvm3HiALGvBas
         JZQA==
X-Gm-Message-State: APuU4Z805GkL0mB0yWNhA/NKH4Q/0X5F5/0W8qxpVyUAuiPVzwK4wydo
	Rn+xrIXQC0dHUVy99hdKvWClKLJ2zvSTpplAoKhDlr0qQTqbpHmaDNVA
X-Gm-Gg: AYBFou2UW6HaFdhlCWp6VFof3GeNgJx2mt04wYM6ATyGDdM42AL8JAYAhnGN3vG0xvn
	VqVBSvhPrtgv1nE8/WnnXCa380q2d6BWCRi5OUqMQ6F+0hw1W2dTdhrIl6Si2widMtuprUcE03W
	67cB1zF0g85rf0y6vprcRKVp5hSIQquHf9k9BAWT6+l5nGT/pjzKtoKGeiC4W+QkVsT5aDr0WbU
	00oghI9qke+/HQ9c8by5hk9juJi8BbD8r653pO9CDGeRp6jBiEWHlB2adEmMkOIrSpjtrTpxkur
	d/y/aJrpoHSN/z4z79LJyB3yAXUXV21JFw8C6J6wIka/hbpDzMj97DNs8QAS5vWRM0iCp7ATwZf
	WeQW1HcLn1O+QUl+PR5Pi3JwG+pvyPIyC7wb3EJzYXQev4sdKGpCeyWoXUbz1JDz4gRynjpkGkZ
	ADZmQvQnWG2v25GhfZsifHkU1gKKN9ktNxCjavR9zmP3PIkC3cez8zcRmR/aIjRLjMnLm2USB0l
	33Pu6u4inxM79/KHdZloto3/KgVWAJOrP+yZXYylKzJW6kH1vx0wPoxy7Q3OWxl3LSFgCUq+zIq
	dEpDg24lfYnZh1kwUE/mPxGsketJQeFTtZmmJXf/d2n8H7swq7B2tq/ODv8Y7p0+m88WgDjbQtU
	=
X-Received: by 2002:a05:600c:314a:b0:4a2:fd2:985d with SMTP id 5b1f17b1804b1-4ac1775316amr367177345e9.12.1793826538751;
        Wed, 04 Nov 2026 13:08:58 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda2007esm5673249f8f.47.2026.11.04.13.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:08:58 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:08:49 +0100
Subject: [PATCH v2 03/27] selftests/landlock: Check the thread result in
 audit.thread
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
Message-Id: <20261104-selftests-refactor-v2-3-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

thread_audit_test() reports failures through its return value, but
audit.thread joins the thread with a NULL result pointer, so these
failures go unnoticed.

Check the returned value, as the other thread-based audit tests do.

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

