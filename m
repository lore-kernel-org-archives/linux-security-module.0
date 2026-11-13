Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601440;
	b=Xbx1TjSupb3q2+cm+xDBum9NMyam1/i5oKAVox2du+dlabwrle/0l5ssWdVr4yLrYufX
	 0r+tJZkyo9pE9lHd8DvL8qlCc7vu82OZ3Fo4ZoPCf6ctoAqC80oyMjXZDlJn2viOo8quJ
	 spZykjinzM91SzZTYOgHjuUTIONxrUTaMFVi5Tte0JQhlspra0nsWqBvB4yMnFYCZCASb
	 ksAxMEHflsWU6Aud3vCn7B0BuTYJjZFEQ0w78Ak6qZ4QiZs1ScACpnEWsNaRoOEaxoHo+
	 kQAT4hhYNn66rRy76Wz4H4fuSggu8udv45T9sXsfhR3RqYIZVBNIisOyef7HFsw/+bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=u7Jx9B4XiDyCzWqvWYy2iq25I09vd8jKOKtiPXq+9CY=;
	b=u8lsHxKBLlLOyDKoEr9bMplm652PJVyfvG/X/2Bg1vQk2sj51KLIWJSOrYiTUPpHGdSA
	 H3mjIit/zdsCNSPS2NHeGgvV1+0VqKNGqmRDGelH31/uTMGGu3UHFLqf7ilPH5TTGAldF
	 3B6dAzXrrf6GzS8GjT4AEu9YaRmW3AvJLkK4oUNlJooNinO8DYIryE2OCKAT1lLpLjtUV
	 oww4yghGphc9oWcR/QUEYbp+MVlpZdTfRCUuGSdboGkqJmnJhLgB7KsvK3haZdKhAurtd
	 zIFW2xldd3qHE7lPdezbOxnfGUBnpSmsQkVGk7P2bVkmpHm3aMDuJ7o3pWfknaKEW5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpsjCMtm;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F66606A33D
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97F66606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpsjCMtm
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb606491faso1094355e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 12:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601439; x=1795206239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u7Jx9B4XiDyCzWqvWYy2iq25I09vd8jKOKtiPXq+9CY=;
        b=YpsjCMtmCYEgPWqV+30pK7N1ZmgaoyTqGauBzlwfhSeCNLAGr2JTsjyWcQwjkuerTf
         oOqJ7kKIeDc9RxClm6MskoSOOKlqrF+a6tAbWaxr2DQH+czdaqrPCJrqgS/uLRYPUNW9
         gDHVaqqcR/PGNSQ9ksVsLEl2AsFk4Aluv6F/s7lsfpncTSnPHdKriiLafjotRrTFqSoM
         /NAoNribSHaasKcrbhYO40bnHctgDriSDtrWTAaOnrzH99oYgWVz2nfRk4s/ZeveY2md
         UYRM+1ujFTkHSmf3BxiL5udVKNgpihild2wK5OeTyCdBnjxDd9YTvkiY/8HF+UVyywhL
         OsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601439; x=1795206239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u7Jx9B4XiDyCzWqvWYy2iq25I09vd8jKOKtiPXq+9CY=;
        b=aOTl2cjPTODGdhXvm+6G7c04Rnx4lUKeR5alCDnooQsCl51PsJgiU6KQFG8+EPneNr
         Ej45YLWvN7eFwy6ORysfQeaiSyRq+tB6LzZeOJuthxdlpAeyiLu8bKGLRnvL5589/rrN
         sBlAtrHuysNrORHiseCxnMAUfDW4z/twv+TzzCj5ds7bxZgXvlH+neRhFppKJRHaIxNo
         HjZUBtHn+CBoLOUjveDxfzrj3I2fGX0Ae5a+DrY2m8SEt3d+EwZKZUfAg4O6fOHyZadl
         fGtDCVujpoEsWgH0MoLhNmGEB5kbTxJ0myGq4JQHf0I1xFfuG9eR7KyPmI+R24gJfw9i
         djxA==
X-Forwarded-Encrypted: i=1; AL+hErH05WZsAX1fQgjQ89jkzYh1WkffiKzj5IhBD9z1PqkB1vviRGLeV4TljCo4HgBsU9QcMdTeTWN/345fYgBo1fgRi5KkPio=@vger.kernel.org
X-Gm-Message-State: APuU4Z//qXdg6CMeQv+OS9ItnRd3k6aO8TUZ0SXX7F2gmqmgaJWbMkes
	u3/l6Vmjpz4u3c3yQHIT4Cq3EZDC/15tb7euEQqmRAlOUAIDmJhqDtmv
