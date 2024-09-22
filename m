Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB928F1;
	Sun, 22 Sep 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727016753; cv=none; b=qP5A6oHZtd8dCidk76yRv8jd98gg2jn35yqxk/SQq/IbJkIoDyCLxHQyw3iDFEHMy4WHUEHSIjbN1AkYzqSx+o+/pa7O7LB4M32x+5rdnIXXERlQZTOLtcI5cx9vl0Wgz12zozDVMbQ+/LAM/py3KpSfIxmk9ZV8y9rzxbnE20E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727016753; c=relaxed/simple;
	bh=8dXv+L5cy+r+yw1U4RxDN/TXZy6iJHWclJaV5+Onno0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGTkXnrhxs7OKxGhq34HyRyOppxkJtdnkLLVu+2kEnINNlEIuAZjKm7Fvs+L3qrcgtJgVaKegjoZ3C0pPdG/R68PGXeAYtZ/hvhE+Qb4jjNhNinpnfUEw8+E4yJ4WplyIzr/yVYNddp5ovuGD4Cj89HT5DzLKEj3N4tZ2CpSplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNJa+YJz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNJa+YJz"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so2256778a12.3;
        Sun, 22 Sep 2024 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727016751; x=1727621551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WOgd2QunxMIvSdCybNEpeSDnURu734zoL6YtUhoHgls=;
        b=FNJa+YJzD/8O3IN7JiR3s9XZt6nk9ZZ1MsMZ+euuYp0aP4eVprjwuRDc/IeOFgofQ5
         dmZMd4Cu74sLfDZMipAqL6j8/CENIIQwd3t8R9Ok/inNlSslObIa2lCXDJPB0qmUVMdP
         h1pMuAFUSUT6cLaMupjF4E3Iamj3ELFgyaEHJiJgiCG7EtuCL2BwlDBxQ/oFP3dpq6UC
         G0IbAdOheAkIiTFsKP2GSdd72elBRWf5jDz0iat/SCH+VgmSK7TOYKTDNrH82qsfnwYg
         1ZXmmdpj13wRF0G9n7vRo4jhFPsKHntvGYQx3muroI/q+JlvS1lkPDlm1ZF68b0z9LxW
         CZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727016751; x=1727621551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOgd2QunxMIvSdCybNEpeSDnURu734zoL6YtUhoHgls=;
        b=X2yrHS0M3tvthPI757Y6KBtIEq80jaRnY0No3N4e+hUUxgtnBcN8zW1WBiKRXjC0SI
         v5tcjy2bjqRY0RzqOgzCG7/9VqxJy8LSnVuJSnw7Uxmu8nEkCodKcG38mpI6xBAHO+u8
         +7CV2w6dOCOLnhUVjBzYpAuR61EV2PujdQ1ZvchWtZ3wZ13iZ2NHEMu7VKZPD+YQ+717
         FTTmZQatyIGIpA4bToN3AGhsb6r+wc3xkvb3haC9gaDmxEzkI1ydRUKf2iLaY/Z3q5LI
         rS97uI/ZNcW2xbXUEe1YVIF22D11CbQLeiOpt/ef1l1ojYMjPRBcfCd+FTq71UXeQraB
         NT6g==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6vB1EOxT1Ps/CzLZfqKcrGt425bNMRggnsba34xSp8svPOENIKoAA7TejdCcTZWEnCr7+yEFAX4J3JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5qDrrjTfi+jKweGdWWsVjGstEnkwfm+xAK5ZOCirkOs+fzzZw
	vvK0Ie7ps0yyd5DkBnGWmwgdnX8Cuz8h0BOJWNad1cMXiqQQpNulIetm2A==
X-Google-Smtp-Source: AGHT+IF4el3/MzilIndSxikMQiUble/sAn2HPuAXgPrW4Oc7667+skBjv9AFNdZDdK2tgH+m0f+Y4A==
X-Received: by 2002:a17:90b:1c83:b0:2c4:e333:35e5 with SMTP id 98e67ed59e1d1-2dd80cf1067mr10407145a91.36.1727016750728;
        Sun, 22 Sep 2024 07:52:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef95ad9sm7628223a91.56.2024.09.22.07.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 07:52:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: "Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Deven Bowers <deven.desai@linux.microsoft.com>,
	Paul Moore <paul@paul-moore.com>,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [PATCH] ipe: Add missing terminator to list of unit tests
Date: Sun, 22 Sep 2024 07:52:26 -0700
Message-ID: <20240922145226.491815-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing terminator to list of unit tests to avoid random crashes seen
when running the test.

Fixes: 10ca05a76065 ("ipe: kunit test for parser")
Cc: Deven Bowers <deven.desai@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Fan Wu <wufan@linux.microsoft.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 security/ipe/policy_tests.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/ipe/policy_tests.c b/security/ipe/policy_tests.c
index 89521f6b9994..5f1654deeb04 100644
--- a/security/ipe/policy_tests.c
+++ b/security/ipe/policy_tests.c
@@ -286,6 +286,7 @@ static void ipe_parser_widestring_test(struct kunit *test)
 static struct kunit_case ipe_parser_test_cases[] = {
 	KUNIT_CASE_PARAM(ipe_parser_unsigned_test, ipe_policies_gen_params),
 	KUNIT_CASE(ipe_parser_widestring_test),
+	{ }
 };
 
 static struct kunit_suite ipe_parser_test_suite = {
-- 
2.45.2

