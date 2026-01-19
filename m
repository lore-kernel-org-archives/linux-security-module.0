Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A596F35B15F
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832824; cv=none; b=e0jM+2stL+aw3tfy+7Ccc8mzsBDVI9Nk+ifd4KIxMNkEcikPJ05LD7Jh/obQrDBwipml8917u5G+wc7if1JjW3ElxcBIoIqn+dwW4LC3GYcMm4vBgswork2gg9P+60KZ71B/sd+mCaIhtL8OP4a9PJ/+fLLaRvOrqqdPfo9W2vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832824; c=relaxed/simple;
	bh=GDize0Egb1nCJUitXSfHT4eekC8TEFxuEjiWsp9JZec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHdefCtf+cRpkOgqoA2AvTfqd8WSeM+HrgGMl5lsH+5vL1HLV1E1b4qFUBMtPW7KYH10G/Mzan4pP0ZAtk5FeEKOzd7Roda1Z8BmHOobPqBZ7e21ZUQhpFXrf2JvgnkhQ342lHYxHYqOQLncpW/tzES1ccC6vGEkjrQa+TkIO24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5Qk4al2; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5Qk4al2"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6442e2dd8bbso3318467d50.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 06:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768832822; x=1769437622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJe56JkHE1YD/MRezbrmyR2a6eiGDnrdxW1M4Xs3MEE=;
        b=d5Qk4al27pbhrxmla+1fFF5+ZdhJLXfZGY5FmaN4DXOY0ZNdNMHGQTuJKdppIorlyU
         2yh3BalzvAuUMO4Etiy64BUaiQnkw+J7eQgAWie8Z30yahTG/djUw5LIN4fEN/8o/d00
         N3Lfu2zAx7zV11t9fx+zb7e6gJ7PZebgzcPbs32Lp4qWRkRiN4XXHUE6eNUPs4KoTwxL
         fHarB7N9Z4k0dGouV46Ir8NRY1fcItUA1t216y6nAVFxKydFrI8ayagAjlLCX6b7HwqI
         Y2d4TWl2szIdSMvrb0bUz/vLWz6akra56SbFVH76+2cd8CZNwIlb+xLicqfy7M60tfFd
         uTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832822; x=1769437622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJe56JkHE1YD/MRezbrmyR2a6eiGDnrdxW1M4Xs3MEE=;
        b=lCkHqIvouLkDpo69eVQWc/mD+BHljx7+iufBJhNSn/eGOZIYqNY9LpgzycPxW9U7DA
         kOQaI8XfPm3VXmqvKW+TjvmllSgDRu/JxgSbGh5b1PDVbezVlvRQbMxgjlPBFBgFRz94
         6CroUZQgnip1WbTLsvH9rwGX+MC+fV47OGYBcrOc7ukg7PH+T9U6FlUPWNUzaw+cWR0l
         Ns/q3XJrFuSd+XHTkfZZmrbRrRxYze33tS67rTozCqSxeItq2lpia8yuA229vQfvsIfl
         TI74JnSEA6RQrRRpVpE4L0elRbx0i0/whlWTSPjbn8YOygN/TAYcKcLy6nZBNnA1t87a
         c0zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQfyXyim27lyyCmfReIzGbglUc9oEl3rK67tyRYavr4YefkXp9xjp1xvwnDzrbt5Ad0QlmB3X2WOcQEl2Ydk56nz2JS3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH53zQL1BiH2IgkdroLRDtOTGNyBOxxzNecf6bQrtaU8Qx6j5R
	XktpXlmlLPgfVdyVdPK3mAoilFxEmoUUhLtvb6u0XS8WNpdttW9tMppEcewCjw==
X-Gm-Gg: AZuq6aJF48gb7FmTVv1bUk4DUIoRFunTpORZqXwQzfQis8rrCv7eh6oEJh3fv9Lbqnh
	uWzhQE75+MM8RXdIxF9HabBVp8iOAm4tOh3uEK+eJUVapt3/p2QgFUvPbJGTNZx/q1DoJRfgQF9
	rUMtgNxw6FcMA9/IRfDaYtoSMBxCOjor1qozJ0TI0YnWCwpWyV8m9yH31KAjahrVYksLN2peYKQ
	hh52nYneKfayAxvWV+fPBUhpau9f1WkUkPKirwj8RLUByM0ko7pAK3/W2BSlrluSIFrf9JreWlw
	WQJ3DztxBAmkfe3A/9ApUKklWkQVdEZil38lJQXSVVbQ7wQADvTr+r/h/JD43q3HI1cwiDtdCzt
	dlgky8qPGOdjVsIK7e73SuACbqMR+d6dkouGA/fRHMlQgieX2XeDgd7TL2R0tyQenUbGUJj+GSm
	a/HJ5ItJFO3KGTchfqUl1y1pgaslw0W9gXi74QIhJwiJncvaaNU3i1qbk7YocEw8Mi6WPnei5jx
	CZ7Ndob
X-Received: by 2002:a05:690e:d0a:b0:63e:17d8:d977 with SMTP id 956f58d0204a3-64916498e52mr9168899d50.41.1768832821395;
        Mon, 19 Jan 2026 06:27:01 -0800 (PST)