X-Gm-Gg: AYBFou0Gax8haWl2kWR42ECNsoJRn4B+jXAcMuam1rbnXkm/W0GapObbS6zRQfc9jJg
	/EMv+BH7AOV3OcJazK2ZRBvdSmVECC+UU/mYz4raKQUKYaBOf5pJ0ufwODoP7fQ7ino1MBLOLu4
	iXvh9iiZvq0RT4pJRZu3MbCyawk1skgQQQy6NzlZylM81Y5wAW4JakKEDhVUaLLdfJddJkVRelu
	c6MTfIrxm4Q4Y1MqU1mBFu1/HlFt0Xa1B29AxznGN3uOpCoai4UNvPG5Gwal2scYr0X4A1jF0N4
	oh980PCOKjHtq2HmBSWykALx1DidBiE/D7xLNHZembpHDTlL0WMySF4P3yLDFPgiE2V5seZ4NCz
	ixpnkPkFGTI1sE289T3f/YzGMIdGAKA2Gt2ViA+3LLX111MfHLJBGrIbALUAWXH7HTH5aSvqSPN
	UTpgC5t0zkrs1DtzYXRPUphyfZfrhqORe75dobiohIEnkFHLx2ydYY3EqqEZoeyAD45IH2P4oGA
	EDeeNw9ht7yhUF7JhAlfgb2EMqYjHfBLESFJtBv114WMpJYLO9FkymtdagjTM6CQv6NQE1+k5zX
	0mMJlTl3oO+rZ/BdXSiIFZIMgckrhI4vmSBCC3HyxEJ2+WGcFRJOyA==
X-Received: by 2002:a7b:ce9a:0:b0:4a2:392:9de2 with SMTP id 5b1f17b1804b1-4bb55a911aemr55129645e9.28.1794601438992;
        Fri, 13 Nov 2026 12:23:58 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb566a4a2csm46505365e9.0.2026.11.13.12.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:23:58 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Fri, 13 Nov 2026 21:23:25 +0100
Subject: [PATCH v3 3/5] selftests/landlock: Test that layering does not
 break refer
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
Message-Id: <20261113-b4-landlock-refer-nonfs-layer-v3-3-02d7e42bcdfd@gmail.com>
References: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
In-Reply-To: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
 Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

Regression test to exercise that layered Landlock domains do not
accidentally deny the LANDLOCK_ACCESS_FS_REFER access right.  This
used to be the case when layering a non-filesystem ruleset with a
filesystem-enforcing ruleset.  In that case, REFER operations that
would have been allowed for the individual rulesets would get denied
when layering the same rulesets.

Link: https://github.com/landlock-lsm/linux/issues/67
Link: https://github.com/landlock-lsm/go-landlock/issues/66
Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 54 ++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f725882fa4a7..6d9baab0fae8 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2612,6 +2612,60 @@ TEST_F_FORK(layout1, refer_denied_by_default4)
 				layer_dir_s1d1_refer);
 }
 
+/*
+ * Regression test for layered domains: The two enforced Landlock layers both do
+ * not restrict the tested "refer" operations on their own, so they should also
+ * not restrict them when they are layered, regardless of the layer order.
+ */
+static void test_layering_does_not_break_refer(
+	struct __test_metadata *const _metadata,
+	const struct landlock_ruleset_attr *const non_fs_attr,
+	const bool non_fs_first)
+{
+	ASSERT_EQ(0, unlink(file1_s1d2));
+
+	if (non_fs_first)
+		drop_access_rights(_metadata, non_fs_attr);
+
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER, layer_dir_s1d1_refer);
+
+	if (!non_fs_first)
+		drop_access_rights(_metadata, non_fs_attr);
+
+	EXPECT_EQ(0, test_rename(file1_s1d1, file1_s1d2));
+	EXPECT_EQ(0, test_rename(file1_s1d2, file1_s1d1));
+	EXPECT_EQ(0, test_exchange(file2_s1d1, file2_s1d2));
+	EXPECT_EQ(0, test_exchange(file2_s1d2, file2_s1d1));
+}
+
+static const struct landlock_ruleset_attr net_attr = {
+	.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+};
+
+static const struct landlock_ruleset_attr scoped_attr = {
+	.scoped = LANDLOCK_SCOPE_SIGNAL,
+};
+
+TEST_F_FORK(layout1, layering_fs_then_net_does_not_break_refer)
+{
+	test_layering_does_not_break_refer(_metadata, &net_attr, false);
+}
+
+TEST_F_FORK(layout1, layering_net_then_fs_does_not_break_refer)
+{
+	test_layering_does_not_break_refer(_metadata, &net_attr, true);
+}
+
+TEST_F_FORK(layout1, layering_fs_then_scoped_does_not_break_refer)
+{
+	test_layering_does_not_break_refer(_metadata, &scoped_attr, false);
+}
+
+TEST_F_FORK(layout1, layering_scoped_then_fs_does_not_break_refer)
+{
+	test_layering_does_not_break_refer(_metadata, &scoped_attr, true);
+}
+
 /*
  * Tests walking through a denied root mount.
  */

-- 
2.56.1

