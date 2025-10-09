Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC92D6E58
	for <linux-security-module@vger.kernel.org>; Thu,  9 Oct 2025 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008886; cv=none; b=TbLw74bMNkKDyGKS+isMU7+GLWHrrMqMv2GEM7x7vQXoOkunuBtZ4FFLMY++dJCygi4xhgTsgEfzy1cL+Wc1rBRZsKTUdCLB9nzSmojOYskH1iD5ym5AFph0mdKFW6ed38CHK9w1LalwTCwbuy4CzwKTQ8/RUV3ppFpx76tkaBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008886; c=relaxed/simple;
	bh=rC3SodaA/M9mz/H4DzKiXnOCoIPedmcHNAWPpkYqsxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pfjrswzzXq9CV691mX9Lvi4qEtpm5//7dfhv9xL2EaKvjd158TyQVJ82DMQ+rIHtM53qle7NbrNq4XwUkvajEDJ+ybPaZrx+ZfLZGdLb2/WBHIAyzzfpSvkcnI8oiHPMCpCFmppZQ85yzQI0oiJ2LkFsxsl8t44Rbyv5BNStwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa7aai7b; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa7aai7b"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso812000b3a.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 Oct 2025 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760008884; x=1760613684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VO8SKvoV0MfIaQcTVSAq8u/FTUT1z6zd3ZxIoxWA74E=;
        b=Wa7aai7bCeFKG3Luc7wgztqjDL+ECjIf/XkBZb/GjXUxiS8u88EHska3lZKZMh+Lcm
         O2qoeUF9vp8DYHIpOcfaqOPNqWfHOpORPXMsybD9DMDmqyuzn/9ypgzpmCD3MJW1FN9P
         P6mCL9CRSYodLSOtb7iA1Eho5wGUiB/MdVnvGPBLMiSAhVg7h8zp7ksSYtYP6YxWAqa2
         SU4qOlT7bB1Gl3JSkvIRZ0wezRXgRzR+9Uoh8AsZJ51dFmGmhPNPHzqkJBd5/0/dXgio
         BUV2Ksj2ODpZPxASByxynjrQ7LGWOG84vHOL8bVeQ3pgGzn98OQ0hSXZ41J/LzsCNiDZ
         FC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760008884; x=1760613684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VO8SKvoV0MfIaQcTVSAq8u/FTUT1z6zd3ZxIoxWA74E=;
        b=O5K0bXBdHQbZcTYcZdsORvkMKqMamsmbMBTgZQmAWNO/0d9Ij7g9QPIdjmqOUTGCwx
         KSDfpcsDs1kWAmsmCqxXteZXWvBsAawTdZMLmrQdpNNfxiJDSUx2r5OkoEKv1A7YrPTk
         n4wp2hf9kT7mki2pfjKUhh9vQD3WbOVK+00iFGlQkBkRrFpWD7s/jhWpul975iMKmREE
         ZISMW3FKPj4PB8Im/yDDsWtTWwEeHH7SRr5BxQnas/Sv+IyUvN1dTnkwygFwJKBMogzw
         p2LfrU0t9nYuLaUDJmcnl0MUVwc2wx4mztxiVLDXICxQ2n70y6SmIEG9VBNRpdBA3fZ3
         EXrA==
X-Gm-Message-State: AOJu0Yx27ZymD9MdOsIecfJXiLpzrQYvkcMJA4sBy37nezJM+o5iHY1Q
	Q1Nv47QGSuBTK4L31RveI6jORzSbBzR/bm9owpLWVoWnVCB1WNg//D8T
X-Gm-Gg: ASbGncumFdbORkOOBk5F+jMW5WGc4uq7HDRS6RLgwpt2cAW5LKJsPC8fQBvL2uUNMx5
	uawWF6cqnNjlb9+SGPYDcswsEBHMy+CMJqL41IxBwLlFiU8hcbp6IuJDEba2EKgZgoisCER4cSb
	AQTyXX+AelZ8IGN4GaphP8qJ0nY5d+TfQPZ4bOtUvqvV4L2qjcZwrd5E2XZR9CqFFtwJh1Teb6V
	eBCaIxTNKfrhhQmPiwQflvQLV1p3XL4XQv03EYslX7rzWcFNPL2Ea3NsHLEbtrV4veJJo5nqGV7
	Nt8lpElkuXRwNZln2/pbewI4AR0rBYfkQHWzK3W4OfHQb6otxnNQ6zyPE8xK55oYm4mmQJnh105
	DfmmUCtM/hHwBHLVNZDJ9Hwv+uHfi
X-Google-Smtp-Source: AGHT+IE+3elAzuUoBsMXH83emv2hz1iBTQWPEfVgKB6cy6cCNbyfaqhi5O90RkMxWr9ccb+clNTj3g==
X-Received: by 2002:a05:6a00:891:b0:781:6ce1:998c with SMTP id d2e1a72fcca58-79387c1ae7bmr7146498b3a.30.1760008884432;
        Thu, 09 Oct 2025 04:21:24 -0700 (PDT)
Received: from ASUS ([2a09:bac1:5b40:28::3c4:7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e33f0495sm2619758b3a.76.2025.10.09.04.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 04:21:23 -0700 (PDT)
From: Taimoor Zaeem <taimoorzaeem@gmail.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	Taimoor Zaeem <taimoorzaeem@gmail.com>
Subject: [PATCH] security: smack: fix indentation in smack_access.c
Date: Thu,  9 Oct 2025 16:20:55 +0500
Message-ID: <20251009112055.142440-1-taimoorzaeem@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace spaces in code indent with tab character.

Signed-off-by: Taimoor Zaeem <taimoorzaeem@gmail.com>
---
 security/smack/smack_access.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 2e4a0cb22782..3cc0e00ca1ae 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -392,7 +392,7 @@ void smack_log(char *subject_label, char *object_label, int request,
 }
 #else /* #ifdef CONFIG_AUDIT */
 void smack_log(char *subject_label, char *object_label, int request,
-               int result, struct smk_audit_info *ad)
+	int result, struct smk_audit_info *ad)
 {
 }
 #endif
-- 
2.51.0

