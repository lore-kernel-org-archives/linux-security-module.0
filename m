Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833FC221FCF
	for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765731954; cv=none; b=AATjOkBsvhUW008UCQdrSgYYwBOeSn2EIh2u71rX7mfIKwnGcDiw7vDi5srn0KAj8w6YY0saq9bwUz6GtA2zOI9sf3ghUuGHb6lkIG68AIuVm3pwy3Y7kruLBxOlN+KEARhXP0OE3szvkThb1eKBI10JS3gNAOLinOg3MdG7CoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765731954; c=relaxed/simple;
	bh=BY7kNRB4a83tpGAVBj9J//o7/5Dlur1AQ4EuFur6XIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SgiVIZvOfWzrRZguZfjQJPH9qo8xxofOABeKsIBoLHYivDLS4IZ3CqLRU8zauDKh7Yq1XP5LOhE5PuYbi2e3ci8DhpyEuFrW2KEjANok5gMfXsiUeMY8tN+2xfiOXQvlobNh+erHlb2PaK13pyG8d2vCF9lyqD5yGUVTOHTAumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxxiTDHJ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxxiTDHJ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78ab039ddb4so26234057b3.3
        for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 09:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765731951; x=1766336751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qz20YC+zQ8LqogAl4lrXTM7C6VRD5iWgMj34eapj6tw=;
        b=TxxiTDHJ0UKIqePpgWr+d6i6eAgzmreaD/dikuzJIweAB0GlXH4nQWZ3xlTfvEX8bT
         dylvNqKqLF5A60W5DvwAcr5FmB5pZHaVcxnVecDssZv15MKP2FrCM22eAstiqjGCSD/E
         3YmcNzSrFdbeZkPpT46HMwN1G0s63UGpzgWgSaWxWaiD/S976QGRUSVLoFc5GoUjv5xj
         /MgdusYbhq1uZUjygqBG2LyHoNFjnwHBg1Q5zpTbgmIfASNF4rP+EfenTcVaYmrZe87G
         cFXd3XIV7ESiuQ4n5cm5IKhvTWsuyG15g+noHNVJQ4kPGA/UhWo0ezeQ8ujElRNqsY0c
         jS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765731951; x=1766336751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qz20YC+zQ8LqogAl4lrXTM7C6VRD5iWgMj34eapj6tw=;
        b=Atspz3HImUKv8dgkakB344orgVIXyTQ1SNGab3LzhsrXdqcrKcYLixnnq6gXtwPFdh
         lQlQmmuRDK4bOck1HOlp654wf9b9198sCHTs4dGzW+wV/1wuPk2DtOL12/3aCLYvpwcE
         bFXfc4GRBHR2zMNaiQTR0RjTPTvVyLSS3TP2fwxkSEleHolZcoaI8QP5BwMqDvXQljvV
         G/SC+GYYdMxJVX/HbHMrqEJGaKdBZibecKgFBrh8GzV4/hcRcPmhdsf1GgNOYaecXJDh
         2nuYTUFTD94CYAVcm3/185rbTWApnvZDkpwhIGqZu68mxA018t7MOOJUX8fOrIoA/yh4
         VEkA==
X-Forwarded-Encrypted: i=1; AJvYcCUPsE/HSXx5a2I9BlSquuobwR2qDeQyQbEsz0iKdLcXUEGYp+OTXjqB44mKDIWHWEpTzyZy3yIAMcuW+MAe1j43FIUk8YI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoyq8rAcwcsrHC+lwbLq+8d/vP0nsg0mbpaAlkTNy/8J2B95TH
	Xg1tFwTANvcZsfLdtfmSKUCZ69+lmi0NooGwMlCPTvLlKRIkRGk1ofLi
X-Gm-Gg: AY/fxX4TnMbvE/BLtSkHb+/nkCe8RF3MH4RIK0ld0YPY5wHbs57cEZ2Eak4NJdgNAsk
	9NkcwxAl+mG42FOtcsyTahiE0UskVEcVRoHPS/WhlCn4z1u0UXRnF1+vV/nM/Yt7NgHaLtJi/iY
	mTiPLLwp0nkzTJJbuuAN9Te+ZbXt2tdR/pbPFuCP8QVi06BPkWQIsirXjId2UlxlEmX2Z/NIz2V
	y5F2EPpE+fknhX+fFra2rTBtrb2tLU543IB7ha5bjoRq4H/KSzgPiD8zsCuWSD7v0IN/1RtmxnU
	j623HoAOibytRMUEiulko+iZUglqHZwGLh30ERJ6dDaRHYlZiCmqOGH0XIDYVzlB2uX+D8wO75I
	sevLMeOwZgnQMEJgB+s8CQPydcESQdWBKNRBJZAV7UpsMiUrgElciQrPhg8HutEeO6hMQUodwrm
	AYGeIo2ZLb4/yYrxPP494s1hjNR3BBe4XgZ4+xi4m71VQkNs8EB+q2fEF4u6Uz
