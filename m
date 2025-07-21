Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E5724677A
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140258; cv=none; b=qGYbyhL/1YMWkz7R3D5mKXSzfPDqjS79FiVDw9X+U0rNXnt5NBzX94dlIxNiimMEIJ9ChiL+mh+j5ufPPxD/dQ3faDXBx18DVKiuBzmjg5DykWd2hcJlcms9vBTRhqqNPHub9Gg5cMzxNh3Vv42KJFhPu27JP3f/zO9jUpNwOr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140258; c=relaxed/simple;
	bh=s8ajgUtPSxBTK34/D0YMgtbhZ/1foUt3kMyIZU+SVng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJt7R/bA9GIRQZ0H0h9U2o5HjuqDgv/Jpo9mZu6ZrQj1mjQsim2mNoWkeVDaHc79IxXIV03tHfYRPwCz/Hup8HrZb7mSzbO5yC9VMFwNz6Mxgku7iy70cwi90ZMl7Q2nlncz7jyrjOnmQXUtr3dFy3vq8seFmH3eERQb518JkVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MFlodj7h; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MFlodj7h"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fd0a91ae98so24867146d6.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140255; x=1753745055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PD5DGZEPiqCZ1vxQcnp+XZPHkrpuEfjcGw+lKSBcCZA=;
        b=MFlodj7h1llK5MYhfpInB+cJ/1n5gvDdJDpld8O0gQ4h9krJf0wGRkf0SllDiXLcfw
         /sVxBuEbZcJtbRKmW46ZXAGK/dTjNGo+hWu9kaSIQkCnwl+L7UhKvLBAhUhF4Unc7Spi
         bekUvQkbZyYWR7ROrg+EXpk2HV0ZcxgGMM/mTC2X3MQN2U84bnt49O6kJUrdoJ1eFdDQ
         V9gQbSEiO6IOol9RCY0nSgrW/Wp5BQkEBBO+nRTX0Qj+itm4HvpX6jhVNU1/K8EPAiY5
         oQ6EaMKUcqyY+Cqlblneoe3it56jKAzy8IJ8f7v+r8wQTPQD9NVB1bOpU55XrXthL1kW
         VRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140255; x=1753745055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PD5DGZEPiqCZ1vxQcnp+XZPHkrpuEfjcGw+lKSBcCZA=;
        b=llQXiG3Ztrx0ji3/+o+0nEVT3VwoOKIrSaDp2gQVzdJNdfxPkfqlzwkZRlTxdOSnBF
         j4AyoNtw2A5p/omiuwLBteq8cBNO2c4WPsSw1zzj6ROve1+klVYJqHUiGtIJ+st09vMZ
         qwM1GcO12DADuk4C/SzDOGnjLhBiR9EBQd79mdBBoDl18u52uMxb9nsubMMGk+Lw//CC
         s4ewWjoIfagOM3jO4W+Gc30UHQOLVBXs+nzQIPTBKR9iwgZ76+YLnEsikViqDyF1kUYE
         sizhmWpyqukeu+MO8cIPbGIPyZCpKi8/op0fMOZyn8Ahjpui/50SQiJpUKM+4XYkTgCK
         +mQw==
X-Gm-Message-State: AOJu0YwneEMntGCdBHY6vBqe7SAQI1t8hJzmDm/B2IOORf3CsI/q82Wj
	ltrY3/G6e9AwrpDBV6pT6C+1vfjndgmAVHv/LDYCdngZUulIhxKWdaKcBvS85idhaWGkqStGhJ4
	LO5A=
