Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826554;
	b=uRw+88GxgGA8wUfUlPw0J3EM+DYTTMB+wxGLgMK4d9ENzKo6M4lfKHfgwJbdGxC4RXZ7
	 K9c7tGDUhoHIBxDoI3TZ7l6ub9ITJT1+Rgf+4vuwmMxQEpqNtYCVVCTgyoTNv9dgDl+uI
	 QlfcAd/KaYIA3cQnytAXMLEj+aIEifYaJsCaH4Gm1TxUl3bB2OYBzFvvvlSjT1hiJOH5W
	 HVpsnlyEXgFsm8v2wpCfhDVs4+AyT/vWBxER3GL9EKkQhwr2yUEavrCaqK7qy+6gPdpEV
	 mOQefTQV5UjNz5H5YRLfVd8g6aiec3yzs2DxWJ7RPW8mfHVRG/xwCjLK1otQzaJOCIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=FwmAXxaBahAboQnBQiZSfiZqfzogCrFIH3WtsyVwi2s=;
	b=Dv7TV30uvxv4heYdHxIdUUx43jfw63uiPKTibcCsP2+EO/45bk2VvDIVvUmtaUEczeZZ
	 /epONAQwfWYsBHNawyYeo3JJG4yXPkBVV+FcE0z7H1rJ7QfPYLz2GtDmoVJmc/TDKC1kb
	 DpFtI7GDhJ4rvF2H3yv5Dt86dAAqoPzITmWQE0DXhA3vtfMAaB6giceKqoiG3kQCvW/GL
	 qxHu8jFpvd1dnejb/1kh/yAdEoh6xB/y+seSxtxjd5afCiiVru5Z2ARK00AtU8zIszr42
	 EZtvEbA5rE79uYFnB1ILqQuukOvKQlPMkO0GSmfb1rUrCuulYBfuSE1eUWCFQdhb62w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iCHWRBMc;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0460A4FA5
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18E0460A4FA5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iCHWRBMc
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so8875965e9.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826552; x=1794431352; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FwmAXxaBahAboQnBQiZSfiZqfzogCrFIH3WtsyVwi2s=;
        b=iCHWRBMcQht93C+GJcUpbzIdEGz3IzwCqHXybDR+OVilK/BGP9+75mqet1wyp3kCqt
         C5sIzGZHzcoU4T/IuUdrz10/fQZ0CnX8rgDUDzUJa2nIZ8zzF/nl/eHo0htYoSi124Dc
         kSq6HBFe/Yd7iWW33Y3pgpBkI5e1Su5FsvGTMW5qYW9T85FGp7rnphbcJuqPJlBDF7CE
         FPy9N0YBSlAtVkda6gvjtVcCvM9mqZxur2aHKktmr3ephDmqD5qfYx9Gm0nnZaATzONt
         iBqFDQtqt8l2+HmGpwukEwSX4rHC0/Crls1Kq4Na3wp21xt+iUDkE87ohl5NbqDkCBC2
         DrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826552; x=1794431352;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FwmAXxaBahAboQnBQiZSfiZqfzogCrFIH3WtsyVwi2s=;
        b=x3X1n6o7Bxstlxa+FnadRgbgdBTyeGWNGkinG3476l4lRCsDWBiO9HdCs9eF5K7VJx
         vVUcCFQUTi28RS+e729w1ARYSa9VEltza6oEQtcHM8IpggqsunZNcPrA1JXN2KaKo1QW
         xVBjdzsJM3sUtYZ97xID7AIMEnrFzvy+CJXjZq95AKzDswlPBhZ9OPtDqqmpW5jNZofO
         25vK8ptuYWDsbgA8kuM8bGC8WE1tf6+z5c4MbuOmnvljz6lEpcmpZLtFq54iqhHCEWjA
         MRG35aRKo1DGiOM0A7dCLG1x9uSHikp1NC/4+bA1UTixMPcOTfoVGBrDVQiMQBnMvDk9
         MawA==
