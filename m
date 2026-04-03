Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535762FF65F
	for <linux-security-module@vger.kernel.org>; Fri,  3 Apr 2026 03:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775185748; cv=none; b=Diz142NaRAiomJo/kv+2vqeLfkRlfT6tivzktvb79jF9+Yr9/1gViowoNtE2Ek64f4cfaMyNdUfsXpOO/cAnDQNIml46tPKS/qLwjl13DJDD/6fE3BioUVi5+pGWKPpjYX7TgOYRNg8kvoVCF+EAKMbIWdQNckTSiqNGTkKF8vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775185748; c=relaxed/simple;
	bh=Ht/CWS8eAdFAx31qEnne/OHet5mQZLtjtZViqsMWheY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYtjNW1vPqN6tsq8c0XKw0cJL9g932FPAbFQ8/kbFlcXh8J9H0ZNOhyN86H/CxbyWgtv/VJIW1Df4D0j/bh/BrV9X41JAYrfWDZzU5VperkHtROGWbP90nhsEoIqdkxpN4oQV0LXAYDrkxveawfNpdliEuVAbVsqAdpULafhT6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Zd5DTnBZ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Zd5DTnBZ"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899d6b7b073so20649666d6.2
        for <linux-security-module@vger.kernel.org>; Thu, 02 Apr 2026 20:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775185746; x=1775790546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+R/8MkRE1msWS32ANzMTpmj3lRg9zDjBRK7qW9MA9g=;
        b=Zd5DTnBZbxFLUVGb3M3vyvfa+YDIGbXlT1WZnLSA/npeZOnHi2UG0Fke/jqKqml5B3
         p8hJS+b21nmkMYMfOngu6n/5dXTGqPy7vPVUiX2rceZsuFqyUVZZF8m7zTnfrDX9cdXb
         DHcpjEvOfQDg/WAaiE3FttsUbGTfvmD1DtyDdAJwo2SttFAVqMLC66LWN/UjzIMo6JsB
         iH3FDX6kt+CboDUhklEFGToVBLEbWqMCj4VXHuoH4snvcDyWLFPfSDt9l0+xOVnMIKMe
         1Clk4i7H9CMjX0NMEoux7gAQ5ZUSKSn5tBtmdag7F15jTRRSY4I6xVMJeuZZHU6YXBb3
         ooJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775185746; x=1775790546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+R/8MkRE1msWS32ANzMTpmj3lRg9zDjBRK7qW9MA9g=;
        b=qPEET34fucStdaZgDAKTzOjlNQh6NimvyDZHR78gCSsZaIGDXagF6pT1wHG5HIaPvT
         F+QMI9ZPNFPF2+Crd4J2YF4/YpTJ3/fQgWugf1CnRVcVR5STx3C3j2pubJiqEmDHDR9K
         oAXkE6ahjnm7RgT0IkLPsVSsd2cKunrsKk1ZvDEWxXT3LkJjp5m/KkiYZMqJmpDTb/mi
         0DPmn0nfxA/Cy1UgIyWevmttwDfwz1ilOajuxu0bgfE/8FuYtt65ShRfgH4qAUHkwbq2
         BqXhtwi7jeMQMEVF68PtZ/pPSZlxCXiCHRws46vxeXFifRjPdcd26P6VX4sxdVsVVU87
         c1tw==
X-Gm-Message-State: AOJu0YwiDa9yVgcr9d7n7g0txh9pD8l3sP/wFpl/w1ee4W4R0zZvbz/G
	QvIzuD+EHMKBOliMcenCtqkPiitXt+/enSPHWzNCpmapYd/aY8y2b2GhAIwemO3mN6hsMZybGdu
	4YlU=
