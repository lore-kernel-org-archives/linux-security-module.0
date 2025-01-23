Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F1817741;
	Thu, 23 Jan 2025 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660943; cv=none; b=Qyu13wCMrg5HC673HQp5iAYbRCPhle9QCWO0nxviduSMQCju0N9ox3mmDudfBweWezQ85pxpusz/VSzJ0yikEq9LTXRNb5XPGE9bKUL9Rv/EGF78fWQmVjBaIipKLslvtauO7d8K9IF2/o1onkR/B+Fm+UXglVUD/Ddk5fXOsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660943; c=relaxed/simple;
	bh=OrOPTNvmLG+uHtS85sFTmFwoGieO2DrjUFsaAHwJliU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QevHjH1au+izebtp1CxfPnWi+bTkltPLGwzu6v4USLAm9vwK716Teijv7Gv7OiXmVXK6u6gCe4BBXFze8mHJi34fOE85aDK992J60M69F7FfVhlEgTyNlNAjWKzVLJ7x/t3XdQxYZKyuu3HnvZTa5Ze8kKE1fJHHYJh9gDH3fMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=hXwE+o38; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="hXwE+o38"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso1974102a91.0;
        Thu, 23 Jan 2025 11:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737660941; x=1738265741;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4T+apJXEA7u5KQk5F9JrltDCYPHbJDoYl9ngyqeDPrI=;
        b=gXDUBZNPwXcNvkyfWyFT6rKiRIifaP7nSNUlBDxgyVdInhLktfQ8i3O1k71MVcVVN4
         gJ9CGjjeS8qKR0g+aOZqerhVyfGh0iZEHftMV1JB007JNk5kPFaACe6gYXrCalAJAaGd
         akZKIGojigJr8GiiTX9gkJFd8rogPAX5gW2OP0JRSJdJxbLEHaqpeOhyPo3wYo4T+3jM
         C2EM5YHFgpqTODcgKHbYPro0Gl8fQ6YPyFnwU8nU5ihP3c0dOBe5vDr/Yjdi7tJfvIE3
         mIsu+GntbE52n0UY/LqinopX5JFSf9F/bcHAG5mKxEp9VjR82I0H34UZ3v4Ju62z7QEx
         vuhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwbe/SBTg2LYZ3gZUZe7a5lajgp+w0YibWY1pbBCz/4RMUWCJYYkiYUoC631fyo96RQ+B3XAhEjF2adM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ifwyG+aruu4RTlJ+eEBDPuDOPofY8AZa9knQgs6rTDbXrYuE
	/3oi/CCv5zj76UO59vvUq4Fu4SKanVeH8m1JIw/DQmLnCUqPW5Ar
X-Gm-Gg: ASbGncukL6/eNOrkuQZW/7iofc3SqslUUIAWl32PgkgRptwdbSZqtUv6fJF/dIv3iMC
	l1rAB/BHc79QjWFWc0dZW6Ydqs6Z84+Fx8zVKbxB5YDf7noLnSJacR1pKtodpxKmp9VtoK15Sjc
	Qx0vhTdC02vi91sSF2hwCAlu01Ku7F5SEmpr2rtidekN0gj0SYSFFddwm9uS93U/eaVak3yfgKN
	abcZaE+wmm+jxeyvrt79zyrC3tx9h1mRorG2UCGwSJUw9MFipB9oPZInhxI8BV7OdAExcHLR7o=
X-Google-Smtp-Source: AGHT+IHyQ39QzlRsCkMxkJ0UN+1KdBMird1PTlFmYOfVxzo5F9nPeMdZMyXoMTiWPuLwzT6ubq8WQA==
X-Received: by 2002:a05:6a00:2355:b0:726:41e:b314 with SMTP id d2e1a72fcca58-72dafb9dc87mr40458736b3a.19.1737660940534;
        Thu, 23 Jan 2025 11:35:40 -0800 (PST)
