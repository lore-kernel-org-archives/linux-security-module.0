Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866127FD72
	for <linux-security-module@vger.kernel.org>; Fri,  6 Feb 2026 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390734; cv=none; b=W+TjxyYA3zgP4sBc75jVY/E3WCQdR/gmXxvCkvLrbI2vmEt4utgs279N6jklj3wi9srQAOSOS7/bkd9/ePOGHwwF1v76xhTnmv+ifuAAhVUMWJTiP5GFGOGftZp9JeyGawRaoIWJ22SZPGnUaHbqIuB8iwZKbpxQH5TX4InyvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390734; c=relaxed/simple;
	bh=SrGh6drfemT7ywX0iFILiffLeeKN8PjrpAyEWQiilEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t9mdmfGLqPfYyKWRVNryUOLcpidV1dmvpMLcbTL076DKilRMb8T+4RUnag8Ewr4BgJ5ViA/ANvf4osEwKSagP6Sxec6athzI8ZJzvzrrqnVIyPAzbt2cAFeN6xA45mHouR4g0JVdmqwgbc16zhiDzNrqTNjn4uZLZQ4PSESYdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpfzRC59; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpfzRC59"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so27218395e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 06 Feb 2026 07:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390732; x=1770995532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=btFi4jjOSKXTQTYm0NeOLYS0yL2N7AH80cNmY2AerJg=;
        b=jpfzRC59RlaL94JD820rq5LxulJFJvwd/w8bp/nTIjA2pbsLy9iS53lX9XpE4ae6bm
         Py/OMgtFUK/jHSesR5P0S9AIxWOK7o/9tSHx5nIMHt5fBjDex6hOeLXjyqx1iTYMHW/1
         a6wc8u20JUKZSuAclbKlVZkiLxt8ysyl4rn57mjZDzRicGw1hcbj6vRTu8Ht+A6pT4xT
         S7lA402y+Hs/2S3IqyJGuKOgME+b6Rfx3Ezc0R+f+1QXfHEnDv+GfpIxVfvMJaQfO8P2
         NNUVxC5lTj9mJ0SBTR3YjP/rCCTTG+7Sf+WHPyFD9uuGh2la4kc7pVg2k4YSd4EK28dO
         ZN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390732; x=1770995532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btFi4jjOSKXTQTYm0NeOLYS0yL2N7AH80cNmY2AerJg=;
        b=U+27bj/z2CrPBhDKN5v3w6uXlzNQgmIg/x85zPbSgETfpqMhZYlJeRZS/PzkezXghI
         kGpOYgVTq14DYocrlkLFpKcleK7hYNS5q3D+4633O86UxlZ7WpAeQ8Z84lstaBOgvnyJ
         XYo46VE2ElJJoNzkZTbThibOZqKLebFUMwtZzhmBzRk1m91PR6UcCdaTcMbDBRZSAg/H
         FPcp/B9WVr1LbS7kFzsHzRWOpDnp/8wQCQs69OxXCZaJNInwpJlHIl/VJY8mGXP4UEHc
         wmq7K1NbdXUfgodOUH8T9YpqBTAW/GaOEjOO5u4K3zv75G8/6UFZlhWK8lL23UrrNoqn
         YM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqVEpuZq5cbsoOBAIhKOCYrAWwpe65DdMeiPFeVb8f3PrYJrrj5YI6QpMA/rapCfB+rJrD8rvCyju9fS5/M4Jv2itjerA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhTwQXA4l6vyX9560+h466+S3lxeZOO7Pk3aC7k4Ms2KuDXHBM
	HzLlsDpwOs941mvCvC8jApISDScNC7pI3XqupN999iaBW9fnzNZLg+VP
