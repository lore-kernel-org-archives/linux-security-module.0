Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1AB3D567F
	for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2026 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961481; cv=none; b=WNBak4MuXVaJxXlHcO9Wq4J4HV/3I1Q/zmNW3JR2zUBTPAKHR6zVvYhnVEQVUOP3h5cHC2HJuL9AlweNSDJHc558DzmzKwmuwo51sQWI6TbsYGkmlySM9QxeMKqbID089nnC4dzjQD8Hx7wHBkOwkItymwq7u2iyk+eTqwov8JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961481; c=relaxed/simple;
	bh=9EB+yPueLE4eNzjZXRf1+qRGobDQDTE47/I1H9AusW4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=IPDaM1GZrRsQMN61n60HQLWydiGL7zCAbYD1QcOiguUxgitjAFV/JdWC4+s26HlV56A5rdeO6vk/HiRx1OSZSXu8d+aINNJLYCWNWAxek8+f8iqyCpGa6hQfPphPGFmnF4LCmbADDapbrW66az7RjwDombifgDIzgUPfaOVCzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=faHtedTy; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="faHtedTy"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e7c6ec9dbso73255485a.0
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2026 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785961478; x=1786566278; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4vZft3ZLAfDQnTWAJQjKv+QpX7ma9bE3TeX4kEGzSho=;
        b=faHtedTyx6SwTIT4rBLd6vzkdhr+xfJCGdC1xMbCeFX8oUrULq/suRirdTJacQH39Y
         Mwa61BQtoXiEyDDeXpHkLf46Wx6f3a7J10RyX/zUQAFht2+1es07Nc+7OgEhA4hm8ioU
         J42ImKG/DW1ou76ytzPT+xKmGvDJxI/aetsEe5cp7xYSLLYONBE+WbMg18Yd6bJl1vpE
         BzD1GBRg/92cv3XoF90KdFiOPFZxvAEzyLQffJKZHFcH7Hj+IFlq7bs2cQ2EACFOPOhv
         1DBqG5gIwU8KwuED2dNF+Aqfr4e28JJpDjwCh6w1Kl3foRZkFcNiGOLwZHWCXYFYq/Ce
         DS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785961478; x=1786566278;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4vZft3ZLAfDQnTWAJQjKv+QpX7ma9bE3TeX4kEGzSho=;
        b=FSOWpJsIwgKODDpBe9bWtJNcKtXWjbJY/GImPdkweoJj39UQ0LpJPYxN5jDUA64IoD
         UqGeyx1EWb0o1UB9VVM1pdsDn7r3JQXD/VDiVEqKI10Rwz35lqXuOM0VMHO2+xxXchhv
         h2C8K5bkA/2two5HpYiOC0HVIv38lsppkdhNfENx8YhX7buADCkeyDzfPWu4MExCaqsZ
         2gQMdR/ukGeJNpqEvKxADpTKqTAjtrAQ7Op1sWjCzBvPg3KnZxza/x69OPKntj9omcCF
         5FVa/Zsdh8+r2mjHFtQfQIoON+oF+uRVUMZMgWshJKQH4TFrwaHQDNS1JroBMhZLLi6d
         oZCg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4AQ1gzpYnNJQTs8ZEpjrt3aWrW11iMVwTIRw08pc7x2BhCJX5tsq3hVd3KIiadt9j2i01bZRAPX2oBUCr5gR8HLbxyVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBJm7WInA6i2J8QbOjhphh4+sEJq4+Ap0mn1l+ZervCBzGBAM
	SoQoyf/+zf4v2gDL+46pqentxJGvJFOfYd1kfqyRgILcmjYpfu9OJWf9zm8q7puDiQ==
X-Gm-Gg: AR+sD13sHJ21uitC8xrO/vlEdE4MP4GNOS1ZsCBlf/vsT9mYW0jbEsOYrxDQ+nH8i2m
	gHcTEkIM7mpSWo7DtRVcg6j3HVFoIQsBv7/1gRwNWzNenHfIV863WOjWOChxWlHkx0tWvlCl7v4
	nwQMQsgYhu+Okzfkme+G3NgmRaOk5CFZ4xoLIUVJM85FcmniolHJA7L70aUpb2GMIBdKOgB1dxP
	5QQslFw6qp2HetLU1eYqh5T7QwIppNLN/OI5UNk0m5wfcCtIXkjUDpUtEaAitkce/UbpHxeep1O
	iPCK5EBcZ7vD0LPF9Ie3EqAGMGtoSzj8O6L9Qs0OYkw0bPw+yOoMKPWXZZpTdXAreXgo80aIXzA
	qV+BAVN0yO6UVZHEV5FaeSyUvkDzSHcYXqmKtKP2YD8aZGQDcOQpwqzXGRgyxqhZ+CylPn4CRy8
	wpJvYay43pQ34lNa4Iq41EOFsHMvgV9ILJUcMVTqrs4OIBA0JWKjcddipoXEqsyQ0X2+Rl5TBXa
	DlELoEC2KSWVMEO/6AOntjPfBBJKapheQ==
X-Received: by 2002:a05:620a:1989:b0:936:41fe:2350 with SMTP id af79cd13be357-9364910443dmr875713085a.4.1785961477613;
        Wed, 05 Aug 2026 13:24:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9365818c9a7sm82088385a.5.2026.08.05.13.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:24:36 -0700 (PDT)
Date: Wed, 05 Aug 2026 16:24:35 -0400
Message-ID: <e8381f47156a6d70a99d5a3c24286662@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260805
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Eight SELinux patches for the next v7.2-rcX release, a quick summary
below:

- Continue to improve the validation of SELinux policies during load

- Fix a SELinux regression caused by bpffs changes in v7.2-rc1

- Fix a SELinux preformance regression caused by SELinux changes in v7.2-rc1

Paul

--
The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260805

for you to fetch changes up to 9c1cc4a7f79275ef93746f6247685763b475bfb0:

  selinux: check level category sets once at load time
    (2026-08-04 10:57:46 -0400)

----------------------------------------------------------------
selinux/stable-7.2 PR 20260805
----------------------------------------------------------------

Bryam Vargas (6):
      selinux: reject a permission value exceeding the class permission
         count
      selinux: reject a class permission count below its inherited
         common
      selinux: do not cancel a policy conversion that never started
      selinux: require a class's permission values to cover its
         permission count
      selinux: reject an unclaimed class value in security_get_classes()
      selinux: require every boolean value to be defined

Carlos Llamas (1):
      selinux: bpf: check SBLABEL_MNT before isec init

Stephen Smalley (1):
      selinux: check level category sets once at load time

 security/selinux/hooks.c       |    8 +-
 security/selinux/ss/mls.c      |   24 ++-----
 security/selinux/ss/policydb.c |  108 +++++++++++++++++++++++++++++++--
 security/selinux/ss/services.c |   28 ++++++--
 4 files changed, 136 insertions(+), 32 deletions(-)

--
paul-moore.com
