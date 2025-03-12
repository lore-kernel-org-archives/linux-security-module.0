Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828981F2388
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823499; cv=none; b=eDpwJ6cWzlX4qbvYV3eZuTWpnJKPwncGrSwvyJo4HL2PEeLWCnsoB2xsvm4fbEQfW8pfB/Jkuvwdlf9LdYNs8z3XDxzJr1dj8Qd/qBckJ9hfAa9UFZUFRPcEoZX/57oMLPa/b157yAUz/MaTfLuKeZTHFErIIIoUUmfES1GqMuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823499; c=relaxed/simple;
	bh=y6im2FC9RnrBK0DsITVVl0clIoDEu4fT57zPgo7oKQI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=QP/YJ7zAj1uUHbJ4JQuYqpi7q/OGCbHkVaDGadZMv6QtKB+VWrez5igaq+4cYGljwJ1w0G4rqEKPrR8IQ3fgUvGFbwsgLShkNkrF6CndVSVOwdw+Peo+2ek40SBSeUzuJu/Hx1wUrlqdnuQ2uOO0QkQScU7qdlEVPf6ADifiaIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aagWl5ht; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aagWl5ht"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c089b2e239so52959185a.0
        for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 16:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823495; x=1742428295; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEHvEcO4NOg0YRDF2fNEp3c9gsS6yXYNEicVD7ca+jg=;
        b=aagWl5htvm96U1T2VDK+wTQWnB3Os1O1B4Smq1jlsN18q5uwQA1ye/O7YN9OFTgSYL
         Q+5F76wxKqehkXX2JLKFrrPcUFOEhyaS/xp+ARN/5ANK6NAe5KtqkkNhq0cS275kr5ET
         cfFb/pGJ4yCTm/8OFF3b9Cd2GdS+CrDaiHpmQ3ktrtByR2ZIC238a6tZgpeBAY2MXROo
         gKhuRVk+lCXBzwjypUwZFPWGreAN41yWzjA10hNffGY3/YxPC2nqDvyaqR/rqn7xWX3J
         Arc/43oUVhEoAcDOOEOwE12DI2UXwFlbJ+UnfSruPN8xj1jekQUB7+5h0PJB+yskVL58
         Uv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823495; x=1742428295;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qEHvEcO4NOg0YRDF2fNEp3c9gsS6yXYNEicVD7ca+jg=;
        b=V2ZkO5AvxqfbdezcD4Xg7AyLdjT+f2QmQ7nDm2WYsFCWrWpICzUHtMrLK+yCW6ltWU
         kX3zj3GTDSyUr6XZtxF1ruvpUMUrvnbGzxV9/S1HRnTx+DKyL1Xnq0WgWjNgS4CbXOES
         j3eFOuogNQPta0VuxG7UnMCmVABUXq3rH3U8wD1rtroTX6x8VcaC7tgrUS8hQEY2z474
         03+O7afbBMtOpIHoWVPlwHPvum4Jrm+LmvtLzlLNtGZS78kIyAsT/e0DkfgDXiNYd7Td
         OOBqsjRHkfzAd+dhG9tYhePJuNcQN6BMGSF6kZx3V/3uCU7sxkp/JFBUvuEev3mBy/hy
         tQyA==
X-Forwarded-Encrypted: i=1; AJvYcCV2fKYFlxN5m6W0AjxEmIbkTUcuyvtWDWp7v9YKLpS4SBiDMIPoXxU1jbqtBHug4R9KEB2S0Bh7+u5MkxcTAaDvTWSZatY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/7/EA+r8YLepNZBYK6W4CgSKMYYOVcLcDtj2gKuiI7GR8nNj
	6dfN9BGP03KCFlKbRUZGWWK52FiGwcJGHeoWm6jcxHFlemR4ua/RLg0G8Egayg==
