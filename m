Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE0302748
	for <linux-security-module@vger.kernel.org>; Fri, 21 Nov 2025 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763758653; cv=none; b=WHiDOXb3q55P/NvoiGixpvKRgfDTI6ZQT5OwgnINH+DcU0UqhcvNvNuYf6SlwYj3pws59Z3QIBjsSWUHFNDwUd+i5aiDcsQKsfW1Dkqar1UvnT1w2Z97UBl5hGtNRVwBg4HkAoe3x35FUwbVyFrfiq4DBMADBC5UHqBqHeJRKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763758653; c=relaxed/simple;
	bh=JKijqc8wOYCjKCXxb/aASNxNvgctpBpqhlMRIAeEcmA=;
	h=Date:Message-ID:From:To:Cc:Subject; b=gq3gxva+IoWft4jFxOOq30zxOPjqcWiBqaaqpSdJG/oGg+sQLtTMLOdWyljMVqWfkuEz49WmVXdx2C0FTRq5le3m+J8l0Up5nRK6TNLg80pWFP8GbYqQN110Un1nYqv2AzW9H08XjkfYkDfwW0Wa+lSDLIlZUi7d00Tde8W+2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E7k5hkYM; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E7k5hkYM"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-882379c0b14so17856166d6.1
        for <linux-security-module@vger.kernel.org>; Fri, 21 Nov 2025 12:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763758649; x=1764363449; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HguO6GcHAOvEOIpYcUY0fN2LJojxdMWo0XdVG/dzQM=;
        b=E7k5hkYMIcgQjjEOGdv9N3sOKdZZAOryd10lyJX5lz0xxxSAhsMK/7sulmn3Z7kIx+
         GXwRqez/DJfZVKwYO0wcLf8KykL5VKyBfjtsxUH+o36TCnQDK9Ujc1vBx0OlAvOXKuyH
         DGdiEuY40gaAjGldZn/rjhcvSNb7R0pHyI4gFHtXwEA0TnO142HZxwvN4Y5pDGMjibi9
         0HrnDfnLVIyVjLooshITpdTcpx+9dyeLwW31fFqiHyiNmWXg/wrmdrwAdVaxySMrXdm1
         tjfF9ugUAOeiWDhdVnAXEpwQyPxwXMk1g3q5U2BM2BwY/c+wKWOjoFACo+18ZpJ7/Oxj
         W/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763758649; x=1764363449;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2HguO6GcHAOvEOIpYcUY0fN2LJojxdMWo0XdVG/dzQM=;
        b=IUORo+cmM7pj5yeV+z68PGP+jN2YRAyIhEwVQfwnvGug6amdHpMVgA4nLhmSVy9nom
         AC1hxN4MEIP26COr+t//GnPz8/fpeyGcFPJTvPl3B2xiuCdP/pbkJCUr14RSfkCstDZ5
         +L8W6JhfNZr0UVZ+ol4XgvHdYbVJ1SdJFg69sfZEUDUkcp2zYWvCyAZCQl0nQXCPeEyH
         iIlQ1KEQo4WsE8Uc+Bus23HnN9W1I1dLuim15T8Hdid3E5r7ucykNU+3q9RkYc7oa9RV
         V49vFMbpkA7DTVUWCvABX0A7u1k7Z2zy/TTmo36NPJKAOTswUyzodWiXPPulN3q6XhCt
         kJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqnT1H7jGcewwC8sfn3U4VtGg4fretRAoX5DGzJ99OayZkViR6iG6iVwMqOrPgXTP+9uccaZM7E6hB9nYGjaFhYl78KbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Z5Rg1Yvt7SFuND11ZA2Zu7o7+gCIvf9G08sKLDYsxhipVyvR
	4eiOXdoNZEbjIMwrIcZGKajCb73JosTwK8egJ1daf0K2+8CtdhWkwjMHPbdogsrzHA==
