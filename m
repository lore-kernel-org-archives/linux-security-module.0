Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355904;
	b=iad+FfnXzdn2Z1vPGwhBeSbfNpILFSRQvo2SYt7SYgCOwOygU/6Lh4Eg2AN0ty3JeI+C
	 lYXglnlCcSZKMw17oEQ7zlLUmObd0MJbHTpKUnMM9ENbU7hyPRCXrr99BD0lmwCadHRy5
	 I7dQYvrSJnIphlP+O/2SGZR7ea2NK4KCs2hcno0NnBrPPNKWECzKC7qtqzTO9hlixmLe+
	 QOKkMEwYU9pFFPF8JSqsBh6TeK9EEFHPiDVAz4bYCPqFnyYYZD/iO6tlBv17eYTcmG7Cd
	 ndYhd6LtL6iaPpnHJMzJo0ROC03x/TnjqumP82zittwIYGbUAQ6h8TTJ2QJoGBeT6ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=HuBbZFfmsbv55VA2uPYkZzZXFL/PczYYekIANInBKXc=;
	b=tgZNjJtujY87kDAh4Afd6UGLF6pRoqTg8SpPU2YhU2LCs9wInjuzDhz756z5zG4U8YMT
	 vBfzwzbJTBGzNS4tvwUuctbPfn3/Q0R3hHqLpI0cac1JuLyh2NGeN8AMFFoDMaFfyQeuZ
	 srd8PZwb9t9Itl0rKVA0bOOQmHMm/kH5PsXTDgUWAudWcJwdXJhwaWW0EhTgfHCcpJe3F
	 zd2noTmi8tGJZpcAaXWbmJyYz25aIrPJhSAtTtxVdaWcBA4S9TONPhR6fmyP1fDgGs5JJ
	 9K9tAtGoIIB1HIEDkZjDDY/bjCipVonf9CsOXCB4lN70n+hA61HYqlu12wDAZEkG5zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WH0pUumP;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A7D606A33A
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 10:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5A7D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WH0pUumP
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so6307495e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793355902; x=1793960702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HuBbZFfmsbv55VA2uPYkZzZXFL/PczYYekIANInBKXc=;
        b=WH0pUumP62m2FpRN4el6/yxdfGNl6glm5dxHyT+PoslYBKWOtwcJZzUidXa1s9ElUq
         qn1+gtJ7p95+v3ARiB3mG6GmGabemikbRTCdSf1o1O4+HIOPPKJjggFWO+qISQ9gc3LR
         2d/yqhS2Kc+wtTOMgsKflInybDn50AEl2qGkstwRej3nPe/Tolo7I8opj7HH8t10966f
         qBAT0U8U1LWx80j5U58927Z68iCE39qwPzWmiONerj6wzT24q/w9E7mwq1zdWFQd5FVV
         z1skikCAaCh+iEXLa9Iz+0xv99Tx20Dg0J0NH+Z/T1cPSm4OEowrHSfTiM4z0CHIKU72
         wcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355902; x=1793960702;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HuBbZFfmsbv55VA2uPYkZzZXFL/PczYYekIANInBKXc=;
        b=GGC0F5njDIE+4fZEeUSbm3A6yNFlUJvcC/WLYfQRmDCcTqrFarCMlUv/PucWM5ujRZ
         j0l7HwOSq/OSODGSWwDdLWWWnW0mFXO9lj0NVUTI7plZncC2nKsdYQyTuChhWDh6ZvAz
         /37N9Q+/ADnXh/DslJLHp+mJqBb7ZmgGfUccVcT7YeetfxamBydvL84gVLR6trYIK12E
         64u1cTt9JAs1/0VZymREAW0SHapzIueiATQVDjIei6B+5/Rx9GbGMnmRqn/8s1TJrABZ
         yR38Xcg9jVWKVRa9vY7P+daFTcp5I3EYIfcgM1z0LbbbH3N85iN3vzG9YxgD1bywinSD
         DL9g==
X-Gm-Message-State: AFq9FYIA4gzRckn3s8HKBz/fws6NkWSK8MEQi7u3R/1au1ZbL4DbN9RH
	hBI5vPGgZnVwHT5/mJ/eLs1ibtNSCyMlNj4UQyKC0XPVXAsTMqkOcv/w
