Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922341A7AC6
	for <linux-security-module@vger.kernel.org>; Fri, 30 Aug 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031350; cv=none; b=JPw8u5p9pGRqr26UeutAIQcxsmniZQ9JncsHDyUNVsMfy6xGrh4Nn3ESnqFCTyOlWpKuk8F3OJ4z7wcoS2My8FAXJ5fVqJSyASXZOGJR69FiHLxHkU02eeO+Dh8FMHu4csHGNy9E/J1kl8/Rs4/7+AHtGLczrYud0srDWXxFCfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031350; c=relaxed/simple;
	bh=H4RYLvcr39BN0rzwnNHM3KFnAYMZpv20paMKOn8qAv4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ovdGv8a5/8DZv5Ccj63R4pqkTpW3pHB5XFsXcIZxSUSUOATPph0XWhkhvWyzHQp23mZL+s6jZWXqJ04UgbM7OCIm3tj9KNb31PppYjnJUavHbpWTQup4rYmY6BZqO6KcW5499ByA7mtwAhfp1eWBHEhJlrbziW0pqvlCO+bHEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VSO3OcBh; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VSO3OcBh"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a7f94938fcso124311185a.1
        for <linux-security-module@vger.kernel.org>; Fri, 30 Aug 2024 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725031347; x=1725636147; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYVTJeRzzAJP9TM8I5ujnHMS7FA/up2ERsbsPl7BVDg=;
        b=VSO3OcBhe3LcOp2sPZDJmVA3FdGZ9erZboHwLWnR/8GKdQXHYqadoQBaxR4DTd6pKy
         x9xy7U0RuROQfdGMo48oux1adONmPQTvmkp/KFf9Rvio78SrxDUkQclTlV745eGJmncx
         /vnfBoHaWiwZXDitTDs5hYD+uSvxHYu6RcgrRQqOVgsYOsy3lEzO2MaOoLs5XcxRU16a
         n3kgDuV8/Z8QPPxdLiGhqr2AtIvK/eFl588iRWI3yKYLbp3eLaJad0XssZjeTZfJBjQC
         cuUxzFJkUYV2CcxGIcMSI0E0GaeLsbOaV1b7pfRauf/BKUztrWtTir72S6u0boExKtsF
         sZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725031347; x=1725636147;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYVTJeRzzAJP9TM8I5ujnHMS7FA/up2ERsbsPl7BVDg=;
        b=DTCcNAkkuWDpgbkBodc9INtoPfwKEgo3RaRB88LuslU6w77Ip7lDkE+h2dKyyE8pjJ
         9KCKeBasES3Vh/RrKhSu0TwBbuTzsDND2Gu3W2AuDbG77uv7T8R6AUAnJYNgcIZS3P/O
         WR0brdKd4F/kVCJymGPuNmDEskGXWK8aJ4lMWb2noE4zTNx6Ue5Djc6hjZ85BHmzRlf/
         z/q1Eud8FnHA0Zdlo0Sgl0TafdaGPSPHovXjEGwq77nSlOu/COJr1PjlBxX5fBKOcTHM
         5eR0B//gC+gmgZdI4CdRp+hX04qMll2ZHiH9m125fTm75nhRqx+EFvcw/ZwSxXDMFhYc
         PFUA==
X-Gm-Message-State: AOJu0Yy0+yJtxg6AS4epkSKBajw8vA4F7TJ2JIG56g+fzd0Pjs7Qjajt
	PRTAv6ZNjGGtRZkOSJNaPME9vXNxeDWWRXMWpckUyXmj7FvnbkA2HCa8tlrNSQ==
X-Google-Smtp-Source: AGHT+IH1VT5+1RZLWoTApOI6xYRPV2CewJSrq6PlNvChkaFBl6YHH4QQn1Nd5pdyQo1ugjODpSbEPA==
X-Received: by 2002:a05:620a:44c8:b0:7a1:d6e4:d83a with SMTP id af79cd13be357-7a8042b9fc7mr786119885a.69.1725031347425;
        Fri, 30 Aug 2024 08:22:27 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c49bf0sm150656585a.54.2024.08.30.08.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:22:27 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:22:26 -0400
Message-ID: <44172f0b7c57b1423cccfbbdf7b6518c@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240830
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

One small patch to correct a NFS permissions problem with SELinux and
Smack, see the commit description for more information.  Please merge
for an upcoming v6.11-rcX release.

-Paul

--
The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240830

for you to fetch changes up to 76a0e79bc84f466999fa501fce5bf7a07641b8a7:

  selinux,smack: don't bypass permissions check in inode_setsecctx hook
    (2024-08-28 19:12:44 -0400)

----------------------------------------------------------------
lsm/stable-6.11 PR 20240830
----------------------------------------------------------------

Scott Mayhew (1):
      selinux,smack: don't bypass permissions check in inode_setsecctx
         hook

 security/selinux/hooks.c   |    4 ++--
 security/smack/smack_lsm.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--
paul-moore.com
