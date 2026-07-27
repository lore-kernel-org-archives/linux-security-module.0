Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8677442901B
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 23:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193729; cv=none; b=cdOpEV7E/JkNTikzWEUIhmyOoRtDLEYtn+AFn50M6DazGMI94tl2lL62VmxjoBVHkf6i+9l5s7Z+/g/OewRbgdz7hPvQXU65mpkcdSNjct4Eo1Pz3pDbwCFCcUC3RCaHB2X/RnvMVYm6wtY8TPRMJOn35G5mSequbZVeJ8n6Kuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193729; c=relaxed/simple;
	bh=9OzfBB6fq3+FkUEK+HTYHqPle2N3b7d/LwOM77nItTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5awPD/SQWDJGO9mKM/wI82v2WNeY/XzQIrO5yVJNWG/W33cfIqLg6IIYfHzO1jECGYRhK+dQzu3Fxd0RDxdrb/4CB4KBpZ45nq6z7hCVcU9/cUdHRLHXwZS8V7qcBeQRI6rfVbuo9j2ldpWa/CNOWD/mZqTtQBz/TNgz2AUpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9ab4QEm; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9ab4QEm"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81ed000b507so25767377b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 16:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785193726; x=1785798526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kMVJlMZ5aiYr17VZ8/g7qzvf1FPYL/KyBw/hvOfyKtg=;
        b=S9ab4QEmN6j1sV4kNZB28qXfDBrBBHpNp1FgcBvtCJ+8DnVYfmcFjWzgYpfOZPD5iG
         zeck6GkahqX9T+62nOmiWPcIqKG4+yHWq9En77Lj86FbYWArrYP0vUPYKIJuciu2jmnz
         3R5O3p/pYen9jpc9GOn6ma9fOcj87chXV4mOmbLk0tJNd2qK+75y0MRN2/Dm6Ox0Ajae
         einnn6kjMPok1fj6BlUdFCEsww5T+y6JLB5cFiCX3//i1QEmI7A/4e/9HpsORex1ghAQ
         +pT4hXVyD3WOKoEH6/I3PzGDHefTD5NRYLcsdoKOoEW1ThjS5sdyRNpVRxyXGpMYM6d8
         iWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785193726; x=1785798526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kMVJlMZ5aiYr17VZ8/g7qzvf1FPYL/KyBw/hvOfyKtg=;
        b=MI111ML1xBrQ6bwkonPrKF5RCg4q4Oo0FCR/hx64RdpRIuhsRDUfJVTcIE+9wO373+
         Gi4c+ZO31aeehSvbjqUIF3oU9hckcQZuoIeahI3EfEKouDWLqmM6TXNV5QMFXJhbP5Rp
         HB5HmKwXq2UIf/jtCixUO+m6uBwIf1pwZtzruAx15vpAIWoN9N/KodP8nmucym5tTJih
         xnjkGnnhxxtX+Au6kt8/X7Y9YEz5HFWDjAkG3Sv8IyOUCDTlJMNKsY1n1zuXYNvHonBO
         EzdRItbaVP0LO1lcDLwP7C0LhbblXx6Qo4a6v6Xc6K58a22JF9OQl/VbdC8O5rqeYrLE
         aUlw==
X-Forwarded-Encrypted: i=1; AHgh+RoC8Rz+mOcuek1XNGWjUv5O81OjMuOLdWCJ37L4dfPirGhCEG4FE9pNKd2r+qb7BbknNF9qpmPMeJLuq/YllWRRaeZTYQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSK2pfpQudB2eyBk0jb3ZfmtnRPi9y+SGFzWuU1Pf6ctYorYxe
	HZRGeEkgDR98hb1TUpBkFLNMSdKIEt2cPo0TQOKsIKsgMbC5lKk3J78Z
X-Gm-Gg: AR+sD13YIY0M6qzJt/ApVy7hfafO11WaadGg5dPrUCNuNEKjqFkv20FQs5zUU4ksmhG
	BQL+ZFE5UTE/Cy03rL8PSLnFkjnzGiIga4+DHQTuZdBY7jMEnT4kBS9HE00NGH/z4mR+xeeUaDc
	n23zbLdEyqhrPR0/K09T+QnlvC+u5fuhZkuCFvCcKmqP0McEGeDDzv5ss4WyangUwJzTZ2FRlbU
	Rtcq8QofF+2IFS5F9meSCbyK6pAPH/AnUdBoQG1HBgzhBIBkOtp0t26U8rtsEHiM0X5kkzMYJsX
	ZKBycXfHZoOZtdTKiWhcisDtaotyQU6+BuJVZdzWBdEQeF79IuCDB8TPwn+NhQEE6+Se6FcmFgR
	Qc2Hcg9OSZgWmGHs/Hggv/emxK0laeJqUihJ2SlBI94iavlkjnMRtrkT1CCeqtOLZvA9TlJt1rd
	I8f5ttPZHWbcSDXQRf1+rBUtagQdCyiztHIYoT
X-Received: by 2002:a05:690c:3685:b0:81e:4e5d:484a with SMTP id 00721157ae682-81f69cdcbabmr38242427b3.2.1785193726487;
        Mon, 27 Jul 2026 16:08:46 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:732e:7f3e:f365:cf9a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65931411sm38644837b3.44.2026.07.27.16.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:08:46 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 3/6] landlock: Bump ABI for LANDLOCK_SCOPE_SYSV_MSG_QUEUE
Date: Mon, 27 Jul 2026 19:08:30 -0400
Message-ID: <20260727230833.138165-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727230833.138165-1-utilityemal77@gmail.com>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bump the ABI version for Landlock SysV message queue scoping.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/syscalls.c                 | 2 +-
 tools/testing/selftests/landlock/base_test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 36b02892c62f..84521a31bf75 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -169,7 +169,7 @@ static const struct file_operations ruleset_fops = {
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 10;
+const int landlock_abi_version = 11;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index cbd3c1669951..b8b5fa1042ba 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(11, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
-- 
2.54.0

