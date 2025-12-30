Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2E2236F0
	for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767091201; cv=none; b=B3lh4ZDtAo/bLKYyFiPzE6yIFC99kR2KjP3BNzZUSictaHal30pl8DWalyUUyVww6veqgWCIQlK4X/WJJM3lzaAJtoVNgvnnfusV99h0wT+dxzjjKhFB/Abjz2iLzAGqzEI5Qg0uD5TR3wBiSubVZlxLVTS/Am6o16qrpbsYjAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767091201; c=relaxed/simple;
	bh=juiHCNCf7ST8FXM29YBlqPiQAb35HZCA8SNw5dm3MR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mj9B6zVkeksMIBsGPHtlNiyCI4neU53lSFBF2VJaOMSaVPFXoF8S/bnI9bd8UknckfBvd0JL3ktnt1QhgHXRJCTSI3CtVfeFfTRiiZJPtl2o4mM03YOOBfj0Oy9y+EYmRzcNda+2cqb3BmyFpa7N1oZtwv5c9JGVKVirUk2oFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABq1oPCY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABq1oPCY"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64daeb28c56so7954038a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 02:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767091198; x=1767695998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo8DBddupBRUBpfI3daUVwCsa4ufJoTKeedM3BjWazA=;
        b=ABq1oPCYCmFWEtIlCrfjJvXH6n3BzgpVAjAmRsZd2FmwQovvf68DM5wYMOvwyq7how
         TFuTFt0cOIcyEacKIXzZuTdUbHveLV5qfnE3HIJ8frwepd39a5URei9JoSWDO8gFwe7H
         r0Lt1nn0iTESvql470FS7akECDK22rfYll/yyYBd3XsOSuCGa773Xf8OfSnqWWKOQOWn
         5zlW5btnWfGBNJyBdbt1vM/gqcnxhHoJEs4WtaSVscQcTkLqeNu8t/QblOhb67xWVHgT
         CVpAt1hslvUGIM4xqr3CwvWVB8tgvI83BDqZ5/U7xtG6rs18RMb6MF211azP1FvIVLeL
         WKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767091198; x=1767695998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jo8DBddupBRUBpfI3daUVwCsa4ufJoTKeedM3BjWazA=;
        b=VkwFTrAFizTOto6PCrphEoh5Qr5P/0o093rooJIsYQQl7DaS1ZBzzSC1Tg4kuToYjM
         BczxoxTqheKdLjgH2yod7nRz5pFrLg/VtKDepAlTdUUhU6130yStnIbi+XM6wlVOygpd
         9j7NNjkkSwjyX2kGSqs1cDiR9mz8N0UFBGa9bEyOO3fQkaANsiYCx5/TY7TnJYuUQsY3
         JkR//2wkbo7ZVW0RM/ZqfoCrnvwzMigDUejla757DW2M8ceyOW8t9kl8CArHVORlQ6fF
         5LwsBbJ3ur80PT7AzGGtd3fMq39GR9m8cbUnUdZ1wS5ct1POFp5f0vP10LtK+DeBEzDq
         7L6g==
X-Gm-Message-State: AOJu0YyUSRxoAHZCFfOncwFdItQMspXmNzqIs8tQDL+M7LdPEOTpeIBQ
	/QyfE4G9IPY5h0sJc6/AaWv4UigQA5uVyoOfMLgdNCkKVvuUYwInNoTW
X-Gm-Gg: AY/fxX7GJsZHZhkDIhV01DWi6w6xgpJE4adjSgSh1NxS3oO928RaHvsIV/7JKRiL/e7
	lnpP9niT5p5QSdriE50NaZf4v3peepNMsfyy6XiJXIiX+G8Hy2zmBQZ8D3B4d7u0nRfOvW2sBkD
	pqkjNiM11Y4vXn83+gBM7Nd9ZDRGk5I71lBxNCMlxTGjFDuKp7w23m0f7eCsLKaOod3khurSIfz
	yW2VEH5HpbuzhEdBWf+XUSzUX4lq2Z19Tku8nUYGZuWiUZ7Xi2Y616REfaSmdbVvF7uf5vet4RJ
	R8Xh86XzNz+tUUkdjufTxBKerpIOS4xzyxXOvyZnthMFjWP2DFkssv/gFPMzRvvkYKzfDmHWAyH
	HKFjkGUNVwg2GbbL4jNEh1cMVA4VhbihhUVoRJw5lNwPU+znQpmqCWw0x5M67d2PU7U9qstw+RE
	hnrw3fxt9tbf8+N9qNP7vl+wjAJb0+h9uqU8Hl
X-Google-Smtp-Source: AGHT+IFYekmMoueAgl0i320aXXF/dDlwHQxSp67gDmb4kdW4uu9wOZbJ0FhEDuJGWBW3Oj/do8O72g==
X-Received: by 2002:a05:6402:13d6:b0:64d:521e:15f8 with SMTP id 4fb4d7f45d1cf-64d521e19c7mr23634571a12.10.1767091197497;
        Tue, 30 Dec 2025 02:39:57 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a4eesm33761685a12.24.2025.12.30.02.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:39:57 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [RFC PATCH 0/2] landlock: Refactor layer masks
Date: Tue, 30 Dec 2025 11:39:17 +0100
Message-ID: <20251230103917.10549-3-gnoack3000@gmail.com>
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
speedup of -8.3%.  The benchmark results are only tentative and have
been produced in Qemu:

With the patch, the benchmark runs in 5932 clocks (measured with
times(3)):

*** Benchmark ***
10000 dirs, 100000 iterations, with landlock
*** Benchmark concluded ***
System: 5932 clocks
User  : 1 clocks
Clocks per second: 1000000

Without the patch, we get 6472 clocks, which is 9.1% more.

*** Benchmark ***
10000 dirs, 100000 iterations, with landlock
*** Benchmark concluded ***
System: 6472 clocks
User  : 1 clocks
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

Günther Noack (2):
  landlock: access_mask_subset() helper
  landlock: transpose the layer masks data structure

 security/landlock/access.h  |  10 +-
 security/landlock/audit.c   | 155 ++++++----------
 security/landlock/audit.h   |   3 +-
 security/landlock/domain.c  | 120 +++---------
 security/landlock/domain.h  |   6 +-
 security/landlock/fs.c      | 361 +++++++++++++++++-------------------
 security/landlock/net.c     |  10 +-
 security/landlock/ruleset.c |  78 ++------
 security/landlock/ruleset.h |  18 +-
 9 files changed, 300 insertions(+), 461 deletions(-)

-- 
2.52.0

