Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826535;
	b=PZRN3wmds7ZCAwFFHe4lAG0YgNzwztMdqgm3ZlzGJrOO6PR67FeTUSCqL5B7AFpGyn13
	 yeUqo2KX7DzU8xW67c4GFsEjm0EEYz4wDVCySgqr9Zbb3ZRxO6BerxBrq63CB8t5zbKM3
	 rZzzjiYpWqwRu5g1sL5LxY97Qqbakfw4xCIxep1xBRmS39H/HCqkodgwFrQ2jmXwBtlOX
	 4ihtMsvHubhfqMMbL+MmuRno4rEzQILcXByZsPTtTgRsSg5TokvUqTEEXxRF/SvGuGqq8
	 +C0/jWb5k5oHN2xg8MfR8ENE36OkfyhYIUJCNcRNV/PFI94Ls7ao4fl0w5Y7ky9n/uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=4OSWRtRd+V91Vqwy50g3O6DPEqRmvPxAQw2Z2wGJO2E=;
	b=kAAuBZJCthEG/a6FyGIVySSpvExtujfM7emSqxcOPGgqAVIYgfIVI0YVwDpyO/4GYOLT
	 vYGdxgfP+u+S0Lr4iMNe3TO09RczjPio8xtoUOr/FHFtnfqrcLY7Joqeu09/21OfYBqei
	 7mG2asud8pRYx9+nEBdld+0Cs4Q2tzq4RWSmKNLgi3Ri9nci99PlHnvrLzYCIbZgJNAZR
	 zgKuVCbKTi8AgKclkmqcnlV+Lxq/5cuL6otS2I9ZO0x5TFXh6nxTpnwCUSeSfVjh0hYYf
	 RSL6HoWdMXOpda3DM43nnhMo3ynDyWchTzGmj2EMkNtY1di/6NP8WQpPx6rN35PaByQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gRxGPTfT;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2B6070F1F
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17A2B6070F1F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gRxGPTfT
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49d05d51553so7483435e9.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826534; x=1794431334; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4OSWRtRd+V91Vqwy50g3O6DPEqRmvPxAQw2Z2wGJO2E=;
        b=gRxGPTfTWalo994sN1tcM8Gk6GH7B3u/3u+F1Kga5xftUlTlJ+u+1yOwZSLEM7R7aJ
         FROykiffhUmwAaJBOn0r3S4I4IVM6erRuf77jUBCj/eO3FvlzgriebXvlaf/6V2eH3Mo
         fsMxDzITqnq6BNLn+6zyyLxMSXv7hPNPgabFJN6NqxKx1PMIqDF5W7vE0IYAhha9OD9C
         RwADQixSQl4Dp1d85S/d/e7/WsvZ4wtQS09FmQnCTMi3VFAuLTPeKr8rK/93/TJ5UHSy
         SiwtgOkxGsRhFm9044+37iy+D+5GlNp64v4HTtASP34RoGpoImJsKaN9+aBo3owFhhJY
         Gf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826534; x=1794431334;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4OSWRtRd+V91Vqwy50g3O6DPEqRmvPxAQw2Z2wGJO2E=;
        b=cTQTBK5przhG1GBKqryhf6/xYm5TxBe+kZEIUjR2oGOWrCI7OYNQeLATunNsqaqH1n
         HTNI6BMGu42yjdrH6vftyWhoRuCTclhdMCtIHylHr2PeLN5ylV90ZK6KiBioJsWOO9BO
         lNbEmD0ut1xdtFG4qSMjCBuFS8cheNdcVvCafmjP2PRRdsQINZT8oWXcFFnCNB44oTcf
         7PJGrEy3PUTdSV43j8X9Myznrvyr+CUy5DhwYM7Z4aHelG/3txTsAkfnNCKp18RmDy6E
         HHxJtFOPk9K6Zuz1uwwHMq0WfkRfDgZNVw/UvU+3ls6FBzMf0y/PUFscYY+4mGWdumA3
         J3lg==
