Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC0621255A
	for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789870040; cv=none; b=PLdDTQ87dDtKdEenAF3KnSTdlV7eJ1ynK5vKU7QdCEnORq/HAyfQk8uR5jjjaV/qe4uXdT6Re/wT5zIflNl0wgfoXn7UGBvTSzuMxFD9CtLfrqWe+WeQaS2sQB9nWA+N9DC09RZRFQraCMNFNEilWy6PG7TkROPfd7/wJibtqcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789870040; c=relaxed/simple;
	bh=v3ioTneesQ4IhyYIfJxKV4qgKfus9Larac1jgDv+YKU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=VaTzvAThE4XaDFIj70/8J20l+PtolrI8is2Ha4RqFvH/egCqwSF0LN/qaInobVtZg7eSdyJn5tGaKlH3euo1OqXjvOc7tJS6xQEx4h+74snOZHg8JTcopv+RgEg7svEsOTvvqcVUK7Gavzimcf5Hyly0vkvM3lRb/nBKzMq1AzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f72xp97m; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f72xp97m"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-912628ea724so6852136d6.0
        for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 19:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789870037; x=1790474837; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G3+zGNgJRkxBaioG5ib3jA+WMEMkM7qf13aN5UYh0n8=;
        b=f72xp97mARjRcuBps6jbRNZ7PRLKmF96Z0UzNvppBVEZEBzPSfC/be0f53Lmek/qcw
         +oEMAzIY1u5NG+N1dDL5Q5Cx6whNdo/Sx/IQ/+REPfHT4SQAY7qUyM7UD0eISTyFgw5m
         /Mn06FdHxgIZ7y8dpKbTS59Uc/wrC807Gpu95w6NFvKGNNFqpA3sB3WqtAVpcn3UdWYC
         0JUiI1ndhrmFhIM5rtY+0wdJBPKIRRa20/iP0521s/pIkzV2bAp9raYshiyojNaTYbok
         K0SmnYOBG0rSfKcd4u9xTROuaWC7wL/ZyciP+DRroV2j2/bZ0OJW0IoAU6YS0Cjblr0L
         293Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789870037; x=1790474837;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G3+zGNgJRkxBaioG5ib3jA+WMEMkM7qf13aN5UYh0n8=;
        b=dka/yB9wGlFUmi15fq9yhLEdESj3H2EZx9+RBj/toSay15Tgy5kT9h6/63KJjpMnWY
         c5GmzT0zIN9O3JmsU1xzqpuEATLuevlIH+S0XxGiW/qfqjUt9u2fxuDr3zhKj0e8nWIF
         QY4EqaGQf087FmJD/GM/3W+hFTTkxTt+sZ80G6kdBlrE7Xrdy1oM88Nk4gIaQIDOKgkR
         c715JhVQeS8iE6RKa9ozAn1uA6b8LFipTG8Rj7hjePY06R4Asq3sknxdja+EwOH+TSLP
         InU9IrgulpKdRTuPdntOJAlU2IL4EhQ8BhVEQm0pIZm3cTZu9cnkPRFHV+XBaaCrQS/3
         0R6A==
X-Forwarded-Encrypted: i=1; AKwUvByoljfnTrvMY7kIOKNE9x4KSR2GW1o+U/cZBZYNbLWZmDU0jA6D2C7AAIrl2VJU8X5EPBxe4QAGnw4DbAGcrv0Y0vcQe38=@vger.kernel.org
X-Gm-Message-State: AFuF++mP2H3zFWT5HL7KKyd3o/KmqxZMMF7uG41TesDMsTG/Ta5JmZnE
	XZRezzhU3xAONW3kAo6OSfE3hLCmfonKDZTzStvom/tnRPdtZ89aq8Zb0U5SFBfxKukyXf5al4h
	JgJ4SkA==
X-Gm-Gg: AYBFou2MeoEvV0ZfsmaraLrSyBNPgmOn2rNKqeVlQhtbUyL+1VrUZW0wMu13bLJOBwS
	NjCWZmr7AYAcBw51yT7v93tSFpPggKIALl8Ge6s646yeatJUyX71mTNqrO54N62380pTCu4ZfYG
	NdYE34xLgRGIf0R3ZFieN98kAZ5mbunOeLztq/SjBdVdQPngl5TibIYUfrqmeHI64PtO9izrEtH
	ox7+me1uikvn4XgCh1CJOFIbTMsvzUQZtyNPrZQMbNTdy00WdQsa4WxAPSU+H3QYySR1rmhWsyS
	q9kn93mAiq01dbxadD0079J4+LG6a/kf1Kos5ey1kZAcgLPYwUC1ghFq98VDPMq/5BNSb9lsUqY
	Zx0E/NEg4a9BMCJk9hiyFlEHabq21wZcSMBfknNw68Ou+1R+FImvpQlt8cDE0H0f01jVhr8oVnp
	ZH1WM3DUmx4rKINBo0aZgu8S1dskNXvVAMqA3rCf/fOXd1uQJOUeQn+qYWKSJvPfxMRoa29r2bq
	UwmNHf3WNkYxjKM6E0QIX9PvpwVzb0J2EgqOJkIXZ5kFaa3MBUXMcFt3t4shkYVx/8Nmb3TjZP9
	pw==
X-Received: by 2002:a05:6214:ca8:b0:912:5951:179b with SMTP id 6a1803df08f44-912a8017caemr43115516d6.30.1789870037098;
        Sat, 19 Sep 2026 19:07:17 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260aa1c03sm33242166d6.39.2026.09.19.19.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 19:07:15 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:07:14 -0400
Message-ID: <932d0e418d78fa40b5d18951a34876ac@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260919
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Three fixes for Linux v7.3-rcX:

- Ensure that the cached SELinux access decisions are correct.

- Fix the SELinux overlayfs code to properly track the top-level/user
information on multiple stacked overlayfs filesystems.

- Fix the SELinux overlayfs code to properly enforce mprotect() access
control policy on all of the different layers in multiple stacked
overlayfs filesystems.

Paul

--
The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260919

for you to fetch changes up to 78fc54b934bfb2c18aad8154c7302067146946f9:

  selinux: recheck intermediate backing files on mprotect()
    (2026-09-15 23:30:07 -0400)

----------------------------------------------------------------
selinux/stable-7.3 PR 20260919
----------------------------------------------------------------

Christian Göttsche (1):
      selinux: always fill AVC decision in avc_has_perm_noaudit()

Karl Mehltretter (2):
      selinux: preserve user SID across nested backing files
      selinux: recheck intermediate backing files on mprotect()

 security/selinux/avc.c            |    5 
 security/selinux/hooks.c          |  158 ++++++++++++++++++++++++++----
 security/selinux/include/objsec.h |   10 +
 3 files changed, 150 insertions(+), 23 deletions(-)

--
paul-moore.com