X-Gm-Gg: AeBDiev0z6eUuiAxLRDH0VUS6CVAkoONAI7abkHL5yr/bc32hyuYGjHORMxJ6KHxEHk
	A36DZGHQ5ynfphigv5drUqIO6g/+4cls9cs3Emp3NcHltkS+cUth4JY+ncekfi6cG4Hu9ngEOnS
	5VTdyW3ng4RiKrvp7gzdR/mWbqmOqN4k5TSx2A+Q7XVdzupGXZyfiq1Htx4jhTeOxm/CZXRxKBE
	y5w9mR0RZ9Tf7Sv8j33UFqDjHqnokuJCwsRbqrO+TE0KPJltibGHrYpN91Q12shLXqG7fa9RSZN
	9OAFMqlq1TjuuuAKr4/U3fMTm9KzvdBvF2obGcYdbqU+B6kQ2SaukiNvk9bsxg2fKk7Nlo+mIwV
	U798hs9Ijwmtiy1B0VTZAZkqtBL3WErtXBIMU9FzVSaUeO8A5i8eWTsIJReU6XUWntOE6OG4HfJ
	JNZCiEUXDzMt29Dy/STtjO3cEn+aKr8zKOAP9o6thwbozhXwClNo392LtN9C0OPZrEI4H1
X-Received: by 2002:a05:6214:2b0b:b0:8a0:22bb:1d3c with SMTP id 6a1803df08f44-8a7025b40bcmr26368956d6.3.1775185745794;
        Thu, 02 Apr 2026 20:09:05 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596e03ce5sm43960226d6.35.2026.04.02.20.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 20:09:05 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Thu,  2 Apr 2026 23:08:32 -0400
Message-ID: <20260403030848.731867-5-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another week, another revision to this patchset.  The v3 revision can be
found at the lore[1] link below.

The revision still takes the same basic approach introduced in v2, with
the most significant change in v4 being the change to make the backing
file LSM blob conditional on CONFIG_SECURITY.  This requires a number of
other changes to ensure that all accesses of the LSM blob go through a
set of accessor functions which can be converted into dummy functions
when !CONFIG_SECURITY.

While the changes between v3 and v4 were fairly straight forward, there
were enough of them that it felt wrong to preserve the ACKs from previous
revisions.  It would be appreciated if those of you who had previously
ACK'd a patch could take a second look and renew your ACK (or comment on
the problem preventing you from ACK'ing).

Thanks all.

[1] https://lore.kernel.org/linux-security-module/20260327220446.353103-4-paul@paul-moore.com/

--
CHANGELOG:
v4:
- added fs prep patch (Amir)
- added CONFIG_SECURITY conditional code (Amir)
v3:
- fix the LSM hook stubs (kernel robot, Ryan Lee)
- fix the lsm_backing_file_cache allocation size (Ryan Lee)
- minor style, simplicity tweaks to the SELinux patch
v2:
- remove the user O_PATH file patch from Amir
- add the backing_file LSM blob and lifecycle hooks
- update the SELinux code to reflect the other changes
v1:
- initial version

--
Amir Goldstein (1):
      fs: prepare for adding LSM blob to backing_file

Paul Moore (2):
      lsm: add backing_file LSM hooks
      selinux: fix overlayfs mmap() and mprotect() access checks

 fs/backing-file.c                 |   18 +-
 fs/erofs/ishare.c                 |   10 +
 fs/file_table.c                   |   43 ++++-
 fs/fuse/passthrough.c             |    2 
 fs/internal.h                     |    3 
 fs/overlayfs/dir.c                |    2 
 fs/overlayfs/file.c               |    2 
 include/linux/backing-file.h      |    4 
 include/linux/fs.h                |   13 +
 include/linux/lsm_audit.h         |    2 
 include/linux/lsm_hook_defs.h     |    5 
 include/linux/lsm_hooks.h         |    1 
 include/linux/security.h          |   22 ++
 security/lsm.h                    |    1 
 security/lsm_init.c               |    9 +
 security/security.c               |  102 +++++++++++
 security/selinux/hooks.c          |  256 +++++++++++++++++++++---------
 security/selinux/include/objsec.h |   11 +
 18 files changed, 419 insertions(+), 87 deletions(-)

