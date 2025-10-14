Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7198B2E7653
	for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483567; cv=none; b=uBPqpIajDSM7vBhCl963PVqS8iKkUccLKuaF3mqfNAmfW2LylZR3F0txiX14Z4034vAHg4fAETstwwbeoSm5CxOYEpZBR0443zWSntJCDjO0atJHXnoHbPAkbnz6sbeFrlrf4ceg988CRKQimBd6f198MdUe/ZciqOfKiLG43jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483567; c=relaxed/simple;
	bh=b+JPuRya1KU5RJhAmgP2fLr3omiwqFKbt15uSqlXlxk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=QLpP8KwaLlNC4dC4E7xRSBhXHKDY1zX+WE9LAuwWQLtp5WpVDWuH8Sqo7kR/2zFG30l29qc8VhLOh/zxUU8C9eVbwEShMx5bZ4tNngvydpfDD9+vGWi1IIq4FADcQnyVL7puRflOPGQxm7JZrEmp6IDJ5NdEPQVgAsI8saAK/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VUQSwCfy; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VUQSwCfy"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-854585036e8so840193285a.1
        for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 16:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483564; x=1761088364; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVvdaze35/CRosAlcMdQpNGdw9QE4ISqfe//0KuZp3M=;
        b=VUQSwCfyYwnlAEqFXlFsAD3pTFNEVKVixzJ2/dcKjQU2RqclsciV8Vv14OZdy4K+9d
         p0Qbf4kAkpsXOO7UcKArvzpcCVW5RU6INa5eZbcTLXkAjyCsbHmQU4f1H4Tb/knhtC/o
         oozvtewSSWLEPo6vjsRoU45m7/J4O4wp2ojhDZSsATKmw0H5YXeUHSvocJry0LHU7OtG
         UdW24ZrvwOLT9t3xIRRd6fgUsYoYDO5C4xIT89Ior0+JLtIBL/jInQByYhux6Adj0Rx6
         NRNRHgkUyIIrliJ4zWvtSoJJWEkUYzkcboUdGnwXn/w8hYMYByR0daragyZPrHkZr2rs
         uFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483564; x=1761088364;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vVvdaze35/CRosAlcMdQpNGdw9QE4ISqfe//0KuZp3M=;
        b=IkxHr6S5UtVzvKwDRmBAohSV2PoUeemqA26TKHxyS5nScz5cby5IMuodos86Ys9hfT
         s98TLZY7hWlLB0tXavy4XTAsgCy/k3g6tf1xNB9ugxReX+Qyi5dQCwxIh8uWtEntJ2MZ
         oEeiWOnkJtV7JX5eVJyvxIbhuJqFlmaOmn+FjButmHeORs56bMjcs/2f9MEFQVRNPCxW
         MPHko/H/aOX/qzEwFj7FBCSh/2UR2lXnyRECEPmi2BlWr4z/Oh1eXAYYzUi9C7I+I2Yo
         9P+xadjEKpFyUqHIibSODT8glIGFmcZ/U7yn3M/kR7n+mlUUnXtEVDQ+50joHavPa4m7
         ToEg==
X-Forwarded-Encrypted: i=1; AJvYcCX+BT9fLNKGjSZ4iNbROmJ92vEyB3KJmfHGqnhC5ksrL9JND/QyYjNi8rUTBQssmhTjRfshxjbfOaAeHZRYU6hw5NpfZI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Tg+RoIfSc54LPc7FJ7rClby2ZixBlf/QDWoihvAdH2NiYzC0
	ZHOgkjw2TqM97Jn3cnOGDH4hxQBUhzRKGcDuA0tEfz0BFAlBVYgb+wQ2+yhL85HQd6iL4Rpm37A
	0sJVtDA==
X-Gm-Gg: ASbGncvHPbOsa6opGsRjnM5iERA946yoPA3iGqThVB+tv+9ZOIorGzzldtStROogdwL
	BurQ6BVvR+58XfiX1FP2mZg6vhQTIC337NaTMoWab3uzWauCVnIeTT0SwqZ9f3tvmgfydchegbX
	NPTemXxBOh67GcEXuhxaux6ycxVfZg7C1bwzDiokKcxHq5zk964mG8uQSVh6ZuTEgKh248d0oZU
	r/IbTdbxTpsuXpXWMFDueZppGZjTKuFEs9Nb5AyzK13D1H87GvRoY3JIF/pAalW54oCGuoF+bpo
	Qnn01YE9hVY2blo/orEbotuciJEVPiCDKTWzky7mpCI1iKLQvm8XK1FQvdfZ4E/T6SOCh91WXaq
	WTU9Qw3RypMEqCLS3ky4autvG+PF53Mtg1ey1m84P0JnWi6XF852pcM/m48Pq6qA/oFQp7xV3cJ
	9PhSB1EQNo7M8=
X-Google-Smtp-Source: AGHT+IHIaLztJ0EzDzTfr0vpC8k7Pus9jJGW+Vxhl33MfL6VS+zErfGM1vlpYkIvsD1bC3Dy3OU/pg==
X-Received: by 2002:ac8:7f89:0:b0:4e0:b72b:7f6d with SMTP id d75a77b69052e-4e6eacf4870mr384481971cf.29.1760483564238;
        Tue, 14 Oct 2025 16:12:44 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4e881c8cecfsm7843551cf.19.2025.10.14.16.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:43 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:42 -0400
Message-ID: <cee3f6f2d0657e53f5313225fe182a1b@paul-moore.com>
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
Subject: Re: [PATCH RFC 3/15] Audit: Add record for multiple task security  contexts
References: <20250621171851.5869-4-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-4-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the single skb pointer in an audit_buffer with a list of
> skb pointers. Add the audit_stamp information to the audit_buffer as
> there's no guarantee that there will be an audit_context containing
> the stamp associated with the event. At audit_log_end() time create
> auxiliary records as have been added to the list. Functions are
> created to manage the skb list in the audit_buffer.
> 
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS record is:
> 
>     type=MAC_TASK_CONTEXTS
>     msg=audit(1600880931.832:113)
>     subj_apparmor=unconfined
>     subj_smack=_
> 
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record the
> "subj=" field in other records in the event will be "subj=?".
> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based on a
> subject security context.
> 
> Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
> This is used in netlabel auditing to provide multiple subject security
> contexts as necessary.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        |  16 +++
>  include/uapi/linux/audit.h   |   1 +
>  kernel/audit.c               | 207 +++++++++++++++++++++++++++++------
>  net/netlabel/netlabel_user.c |   9 +-
>  security/apparmor/lsm.c      |   3 +
>  security/lsm.h               |   4 -
>  security/lsm_init.c          |   5 -
>  security/security.c          |   3 -
>  security/selinux/hooks.c     |   3 +
>  security/smack/smack_lsm.c   |   3 +
>  10 files changed, 202 insertions(+), 52 deletions(-)

Similar to patch 1/15, dropped due to this already being in Linus'
tree.

--
paul-moore.com
