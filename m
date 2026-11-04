Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826550;
	b=4ahuUKjvxtY2BxdT/s6JB991EHEkImFRA3jI43TlRKT+909NUrbOspSVmiwIERj0ISkI
	 NoC/2joXE9jlUEXnoYrXnobSkvA6q1DZCAZ6DsGqV/CaKJkP9TscNTQuVMFzl2eJoMBGl
	 wahRCkwHl5hudLjZzpaNo0qahnJS/uZlIeIo+GrEZBOOZYRfRZnoZoCn66DjpwQ0jXgvT
	 oZNx6HTHsKk0e0FwcCIs0fMVQpQW7ufsME1U+Ik6tCPZwzhyzS/P8pLStopeTu17YNyZs
	 3D/1eBDc4jt4s9/QOntYtAPFMYHQr7gBPBHxVO3iMEYr2vGfDjIKkODx2jJ+AvnkV9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=729LbPMPastRfQlfVEWKWxLCR7JpRj6YVk1X4d7YWEo=;
	b=4NC2eBOqDdjM4QSHSEvWJX3LM9eiX6og4XIiQr+ALielVK68YGyESEE1k42XjunRvCXx
	 kMTKpjjPVUz7HJXi/2YRJ5Geu7sF3zXbMz0Y8SWOEgGMo6cgfk0SY7eInuuDymLBhUmbG
	 pB8ciwI2GoUFnwl50jHaKmE/+0HCwvNv6/pKJKU2rluhEVjlKC2fRt3E4TYLZfGdSm6AB
	 87fISzrRBPi0VeTjAOSNOBiZkElAae0Fcy9Yq/+O7FGDJqxYifGxi+cLnvEqugjlPo5Bt
	 yWhzozcah4TV9WXnfU13aqWc4EN78qPMtM2ZKSS27JxhEvjgkFvuftCW3xFrH4ZkxGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qW4/6f9Q";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA5260A2610
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AA5260A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qW4/6f9Q
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so7263525e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826549; x=1794431349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=729LbPMPastRfQlfVEWKWxLCR7JpRj6YVk1X4d7YWEo=;
        b=qW4/6f9QMYYNLzuX+9fq2z2jVkf1UM/thXabt8pajkTNPSX43bpePlTtAm2TfGRLbJ
         HcJt1RKD1b83ThkRoRG6R0VlGkC3nfTnehIAhBWA9bm5IrjeUzYvmd3wKTkyY1/yr3IS
         B5kNYDdWaxAtEsdwVifmNbyEAEPeRtq3OqUSzCK3QV8HrGPy00ZH7vq3h6mEOjndJ7Yj
         rLoam+HoGGbg8y1DVaQtdqQgwulTmfWEPFbfrvv047DnKKOScesliWUq/7qeVTuOs/Qk
         FmyzarFvGeu0qV1VNKXMPAGGDVZP7j5m+BPMW+dI4akrhRQkN1Rqf35mNt+DCuLwLjqt
         w5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826549; x=1794431349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=729LbPMPastRfQlfVEWKWxLCR7JpRj6YVk1X4d7YWEo=;
        b=EJrVuS9weK95YE6yVdFQDTzRUZGq3F23gNxX0ZSjVaI6NqNyGutDQrBNujEtB8eG3O
         WY60YrHCNRsN0Ed2gXcUyOTYIyvB3EhnmPWBWsVrUxF6XiEjnfUyuclWV+vwJfrfBZIK
         XRxJ2y8dnmniSEOWz0aoNZUReWbEMLakDMbykBgrtwVdrZVG1ZNGiNx/pKtZ3jLqIU+4
         DFPbC5ME3/yR0qiVD4qHsqSFWhWn4JBZYqI3PuFqF/4/6ye23AD+pn1GdG1XFMNp/POu
         rpKDINIYYVWpRQSOKOSKwOASaSKLJe8JCKHOi6pJc4qHuXx781kXzXZpp/Arxh9RYmHu
         Sk1A==
X-Gm-Message-State: APuU4Z/HYymcj6vQ4RVaqZvFXC6SdeXZh40jZKqjDKjV6S+IepFtmR/U
	2Y0An1SzWy/qzSxPvTYguXc4KbeCE3QAjXzEfSxvJ6yuYbaamvwh/JU9
X-Gm-Gg: AYBFou2b9tvGKaMhJKglbWunwXhFesWMzTkgZIdlaJ37RS2AYD6/K8j9flCv4dh8Z1S
	eGwyzfBrkN3BWIFoTzQb5LYni+eFflJqj6S/omJRDaJTn9zXijhSBv31wnO+zSvYm1vSNWA61Fs
	twd9G0VBj16pEwxYpzp31fj99ETKZhgxpbLkPXxS5e0nduhUP7f7DvOJioqLxHh91tG9J0EOWV/
	/bvVWxQyPfrv1dfCCpEYKsr3pRdDmWENU2Cd7bDYXQ2qTii4s4yvntiZoP28OZbUu/GYsWwhfTO
	Cg7sLbtHClpCIrvIKcU85TDuzXwN0WLWHiXxYSEvNo/q1AjFIb7+VHkIuRhdu1OErSWzin8g44u
	+7BBvbeObtJN58TaEZ+vBDrtbV1mJfNhp4qNBSsGn/BsDf4tjQHxzgLPTkd+CS3fylNuxcByTk8
	tq3YSNA7a9Ah8FhU0+b6IzYI2MaPAudjQsND/PPk3R7wI/n0Dia88CYxGR7WcWiu4smwqxkdQLR
	bc9dXfUKk27cPh00BzexVsTKglNr2UU4BfWNMIED9nXgukmiLqquaNRGYv0uS2S0qMYXscQVBG9
	luJ0iO/1W2bHwueAqRtftLmnThrfdTkqdYvxV1jWMGu6BjdABaCEGQ==