X-Gm-Gg: ASbGncttN6i0irivVDAwK3cxpNCD80CsIlc4iDi2Lfi9wWCOKDS8+M/VUbqc7IaRCjf
	38nXX0YYG8Hk6Re6VN+lawd7bwjKPX0OoqO3WUhA5kWRlvFFfkVZkWMbx0nZP/O746xw3jxBRJo
	TzuvlRCfDVjzMdJ+tVQ22BS5T82hUO8Bw71sMSj8dIjXk+weETsZcOOQzlW1EWDOZHXrutDGrYt
	TFG/XqQVWnMfxIs0xybULFtoHwQPvkuUy/1QglQqnkSCoI88MISaKgIR5atDrME1s2qduSuJdpI
	9hRXS8jUdiqb3Iw5cPeBRmi6/8B3jDUiuHSJpUwReb1owUfflOcIpuweFx3DRmz5VR1Zc3sACXj
	8NInAYQuBXCkEKEXL/qOww2t5VXFtngelpTvOizQdI1hZ8GykgzU6m/vRRf/9cdhLQ7I=
X-Google-Smtp-Source: AGHT+IFtF9pLRCzD9wTDfHj/BsxYJm/9dARApCvNXQSGJ08WEfZJYRhGrP+vVcnDQWv+BLRW+qXLZA==
X-Received: by 2002:a05:6214:19e2:b0:6fd:74d4:b6 with SMTP id 6a1803df08f44-704f6aa0301mr332315806d6.28.1753140255173;
        Mon, 21 Jul 2025 16:24:15 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051b921b86sm45418056d6.49.2025.07.21.16.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:14 -0700 (PDT)
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
Subject: [RFC PATCH v2 15/34] lsm: rename/rework ordered_lsm_parse() to lsm_order_parse()
Date: Mon, 21 Jul 2025 19:21:18 -0400
Message-ID: <20250721232142.77224-51-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4783; i=paul@paul-moore.com; h=from:subject; bh=s8ajgUtPSxBTK34/D0YMgtbhZ/1foUt3kMyIZU+SVng=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsu+K3X3GBLwLQOLO+7aqlOfI3tNg0C4Gvmiq NanPCbrBWGJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LvgAKCRDqIPLalzeJ c0CFD/9LkEItfBU/qx5q1+E2zhO2ZdvXyDYzvOFpqgAuDhipEaRPm2YbosuO9V0REN41pGe88AT C76pVx9mNkL9eoVzYBr6dcZ0lCkr6xi4+BcgQfJ+LjNWhvDBquyprbyQGNrfguBqyfIZHbN6EBy u3FcbgPmpNCjt064CWOTfPhPQGkbTX5qS+XK668K+jLOPnC4cEd57FZUiGHxUEDyzmfonqGjlaW ul/+iQjAjxzSS4WuuFD5eLANSKz6LddadkP7n2vNzDNTE3hEqbc0+eauC8vKjWFAFA/bMhIIk/l PKhBZaWae/sVqX1CrvWaGhFDkWvdeo9/yyJBZAVAqaJu9fl12EB5OB0EYg/+AGOv5iw8UkUtzBP nozQwUoJf5PuhN0f9/4502cP8Pw+BepAx8G9FLVhB8Z0cjH2QX2k+cBFoVB2l/jPmBXxm3q5RvQ qwTuzgFqkb6zZ/hnm5JErTI8ICx/GtfMQ5pkLmqrJiUeWn8soZdrpOctEbjTpyW4NDp594ye0FO Suww097DHyl2Jgm/AzemvMTrnK5Qv6CL5xaT6Ed+WYl2veLhiVntagNEHODfjGKjq9vd38NDtAM NmBTifj/dLfP1emfKc42Fv0+cc2/XRtUQ5733KoqiUft47AH1jEZkx3bGpByJTYNfVXu7eqLiFE hCqivUL0xWwzxjQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename ordered_lsm_parse() to lsm_order_parse() for the sake of
consistency with the other LSM initialization routines, and also
do some minor rework of the function.  Aside from some minor style
decisions, the majority of the rework involved shuffling the order
of the LSM_FLAG_LEGACY and LSM_ORDER_FIRST code so that the
LSM_FLAG_LEGACY checks are handled first; it is important to note
that this doesn't affect the order in which the LSMs are registered.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 82 ++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 8c632ab77da9..b1156f414491 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -225,83 +225,75 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-/* Populate ordered LSMs list from comma-separated LSM name list. */
-static void __init ordered_lsm_parse(const char *order, const char *origin)
+/**
+ * lsm_order_parse - Parse the comma delimited LSM list
+ * @list: LSM list
+ * @src: source of the list
+ */
+static void __init lsm_order_parse(const char *list, const char *src)
 {
 	struct lsm_info *lsm;
 	char *sep, *name, *next;
 
-	/* LSM_ORDER_FIRST is always first. */
-	lsm_for_each_raw(lsm) {
-		if (lsm->order == LSM_ORDER_FIRST)
-			lsm_order_append(lsm, "  first");
-	}
-
-	/* Process "security=", if given. */
+	/* Handle any Legacy LSM exclusions if one was specified. */
 	if (lsm_order_legacy) {
-		struct lsm_info *major;
-
 		/*
-		 * To match the original "security=" behavior, this
-		 * explicitly does NOT fallback to another Legacy Major
-		 * if the selected one was separately disabled: disable
-		 * all non-matching Legacy Major LSMs.
+		 * To match the original "security=" behavior, this explicitly
+		 * does NOT fallback to another Legacy Major if the selected
+		 * one was separately disabled: disable all non-matching
+		 * Legacy Major LSMs.
 		 */
-		lsm_for_each_raw(major) {
-			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			    strcmp(major->id->name, lsm_order_legacy) != 0) {
-				lsm_enabled_set(major, false);
+		lsm_for_each_raw(lsm) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			     strcmp(lsm->id->name, lsm_order_legacy)) {
+				lsm_enabled_set(lsm, false);
 				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   lsm_order_legacy, major->id->name);
+					   lsm_order_legacy, lsm->id->name);
 			}
 		}
 	}
 
