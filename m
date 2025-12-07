Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C01FE451
	for <linux-security-module@vger.kernel.org>; Sun,  7 Dec 2025 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765072308; cv=none; b=IE4l2ppLM78vQPuKxlFiOYo/zR6kO4N2+vgbdWVMLqNUIw1nCw3VGP4wnkk3nXUbCZmyUreYd2DG3dgYvOvhCcoBNv+JQn3iGNOZIKw+UuP4grMjgewHRbtb6GR4S0VOAZZLUUbuIRp/nvXlGoAcdwYZHBgjAcP+uyuP1uvsYQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765072308; c=relaxed/simple;
	bh=yR0A1+a0Ec6yVIc8eF9mhmMf4aSZN6mqMF0/NL3rEto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dilx0kN9j3rLttSZgmxlwXR9lZ6+yL3L5K5MEIut6M0tcjMYxLeu+/iBbmjjicrcSKFeetly8cSkYkyLt+AZJBGdTPDhLSkJeP59VqBsz9kyagWapjBcKngn2WR5y1isEdqD2+oXvMwj3RJ7E+awYmWqXbf/00LytFm39fbSh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPPeAVKs; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPPeAVKs"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63fc72db706so3022391d50.2
        for <linux-security-module@vger.kernel.org>; Sat, 06 Dec 2025 17:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765072306; x=1765677106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqMtyiNBCFRZjKg1Vmeiq/uMLJGlx2GxG5LTdSZGBXM=;
        b=QPPeAVKsWcUZ9Pm9gZJBw+t40L5P+ADEmKpUXfTVpdemsruNeZONzY9lJgkqCSoojb
         Z5pxC6LwlRVg+QmgOi1mqHN/gd6W6POJNaEB+4LKzwuxPSBjbKuEu6KtUFoJ1WYBnX4F
         EtBhmcSZcJohG2QDJPusMgykxmS3FFoZJ4CED+iIJvd0+FMTYPwAWt332hJJTmUq4yA7
         hk3IqGQW5Bt/TD1vH3I5cj2v8wvv4ykhFKFal/SCNA+SWcNnvi8dCp4z8x7y1XHl4NkH
         MmELvQ4RC7+qRE3T9wonq9mgNb/o8TeXQ/FWIbvXp/EKuDD+pVSjRmIMxdA29AtT96lW
         N2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765072306; x=1765677106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqMtyiNBCFRZjKg1Vmeiq/uMLJGlx2GxG5LTdSZGBXM=;
        b=SbDbbiHF8qCKiAlFV7Ek/onH+Rl1EOAWPgORSWhC7eSggg1mWJWgIJW3rJEEHoVk+G
         kiSbNEGliAHlfBntZTmQFymvedEXuAD7iPjzdIttf7JMtBNiNGRBoUhFsIBMFoVemFGj
         IRMC6pRLr/ncwc6GjCsi/yxdDSq0u/Gv/0m2h+Ry95kdRygSYiUPvgWA4fuWQ7Cyr8yC
         ppJycoIlEh3ip5KwrgDf1Asea2oaROPGXSnIZDXJ49hscrCO3XIVpH4K/LMnBTqkV9qz
         SIz/mG35ozbXhbDQn0BzeqJVjHatsU4GUNGTq7tHfYeaaQEMy2dPQu7LIE7q4rUewY5I
         TElA==
X-Forwarded-Encrypted: i=1; AJvYcCUgE81HCMofPiMzBoSS9wcb/P+ZKOU9evc++vcb+aLPTAb+/7TBIEEjfPD9L8Rh38JdMjEE+8jwy0ClUvUc+UOkfjrvNg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/wqNCApnZgsM08/XekM0T7JUNtxBsTIgMJsMR/K2ZJCGTOzAF
	HfJDAY/11/ujlQsdr1yLk+TNKWdR20DTPwRwlyW/4rRGn1oDyySIeNwM
X-Gm-Gg: ASbGncuoRHwpMv7objHh5C0sIVF+Pa9u42/kt0bf7v9tyAyLXlafG7LXq6yFqbXKDM2
	VmUVz+DspBNRKCRWKudkFX2Na8SQhSNgD8RszLgSosI2fgTQBJH9hbLfVQZ5gbXVGYwOA9eA7tq
	AAZyIeoLVBhK+B0ASuQOiHfxu0ujAQZKOOAiIPUYZWF+lndTfnM+dPh3s8mhZyJmoI8ovAp660z
	3dEqJ/vr/Cro8uGE1EDSg7UwsBE1x/lM1ntzKEQhsCgYucfOxvl/g4d1MqWXUv8wPZF7kEtoFLZ
	AXI6m4V6R+UYHRejBgalXkQ+4nM8tZqNSdVVr1OJY/3faOkpqHIxfL6Ds4Fh3hu29tSYc/7UeWx
	hgg70z59+xeLOBF8MmUohRIYNzQ6G1MvNs647dZTbPLhG5GlLz/eJyO7veeaoBJ4AqO/uj9y8oE
	0wWErfOw0Eog0c3bNse+WxGZAGoO1W2ja+mziVEy4kEgezrkkV1se0k0sxIVCA
