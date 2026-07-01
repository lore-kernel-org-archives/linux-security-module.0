Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB06346E74
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915525; cv=none; b=a7oksNotGn3vNVk623aa5mtqlRia/iui9MLrB60OOMpoaQUpqcg+RxvLbWPjogzOjzBOfJ8PuApWpf73FS+vstRlr8YPrOUCzEnNN2QQvUqgrod7JK8zWn+acRRZygLlebsNysB/24nAFt+Znn38hYQN7xbbch9jdR20eSqO8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915525; c=relaxed/simple;
	bh=PFFo7h7gOSRJvPMfXM/Utr1i+DFVy9GuaNydkRf4zbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P2nWXKaxVS/sxtZ8W4LtLAlxHgfQPWfFSliXwPDVWqN8vXBDgWDA1xCxdOuYVroz0DazMZjHRLssaMzTpztqtzWdOFrgdlsxx73sV6RP9N/ZNBHWsBT8c3dGE9mPE7PW0sDUbb6sGbXzuihd6uX+KzLNbxS/DPXPlHKKU6ksf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pwJNcHIa; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pwJNcHIa"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37fc13e8182so910879a91.3
        for <linux-security-module@vger.kernel.org>; Wed, 01 Jul 2026 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782915523; x=1783520323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXvjFbiCBj3zMYUwQudq7Nuf6IsDrsbkfKwCQ0KY2cY=;
        b=pwJNcHIaxlfGX9bwIcfWA/+ORGQJTaT2P7CrZ3torgnFDfHYbFV9kG4jDc/wOAF17Y
         4W2uwOguj17F36easz//rRv35tp8rZCKE7fZSw8Fmepo2DO6nGBtNm4ry4l5j0enhTfa
         02o/XKqOOlT4rmxq9bCBTb1++LlQuAV+ntqRSrlj6Yi8t+n56LLBZH34GpPkhwPtOt3p
         6zp2KhRogggfc2rXabEtlvU3mUwfEPY6qoIuApyhCN2Av756SFCKZoHkp3JoVfgszAfr
         dhlPlAKVJjyvRzs6NKqNh3sKEzbvzFa5tbtG03Pu/P3Hjyxjmqb/nYIBKNSEw7Othn0P
         lGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782915523; x=1783520323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXvjFbiCBj3zMYUwQudq7Nuf6IsDrsbkfKwCQ0KY2cY=;
        b=Yf/GQeER2dO83wujSMvZeZKZRmqPOJxd2PIyWAmhmwRreQQjOM7LQTa1CNT1WvpPzb
         M1gB59FY9jky/OK6TrWyMNAPDywA3OmhFq+RbmHUqJ5rJg/EIn7UUKQ6hdjd7hyS+U3O
         g3gBk/MSd0eVacubvuMKBpcwME9yq6QBLufyxBKVASyS5ksCa3/xrdVqSyFTyx1UdqtM
         7DUupyWZn/nPKfN4Fwzjaa3DDFqcU8XOweId0WBqf59IoeYKfwjwrqGpHyK/TOq+JJN8
         KzF3USllNeKWziTzED3bYTwwymNrSbR3aUFLYkSpJb1RTZ4KhxhjCvDbQKu34UtDekzF
         Dd1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr3RUl+0dNgaCpxC+3XdFt/mkc8msuLZH7K247XbFQxbkcsYpQ8bF8iRbu52fpcRHkkY66zpkABjd8P7y/afpaAzacZPg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztOfqNDl+0bm8PqJ4bge7a4rNvfX3G9RQCYdCmexrAbH7jLu3K
	PJ4mj7DuArB3lgavNjwbOyS+xwmP3Z8QKyLBjDeV8mYB7M9cx0b7IfTYgBaI9Na4RuaHKQdsSsj
	BVMgFrQ==
X-Received: from pjre10.prod.google.com ([2002:a17:90a:b38a:b0:37d:d531:5f4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5585:b0:37f:b0a9:1a55
 with SMTP id 98e67ed59e1d1-380aa0b5724mr1993828a91.11.1782915522810; Wed, 01
 Jul 2026 07:18:42 -0700 (PDT)
Date: Wed, 1 Jul 2026 07:18:42 -0700
In-Reply-To: <20260701123520.271580-1-wangyan01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701123520.271580-1-wangyan01@kylinos.cn>
Message-ID: <akUhwrDSCjGLpnSg@google.com>
Subject: Re: [PATCH 0/6] selftests: fix multiple spelling errors across submodules
From: Sean Christopherson <seanjc@google.com>
To: Wang Yan <wangyan01@kylinos.cn>
Cc: Shuah Khan <shuah@kernel.org>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, Wang Yan wrote:
> This series fixes trivial spelling typos in comments across multiple
> selftests subdirectories. All changes are pure comment fixes, no
> functional or logical change to any test logic.
> 
> Changes are split by subsystem for easier review and merging.

In the future, please send individual patches.  Splitting the patches is nice,
but then bundling them in a single series that affects different maintainer
domains reintroduces the friction you're trying to avoid, especially since most
of us only got the one patch.  E.g. I only received patch 4/6, which left me
wondering "what's in the other 5 patches?".

> Wang Yan (6):
>   selftests/arm64: fix spelling errors in comments
>   selftests/filesystems: fix spelling error in statmount test comment
>   selftests/ftrace: fix spelling error in poll test comment
>   selftests/kvm/x86: fix spelling error in xapic_ipi_test comment
>   selftests/landlock: fix spelling error in fs_test comment
>   selftests/powerpc/tm: fix spelling errors in comments
> 
>  tools/testing/selftests/arm64/gcs/libc-gcs.c                   | 2 +-
>  tools/testing/selftests/arm64/pauth/pac.c                      | 2 +-
>  tools/testing/selftests/filesystems/statmount/statmount_test.c | 2 +-
>  tools/testing/selftests/ftrace/poll.c                          | 2 +-
>  tools/testing/selftests/kvm/x86/xapic_ipi_test.c               | 2 +-
>  tools/testing/selftests/landlock/fs_test.c                     | 2 +-
>  tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c        | 2 +-
>  tools/testing/selftests/powerpc/tm/tm-signal-stack.c           | 2 +-
>  tools/testing/selftests/powerpc/tm/tm-tar.c                    | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)
> 
> -- 
> 2.25.1
> 
