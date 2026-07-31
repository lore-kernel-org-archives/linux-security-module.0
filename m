Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31E30ACF0
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464483; cv=none; b=ipE6u/lH+Q1NfyuOu0XY/74E1NeZXLUeWXZPLUvkxi1otvVFkybgSg+X7mC3RSnaiwfPjh3CNceF7GNaSgnJrcRfrJLgD8YZtRDy9m3VELSEFHg0iPK+tMllk14e7ZDeduF38us3V14sy/0n46L1EAa3Nbx96EHTyQWbpHbXYrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464483; c=relaxed/simple;
	bh=My+S/AoHnM0sWQ2xfzHcL0mjHYwtuqRDL/YoeC794wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ma+07FxaD/H8ATT7BuMIxt5W+KSYnS9tEzYU36pZhP54PeHKodiHx7NmCOgcKiuBhqhFhwq5EVEk1cLL7tRtq3GzBtww4aEXyKSrXn4JUs3pt9RAxhTrLKJOM4a0TByRdd5vSBPJoZiWMFKxwHfx9BWquGohHvaLMrzXh5NX0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1DwJtRu; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1DwJtRu"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8114a4542b2so7917537b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 19:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464478; x=1786069278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XvJusACK6JVx1ShSYZD+EOjxsALcCJEGMTDUzMzDD3c=;
        b=a1DwJtRuTrfBqJIpT7wp4bSk7RCtJIXYYrQVMamrOzMYTTbcdNX4Pz/iB/L0505v/I
         xf2+zjVBY1gVRicrjaVJNGTolZiHTS3gSpp3ASRd77GUSYpAVcvmTKDrtBR2ND8pEAAj
         dNiJhesd1Wi5oMiYNsYCDJDzy8mhvswtiyKr0cqrFG1zBtkfMPSxq5r4FsymOZQEVArJ
         +WqStX3G74jsfik01Uv8IfbeT0Mv7diKahbvxNmHwjK89ztXWL8gq3536RaS9A4iVfm8
         Ln4g0m1U8yWAQRhl401SCnyuRSzMNOWYJiR7gBlWRB4cTzzOBkOLtWVcJKP/q4RB67LU
         Q9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464478; x=1786069278;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XvJusACK6JVx1ShSYZD+EOjxsALcCJEGMTDUzMzDD3c=;
        b=Q/hwSr2GITewsBXMGk2UtiTaUkRCBiNobkCCvgXhnQr+eVQsFoMu6zjyHRAlmAEnEB
         pptjTxwGRfspzQaJhyg+dKv1CDUXr3hPB7oDulo3Tj3JNHMKFODsxCaBTKKjrjXHZmDS
         DuA2QSXfuBQRujojZHOfvq0Sgl4iHnHAMXAkHuGnUeNB23ihjuT5RmKFSa334gqo61NH
         AFZLZSGynzjPi71qpnrUPz0Ek6xHnKcQoFbzXAEqF822a5wJelGQNowc5lA3zxzF0RR4
         /SLhZgBrj2XQvmQnyeDdgF5G/B/nOm4jh9SvZ4WNTrMxQdh2YjofN+cItYPXnd/yDmrB
         C5ag==
X-Forwarded-Encrypted: i=1; AHgh+Rqw9nGAXLDOE/hKfGpuzYj2W+2khfxgyoQB+hHCGEXZOyiihoHKlBFrw7nBHGKZ8/+JFA8Uc9uGB60oxEJdVtrn/JpYASw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKqGoyV/fuJKw29j6W9lVdN+59vVzEKVnX0lVvCWB6ILGIzAMk
	x7UEutH0zVqzgquevaBUnpkzZp1Z9GfRdN7PekM9n3/niq2ecYOFw36n
X-Gm-Gg: AR+sD10mN256L5+W2uYCWy0N1V3S4voq1IIsHBg7uMaKskTn8jTCTKGYMwl/ljXPvXj
	/m+s/7Hb4LfvLyEPHh57UruAAJssVkhvDzvUNaoBXQZ+fpfJqqXesNyHPRYRG5tCG0vQvl8vrYE
	CW47n5WrrL+u72G+E/nCKubuNQ++MnErBIVwuEziuP2ERgU34qYbzxBLbx5JYpwnP1Ccs0HBMj3
	Cvuh7AkLy0Pnrg7dFXKLanVnkIJ0Pcm/Fe/n4LQ/9V5NTZd8HTI1K2N+RwV38rs0X5v6d6NT+Py
	sNO7sO6qK7Orzz0CJQR9NT3KdVbyTCFH99iTwwxUKlA2l0QSqAK6+D8i1SjLfYeZ8RWAwowbDO5
	xseuPySP8egWh1/w3b0x5SO9dM6ePw2wXAPoBruJFd1nfu1XuIiHwOccwWbwIJpuZIhxFQHsAE8
	WAu7kN6igYB/wmWopLYl8DQw3m27CsQFyT4wWC0iO/flRtY5r2Dl0y8BOEXWRnMnG6+q86AyAxK
	Mnjay+OCoLWKqjWronf8A==
X-Received: by 2002:a05:690c:e3ce:b0:81e:6c2e:f113 with SMTP id 00721157ae682-81fcbb0187dmr690287b3.36.1785464477862;
        Thu, 30 Jul 2026 19:21:17 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:17 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 04/13] landlock: Expose the ruleset fd lookup to the rest of Landlock
Date: Thu, 30 Jul 2026 22:20:37 -0400
Message-ID: <20260731022047.189137-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rename get_ruleset_from_fd() to landlock_get_ruleset_from_fd() and
give it external linkage within Landlock, declared in ruleset.h next
to the other ruleset lifetime helpers.

A following commit implements the LSM kfunc policy hooks, which need
to translate a ruleset fd into a landlock_ruleset reference from
outside syscalls.c.  No behavioral change.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/ruleset.h  | 3 +++
 security/landlock/syscalls.c | 9 +++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 0437adf17428..b65d1c07e192 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -225,6 +225,9 @@ struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
 		       struct landlock_ruleset *const ruleset);
 
+struct landlock_ruleset *landlock_get_ruleset_from_fd(const int fd,
+						      const fmode_t mode);
+
 const struct landlock_rule *
 landlock_find_rule(const struct landlock_ruleset *const ruleset,
 		   const struct landlock_id id);
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 36b02892c62f..9af2407274b2 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -293,8 +293,8 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
  * Returns an owned ruleset from a FD. It is thus needed to call
  * landlock_put_ruleset() on the return value.
  */
-static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
-						    const fmode_t mode)
+struct landlock_ruleset *landlock_get_ruleset_from_fd(const int fd,
+						      const fmode_t mode)
 {
 	CLASS(fd, ruleset_f)(fd);
 	struct landlock_ruleset *ruleset;
@@ -476,7 +476,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
-	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
+	ruleset = landlock_get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
@@ -564,7 +564,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	      (flags & ~LANDLOCK_RESTRICT_SELF_TSYNC) ==
 		      LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {
 		/* Gets and checks the ruleset. */
-		ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
+		ruleset = landlock_get_ruleset_from_fd(ruleset_fd,
+						       FMODE_CAN_READ);
 		if (IS_ERR(ruleset))
 			return PTR_ERR(ruleset);
 	}
-- 
2.54.0

