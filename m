Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601439;
	b=Ruyi/IdC7Y3AkOtuNwgS7wtc+Q4GSBB94+UxZsjlKY7Vqtw93sNWmEJYkvCm4C9emDjf
	 +4gCtPoVpgutqQPnWvFvWvpql8fHl9C90X7inp+g3h+6zVYgzE1uER12BjzU9YKT+lToR
	 /dnRn6jqR5ma1c/u07FUHjSXD02nRkHtfGTeQNUGNvk7MPFpfbRbxliXH21jbzDri3S6u
	 /PrufX2xR4dE0SYyi2PtZFP8Xkvr9OclElSK7R4KqohRvb8sW2CeIxwajZuiZOYOiNrb8
	 eQJNGj91uMHl6II7AOXkwGKwnG+gc86eSqChjjeg+cyrlYoaLUv773/EH3/pzdQqjpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=4jvEUnUJrd74/uF8JXphTJ/RHPybs0qTVGP2JvV6cQ4=;
	b=EaSq2UGazz7f6YPqWCXjunIqzCBBmcfo8UJCuoBpWCizlFwNq6eKxCb3aNT+gGIZfy4L
	 o5u3kw3xIcki33XQ7phxAPGQBAv2sudfdV9FHRB71EpHvLzA7OmjUKkMP7+z5PC3Bgrzb
	 +sBTcsAaVCB3FVoxzhnkJdcBXtwgrfyhWE8M3uqNHx795TFgxWF0EMqRlItY8dAH1cV+D
	 BxJepa+yO/00V7QOHfLLaBt0LiPq7g0WD2v7DXW4rhAzP2V59OPKFNmRJzk/JSx+I/DdU
	 2kVNAlmOumVgAOUd3/uha5DluKr+ZhBjaQ0XSYpJEm9XqA2W7CJsCl84Jh0I9bBWFvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Yga/QSqb";
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32A1606A88A
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F32A1606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yga/QSqb
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-491971ac844so1577587f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 12:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601437; x=1795206237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4jvEUnUJrd74/uF8JXphTJ/RHPybs0qTVGP2JvV6cQ4=;
        b=Yga/QSqbbsvIGtL60aI1kAe5OPZjPUAJxR18Z0gEJRPCeu7mHEpaqlir2hvikPClmJ
         VQ9aDqcjqM1tnBxEJ3nhAbq3m30/Qx4voX2Hg45lE7g2RqvnsWT5ZLk6UPC3+GEp+41X
         p3yM2sLV23WedO2RYYSoV3BE+pWZmHRVlvYz9Y6J8JE4bKuwPCObU2vss8dHVqnqrJOc
         UqRp6XH+jUjNgZBRvEEcK0qK5vZSgxbbk6/J7P/7HjViG+XiW5b2yyI3IIb4oUkCQ2QM
         B6w/EMth+rNtWJqIPtxw13cTDw0fPGmC/bOm9/sSiofCFI9IYQinQy4bkQsbtMsZDVG5
         pa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601437; x=1795206237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4jvEUnUJrd74/uF8JXphTJ/RHPybs0qTVGP2JvV6cQ4=;
        b=ZT/KaktVz+ZaLxI4PZEMla/zMpBkUczjAUvf2SCmwB0WuyVEI1a59foRtsvZA7YFsk
         aV5tfhE6C7mfj/4gGkFYlE66cTlKYD3F1UwJbfBFxNOfmfMYa1TMi68ep9J0nhzhWdcr
         R7IkLa9lRf/NZNimieHoNkRr1+gdR9JZEKuyPuoHA/Flw2Jw+5vZF6kLwcpd6Pi8w9eS
         I369XUf2yR83gtlgxQDArjJ1z7m2oGpyyHjIMZFFcU+jroL+J2RLDy3eW+GHckNixvsg
         rlf8RSGT2E8FvGo4oTHCymnKlZMduv0ST3lSP81RLcn0XwSxusVe0ImM2edQlBeADaiM
         xi+Q==
X-Forwarded-Encrypted: i=1; AL+hErE4oRxYXXR+N5/dLL5ind0r8MFJiwgI9zbv3bfTRfPLxZvty3r3TQMFb8xdLY0/4Y2Ahz6S6DfnBU/rnaSfrI9Rc/SISaY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TK/eeitWKwZHfJw24zlDRPRCLHs7tJQXOodN15PNVOCTVrv7M
	dLRA3XMw8D3k8Z3yVoab8o7MgO6kCQ7F+9NNwHIV1h4ePPIYfQfy/wuHwJYvWEVQ