Received: from mail.marliere.net ([2604:a880:4:1d0::7f5:6000])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c822sm313996b3a.138.2025.01.23.11.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:35:40 -0800 (PST)
From: Ricardo B. Marliere <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1737660937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4T+apJXEA7u5KQk5F9JrltDCYPHbJDoYl9ngyqeDPrI=;
	b=hXwE+o38ck6DYFsdDI97teXXMFxlp9/jd4BEmtiMPYpB5u7lvrciWVsUdlr84NScg8z7Mk
	1/+++TfRSEZyKmL33i4aNWYDO8Xg5gpQ+BVb2He3u43QP372D5EWsrW0b07Nw5d0zuDvXD
	G/BrYD2zQcDH7PD26/O1s0wHOUYJfCja1UtIY0bzEyo+18u7jk3sfRsnRz8B0Jzkc18Nds
	SUXo9Ee0v3LDm9RkicQo01DKaG26sck+DMWWJ8QpN0ok+/4ChotZXUPBi3tV1xVvLhDc2A
	BCHxqFMQVtY7QN8py5nj//ZCj6xwqgqqCYWMvGaKg23W8kzR9otTrDVVRtWS6g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] security: Constify sysctl tables
Date: Thu, 23 Jan 2025 16:33:33 -0300
Message-Id: <20250123-sysctl-kees-v1-0-533359e74d66@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI2ZkmcC/x3MTQqDMBBA4avIrDsYI9Kfq5QuYjIxQ8tYZqRYx
 Ls3dvkt3tvASJkMbs0GSh82nqWiOzUQS5CJkFM1eOcH1/ke7WtxeeGTyDCd48UNRP01ZqjFWyn
 z+r/dH9VjMMJRg8RyPI6mzbOi0Lq0JWgiYZlg33/WoK08hwAAAA==
X-Change-ID: 20250123-sysctl-kees-d7c805ee39cf
To: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <rbm@suse.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=621; i=rbm@suse.com;
 h=from:subject:message-id; bh=OrOPTNvmLG+uHtS85sFTmFwoGieO2DrjUFsaAHwJliU=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnkpoEAT45YdndsjcNgA9T6+Gj5xqfqELzrMc3j
 o0U3LTIcEOJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ5KaBAAKCRDJC4p8Y4ZY
 plNDD/94rjmgyh7eod2q7zFKVpVl2eGQdkNWbP/q6sIuHSKbaIUkRQP32+PBA3/mjNSJwPgaOT5
 L5yY2Xfw9uzljHIngxjAvFaS60TxFPR/iP+tavKb4+KIgQMHHTxxmVAjTDmZ5rGMmQ4JnRLy6/h
 8bWG2VPHIkFhXcwBEVEp/bF8QOKpuLXIRJrlcWHjECMfXwlXbrW4St7cd6v/HP+hajGCkNsBRL2
 fPYQU+NnNc+Il7oSgTXhC2xukxsA84bwjCp04NOkLEzKiykZVOzPkoSA2g23d+0/I8qFsBrazLT
 ywhzmYyVfMzs5rY0iUTT5O0ctV8dCItXMaXKVZ1Xw3aZdeprXJNzijtWdPLAAn5e3DGxQwJXMtz
 7oL17LAHLTkQcgmGDImi5MQvshrPcVS3hX9d/l/Yd7JS4ZLSnXtStk2L24uGjUW1N90VRWJmTLP
 hsV6UGcaFTpQuT09w6Wv2tkoQNrV9YFB/QSlnWnM0UzeuW4dCQpcd4KO3Ho53mWCmZA0uGNPvZA
 zTgl6TSOxo/IsH404UNvJquw92209y6zg6kzQ8MojVRsmna2rEkoz8kDJNIIWPCkTFr/9X5EnoZ
 mQWfZRUx/AJNzZJpc+1yddUF77lsxQRFPBGg8qQDUfaePQRSbMV0D7vi+pFRS95EUmu6BskRCYY
 SpzZABWwxfU/T8Q==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Hello,

Please consider pulling these small cleanup patches. They simply add
"const" to a couple of ctl_table structs within your subsystem.

Thank you,
-	Ricardo.

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
Ricardo B. Marliere (2):
      yama: Make sysctl table const
      LoadPin: Make sysctl table const

 security/loadpin/loadpin.c | 2 +-
 security/yama/yama_lsm.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: a9a5e0bdc5a77a7c662ad4be0ad661f0b0d5e99d
change-id: 20250123-sysctl-kees-d7c805ee39cf

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>

