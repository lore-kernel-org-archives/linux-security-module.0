Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6518BEE
	for <linux-security-module@vger.kernel.org>; Fri, 19 Jul 2024 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354888; cv=none; b=nY9SEAXyg7rujOqv5PHZw2r8oyjovr/ybITmUH9e1ShJtsj2yxSDo7ajIgW9DpeTfkHA5hLvKvba3erGBp8hHawpopGQSsa8BEnHlKuLHra/kTmXkDA4rANUpSsmJb3ClezPqRJp9rPdd36cU0O3Xq3K4ZrXwxTf+bhapIP4CgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354888; c=relaxed/simple;
	bh=3kQS2cZBJ39f+nV1qKNmNoKNDB7FDTY1mI5qcsc0L6E=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=g/zvv2IbV1mda1CEsd9aauS3HBaIUw1jP9xoo2f10embalbQ8xgSq7vZJioEFj8bYtOWsMWMryPr7U0xiuNsWGUwoLJDJC8h2TKPouRC72JXXagVJlTBpEjeYtF8XmxWWM5x4KsbkZh10IhspmSypK78rQfwGS2MRdW2ZOTVlOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HpMOg9hP; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HpMOg9hP"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-447d97f98d3so4810491cf.2
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jul 2024 19:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354886; x=1721959686; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RdOweloEpaz6RcCvISa0YGQIo20b47lcaEayePDedxM=;
        b=HpMOg9hP2D2CTIPEDAoJCR0GMOLmSCcqBQi5wznRJIrnLgRAQtG1TjSvV7e9U6dDbq
         DgOXGYY81ajdwliU84ZqZynv8JissDXi9EGoLvHwR5IfaPpmuxm5FkUrAYes8b+4gAZi
         6EmN8C5F1Q51+9W6JN2IlDACNzY4elkY7tv7mQmcDT5oNGrX/1CISKwP2uM9Hiy+vsC+
         ESvRK8rQjUl3QQZmlCE5KiSkc0BjFp/l9FIUTmgbaQ95Jj8LXz3lkI/fvNJCz6KwGytb
         6YmgUyci89NY1g0YBukW/VwWwsoqPYZfvji94ceyMbBydexVHF/8klkLWDM4jzklkH3S
         N3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354886; x=1721959686;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdOweloEpaz6RcCvISa0YGQIo20b47lcaEayePDedxM=;
        b=CeRN4v7FF3p1zkAeYleQr+SrvBJew051aBMAekJ1+8YCkHcEg724KTvgcGKNdJ/x2Q
         bjW3Y7NJMAI0n5o9OO4by5PU3tWIpsA9k29OhJ3EEwCMJ2xXrGpoWYQ084OknBqqTDAy
         vuwmkouwZbAqoq5Il54nzrqdru4W3b0gkQxpoPuuwSQ3lcy+lTp9DLxDqBO0iUKKH3o+
         ptB2yNcslY8F+3XY/RBixTQHqHC4MuHGrddDgHQh7C9LKRh1SPZtbbZgdszlxEUZZqCY
         VWOMWskFKIgzQlgZZHVw2D4aACflpNEJmS3dbosHmHJ986+PvdAqBUGzJh4fUmiWE9fb
         y61Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeSURa4Cm1w3YY9b6S3uFnzj55R7wdTVzUiK14TwDSnd8V9VxfsHzX04aUOva0u6TNNhV3xAnE6HtStgw5N78371dRfWPjFDkvO0qG9ggbGzoseruE
X-Gm-Message-State: AOJu0YzpGG4CQ8+Ix8xAKAqGCYZpCjRvrT/fIkWwOWVoVrlnaFrxLu2A
	4tj4QnEaNN+0pIx3ovstHxdfyHcSeXTYLDiFcJD22hE3Uen9Qe8q0erA5zhXxw==
X-Google-Smtp-Source: AGHT+IF74+EqudtKUL7i1ZCCvXjz+qd3zopM19m0jWGVbddz7RHlAWv2UgDf87dhf8FKY+88djubgQ==
X-Received: by 2002:a05:6214:2301:b0:6b5:3c06:a58b with SMTP id 6a1803df08f44-6b78e364c4fmr77396666d6.59.1721354885611;
        Thu, 18 Jul 2024 19:08:05 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7dfc97sm1785356d6.46.2024.07.18.19.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:04 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:04 -0400
Message-ID: <6e79c031aa6c223df552726ac6537d44@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 6/20] lsm: Refactor return value of LSM hook getselfattr
References: <20240711111908.3817636-7-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-7-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook getselfattr to 0 or a negative error code.
> 
> Before:
> - Hook getselfattr returns number of attributes found on success
>   or a negative error code on failure.
> 
> After:
> - Hook getselfattr returns 0 on success or a negative error code
>   on failure. An output parameter @nattr is introduced to hold
>   the number of attributes found on success.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      |  5 +++--
>  security/apparmor/lsm.c       |  5 +++--
>  security/lsm_syscalls.c       |  6 +++++-
>  security/security.c           | 18 +++++++++++-------
>  security/selinux/hooks.c      | 13 +++++++++----
>  security/smack/smack_lsm.c    | 13 +++++++++----
>  7 files changed, 41 insertions(+), 21 deletions(-)

The getselfattr hook is different from the majority of the other LSM
hooks as getselfattr is used as part of lsm_get_self_attr(2) syscall and
not by other subsystems within the kernel.  Let's leave it as-is for now
as it is sufficiently special case that a deviation is okay.

--
paul-moore.com
