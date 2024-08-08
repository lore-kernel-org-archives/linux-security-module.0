Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C118E056;
	Thu,  8 Aug 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132777; cv=none; b=MC9aBcbLrJB84JexcUPi/8zJYNU/xRUNgdVrwfMk8SwgXt2yidBbekBE9ZcCL4zornztvgM5CZxbxbynphsMWkckTX5ZBzUG7fcFtysiAHISG8lMVkZRDZz6RTB3bZfVOeTVdWDHnuVWdjuRVATsTK7SIsLAij6Rofc39j91u8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132777; c=relaxed/simple;
	bh=qt2t5pX4tolQSOlVhWdQbwDyBRC9NG8bRoVDbqSaJaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjYjchXoojZH0ukLKpe7N96jXeHUgn+a9mxFlmVX2sNW64dZM5IGY/VCudNfgTGQtqd6BMkPwHBqpwCw+06E8U+5uwTpXLJMmIf30S5PS4TEGTsMn2yqDcLY9RXxJ2JE307MchCvFHWfuvOlxuL29hdxuARDubajgGK+38nP/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTWth43g; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTWth43g"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-710bdddb95cso787283b3a.3;
        Thu, 08 Aug 2024 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723132775; x=1723737575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2kUjHTbBqy9ZeAxHJojWr0iq+a17EATMPja0/Lfx1fo=;
        b=YTWth43g9Oy0VkuBvkSf1ic5xN/Q28z1HuA1Xw2s092R2YQTLIweOypmUtsyHz7bGv
         xkp5DoAI6Oo7MYjmU3VrG9K0gVuB20JC2UyDIx/5eoUJ0BobpssTcPGjkGdjtL0duxpw
         uwK6kA0sXacaYHVtPYo+6yQvZdzaVkg/HAtusmRaR/VL3vjcEzuVYUIzBduQNCc9mJUw
         /lWExDiH6x6fb3WIss+xdfM0Pjag8mxtIV4WpWiwR+4FPl3qdcvD/+4bnDJbjlaF8pZW
         wTlDf7yNumhVmJFnOkxTZWmZKsUFQG5uZnKhtwhVIxnJzTLmeX/dqhE5NeHC1h5vK3Uv
         /ipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723132775; x=1723737575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kUjHTbBqy9ZeAxHJojWr0iq+a17EATMPja0/Lfx1fo=;
        b=KrSbQk1iT4n3WHhDF3PegJQIWejnyItYi/+OTjou8JToBwTA2hwSqSlTs2qQq3ZKZu
         D88TeGUcPrhJUI6oP5qCiOhs+NVFdfbInEWSwU9V5hYXy15x4C8BQc+pXpkB8R35Gz2m
         DJVJ8WjU0vfhYIMq50GrlvzqisGupA/AknU+8OZuAysZIEV2s2Y6i5GRBKsMajb+hG9A
         xLPJr5s76+5Cr8WTlNObXckyHx4Q2Lu41mNBJ6JL51Zt2Jh3CAhWFAvRi4GTeArn0b+F
         Gh+mSAYXP3WzmK+sqemVuGW/wG68g99rd5dnfYud70JQeM7Pig0CycKIrKebWSV0PFhs
         GjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0uROrXP6tjX1NjwkhoBeW+9mr5cVBIGO7nWemVUhbDI3jNCQYROIX8pIi/Z9vYbpbRP/n5/Pz5SvyCJHv1IxnTiSzw7subIdOsmrm39bA4tz71N990Bs13S0VEoNroTG7M6PjheTpX4sk9DLt1d6a9G5A
X-Gm-Message-State: AOJu0YyIa7hDORU3WtJbd+uyvnW/IUIuGPeWSAioGWSrFgLmHIX0yG3t
	NbtLpFU79jQyhv4mwPXuQd5Ai3KtQNsPgcldsk8awK9j0ISfxCuc
X-Google-Smtp-Source: AGHT+IF26TxdY5EP8WiP7V6kZ8hbYlBiQ0hXvxyoqIa69Gvjfa7kAqBGwR4qbH+/xobCbCcK2vXOew==
X-Received: by 2002:a05:6a21:6da8:b0:1c4:87b9:7ef9 with SMTP id adf61e73a8af0-1c6fcfec8a4mr2814985637.42.1723132774440;
        Thu, 08 Aug 2024 08:59:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3a9e308sm3619406a91.9.2024.08.08.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:59:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Brendan Higgins <brendanhiggins@google.com>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH] apparmor: fix policy_unpack_test on big endian systems
Date: Thu,  8 Aug 2024 08:59:31 -0700
Message-ID: <20240808155931.1290349-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

policy_unpack_test fails on big endian systems because data byte order
is expected to be little endian but is generated in host byte order.
This results in test failures such as:

 # policy_unpack_test_unpack_array_with_null_name: EXPECTATION FAILED at security/apparmor/policy_unpack_test.c:150
    Expected array_size == (u16)16, but
        array_size == 4096 (0x1000)
        (u16)16 == 16 (0x10)
    # policy_unpack_test_unpack_array_with_null_name: pass:0 fail:1 skip:0 total:1
    not ok 3 policy_unpack_test_unpack_array_with_null_name
    # policy_unpack_test_unpack_array_with_name: EXPECTATION FAILED at security/apparmor/policy_unpack_test.c:164
    Expected array_size == (u16)16, but
        array_size == 4096 (0x1000)
        (u16)16 == 16 (0x10)
    # policy_unpack_test_unpack_array_with_name: pass:0 fail:1 skip:0 total:1

Add the missing endianness conversions when generating test data.

Fixes: 4d944bcd4e73 ("apparmor: add AppArmor KUnit tests for policy unpack")
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 security/apparmor/policy_unpack_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 874fcf97794e..c64733d6c98f 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -80,14 +80,14 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 	*(buf + 1) = strlen(TEST_U32_NAME) + 1;
 	strscpy(buf + 3, TEST_U32_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_U32_NAME) + 1) = AA_U32;
-	*((u32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = TEST_U32_DATA;
+	*((__le32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = cpu_to_le32(TEST_U32_DATA);
 
 	buf = e->start + TEST_NAMED_U64_BUF_OFFSET;
 	*buf = AA_NAME;
 	*(buf + 1) = strlen(TEST_U64_NAME) + 1;
 	strscpy(buf + 3, TEST_U64_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_U64_NAME) + 1) = AA_U64;
-	*((u64 *)(buf + 3 + strlen(TEST_U64_NAME) + 2)) = TEST_U64_DATA;
+	*((__le64 *)(buf + 3 + strlen(TEST_U64_NAME) + 2)) = cpu_to_le64(TEST_U64_DATA);
 
 	buf = e->start + TEST_NAMED_BLOB_BUF_OFFSET;
 	*buf = AA_NAME;
@@ -103,7 +103,7 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 	*(buf + 1) = strlen(TEST_ARRAY_NAME) + 1;
 	strscpy(buf + 3, TEST_ARRAY_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_ARRAY_NAME) + 1) = AA_ARRAY;
-	*((u16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = TEST_ARRAY_SIZE;
+	*((__le16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = cpu_to_le16(TEST_ARRAY_SIZE);
 
 	return e;
 }
-- 
2.45.2

