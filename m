Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826547;
	b=k4kpgDmF5YCXcALqcUi9rS7QBCRdLkBL02M7GwDJ/GWjusSbmdcj3Yyk8sttO74lL/pb
	 t+NcfxUIywReHIxHHIwzEbFEAusLd9J9aLOBzn0TRo7ZJ1UDMZAjzuBq4RXHdawajSa7R
	 Ht78XE0IqjOQ0UFbFOcSwg0Wk7aqoyLQs9E6Ev5jOJRqiVmQcNrD7WXDZYfDy631D+gRv
	 71lUy2VVamlQHeCyv85nNLcSnfJzWy1VMQGtsPs5rZEsrh862ylV/3PN1RCU9IYvZG3DS
	 p9qdcyD4CUpcXh5Fw2QA7QXD8x6p4xGf/Cae+9GeYj7faWTvTYdh22RtcRthqbSeUhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=irqZ6/3MyiMekC4JKIQxGO3/LPhRZcckOlSBTK+F8dQ=;
	b=fsvCPNUN44jKCWco+R0L7F7A4TWcEwiqaaRnP81uPcIvQ0unxPDdvaqByTBKYMWUQ52l
	 viKYla59wOmkB1czhMcpIGUmgPuUa2k64C9fG9hAEw2PQbIgG7Ymx4A6oT/0Yzre/n8q/
	 rbQO3rGW5OlBiRPxE8pQcinH47igjpbKEakC8C8XiR04mc5/NopHnRysdJQH1E/v/XkbQ
	 VYLsrDZ3FU+uu5aTPxkW2a2K4vjUZSTS8J5r1aD1QeOfK739qk/aPYYaQPZxW93wxYqFv
	 0Tdovn7h4nEdRqg6BVtlmWKsJ64XVV8SudUBJXhoLVNdNZnW8wYs9JA50l8zoGHUuQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEg7oruh;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3060A16DD
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62F3060A16DD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEg7oruh
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so12771195e9.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826546; x=1794431346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=irqZ6/3MyiMekC4JKIQxGO3/LPhRZcckOlSBTK+F8dQ=;
        b=UEg7oruhJEBaj6ZB2neW6iSWvxxOKi0Wv37wuZBin/3EppB4M0EOSjSnRf5+lMJzSF
         X3P0nqm/4cMEfx0KlrClvKbM/Br7UFji3TzrxtfCC6Sf9mx1UcopnkK728VVYbQ7l7OX
         STE6EC0EJCt/njfoPJMnCO4ZZfskJpaN+ztgkQ7RBbF0WND7fy88qzn8aFXXW6EvyQ0n
         8HXhyxkVdFJVfOo6DuR/NPDbLrepl6n3wm155kLXN1VajbJvz4Jbtbk6i1DsW+G/WlYx
         m9IiGgWz/pn+oFCfwTzgKhP/zqzUvvajiIth+ab3ZxiZki6c7lvTaDKWuEfwHw0Axw0A
         D6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826546; x=1794431346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=irqZ6/3MyiMekC4JKIQxGO3/LPhRZcckOlSBTK+F8dQ=;
        b=zTKrVtpG5h/7oW9Pa/Bzl/wH7SK4SjutIAG84B1vuKh4Dh7KeX6Fw7ptb/OK/SIABM
         yr/6f6gEH+BXxx+YDvd5S1bHy4IX++/suTT6L8Qb3rSBNmPY39Ytyiwy9Fq74ub8U5Oo
         bou4fjg8G6iCDRstKW7bgTjPIp0UpacA5Lzvdy5+4oXz4w5Az1POLIXPmcxv7ONU63MZ
         SZgDgZXSEPg8ew1dJaQVcVMACppe2FgzRvi4UD1M0siEmQhZ/sSRz4umvQ+14IEoJU8O
         oZ8Qut3HsJ1vs8Q1+Ft/2CPQPr5M4UIOTlGd51sCGixdJYRLz+7gEjPdbStqFVkwmjyT
         LPFA==
X-Gm-Message-State: APuU4Z9ZVmiz0ZKT/KRN68rkxXUkzZRZjWMvqhxMQH5LMjVMFNuMv5De
	iwvaiG1WBz7Zy5L2zThREBFL/aG3iN0TbABMWF1NKTchCQQkphYcHpJ+
X-Gm-Gg: AYBFou1Pzs9eT9oYxGY1RixqfPAnLlEINz3y9zNXgrnee8WoOm4407Dgez18ODi2oqk
	8MVp7h6iE8wgKgFkRgT5D6h15A1QI8I+ctNoid3ahGPX5kWJz8NjI8qMaacXuWQQ10obvEL4ATk
	+zRzq4ttcyuzb4DT0GBYlsxc6Zijwc51/ZShXKiY1oOnxV+wiRYr69NXnZLeQwe5s+cUCBJSPTw
	97UWDS7SKWzUccIpzyBJR3leaBXPKh4dxauTJPEBOGW2XOcZnCIho1gVI5TiXxJlymYKrOsfxqS
	Qh3fC2cicplrCSHtWdmZCjoybI/ZS82xM6JtKY6MeFlJuxOGFmZS6g628xDBJLNa7cnwaXKGN/K
	owWE6Py4uUsWYMuDCeinTZPLyxAU4cffUj3MdXt1v+7pzP/aSvtxyL4MUaz9Bt1MWgWdhAxNDup
	z384jsU6nFk3D5nDL744ukq9TEhHiwnbk/jZt+aoP7Me7l0I35MgfeD9/cGuY06dZkvqpYGV/Vd
	YVscuqZIW8UVvAqGHWpj10n4YBJDY6GetotAnzhg1nKR4Dft+i3hRLIdVTPoxFyjYYWD5sh2Whs
	LAdmGc7+S/6e3TuapPfEw0oOkVljAc1y8MPGglJOvnPvs38+icj4mA==
X-Received: by 2002:a05:600c:1d07:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4ac150b229cmr403893635e9.2.1793826545784;
        Wed, 04 Nov 2026 13:09:05 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b433ebd278sm70399275e9.3.2026.11.04.13.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:05 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:08:53 +0100
Subject: [PATCH v2 07/27] selftests/landlock: Fix the ruleset_fd check in
 empty_or_same_ruleset
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
Message-Id: <20261104-selftests-refactor-v2-7-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

ASSERT_LE(-1, ruleset_fd) is always true, so the test does not check
that creating a ruleset with an empty handled_access_fs fails.  Check
for -1 instead.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f725882fa4a7..7d399c097c93 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1456,7 +1456,7 @@ TEST_F_FORK(layout1, empty_or_same_ruleset)
 	/* Tests empty handled_access_fs. */
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
-	ASSERT_LE(-1, ruleset_fd);
+	ASSERT_EQ(-1, ruleset_fd);
 	ASSERT_EQ(ENOMSG, errno);
 
 	/* Enforces policy which denies read access to all files. */

-- 
2.56.0

