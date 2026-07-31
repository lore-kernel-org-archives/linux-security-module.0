Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642B343CEDD
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512647; cv=none; b=V9FRG1G7eb4MpIbJrKKi2CaVahiH9UWFXZrrUpmTiuJjIBY2LD3HEt4oFUqh7TjCr3b0+RFy5ZEP5rbQgpT3/GH9yYluk9D2XvG8Vk3FiNTnYu1JDM4AITyCiCn7xjmw6Ypm9RemgEC9S0nmX5GC7OgMXDIBtMh4SuDw6qSyKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512647; c=relaxed/simple;
	bh=0YF7Kd1EHvXNoQ1GXrjoa9wl2h7XBNeZTqRHymvGl90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T98DcB0Evlhvz1Eeq5kyjqlC3vIh5RWGOeCTP/JBWTx8eKr7abo+LWml0sBcEYiSldC+SgwV3tSGvQEi/a8G0+zU/ciUTeEZbUCzKnafD0filQB7HtsmD4x+5PFHurhD4V2AITMk1xJNgsyCwy5v9xLLbHLhsOVEDsls1JoXWZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=alo1S5aM; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="alo1S5aM"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15d4224f9dso91353466b.3
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785512644; x=1786117444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Rcj0uqe4vU7QJQl2I4D1fOP+no9LKYqILzou+a9fRY0=;
        b=alo1S5aM37gSwTj6HvPCvSw/MUCkXZslpQ8/C15xGMW47tmDzz+CEJC64hc5iBiFnh
         500i5u4QsliMN03EofDtiBjpFgXTjM6bjlb4mzcYtDoWFsl0CJRWz5IFjM/flrfrbeYt
         h+FRgL9VccVtLwVdVh0deCXpGg4hDU/6GlhasRzh9hzUZqM6GHNWTJu2IPBYmwZEcD2f
         HScS2UKMESh0Fdvn5e6tBuG1Ez/dU4bdwNJ2puReDBN7uE37u2iW/4/a1QFcyf+HOOMW
         +0USud1yl8BuJq9WNdqKua4HVu7D7DmD5K9xKmVIOHVPX6W4iXpFdT7Sx+MEqoNeQ5Rb
         WCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512644; x=1786117444;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rcj0uqe4vU7QJQl2I4D1fOP+no9LKYqILzou+a9fRY0=;
        b=YrhH6zxHmbkot9XafwP1UkkwS2x9IvrYeOYazjj+XNUjKXVF686NvpiPUKabc6cVqV
         tw5abY/j7M3cnHBFFdW0B3sHhHfWJDuSaMKeV/BjQKrcFbBLreV3EayZN3bRrKM8Gwcc
         81DZDTwbC6RJ1NH7qnMFwOLMAeEm9DQJE0w/Hbu+3/x1EjcCeAdqmtWyC/ltIvD9LyXn
         Gr6jpk/jgususaWHxIfBN3Ow59Ju5nDeg80l3bf31qWic4kOOZaYOWwwaUT4V91KXC3j
         G2EXusQZpCCREx13GuIpT3YI85UMH0Kv4SiqYZGBHqEBiQEeCrqo4jY9sqVKP7yOXM3C
         cu6Q==
X-Gm-Message-State: AOJu0Yw8udZsUaggzWNUmJ0BBNQDhgWxnNRmNrHIE5XWHSUfNmYnRkfo
	uZPvR3Lf792wM5AnArt3kIWWDfOX/10EBt5fZ90o8aSjO/AjgBADIRbPTff8nfzWbYQUS5tVI6D
	hORbL0g==
X-Received: from wrmp3.prod.google.com ([2002:adf:e603:0:b0:47f:6c7e:fa04])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:960e:b0:c12:12b7:84de
 with SMTP id a640c23a62f3a-c1fe81068bcmr11445266b.17.1785512644290; Fri, 31
 Jul 2026 08:44:04 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:43:49 +0200
In-Reply-To: <20260731154353.1790268-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731154353.1790268-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731154353.1790268-2-gnoack@google.com>
Subject: [PATCH v5 1/5] selftests/landlock: Use an actual chardev for
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
2.55.0.508.g3f0d502094-goog

