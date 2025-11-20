Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8564334C811
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677448; cv=none; b=LY1HA6Jw+6M5ChBR7hKf4iA/TCILCd24zk73RnJiRjS1H40yEAbgsPGYmyTAgi0fE3jQTEQ3W9tBbhTGVjHlu2fABFI1BZz/o2qYLEHugI0+21yAkfrmnPxyapYhQc1HQdSUnAYtSG+hCSGPxUMHWul9SR5xIduTnTLFoBikDU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677448; c=relaxed/simple;
	bh=iz9YMgP4N+cbRQdtk6q0XTOtdCFg/51B2rqe+13rRQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+ZVkUNINR+bf7HrEp48xAWetFs/PbdvFwKBYWNJV872KCLNCceofCc9BNoC2SxQ8K+Vi+DvQbgtAapWFYMMCGNl+Kihh3QKWv30pYywx4+PjEDw9piFcfdp+1/u5GxNECbvuJi/03U7OANSz50EPt0O/MdOaWzUlwR03VDaWeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTCh35Dl; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTCh35Dl"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-789524e6719so19842887b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 14:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763677443; x=1764282243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NciS2ikFl6u2GUPwa6tJUCwoUTqA9UOzQBDu265f5KY=;
        b=QTCh35DlkE4AcihdwgqBNvdaPqubtuoEypbgj6ZwILDMR6FYRu9yFlVYgiCsCGd4wo
         6BxBtLoB4UP+QkNMgikFaf+Tzaj9gpsotF2gPbESQ+A8Ye19fCqe12hvnCUaj4tyWE+z
         0Qx+dkYPjk+0FRWPlpVZ4OAwoVGkqpHLSW24N5iTWiO+lJ+a+6sleqBSVXvaQX0CYEZk
         B7fipe+qYHYIaLDHGlAtOJ/Pe3OYGyIPEshS1EF2fetPZeg6Q91z0ZLqYF6vRUxWDNIr
         SvOMl+7gzJ/3qRiZ688j6sQpx5XK4nTYEC4vq5ipAQ3T5LVna6BVncXlMy2UsLWhpmN8
         g2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763677443; x=1764282243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NciS2ikFl6u2GUPwa6tJUCwoUTqA9UOzQBDu265f5KY=;
        b=Q2PYx6V3/PMVIdnCCin5nUH8xbGmySUWO8uP3FlwPXMYUL8YTr4bDzSCq88QZdw3qi
         bozEBqBlVR5CTYF3MIOVWMRZPptw1DvomfTQyxNInKd2UYTJdNb4nolnZEnVZaPDepYc
         wPNNlBnWEUpL0W3TdffzSJymptiWi/Kih5yza+lPCKLR2jZsFzc1azBcq6TiQHT52c3D
         UJ126pmyIAHfHQ0KOt5McmHcNpMksJynpqR/YUBlcTd0OivHh0/5O7pF5XYwHcDga4T/
         IiqCxET3FOKiKc7e7DcIELbWVZbo3JzisPMmxfTwNOWsU5p7/gmdHeD22tgbZ3joP0pn
         X0kA==
X-Gm-Message-State: AOJu0Yyq71VkOfZSkTSurWu35rylu7n+2q6gSQ4AbhxIzrE9GLvg/pS6
	NyST9qVrj4vXJuUH3uRQca06m1VhA3H2muT1AyizovvotVRzhpZYxPtur2f39K7+GhrgTQ==
X-Gm-Gg: ASbGncu46u0dulqN+KwJlNTZ5cjxjXPrHfmmA7Ps3j6VlxD+ktapplHzY5m+yu3thkr
	VwD9Hv3s52rHdmB9wEKkCKZzu3XRNfoAh+Ik74InwJQpXxDzc4qnNUk2ZsCKVWqABjkaaO2FtI7
	OBsgYfs7YgIaHtKqhE08xrN6T3EAYao5N7uthpI211Sy7Zf/EF2qmGAHE21aq3lH+pHthRydSJ9
	knuvKE4JwY5OgccdNLxHIPXY91e0O/7T5feCWAbCXd0ROV/Oc7w7+w804FnJN9TplprpPh0URh/
	xsI5BFGJL7pyttPsyQtnRNVjb8iAaPnDAGbUXh431VwCCgRn4nG3XflD9nKNqo8etwX6tZfRzEV
	yMRDhDKGdDnnvEX+iLCMn0g5ZcMFApnwaU9jDrtBCxGcgc4wJ6kMEurRDUac3aQKErdmCeh1XKM
	LPsKsHU5a3H5HfBSlfLPArx226S3xGItrOegJ7poXnvO+/IHzfXPwPZ3J1rKo9
X-Google-Smtp-Source: AGHT+IFuDPDIfa7fNKtMBzET/+ke8UW54hj0IuzsV7ZDy7nTRrW5A5I35mQalHVUTTIwknVvLlp1Vg==
X-Received: by 2002:a05:690c:d90:b0:787:e779:9ef8 with SMTP id 00721157ae682-78a7bb5a576mr35330267b3.16.1763677443408;
        Thu, 20 Nov 2025 14:24:03 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7993cedesm10954757b3.41.2025.11.20.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 14:24:03 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 2/6] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT userspace api
Date: Thu, 20 Nov 2025 17:23:42 -0500
Message-ID: <20251120222346.1157004-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251120222346.1157004-1-utilityemal77@gmail.com>
References: <20251120222346.1157004-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements the syscall side flag handling and kernel api headers for the
LANDLOCK_ADD_RULE_NO_INHERIT flag.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/uapi/linux/landlock.h | 9 +++++++++
 security/landlock/syscalls.c  | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 50f0806b7e33..d9daef551d96 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -127,10 +127,19 @@ struct landlock_ruleset_attr {
  *     allowed_access in the passed in rule_attr.  When this flag is
  *     present, the caller is also allowed to pass in an empty
  *     allowed_access.
+ * %LANDLOCK_ADD_RULE_NO_INHERIT
+ *     When this flag is set while adding a rule to a ruleset, the rule
+ *     will not inherit allowed accesses from rules on parent objects
+ *     within the same layer. (currently only applies to filesystem objects)
+ *     By default, Landlock rules added to a ruleset inherit allowed accesses
+ *     from parent objects, meaning that if a parent directory has been granted
+ *     certain access rights, those rights will also apply to its child objects.
+ *     This flag prevents such inheritance for the specific rule being added.
  */
 
 /* clang-format off */
 #define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
+#define LANDLOCK_ADD_RULE_NO_INHERIT		(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 93396bfc1500..200287a34895 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -463,7 +463,10 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	if (!is_initialized())
 		return -EOPNOTSUPP;
 
-	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
+	if (flags && flags & ~(LANDLOCK_ADD_RULE_QUIET | LANDLOCK_ADD_RULE_NO_INHERIT))
+		return -EINVAL;
+	if ((flags & LANDLOCK_ADD_RULE_NO_INHERIT) &&
+	    rule_type != LANDLOCK_RULE_PATH_BENEATH)
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
-- 
2.51.2