X-Gm-Gg: ASbGnctgMZEJcclqeM9YSNGBGXCathjMtmWM8mNULKofkQk2iwYCtiIHAWLfGy3SByh
	syevGpo28TXT1Qj3W197Wg8+9d+0yruK+t5Qat4W4whw/G7jII4GBiV2/rsv8ZJ60bfQnli5a5A
	KkbCvfKprL0/JwfFlyFVL9QJ8FkVJISOTklJZvjdb/klhYg0nAMQeM6yPEZ+5jOEdAsqbn8Hpui
	+3n+rkXPvCUfAv+reZormzolw2k0vz2M4KavgEpNlgtlUQwjnzP7E2CMboSbQgOEyg4eNOQgEcJ
	1GZyWdpjJ0WMnKp++b6wlxy4bxDCuDHECg5LTlpr7YZr0DATSGzd/4Z37GhQNNdHHCNzyNILKVm
	/60rRV2WmdweqGQCbq8nJLzB5fsIVFZR5CqHbFwD/mJc9+bCbEzgm83iCpmiDsmk7QVaNMEmSxC
	jiy+ysb+jKD7Kr9JpeMQcEhi86hbHmswWWxKwUY5qef0y9Z7aACyIpU578
X-Google-Smtp-Source: AGHT+IFbGD/DPFVnjSByEUCrBh+IgINtUgnb9tnflkGpR6ozD7bUcSF3T1wUKOd2pAWkBWwGqFqWIA==
X-Received: by 2002:ad4:5ca4:0:b0:880:4dd2:1d0b with SMTP id 6a1803df08f44-8847c5796c9mr57289356d6.58.1763758648692;
        Fri, 21 Nov 2025 12:57:28 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54e7bfsm46637936d6.29.2025.11.21.12.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 12:57:27 -0800 (PST)
Date: Fri, 21 Nov 2025 15:57:27 -0500
Message-ID: <e6a2c26951147ce12c57ff1fd53651c0@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20251121
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Hi Linus,

Three SELinux patches for v6.18 to fix issues around accessing the
per-task decision cache that we introduced in v6.16 to help reduce
SELinux overhead on path walks.  The problem was that despite the
cache being located in the SELinux "task_security_struct", the
parent struct wasn't actually tied to the task, it was tied to a cred.

Historically SELinux did locate the task_security_struct in the
task_struct's security blob, but it was later relocated to the cred
struct when the cred work happened, as it made the most sense at the
time.  Unfortunately we never did the task_security_struct to
cred_security_struct rename work (avoid code churn maybe? who knows)
because it didn't really matter at the time.  However, it suddenly
became a problem when we added a per-task cache to a per-cred object
and didn't notice because of the old, no-longer-correct struct naming.
Thanks to KCSAN for flagging this, as the silly humans running
things forgot that the task_security_struct was a big lie.

This pull request contains three patches, only one of which actually
fixes the problem described above and moves the SELinux decision cache
from the per-cred struct to a newly (re)created per-task struct.  The
other two patches, which form the bulk of the diffstat, take care of
the associated renaming tasks so we can hopefully avoid making the
same stupid mistake in the future.  For the record, I did contemplate
sending just a fix for the cache, leaving the renaming patches for the
upcoming merge window, but the type/variable naming ended up being
pretty awful and would have made v6.18 an outlier stuck between the
"old" names and the "new" names in v6.19.  The renaming patches are
also fairly mechanical/trivial and shouldn't pose much risk despite
their size.

TLDR; naming things may be hard, but if you mess it up bad things
happen.

Paul

--
The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20251121

for you to fetch changes up to 3ded250b97c3ae94a642bc2e710a95700e72dfb0:

  selinux: rename the cred_security_struct variables to "crsec"
    (2025-11-20 16:47:50 -0500)

----------------------------------------------------------------
selinux/stable-6.18 PR 20251121
----------------------------------------------------------------

Paul Moore (1):
      selinux: rename the cred_security_struct variables to "crsec"

Stephen Smalley (2):
      selinux: rename task_security_struct to cred_security_struct
      selinux: move avdcache to per-task security struct

 security/selinux/hooks.c          |  251 +++++++++++++++---------------
 security/selinux/include/objsec.h |   22 +-
 2 files changed, 144 insertions(+), 129 deletions(-)

--
paul-moore.com
