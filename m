Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30138DC8
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720562884; cv=none; b=X6WJrHiJLrDcQBS7PHg+NEoHhiQcEPN+m0zyLr3d1DiTATfOHSV5eSd4+LXMuKwD1RTwDiBV5LA6tiQZEQstZxRWkXA2G2mbzb0ySJc3muiABZfhqJIPWnQCuPnR7/NCvOrWVf3ri5u19IeT21BdHBHBfx5Cz5WWVwl22n1fMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720562884; c=relaxed/simple;
	bh=OcCbFBtOOdtcjEHE0J+EHyCf9/iadOe/psDqDsdfq1M=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=h93qBiW5NTPwHn5KQejiW5tdIXzR+uTEj2+54pcT2m9Gl2oybMefYoYWrhUFDI/pwUCDHiqsLcbFxFDB2VQm8WfjgiWuHcTH501a2HSP/dzLDdLHmJ+dcJCJGh+RSi4PaQiWLrh8dx6V0+VTsQChLeWC71ds1ut2AODVZRtoh78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G8CahuG5; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G8CahuG5"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-70364e06dc6so1310392a34.0
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720562881; x=1721167681; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PmLo4Zcw2jC0g79rTyQJdXFrJQHNuDkZQi+aAMfo2O8=;
        b=G8CahuG5bh03G3L5TXY8NQhYpEFNq21v3AX8JevPWgUPkURDld6D5bEySUWrnGosEe
         VPvVQKmo6/ffsJEZnsadCaE3j0Er6zyJECAsh0NLqQC6Y6QJUjttJVTWXGVehO/RTJ2b
         eAJjnr0kPUdRuHp5dRB0EDi3Uv/eNL+sIAzA7Nta/PHQA2ebmqcpL+bBq7h/9KaeINa7
         DEcxQ5pG5ZpRUMszUsgoaA1FoSEQITAoLDrpmMiYrCzNc58gsyAlVS9WVrBT94av9blg
         nsIEVI5WlPLRQtDOjxWcdtX3ZsM0od2sfAXS6TcTK9VugRrqbYOVImEAYMOcRLigaDXp
         OKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720562881; x=1721167681;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmLo4Zcw2jC0g79rTyQJdXFrJQHNuDkZQi+aAMfo2O8=;
        b=O6ZY/Og/bKavnHjkIpTGjjbQMTnzOABC5XGFU4frxOLXKbzBKHhBz/ERJn+Rt79iMY
         5Qd+lle0zLwsFO1XOMHyK6Co3ZtGY5fUJF/lzm2wiiomw8ArOPAamE0muneef1fH44Aq
         v4hm6kyFDqmkk5reXxJ/OHrjK+UdROm753e+AxlNG4cExVu2mKpb02GCvtccQICiL5bo
         pEJD9TiN/uzm7eZbmiJlr7Uyb1V9euMEamOwuJXshVJR1NTOnBMzYUE/d62ZsyN69CL4
         jPyfI7GikWInlmTmJyQNc/NbzRTXQUOSxEu1an1lHyhXw0cwSQFc0zlkp6HMQewbCjr8
         s2oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwYHKD6DtSRN1fe7cvxLHYekzd1L5/e6wF8JHRm94P5KR8mVOA3YqCF7b+H3fS3H8INT5UAfPwJhm+37dYryGmL070Yjgy/3wuGUtUf6r6cMmqPcij
X-Gm-Message-State: AOJu0YzEz9gafrKQKFYOdemqObFOUVSO5C3n2t5MbUr650jxpHxRYRrK
	pzoT2XadV+gvLza0aJdODgi9Qru3eIzpNGXyOfItnsyE6qSVgMfesI8B5PkPuw==
X-Google-Smtp-Source: AGHT+IG3spu1sFdjRBeKq1+rUEj9OYl7yAWKWlDaz1NFSaKFpFAzBBd1v1SjXpOanCtJiqJG+yyCZg==
X-Received: by 2002:a9d:6ac7:0:b0:701:ff2a:e50c with SMTP id 46e09a7af769-70375a07e4dmr4320974a34.13.1720562881422;
        Tue, 09 Jul 2024 15:08:01 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b26c90sm14529291cf.8.2024.07.09.15.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:08:01 -0700 (PDT)
Date: Tue, 09 Jul 2024 18:08:00 -0400
Message-ID: <cb98fac71d2a4c879ba64aa398be6101@paul-moore.com>
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
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, mic@digikod.net
Subject: Re: [PATCH 1/6] LSM: Infrastructure management of the sock security
References: <20240708213957.20519-2-casey@schaufler-ca.com>
In-Reply-To: <20240708213957.20519-2-casey@schaufler-ca.com>

On Jul  8, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Move management of the sock->sk_security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h         |  1 +
>  security/apparmor/include/net.h   |  3 +-
>  security/apparmor/lsm.c           | 17 +------
>  security/apparmor/net.c           |  2 +-
>  security/security.c               | 36 +++++++++++++-
>  security/selinux/hooks.c          | 80 ++++++++++++++-----------------
>  security/selinux/include/objsec.h |  5 ++
>  security/selinux/netlabel.c       | 23 ++++-----
>  security/smack/smack.h            |  5 ++
>  security/smack/smack_lsm.c        | 70 +++++++++++++--------------
>  security/smack/smack_netfilter.c  |  4 +-
>  11 files changed, 133 insertions(+), 113 deletions(-)

This looked fine before and with the only change being the additional
conversion in the SELinux MPTCP code it still looks good.  I'm going to
merge this into lsm/dev-staging for testing with the idea of moving it
into lsm/dev after the upcoming merge window.

If you respin you don't need to resend this patch.

--
paul-moore.com
