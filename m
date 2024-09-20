Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0573D4D8D0
	for <linux-security-module@vger.kernel.org>; Fri, 20 Sep 2024 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726823519; cv=none; b=toy9Uo21ULRgAZioor6jQpN0LgF8ihWOh7PTi036BcgXYpxrR78C7sO1K9CfYumK7+2HX9usgOrasktgPuXDxIMs/Vzh3rCF3UrqJUmIkta7la/e2SNwnzBtVCTQFa0UtCpRlECxGxvjMT48vDjHej/HhDGji84F2oBa/z8mf5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726823519; c=relaxed/simple;
	bh=BfdACjiwpH6jpQQYgFCRbsgqVxTshC9Z8Pf7EkLzUcE=;
	h=Date:Message-ID:From:To:Cc:Subject; b=LzjuQQP8BVPMB1ICXJeKrGYC0aitIb1SPQO19FoW9QPj3AQoUmuUrocT20I+ufMTW9F0ST4F7jot1V3lossc6LhmvbP0/VFMelvqrc9wLB+4sAx48YKej4ty2BszPrqPyKPhQ/FH5WBsLO34srT1eOr+tP75SDj0g5TrVURAFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZfRXV+h+; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZfRXV+h+"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a9acc6f22dso162958985a.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Sep 2024 02:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726823517; x=1727428317; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvReCFSCf9aQipym48DyE8HCr0WcsMysWCFlAr+/F5k=;
        b=ZfRXV+h+L6xLp9CWaHVnIhfgIubyG8ASZlROMhNNPoh1jkY7MbEJfhA3mDf0XPhOQk
         XaZsuo6IRd+haKLLFUNWHEvaH7V1YUVe9YRUqlohDxF53NItQX5W4p7rnpQe6x5naGD8
         13rjtQftzDxtz1f/2vl628zkwLC3qfYSy4AptM9CzMAIVWDQ6t0X8cUX7MWj982DeWYC
         sSCJWOUE/zHyPaJdMNdLn86O7fPrCjpZ3M/AhLCoOtTM562GHIJBLMWwLXI1YObFtSF9
         qpIYCcKfbn4IHkrJrqmSoBxFBc44A2uhivV4DAD49lq+OesUVP/J//g5LXi9xnmXowVd
         maFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726823517; x=1727428317;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvReCFSCf9aQipym48DyE8HCr0WcsMysWCFlAr+/F5k=;
        b=Um9vMEHKHrB/aOmckSdYpr03ym5paoy618KNhCXORycdI90bpi9qNM+TQZGUScjEmB
         ZZJyKkBgwjeO7bTpgPqDx009tmNOfkWAHmJq8lwUdR445tT3GzgW3SVNKXjTvVukduNJ
         qeNXqOTjgJdoIdKIkw9chUJKM4oAvvHu6Eth6og8xnX6hOy7WV906O/efHYJd4K1/nte
         2i/b8lSN+Xgs9UT5iIYKi6b/ea3QBztIB8SC5HtxNqvgGxwcRz1wvdSE9d0cegrMso2g
         5VqvqmNRstHcXZ1QljGwRTtyGfW7luf9P46wNnUwDs7EDk0ozRPSUs2IUEoCXIb+hH5q
         xM1Q==
X-Gm-Message-State: AOJu0Yyjq19/O1cI7+A3nv1f8ZPF+LYQ+pJSS5p2Sj8YxABXkQsGp4vB
	wdBUcNCa3WERkd3Cux9rUluziVeYOOCqIUQAeWwQEnGSdqeYGujV7aaXuE9k2WRryhhXwPbiU3M
	uYw==
X-Google-Smtp-Source: AGHT+IFNrKfjhSJKxp2/e/sc/Hs1+8MWeOQBVm7lcA/utzHJSTmA1zTL0FZRN/qGdLlY4sqTuArC6g==
X-Received: by 2002:a05:620a:198a:b0:7a9:be2f:651a with SMTP id af79cd13be357-7acb809e802mr378354885a.2.1726823516879;
        Fri, 20 Sep 2024 02:11:56 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb07dfec5sm154857085a.12.2024.09.20.02.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 02:11:56 -0700 (PDT)
Date: Fri, 20 Sep 2024 05:11:53 -0400
Message-ID: <f8a48215c742da6510f5c1898b4c8335@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240920
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Two important LSM fixes for v6.12-rcX:

- Add a missing security_mmap_file() check to the remap_file_pages()
syscall.

- Properly reference the SELinux and Smack LSM blobs in the
security_watch_key() LSM hook.

-Paul

--
The following changes since commit 19c9d55d72a9040cf9dc8de62633e6217381106b:

  security: Update file_set_fowner documentation
    (2024-09-09 12:30:51 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240920

for you to fetch changes up to 8a23c9e1ba4642b60420e8caa75859883a509c24:

  selinux,smack: properly reference the LSM blob in security_watch_key()
    (2024-09-19 16:37:01 -0400)

----------------------------------------------------------------
lsm/stable-6.12 PR 20240920
----------------------------------------------------------------

Paul Moore (1):
      selinux,smack: properly reference the LSM blob in
         security_watch_key()

Shu Han (1):
      mm: call the security_mmap_file() LSM hook in remap_file_pages()

 mm/mmap.c                  |    4 ++++
 security/selinux/hooks.c   |    2 +-
 security/smack/smack_lsm.c |   13 +++----------
 3 files changed, 8 insertions(+), 11 deletions(-)

--
paul-moore.com
