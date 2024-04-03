Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097C1C280
	for <linux-security-module@vger.kernel.org>; Wed,  3 Apr 2024 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113909; cv=none; b=tNE0uUErhTUyQdl6nmoaTdPjGsAsmrZICwvCoztNRZMICClnT5VBHDdnqqzfbe4vRqgYsTvzg+c7QKXL9kXuLJkuz2qcmVyE/MC10MZyR+LzU5nOcCa2QRtIu/BxOQCdTXFoRZnVhGc0kDad+K9k0XSOh7HGwZrlwjw/ok+SFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113909; c=relaxed/simple;
	bh=JrM1uuFnTIVBKbjDsmBuCX7sxswHD1aKYDxO96MS6V0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=X2qpjVdbXwLCQ2oqeNLMOJMUzHcWLFAEEh7WezP6QhO7aFd5k1k1310z2CdZpSuYiYk7QS9QFNgyYdwDsiCOAGKs/RoCrrIBY7pLcx+Qc75zqbKK3YXJwKeUTbMVyT0cEq2XdyJhOWNDcRU3dhLBgbEVJe58xwovHd+xizLv+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gn+CaIq7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gn+CaIq7"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-432b72c706cso4880391cf.1
        for <linux-security-module@vger.kernel.org>; Tue, 02 Apr 2024 20:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712113907; x=1712718707; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10kPDwtnOEt8AZOr3ERW9xy/nQdgWpYkiYiozTsU2nU=;
        b=gn+CaIq7e0C/FTM3wnme0xjlmWmFpeRSGdYQE9wd5msEJ1e67odLHVokusixkHkG1Z
         SowUMEQfzMJbQD8prpk9GtuzLbE0qKdLX0ptS/emTFqZQJTxwIG8Fr4FabJbocUJmYyL
         Y3ODP7gr2atYEmXCgIicf1tSxSh/IEqI/FCXfFKkueK1bRgj0qynD0SNGa2wNXjfP+y2
         Vtd8ABtS6ujLw8E6cTpnIXFY9vOjw/Z7AMJk8GEKpRecTvJX831XfE9BIMGDxgbjirWD
         r6L+diK6v4E4cazySK3Hy45i2JuIHMfJLBxSls9RjhPD9KHwOpumWQf8TdYGg2BxTRfZ
         cc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712113907; x=1712718707;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10kPDwtnOEt8AZOr3ERW9xy/nQdgWpYkiYiozTsU2nU=;
        b=mQ/pEgDiRFF7xEFt/r1eLEcFaXAiu2Ysw0JfcjOOxo/Vrt1ybcVp6gLQynrGJT7w+q
         zf9Df+qk/MYGLqJCcsJT9GCPvncc918NHwrjD9EOIdnL1aE/K+jTNtFjz1KrwmGWvhGC
         Ht5Vp+enYXZz6warbrLEQ1c19P16LgQPJ4y7JieKVlAfxENkPljKU0GBbIiOjeMz+UrK
         +r4+DJ4T+zV69eLWQE2ulHiGbLKo9gv/b1Ulszut2JnZT7icHnt+1pF+YYkUXLAgzqLS
         0BVWzp0VH5jdM3HBMgm0IThXk71vhcA8mGcAlFXa/tajK6oZuLwAVU9jxFqMxCXSbty1
         BESA==
X-Forwarded-Encrypted: i=1; AJvYcCWJk7FPhyGrjDg5HcDV1G4H6ZzfNmc+bbowZCpeLjq6mTgyRTws/1jQwuwCr0Hqc10iG+G7B1B9sP5A6PKgVuS4uv8LHVcMccbd6QO+9y2jTE76/0ll
X-Gm-Message-State: AOJu0Yx8W35iO+fEFm5uVV+eljn5oZxFTJdSntUCtjhSMiCJl/G7Oed3
	ztnixWL2otOJ6whLrqUU0dNcoQ2LhtwYIxOZvVFle2I9/bnH3dRRLzaiE/oRgQ==
X-Google-Smtp-Source: AGHT+IE78oAKuIVYbax+koIpgJJOpn/ZYMkQ/QoOzelQ16IOpVq6C4shR8C6h7JU+WX+5bbERMuWHg==
X-Received: by 2002:a05:622a:1711:b0:432:f37e:d274 with SMTP id h17-20020a05622a171100b00432f37ed274mr2421865qtk.8.1712113907185;
        Tue, 02 Apr 2024 20:11:47 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bb12-20020a05622a1b0c00b00432ff561b2esm1776656qtb.79.2024.04.02.20.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 20:11:46 -0700 (PDT)
Date: Tue, 02 Apr 2024 23:11:46 -0400
Message-ID: <cf11f516883d7fbf75a34f7981174e73@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20240402
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Hi Linus,

A single patch for SELinux to fix a problem where we could potentially
dereference an error pointer if we failed to successfully mount
selinuxfs.  Please merge for the next v6.9-rcX tag.

Thanks,
-Paul

--
The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20240402

for you to fetch changes up to 37801a36b4d68892ce807264f784d818f8d0d39b:

  selinux: avoid dereference of garbage after mount failure
    (2024-04-01 23:32:35 -0400)

----------------------------------------------------------------
selinux/stable-6.9 PR 20240402

----------------------------------------------------------------
Christian Göttsche (1):
      selinux: avoid dereference of garbage after mount failure

 security/selinux/selinuxfs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--
paul-moore.com
