Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A7033F7;
	Thu,  8 Aug 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140044; cv=none; b=fuTzf1mHyQAjvccUi2cqFQ9y0vLK4cUgS/mldPQrIxe8dgYnvMXcPJVuRyhY7FILcnvhWDRqndGLF0iDfWBJwKmwsTh1lgZoMjXBEN8SrWRNw0g1hVUtRxRXAn+Sjtfcnn/bVs8ApXTHXsPNSzDAPgz4/eJ9oH27nI/qXC7LNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140044; c=relaxed/simple;
	bh=iloXxDGruNoFK3WMjxkdVwZgDaK2n76p6HZmSWL9tMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN9rS/I6ZYlxb0+Kh2Oaifwv/SSVF6O5b+APvXvcun2CNvd2PNHDrCk4e109E+5pTLqMcFBsQMK16NtPe0oF2y2yw8tgKNCQ7Uxg/hvvLFVK2lXvJ5R4K4CY2YBaZ9KxQ/1x9WTONxalOObfrJ3z5R+3bdCf960d1V7wvhBzOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1/YRpIw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1/YRpIw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fec34f94abso12276085ad.2;
        Thu, 08 Aug 2024 11:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723140042; x=1723744842; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2KXVrIDntiwv323wOQhLAY5VMse6JMKaP5+kYMUsCQ=;
        b=L1/YRpIwAYae1OqNDXXxYzuFaydI5UWuAOr+RU8zu8QrAuzdrfSk7WIrhW14oLDx/Z
         /4BlLOBrl2GTrHhvZa0PdQo+Bheb2kq8kvTxK+k9ro5RanyTIw3RfAXHlvRePLl83eYF
         vltPFJHJeuPKB8GLX9IqxGFC6rHmlMrgGnzl5xnrnYyLDCyfWnGJZiJrWttJ/lOTls80
         TVcWQuuLUS38RWyEFPEEysIzGSwAH6rb6X1Hwj9jEclXQ1FJn0oSq8a4aAvEckFrXgIE
         AOz0qhzD/MfgQJFSjHdeEayENeBZa4ZXi7Kk3lfTimlgjpmgXiN8sp7uEhLadWvaryM3
         saJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723140042; x=1723744842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2KXVrIDntiwv323wOQhLAY5VMse6JMKaP5+kYMUsCQ=;
        b=vvhEmFjSdFGmMnjB5VevjwzVUCWD+rcU+qu2fMOI6+CSIPYaASGhtxfXN8e/BO93VE
         8BKliTCQxk4rZfRyCRQWOMslYTvYKa6aHXPmsJA5ETVwgwwaJyiQ6vL3+CcnuwvrBgYc
         68Q+4FW9QaUhTeM4vREzdpmgxaskvH3259Jta/8kFb8pt6ttZi6sBn/0yuCKSLCnFH/w
         non16qYA6y8UTZ/crLO/0/QLG2PTi8ClwYBLp09jIa/cqHxKRkMreV+pNaf6s3kXThOl
         JcOjRZ2CMM2NpUJTleS7caPseUGjVb9kWNt7kdwBW+yb6HMN8LYb1Yr6WdCNT9ug22Qq
         viEA==
X-Forwarded-Encrypted: i=1; AJvYcCXnpEm8LnE1LrBfe54tdK4XLA6SNsJHefBvBEZfM+2WApsu7k/5STBXL/CInocQqDP2jCAuX4SszlONsaEYp/eshfufDKFaTLEPWTE0nbNu1ZVnoBff2XuvRjU5vEqxPcu1RNh8oipdwiyLPUX6Va6Pp2VN
X-Gm-Message-State: AOJu0YxgqrZPqGWPlyWrzNPvZPzIpjfwJ+Su3nVz7aU4BF+UphGRg9AI
	IDfKHWGEgORRoT+SUtxEwZIWb3jXvxRWmq5DdGU90kBfp5zVpvMu
X-Google-Smtp-Source: AGHT+IHztOZ1jku+YOzW//V6Nt0XSwNWJIS82+IgbYY4kXvel4+T/NXRFPIVJ4G3aRUDv1KRWpykBQ==
X-Received: by 2002:a17:903:1105:b0:1ff:498b:5857 with SMTP id d9443c01a7336-20095252d1fmr34411975ad.24.1723140041972;
        Thu, 08 Aug 2024 11:00:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53c41sm127534025ad.71.2024.08.08.11.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 11:00:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 8 Aug 2024 11:00:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	bp@alien8.de, sfr@canb.auug.org.au, peterz@infradead.org
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
Message-ID: <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net>
References: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net>
 <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net>
 <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
 <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net>
 <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>

On Thu, Aug 08, 2024 at 01:32:37PM -0400, Paul Moore wrote:
> On Thu, Aug 8, 2024 at 12:43 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Also, there is a backtrace on ppc (also see below), but that is unrelated
> > to your patches and only seen now because I enabled the security modules
> > on that architecture. I'll bring that up with ppc maintainers.
> 
> Thanks for all your help testing this Guenter.  I see you've also
> already submitted an AppArmor fix for the endian issue, that's very
> helpful and I'm sure John will be happy to see it.
> 
> Beyond this work testing the static call patches from KP, would you be
> willing to add a LSM configuration to your normal testing?  While most
> of the LSM subsystem should be architecture agnostic, there are
> definitely bits and pieces that can vary (as you've seen), and I think
> it would be great to get more testing across a broad range of
> supported arches, even if it is just some simple "does it boot" tests.
> 

That really depends. I already enabled some of the kernel security modules.

CONFIG_SECURITY=y
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_KUNIT_TEST=y
CONFIG_SECURITY_LANDLOCK=y
CONFIG_SECURITY_LANDLOCK_KUNIT_TEST=y
CONFIG_SECURITY_LOCKDOWN_LSM=y
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
CONFIG_SECURITY_YAMA=y
CONFIG_SECURITY_LOADPIN=y
CONFIG_SECURITY_SAFESETID=y
CONFIG_BPF_LSM=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,bpf"

I can easily add more if you tell me what else I should enable.

Userspace is more difficult. My root file systems are generated using
buildroot. I run some basic tests, such as network interface tests
and TPM tests, but those are just simple scripts utilizing packages
provided by buildroot. I can add more, but I would need to know what
exactly to add and how to execute it.

In general my tests are intended to cover a large number of different
configurations; they are intended to be broad, not deep. That means an
individual test should not take longer than a couple of seconds. If you
can provide something that would run in the buildroot environment and
not take long to execute (example: tpm2 selftests), I'd be happy to add
it.

For more comprehensive tests, it might make sense to discuss adding
security tests to KernelCI; they have much more resources available
and target deeper testing. That would make sense if you have, for example,
test suites to run on upstream kernels or stable release candidates. 

> Out of curiosity, do you have your test setup documented anywhere?  It
> sounds fairly impressive and I'd be curious to learn more about it.
> 

Not really. The code is at https://github.com/groeck/linux-build-test.
My clone of buildroot is at https://github.com/groeck/buildroot (look
for local- branches to see my changes). Please feel free to have a look,
but documentation is seriously lacking (and README is completely out
of date).

Guenter
