Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A742F9D8C
	for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483574; cv=none; b=jx/787x6cpE5ZQp3Gs68t4g3L8FKRweTGwilfewIabrNxZLZswpDdSf+MZ6nKrqxZ656r+90xPyCEQLpTrXT9b52tLagRzeohTi+G5G+/zm8zaEg+TkdHemY1vdIdT5qz5oCv8qEVyc1lMZFZPTqfFqUFTuE83x26Edhmaqa1d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483574; c=relaxed/simple;
	bh=uSN4FXEH/3MuffBTCj2UYI2kGTHCWhQlnhaFfdx8IkU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=SqSkp2kAlwwohdvpIDJC0CpKgsMbirY/3ge4P/VbyL0wrcMD+WOX5amjWrfMvRBGwOHWMNPeYttGXtVFfKLzaGrgN3GHgrYjG7CSzltFVlQC/NECqaa7sqOCI/GCmbFSKhVHqYVYQ1uEbV+bt6fgy1U4MrNrh1H3Yyb7LmAxBSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J+cgwIPm; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J+cgwIPm"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-795be3a3644so46705266d6.0
        for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 16:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483571; x=1761088371; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWvPskZ+a5ABD4yOHJLWshlzE1qsBPvU8Eyo2RkT7/U=;
        b=J+cgwIPmIeXNQNd2aqaNp4EwgZMRN0nTy1A1qxO+DCYGlQ+5TmPjYWZay/7B+UJxmY
         hRCOploooNk+X6W9qkzr56EIjWijWciQVXzdyaTmFV27azILROFQedAiQTog55nT3CZn
         GNZCP4LsHSEf+XssbeNDWjs81InSeC4mijblXPqyZEpNYcRop2sOEE5Vi8YfqVUdyLj5
         a2nXYg1Ru8L5+kPQZk++Rs2Znl8rrDlzPNYE3yNS34UAqDvWnyj9otwMr8q4FoWsNMle
         2KzcykpUaIsCfnD8QLOwqTQA/ZNqDtXvdKSBgCq27SBy2FuvRXm0IvHd2ABTl6lslHLZ
         Yn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483571; x=1761088371;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pWvPskZ+a5ABD4yOHJLWshlzE1qsBPvU8Eyo2RkT7/U=;
        b=R2rXgFONlbRMxhht9veuMAH1l+0UKEE37BBm4SWZnCQkMp/2PTZzCZPyG4J0zXcY17
         pZuJyXnYZOU3OuBZpQGSK0NUK94IE4UjOwbCwsgzr/FLRGQi1jfzGcOC3jXKqxDr2Sj2
         gLkA5RmqFcTK14cy8sj0jVP+s12/7S8eM4DGkxMWwV2O+7KGwbHzBrgHhQZ2Qlq1RexI
         KZ5tboP31iQjWmAcUHjRJnteigO3nFIENeyqvOPa7B08CYuPxlydFxCqSBzyFomBcGtV
         GKWLpEu0r7jrSFTuvTiWdSkimd8BuZ6nCWKiYh2YzGXkFVtczRjjDBCxDgQ6OSqGXnHH
         wj8A==
X-Forwarded-Encrypted: i=1; AJvYcCX8acVwPnNqrCl9YJpgwS8Fm3jANzzABggUjJHRQSDpyvQDfWDcLTdOI6xz42DTT3is/hqXHURnzGZzlib+jV0Hgoxu1RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxadoR0jbIlQxWwjUdZiLJZNX2XznpYDOqQML4upEmBU49tov6S
	4UcprDKdapo+qihPG4Tr0KQSt4Xc2LsRyLWkNyk493FnisW5IRN/SXLfI75Vdhxg1A==
X-Gm-Gg: ASbGncuXoo9WZX/46vqGuipzwTM7jWnYewUc+DQUnlL8i5VqGPmmQTdvSzcQr8qG/Rq
	B1bBZBIVFJhesPGyYG6dO2D/IONHOremEhIVHtB9E8QyMVTXtyrkMb0pykqAA625RdbXEYDBZEw
	hj1jik4rr5cFIpx/l0jAW9M0qS0sjNMms58+XTA0gts8ffseBr6BKvBYXDjo2Kgd7U6QSvTh0M1
	KYop79vXRosqWMVt8pbwR7URKxDaZ3Ps0e5mm5w+Gy4utfuPzRI+kqHFAUTPuO8xKOHjn53F+Ns
	NHMUUC36YLaqh9n92pIWONFExh27+8L5hc8qIk2gQRVaPF7QLRZeDb/7eDSOViExjp2+2LgrRSv
	GsJkwBCHrxDV5JkK9h1RTCevuVu+p1tWIe1qw/Q7z2py45MK1NqIBNJEe1TyzkDu1llraIkHj+B
	c7bSjSF7M7H1HUlqpkS1A3Uw==
X-Google-Smtp-Source: AGHT+IHCPlsD9zAsKBhE3Wi8fF8+vdSGhRlXGGKb3DnpK8wXKCrf1dLszTeWmxiFrIx4cZK1oq7OBA==
X-Received: by 2002:a05:622a:4814:b0:4b7:964d:a473 with SMTP id d75a77b69052e-4e6ead5803bmr401868921cf.52.1760483571078;
        Tue, 14 Oct 2025 16:12:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87c0120ce79sm7028506d6.10.2025.10.14.16.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:49 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:48 -0400
Message-ID: <7cccbd87d3ca12f377fca6cbc564eb69@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 6/15] LSM: Exclusive secmark usage
References: <20250621171851.5869-7-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-7-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> The network secmark can only be used by one security module
> at a time. Establish mechanism to identify to security modules
> whether they have access to the secmark. SELinux already
> incorparates mechanism, but it has to be added to Smack and
> AppArmor.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h        |  1 +
>  security/apparmor/include/net.h  |  5 +++++
>  security/apparmor/lsm.c          |  7 ++++---
>  security/lsm_init.c              |  6 ++++++
>  security/selinux/hooks.c         |  4 +++-
>  security/smack/smack.h           |  5 +++++
>  security/smack/smack_lsm.c       |  3 ++-
>  security/smack/smack_netfilter.c | 10 ++++++++--
>  8 files changed, 34 insertions(+), 7 deletions(-)

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20251001215643.31465-1-casey@schaufler-ca.com/

--
paul-moore.com
