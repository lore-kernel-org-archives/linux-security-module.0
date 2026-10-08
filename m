Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AB3988E2
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469639; cv=none; b=LY/RZarKElINXcUNT6XB8Sv9TitRFUdRCHYwHJ9ASRsM7PxGTfxvei3oHbUx+QCf+Lst06werOnR+DYd6tuk5okjXP9HcWqh4JviAJut/iypGFAIjjqtAaEAQXotD6+iAPRy+4rtzzZ7LQa1O24R+ITOVldS/ZKAncAY7zw81Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469639; c=relaxed/simple;
	bh=UhDm4WNQwXw7aR1QB+LiX+TYoJuttlt2x/dLLT9hWvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M49AN8ki9KyRNlxOiOAtSMXh2gW1J4Y7K9J3wiAlFsNYw8vHGikqPLhaV/2B20W5wMiAVVFcxGMq26mFZAHGQocpZQFehO+/ZP1TfwnkJHqOetuHdzGFBq5TdlN4U0fcyb1o+A9Pk91Zf7XIJ5/3cit4YJymgVxBKnze1m7ZgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3DB4DGK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3DB4DGK"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso4999965e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469636; x=1792074436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CHrEYq9MgxAFLtaKHzrscJ3u+B/7wbhOLRSIihIY+ZY=;
        b=s3DB4DGKs7pX1+Mj1c+pexU6gX500tbugCO1Ah4S0IH9YFW4NSNK40++9jL1SVVzE+
         /AOkb/EJlCn8ks2dgjV83cPQ968cCp3B9CeTqNZv4+U1mhPg3WFJ6cp2UpzSmzbxHG23
         bxW2ryAYE7Phvmu8BsRC4UWBo1exeZNIRYgb8htnAj7g9bA6HkNc6We0fSQxTG4K7II7
         SkvPcFT9SHzI3hb6t+00lDPIjaaFv9oQMtsaJjndH54foLElPv9m9frzv52ca+YEj/04
         c/RYLUfQ8j5zoWisgMCdGObM+/vYMfvk3X0wc1PRkdVKuqyU1G4iEwyzgcvrTgnhIro9
         7f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469636; x=1792074436;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHrEYq9MgxAFLtaKHzrscJ3u+B/7wbhOLRSIihIY+ZY=;
        b=lZMsjucpfKBi8kpYAHlPCHDkfrOzwn4OXIe235ayau9zxKO9htiUKTBFjIIYCnTbll
         KmpMqA0InKIxF48b7CqqhPQlC1REAcEUMqNwFvOcCX2+zsDMg2mxXgGgssRTlq6GIOCD
         IDo4wt6sxDScRmR6KUY8NzXXZdymTUnl3mtCnU4Ri4RAW1mCODuOV2T5FTUXfcBZeRD9
         b2dXHq1FV8LVRjbbh9PWtm5Cgdh8YPTBISvwzFb55g6+5TkTbgXkEHVYiDz35mM6FKr9
         OY6Zvv2zguTKq21dRVAdpE3mnatydrmpRHkRayiN9h4+T3pUswxf1zjehiOsB5hvVsoB
         SqiQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+hMgwg3LqmJjxxU/0I7l2w1LQ9XLRpEluQSRTNijDXZQr5iIYxhkFcz9jIxl988mIbnhUmG+w3yRY/hjJkF+OlH0dp8c=@vger.kernel.org
X-Gm-Message-State: AFuF++mTocq7lMNl2WkRHECaJmXOu8yc/Z4RaDyGXvkRqGPGOZvUp3to
	wz4BTNr4jj9+AN4JQ5eN1Ves19afKWE5NSB5vD5rBJ2QwOYHaZtIUUUo
X-Gm-Gg: AYBFou0PQXpWX7155nLB0BYH2/H2LH6XBnCrJG3PQk1jKUG2ouKw4DXt+Kh8PkubEis
	a99twZUOVWhnRWbAXHmNE5XBN198H0CBzmB1vXdW3ef8xgDKYaiPAsaGk13xmR92SoxvQuj4Zcj
	mrCj9Q6ovnveuF5bJVHtcYsHBamsB7zDnG5Hl5nm9/ElnIIiFjooevSBNl4HgE3qnUOzb2N0BLN
	GmknN/gNVp482lNar6CBHZke13fBS6yLlCY/T/xL29L7HcvT9gf3AVqQrt0e+AZ39wXSS9PQogz
	IY2tRb0esVAxC8qrW+LAZ40ZXldPhpkbDXjN39WQXNpnzPRHhVz8kTJLI2TnSgTOTpolr473CeS
	An9FAHBdC1cs065cfDJkX1loi7SskGWe60f9Ld08tY1GaAd4uRNyjfy0uUfsj7WSq00PhQ8bIQe
	pnSosRGtcmMifpOXzabte+04N6OzAGYg7aiRnJau05JBlQbGMquOXRE5LeK42pErxFPmpyfzfs2
	VkPc0sLkYdraY3b8iGKp8A=
X-Received: by 2002:a05:600c:3111:b0:4a0:ec5:46d9 with SMTP id 5b1f17b1804b1-4a185160ba8mr53337635e9.0.1791469635592;
        Thu, 08 Oct 2026 07:27:15 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d113dasm11244781f8f.19.2026.10.08.07.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:15 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/27] selftests/landlock: Fix memory leak in audit_init_filter_exe()
Date: Thu,  8 Oct 2026 16:25:42 +0200
Message-ID: <20261008142604.39107-15-gnoack3000@gmail.com>
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

audit_init_filter_exe() does not free the buffer returned by realpath(3)
when the path is too long.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index d428ce802f49..1e533b4e26db 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -507,8 +507,10 @@ static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
 
 	/* No need for the terminating NULL byte. */
 	filter->exe_len = strlen(absolute_path);
-	if (filter->exe_len > sizeof(filter->exe))
+	if (filter->exe_len > sizeof(filter->exe)) {
+		free(absolute_path);
 		return -E2BIG;
+	}
 
 	memcpy(filter->exe, absolute_path, filter->exe_len);
 	free(absolute_path);
-- 
2.56.0

