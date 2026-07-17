Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901C2F8EAA
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307815; cv=none; b=KQcmpJT8NoB1RkioSrKmYwZHUYmNV9XDuE3ZXYSeLHNV8VCweZV1icoj0Xn3Ajrg5YrJoRQAqzLJYRlVsaBN/rqN3yxipXcbrYHMJwyL0qQYd0xm+SQ59yWjqCx0t4J5gVbipya0wocP2u7KyZoho7GaRvtZ1Ot2BrYs1K/qVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307815; c=relaxed/simple;
	bh=4IyVDEjTbHrMhKT+H+6dyluqRj6+971TcLj7HnMvksQ=;
	h=Date:Message-ID:From:To:Cc:Subject; b=QU4w0uEwdM+6NZ+avl39iG8iirBfObBLfmBLL0OA6YJ1OhK3O/L5W8G50Z4DuoCCmkg++6DsubzFw2eip+CYsfdaOtnJCMJyT702AcTCCqMs5Kn9aCha95Zwy3l6kxcjvCjewAVJNgW8Uv3Vg3vmJls/6AjFa9dQnyEWPxtQPGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=V/5lBr/O; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="V/5lBr/O"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92edb12cdf2so295998885a.3
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784307813; x=1784912613; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZBj8o+qzHfyvCCselvW/9XCn3UKf7PzkVoXV3QNsub0=;
        b=V/5lBr/O3VRUvSBqwm6ku2OFMchm3+ykXMbba2g2EuYtQFWN0RmG4QvbjCwF1P17Fx
         XvkR2ejQPcB1StQ5c6n0X1jlg46wtumhjEqKEitT4c7nvnsjo7yUrbw1BhSoYbnC3Bq4
         SXKSA8bh+vB6cy4xy+TuQg94CKJ4aerdaXFwOOwhY1lhIBoiJk1Ul2zPq9LTp5RajYm4
         vHx4Sl0fQlUk0BRuwpSKj1bUmTmGTBUZLlTiom0JxWBUrYfqdPK2ojVBm8TS8upyDJ8M
         /UNt/mDVr4SAk91xANyt9CCU5JkcP134GZL1otDmjLVJmTou6x+VlkkC9lic9mTHN2LI
         Xfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784307813; x=1784912613;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZBj8o+qzHfyvCCselvW/9XCn3UKf7PzkVoXV3QNsub0=;
        b=B+K542GHcarQ3j68unFmBeuoAK9HF6XsRclPG/ofO1Mp9T9u42iujg3Xj6IDbk+JEu
         F/F9aIJarFqSHV4ZtREvuUmMwQWl3XXEVkdKh6KJOaXC0JNoNNYZ6rLhnvv86XXLb6o7
         YnianXFhVnHJ2dgbjyuk77vutDnTBJJHSnKiqXKG+RpTY/EHSQ/FEsW5k1vIDbgT+bhZ
         a3XokU7blboPOnV6jhN9bVypW+NCwasJ3PEC98ts+oVdSLpcKTkWqzCSN4KW3uQ7dLVy
         qFyWgx9oSTAhyl74SLL/zBzgPRH2IhTyf8npNWo9j+uJaRHT5GVQgurl1gha+cxPkxBF
         NDeA==
X-Forwarded-Encrypted: i=1; AHgh+Rqq3n8RpOmFotlhjsn0hDxlgUwGynfaiVqoPBy/DEgpqBcqDUiXUz8VwBJ8ySKhe5J3yJeUwPXNhgdM+2s4NHEhEBklDNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN11NUNujNhPu3nFaO+NBy2Vnxn1OEkpcb+g9E8gv0nodwclqX
	Ygj1NlhS275mrwKgej3QbcnFvw/v7vAJXwZ80S5Z7MoKAvsjlvv0hM2Wd32f0OVtJQ==
X-Gm-Gg: AfdE7cnmxQj41FpHnvleEIXvrqsjhGITTZy1ar5jB0mPb4ypBmgrnV5Wu7JQdbmqbVY
	zR3ll/aNZF94zrCzp+FYq3jYbuG2YqnWeZlEkyU6s8YWQwH4D4NkbbDf9zzicmLGkzXIK274LJQ
	8It28e9+f51X+hIwTF20FT789ZiizVQQW/bqoh+gZziTUsunT35XidpcGosEwJkY//Csi9lwHRq
	bc4nc2EXvnlSrhbmAqCWKB2OnGTkIJxRAuJPJGLV7cQT4bkLTqlRz7xEYHoi9Qc0O6pNWR9Tnzi
	M8j/1cNqJdfgHleVQnz/dcPaJ0UMBgeVcruggZ/jDggIh/Gh4/6jS5AzpgFwDVZE4McusrnGI7r
	Jhc9YGCKoh/kV5U2+534eHcWOS6rWo5i5TNIYaIK7T6z63HA8BhosJbSBsa6XaSvm2yhn+UsUCN
	3wqhk769TYGRc7LqrcpLZU6O6Mfkv3Dvy2qMxKcoo0BHARdSk=
X-Received: by 2002:a05:620a:2585:b0:92e:de49:64a5 with SMTP id af79cd13be357-930b416d8c7mr389590585a.56.1784307812602;
        Fri, 17 Jul 2026 10:03:32 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52e0f87sm196745985a.7.2026.07.17.10.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:03:31 -0700 (PDT)
Date: Fri, 17 Jul 2026 13:03:30 -0400
Message-ID: <fa44478822ef189fb7a5ce16135dadd8@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260717
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

A single SELinux patch to correct a problem with the overlayfs mmap()
and mprotect() fixes from earlier this year where we inadvertenly
included an additional SELinux execmem permission check on some
operations.  Please merge for an upcoming v7.2-rcX release.

Paul

--
The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260717

for you to fetch changes up to 9fe595fad54d4ac6a402edb3f60bec859d52cea6:

  selinux: fix incorrect execmem checks on overlayfs
    (2026-07-14 18:10:20 -0400)

----------------------------------------------------------------
selinux/stable-7.2 PR 20260717
----------------------------------------------------------------

Ondrej Mosnacek (1):
      selinux: fix incorrect execmem checks on overlayfs

 security/selinux/hooks.c |   42 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

--
paul-moore.com
