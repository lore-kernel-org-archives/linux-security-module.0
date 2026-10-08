Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1C3876D5
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469608; cv=none; b=RlsQC07UsXkJkMAkEgVjAgidg6So3nFCthhKexxYeXVOxAmwW8csa6GmmjlzwU2mpqTbawKIt5UL/Z/OTbmsNics4vKO7ozBQgL075f6j5PduOezzXS+lHaYOsqJOgiYhfeSXKl+ECbBKF8aE/IozUREvWjY1hp7Nq02Yu1bgg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469608; c=relaxed/simple;
	bh=Myio4zy1rcj3M7L4miPMIF/m5+9bCsWUc2GpKi0dF5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T/MMXDavIwZboOEbsC4GjqPK5d56tAUYUhVFdrVdZQNG3dAfPi+V5i466pQ+95bsRBNNM5R4QISOCnJZdyOxVSp1XjO9lg/Mso2uuH6wdNktV4T/ZcL7WEVyRxP7O5Vr3nAWT384OEVehzzOo86X5CtwCD3EOJ75F6v4echDWhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTUdxb8X; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTUdxb8X"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a16c399641so30621285e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469604; x=1792074404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NzueoD+ES6klpAo68ynClo/FIBtsX+vJEmu8cfaDXg0=;
        b=hTUdxb8XYtQ8ZFe9YL6Rr9/zgRIqMpFSeorffvJA+Y4vFa+V2BSCsmLeYAm3w1NVEd
         ZgOGPy2JEGMN2ahJQoAoTwVn3l0MU6lqqmR0V52Attqv2jU2KWVu+0KDIrsZAX9h4CH4
         5ZsEOajfB3sJc2uKrtz/j7v3hMZKF8k+zhVYEz/h0FiQyUw7Ec/YwIzMiYXZHI07jEFz
         2HBLJPvLPO9PLmU0smFOxy6FdPe/iB+VgaGSyF9wKgpzyxoSst1c4XY1RVJSST0NAsYb
         Ib3ZEz83WjLWzcce+9lo1Kdq3Xc7y2xu194IPrczMGl6XNNZcOzc+4TOZe/lyjBOz8UR
         fQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469604; x=1792074404;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NzueoD+ES6klpAo68ynClo/FIBtsX+vJEmu8cfaDXg0=;
        b=LKoVtfM0Xmwv84NwH+bJg+ENe+OZbaSAkxYYwDG5yVE3ZFAvdUdbkEXnEO2IUT4EZ6
         gD+0rXpZGN7wI8P32Fl5O4Rf05jLIT3fH8kp1X7/f6bEQtKygeeaRq+NVFAiC3upQkVH
         Lc4MycAEyhk4GR6503HhuxYBBsjt2NeI12PEV0HTtYckoQTMnqdHlozvc3IENpprawYt
         pK95eWIMG2ztwY2/nau3NFiuhFG+YZJvrWUVrI4foS6/eTl5WFfAP7xnuaVPIFxDA8qM
         PZejHiP9YAzWGPCV85flmnUQM7hK2/V0HAON+L6V/rMLvdttHSWBfCmLO6xrDIaBIiof
         wTUw==
X-Forwarded-Encrypted: i=1; AKwUvBw536xT7hWnpAG6rJAxS2uJy67+NVpltvsTTMclFCFMvAM9idS3sTvwcjJ7ziJh6bSQ5ptU85Qw6koUEy5vxMndnP+PEh4=@vger.kernel.org
X-Gm-Message-State: AFuF++n4Tf0jEN0/nPE8ZVngP+oF2qTomoIXy9GdpR+dH4kgs37LxPai
	V28w5+uM0AwlDzU7Qx6sJNYKjE7MZxR9ACwwEOh/RlJdtWIMXNdNfiRp
X-Gm-Gg: AYBFou1Ig0IyvKjR1IEWPspufmK56v2crj0sGT0RM+dSNBVp/oTetXj/Zler9NzlTxh
	YGu7ekG+/sBi9VF2HFEtOSfGmM3YXmjHaEXDRhU7n2H7/yXAjhUTb4n/qrZ9g4cVZ27h7rtttYz
	5AxbwetKMyeg6LdMo7vcdQceAYEvtwINgyvpsNmmk02Tl1kFmSV2eAkx4le8P0TNe2GhEJdNKTE
	mdW+o0JuP8CKh9xLJEq7Wjfr9DiJaO3hQwDk73+liZBxCQpyA3TuAheVegQvhIuzdMGYOrfsys1
	1h2feQGh8J4ZflMnqrpf+xo2/Ex3Ys+3uxAFZj3UGbbNtmFFYTf7HJwP+RtSXoRtkphnK1NZadg
	xC/vaaGhdsDckn+FZwEGzlNBnaLi8TFTDL5KIuIOezwaawjk8Aa6hZTO2nSnmqDGwWUAmOkuL9k
	7Dz8jNPxYAg7BWIBnczq7hAC41ZPDKR9faIV3XcWDfKriR9OTqPB7LLpwJsRhzUL7x6YDxhAil3
	H9xXjvV+6V1Chyp9zfhm8pQ
