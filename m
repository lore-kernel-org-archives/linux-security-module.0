Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424C1CA84
	for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122002; cv=none; b=NO75aokwe+sSiOQFAOCl13NtMLztYwJNbouCw89pnpDjKydvupkMRftnw9cW1TubXbRIiSICcu10VHane7Gg/gzrbBpFTa9raRZjRkvwwK1V8/e9alpvsGLU4RsjTFr+6tHio9yOfozSjpHzKPgKK6pC/KVn8NzK7vDrqWQ1IHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122002; c=relaxed/simple;
	bh=2qClRv2u51HJ5DZ5ukRUKKJBNtpQA3BByVkkJAoymBg=;
	h=Date:Message-ID:From:To:Cc:Subject; b=XiWd1nVw+VTBLbPNdr5M1TGtkZD0kNYFaNh55sHTZmvAzL69oUkIhuD5716eQljZaNIA0Gjv+yArFbMctSVL1SLS0Xd+tiNtZJ+dJT+Qlm/lo5ud0KHgCQxeHkP/9+MMHk94kTOx4N1oSEFiz7eFLGhuy8IegAiJLW8txuf096I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UAzz5R94; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UAzz5R94"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5e1c65eb5bbso2502480eaf.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727122000; x=1727726800; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P23y1Kzvrc9ngvdQj04Xt+ODVVaQhl42LTZ4zzaCVI=;
        b=UAzz5R94Fp+n/xug3G661zSiRh29cmL0JeE4UyveWGGS0os/G7E7XL4nbXa6mjZHSW
         XeqaqSXppFC7T2hzMC1mZZeupUkn2/z7HqI9pTb9z4GYBDcbfZiyxCh5I7Tezmz5vgRt
         bYbLtyy5F9mHjDFydrsN0JZhPnPv140+Ue97NkpmGQhXDs5gCvZo3LOmIiRisIaRg3zV
         I8kJaJxf5ZW69FreV41ndP5v0ZJVYRDlu1Z2386rMwkskOLZU+Pz/v3i0cGIs9I+/Ejk
         eatExGJdH6wnfoEbVtu6WYJdzaV3Q9WoXw2aFKF6I3F72Iy934/ttSYKU1joE5PJnJha
         fC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727122000; x=1727726800;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9P23y1Kzvrc9ngvdQj04Xt+ODVVaQhl42LTZ4zzaCVI=;
        b=t3SenWwoULcB53/43itxXrM1JgwtcrNiYQ4FmF5c2InBnkmYvTv3qel1ZF6QdNFqVr
         woTwJPYgDohZgf5daH9agjkYzGsNUbHafwNxB0tLoPJLyK24Iy6U2ZneiThtix0KzAQ3
         VhkJEBMzEF4gydkwlMkgdw3vDUVBP00aScuAkqU4e5Xui+QHBI2LVza6Z4JVh8nMPNP+
         B+Z8wsx1kY+QyyXto3q6XjtpO8dN8gLkOt3CgWqWo5eC+L2I7T7ZR1L+Aaxe2gfI8fy4
         WSsIyipU90Wlz3R2k1nDlRruJrpuIz7JABvcmlQW9/AVRAIh7edDyxgbxR92iRtYT7Eb
         Ba0Q==
X-Gm-Message-State: AOJu0Yyry2XYp24bHamxOQTePuI4BzOWEqeTTSbhZ8lb4zDxTeBh+gji
	1ztezjXtHQyNnNO5TCZRP1a8cdskO7KYGnj4o+HYskrUegzNoCgB/Q1AT9ot3MZG4suqqrOdbL0
	=
X-Google-Smtp-Source: AGHT+IHexHQcsFqylxyINccp9kWCtDo+YRAuXa+STnGUXXNG5JGJmYCFYYfO0q8GOE/iRfJxrGYhKw==
X-Received: by 2002:a05:6358:c6a6:b0:1bc:d1b9:ccc1 with SMTP id e5c5f4694b2df-1bcd1b9d28amr41439555d.16.1727122000254;
        Mon, 23 Sep 2024 13:06:40 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b17867eb0sm50109261cf.12.2024.09.23.13.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 13:06:39 -0700 (PDT)
Date: Mon, 23 Sep 2024 16:06:39 -0400
Message-ID: <d46aba81e752a28ebf49ddc49fd1aed8@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240923
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

This pull request updates the the previous lsm-pr-20240920 pull request
sitting in your inbox to include a single one-line patch to IPE to fix a
random selftest crash caused by a missing list terminator in the test.

-Paul

--
The following changes since commit 19c9d55d72a9040cf9dc8de62633e6217381106b:

  security: Update file_set_fowner documentation
    (2024-09-09 12:30:51 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240923

for you to fetch changes up to f89722faa31466ff41aed21bdeb9cf34c2312858:

  ipe: Add missing terminator to list of unit tests
    (2024-09-23 15:53:37 -0400)

----------------------------------------------------------------
lsm/stable-6.12 PR 20240923
----------------------------------------------------------------

Guenter Roeck (1):
      ipe: Add missing terminator to list of unit tests

Paul Moore (1):
      selinux,smack: properly reference the LSM blob in
         security_watch_key()

Shu Han (1):
      mm: call the security_mmap_file() LSM hook in remap_file_pages()

 mm/mmap.c                   |    4 ++++
 security/ipe/policy_tests.c |    1 +
 security/selinux/hooks.c    |    2 +-
 security/smack/smack_lsm.c  |   13 +++----------
 4 files changed, 9 insertions(+), 11 deletions(-)

--
paul-moore.com