Received: from [10.10.10.50] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c68c76cesm40661957b3.54.2026.01.19.06.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:27:00 -0800 (PST)
Message-ID: <b7a2444d-c3af-428f-904e-ec5a6452e513@gmail.com>
Date: Mon, 19 Jan 2026 09:26:59 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] Implement LANDLOCK_ADD_RULE_QUIET
To: Tingmao Wang <m@maowtm.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>,
 linux-security-module@vger.kernel.org
References: <cover.1766330134.git.m@maowtm.org>
Content-Language: en-US
From: Justin Suess <utilityemal77@gmail.com>
In-Reply-To: <cover.1766330134.git.m@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/21/25 10:20, Tingmao Wang wrote:
> Hi,
>
> This is the v7 of the "quiet flag" series, implementing the feature as
> proposed in [1].
>
> v6: https://lore.kernel.org/all/cover.1765040503.git.m@maowtm.org/
> v5: https://lore.kernel.org/all/cover.1763931318.git.m@maowtm.org/
> v4: https://lore.kernel.org/all/cover.1763330228.git.m@maowtm.org/
> v3: https://lore.kernel.org/all/cover.1761511023.git.m@maowtm.org/
> v2: https://lore.kernel.org/all/cover.1759686613.git.m@maowtm.org/
> v1: https://lore.kernel.org/all/cover.1757376311.git.m@maowtm.org/
>
> v6..v7:
>
> - Remove "landlock: Fix wrong type usage" (merged)
> - Revert back to taking rule_flags separately from landlock_request until
>   we call landlock_log_denial (https://lore.kernel.org/all/20251219.ahn3aiJuKahb@digikod.net/)
> - Rebase to mic/next
>
> v5..v6 rebases on top of the new simpler disconnected directory handling,
> change some bools into u32, and fix some typo and style.
>
> v4..v5 addresses review feedbacks, most significantly:
>   - reduces code changes by pushing rule_flags into landlock_request.
>   - adding test cases for two layers handling different access bits.
>
> v3..v4 is a one-character formatting change, plus more tests.
>
> We now have 5 patches for the selftest - I'm happy to squash it into one
> depending on preference (and happy for Mickaël to do the squash if no
> other feedback):
> - selftests/landlock: Replace hard-coded 16 with a constant
> - selftests/landlock: add tests for quiet flag with fs rules
> - selftests/landlock: add tests for quiet flag with net rules
> - selftests/landlock: Add tests for quiet flag with scope
> - selftests/landlock: Add tests for invalid use of quiet flag
>
> v2..v3:
> Not much has changed in the actual functionality except various comment,
> typing, asserts and general style fixes based on feedback.  The major new
> thing here is tests (a bit of KUnit squashed into the optional access
> commit, a lot of selftests especially in fs_tests.c).
>
> The added fs_tests should exercise code path for optional and non-optional
> access, renames, and mountpoint and disconnected directory handling.  I
> will add the above missing bits to v4.
>
> Removed:
> - "Implement quiet for optional accesses"
>     (squashed into "landlock: Suppress logging when quiet flag is present")
>
>
> Old feature summary below:
>
> The quiet flag allows a sandboxer to suppress audit logs for uninteresting
> denials.  The flag can be set on objects and inherits downward in the
> filesystem hierarchy.  On a denial, the youngest denying layer's quiet
> flag setting decides whether to audit.  The motivation for this feature is
> to reduce audit noise, and also prepare for a future supervisor feature
> which will use this bit to suppress supervisor notifications.
>
> This patch introduces a new quiet access mask in the ruleset_attr, which
> gets eventually stored in the hierarchy. This allows the user to specify
> which access should be affected by quiet bits.  One can then, for example,
> make it such that read accesses to certain files are not audited (but
> still denied), but all writes are still audited, regardless of location.
>
> The sandboxer is extended to show example usage of this feature,
> supporting quieting filesystem, network and scope accesses.
>
> Demo:
>
>     /# LL_FS_RO=/usr LL_FS_RW= LL_FORCE_LOG=1 LL_FS_QUIET=/dev:/tmp:/etc LL_FS_QUIET_ACCESS=r ./sandboxer bash
>     ...
>     audit: type=1423 audit(1759680175.562:195): domain=15bb25f6b blockers=fs.write_file,fs.read_file path="/dev/tty" dev="devtmpfs" ino=11
>     ^^^^^^^^
>     # note: because write is not quieted, we see the above line. blockers
>     # contains read as well since that's the originally requested access.
>     audit: type=1424 audit(1759680175.562:195): domain=15bb25f6b status=allocated mode=enforcing pid=616 uid=0 exe="/sandboxer" comm="sandboxer"
>     audit: type=1300 audit(1759680175.562:195): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5565c86113d1 a2=802 a3=0 items=0 ppid=605 pid=616 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
>     audit: type=1327 audit(1759680175.562:195): proctitle="bash"
>     bash: cannot set terminal process group (605): Inappropriate ioctl for device
>     bash: no job control in this shell
>     bash: /etc/bash.bashrc: Permission denied
>     audit: type=1423 audit(1759680175.570:196): domain=15bb25f6b blockers=fs.read_file path="/.bash_history" dev="virtiofs" ino=36963
>     ^^^^^^^^
>     # read outside /dev:/tmp:/etc - not quieted
>     audit: type=1300 audit(1759680175.570:196): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5565c868e400 a2=0 a3=0 items=0 ppid=605 pid=616 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
>     audit: type=1327 audit(1759680175.570:196): proctitle="bash"
>     audit: type=1423 audit(1759680175.570:197): domain=15bb25f6b blockers=fs.read_file path="/.bash_history" dev="virtiofs" ino=36963
>     audit: type=1300 audit(1759680175.570:197): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5565c868e400 a2=0 a3=0 items=0 ppid=605 pid=616 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
>     audit: type=1327 audit(1759680175.570:197): proctitle="bash"
>
>     bash-5.2# head /etc/passwd
>     head: cannot open '/etc/passwd' for reading: Permission denied
>     ^^^^^^^^
>     # reads to /etc are quieted
>
>     bash-5.2# echo evil >> /etc/passwd
>     bash: /etc/passwd: Permission denied
>     audit: type=1423 audit(1759680227.030:198): domain=15bb25f6b blockers=fs.write_file path="/etc/passwd" dev="virtiofs" ino=790
>     ^^^^^^^^
>     # writes are not quieted
>     audit: type=1300 audit(1759680227.030:198): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5565c86ab030 a2=441 a3=1b6 items=0 ppid=605 pid=616 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
>     audit: type=1327 audit(1759680227.030:198): proctitle="bash"
>
> Design:
>
> - The user can set the quiet flag for a layer on any part of the fs
>   hierarchy (whether it allows any access on it or not), and the flag
>   inherits down (no support for "cancelling" the inheritance of the flag
>   in specific subdirectories).
>
> - The youngest layer that denies a request gets to decide whether the
>   denial is audited or not.  This means that a compromised binary, for
>   example, cannot "turn off" Landlock auditing when it tries to access
>   files, unless it denies access to the files itself.  There is some
>   debate to be had on whether, if a parent layer sets the quiet flag, but
>   the request is denied by a deeper layer, whether Landlock should still
>   audit anyway (since the rule author of the child layer likely did not
>   expect the denial, so it would be good diagnostic).  The current
>   approach is to ignore the quiet on the parent layer and audit anyway.
>
> [1]: https://github.com/landlock-lsm/linux/issues/44#issuecomment-2876500918
>
> Kind regards,
> Tingmao
>
> Tingmao Wang (9):
>   landlock: Add a place for flags to layer rules
>   landlock: Add API support and docs for the quiet flags
>   landlock: Suppress logging when quiet flag is present
>   samples/landlock: Add quiet flag support to sandboxer
>   selftests/landlock: Replace hard-coded 16 with a constant
>   selftests/landlock: add tests for quiet flag with fs rules
>   selftests/landlock: add tests for quiet flag with net rules
>   selftests/landlock: Add tests for quiet flag with scope
>   selftests/landlock: Add tests for invalid use of quiet flag
>
>  include/uapi/linux/landlock.h                 |   64 +
>  samples/landlock/sandboxer.c                  |  129 +-
>  security/landlock/access.h                    |    5 +
>  security/landlock/audit.c                     |  255 +-
>  security/landlock/audit.h                     |    3 +
>  security/landlock/domain.c                    |   33 +
>  security/landlock/domain.h                    |   10 +
>  security/landlock/fs.c                        |  120 +-
>  security/landlock/fs.h                        |   19 +-
>  security/landlock/net.c                       |   10 +-
>  security/landlock/net.h                       |    5 +-
>  security/landlock/ruleset.c                   |   19 +-
>  security/landlock/ruleset.h                   |   38 +-
>  security/landlock/syscalls.c                  |   72 +-
>  tools/testing/selftests/landlock/audit_test.c |   27 +-
>  tools/testing/selftests/landlock/base_test.c  |   61 +-
>  tools/testing/selftests/landlock/common.h     |    2 +
>  tools/testing/selftests/landlock/fs_test.c    | 2456 ++++++++++++++++-
>  tools/testing/selftests/landlock/net_test.c   |  121 +-
>  .../landlock/scoped_abstract_unix_test.c      |   77 +-
>  20 files changed, 3394 insertions(+), 132 deletions(-)
>
>
> base-commit: 161db1810f3625e97ab414908dbcf4b2ab73c309
Hey Tingmao,

Thank you for your work on this patch-- I don’t have any further nits,
this looks very clean.

Do you plan to rebase/resend this series on the current mic-next branch
at some point? It would be helpful to be able to test it alongside some
of the other Landlock series that are in flight.

Feedback on the latest version of the series has been fairly quiet so far,
and having it rebased would make cross-testing easier. I’d also rebase the
LANDLOCK_ADD_RULE_NO_INHERIT series on top for further consideration.

Kind Regards,
Justin