X-Gm-Gg: ASbGncsgO2RqGwSoxcTO3rFd0xMMi/7X0I9BwemNeSQDVib1yzrtzNXvazduJtG2xPm
	viAVIahrwBf97nnCUo1BovWqccZjahXAsqj78nctQmcsdqDhvOcbPD3lBrTP34lqiUf1OTc9NDt
	wlh/7/QXuFUJ2HtW2tpCIt/P7mnrO3YC+n9bUbcWdT8GClooRlQkWKH3OfZ8N7A1YkfKD1s6s4c
	+5d5IjdQxF2VjbGGUxZ0R0qWn6p65s3GJL0UxLZaYm/tkH6BmpScHFT9kP/oz9xh1to7TCURNe8
	PZtzF07aD7FiOknDL0QSZSJwuvsBKjmR+5eCLU1gtvoLK+n2eU/rLJER+wIUaJVf5vgLHCfOnF/
	qIeysqGRcAljeCg==
X-Google-Smtp-Source: AGHT+IEW0E6G8sFUJZrXjgx8IgIO7dCL/me5AKtsty8GXdCJQbxSmByGBM0HaBvG1kOgomgjfgPzCw==
X-Received: by 2002:a05:620a:13d0:b0:7c0:add8:1759 with SMTP id af79cd13be357-7c5737b8c7dmr71231985a.18.1741823495217;
        Wed, 12 Mar 2025 16:51:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c9d8b8sm18772585a.53.2025.03.12.16.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:34 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:34 -0400
Message-ID: <69ee16ce82a564e09b2060d46fa2be0d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250312_1930/pstg-lib:20250312_1930/pstg-pwork:20250312_1930
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Audit: Allow multiple records in an audit_buffer
References: <20250307183701.16970-3-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-3-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the single skb pointer in an audit_buffer with
> a list of skb pointers. Add the audit_stamp information
> to the audit_buffer as there's no guarantee that there
> will be an audit_context containing the stamp associated
> with the event. At audit_log_end() time create auxiliary
> records (none are currently defined) as have been added
> to the list. Functions are created to manage the skb list
> in the audit_buffer.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c | 111 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 89 insertions(+), 22 deletions(-)

This may need to be squashed with a later patch as I get
"defined but not used" warnings/errors for audit_buffer_aux_{new,end}().

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 2a567f667528..a4945f1c3ec0 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2412,26 +2471,14 @@ int audit_signal_info(int sig, struct task_struct *t)
>  }
>  
>  /**
> - * audit_log_end - end one audit record
> - * @ab: the audit_buffer
> - *
> - * We can not do a netlink send inside an irq context because it blocks (last
> - * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
> - * queue and a kthread is scheduled to remove them from the queue outside the
> - * irq context.  May be called in any context.
> + * __audit_log_end - enqueue one audit record
> + * @skb: the buffer to send
>   */
> -void audit_log_end(struct audit_buffer *ab)
> +static void __audit_log_end(struct sk_buff *skb)
>  {
> -	struct sk_buff *skb;
>  	struct nlmsghdr *nlh;
>  
> -	if (!ab)
> -		return;
> -
>  	if (audit_rate_check()) {
> -		skb = ab->skb;
> -		ab->skb = NULL;
> -
>  		/* setup the netlink header, see the comments in
>  		 * kauditd_send_multicast_skb() for length quirks */
>  		nlh = nlmsg_hdr(skb);
> @@ -2442,6 +2489,26 @@ void audit_log_end(struct audit_buffer *ab)
>  		wake_up_interruptible(&kauditd_wait);

We should probably move the kauditd thread wake into audit_log_end()
so we don't end up poking the scheduler multiple times.

>  	} else
>  		audit_log_lost("rate limit exceeded");
> +}
> +
> +/**
> + * audit_log_end - end one audit record
> + * @ab: the audit_buffer
> + *
> + * We can not do a netlink send inside an irq context because it blocks (last
> + * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
> + * queue and a kthread is scheduled to remove them from the queue outside the
> + * irq context.  May be called in any context.
> + */
> +void audit_log_end(struct audit_buffer *ab)
> +{
> +	struct sk_buff *skb;
> +
> +	if (!ab)
> +		return;
> +
> +	while ((skb = skb_dequeue(&ab->skb_list)))
> +		__audit_log_end(skb);

Put the kauditd thread wake here.

>  	audit_buffer_free(ab);
>  }
> -- 
> 2.47.0

--
paul-moore.com
