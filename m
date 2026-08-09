Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D073F1C5F1B
	for <linux-security-module@vger.kernel.org>; Sun,  9 Aug 2026 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786290352; cv=none; b=LfxBh3m63GaGHWUbTBg2gbCl9jAzq4mawmjt4WvsvKS2tjR8rg2BS1yukJlzhAdv3ClrbLrdVKEmaZAKe1IV7uu2R+vkJjtn/muxALJ0pFKITs9lOYc3B42EqsooLqDibugBZ7iAo/No75FHirWbY2kIwBkrLM25poCGF768Lrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786290352; c=relaxed/simple;
	bh=eAMqol1zYgr+7QAqNpjRtuDJ60g/z6FUFiVLJddOzHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRcEX5ZRDs0TBvH7v0HjsAGxuY/UJE89rZibAIYRtb5LhounV4TcFychDsqj6ZOhjYgNbNZkvVeAfQCDC4EVKJ1Iy4kpHenMJ5DjWirqHN0bbvuhARsEbKxoWBqqfoA9S/L5ksF7LdAP9YgezWqaTCOtYn5EUrfGTehq2yPK5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il0X/cf8; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il0X/cf8"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664a09bc459so1545451d50.1
        for <linux-security-module@vger.kernel.org>; Sun, 09 Aug 2026 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786290350; x=1786895150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hn9JpmrDnY0h+wRK1i77j3APz1tT5vx3twjO5WqH6vM=;
        b=Il0X/cf8czIYtdi0HbSoViVP2LYI0ZX360MjxpLRm9OyOBNiWxf1VIMaH8zpg+8qQw
         NxNssyK/xZf33sk32yC8xfLqmfk7ZAqm4zMokJ6PpjVWCZbfxqp1jgd8Cbd2ip8z5ioa
         t9ngghBCUP4TixxA6G/QJowshsVEUarmcADRQs67iBwJB+7xHyGeXwp+jh8I+3VUSbD1
         fzRzZGp8WHvxQqruEqU7e9CLbd5hOCl5CFrj1DI/AWtjv2z9SbnHL6zpn0X4uq2aZFHA
         owpuSXY/UXV8jCGle18fFsXtrMnWA/Hl3RLrxXDTANhXgUqBBVvVJf0ofDDEZdA9Deil
         SgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786290350; x=1786895150;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hn9JpmrDnY0h+wRK1i77j3APz1tT5vx3twjO5WqH6vM=;
        b=LrJshEonBEXPjndQD40g+byAivmpTlLlFi8PMC8aZ+AYUL6llMoXHBIYOMc/nb0RB1
         o4gw9zl+JK2DPXWa60iqpoHYV2gxXQxqfZaCww+uMjKPbNwh+E37X984Tz3Nh/IVuXgZ
         SLBSfhj5U6iEODsp3XYswfC86xIGATU5tDiEwaGnevlmcFibnKyup58/FpGz3x0+Srxa
         pJL+Ex2pM8b6GFxmiBz+RUWpustg8Z8mMqC70PUz0Vbxz7lLdpZytYLolulYZEZfD6wb
         PLCC1RiF+utEW8/PDXPD3V3wW+73EI7uVwYtODnLlMgxDimoLzsQp/fLL1Eo28uUbT+F
         Z2sg==
X-Forwarded-Encrypted: i=1; AHgh+RqoqwTFnqrnCp2VuKYirRRrppgw9Prrs+jpl9K0iKW4aAlgijSHKigmi0ATSqQlGGGM4aHWT7x9/5E1k1Wz/M4CH0hGr9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmR2O1p/ugSO+nwEVO9V3C2bcJjGGy1jNHSSUijolNW0EYKiQ5
	fQtNbvoPFAvLyqcEd6XJVosvxN8n6hozofc6V7eotTD5a/ciPjD4js3P