-	sep = kstrdup(order, GFP_KERNEL);
+	/* LSM_ORDER_FIRST */
+	lsm_for_each_raw(lsm) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			lsm_order_append(lsm, "first");
+	}
+
+	/* Normal or "mutable" LSMs */
+	sep = kstrdup(list, GFP_KERNEL);
 	next = sep;
 	/* Walk the list, looking for matching LSMs. */
 	while ((name = strsep(&next, ",")) != NULL) {
-		bool found = false;
-
 		lsm_for_each_raw(lsm) {
-			if (strcmp(lsm->id->name, name) == 0) {
-				if (lsm->order == LSM_ORDER_MUTABLE)
-					lsm_order_append(lsm, origin);
-				found = true;
-			}
+			if (!strcmp(lsm->id->name, name) &&
+			    lsm->order == LSM_ORDER_MUTABLE)
+				lsm_order_append(lsm, src);
 		}
-
-		if (!found)
-			init_debug("%s ignored: %s (not built into kernel)\n",
-				   origin, name);
 	}
+	kfree(sep);
 
-	/* Process "security=", if given. */
+	/* Legacy LSM if specified. */
 	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
-			if (lsm_order_exists(lsm))
-				continue;
-			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
-				lsm_order_append(lsm, "security=");
+			if (!strcmp(lsm->id->name, lsm_order_legacy))
+				lsm_order_append(lsm, src);
 		}
 	}
 
-	/* LSM_ORDER_LAST is always last. */
+	/* LSM_ORDER_LAST */
 	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_LAST)
-			lsm_order_append(lsm, "   last");
+			lsm_order_append(lsm, "last");
 	}
 
-	/* Disable all LSMs not in the ordered list. */
+	/* Disable all LSMs not previously enabled. */
 	lsm_for_each_raw(lsm) {
 		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-			   origin, lsm->id->name);
+			   src, lsm->id->name);
 	}
-
-	kfree(sep);
 }
 
 /**
@@ -319,9 +311,9 @@ static void __init lsm_init_ordered(void)
 				lsm_order_legacy, lsm_order_cmdline);
 			lsm_order_legacy = NULL;
 		}
-		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
+		lsm_order_parse(lsm_order_cmdline, "cmdline");
 	} else
-		ordered_lsm_parse(lsm_order_builtin, "builtin");
+		lsm_order_parse(lsm_order_builtin, "builtin");
 
 	lsm_order_for_each(lsm) {
 		lsm_prepare(*lsm);
-- 
2.50.1

