Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBE1C5D72
	for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769371141; cv=none; b=gBlzQyEmXdYptmqbyMQdlz6qzujRmQIssbeQDrg1IEdgwHp88FtyE5p7vESRc4A4p8cnLjS4blXmDq50ZmWgoBdoFtTbatqIr3i4S7J+u8sSZKGoWFL/lGRtUdcUW9FGe+7QK8ak4OkGq4EZGGeBpgNqI0fZB9doHVrs96iUpHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769371141; c=relaxed/simple;
	bh=Jx9p0DnqYP+zBsCAa9AiFEk4ZJOgEUhx7jBFUu4J8pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mYc9bc3s3wT76M0jJWeZ/jcn4889+CuFprxUsF13cK1yU5NuPBD8JM3RbX/fhDoa3jkzo1vTcIayjw2MfSaQQoYKc8ENN5XNJpo4I9F1L5E19VklZiIbiylUf1zYHqFzjAAOxpzOBmMz3wDJ0AfUGRpB4t2nIasSHxTCbCp7YG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1aL7sUq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1aL7sUq"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47f3b7ef761so27718605e9.0
        for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 11:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769371139; x=1769975939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c99jbTSALHC1B0TLORG9vf5IHFA7x8faCD28wcO2Gn4=;
        b=X1aL7sUqge62NIfPzs9wrckCceyQs3PGXeb9M+EV26CSi7l1qWCdugwqTQFH916hhs
         +Commnbg1yp8WCF0jaW3yheDHRLauIy1OssAQORhEH2gzuiOvQG6KcRK5VU72nW5eygk
         Z6c2+9xfrv9ZHd1XUFun7yWty/j/32YLjVqu3FpjjhuDm2vD/WEcwlE6l4O3Idx7w2I9
         IOH+uki44rdLcXYggKowtD4p4MoBMsuaK2OzK2j33HsSkArlzSDV1A1EUKxmuvHUviF7
         rUsxWKqS3/muTa0Uda7nTpVxGx1CuTpclWzdqIMPm7clTUjTGGZ2eL0iROrmU0eV2mgn
         hWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769371139; x=1769975939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c99jbTSALHC1B0TLORG9vf5IHFA7x8faCD28wcO2Gn4=;
        b=mOP5rnu/79VDf+YcgSl2FacMIUtULQRvOYz1Lq20CZBps2u3dH5cOVmtrG+PTwBdYV
         dmCtpLCPk1IjRQO9yO6wWqafNRKrxXZ2J4gbkt8qrBkW0+K30wBfDrqBKmTI9Iv8xYZ5
         A/u1zoLPoZc2AXu8jjA8mWHTZZdHlsv+exev3Yic4EX9UMUctwZP16KUNmFvS/vyQMGH
         OeFRGioAI7nv3fsylOF2xvoKTxjLMhqPEgqvEgj4TNUbKpVPVMp5V6+hVRaVDPAdySv1
         dU6pBe3ZbOwaJaYtZYiD5u/8coL7ha1fjfApXAgzPqL9ZbvWgHre5E1TM1GdZ9wxp/4x
         DtSg==
X-Gm-Message-State: AOJu0YxFs8z4QyegbzKnULlGFyDWOP/YGCLDWC+t5SnzV/jEfeIC3hPP
	ooxzuZhCMueUUs9cyq0cbfaZcheygRWd2h6sa2magJCK3wdhSoDTa23K
X-Gm-Gg: AZuq6aI/sKhtvUBUxI7tgGX9/lB7IkuuiLMcdSRfjuXqAitZxWMBe4dEkgDi/fvTIx6
	ic1Ndm/np73VOrLec90xqCBWdyvBlV+xANbdpknMBcIZUWdKlcK60kCfb3FMQecd94334cmjPlJ
	wmCKwLHjy9mV8ORtD1APhQEkuaXYJSWpud8uq70RwRI6pKz7+QvSnCmRAA8cXH1o3MWWnpnA2Pt
	t4g/tiRGGE6N44+bf4qlB/WhReOM3gEzTt/kv0X4StIzvbABavSlp/eNJy28cXMNeuDUU6UbBnQ
	UaRvrq9lQsBhNs0uVcyr45PUtIMd0ijgKyGzlZC3zhh+yTB289vVExpscP8uK8b5OsrIuVbtxkv
	G95cqVejguywSf98qSbBlxWtAIN7h94zgmCEQ7VbGAzgVq8ojaijlPsQq/cKt86XIaSmr96uUSb
	aV5qgWjjf0oHXt4cERSV7Gf60q99hKOnxP61dy