X-Gm-Message-State: APuU4Z+uhHlSdDd7tu4EmKAI/40QEyqKI1mf15o+3kScbLsL1YyAkNtC
	inSHrlD7PH5uikZb+1VulPXJSO24DIWdKib4I2q/SRlNBG7xK2OaKukr
X-Gm-Gg: AYBFou3dZJ2+KjmrQUR7k11znZSA8YnF2c8KHkXGZh6ZSVNQ5CkxmQPsxBFusoA+qoF
	0ek6eWwSxWhrZX4iFgkaQWiwjCa5Eirg/+r7xAeEcKh3DTJkllPIJqZYtPBNbkpE6Q+GqptauHi
	6SECBvs8VJU8YJNgK8Y72XPqS7CjZY6jpcQXMcmHJLvwqbuu1CigAjuGXE597SZjaIsABb6n2Jm
	T3JWby+6MIyrU0YSNbzMKkgC5xTnnR1bbj98w39q8nRHA3kfNkOH1Sp/9taCx0jc+QqMQTwMj8f
	1UJ3Rdf1bQY8XUQcXQckiEwrCKR71Cbs3VGBc8QVxcATiYGg6hvk6DvexEAWz3QUjKmRXaW2A1E
	NaLZybsJzeKGMKDZG7yOC1PyFDqarL8encVyp13Rbh20SecrvF4emb83pAnjLbu0Jwd+6a3ObWw
	rhCatWlgmBKdctXYfMabkY3nl/w5/Z/sAhi5SfyYlXi4mKIHwufo09I3gX31VKLrs7SjhZoUqkb
	gQCLCHjjwjKe2nMcIezo3rSfiwHTX+pi1xG2UeRq0uNl/LGCvyI9NvA58H4NEITcWtvVAbkawhy
	1Q9hHci/z3OGxlSSCGRzcHXEhh0qclE5nC3NYgqCNmalNkS9m7kFuA==
X-Received: by 2002:a05:600c:8b04:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4ac17a3683bmr391930765e9.18.1793826533442;
        Wed, 04 Nov 2026 13:08:53 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844c8sm6227254f8f.26.2026.11.04.13.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:08:53 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2 00/27] landlock: Selftest fixes and cleanups
Date: Wed, 04 Nov 2026 22:08:46 +0100
Message-Id: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOQQ6CMBBFr0K6tmRaGlBX3sOwKHUKVaGmU4mGc
 HdbXLh2+fLnvz8LIwwOiR2LhQWcHTk/JZC7gplBTz1yd0nMJMhaCFCc8G4jUiQe0GoTfeCqUaJ
 DUBKVZan4SIl7bdJz+2V6dlc0MZvyhQ1+5HEIqH9ygL1QsgZVVgcBDZe8n7w2twoATv2o3b00f
 sztwVGafW8/zyKv/GVo13X9ACDHseb4AAAA
X-Change-ID: 20261104-selftests-refactor-4741be042e4f
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

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

–Günther

---
Changes in v2:
- Rebased onto master (v7.4-rc1-132-g05441d697f7f).
- Dropped the "Assisted-by: LLM" trailers (not required any more).
- Applied the same ASSERT/EXPECT rules to the test code that was added
  in the meantime (cap_test.c and ns_test.c, plus new checks in
  base_test.c and trace_test.c):
  - "Assert tracefs_extract_field() results that are used": also the
    new handled_permissions check in trace.create_ruleset.
  - "Assert audit initialization in fixture setups": also the
    cap_audit, ns_audit and ns_proc_open fixtures.
  - "Assert audit_count_records() before using its result": also in
    cap_test.c and ns_test.c.
  - "Use ASSERT for syscall failures before errno checks": also in
    cap_test.c and ns_test.c.
  - "Use EXPECT for checks that later steps do not need": also the
    errno and WEXITSTATUS() checks in cap_test.c and ns_test.c, and the
    errno check in base_test.c's ruleset_with_unknown_permission.