X-Gm-Gg: AR+sD13IpvD4Kjdig+q7/F4Kz8YDsiQtZMJRuORydnimQi6Pbhm5o/2DbRkVN7vaS3Z
	zq1KST1a6KY0VNcPYt+waTdX1X5xs56tGvVIsi/f/4qfB9/7F1R3txel5HNdGDnOtW2lpJ23FxW
	zKkimzFtPapfQ+durL4HGiWmxEzBU8M1uHfwNAnwnHELxoKj0pC9UYSWHqYqHMz79Yd2PAHeZq9
	D+puCP3CzIM4tjmMSFVEy2OoQ/Cx+Q/QlFY0Xzz/gfMfJvtOa3hSmZoSbq/Bct6ZJKvDUyUUyMt
	msYLInpJwujfAHeDRcYP6FM/CqIeMiT636S69TJg9fNm7/p4bK43zx5VQKTfKobNeYA1qy/6ShG
	iVl510EUSE4WN3kbuMdrSebq8EdN9J/q/eIT/i46IoQS5xcHE/RX+ToXNAC5qLC0QvQYm9qSGiA
	yL+UESHnOSAPMb6JwwADs+/R6XmBNDOnTD8eSz3u/eRnP+FWejWT0Wn7PVaJj5f2YfW5pLpRe4F
	5R1jktpIJNqnpfbpT5TE0I=
X-Received: by 2002:a05:690e:16e3:b0:668:9567:db70 with SMTP id 956f58d0204a3-6699aacf1d5mr15790620d50.40.1786290349820;
        Sun, 09 Aug 2026 08:45:49 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:4665:53b0:3ac9:3545])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acacdbea9sm4838001d50.3.2026.08.09.08.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:45:49 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v4 1/5] landlock: Check landlock_restrict_self(2)'s flags before privileges
Date: Sun,  9 Aug 2026 11:45:19 -0400
Message-ID: <20260809154544.1253100-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260809154544.1253100-1-utilityemal77@gmail.com>
References: <20260809154544.1253100-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sys_landlock_restrict_self() currently checks the no_new_privs /
CAP_SYS_ADMIN requirement before validating the flags argument.  An
unprivileged caller without no_new_privs thus gets EPERM even when the
passed flags are invalid, hiding the EINVAL error.

Move the no_new_privs / CAP_SYS_ADMIN check just after the flags check
so that malformed calls consistently error out with EINVAL whatever the
caller's privileges, the same way seccomp(2) validates its flags before
checking no_new_privs.

Update the restrict_self_checks_ordering test accordingly.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v4:
        - New patch, following Mickaël's review of the main patch: check
          the flags argument before the no_new_privs / CAP_SYS_ADMIN
          requirement, in the same order as seccomp(2).

 security/landlock/syscalls.c                 | 8 ++++----
 tools/testing/selftests/landlock/base_test.c | 6 +++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 36b02892c62f..e3ef7b980c82 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -535,6 +535,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	if (!is_initialized())
 		return -EOPNOTSUPP;
 
+	if ((flags | LANDLOCK_MASK_RESTRICT_SELF) !=
+	    LANDLOCK_MASK_RESTRICT_SELF)
+		return -EINVAL;
+
 	/*
 	 * Similar checks as for seccomp(2), except that an -EPERM may be
 	 * returned.
@@ -543,10 +547,6 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if ((flags | LANDLOCK_MASK_RESTRICT_SELF) !=
-	    LANDLOCK_MASK_RESTRICT_SELF)
-		return -EINVAL;
-
 	/* Translates "off" flag to boolean. */
 	log_same_exec = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF);
 	/* Translates "on" flag to boolean. */
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index cbd3c1669951..f3c126d5c003 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -255,8 +255,12 @@ TEST(restrict_self_checks_ordering)
 
 	/* Checks unprivileged enforcement without no_new_privs. */
 	drop_caps(_metadata);
+	/*
+	 * The flags validity is checked before the no_new_privs /
+	 * CAP_SYS_ADMIN requirement.
+	 */
 	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
-	ASSERT_EQ(EPERM, errno);
+	ASSERT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
 	ASSERT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
-- 
2.55.0