X-Received: by 2002:a05:600c:450d:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-4805d070a9emr36253875e9.36.1769371138556;
        Sun, 25 Jan 2026 11:58:58 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804702876asm335282955e9.1.2026.01.25.11.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 11:58:58 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2 0/3] landlock: Refactor layer masks
Date: Sun, 25 Jan 2026 20:58:50 +0100
Message-ID: <20260125195853.109967-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello!

This patch set "transposes" the layer masks matrix, which was
previously modeled as a access-max-sized array of layer masks, and
changes it to be a layer-max-sized array of access masks instead.
(It is a pure refactoring, there are no user-visible changes.)

This unlocks a few code simplifications and in multiple places it
removes the need for loops and branches that deal with individual
bits.  Instead, the changed data structure now lends itself for more
bitwise operations.  The underlying hypothesis for me was that by
using more bitwise operations and fewer branches, we would get an
overall speedup even when the data structure size increases slightly
in some cases.

Tentative results with and without this patch set show that the
hypothesis likely holds true.  The benchmark I used exercises a "worst
case" scenario that attempts to be bottlenecked on the affected code:
constructs a large number of nested directories, with one "path
beneath" rule each and then tries to open the innermost directory many
times.  The benchmark is intentionally unrealistic to amplify the
amount of time used for the path walk logic and forces Landlock to
walk the full path (eventually failing the open syscall).  (I'll send
the benchmark program in a reply to this mail for full transparency.)

Measured with the benchmark program, the patch set results in a
speedup of about -10%.  The benchmark results are only tentative and
have been produced in Qemu:

With the patch, the benchmark runs in 6046 clocks (measured with
times(3)):

*** Benchmark ***
10000 dirs, 100000 iterations, with landlock
*** Benchmark concluded ***
System: 6046 clocks
User  : 1 clocks
Clocks per second: 1000000

Without the patch, we get 6713 clocks, which is 11% more

*** Benchmark ***
10000 dirs, 100000 iterations, with landlock
*** Benchmark concluded ***
System: 6713 clocks
User  : 0 clocks
Clocks per second: 1000000

The base revision used for benchmarking was commit 7a51784da76d
("tools/sched_ext: update scx_show_state.py for scx_aborting change")

In real-life scenarios, the speed improvement from this patch set will
be less pronounced than in the artificial benchmark, as people do not
usually stack directories that deeply and attach so many rules to
them, and the EACCES error should also be the exception rather than
the norm.

I am looking forward to your feedback.

P.S.: I am open to suggestions on what the "layer masks" variables
should be called, because the name "layer masks" might be less
appropriate after this change.  I have not fixed up the name
everywhere because fixing up the code took priority for now.

---
Changes since previous versions:

V2: (This patch set)

* Remove the refactoring around the deny_mask_t type,
  it is better to send that as a separate patch (mic review)
* Added the benchmark program to the selftests
* Fix unused variable report for "access_dom":
  https://lore.kernel.org/all/202601200900.wonk9M0m-lkp@intel.com/
* Use size_t and ARRAY_SIZE to loop over the layers (mic review)
* Documentation
  * Fixing up and adding back documentaiton (mic review)
  * Documented landlock_unmask_layers()
  * Fixed up kernel docs in a place where it was improperly updated
    (Spotted by Randy Dunlap
    https://lore.kernel.org/all/20260123025121.3713403-1-rdunlap@infradead.org/)
* Minor
  * Const, some newlines (mic review)

V1: (Initial version)

https://lore.kernel.org/all/20251230103917.10549-3-gnoack3000@gmail.com/

Günther Noack (3):
  selftests/landlock: Add filesystem access benchmark
  landlock: access_mask_subset() helper
  landlock: transpose the layer masks data structure

 security/landlock/access.h                  |  16 +-
 security/landlock/audit.c                   |  84 ++---
 security/landlock/audit.h                   |   3 +-
 security/landlock/domain.c                  |  45 +--
 security/landlock/domain.h                  |   4 +-
 security/landlock/fs.c                      | 354 +++++++++-----------
 security/landlock/net.c                     |  11 +-
 security/landlock/ruleset.c                 |  88 ++---
 security/landlock/ruleset.h                 |  21 +-
 tools/testing/selftests/landlock/.gitignore |   1 +
 tools/testing/selftests/landlock/Makefile   |   1 +
 tools/testing/selftests/landlock/fs_bench.c | 161 +++++++++
 12 files changed, 444 insertions(+), 345 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/fs_bench.c

-- 
2.52.0

