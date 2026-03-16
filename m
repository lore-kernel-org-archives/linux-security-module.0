Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF733A9E9
	for <linux-security-module@vger.kernel.org>; Mon, 16 Mar 2026 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699284; cv=none; b=M4YPDM+oj8BMHCLDM/MqgHyf9s4GZXSiEfWV+wpkrg0tp11aib+sIah/mErbEfuADAYxoayiWdhSYjMIDlkbIC2jTZmGtbz9or79j2WfhH37GKys39Pe46OEACGZv8649VAPfFo+TWVXSLSnyPsIdeqtnmoYGvIV96puuF5BKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699284; c=relaxed/simple;
	bh=HGj5yiUG7iKWATjOzUz8OSk7F9PspHcBFX+MhNveJts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaUOodzq5YLBCy12vxsrcBva0/WSlyOeTBMSdbRVf9XKFT7ZpAaQnOuoWZPu3CrNP9uXgrIAME+BStZjwKMLRELYCZQHkiu+P4YIUhZMQ4yXyQYkZhhW8vYGwcLV6BWErTo/75MzZOZ8ZDhJ7hZDvLswImW6kBrFR1xtyZHO+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTH+pELL; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTH+pELL"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89a0ecbc713so2573596d6.1
        for <linux-security-module@vger.kernel.org>; Mon, 16 Mar 2026 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773699282; x=1774304082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xVo0DvHLvdFL5zFcyTS5pi/B+LyIVJQdufAwf30Klo=;
        b=gTH+pELLcKYJsiNcJvWi2+XVvonHdHeESyISqkJ/8XBdU31sJZU54Dafsf+tOfcO7S
         LZzyi6Q27OscB9DBKM9PSCFNq3bIKRKI8AzHzvgxAHOFdvk69VUkYpszBl0bMrG4o+qm
         CwmF7fOYP9iFPaXJtuSJY6C3P99CZv0dmNHpssHaizJu4v8p7xTVxvu8E+VKDP9XyYbh
         bsCGmdfxFVAydBEnEm8d5FNfbjZhIDOlfDb/GdiFjs729HlD/PyygvwmB898d4lbFH77
         chh4j6zq4JEDejcZCjtpD+Tj/P4lZ76LcXgXMzYv+feMt9RPGjhgVGCYOHqugQ2mI7VP
         EKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773699282; x=1774304082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xVo0DvHLvdFL5zFcyTS5pi/B+LyIVJQdufAwf30Klo=;
        b=Ak2W16fN6R9eumjxiiUWeNA/Us7n4Kb1srCVQUMY2Z9v3Iu6zySaBzyxOqhJGmvUIc
         c0quxmqYSzpV6gigryyT1ltwqVf9iu64EP30x65YxDPeZ2qI8NCq2vRnffZaCqjpQTeu
         uwk2N7R2WDRql89W2+NDPhsP6APRm6Anf21Cahbxc6doSz8HoCIb1M1qfnmP2BSWYLed
         RqdYSw5Pkay5ak2pKwWOND+NjFgnWfmqnpYlBVDX6gGPDuwa6KYXFRYQPI+lnnMnEefW
         PYuuNhK8ZRmigDEdoMVtFb2hCfvokaSBjsE8ginweeKSSosLJ25P9bCo+ofN+Ph4CJOa
         XG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkTWbIkCtq/+pFahlVMCjb0RZQ3lGVGbDsjb14QQSaUHntOPdFf1AG11zojUlyQaJoEHQLAUkn8EtPTr1hfEm9n2t84cA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycu1NhRFStDSsBcHfnuMk9Ddmzp57RBcrtG5G0D6jwFDAB/Nuy
	ws9JVZWsoy9CiCryZE4U3ICCGVnKiuXlknk7smjdouwW7jfl+UvtNnnz
X-Gm-Gg: ATEYQzzyj+KuAqEJc10Kqsz+KTnyZMU8gVu7P+OHlwNwiRl3lWkWB99mLDo1IjA3tY5
	Rl99MMJN5iw0EwQIPTEPlvzUZb/fQygNUD4SoExn0pmr4aIeYOVQz2oKvLcxjCoRi0qXIHUO7+V
	vBxSfQlvdL6OMENsV2rfJGNRhBsWLy8ZfFzDuR8bu7d9PS2Ff1TXRBUidyjOtK4IyQHXU4rg1Wy
	nH2Z3iK6283jQVXW1qwc7Re5ue0z2a+o/rObXsZObN6RQHK96zrDiP99q3/D+YR+ho8mCic2hhH
	ZGUQflG0xa7HyDrHv0bLsXdR+sxwtsjkk0UINxpaMB3hi3D/MrRJfXrErqDRks5DzYXo+7a/Q+x
	vq09XgG5rfaCftxYTTqXKzjFNsbn0gLOPYuUuhxy+mRY9qr01ErCI67SDuQgRJ6+z42xECZDmJs
	bxpfP7O9rM2QT/zd3dCaf6qHpL3/nORW5nPESGZpGDxh/J3HRix2idy8XhJ5sANjPAj8NunVwpI
	Pwl7oE9dhCX8PIcA61xg25scAYkCFPawwJjIrO+og==
X-Received: by 2002:a05:6214:252a:b0:89a:424:984b with SMTP id 6a1803df08f44-89c5e3c81ffmr17623666d6.31.1773699282359;
        Mon, 16 Mar 2026 15:14:42 -0700 (PDT)
Received: from kerndev.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beeb7dsm145596556d6.19.2026.03.16.15.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:14:42 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: fred@cloudflare.com
Cc: paul@paul-moore.com,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	kpsingh@kernel.org
Subject: Re: [PATCH RFC 1/4] audit: Implement bpf_audit_log_*() wrappers
Date: Mon, 16 Mar 2026 18:14:40 -0400
Message-ID: <20260316221440.2043299-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
References: <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Frederick,

On Wed, Mar 11, 2026 at 04:31:17PM -0500, Frederick Lawler wrote:
> +__bpf_kfunc int bpf_audit_log_cause(struct bpf_audit_context *ac,
> +				    const char *cause__str)
> +{
> +	if (log_once(ac, BIT_ULL(LSM_AUDIT_DATA_CAUSE)))
> +		return -EINVAL;
> +
> +	audit_log_format(ac->ab, " cause=");
> +	audit_log_untrustedstring(ac->ab, cause__str);
> +	return 0;
> +}

Rather than putting everything in the cause field, could we perhaps
have a separate kfunc here that appends normal stringpairs (not
format strings) to the audit record:

  bpf_audit_log_str(ac, "result", "denied");
  bpf_audit_log_str(ac, "op", "read");
  bpf_audit_log_str(ac, "scontext", ctx_str);

I know you didn't want to wrap audit_log_format(), which makes sense,
this would be a midway point between that and stuffing everything in
one field.

> +__bpf_kfunc int bpf_audit_log_net_sock(struct bpf_audit_context *ac, int netif,
> +				       const struct socket *sock)
> +{
> +	struct lsm_network_audit net = { .sk = sock->sk, .netif = netif };
> +	struct common_audit_data ad;
> +
> +	ad.type = LSM_AUDIT_DATA_NET;
> +	ad.u.net = &net;
> +	return __audit_log_lsm_data(ac, &ad);
> +}

Should we also wrap ipv4_skb_to_auditdata() /
ipv6_skb_to_auditdata()? Smack uses it in smack_socket_sock_rcv_skb.

Thanks,
David
