Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7EE30F924
	for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613533; cv=none; b=mosQj0C340jxJCSWnFizFfQWyINr+ZwfVNMiJz2pmQXm65xc1JNWc8hscPDMH+KyIcse2CCwBcamWGPlLN+svGifJqTD9jaUsyqf6mC8AayPdRvDqQLvF1NQczcIaNv2IUZrbGLQIpM1NEq3NTrJDiXJOoXULNr/phz4hZtaahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613533; c=relaxed/simple;
	bh=+jbpdZZnxylrfPNbAQZcEFMKuUGXyKwB4LtNa68XuOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qx6k/eZ54qL+4wuCIdDtEr4qUS6Mo4mbecHhBEkHsqu3EfazpYN5YwLhLnEfjWhCqTetzFUFQGZo74BtYGkGHgcvWsx3n6UNamuZAzQpDUsFi9QWx5K2JT1gN90hVF59LBHy1b6LXjS01QhuLTA92TpmXCPSgsaw57CKJbOzG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjNUQ5GE; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjNUQ5GE"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso17952265e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786613530; x=1787218330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Tpr9BgA1Tz4KtvRQ5tIV4ELRuG2SxWwjWO6MH+8Ct58=;
        b=PjNUQ5GEMAojfjE6XxXC2r8AQ+8zxvZGlZjR/oCxTw7/m131fpExkwYGm7V00ShcYS
         6iwf6HCHvWAyJf+1C5Y6k25hWLVkLmETdAAAmryw2ngFcDIhjQ3+7wLGqq+riN2gCins
         cNGzlqVrnNDXJqrM0oJyxzXQvv1C6POt/Al8xwd37P1pfHEEy/oHfH4p/kTlt6hieXKn
         9lrKbNqd0J4M1IGusOZ6ZPVTe5setkpS5mjJsZ0V+1ARZZPJ+bhZJ0dpsC22IjYgfDLZ
         B+GbQnznUjmblxMmk2/Ij9aaVBzq2cXHFBvEXZ20y3m/0nxmnTVGPRQI8PeJ5Jbxxlg0
         iMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613530; x=1787218330;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tpr9BgA1Tz4KtvRQ5tIV4ELRuG2SxWwjWO6MH+8Ct58=;
        b=etB5yG+i/hq/v3rDHe4n2SJ74NqeWxyQgeNgiIWYudA6Nf4yG15NPSj+3fqzAj9HeR
         zk9ukYbHL7iAX+iwvhTzEDZiSmdyqCeRC8d3oICRWV2xkEId8mKZMeVGmane+UiQTUDM
         vvQdUQQwZGAh1feazAUPRnl3B15rBP3nycNFkzAZKbG3F+S+pWfRhw3ALBPdqrVeH91C
         KhkIsOxOoXIjMkx4lT3hLxoR0CYOQdWeQGD7WCpH0cyl4hC018NUEbFWNTTFu/HwiUh3
         pMQgPBmursIt58Untzo1Xhvd+SSqZiRqsnyoCkuG5xj1OP47HqUWov8m3BnjjTx20okw
         Ynhw==
X-Gm-Message-State: AOJu0YxQ3XQij3+j3Clqq6phm+wEPf1MnrReZJmzNk+cX7CJVYEZN1oQ
	TqRQVBg77V8ZJZ4AOAqepFpQld8co/LYcciGGVa1X82fQnt7aob/09F174ebzOr+BmofgeEhf1b
	rkajtNw==
X-Received: from wmdp9.prod.google.com ([2002:a05:600c:5c9:b0:489:1b01:386f])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1993:b0:490:c6c2:52
 with SMTP id 5b1f17b1804b1-49982187725mr42651735e9.3.1786613529810; Thu, 13
 Aug 2026 02:32:09 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:31:52 +0200
In-Reply-To: <20260813093157.1436894-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813093157.1436894-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260813093157.1436894-2-gnoack@google.com>
Subject: [PATCH v6 1/6] selftests/landlock: Use an actual chardev for
 MAKE_CHAR audit test
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

By passing a (0, 0) device number, the audit test for
LANDLOCK_ACCESS_FS_MAKE_CHAR was accidentally creating a whiteout object
rather than a char device.  In preparation to treating whiteout objects
differently, use an actual character device instead.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 86e08aa6e0a7..e82b56a74c5f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7436,7 +7436,7 @@ TEST_F(audit_layout1, make_char)
=20
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
=20
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, 0));
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, makedev(7, 0)));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_char",
 				    dir_s1d3));
--=20
2.55.0.699.gb54405d56f-goog