X-Gm-Gg: AYBFou3ALV2vWa/XF5jxIePwVKlO3TwcxBugujCrZJ4UYtibsTNOZOWsgqv3gYAKg+9
	knBFoT5CKk52+3UVqT8IsD6GN6P/dOP6TYI4kh3LBLWmGGUqg6PywsOsbBxGnsd/zyNUNg0H14t
	WKz+zdhEPwbuHnOCzMTVr4XO0IHghx0OtTAYU/FK44s1mY/5fbNfjpoYJedWpAuftpU3xUOhJv7
	OFCWrv5bllGgYS1CRYQsQvmBpVCl5fyyjBh/v8aloYKrBWGnR/T/lNCfiHnlxZAygD5F9OaZsn4
	AouYu4d9qYJSlvM35gNU9dTlv4p7gaxk4h/r67cQSAe0DBtAbsu7t+QQ2BnP11d+RLGNQ1C+wVx
	j1pqbLMAktSGuCVrsH7amufGLSAD1GYrMHSbRhWwjkkHdn2Ad5+pN/ma2koiyItuiBREh6LCBKO
	Qdh8abNmqnGQQbnVXz7PXqonbdHRjCbFezo7L+LuI/udDkWX7iUv4K1UyejrWAnGiHuPtsTm9ZO
	mfKTk8ZZZw18rD4XHILA76FCAlGkUrURm/jDlcMzku+0Vtrk5GjNk6BqRoXo72bHEPujqrvXdwj
	0ryKCYAZLVjQ9I1NAw6UIbIwXe1jMXXruZhdGJCJblLQG28bupCXLA==
X-Received: by 2002:a05:600c:19d3:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4ac1209eafcmr39549955e9.0.1793355902258;
        Fri, 30 Oct 2026 03:25:02 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm143295135e9.11.2026.10.30.03.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:25:02 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Dwi Siswanto <me@dw1.io>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] selftests/landlock: Test that layering does not break refer
Date: Fri, 30 Oct 2026 11:24:09 +0100
Message-ID: <20261030102411.12985-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030102411.12985-1-gnoack3000@gmail.com>
References: <20261030102411.12985-1-gnoack3000@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Regression test to exercise that layered Landlock domains do not
accidentally deny the LANDLOCK_ACCESS_FS_REFER access right.  This
used to be the case when layering a non-filesystem ruleset with a
filesystem-enforcing ruleset.  In that case, REFER operations that
would have been allowed for the individual rulesets would get denied
when layering the same rulesets.

Link: https://github.com/landlock-lsm/linux/issues/67
Link: https://github.com/landlock-lsm/go-landlock/issues/66
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 6e979cef884d..c319bcea1437 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2619,6 +2619,45 @@ TEST_F_FORK(layout1, refer_denied_by_default4)
 				layer_dir_s1d1_refer);
 }
 
+/*
+ * Regression test for layered domains: The two enforced Landlock layers both do
+ * not restrict the tested "refer" operations on their own, so they should also
+ * not restrict them when they are layered.
+ */
+static void test_layering_does_not_break_refer(
+	struct __test_metadata *const _metadata,
+	const struct landlock_ruleset_attr *const non_fs_attr)
+{
+	ASSERT_EQ(0, unlink(file1_s1d2));
+
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER, layer_dir_s1d1_refer);
+
+	drop_access_rights(_metadata, non_fs_attr);
+
+	EXPECT_EQ(0, test_rename(file1_s1d1, file1_s1d2));
+	EXPECT_EQ(0, test_rename(file1_s1d2, file1_s1d1));
+	EXPECT_EQ(0, test_exchange(file2_s1d1, file2_s1d2));
+	EXPECT_EQ(0, test_exchange(file2_s1d2, file2_s1d1));
+}
+
+TEST_F_FORK(layout1, layering_with_net_does_not_break_refer)
+{
+	const struct landlock_ruleset_attr attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+	};
+
+	test_layering_does_not_break_refer(_metadata, &attr);
+}
+
+TEST_F_FORK(layout1, layering_with_scoped_does_not_break_refer)
+{
+	const struct landlock_ruleset_attr attr = {
+		.scoped = LANDLOCK_SCOPE_SIGNAL,
+	};
+
+	test_layering_does_not_break_refer(_metadata, &attr);
+}
+
 /*
  * Tests walking through a denied root mount.
  */
-- 
2.56.0