X-Google-Smtp-Source: AGHT+IE+4CavXz7HaxXVRelEOPUwkOkyUgIBOAMT/1y5w1R6ah2VfKfoXjhow2ghF0CHzz71nRR01A==
X-Received: by 2002:a05:690e:144d:b0:63e:145f:a4bd with SMTP id 956f58d0204a3-645555db7a8mr6157403d50.22.1765731951315;
        Sun, 14 Dec 2025 09:05:51 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e749e7683sm19401117b3.32.2025.12.14.09.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 09:05:50 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 0/6] Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sun, 14 Dec 2025 12:05:40 -0500
Message-ID: <20251214170548.408142-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is version 5 of the LANDLOCK_ADD_RULE_NO_INHERIT series, which
implements a new flag to suppress inheritance of access rights and
flags from parent objects.

This version of the series focuses on simplification and cleanup.
Behavior of the flag is identical to the previous patch.

This version has 1136 insertions(+), 72 deletions(-), down from
1285 insertions(+), 9 deletions(-), while adding documentation
and retaining all existing tests.

This series is still based on v6 of Tingmao Wang's "quiet flag" series.

Previous patch summary:

The new flag enables policies where a parent directory needs broader
access than its children. For example, a sandbox may permit read-write
access to /home/user but still prohibit writes to ~/.bashrc or
~/.ssh, even though they are nested beneath the parent. Today this is
not possible because access rights always propagate from parent to
child inodes.

When a rule is added with LANDLOCK_ADD_RULE_NO_INHERIT:

  * access rights on parent inodes are ignored for that inode and its
    descendants; and
  * operations that change the filesystem ancestors of such objects
    (via rename, rmdir, link) are denied up to the VFS root.
  * parent flags do not propagate below a NO_INHERIT rule.

These parent-directory restrictions help mitigate sandbox-restart
attacks: a sandboxed process could otherwise move a protected
directory before exit, causing the next sandbox instance to apply its
policy to the wrong path.

Changes since v4:

  1. Trimmed ~120 lines from core implementation in fs.c.
  2. Centralized path traversal logic with a helper function
     landlock_walk_path_up.
  3. Fixed bug in test on applying LANDLOCK_ADD_RULE_NO_INHERIT on
     a file, giving it valid access rights.
  4. Restructured commits to allow independent builds.
  5. Adds userspace API documentation for the flag.

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
  https://lore.kernel.org/linux-security-module/20251105180019.1432367-1-utilityemal77@gmail.com/
v2:
  https://lore.kernel.org/linux-security-module/20251120222346.1157004-1-utilityemal77@gmail.com/
v3:
  https://lore.kernel.org/linux-security-module/20251126122039.3832162-1-utilityemal77@gmail.com/
v4:
  https://lore.kernel.org/linux-security-module/20251207015132.800576-1-utilityemal77@gmail.com/
quiet-flag v6:
  https://lore.kernel.org/linux-security-module/cover.1765040503.git.m@maowtm.org/

Example usage:

  # LL_FS_RO="/a/b/c" LL_FS_RW="/" LL_FS_NO_INHERIT="/a/b/c"
    landlock-sandboxer sh
  # touch /a/b/c/fi                    # denied; / RW does not inherit
  # rmdir /a/b/c                       # denied by ancestor protections
  # mv /a /bad                         # denied
  # mkdir /a/good; touch /a/good/fi    # allowed; unrelated path

About 120 lines of code have been removed from the fs.c file, achieved by
removing/streamlining many of the previous functions, and adding shared
path traversal logic.

Simplifying the path handling has a nice side effect of making some hairy
functions (is_access_to_paths_allowed) more readable.

All tests added by this series, and all other existing landlock tests,
are passing. This patch was also validated through checkpatch.pl.

Special thanks to Tingmao Wang and Mickaël Salaün for your valuable
feedback.

Thank you for your time and review.

Regards,
Justin Suess

Justin Suess (6):
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT userspace api
  samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to
    landlock-sandboxer
  selftests/landlock: Implement selftests for
    LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Add documentation for LANDLOCK_ADD_RULE_NO_INHERIT

 Documentation/userspace-api/landlock.rst   |  17 +
 include/uapi/linux/landlock.h              |  29 +
 samples/landlock/sandboxer.c               |  13 +-
 security/landlock/fs.c                     | 266 ++++++--
 security/landlock/ruleset.c                | 108 ++-
 security/landlock/ruleset.h                |  29 +-
 security/landlock/syscalls.c               |  16 +-
 tools/testing/selftests/landlock/fs_test.c | 730 +++++++++++++++++++++
 8 files changed, 1136 insertions(+), 72 deletions(-)


base-commit: 92f98eb2cc08c6e2d093d4682f1cd1204728e97e
-- 
2.51.0

