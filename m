Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648C3914FE
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469666; cv=none; b=j7AnsRO9sr+SUxDVA6/vddMv/71H2hD4wHnX3JDU8NOOmDuNZCQlCbVLqQP0MFCxsDwo8TmBy4PE+duCu3ioleukFpGjWuRaWIBW1N0pgFQ0mKyPqTLQYzi2lNtOx27I7ml8oAR25bgI8ScuG2xPU5dGBvyXicY5LQuz9rKWtPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469666; c=relaxed/simple;
	bh=m5ow1J9jdoEMi1CXJk8/S4UkgRL/ss96Vuk19sTxtY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYPTXtVa1i/y1YRFZI7BL14tZY7LN/ZXrabCrh7Ua9RhLMBnwPqFqV71PMGxx84kJpmCofzbYk7bivi1H6iFUTJDN81Y7yfBCSDA25Qxb7YSKKr9gCKxyTg7GyW4cf8X9GKaxTTnOhZLZhxmVfcj13JRkBJ7CAT7uqk0ralPHPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ei+sdUeB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei+sdUeB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso9452685e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469664; x=1792074464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YZISr/L9O4I7MRbnn9NJb2XEWKkc1K5iiNHqgDIFDWo=;
        b=Ei+sdUeBu1qLgwTVVj2LrRNhBdlQStMypGTqf3C7xtNblB1TVX/dUJMVb0St3F7P+g
         acC3ay1aoyeiQQEmk2K0MTBsfRAsMcs6lKClV6zga+9EzvVL5puFUCzx5MauWIsIbG/c
         iv+AgUdHds1ws3BQ3Re6DvazqpQ7q7G0JHY5uY+H9cUkw9ay1fGbUyDGksr5HseZAjkO
         1PhZ8BMN1xPPdIhN1A6AcikOL/ETtIFFpFN2pmGyju0czYEmuTrmE/lFvDEzu0JaIxKA
         ygzvNXDbt7be/Wzk85AkaysVvTSHJDgri2cPs30Bcr3OSCLJbR6WMvVuuslCXTRGvZjq
         epXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469664; x=1792074464;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZISr/L9O4I7MRbnn9NJb2XEWKkc1K5iiNHqgDIFDWo=;
        b=X5xMTpNlVHiP0rWfDh08DihObOn4pQ0WHOJ/ueafBDbiHuES71e8sclLUJKCAGwIUh
         n0vb8ZdavAnO70uYDsBHomiVKFByMC4h29cXo1XsdivDbWsupZOga+RG3SHQF1YZkRij
         bIwTNppIUh9uclgtNsKusY9V30NCjMkcMpz9Hcf2/ibGT3I8dtTupHEFovjHT5IAUBb8
         y30Cr7kUArqw4l3dzUclToHxdvuRbzlBJRI1h4oToymp4a4UGQT/mXwMWvtWgKHLeNju
         S6Iar0dmu+ijhGM5C+NVEeY5oAyi+nB8uRaSqx+yZoutWhSViUNbyZ/nlm0t/mAPDCeA
         /ITA==
X-Forwarded-Encrypted: i=1; AKwUvBz2Jp2ogA8iHe5eKQ5P+ULLrXiY/AGhj+xfLJEAcZMKaYAgAqka5NTIFtyZYYz1aJQyWouB7/PuVxPbyKXB8omkwiWbBEY=@vger.kernel.org
X-Gm-Message-State: AFuF++nYhN58TbNiPNgOasKonVPLz061vxOkpVDZSIwzOlhDEiGJeK1h
	OLSGFX3nZcaa6a3SwnV2Y+9sAt6b/TSw23Q+0WNRBAASs3Nd3lGQX0na
X-Gm-Gg: AYBFou2nF6ENtSKCTZyrnxV3nkJizTUlsiwws8D8LOykO+K3VDOifuvPYtmNih7A58N
	fBIh2OSj82FblQu7ti2YXEGWIc8uGhSgLFEABuzOkUNJ00Arj81gq0IP68jhiJ9a0d4n5/Un5T8
	dLg/X/5ZCiIBGxVS4onH3W+QZIVs8ORIHlWDBsBy6LKvRPvGdt9E1bnOjgbaL6W+YMK02JiMNu2
	fLGMUe/bZz09k263gbBxku4Yklhz4j/3612owWTbRgAxl1mHVNpiPwFgZw7sFCPSKg34g5Z12nE
	5NIKcSNtNamHQTUzXxFqolKPJ0UboQtsV1vF0aFx5RT4V/ilmr3tqHBBp0Ba28b3lpch1M6pqfO
	x7QROK3mGH6rZpxqZyHEuTjR78m6OJbiznjPcVeTr9VnwgT9pISoPevA/jXJcgzaYBhcuIpoLbA
	fAyUAhlwlUzdZQCoBALv9miGgYECBSs6Nr1jM4tfZpp1ZoieWqvcpYfnMm93oEoRZK9Zg/LVhFg
	BHtB/5llTtOgWaQldP5Hyo=
X-Received: by 2002:a05:600c:3e0b:b0:49f:fbad:29ae with SMTP id 5b1f17b1804b1-4a1851c7355mr52692635e9.17.1791469663731;
        Thu, 08 Oct 2026 07:27:43 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f4480a4sm112187905e9.0.2026.10.08.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:43 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 23/27] selftests/landlock: Fix stale comments in common.h and audit.h
Date: Thu,  8 Oct 2026 16:25:52 +0200
Message-ID: <20261008142604.39107-25-gnoack3000@gmail.com>
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

* _init_caps() lists more than three capabilities.
* A 64-bit hexadecimal domain ID has at most 16 digits, not 17.  Size
  the buffer accordingly and drop a redundant domain_id check in
  audit_match_record().

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit.h  | 7 +++----
 tools/testing/selftests/landlock/common.h | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 173dcd1088db..d23bb2ad3a30 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -274,15 +274,14 @@ static int audit_match_record(int audit_fd, const __u16 type,
 		*domain_id = 0;
 		if (matches[1].rm_so != -1) {
 			int match_len = matches[1].rm_eo - matches[1].rm_so;
-			/* The maximal characters of a 2^64 hexadecimal number is 17. */
-			char dom_id[18];
+			/* A 64-bit hexadecimal number has at most 16 digits. */
+			char dom_id[17];
 
 			if (match_len > 0 && match_len < sizeof(dom_id)) {
 				memcpy(dom_id, msg.data + matches[1].rm_so,
 				       match_len);
 				dom_id[match_len] = '\0';
-				if (domain_id)
-					*domain_id = strtoull(dom_id, NULL, 16);
+				*domain_id = strtoull(dom_id, NULL, 16);
 			}
 		}
 	}
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index ae6a0eb8e343..f0e8d3a498b3 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -34,7 +34,7 @@ static const char bin_wait_pipe_sandbox[] = "./wait-pipe-sandbox";
 static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 {
 	cap_t cap_p;
-	/* Only these three capabilities are useful for the tests. */
+	/* Only these capabilities are useful for the tests. */
 	const cap_value_t caps[] = {
 		/* clang-format off */
 		CAP_AUDIT_CONTROL,
-- 
2.56.0