- Dropped the note about depending on Wang Yan's snprintf() fix, which
  has landed as commit 8e4c736cffdd ("selftests/landlock: Fix snprintf
  truncation checks in test files").
- Link to v1: https://patch.msgid.link/20261008142604.39107-2-gnoack3000@gmail.com

To: Mickaël Salaün <mic@digikod.net>
To: Günther Noack <gnoack@google.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Günther Noack (27):
      selftests/landlock: Propagate grandchild failures in unix_scoping
      selftests/landlock: Propagate EXPECT failures from forked children
      selftests/landlock: Check the thread result in audit.thread
      selftests/landlock: Zero-initialize the buffer in inconsistent_attr
      selftests/landlock: Fix the openat() success check in fs_bench
      selftests/landlock: Fix the reported clock tick rate in fs_bench
      selftests/landlock: Fix the ruleset_fd check in empty_or_same_ruleset
      selftests/landlock: Handle a missing control message in recv_fd()
      selftests/landlock: Assert tracefs_extract_field() results that are used
      selftests/landlock: Assert audit initialization in fixture setups
      selftests/landlock: Assert helper results that are used afterwards
      selftests/landlock: Assert audit_count_records() before using its result
      selftests/landlock: Fix memory leak in audit_init_filter_exe()
      selftests/landlock: Make audit_message large enough for any exe filter
      selftests/landlock: Close leaked file descriptors
      selftests/landlock: Check errno for combined VERSION and ERRATA flags
      selftests/landlock: Fix SIGURG handler setup in scoped_signal_test
      selftests/landlock: Fix regex_escape() error handling in matches_log_fs_extra()
      selftests/landlock: Fix off-by-one in regex_escape()
      selftests/landlock: Fix the snprintf() error check in matches_log_fs_extra()
      selftests/landlock: Use _exit() in the named_pipe_ioctl child
      selftests/landlock: Fix messages and comments in helper programs
      selftests/landlock: Fix stale comments in common.h and audit.h
      selftests/landlock: Use ASSERT for syscall failures before errno checks
      selftests/landlock: Assert WIFEXITED() before checking the exit status
      selftests/landlock: Use EXPECT for closing FDs and stopping threads
      selftests/landlock: Use EXPECT for checks that later steps do not need

 tools/testing/selftests/landlock/audit.h           |   20 +-
 tools/testing/selftests/landlock/audit_test.c      |   56 +-
 tools/testing/selftests/landlock/base_test.c       |  192 +--
 tools/testing/selftests/landlock/cap_test.c        |   70 +-
 tools/testing/selftests/landlock/common.h          |   32 +-
 tools/testing/selftests/landlock/fs_bench.c        |    5 +-
 tools/testing/selftests/landlock/fs_test.c         | 1300 ++++++++++----------
 tools/testing/selftests/landlock/net_test.c        |   64 +-
 tools/testing/selftests/landlock/ns_test.c         |  124 +-
 tools/testing/selftests/landlock/ptrace_test.c     |   44 +-
 .../selftests/landlock/sandbox-and-launch.c        |    6 +-
 .../selftests/landlock/scoped_abstract_unix_test.c |   45 +-
 .../selftests/landlock/scoped_signal_test.c        |   23 +-
 tools/testing/selftests/landlock/scoped_test.c     |    2 +-
 tools/testing/selftests/landlock/trace_fs_test.c   |    8 +-
 tools/testing/selftests/landlock/trace_test.c      |   28 +-
 tools/testing/selftests/landlock/tsync_test.c      |   22 +-
 .../testing/selftests/landlock/wait-pipe-sandbox.c |   16 +-
 tools/testing/selftests/landlock/wait-pipe.c       |    2 +-
 19 files changed, 1051 insertions(+), 1008 deletions(-)
---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261104-selftests-refactor-4741be042e4f

Best regards,
--  
Günther Noack <gnoack3000@gmail.com>

