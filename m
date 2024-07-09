Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F338DC8
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720562886; cv=none; b=tE7tr8aQm/FM9WNV7E1zSGzV7pAi9vc4aEg8MM3ch+VyZMGmKmuvEBQgM/UWyImO32tETrI+niaNrIHOmXfJdWPXZiedjhatlsLE3ikKeC+bciCGSYA6+G/ox77GgVP0Uzh5mnZT1J8+pB35N8+62eGD2z5um+19WWPsGupp+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720562886; c=relaxed/simple;
	bh=L1XQ81rUdqGcbMW6y3+4WWbvNlr22bvgO4PGp0JN8Kc=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=OWb3jmQExNPfjXcgCYVU6g8OiMSW67WQUJVkBkdvOhVBGwD1uuXaRg9Nd9dbwRh8Seili0vZa+BXHmngtyyka0K2OYnBB94OkSu4W+D8CA4ay2GKly+fyEENAbvcIbvcW80p8JanD7B5Q2XQ+TperYlNix/wRtbnN4fOKBwRIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R6I+zCBb; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R6I+zCBb"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b73dc6e7aaso2629416d6.0
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 15:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720562884; x=1721167684; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g8B+Degki4KYV/gDwJXAhqdmgQZ5DO6DQPDAksSuO0w=;
        b=R6I+zCBb9rhkTJQrsjTdW5RgBEjNNxuvoL/3vwzWV9FPUXCZ9sQ3JClssp0fENMPrw
         bJrrIeB5k3l3/KpmuCaJnRI5oj9QYFi9sci9jfdf57I5E7SbtjNS83UHwoJDrRZj4GsA
         1oA8ahVVKCSKL3cZmSMaNAYKykdrFDxoidAMfyYbNQSWW37CpuIMUM7KFMfb3oA1P18j
         GnzcZuW8mqIZdlyo7EUIFi2hC2mR4d3M0Z9MRcctQxF3+iBSfjfhvfrvyPhAF9Bbln/E
         6xhbubnljjPJBsCW+E3QjiL65++lrelaDcpkhCa/8XRFb8S10I897lsSC68Q2/M2Ejqn
         iwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720562884; x=1721167684;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g8B+Degki4KYV/gDwJXAhqdmgQZ5DO6DQPDAksSuO0w=;
        b=HwXGxEXEXqU13qjdrb1Ge8uuxH9NwBtEAsH21ET3soImcxdGolfbVhG+FVzcV2Rl7q
         KHkQnaSPEmf30UrWM9O3ShIZHCNSkzOQ1KosK/KkgpItxd/4BOOnVNNWuoms+yUk96/V
         FAhXtrHHxE/atBnygA1qiM5TVTl1/n+sC7byowEaivWS2a8RHTxft48SeYWVTgwtcUNG
         90Y8cndr8N3x0a9oNERF/u3fCRbjkOi2eH1xzMPifCr60V4d5j7Azln1gNbuO4nWZJHz
         VUsDRuqh0dgYV9gwopzzFfvVmTJ+YGJN8GEt5ZXfKWwPJthPOUZGPUPQYauemd6sfEN5
         wKqg==
X-Forwarded-Encrypted: i=1; AJvYcCUluylr5xy4Qo0Q3pjdOE/SYSGyox3QUXpok4rjJd3su2R83L+pxhoYY2MxI6wN1a3Ybl9BOLKMtj8lYAkRd8T19g8fxnODpeVtkP5+iK1TVM/eSBNn
X-Gm-Message-State: AOJu0Yz+5GQOv6ZjFKJkUazK+NHNfaNzJVldp+RQN/1jyBIfwmfzc01g
	a2D6UVyQLaQH5VkosiWWvfmuyNDa9wh1X0DTcPt9lfA3h5EkWA8AqIRNoCkZ3A==
X-Google-Smtp-Source: AGHT+IGSmbHKUfgl/YCuNvsvaFbP5YEoJ7Sek22XIRASVzf5pM6JP0EQx4LFsZcoFyH8CMiaJXdBaA==
X-Received: by 2002:a05:6214:2602:b0:6b0:92ac:8193 with SMTP id 6a1803df08f44-6b61c1e2e3bmr41200296d6.54.1720562884063;
        Tue, 09 Jul 2024 15:08:04 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8c087sm12311976d6.121.2024.07.09.15.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:08:03 -0700 (PDT)
Date: Tue, 09 Jul 2024 18:08:03 -0400
Message-ID: <6e7f6a585d0b3189da2a10ff50fa3a66@paul-moore.com>
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
Subject: Re: [PATCH 4/6] LSM: Infrastructure management of the dev_tun blob
References: <20240708213957.20519-5-casey@schaufler-ca.com>
In-Reply-To: <20240708213957.20519-5-casey@schaufler-ca.com>

On Jul  8, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Move management of the dev_tun security blob out of the individual
> security modules and into the LSM infrastructure.  The security modules
> tell the infrastructure how much space they require at initialization.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hook_defs.h     |  2 +-
>  include/linux/lsm_hooks.h         |  1 +
>  security/security.c               | 11 ++++++++++-
>  security/selinux/hooks.c          | 22 ++++++----------------
>  security/selinux/include/objsec.h |  6 ++++++
>  5 files changed, 24 insertions(+), 18 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 438ec6708eb3..2c9d075f5f92 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4864,6 +4872,7 @@ EXPORT_SYMBOL(security_tun_dev_alloc_security);
>  void security_tun_dev_free_security(void *security)
>  {
>  	call_void_hook(tun_dev_free_security, security);
> +	kfree(security);
>  }
>  EXPORT_SYMBOL(security_tun_dev_free_security);

If we removed key_free in patch 2/6, we should probably do the same
here for the same reasons.  Don't forget to mention it in the commit
description.

--
paul-moore.com
