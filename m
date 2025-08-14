Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51128312D
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212069; cv=none; b=CvDuXP/N0LO0BpTEhMViW/cmk7++X9eooQn404Z5zezfJ1ZX5NumsriAidnIKwH7Vii1IFu7uPzCm9klkMnh4aFnw8CB4AidEgHvRdLjgTzJT7usIfWIKc9a1lcL9S/vhyCwL4fPOSpFHLDoi8YaiD4VOCICaxYbwWYm1Adi8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212069; c=relaxed/simple;
	bh=HKF67OsLeT1myJnqi9Pxbz0WOcMY5KN76H+/4VbDStk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDNvl/gj/lUNb56S2+cButX1URPk9VZ657Zw3DGr/31rYI1CUyvzAEnOgAb3+ndAu7ln6tGx02ALcBafmyYugbvU87qXSuMauTJ1ieSZKy8VSYJ8iWRgIduTPTPUBeG/CBHnK3hO4UVuzFcYkRknWjdiWdUcFNeiofAKCeg7AYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UhEG+JXS; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UhEG+JXS"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70a927d4aaaso13465296d6.1
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212066; x=1755816866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0RgZUydMw7BqGwhxivjtden0TclXeRXnZzEmr97SIM=;
        b=UhEG+JXSJZm3pMmCgTBDtcfaQHZcYvD2ZES3k0HPMrEpDZNkNzMjwncLiPGR3/FIUD
         hlJp7U7bvRkixtJkZeRxlASAvWlOVYa+FDLKEPnNws0uQe8ikhDrD+8CI9X0GeffH8Ec
         It8csLRcUwnT0ocHn+fJymqGjizPJI4KMDQEtDa60FRPDbSsRgEfFGjiLKIhzbqX0ow7
         PwVuYszfiPbQsgHVE69LTEWAmEbv0LI3Ytg5fz6ZNsjkreP3G+WzIpzmEattm4HEzS8w
         PB5xBe1WRQXzY+ufXRW33HVNNxFDovUXrC7tOIQIiRHFZ/NTG2SkCnJzA+fbp98wLZZy
         w+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212066; x=1755816866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0RgZUydMw7BqGwhxivjtden0TclXeRXnZzEmr97SIM=;
        b=RNVMSbN6obB52C3khy2iDGYlYX1AChiyK7MWRAuJjy/6/ZMRdzxDLDSFrRJhfcRWqW
         xNDW460bZGnMof3wQGs+WCN2+k0OqBDLFL/K506F86izm2ENKrIwbQJdJglxNIn6HYjo
         ERKSC4KVwYR9Pt52u6jCu4zGyA7an+TZ6nomhdezmaLrRKlW4znqXL0DogVgeh+R2UgP
         8bqfNRb2Fo6sXgWnBTVU+vwrPgq+96Ddm1KBv7YRBN4PAQW5LnlaW+pEXLZe7u8yxt/v
         ljPZVyaI+4Gz2DAJh1trEBLmOluaf6DS7U1g8Blc/HEVQbWq2jJlkRvz9MOc683qe+ZY
         eWzA==
X-Gm-Message-State: AOJu0Yz+Ck/yktnkURCUaaOg0laynANGxqKryyM6PhR6UrugBc/SbCvI
	HDNMtF4fDTpFyI+4IGz/1OUaNhVwLgIbvN5+c6O4+vqxiprqEBWuHUosh1VDKJPUBFVLdOs4vN0
	3urs=
X-Gm-Gg: ASbGncsKJkjj5sbFW6Dm4WOqSef5EyBbYQDpO+7Wz+yEyrjj0n/WI3n0YiddLn4A/KW
	lEOACkAuP61ANb2d9tduvV5EXV2WIObQE/HAygHSIdLlg27TfJcyp9k3EtWCkRt8HlCHFuGAJn7
	ZutmJ/i3gaSl2lbbgjrivTLfZkQ4wSxAwzAug4VEJ2kfEjdcPrjMm4Rpx1JxgznzMRoiWNyX63h
	l2acYFPXm1ShOZNghhjAkt1yVKtbWCn8LCbt+9xeBJJktRXwV6dVYSQCy9ycrUVUARNUaal7U89
	sCU46tCVsLdtxigZYbRG5qKLHJiyAoUx+6M1CCx+Lw+vGuazR7PGSQl9eG4IrtBp7wO6w84jMXU
	ssla9mKAPPY/YeChzbvfm3GuTsNwaTZj+olNeKvO3LMH9xAon2h3m3NsPibFmRrfWX60=
