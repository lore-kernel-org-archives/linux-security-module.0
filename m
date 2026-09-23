Received: from mail-yx2-f5.google.com (mail-yx2-f5.google.com [74.125.224.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF29A53FD4B
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181386; cv=none; b=m+ZuYRaxmy8IgbGU/AaiYs249XuWQo9djYuf5QNapktD48b1+v24RID3RCa4VImgcywOdJlpzTZU7ITG7sS6XDvkDGvx2WFExUM4ulbKO6R7L36TAFBwmayRvMLBQy4YsTSRWWTmq9nk2r+HrJIBvxvQ8TJQh+InP0hzX8AerUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181386; c=relaxed/simple;
	bh=9OeixsceemmEnxehS4nFF1a2FYDdepSavWu1P0EAnzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iqdt9ngdXoFDIGgVBHxqp6swSBb2XoanLNPRnYzgohcIPhYN3Zh1iX3p6+7OKjCcNEQu+3jM11By/dRQSlgTXIEdchPgnhjMkkJSsZ+0oGSKPN+/ycyvm8CzsnseAMrvMC+ALb6/O4COIM4yvj6K548vhjM3/nyjJgOyBqPqI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=cKOOysva; arc=none smtp.client-ip=74.125.224.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="cKOOysva"
Received: by mail-yx2-f5.google.com with SMTP id 00721157ae682-86333700d68so367557b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1790181378; x=1790786178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0e5lTRhuZiVse6rLfC3ssGDQx6Z+oJqHSfiMTS5QO4=;
        b=cKOOysvaur4Q9x2WyEc1b2g4vi39OoTsYvdqSSn+c29aYnEUz+0p0a/vBqVSU+iYBO
         Qa22NU3nCcjEZNi6Nwmij/tsLjGD3uW9hy/TZFDG8phDuMMqmryNMvoOzWGZ9QcxyB2D
         uELEEv+hnUftol0gtl1QZjtbgTw9Bp9rhoAtKUUe1n40l9l4IhPkssn7e6hxQUmp/kp/
         +gRyp2oM/V4iKDb0uanFXWj6YZ2UR8P+jmzUsnhkPn/dvuceEXctlGcM5Og8MIrqE6h1
         DuOBzM+Y9fSKcWkTw6AiCa9Fw1/EUrKDDZHToJ+/RSXGCGBsqi4KOJKFHfZSdC/RChVN
         DKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181378; x=1790786178;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J0e5lTRhuZiVse6rLfC3ssGDQx6Z+oJqHSfiMTS5QO4=;
        b=pjPVHAVz5TDOVX8BpsWQOERMGeLcY8b9pqzC4tNGn+mDvtWq1UUAgFTjgeICM89DFU
         Vip9sxA+lkIod+4BC9VtnEv1fv8PiTNoFyqC2tOV9ELjSo3BWHvNx5pbVeUdfkG2mArf
         eMj0GpsD7cl8pffd0BraQ21AJbNuUnLUeCMRrB4gaB8y7yKxU2d2PevIWIh3BcczHIwV
         yFRrLl0iMSAAUM1c73+2ftVm7s1pv77C9dJf4m9WGgB209XbxOVSGayRjOnMLxS7fPUM
         j8qYRBGMhfVNNSlKU2baFkWiXW6KnVAYPHo0S87Dtr8DaC507yplY5P6avawE1VIS80i
         7d4g==
X-Forwarded-Encrypted: i=1; AKwUvBwnn4B9B0OxR6vZdcEO4R+c85lHSsBuEjnSSjKSY4ZBlmv94tSjCdRR5xKU2+4OK/sxiHgvr0yjVym39DK8gaMGoCydGg0=@vger.kernel.org
X-Gm-Message-State: AFuF++mItX8/qEa8+IMk93CG8yfUOZ4TyrzOmv19dk0vBPjvLbfyGSDN
	UT+pov2tkISUYnm6QCKAhOKUz3vA3rJegqwLFTbYSyiX9DjZfFGOGbYU9qq9jYr+/bnK
X-Gm-Gg: AYBFou3hSxWJq5gVwivyQ0yougF5ULLllzSLjwJ8I2YVLHkF+9REblR3mAkAWvYR6Vj
	jh+TSnWD6ubhEdw1MT1B6i5MkmZ2Nn9GdBG1zn+zKIa325soYG++vy4rimTg083+7OBdsS3NgsJ
	HXobKMP2/zPemBiqcLq7pD4foQajxV6x5MquQc+dyRe5WwqlGJkgSTC0m/lnCsOZZg0mLUpwda5
	N3fdqfbc0c4yw8qkZ7QUChVpPmryv+X08TqsAK9EQ2KMmpYQu1HJgBt7WaULcTS0MqksLey2Ucr
	KukdSrKRfKJHUPL0azE/XqiVRIW+8FiIVlGk283SoMJvTx2h7LfpKyK4gpGy5bvoSWC17jPoxns
	7+bZSNLC5vhKqLl4cmD1uSElQ90G/FwKa2Noj2wwamtwMmzTjCIrz8WF7oh5gzK1NuUeovDeZKj
	d7b5Z0A+6hu3kmOUJ3LVy6/fFuTTFhXQwY/QA74X59jD7Dj8hejmfyhepSu8ZIb2Ll9RyXx4GAF
	pOBF4QvM910CHVTdKk57/0qgGDRr4ySP2NUTPEPWBbU5YHKRg==
X-Received: by 2002:a05:690c:998a:b0:841:dd38:a734 with SMTP id 00721157ae682-8a452878e4bmr37543737b3.0.1790181378043;
        Wed, 23 Sep 2026 09:36:18 -0700 (PDT)
Received: from kelso (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a4658c9778sm12709257b3.8.2026.09.23.09.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:36:17 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] landlock: clarify TTY signal scoping
Date: Wed, 23 Sep 2026 12:33:19 -0400
Message-ID: <20260923163321.79770-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document that a PTY master retains control over processes attached to the
terminal, and add a selftest covering this boundary alongside the direct
signal restriction.

Since v2, the documentation follows Mickaël's capability framing, the UAPI
description refers to arbitrary signal targets, and the series includes the
requested selftest.

Link: https://lore.kernel.org/r/20260916152336.1589383-1-clusk@northecho.dev

Christopher Lusk (2):
  docs: landlock: clarify TTY signal scoping
  selftests/landlock: cover TTY signal scoping

 Documentation/userspace-api/landlock.rst      |   6 +
 include/uapi/linux/landlock.h                 |   2 +-
 .../selftests/landlock/scoped_signal_test.c   | 175 ++++++++++++++++++
 3 files changed, 182 insertions(+), 1 deletion(-)

-- 
2.55.0

