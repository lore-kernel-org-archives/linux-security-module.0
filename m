Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF7D34C811
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677442; cv=none; b=bRJnWdqdkrz13lEXv+KmmD7Y3+S0a9iyqvJ1JZJCZC/Am1QUdpX1SCcl0OtvLEAqhx4t9d8RbdDR+JLGFcRptNseCAJxgo6XAgiS13GOy2y1FbcWoZbj63P8AmufbFmbPZkkuUfGS7cAKrDs5notre4utztAd/HlnReP3dPd7wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677442; c=relaxed/simple;
	bh=wmvjHViWWxiFKGygWBTYB0SwCwQknBwHsKaF3xjRZjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJeZsHNL9BCNF/6lMj0CO9mjVJPl+fQ9SW8TXsICUkhLGGtSryFUVlfelHuDrLm/UF+FzaNNSGXnGBbjC7O9CXsPEBEeNuoV33c8McA/5/4ZtrW/37MewHKe7HtmTyma+jOjRa+krp977yrbQ7j01UOqfsEwMnZfkjW9dieZlSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7GPQw2H; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7GPQw2H"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640d4f2f13dso1300135d50.1
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 14:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763677440; x=1764282240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NdD6UqKBnNEBS5QbhNmQt8W/mGNgTrbj9xTpwZ12gL4=;
        b=Q7GPQw2HYRJjprY5wYh/S4Sn9cHmGgET0sW7JeNgJc7/MQY8NkgHoKfQdpomqZzyUp
         U6P/Jk851pFu3FPoGVWcNm6/PA30cGWOhLimcuih/v9ddGPlbqiooNGaeOv5BmdQqFSF
         xUJA/oAqltm9KgIadoANOse5ieQwMQXVlCKgseoXyfo7zu2ogh5WChXmqzGAsYUZYBka
         wTvkYeHyBylLL2eLpgedWct5MF4DWTwBDvnnjAztZEadyT5tXqW9PYdu/l6WieBhMLIO
         3uHLyDNw+BJXB8MKlij/8kxYxA85IkIQKHL8/Xk/V+Zt5wl0xO4pj2olEdSdRfxqtj92
         56bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763677440; x=1764282240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdD6UqKBnNEBS5QbhNmQt8W/mGNgTrbj9xTpwZ12gL4=;
        b=ITtbHOUmmEvR6VMtAT7RldoSPjzZX54cyh8a4O/72D9QCMBt7x28Bw+lFeFnWXplnb
         eJm3jFdrsYt7xVh+9QK82CluHneTFHSN2omunL2uWm8wXBR6LicV4aQv7JswkSXeHUej
         uFCIgREEgcq5eY3zMjpgOlM6RrDVlpG4iQMaQ9ttBFRX1P4chrXb2MYCcqu8W4xCm0+t
         CrZfvnkXGHX5tD8B1O7CQ/JgTOw5mTD6h5rnPN9Blan3fHeikm0Z1OyB+Iwh/+z5go3a
         pViFF/LdIL4WwKzKz63yQpQxz+iFaxFh2MjYaq8gXcFMycUAYErt+pns6PA+p47FrEUk
         EFng==
X-Gm-Message-State: AOJu0YwTCYhsmyl2GhekhclXzjvg7wRUcTXmycSvrkjsPoxrr+zkSB3W
	2icB+R1rsEHgI/mnfQeP3bvW7L+rhb+AAeN1786Y+sdAYjR5JbN5MMiJNCWT0SGKvP/7XQ==
X-Gm-Gg: ASbGncuG1aucRtN6daXsUyremtt6ysyzhlEeWISwADgo71wgXC0OdDfH48VxgR1qviK
	worjmU1MqZaEHtWXh3FYeuT1x7Cc/7nGPrwMsaBgZU+e9F0j7WbePk18KtMIS0Ey//+AynHnbe7
	ECZpju8vo4b+ATBJw/0lbBqfN0VkDWN9tw4KO0Pyoh0Gh5O08Tv/I72h6eWKbbbw2zTmIv+Dv/M
	FLSy3R8tWjqfGsshCnK97j3thytoo9o4J3vpTM+TjTzUhoN3oUt3fC6TMpEz9aGB/46H0xeDooO
	I7qsbLRjpqUCP3AAzlsW3fb7C1WSY1M6KqnDxspi6xMojgSGRA1kzZiVtAN2NltuLaRxqv2z+HY
	3QDeIGx3iHXhY7uGK6y60jDxb/eea9zY0aplGzYJz14BvgU3ua7PchEHxg9jruR2HJ0siHu5D7i
	It2QlKgv6NVIlO2k9hLGwBOs2CYmiz5lToj7L3IaGNjLu5U6VUJJVDnxOGwa3a