X-Google-Smtp-Source: AGHT+IHh2BCGfCJjFaxhrZ6UEEVwCUY3ho0STniHHyk7SGBUx0PDnA6eNOmbxfA7FxP7oHlb2waXqg==
X-Received: by 2002:ad4:5d47:0:b0:709:ee6f:1488 with SMTP id 6a1803df08f44-70ba4748493mr9032146d6.6.1755212065892;
        Thu, 14 Aug 2025 15:54:25 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70af5b0877fsm19436466d6.39.2025.08.14.15.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:24 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v3 13/34] lsm: rename exists_ordered_lsm() to lsm_order_exists()
Date: Thu, 14 Aug 2025 18:50:22 -0400
Message-ID: <20250814225159.275901-49-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=paul@paul-moore.com; h=from:subject; bh=HKF67OsLeT1myJnqi9Pxbz0WOcMY5KN76H+/4VbDStk=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmi2U/3Rly9V4RLpMZZBjXhJ2cx+k41/pVuwn 2o2a8TT4uaJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5otgAKCRDqIPLalzeJ c5cxD/wOmfbUQfVVe+5soKKBDJgtVrsao4bUezJLejtAizCf6JW9qs7a5qCezwdNVHLv+4n72vA ErEezJn1hOOIopYmLHZEq4oao503iTWQr5CV057LD7BWNQFNxMBi9HFncYFJoWYz7ptGdWtKAWx O5vo28xFuowbBBdI+lOEiZLbCJfzmEbLN7L5JBmB0DlRXey59RqTnGu9lciNHnCQxPvRlWN5JI0 gMisrf8HLhKIgK9hT8MyxgK17ZGO0wiQeajefuxUfakCziZ8g9PK6MnKHAZ/egO8EeIMZ6on7dN KBAx7g6eJ5mdTf83zHxjAUV7g2miocATKtv+yzZOWpp5UqCFBwEONiEiZ1xGHgVyOHQ6Cx+l8Qe lymhf7bRTX1XfgyAtBSTsNbVB4+tNu5u1QttIWYMGkPrFAdWorfTvzjEPtl7RIJPvW7DhTUV9Yi 7WXWMHF/Npn1ynqcFqzdRZN0jsGZr9pDxo2bDVg4wPSq0mDayZEi9ccYXxZlXA+nh6Jp2t+oM3q H39g5Nkd1qFyCfUxelPp3/YiwNZQY6ZK3tcsPprCgMqK+dtG+WYMtO5wU68vGqaYzv2pL3u0HDg 07jnw82QnjBErldyC0kx7M/jwOWkH1NcoKNTYGXVabts4Uto7LCiBmAC/TLpkWAsD9xKnMfYX9+ tfIzumRTo/p9Vng==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Also add a header comment block to the function.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 2cfd72ade6fb..ec46ddb18e1e 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -108,8 +108,11 @@ static inline bool lsm_is_enabled(struct lsm_info *lsm)
 	return (lsm->enabled ? *lsm->enabled : false);
 }
 
-/* Is an LSM already listed in the ordered LSMs list? */
-static bool __init exists_ordered_lsm(struct lsm_info *lsm)
+/**
+ * lsm_order_exists - Determine if a LSM exists in the ordered list
+ * @lsm: LSM definition
+ */
+static bool __init lsm_order_exists(struct lsm_info *lsm)
 {
 	struct lsm_info **check;
 
@@ -126,7 +129,7 @@ static int last_lsm __initdata;
 static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 {
 	/* Ignore duplicate selections. */
-	if (exists_ordered_lsm(lsm))
+	if (lsm_order_exists(lsm))
 		return;
 
 	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
@@ -269,7 +272,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* Process "security=", if given. */
 	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
-			if (exists_ordered_lsm(lsm))
+			if (lsm_order_exists(lsm))
 				continue;
 			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
 				append_ordered_lsm(lsm, "security=");
@@ -284,7 +287,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 	/* Disable all LSMs not in the ordered list. */
 	lsm_for_each_raw(lsm) {
-		if (exists_ordered_lsm(lsm))
+		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-- 
2.50.1

