Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766500;
	b=2XKmUwrofS/wwsXLkwq4TMpWEu+nJO6eVMJ0f58n2vzebOupSokxNDyeKo1E0NF9/eZT
	 67EqNeWqxLX3CnzVFe5Fx26MSMncikyfQHj6HcEPN6qSpKvpZwhmgpz/M0WDFjz1KBEdH
	 r2OJyUqVF4yUkLg8PbHJcLToeAT888Hy5ILdNIxUEh4NXtTNwlfFGYP/xw7y4+AzwhhWa
	 lzjNNpTJzJNOFax4HboHhgSB7KDJ0k3V/FQcjO6iojf/0+R7cwTqtUz6IIKf/CKNhVh6d
	 +HvM9KLLegyWbcUFPphP7p6fWP3sEhbSpeHzJLBK5FctZv3qV745xgF/KBM2e273uhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G5cm++BKjFrmGv1W0VY1iGSaZZ+nQ2gJAfMXfykemMY=;
	b=pwkSoTis8GfITEA6QatKg8GEgLLpXlexwCdtF4Zvrry1k4rMMCi+6G4x+ImK0iatSdFb
	 dP9PfSFiCWf00c9OdBf403msw3uHr2iVeDysBaszNjrIWf0CbXFQMQ1FvM91O35mSNFqP
	 eFCz8/2yA5HGDVpRuvzaMW2GrETJtkHdfEuiFaXxGCkB7tTa7quZgdJUafXRjV4MOsAvx
	 hBYMsD92aqhQpZoTKAQBt5SiFTD2Q12B8EDR1/jOIIDrKzr9QZDOsB0hp6OWjE6eEhCg1
	 NQPlMIPUl2e7rXIWJ8D/XWb61h1nMYv6W/2E0H16dI/U9JaIYF5ANXQJXGNin0VQLqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aoE2KlTZ;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A3606A327
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 08:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E9A3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aoE2KlTZ
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a2af4c8d00so8262138c88.0
        for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 00:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795766499; x=1796371299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G5cm++BKjFrmGv1W0VY1iGSaZZ+nQ2gJAfMXfykemMY=;
        b=aoE2KlTZsOaqN/EKDD8LhhRvMHJHUrDgyfVz5jrv5SYa9u0HsYZuylI7Vl7jQQEYMZ
         tdW/I2/u+IuPcCNiN16K9wECxM5kKqya2nq0x2eKTNCov4Jz+VB6PSMo2yKm5pl0Kv7i
         cqQb+wn7UdSCvttjJLCudtu7dQgt9uEJFSHwxNdt70K1UVxK/dJa1vhhiBFXazv6vWM8
         Xp447FkML8miI0jA4DPkuBgGqLuwOIQM2vOBgLyZkLLlG4IL/l0UNNksKzmV5EwOfnlK
         7734bocIlbh92laV8ISUKLnlfl1cR9UY7kaoEQHy6NtLqK0JdN1u1if7cqiREir5/k+G
         HVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795766499; x=1796371299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5cm++BKjFrmGv1W0VY1iGSaZZ+nQ2gJAfMXfykemMY=;
        b=p5mDpRFM4ORpCeSKFaG9DLXUjMek0b5bNpnwXzxFsDMbUEoZHFGwepvX4c0gBM/f3p
         UFV+ETwt7RJq06OUkutL/QhI8UFR7d/1kGAT34SGo2mP11R6Oq/1R+NZpsc1ENWtDkqr
         XDBiMq7WYku9veR+ED2DTVgiJbbokzKVli0gYtQ66zwYE/You14U5iRmLhFzybzkZ3AO
         u2PHbjeKT2Gjdp5eYi3y04uWW/52W+9pSGoQZfJhTEZJSqd7TKZ7EFv3JP36UuRnDWHc
         Jj6m+9JosBtYO1N67uuLGWgm7k6/pSnNu6wFo0KmR1fY0tOOjEjaQF876k18DYsq+n8i
         hHQA==
X-Forwarded-Encrypted: i=1; AL+hErEgNPtqsGbibxQcCuhYYWg4v6JeAoqpCG1gYb7RIjXrsjtYrGkJGgEH1VI9CCZTlDWYG2O45bZ6fm87hfVyzRYTgnxJqr4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fTFO/jDPGJqK21QFO0dLFStWOCDRCNd/s+9O4im62fwSt5xwy
	LXBlggoq5uDLllqX8Sv0DOvfhdewQwZ9KZqEDponYUhj269PlNUvrXb+
X-Gm-Gg: AZFdTZf7d6EZkFMpeJp5lY6IUblCml7jnl3nGt8VKVf7SST/3fNKzN0htpN4/iwuUlr
	v5wUq2JyvbhuInPfhs6FmofS1mTBcshKZlGQEwdYtJKkkyFozVI1eLRZn28uNm+SuMZmuhDplmd
	1AwwMWCsdUBY+aFYcQMl549sCNvYDS/aDZdY1rjXxUyULqr2dS5+CmxqgIxXun1jinzLuvlUVHx
	9iTL40E5cpnpaoetVhWxOWBQxsVnJOorcSuBxuZnhggPqEdQhZvuyDLj72s+TlHZhGm31sIF+w7
	i/2WkGfS6mDWWI9oz2wgOOqHkTf7W/ShVgf7XDULHk5qkH9Qmf6rmX0PuSd49jHsxMj+AW7CxQy
	uamA0upIzsm+F+RXNBrDx7v25bQkaQicJ1KIXnLzjKwDIJlMDcc9ItmfmrPsVbBxcp+Wlw2Ows6
	0xFjH2J9eHdNd4fp32MMWCiE2hz5BUcU7YeCtr7L8BbWikObXU35y8XIqun1XkMXVZ0SeclpI2f
	yVF7s6WfY+OAFcgaQEHuMuVNOewQxYmrYMAMeAoPfsUH7dUp0AHEvbZjbN1hbhXcvTamMheeBO1
	HIKHfqGzAmYpS2b8mauCSxzYQKGG2+dh9Urk7jxubGrmaWE=
X-Received: by 2002:a05:7022:ed02:b0:149:50cb:2175 with SMTP id a92af1059eb24-1b5568fda53mr22332116c88.33.1795766498681;
        Fri, 27 Nov 2026 00:01:38 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm61827257c88.13.2026.11.27.00.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:01:38 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: return 0 from unpack_tag_headers() on success
Date: Fri, 27 Nov 2026 15:01:32 +0700
Message-Id: <20261127080132.266236-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unpack_tag_headers() returns int, where 0 means success and a negative
errno means failure, like unpack_strs_table() and unpack_tagsets() which
unpack_tags() calls next to it. On success it returns true, which is 1.

unpack_tags() tests the result with "if (error)", so a successfully
unpacked "hdrs" array is treated as a failure: unpack_tags() destroys the
tags, rewinds e->pos and returns 1. Its caller, unpack_pdb(), only checks
for "< 0", so it continues without the tags.

Return 0 on success.

Fixes: 3d28e2397af7 ("apparmor: add support loading per permission tagging")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 24fbce2e4322..b6864757e6dd 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -841,7 +841,7 @@ static int unpack_tag_headers(struct aa_ext *e, struct aa_tags_struct *tags)
 	tags->hdrs.size = size;
 	tags->hdrs.table = hdrs;
 	AA_DEBUG(DEBUG_UNPACK, "headers %ld size %d", (long) hdrs, size);
-	return true;
+	return 0;
 
 fail:
 	kfree_sensitive(hdrs);
-- 
2.25.1

