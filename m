Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760DF156CA
	for <linux-security-module@vger.kernel.org>; Sat, 30 Nov 2024 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732933662; cv=none; b=RkTlt8vGBSfziOi72S3INeoAba4jTe2nyRyARHCxJSNFKo8uzmMlAcroCrJi/YuwHQKjgBCh1CZLbaQC4h/+UuCki8b9EsKG4kc/+GNGdLqr7zfg2ul/y2ccnjy7ealtMfbVp31TGFAcvpITSpndBhJHBIrQEM7Tvyp53B+vGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732933662; c=relaxed/simple;
	bh=aWnmarBawaRLlTgny6s97w2dRCAw14joD5nX5cQZVF8=;
	h=Date:Message-ID:From:To:Cc:Subject; b=JeiS7SZWqGxacIpZTppjpNUDjaf5JFzcPOj2gEvyv7jpIYJKUE9AmhbvnjldxlbW8anBWNSMytCyMy4+hhLi0QcN9MZ404HiKpWzwYkBqKTgK+LyNBYHHaWvBzs+/+XfcVYUZA+VHjaJwOhS6eijzERSAzkr84FUIa8RY6+y5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VF5dqM+p; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VF5dqM+p"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b65db9b69fso142174385a.2
        for <linux-security-module@vger.kernel.org>; Fri, 29 Nov 2024 18:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732933659; x=1733538459; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny/xOclvKvO96CaJgqDIoJ71/Sn21XjQ/xxsbfZgVno=;
        b=VF5dqM+pP/gUpot2DVRAZqXtyJ0bEEi4VNHmDrqQ5L+SddiFjKIFcQJe5LopUQKsWM
         S5SINF7Wgo/I02eIAPovwsVp/zOCp+9417CdNWTzT9NYlQsHApu4aP8T5b26JPMUEZJa
         GqQx/iCBTUMPwxkPbeoXodeiuE3iMnBUxyqmeg7z4tmJhd/avK4KDsOgMsn4nRWOv8yK
         +jRNmpadLBAY+h59c2NPJp+cCnwOirAvFEMkNvGJChySIp8h5RQ0AH75GBNcT4IFib23
         25PPGtxMdew4+E8NVMAWyCl+QMsk6LmkHsgpt1ZJoT1Kp6nBEVEr4RYHW01W08fSZmRS
         j77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732933659; x=1733538459;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny/xOclvKvO96CaJgqDIoJ71/Sn21XjQ/xxsbfZgVno=;
        b=E4cCCC6DVbQ3h6VfKxOcUFx3spxN9mqa5En2VnhjRbo0Q+tkGwcIktJIBM7tQ6pmZ9
         CxAqMXYt4GfFrQBpFFvh4edtbzySE0889c9AL85/KYNevZS/5KplOYSAZDP+rOObDgI5
         rWlKEmpISk8CJK5qgZqn9z4f6YB4Ql7bRn6Ks8GIDpjItJ+MedUMDzEERIKYy6BoUkJM
         li8IHF3KBMLzfh2cXiKeAxlsoGeS5f/NF/XfsVkTBHZa5xraPD1rs9wN/wBLWl/jCcoN
         Of/GKHQssu4N3tLFmecDFb/tg8G+HEiihIqe3Q+zI3EirWv9SK4SPWGH4kKH/hvLJBFP
         wrVg==
X-Gm-Message-State: AOJu0Yyf2YsRqOQxDWAq1g+wOJr/7NsfW/4INMPufAYOEhG319brEDt4
	zCcZQJuvgOFKXO9PyH1cGQAkL3o6//Tetyk3xZX/Irtqs0OtsaoJA0R0Oaua9w==
X-Gm-Gg: ASbGncsxPIk3lxfR73TQLm34MXJkMkiAUiK3MWMccgm/CMImmWAeTKEy9LyFVv8dncG
	Pn/tMF9uBdxbvivMNW01DiAss90V/0VocpVTdI1eBKuP2RCX+66DAV/sA6rGf3buFZc7yXjqLwA
	p5fEKwhCWBu7/jDwChAs3bqnRDkptmG+VlHJuhkMX0JkEDDBP51c2zOQM29O1Pdu62mJhQEU6nO
	ZAde5xybt1K0k0rHUrWTQRT3VUeXw9dc9RInjejgCIR
X-Google-Smtp-Source: AGHT+IEaIDdrWw106ZDQw0mbWestIN+m9HBQ9vmiOd4JwFtKrDnxFQ8CI9ZeiVjBiiizd4mXDAYLNg==
X-Received: by 2002:a05:620a:4109:b0:7b6:6634:5a38 with SMTP id af79cd13be357-7b67c278e4dmr1869693385a.19.1732933659414;
        Fri, 29 Nov 2024 18:27:39 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849aaaf9sm192839885a.79.2024.11.29.18.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 18:27:39 -0800 (PST)
Date: Fri, 29 Nov 2024 21:27:33 -0500
Message-ID: <86752346e28a77c830cb8249610f0f00@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20241129
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

One small patch to fix a function parameter / local variable naming
snafu that went up to you in the current merge window.  Please merge
for v6.13-rcX.

-Paul

--
The following changes since commit 8afd8c8faa24249e48f5007aee46209299377588:

  lsm: remove lsm_prop scaffolding (2024-10-11 14:34:16 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20241129

for you to fetch changes up to a65d9d1d893b124917141bd8cdf0e0e47ff96438:

  ima: uncover hidden variable in ima_match_rules()
    (2024-11-26 22:58:03 -0500)

----------------------------------------------------------------
lsm/stable-6.13 PR 20241129
----------------------------------------------------------------

Casey Schaufler (1):
      ima: uncover hidden variable in ima_match_rules()

 security/integrity/ima/ima_policy.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--
paul-moore.com