X-Gm-Message-State: APuU4Z9tg/78oSB2yzjkKPRxVGfp4qKsfiFFSO4Nvar7xwBDvjnwbtPl
	LR9YQ4Ez/ZoplfsIbCAdhb39nSR0Ed6Qcv7hb/FQRhJBm73p6DgVBc5Q
X-Gm-Gg: AYBFou3AlQZEEqyckIlVPZ/0XAjtVOdW5UFQBdkYAMgYnT74zE3nhEH+gBX/QcSeiQC
	SKKW56rluIGG1FF8f6f+4B9yWAeoI8lM/zfvoID1ulX9YjsmHfETv7/Izv6nWNj+zqJDT+Et2EI
	v17A+SJl6+c0WE8nOKY4vO0LlGXmjaca62ss77TZ09v3Ed2sZoLAHb0cxI4gh5bfz0kn0981MiU
	kJU+88zEgGYuUFsm/BZZLurWUM7fcFlEzssAR0l6YXjL/bPhS9qnDntHck+BOIc/YxmoSOBXwz/
	/jhlTvEIpbsasEWIn2l6HCUJzJZpyj0caFRAvjQP4PGlGGR+HBAmi+DfHJ0CgSOvza7cZIT/hE9
	6HenBDTtMDN+KWTxy6H/WRllTE0kGMMp1iEzjjG0HVMJuwsBfctTV5+YVBQwLFfvCx1kCfcnov1
	lcUpTigT5eDuUeR7npyPGHfYjtQnihe9uzjEPoh9dKLAZBgoXEbDchLlFH9QIV/SJtCVCjeNmIh
	ZzLu4PdBY3PgHr5IoLRj/uvPbolqfmcVO/GXntO+gcNq7tu6LtdBP6ejPcR/XW1M6gr+cRScGPQ
	kyltdGR2B2kO8dPHLGaiEaCXYKln3zTq0lhkKWKU+w6l9qxKdbvu5w==
X-Received: by 2002:a05:600c:5249:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4ac1228b5bfmr387058325e9.0.1793826552398;
        Wed, 04 Nov 2026 13:09:12 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56fca2a4fsm12960655e9.15.2026.11.04.13.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:12 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:08:57 +0100
Subject: [PATCH v2 11/27] selftests/landlock: Assert helper results that
 are used afterwards
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
Message-Id: <20261104-selftests-refactor-v2-11-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

Some helpers check a result with EXPECT_*() and then use it:
cap_get_proc() in _init_caps() and _change_cap(), and
landlock_create_ruleset() in drop_access_rights(), create_domain() and
create_fs_domain().  On failure they pass NULL or -1 to the next calls,
which then fail with misleading messages.

Use ASSERT_*() for these checks, as create_scoped_domain() already does.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/common.h                    | 6 +++---
 tools/testing/selftests/landlock/ptrace_test.c               | 2 +-
 tools/testing/selftests/landlock/scoped_abstract_unix_test.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 6c2aa913ff11..a662a68bee7b 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -55,7 +55,7 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 		EXPECT_EQ(0, cap_set_secbits(noroot));
 
 	cap_p = cap_get_proc();
-	EXPECT_NE(NULL, cap_p);
+	ASSERT_NE(NULL, cap_p);
 	EXPECT_NE(-1, cap_clear(cap_p));
 	if (!drop_all) {
 		EXPECT_NE(-1, cap_set_flag(cap_p, CAP_PERMITTED,
@@ -91,7 +91,7 @@ static void _change_cap(struct __test_metadata *const _metadata,
 	cap_t cap_p;
 
 	cap_p = cap_get_proc();
-	EXPECT_NE(NULL, cap_p);
+	ASSERT_NE(NULL, cap_p);
 	EXPECT_NE(-1, cap_set_flag(cap_p, flag, 1, &cap, value));
 	EXPECT_NE(-1, cap_set_proc(cap_p))
 	{
@@ -227,7 +227,7 @@ drop_access_rights(struct __test_metadata *const _metadata,
 
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