X-Received: by 2002:a05:600c:19c8:b0:4a3:59c9:a743 with SMTP id 5b1f17b1804b1-4ac1913ef8fmr402468605e9.27.1793826549010;
        Wed, 04 Nov 2026 13:09:09 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e58fcc6sm20061955e9.2.2026.11.04.13.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:08 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:08:55 +0100
Subject: [PATCH v2 09/27] selftests/landlock: Assert
 tracefs_extract_field() results that are used
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
Message-Id: <20261104-selftests-refactor-v2-9-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

Several trace tests check tracefs_extract_field() with EXPECT_EQ() and
then compare the extracted field.  If the extraction fails, the field
buffer is left uninitialized and the following comparison reads it.

Use ASSERT_EQ() for these calls, as the other trace tests already do.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/trace_test.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/landlock/trace_test.c b/tools/testing/selftests/landlock/trace_test.c
index cb49ce8dbeda..1795d41b779f 100644
--- a/tools/testing/selftests/landlock/trace_test.c
+++ b/tools/testing/selftests/landlock/trace_test.c
@@ -175,25 +175,25 @@ TEST_F(trace, create_ruleset)
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
 
 	/* Verify that no permission is handled. */
-	EXPECT_EQ(0, tracefs_extract_field(
+	ASSERT_EQ(0, tracefs_extract_field(
 			     buf, REGEX_CREATE_RULESET(TRACE_TASK),
 			     "handled_permissions", field, sizeof(field)));
 	EXPECT_STREQ("", field);
 
 	/* Verify version is 0 at creation (no rules added yet). */
-	EXPECT_EQ(0,
+	ASSERT_EQ(0,
 		  tracefs_extract_field(buf, REGEX_CREATE_RULESET(TRACE_TASK),
 					"ruleset", field, sizeof(field)));
 	/* Format is <hex>.<dec>; version is after the dot. */
@@ -363,7 +363,7 @@ TEST_F(trace, create_domain)
 	}
 
 	/* Extract the domain ID from create_domain. */
-	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_CREATE_DOMAIN(TRACE_TASK),
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CREATE_DOMAIN(TRACE_TASK),
 					   "domain", domain_id,
 					   sizeof(domain_id)));
 
@@ -371,7 +371,7 @@ TEST_F(trace, create_domain)
 	EXPECT_NE(0, strcmp(domain_id, "0"));
 
 	/* Verify parent=0 (first restriction, no prior domain). */
-	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_CREATE_DOMAIN(TRACE_TASK),
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CREATE_DOMAIN(TRACE_TASK),
 					   "parent", parent_id,
 					   sizeof(parent_id)));
 	EXPECT_STREQ("0", parent_id);
@@ -387,7 +387,7 @@ TEST_F(trace, create_domain)
 		TH_LOG("Expected check_rule_inode events\n%s", buf);
 	}
 
-	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_CHECK_RULE_FS(TRACE_TASK),
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CHECK_RULE_FS(TRACE_TASK),
 					   "domain", check_domain,
 					   sizeof(check_domain)));
 	EXPECT_STREQ(domain_id, check_domain);
@@ -621,7 +621,7 @@ TEST_F(trace, free_domain)
 	}
 
 	/* Verify denials count matches the single denial we triggered. */
-	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_FREE_DOMAIN(KWORKER_TASK),
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_FREE_DOMAIN(KWORKER_TASK),
 					   "denials", denials_field,
 					   sizeof(denials_field)));
 	EXPECT_STREQ("1", denials_field);
@@ -906,7 +906,7 @@ TEST_F(trace, non_audit_visible_denial_counting)
 	{
 		TH_LOG("free_domain event not found after 10 retries");
 	}
-	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_FREE_DOMAIN(KWORKER_TASK),
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_FREE_DOMAIN(KWORKER_TASK),
 					   "denials", denials_field,
 					   sizeof(denials_field)));
 	EXPECT_STREQ("1", denials_field);
@@ -955,7 +955,7 @@ TEST_F(trace, add_rule_net_port_fields)
 	 * (landlock_net_port_attr.port).  On little-endian, htons(8080) is
 	 * 36895, so this comparison catches byte-order bugs.
 	 */
-	EXPECT_EQ(0, tracefs_extract_field(buf,
+	ASSERT_EQ(0, tracefs_extract_field(buf,
 					   REGEX_ADD_RULE_NET_PORT(TRACE_TASK),
 					   "port", field, sizeof(field)));
 	EXPECT_STREQ("8080", field);
@@ -965,7 +965,7 @@ TEST_F(trace, add_rule_net_port_fields)
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

