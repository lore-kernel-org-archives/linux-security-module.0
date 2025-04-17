Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABE19CC05
	for <linux-security-module@vger.kernel.org>; Thu, 17 Apr 2025 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849224; cv=none; b=NnwXnB1nEIAZO4JVAn+uMYIo0hfAl9IHPpmfCfqB7dJdWl7ed30xL+UAbZq2F/UbJ7xiZr60EJvcbe0fBAch8HzQ1/7OhDQF7zRHFl4JhlLLEsEw0KRqLxRW/pHTnWrhuHBw9ZcxweA5BRbY+QFWD+LybZIkyZ6hoxSJrYzN0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849224; c=relaxed/simple;
	bh=VP42e3JZfKvbDI0ooyfOHhztdSFzkob0S0fpP+PH/Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Encxy3XfB/1YUiHSB/ALDjAf5lSu+eqOCko9v2WBCMKV2gS4yokL6vWOkIyhJOpj8emAZMin7/77QVMgnJx0WWgzERU4E+94LUT26GeNCtggoMF4GsHB/sIsDXxXON4Mzftt1yrzFJtt/SiCNmUlo00sMLK199WZTq/hRgDY2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F4zrrPWI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F4zrrPWI"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33e4fdb8so2380265ad.2
        for <linux-security-module@vger.kernel.org>; Wed, 16 Apr 2025 17:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744849220; x=1745454020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d1zeenHo/WIdiHzlhPJ54CYp3ToWYLsArkbPVUXbsw=;
        b=F4zrrPWIcguk6SioFjSVXIiXyEy1gtu7ZE2ypRomNPScixTqH2uAXuJ9jTZf87VCmk
         Mh9p5vWCdxKR50xcZujHBmV1mC8RMhGpB6PBuX9zBON0wbo7Oa+J5Rbs2UzVH8zJnS1v
         MhTTbEvU9KnUTXI/4VTdZIJ1DjLslX+pb9z10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744849220; x=1745454020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9d1zeenHo/WIdiHzlhPJ54CYp3ToWYLsArkbPVUXbsw=;
        b=kzxcXFJ+4LNvwGdANENpT3xBfQG9n50qsxuxS69fWh8bFPWgqEoSrNf0RCNXNZtJk2
         aa03o/ONlawn4ZGx4cDt5zre6/vKj3U7TRQct/SIcAkoCG2Etn07sbXh/Ju6lS7nsneq
         nsADuk/TEm0NjvZ/XhES94Tsg7wVrfV1SrB2eg95o7bQRn9PTTlZGpRW58cldvIqLUfl
         VF3HuE8EMyp9ypGaDyQD+K3qN2IIkLwtOl2g+OrKMC+h/2rfTN0+QYVOBPEddcQ9cN01
         ccmWpyfR4DTwOt+vBJ1Cx9IEq1bnrF/uNiP//Vx0Ozi0vOi1oe+zZrD/rv7++gxyKyYZ
         L9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXdDLW/yTROlWLZYsK8Zpl5+LCGww7c+7g9/PFUJJwPcFt4N3Sm2p7PKT+6E4SttvnFGM8c1gGV5LeRxF3y4+8JX1xsCSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8H82yUNWv3CyW0rRz5i625CyFTw45qUzSgN44SJL8DFduUDp
	hdxZrKMMzEOQqqeC2Ar/G6pBEitfvwGSeAumLa9ZYgqs+WSRKqKBfuwjc4B2Ug==
X-Gm-Gg: ASbGnctiWf89jkIs76LoaRXT39q90huEnelwzrHODXmiV62fCMHjgPmANIDC5/7eDjq
	zpgqvl27zBDXulyMv8H8i843B4TlHJ8U2X2hGvaEOxquT0SP46DeL2mY2YAqQAjOOz0Uq7LaRqy
	fX2GVs9MOBxNsaJ+nVwCq7Kxyh1HR/8JE8wD9vCKbC5fYUHZ1uRjhlDQj3xt4xbaA40DN0y4v4d
	Kt1nn2oAuRShiuQd+RzodrZ5X0t30odNJnHtkdc9syH+p4eABOrr7jABSGkuNZg0+IHCe3HWhL7
	uvBZ6Iv0vVa8BmgC2OIlJSm1MfiLOTnfdxfVSQcIdvTYw4ckN9+61SUN/Msm8NLjiNsNm2CR1Zv
	d5tSlCZdVI3Ykx2GOEgLUvo1I+oT6+Qhi
X-Google-Smtp-Source: AGHT+IFzYIV/9mXR0m0O/AxlmrF16OfOBFQ+0jrJUZKzp7v11JEoGIiIxamuwnoqAODi21WwPq6gSg==
X-Received: by 2002:a17:903:19cf:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-22c3591883bmr62046785ad.29.1744849220600;
        Wed, 16 Apr 2025 17:20:20 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd87sm20719205ad.73.2025.04.16.17.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 17:20:20 -0700 (PDT)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	omosnace@redhat.com,
	shuah@kernel.org,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	tweek@google.com,
	paul@paul-moore.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH RESEND v17 3/3] binder: transaction report binder_features flag
Date: Wed, 16 Apr 2025 17:20:04 -0700
Message-ID: <20250417002005.2306284-4-dualli@chromium.org>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
In-Reply-To: <20250417002005.2306284-1-dualli@chromium.org>
References: <20250417002005.2306284-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

Add a flag to binder_features to indicate that the transaction report
feature via generic netlink is available.

Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binderfs.c                                | 8 ++++++++
 .../selftests/filesystems/binderfs/binderfs_test.c        | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 98da8c4eea59..bf9c3becca1e 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -59,6 +59,7 @@ struct binder_features {
 	bool oneway_spam_detection;
 	bool extended_error;
 	bool freeze_notification;
+	bool transaction_report;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -76,6 +77,7 @@ static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
 	.extended_error = true,
 	.freeze_notification = true,
+	.transaction_report = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -619,6 +621,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = binderfs_create_file(dir, "transaction_report",
+				      &binder_features_fops,
+				      &binder_features.transaction_report);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 81db85a5cc16..39a68078a79b 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -65,6 +65,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 		"oneway_spam_detection",
 		"extended_error",
 		"freeze_notification",
+		"transaction_report",
 	};
 
 	change_mountns(_metadata);
-- 
2.49.0.805.g082f7c87e0-goog