X-Gm-Gg: AYBFou1JjvcFUX/h8bJ8cumniUleJywxGBEUasIkLtGc1lNCHDllX2oKfByEcA+GThd
	7VVV0gS9/yYmOB62LAsQDzkq66iFAg51d489bbCt7WcLa5HRVXo+tU378L9Fbv9HoFOiLgwiWIk
	KBJta4aJGavSIoQjmdDKZz2c3WcycTzW41E9wXTu8GnG3JRdowZR3ousGg3R5zEze8+AFoQ1W1b
	72hyvjx6hdg2hbu7sTZGpbvUdz6q0188XVbAC7XGBjTvWJJpJvKza57fx1NayDP8Mf5r4eJgYzj
	I6hNH5P8iJChNH4wTvQqBQGh4hEY2thxsmEyVu7s4mx0jtvZTjpqoZQzLUwecTLVYRnQbdBe94y
	sgXj6iRBFA+BPplQxRZcJX5KzYgh9eXz/KjaAiQz0wNFOpAyQvTtLTkrvtiQ/t2BPYM44d31BbX
	6yJ+6XCsWhQkk44Ph+09nHqIpx1eaVovt+JKVawTVvcatX6SN4bSoS5vPDMffwPXe/tuXYbqc8v
	jqVoUVaaMoR/RfAxS6ECYqqRw03RqhODx6C51fRj6MSSK4X1HeJa2AFkjAYw9ciXpfZMuekBnV2
	dci80nQ7qIqLrYlxllZpbTh+/MbxO8HegPf4naSu+hXVTgPOxiC58xNfa8eG4N5QG8yRgEdcs/E
	=
X-Received: by 2002:a05:6000:178e:b0:48d:f488:f32a with SMTP id ffacd0b85a97d-49c73a0550fmr8478003f8f.56.1794601437163;
        Fri, 13 Nov 2026 12:23:57 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8e794sm7424563f8f.59.2026.11.13.12.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:23:56 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Fri, 13 Nov 2026 21:23:24 +0100
Subject: [PATCH v3 2/5] landlock: Add KUnit test for
 landlock_get_fs_access_mask()
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
Message-Id: <20261113-b4-landlock-refer-nonfs-layer-v3-2-02d7e42bcdfd@gmail.com>
References: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
In-Reply-To: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
 Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

This checks that landlock_upgrade_handled_layer_config() and
landlock_get_fs_access_mask() together result in the right handled
access rights being reported by landlock_get_fs_access_mask():
LANDLOCK_ACCESS_FS_REFER is only implicit if any of the other
filesystem access rights are handled.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/domain.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 4c0b1f0e1db5..71756c68d08e 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -753,6 +753,49 @@ static void test_landlock_get_deny_masks(struct kunit *const test)
 					&layers1));
 }
 
+static void test_get_fs_access_mask(struct kunit *const test)
+{
+	static const struct {
+		struct layer_config config;
+		access_mask_t expected_fs;
+	} layers[] = {
+		{
+			.config.handled.net = LANDLOCK_ACCESS_NET_BIND_TCP,
+			.expected_fs = 0,
+		},
+		{
+			.config.handled.scope = LANDLOCK_SCOPE_SIGNAL,
+			.expected_fs = 0,
+		},
+		{
+			.config.handled.fs = LANDLOCK_ACCESS_FS_EXECUTE,
+			.expected_fs = LANDLOCK_ACCESS_FS_EXECUTE |
+				       LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			.config.handled.fs = LANDLOCK_ACCESS_FS_REFER,
+			.expected_fs = LANDLOCK_ACCESS_FS_REFER,
+		},
+	};
+	struct landlock_domain *domain;
+	size_t i;
+
+	domain = kunit_kzalloc(test,
+			       struct_size(domain, layers, ARRAY_SIZE(layers)),
+			       GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, domain);
+	domain->num_layers = ARRAY_SIZE(layers);
+
+	for (i = 0; i < ARRAY_SIZE(layers); i++)
+		domain->layers[i] =
+			landlock_upgrade_handled_layer_config(layers[i].config);
+
+	for (i = 0; i < ARRAY_SIZE(layers); i++)
+		KUNIT_EXPECT_EQ_MSG(test, layers[i].expected_fs,
+				    landlock_get_fs_access_mask(domain, i),
+				    "layer %zu", i);
+}
+
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
 
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
@@ -761,6 +804,7 @@ static struct kunit_case test_cases[] = {
 	/* clang-format off */
 	KUNIT_CASE(test_get_layer_deny_mask),
 	KUNIT_CASE(test_landlock_get_deny_masks),
+	KUNIT_CASE(test_get_fs_access_mask),
 	{}
 	/* clang-format on */
 };

-- 
2.56.1

