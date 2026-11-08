Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169467;
	b=afioa4W5nzXUcCMHfkMJS4Jzhm9/HGBlN7iOR0tQ8EjwClN5l0sN6AS/0OANkG2qQxNf
	 J1FdpdDbHFmlpVLJOMroHp7qyJrfolLrswYlVnqgeaK0yYgdLVwASfu7hVTkxbpWQU8qC
	 kafAsGfvjk02mBEoUsZcvqnqK3maCwNKo+JMpC5qd4NjgG05XTRZJZRm8NYY3LhV9OjNG
	 vbnNfe1df7ZJUrdzn0Rqe3P29e+2byUlP5NKphrwQTOpbJIG+7NO4DHFQ8zXy3Mb9+l26
	 oBS9q9RXokc/Jx5K16iDl7XQ4FQLZsu6amC5lRWBntq5yJHbFQaqJYrw+ktCzzBjA6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=q0L5KoeSSJ9JnTFnKpazoYgvFNGkegOX+bYFdABwfpw=;
	b=O/geU/NNrag+rQ6mD210LeLmxD5J5Ny8yGlhijYDEbUUcjeEGe4w9ep6jsQk6Dw08rNM
	 bEOTaOShHH8RWS/6BTqwfsogF11nyUcBn1i2UEYNkvCrhDQRzedDIi1iNnrranRSTxSNE
	 NKYexdIPbKBcFqg+5LiZ6DZ+75lLjmJ523BJ+HK4ZOde7L1UzZEc98FIJDU22qvvi70HU
	 /ZtTbblnOJDeuGTV4+jfA8BaUNy4WprVAB34/GECrVghnWLag9iCqkon06GfrnYuyP3TL
	 cUnzWpDoy/TSrRi0diBC1rf7CHN7nwckM8rS4QEcleB7JCTXrgHnYq/DggJJpTbQxlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OcHNMHbe;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356D3607A77C
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 20:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 356D3607A77C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OcHNMHbe
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so2151785e9.0
        for <linux-security-module@vger.kernel.org>; Sun, 08 Nov 2026 12:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794169465; x=1794774265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q0L5KoeSSJ9JnTFnKpazoYgvFNGkegOX+bYFdABwfpw=;
        b=OcHNMHbe6+Tr5tBKj3Gx21HnsTCetKKcEAwi0Rw2V8sch6vR/a4C4Q8Q612oZhdRqJ
         N2b0PjiuTqdulkbxYXlm+LU/nj1FHo+cE6x1xsGSPg7diqZpRa2ZfPr6YpcOnNJRhW9r
         fiCZKxy0bzcDpqhU+9fsgtTevyNyR/YxIw1snxETcUqb6NHsydLgd9kaf2w0dmrOayS1
         Y2ev+T2O8QZh2vpgnAtekOkOhmSQMcEhZExKkupYfRTlVo4U1yI6wXJOR0uthiUY9MZ4
         2HVhWDhKoQs0eUfz2cT87I+XMeEAFqleexf/f1VZMnjnX/oLxZcIS5BLlw/0YkR830I6
         At9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794169465; x=1794774265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0L5KoeSSJ9JnTFnKpazoYgvFNGkegOX+bYFdABwfpw=;
        b=BA9Ko0zr9dArd4QzPsOAiVCev22MZiYpuZSGo6gfpAd/q4Cc3NauESI1A8esd/h1/f
         jSnh9MxNOAQsv8Oj25jFkESHoqfx+aZLQ3ezK4mMUUU/uZkVRRgANO4avcbWehkt0ge7
         N9wlYJjijssWsOyPc+/1vlitfDgDfYZdduvUzK2alZuONrHUucP/ZHqrSEzyilvI/3sd
         ODU1GhJLqvj4SqDYIDX/VjmzxvMdJpZGquU7YvBvDmlvmW9qCjQwryH2/Hqz+g5+mf8l
         u6qkd102b363sfG+Ny9ACbgHayPWxHl+qOQjvby4MjO+cUT350sWeEN7eRQlO3UD+6ZZ
         Aaxg==
X-Forwarded-Encrypted: i=1; AL+hErEcwG8nsPPEDpHW/2qxpO6roccxtP1zuuKSDLgv9Yma6j8L+xEUtxghC2r2y+A/hv0AlxP5h7IR2ccOTiKsnjh0XGtddt4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TJrsDNWqlz/TZ0NbEpWpYLNffkiiGj/RQq0eYhJkxWNV2IIWF
	mbQNQlROyudO0HL7sBpHmob8T64Cu0zBY3WJQRtv1VD5HfgZudR74Fa8
X-Gm-Gg: AYBFou1opnZpTamz0Z7lAd+6zQKCaOYOi4SAoVytVEtslQxjr0PQlMuZ1IKS7QZv8qN
	otktQInR0A2q2qdQm5VJ6qP+1TUmSMLBXjSHcOZ7PZoahH5Xmt4H8+pjfn72RXDN9pVzh/UpL2u
	nePHNHzFUsseLeEBwaO/6ikovXu3QU+Zs/qxWHDzi8mrRfr6AR52s2kNt/vJwrk5oU48n8KrEv6
	j/j+iy4nN0x5Q+0v+MUOmQ9NJVdFQjGPRUSeQvDFuSryft6nHPXaIF5G7cUL5btMdCGHRuBLE/g
	92Iai5F4uMh5bNISGvpV+sV6xTonlptAay2AjYze865EwwGf9/kLUnfrR6taCVDiRVRKfgchsOn
	hxM75Mb/QQuVNPAfdE8ItK9s/6VwXNaht2TLCjxQWJpes3LlixwWIMcc4f/64LG8sXIcSwmmy/h
	4YD/mXFaAvKIIvMxjZ7/Pi7nQobyFqWJf68wulKrjx4f7c9kxbKK/1s5CcpOS5dl1TkPnhq37lH
	ENWLtcN8VpQGJpQCUj1SB41+xlKHPOLZbekZ4noO94dymVa4VegYlUYnq7awiFcZXIJmxKSbOnZ
	uVjSZAU/FwwpoZViDNd2/O8RePJ/emt+XqKPH8c7KqidmcfYT8Zljg==
X-Received: by 2002:a05:600c:811b:b0:49f:e8bf:8f9b with SMTP id 5b1f17b1804b1-4b94d7632b5mr38260125e9.4.1794169465512;
        Sun, 08 Nov 2026 12:24:25 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90619bc91sm80029115e9.2.2026.11.08.12.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:24:25 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Sun, 08 Nov 2026 21:23:49 +0100
Subject: [PATCH v2 2/4] selftests/landlock: Test that layering does not
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
Message-Id: <20261108-b4-landlock-refer-nonfs-layer-v2-2-2b405fc1b3aa@gmail.com>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
In-Reply-To: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
 Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
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
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f725882fa4a7..b92cb988a39f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2612,6 +2612,45 @@ TEST_F_FORK(layout1, refer_denied_by_default4)
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

