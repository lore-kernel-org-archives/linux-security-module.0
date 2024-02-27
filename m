Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2FE55C2B
	for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074684; cv=none; b=FiEVwI9kBARB11A2VhU9kY0TM6QZI41WhBmiZsYBdPyNec2Ga8qgBFQl+u4TYYnEUgjhJfJEBKyHH+Y74WYEKz/ppNvn4tZek5+H4Qkvatw/1z7c9qkA77o0gxgSMFbrWvUczmCo+8ZUOpzY/2z91kefjuam7K2jJl+ItS0+T3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074684; c=relaxed/simple;
	bh=Vr71jqKQJ39d0269hwhew7G+y2kaKz1jSP0H4+MZG4E=;
	h=Date:Message-ID:From:To:Cc:Subject; b=o9XacvxGGtDy0PBGj4+ZlvzH+j3ypooJC3vpJmnQZ6VjK8t+vtSyUxgr95sqThm7kgJssqigdiC01I2pQ8lN2UChZA4YIArltoz0hItlsEy+/WSWeGnUg9uZho1ZzcWTmixkBIH8S9pVtFqjYt8eNqdWiIg1KcPA1BKE05gJIX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TFcJprY8; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TFcJprY8"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a095237eefso1241866eaf.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 14:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709074681; x=1709679481; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQORNsSdhj+SgaznGPg3hUT/9RbkqE/djugNonksFls=;
        b=TFcJprY8Yie5+Fw3xy1WuJcr/fSEClWKTfDsimwCOTU1R+CdzFAKyZM0uA80x9/JTN
         SjYWBO+6ILRtJ9SMusbIg1vcgm2uIB2coVSktyhw6CYFk3PR1ISziCFlT2hawHKScIA3
         VIXYfs7kdWHI25xuLQoP5pWumuQOUcJMVvHgTq2ygZCjgOEGdjjRuzaFZpN0XfG5WcIu
         jA0Pbe39ljFtROFIkuyF4GWhece/Uf5NskMezersHtFgPW2Oa9VygzGQCEkwtrAjR1mK
         ssnQZ6kCQump9Giq1PzFWNuAtZ9YZt3MQVhSPsC9NYzJlAgkeUwtmoYnptFmU3KdutBu
         1i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709074681; x=1709679481;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQORNsSdhj+SgaznGPg3hUT/9RbkqE/djugNonksFls=;
        b=gOHYSPKvHz2nnaTc3Ov8YtopOue7CbZP4XVVB70t+zjhbOl3zw58EhnXAAVj6x9Yrr
         Zpj78MBVp2PePdQ404xlyiOtE7fhfSLUAn/0SzwORriVv52/nD1RWmWZn3pRYl8yhypN
         meFLV2NxtYkEc8f5p3cJgLgRmDgk45ewFCzIPmKhcv9nj2iwEUJ89jqGq6k30ZlckI5q
         lOT7YObu+8r3sk75lFqHkaA0efuzcs0zBDnZmxNvfQf/EOD/5VfdBNhUrdxew7WCLqUv
         Wah/kyk16tg93YyknVEBJ61uwrT4YTVzhIYsb2naOGHnCjegi5km9AnB89/u64D+FGlk
         4A6g==
X-Gm-Message-State: AOJu0Yz4WeSIUnfeLRVOxRYoYMZxPTWL9P/+hEMU6ldeKssyCNmXDKF+
	xkE7xuCm+4P3BIgbg5qlmNJwMgtgZ405SHeFq8AfQjewpsdSjG/A0ygZ8hMF7ih74bX/4qzRzfw
	=
X-Google-Smtp-Source: AGHT+IHwJZm/T6E0W8oXoc4axiHsPCsRaNhfSFG27ur+/NBfX7yPpC6M1q4wf8i1cRm52pYSUio0Og==
X-Received: by 2002:a05:6358:5e04:b0:17b:4b52:d3fc with SMTP id q4-20020a0563585e0400b0017b4b52d3fcmr9991484rwn.21.1709074680213;
        Tue, 27 Feb 2024 14:58:00 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id b8-20020a0cf048000000b0068f11ceb309sm4584551qvl.128.2024.02.27.14.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:57:59 -0800 (PST)
Date: Tue, 27 Feb 2024 17:57:59 -0500
Message-ID: <64a1045e4c018f135b78952c2c5ae3e9@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240227
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Hi Linus,

Two small patches, one for AppArmor and one for SELinux, to fix potential
uninitialized variable problems in the new LSM syscalls we added during
the v6.8 merge window.  We haven't been able to get a response from John
on the AppArmor patch, but considering both the importance of the patch
and it's rather simple nature it seems like a good idea to get this
merged sooner rather than later.  I'm sure John is just taking some much
needed vacation; if we need to revise this when he gets back to his email
we can.

You will likely notice a forced push on the branch below, that's due to
some false starts on the commit descriptions and nothing nefarious.  As
usual, the pull tag also has my signature on it to help alleviate any
concerns.

Please merge,
-Paul

--
The following changes since commit d8bdd795d383a23e38ac48a40d3d223caf47b290:

  lsm: fix integer overflow in lsm_set_self_attr() syscall
    (2024-02-14 13:53:15 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240227

for you to fetch changes up to 6d2fb472ea9ea27f765f10ba65ec73d30f6b7977:

  apparmor: fix lsm_get_self_attr() (2024-02-23 17:16:33 -0500)

----------------------------------------------------------------
lsm/stable-6.8 PR 20240227

----------------------------------------------------------------
Mickaël Salaün (2):
      selinux: fix lsm_get_self_attr()
      apparmor: fix lsm_get_self_attr()

 security/apparmor/lsm.c  | 2 +-
 security/selinux/hooks.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--
paul-moore.com