X-Gm-Gg: AZuq6aIJcxtuXbHhbptjmqKXB780X5xuPtjx3NcbY3UPayjS6TfupF2W+2zpbsOQ5I5
	VywGkZ11QZI9gYTCaK7adLz6ceWGrw/AwbFhGtkm/Ad9VlVe4K/CqVQUbUogs1tLTh/SoyP5YqI
	m1Iow4qoQ3+3D9aglt6oEjCIqUB39cviZQq+3yQQzrhO+/vXBqsKjwxN3H0kTXHJTiTglTwMkof
	mA40Q0UtO4Oq5z+LirmAeP9P/oYfkUYF8AI1R802iq0PDoD1xNggegslwwnp1gVFU97g7TmL8Jh
	7U24rZCsDMK7gPd6Xes4P1bvJyOftRWgfyIYK1EHkdeMU5MB7LIf76H40GWwSjtOss5aYiVlsBU
	8JlGkcg8BJiSUcZhXqa5fXIgETfs1qy8YK/J0YO2sxF38GEMkm15r7DT5GOjBfoLqRhF2WR0hC8
	EygbNzPcp7vpUpDSvSHuSkk8XZ3vwIiXPrBXPZ
X-Received: by 2002:a05:600c:4585:b0:480:20f1:7abd with SMTP id 5b1f17b1804b1-4832022100dmr45315355e9.31.1770390731829;
        Fri, 06 Feb 2026 07:12:11 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b2ef1sm6938498f8f.7.2026.02.06.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:12:11 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 0/3] landlock: Refactor layer masks
Date: Fri,  6 Feb 2026 16:11:52 +0100
Message-ID: <20260206151154.97915-2-gnoack3000@gmail.com>
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

Benchmark results with and without this patch set show that the
hypothesis holds true.  The benchmark I used exercises a "worst case"
scenario that attempts to be bottlenecked on the affected code: It
constructs a large number of nested directories, with one "path
beneath" rule each and then tries to open the innermost directory many
times.  The benchmark is intentionally unrealistic to amplify the
amount of time used for the path walk logic and forces Landlock to
walk the full path (eventually failing the open syscall).  (I'll send
the benchmark program in a reply to this mail for full transparency.)

Measured with the benchmark program, the patch set results in a
speedup of about -7%.  The benchmark results are only approximate and
have been produced in Qemu:

With the patch, the benchmark runs in 6007 clocks (measured with
times(3)):

*** Benchmark ***
10000 dirs, 100000 iterations, with landlock
*** Benchmark concluded ***
System: 6007 clocks
User  : 1 clocks
Clocks per second: 1000000

Without the patch, we get 6506 clocks, which is 8% more

*** Benchmark ***
10000 dirs, 100000 iterations, with landlock
*** Benchmark concluded ***
System: 6506 clocks
User  : 1 clocks
Clocks per second: 1000000

The base revision used for benchmarking was
commit b7ff7151e653 ("Merge tag 'hwmon-for-v6.19-final' of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging").

In real-life scenarios, the speed improvement from this patch set will
be less pronounced than in the artificial benchmark, as people do not
usually stack directories that deeply and attach so many rules to
them, and the EACCES error should also be the exception rather than
the norm.

I am looking forward to your feedback.

---

Changes since previous versions:

V3: (This patch set) 

* Benchmark:
  * Document what it does (and doesn't) do
  * Const, use wrappers.h, add copyright line
  * Delete the directory hierarchy after the run
  * Use different Landlock policy for benchmark so that deletion works
* access_mask_subset() helper:
  * Docstring corrections suggested by Randy Dunlap (thanks!)
    https://lore.kernel.org/all/7b7b8fd5-7e1f-4572-a342-11a0fd24b0ac@infradead.org/
  * Change argument names to "subset" and "superset"
  * Use it from one more place
* Various
  * Do not use docstring commenting style for non-docstrings
  * Use ssize_t for downwards iterations from N-1 to 0
  * Slightly reword deny_mask documentation

V2:

https://lore.kernel.org/all/20260125195853.109967-1-gnoack3000@gmail.com/

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

 security/landlock/access.h                  |  22 +-
 security/landlock/audit.c                   |  81 ++---
 security/landlock/audit.h                   |   3 +-
 security/landlock/domain.c                  |  45 +--
 security/landlock/domain.h                  |   4 +-
 security/landlock/fs.c                      | 352 +++++++++-----------
 security/landlock/net.c                     |   9 +-
 security/landlock/ruleset.c                 |  89 ++---
 security/landlock/ruleset.h                 |  21 +-
 tools/testing/selftests/landlock/.gitignore |   1 +
 tools/testing/selftests/landlock/Makefile   |   1 +
 tools/testing/selftests/landlock/fs_bench.c | 214 ++++++++++++
 12 files changed, 499 insertions(+), 343 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/fs_bench.c

-- 
2.52.0

