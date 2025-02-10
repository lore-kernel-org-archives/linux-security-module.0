Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521EEEAF9
	for <linux-security-module@vger.kernel.org>; Mon, 10 Feb 2025 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739158907; cv=none; b=hxGC5nZK1rqKeO6M0pIahLUKAOhZv0GRWYUbzE+o79208g20S84TML6GqYzwNrBq3+mU2OYRm00n2rnvv2sEa7M8HJSY/ioLRMFK+5xl2TbB7X/oAo/tp0pw5ZhKiJoAltRQz2N45Tm9RWODqKU65FU1XAL+uzbvzk+Ou/9PSlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739158907; c=relaxed/simple;
	bh=3+QwqXGTWNcIBXUohx66rLf9w/TpiYavobO2LwXA66U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QhRaLLzar0MbyFsnCaws3dpUh9VH8fkZxhM5XcgffitbtP8Abi7Xl4nNDrxfPE9Q8VRT+OSNSF9j0LBpzkB0RNPNF9FhqY3cigJFNfmarK2QPrLCPNHmMzmTtNX+TlhJHmpv9mE/gKvLaFkvBMpdYBkEhRlOD1Jrxb8zb+PQnkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IvbsPNLJ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IvbsPNLJ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c05b700b78so73364385a.2
        for <linux-security-module@vger.kernel.org>; Sun, 09 Feb 2025 19:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1739158904; x=1739763704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ad2FEUJewFYSSjc1IWPch4ozE/y0Eyq4PpvLwkog2QU=;
        b=IvbsPNLJEqVeDTDqjXcCwLmK8cs03HWetDaJykpJwxvxOw9vAeV03WQfCZs1tRBbCi
         Yw5OAR+NhVMiIc3Vf9JtKhMQ0+oBCY5QVuDXf6Sju+7Yi0cQLDvx/bYvzNGWoaBaiROU
         7AafG2RxH3KwydHFDuPvkxA134FKzL44jr9m+dGjZ84VW/q60H1obJuD6v85cuZtT+0R
         PRV4flnib1ilL/0q2Iq5mBQAe90KYupMwMl4RVb516AyYocjN/C/Gu9PYXf9LiFhb26F
         1oOSHTBVEMyQwNEJYloiv1goQKpTQhd3GOsSyHdjGKZIkkLaFtlQu9LXJGym20LDxiOF
         eTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739158904; x=1739763704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ad2FEUJewFYSSjc1IWPch4ozE/y0Eyq4PpvLwkog2QU=;
        b=lzyL7INrdrymA9PlgqMnPlrsIqJ5N1p0GL3TkBvSIdWQqAgyog/HcW2jHRoCzMt0g4
         6V7lAMcrubTrBGiI97St3PqkGXGCzZyv9e2+A6d2tXZgWmfB4X4uEkjg6IVdGedKSzn7
         zhv1Fd+EfGRwPYmW5bPELRrK4VQ+6Rznk0nuUInd9WsRsbvBxJ7rr7GnKDGtB48ZKvMB
         cPWyHzOr1lj5BkV/qT0f8p5EDQp4NDVEekpSNx641F18zbG3dWK+9v6qV4EPnW1gOmud
         lHFsc7Y81DWS4IoGE+TZgczT1MGFxRi8Kg5S2YzbbP891PBSX4gqIdi9HFUCy4KuuByN
         DJlA==
X-Gm-Message-State: AOJu0YzILTa2pIiJaFQwJdKYsrcwTgrt6V9OS9CRzo9OgBoQJIq7wM18
	jalKvusM5YaI8G0UvFg9rAY+LEqzzGL6mLQG9ZZpKufI80ZDTl9xRTkE9vtqi5zVctvE702guc8
	=
