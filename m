Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C73612F1
	for <linux-security-module@vger.kernel.org>; Fri,  1 May 2026 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777665940; cv=none; b=V9DBPHyWEAcudZufNJdeUrqGo7b2Ud1rLgUiPhFJSjMu0KAMYR3eikAuXpR+3yMW1Pno8mAHRDjrQ7U7cL3ntx5vUIWudhFGMh1Q6pne45H93LkKgbh5g+29+liWTt+8mS56OVq5cyaptrTUKntFKlPEboFMIuA+NNvZCOBGjmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777665940; c=relaxed/simple;
	bh=jBanCbUbazYJ3oeSZLBuNjWBi4k4g4QaKEwj69b+TiY=;
	h=Date:Message-ID:From:To:Cc:Subject; b=CfrZ73WPdiqa3hNKOjOz3gY/jQ6ET/VImuoKWddhz9Km1cSjJ7Vgs+FGGKCvCSk+zkdYYP3Iqjp3NpCAvH8CojL37NtrFWf/aIpVcIwq08Mg8ko0J4c3ioo2hX0812zqealJgcyRRa+58YdPVe0PmpAgybCXMbE/z7Ncn2CIu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E9zyZ40K; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E9zyZ40K"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ef5776530bso256602985a.0
        for <linux-security-module@vger.kernel.org>; Fri, 01 May 2026 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777665936; x=1778270736; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLP4j+bRFf9v6uMjhdLFBi9sH3z2iAa4MpmbjX3d320=;
        b=E9zyZ40KP1tHF1VgdnP8zyECh0d9BrdNdrvw21HZvbOfb2rZ5LmFvavg80MPUiLjLp
         7v4yqmfnuK8YiLzkxA07AeqeVAulf/RWu/boZ1pie15Eu8s8YTf3+YHhlAraGSx9NnrB
         OAtOgR/amMdCsZwUUt/hLAYhjCZ5L4KkOSH7N9nG2G+W3+zmDkpUNUxkd6Tk3+IWRFYx
         jKUm7YotbucTr9p8PVF4JnlIAFeAXR2p/JWhFqqHIKby6R1WCWSZtDNa6urvBjKFDhtN
         TVD5is3wx0EFeJjFyd6qKosG28ja3cDWcjbPZPQrCakPBMJIZkKV8/NCuztBedl3DFxx
         sYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777665936; x=1778270736;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLP4j+bRFf9v6uMjhdLFBi9sH3z2iAa4MpmbjX3d320=;
        b=ab6H3pNSXXre4LMRwtOg4EYvL2i4ZL5eCZgJCfWFGz7BSrH1cG561Hm4AYBHRwHRcM
         1Afeg2Q2eo9ncZzsIn33BdkpemYfi21gYWUME5QSlA0k4L15LgEw6zHCo6ryOpARHkyJ
         OHbpds8M6uRXHEjm/p8Gib8QrzyUYNAFkkkWOWUzKDkcGr9VYrMTa+EKpSj/dDr13tK0
         /yjHMcYQa+aV+jISI+1oEsUX9Z0rXZ83C+GzxVWEj5ALf/JLEcuXiWcicBgvza7oK10y
         2JFSjQkOme2uSx07NqKtyMg9GgVsv4FJvYSKsuvpQskOQImL/kpQPvBKBVnU7RK7e21j
         7i9g==
X-Forwarded-Encrypted: i=1; AFNElJ+zBxMtmtODowTe8hUEwfq1EkclcLQcGYnvaZOGRKPDuXigamqPlNgMMF1ghPJZuMOz0tj34cWVEn1jV90fQOk2NziSIrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc1wD5l8tom7OJsxUPlkDfLKbl9Zd1VPfaHW4G33uBc5GdDm+/
	5Z74Ae1Wh6oz38tBD9MzXnCv81UT+LVIsXx0LrrYe+w7gPbuZXaSbb1Asx4RGyjG2Q==
X-Gm-Gg: AeBDiesDj+lv6Y5lIUYyEn4MOexlxO4tHEb58mb21/L5+zSiPEOKTLpvykqJxnLGx1P
	aGWAhIDf7ENrY6Xd5jnEp3c3uDHNF1dtxozxsiD5x/GrX5xxMtGkhTGVmy8WpUWEBVu54bFmM/E
	0w+5/xH9TxPd3iEPXjhEAajbXJBmXieRlmC4zz2qdtbxUmhWUBlsIP3soK8iwfObIkUIOcj+6vv
	o9+xiXOnPghhk80U9vkavQwMMTqBLwIH2jUp7wsaBmEV+iaDeasQF8INR7drRSOJlcDTCzug5Gr
	Bnv9TwGs2eRlddfcZmji1ECQUvMHIkvY1kmffko9ax1pRYXR2zkp/y8UwXc3Bm5H212Xk86xLyK
	p2tJMUN0t/qeQTm6V0+HdozDR7QuWC3hnLntK3+UpckcrWptMiccGs+DbrEIEzoivKCHKf7ezh3
	yYKRnqM8ybt8jGIcg6u1s/BiWM/6u/9ZR+K+Arsn2f593dQhlx4FzocuqQZSCChaKGH8pKMNLuC
	eq77gM=
X-Received: by 2002:a05:620a:1a11:b0:8ec:c4a7:f8dc with SMTP id af79cd13be357-8fd164c5d3fmr146374385a.27.1777665936094;
        Fri, 01 May 2026 13:05:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253c17sm289316585a.30.2026.05.01.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 13:05:35 -0700 (PDT)
Date: Fri, 01 May 2026 16:05:34 -0400
Message-ID: <c40ca3bb83a27f66229acd4fe3888e78@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260501
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Three SELinux patches to address issues found in Linux v7.1-rcX (and
earlier):

- Ensure SELinux is always properly accessing it's own sock LSM state

- Only reserve an xattr slot for SELinux if it will be used

- Fix a SELinux auditing regression in the directory avdcache

Just as a FYI, I expect there will be some additional v7.1-rcX patches
next week, but they aren't ready quite yet.

Paul

--
The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260501

for you to fetch changes up to f92d542577db878acfd21cc18dab23d03023b217:

  selinux: fix avdcache auditing (2026-04-28 18:13:58 -0400)

----------------------------------------------------------------
selinux/stable-7.1 PR 20260501
----------------------------------------------------------------

David Windsor (1):
      selinux: don't reserve xattr slot when we won't fill it

Stephen Smalley (1):
      selinux: fix avdcache auditing

Zongyao Chen (1):
      selinux: use sk blob accessor in socket permission helpers

 security/selinux/hooks.c          |   38 +++++++++++++-----------------
 security/selinux/include/objsec.h |    4 ---
 2 files changed, 18 insertions(+), 24 deletions(-)

--
paul-moore.com