X-Received: by 2002:a05:600c:818c:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-4a180419643mr92571675e9.10.1791469603629;
        Thu, 08 Oct 2026 07:26:43 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1842ab891sm69494435e9.5.2026.10.08.07.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:26:42 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 00/27] landlock: Selftest fixes and cleanups
Date: Thu,  8 Oct 2026 16:25:29 +0200
Message-ID: <20261008142604.39107-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A collection of Landlock Selftest fixes
=======================================

This patch set is bundled together to be slightly less spammy,
but the patches are mostly independent.  The commits are ordered
such that the simpler and more orthogonal patches come earlier.

The patch set is LLM-assisted (and that turned out to be very useful
for spotting errors).  Needless to say, I have verified all commits by
hand, and reworked them where necessary.

The last few patches are a bit more cross-cutting and probably more
prone to merge conflicts, as they correct cases where we have been
using EXPECT and ASSERT in the wrong way (details in the commit
messages).  I believe that the rationale for each of these is
reasonable, but I am happy to discuss.

Motivation
==========

LLMs (and humans ;-)) have an unfortunate tendency to pick up and
replicate bad coding style patterns, so I hope that a broader cleanup
of the test style will avoid this spreading further.


When applying this patch set, please base it on a branch that has Wang
Yan's snprintf() patch in it [1], which I also support as a selftest
cleanup.

–Günther

[1] https://lore.kernel.org/all/20260626070016.61049-1-wangyan01@kylinos.cn/

Günther Noack (27):
  selftests/landlock: Propagate grandchild failures in unix_scoping
  selftests/landlock: Propagate EXPECT failures from forked children
  selftests/landlock: Check the thread result in audit.thread
  selftests/landlock: Zero-initialize the buffer in inconsistent_attr
  selftests/landlock: Fix the openat() success check in fs_bench
  selftests/landlock: Fix the reported clock tick rate in fs_bench
  selftests/landlock: Fix the ruleset_fd check in empty_or_same_ruleset
  selftests/landlock: Handle a missing control message in recv_fd()
  selftests/landlock: Assert tracefs_extract_field() results that are
    used
  selftests/landlock: Assert audit initialization in fixture setups
  selftests/landlock: Assert helper results that are used afterwards
  selftests/landlock: Assert audit_count_records() before using its
    result
  selftests/landlock: Fix memory leak in audit_init_filter_exe()
  selftests/landlock: Make audit_message large enough for any exe filter
  selftests/landlock: Close leaked file descriptors
  selftests/landlock: Check errno for combined VERSION and ERRATA flags
  selftests/landlock: Fix SIGURG handler setup in scoped_signal_test
  selftests/landlock: Fix regex_escape() error handling in
    matches_log_fs_extra()
  selftests/landlock: Fix off-by-one in regex_escape()
  selftests/landlock: Fix the snprintf() error check in
    matches_log_fs_extra()
  selftests/landlock: Use _exit() in the named_pipe_ioctl child
  selftests/landlock: Fix messages and comments in helper programs
  selftests/landlock: Fix stale comments in common.h and audit.h
  selftests/landlock: Use ASSERT for syscall failures before errno
    checks
  selftests/landlock: Assert WIFEXITED() before checking the exit status
  selftests/landlock: Use EXPECT for closing FDs and stopping threads
  selftests/landlock: Use EXPECT for checks that later steps do not need

 tools/testing/selftests/landlock/audit.h      |   20 +-
 tools/testing/selftests/landlock/audit_test.c |   56 +-
 tools/testing/selftests/landlock/base_test.c  |  190 +--
 tools/testing/selftests/landlock/common.h     |   32 +-
 tools/testing/selftests/landlock/fs_bench.c   |    5 +-
 tools/testing/selftests/landlock/fs_test.c    | 1300 +++++++++--------
 tools/testing/selftests/landlock/net_test.c   |   64 +-
 .../testing/selftests/landlock/ptrace_test.c  |   44 +-
 .../selftests/landlock/sandbox-and-launch.c   |    6 +-
 .../landlock/scoped_abstract_unix_test.c      |   45 +-
 .../selftests/landlock/scoped_signal_test.c   |   23 +-
 .../testing/selftests/landlock/scoped_test.c  |    2 +-
 .../selftests/landlock/trace_fs_test.c        |    8 +-
 tools/testing/selftests/landlock/trace_test.c |   26 +-
 tools/testing/selftests/landlock/tsync_test.c |   22 +-
 .../selftests/landlock/wait-pipe-sandbox.c    |   16 +-
 tools/testing/selftests/landlock/wait-pipe.c  |    2 +-
 17 files changed, 952 insertions(+), 909 deletions(-)

-- 
2.56.0