X-Gm-Gg: ASbGncvYGy/RvYOnQ1Sz2vIFNjCJjh8DrzzR31Y7tg9WDQAtitVI1F77cf1Fab/UCFK
	Xj2Vc8gity8DV0TuB9woY6yS6DCwiA5wHztAlHHlzo/Cf0vYM9VdQTdK3LUXo3jY9yAbQgo+wGX
	44OENtbIPoss0jl2CGsrOkBpi9DM1xxXgkIO8DUb7Cd7av77ecpPaBMC0a2KGnOs/KYCBuwM6xl
	HestDj4Kqn/Vrh9/wYma1QhCEU+sa6oYMQY0QjPOupewVCW5r1taycTcfsRssp+lmwr+nmWGIs5
	xVT+IEeB1Q==
X-Google-Smtp-Source: AGHT+IFqw2aB9ivAU6D1GJiXfbaeXhpX4AjBNrQJtWblNEKxxvApJD7v04NKjchjudU7n4Ra5wBAfg==
X-Received: by 2002:a05:620a:44c6:b0:7b1:880c:5805 with SMTP id af79cd13be357-7c047c21eb3mr1957068485a.45.1739158903954;
        Sun, 09 Feb 2025 19:41:43 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c041e9f9dasm481533585a.80.2025.02.09.19.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 19:41:43 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH] lsm: fix a missing security_uring_allowed() prototype
Date: Sun,  9 Feb 2025 22:41:33 -0500
Message-ID: <20250210034132.8448-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=paul@paul-moore.com; h=from:subject; bh=3+QwqXGTWNcIBXUohx66rLf9w/TpiYavobO2LwXA66U=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBnqXVsHxGE4tGJ20mqtPs6jX/CW8UtQ6oVVPk2b StQiFLQAm6JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ6l1bAAKCRDqIPLalzeJ c3XhD/9T1aQ1yunzzqH92pvraVdXXp1jk7bLmESq32+E4O+duSbnYXZ/X8pjklUMQ8arBOlNyys G42YWdX15Qu3JvNimzYlWs98XK2juehG+rZL41a2l5QyfA2ibB6sdW1CdXD1WL++rOoJwQH9ovN S1F3LT4oDfoX8wI76dUX7KsqMic/awQ8v9VZrXnf3tZnilQAh4D8mMM1dkRoR8I165krUVAAqxB fiewkDmJvKsYdo0OnYUGTyOUWlZTEFAYOkkM6iMqzFHeOJn+YZI8/JQHChYK+nFOrCRpjIXul/S SioXVmABJFH0UuBUMIh/ow/eUlZgyzXLJbWazWetfk/Goqn4RJBRbJ0eNqaqFpcCC1yct3AVfED 2vTQxid7E888DTLX2hHPrMeSUsPLf2pHvXLzPkPxHpE0WAnoscEAqZ0GLqKaTnJ65L2EHWQLbs2 5Ydz8ef1QMt3xOQ/9h8CClPyviF3NlhEO+7mq+GhLlzlyYwQ4sJSqIfshOQ2GQ5j04XkerpYCdM 2KtsS0tk+B5VujO5KxRrZ6eONzp6L4Du3uf7d7wycmiVKy9R+/H6J/svUdfHKkeEplqwJVEy73b JhA82di5xo/hH4p7RGqdesViQj5UOV+4VJKReAnqUjfh9gLBmWEowdUOwxUL9Zn8D42a4joYJHF JO62+w+muO26iwQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The !CONFIG_SECURITY dummy function was missing an inline attribute which
caused the compiler to complain about a missing prototype.  This patch
adds the missing inline attribute.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/oe-kbuild-all/202502081912.TeokpAAe-lkp@intel.com/
Fixes: c6ad9fdbd44b ("io_uring,lsm,selinux: add LSM hooks for io_uring_setup()")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 3e68f8468a22..fab843d5e621 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2376,7 +2376,7 @@ static inline int security_uring_cmd(struct io_uring_cmd *ioucmd)
 {
 	return 0;
 }
-extern int security_uring_allowed(void)
+extern inline int security_uring_allowed(void)
 {
 	return 0;
 }
-- 
2.48.1