X-Google-Smtp-Source: AGHT+IGxJK6Xw36yC9SwViNrBL/WLZBKgE8KWPvCEUcD2HXBt7ssWTIpj4dJaAxpOkirzPNFrdFjqQ==
X-Received: by 2002:a05:690e:dcb:b0:644:5363:a9d2 with SMTP id 956f58d0204a3-6445363aa46mr1665443d50.71.1765072305614;
        Sat, 06 Dec 2025 17:51:45 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae534sm33158417b3.3.2025.12.06.17.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 17:51:43 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 0/5] Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sat,  6 Dec 2025 20:51:26 -0500
Message-ID: <20251207015132.800576-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is version 4 of the LANDLOCK_ADD_RULE_NO_INHERIT series, which
implements a new flag to suppress inheritance of access rights and
flags from parent objects.

This series is rebased on v6 of Tingmao Wang's "quiet flag" series.

The new flag enables policies where a parent directory needs broader
access than its children. For example, a sandbox may permit read-write
access to /home/user but still prohibit writes to ~/.bashrc or
~/.ssh, even though they are nested beneath the parent. Today this is
not possible because access rights always propagate from parent to
child within a layer.

When a rule is added with LANDLOCK_ADD_RULE_NO_INHERIT:

  * access rights on parent inodes are ignored for that inode and its
    descendants; and
  * operations that change the filesystem ancestors of such objects
    (via rename, rmdir, link) are denied up to the VFS root
    (new in v4); and
  * parent flags do not propagate below a NO_INHERIT rule.

These parent-directory restrictions help mitigate sandbox-restart
attacks: a sandboxed process could otherwise move a protected
directory before exit, causing the next sandbox instance to apply its
policy to the wrong path.

Changes since v3:

  1. Trimmed core implementation in fs.c by removing redundant functions.
  2. Fixed placement/inclusion of prototypes.
  3. Added 4 new selftests for bind mount cases.
  4. Protections now apply up to the VFS root instead of the mountpoint
     root.

Changes since v2:

  1. Add six new selftests for the new flag.
  2. Add an optimization to stop permission harvesting when all
     relevant layers are tagged with NO_INHERIT.
  3. Suppress inheritance of parent flags.
  4. Rebase onto v5 of the quiet-flag series.
  5. Remove the xarray structure used for flag tracking in favor of
     blank rule insertion, simplifying the implementation.
  6. Fix edge cases involving flag inheritance across multiple
     NO_INHERIT layers.
  7. Add documenting comments to new functions.

Links:

v1:
  https://lore.kernel.org/linux-security-module/20251105180019.1432367-1-utilityemal77@gmail.com/T/#t
v2:
  https://lore.kernel.org/linux-security-module/20251120222346.1157004-1-utilityemal77@gmail.com/T/#t
v3:
  https://lore.kernel.org/linux-security-module/20251126122039.3832162-1-utilityemal77@gmail.com/
quiet-flag v6:
  https://lore.kernel.org/linux-security-module/cover.1765040503.git.m@maowtm.org/

Example usage:

  # LL_FS_RO="/a/b/c" LL_FS_RW="/" LL_FS_NO_INHERIT="/a/b/c"
    landlock-sandboxer sh
  # touch /a/b/c/fi                    # denied; / RW does not inherit
  # rmdir /a/b/c                       # denied by ancestor protections
  # mv /a /bad                         # denied
  # mkdir /a/good; touch /a/good/fi    # allowed; unrelated path

Again, if preferred, I'm happy to split the selftests into multiple
commits.

This version simplifies a lot of the code in the core implementation.
Special thanks to Tingmao Wang for your valuable feedback.

Thank you for your time and review.

Regards,
Justin Suess

Justin Suess (5):
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT userspace api
  samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to
    landlock-sandboxer
  selftests/landlock: Implement selftests for
    LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT

 include/uapi/linux/landlock.h              |  29 +
 samples/landlock/sandboxer.c               |  13 +-
 security/landlock/fs.c                     | 389 ++++++++++-
 security/landlock/ruleset.c                | 108 +++-
 security/landlock/ruleset.h                |  29 +-
 security/landlock/syscalls.c               |  16 +-
 tools/testing/selftests/landlock/fs_test.c | 710 +++++++++++++++++++++
 7 files changed, 1285 insertions(+), 9 deletions(-)


base-commit: 92f98eb2cc08c6e2d093d4682f1cd1204728e97e
-- 
2.51.0