X-Google-Smtp-Source: AGHT+IEQ4lGuBseafO6o+fF3elaZr04qkiEcd1DihIKxX291QijVVKIR0lTogiAFEeu5GEHz4htQWQ==
X-Received: by 2002:a05:690e:158f:10b0:640:d207:99c5 with SMTP id 956f58d0204a3-642f7a27f2dmr2678734d50.66.1763677439787;
        Thu, 20 Nov 2025 14:23:59 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7993cedesm10954757b3.41.2025.11.20.14.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 14:23:59 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 0/6] Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Thu, 20 Nov 2025 17:23:40 -0500
Message-ID: <20251120222346.1157004-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series introduces a new Landlock rule flag,
LANDLOCK_ADD_RULE_NO_INHERIT, which disables inheriting access rights
from parent objects within the same Landlock layer.

This is useful for policies where a parent directory requires broader
access than its children. For example, a sandbox may allow read-write
access to /home/user but prohibit writes to ~/.bashrc or ~/.ssh even
though they are nested inside the parent directory. Today, this is not
possible because access rights always propagate from parent to child
within a layer.

When a rule is added with LANDLOCK_ADD_RULE_NO_INHERIT:

  * access rights on parent inodes are ignored for that inode and its
    descendants; and
  * operations that change the direct parent subtree of such an object
    (rename, rmdir, link) are denied up to the mountpoint.

These parent-directory restrictions mitigate sandbox-restart attacks.
Without them, a sandboxed program could move a protected directory
before exit, causing the next sandbox instance to apply policies on the
wrong path. Denying such operations prevents these attacks.

This v2 series differs from v1 in the following ways:

  1. Adds four new selftests for the new flag.
  2. Adds a KUnit test for access layer propagation with flags.
  2. Extends parent-directory protections (rename/unlink/link) to prevent
     sandbox-restart attacks.
  3. Rebased on v4 of Tingmao Wang's amazing "quiet flag" series.

For convenience, the original v1 is here:
  https://lore.kernel.org/linux-security-module/20251105180019.1432367-1-utilityemal77@gmail.com/T/#t

And the quiet-flag v4 series is here:
  https://lore.kernel.org/linux-security-module/cover.1763330228.git.m@maowtm.org/T/#t

A short usage example:

  # LL_FS_RO="" LL_FS_RW="/" LL_FS_RO_NO_INHERIT="/a/b/c" landlock-sandboxer sh
  # touch /a/b/c/fi           # denied (does not inherit / RW)
  # rmdir /a/b/c              # denied due to parent-directory protections
  # mv /a /bad                # denied
  # mkdir /a/good; touch /a/good/fi   # allowed (unrelated to /a/b/c)

All kunit and selftests related to landlock, including the new ones, pass on my test system.

Feedback is very welcome. Thank you for your time and consideration. 

Regards,
Justin Suess

Justin Suess (6):
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT userspace api
  samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to
    landlock-sandboxer
  selftests/landlock: Implement selftests for
    LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Fix compilation error for kunit tests when CONFIG_AUDIT is
    disabled.
  landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT

 include/uapi/linux/landlock.h              |   9 +
 samples/landlock/sandboxer.c               |  39 +-
 security/landlock/audit.h                  |   3 +-
 security/landlock/fs.c                     | 433 ++++++++++++++++++++-
 security/landlock/net.h                    |   2 +-
 security/landlock/object.h                 |   2 +
 security/landlock/ruleset.c                | 171 +++++++-
 security/landlock/ruleset.h                |  39 ++
 security/landlock/syscalls.c               |   5 +-
 tools/testing/selftests/landlock/fs_test.c | 222 ++++++++++-
 10 files changed, 883 insertions(+), 42 deletions(-)


base-commit: d74278e895485ffe1c3708f7f2bc5c5b364aab0a
-- 
2.51.2

