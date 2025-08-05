Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41A22331C
	for <linux-security-module@vger.kernel.org>; Tue,  5 Aug 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422757; cv=none; b=m2aO1NJO5wiE/5eGSHtQliL0z2ACeQvMzaVgEzGVHfphor0mJpqEu+BXe7LJ4eFsR14OjLwZvY+ADCh/P+TpoZ5jB9DDKLE4j9kXluTYoJ14Lo88J1Qwn6Ykunc7xhkBSNU6Al8bI2FOW863p38cPsNkPEurp5kzmwJdtXOMERw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422757; c=relaxed/simple;
	bh=hrWShkwoLgpiXECNmA7ue8Ad2qXssEeiJhCjKxFwpUw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=md23DNFIa1jvXxEWFOtzhPqA/HqdaL8a4hCuUUUvy/I/GwpSSIiNgtOs6ZSabKhvAXcOw1IurRMsdbTJ9KlfhdzQPYNfFJ9rAhe5Z12oCCrkZrpzdyq6ZdTbPZEgY44NbarWqedDhhaFbJJGoqpuKfXeGE0xe9BP1Z8ecJMxjfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AdgEqdVx; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AdgEqdVx"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70739d1f07bso62518586d6.2
        for <linux-security-module@vger.kernel.org>; Tue, 05 Aug 2025 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754422754; x=1755027554; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBazbWpOs6DnsY5hjuc5EgI1FanuICFKa6JiwIf4Boc=;
        b=AdgEqdVxp+p3aCgMQklEJoqYqxtp3hq7CHD70lHatl48iYNUfqs4J6ioXr1JDcaSy2
         D4cDsSNeSsWU8YrTTqI2HmzntGW50i2nVttSP2SU5zi8bdGHm8ZreaiZfdT+0ILIFmPt
         ENjn6X7E+DC24x1/Xp1PQ/JllxFrDUw+v6bXyDEIMLn7AvpPvCKG48xKGJwYdobqgu3q
         Q3MuCQ15mQAPFq+aAgAiRbjoqOEbMtNcJAU5Io4X140zmfrDY0LXEF83+SgsLmtxF3Ql
         6zZJ8LEkasEMCLGlub5mrif7b6bJ7+R6t/yWSD3yGJjf+TcdV1Yg81t79kdRQw0F+4sC
         QXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422754; x=1755027554;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fBazbWpOs6DnsY5hjuc5EgI1FanuICFKa6JiwIf4Boc=;
        b=RpS02d54Nu+bmxEISBRxmLoz5sB2+F/+zeszXqmtdE0K2s+nZaD5CfCiQgLBSQimfV
         ChkoN3kaShKGIiqKw3NXXg9WneI1uObG/yZQkvzXsKoHaRWeLoFq7tc9PmKBpO+98M9j
         beFIwh+jf/CjOGEaQZ1fo7tF7tRo8kF1CzgetM+oTkd+PL00vltlwf0ZnxvFoclrDHd+
         mpUDi3hl9A/zpyrMcpE8rzUjGGo+SlAsCu/DhZhwb455558I92QUqM9+ixGMtXheNZzq
         nz93hIrwZ4jnIt2QOkki+Gjnl5dAgG9O+ZtXnRqocTfp48lpI38gDNotNDF7trRFiSaU
         rNNg==
X-Forwarded-Encrypted: i=1; AJvYcCUJhu/254n2bIiE4enXp2a4YPaEr+A1nENnT3UTibV/LKM1WfpM+Nlo+sfj16zCQ4cJ64FH2vTQmipnEz/cBp9OiEttOoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKNnvDIGIv7fQb2jGJs0jZ7GKI0fqxDMVXgvUdy4mb0+Estw3n
	bf2ymKkLOOJGmcqGSU19Lr5eYktE5PZNYOSwgCZ2uZLPnmSHjs2DJ4/BKiaZKSq0lg==
X-Gm-Gg: ASbGncurGFS2Fjj9hn4gfliAqOopPaYYAgDvwAb1pthWtlr2TDY8TTSDbtrUM1msdXL
	J7DyzcHuvYKFDjklaHKRaMMaeoG/6w4/11noAcIIyKnOZgPZkBqax7KaBiPyTGfy+9ZRyObOMSO
	lKxkXAGVj2Kh+Cp7vYmAFBn5876bzwdqBhKXDbxX9dPEeCdWMleKeLy9FOg59Jj9DAgiM+bNvPM
	38JYpF2fGCEoJnpgOJOdDOmuAPdqUFFoPaIjnm8SUvBiBvNXftkOKSEqh8vNpvrp3wQ9KNvTwyH
	4xPDxF9pSQ50IW8/kim9vNeWO269z3hDshydnG4tyvvpiyG05NnJDDvzMx/yrBtv7U5XxHw1NlL
	aFbEVpLYQiocqDuO8ewRN2TtXgpMWh/KyHicd5Qm41tosHzDL8WjzEApgTUyf+m2AHKM=
X-Google-Smtp-Source: AGHT+IE+HthgC1i47sqQa2UGVUpX+LBzsQmL7EJldwFkiqkyAsWUvz71mh0r1BVzJ+awOI6xE6jKGw==
X-Received: by 2002:a05:6214:2a4c:b0:707:5c4f:f0c9 with SMTP id 6a1803df08f44-70979523ac7mr9246676d6.16.1754422754256;
        Tue, 05 Aug 2025 12:39:14 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077ca464acsm76152926d6.36.2025.08.05.12.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:39:12 -0700 (PDT)
Date: Tue, 05 Aug 2025 15:39:12 -0400
Message-ID: <d5f0d7a5edea8511ab4467e0fb225b8b@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250805_1248/pstg-lib:20250804_1752/pstg-pwork:20250805_1248
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v5 4/5] Audit: Fix indentation in audit_log_exit
References: <20250716212731.31628-5-casey@schaufler-ca.com>
In-Reply-To: <20250716212731.31628-5-casey@schaufler-ca.com>

On Jul 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Fix two indentation errors in audit_log_exit().
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/auditsc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

As this is indepdendent of all the other changes in this patchset, I'm
going to merge this into audit/dev-staging now and audit/dev later when
the merge window is closed.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 322d4e27f28e..84173d234d4a 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1780,15 +1780,16 @@ static void audit_log_exit(void)
>  						  axs->target_sessionid[i],
>  						  &axs->target_ref[i],
>  						  axs->target_comm[i]))
> -				call_panic = 1;
> +			call_panic = 1;
>  	}
>  
>  	if (context->target_pid &&
>  	    audit_log_pid_context(context, context->target_pid,
>  				  context->target_auid, context->target_uid,
>  				  context->target_sessionid,
> -				  &context->target_ref, context->target_comm))
> -			call_panic = 1;
> +				  &context->target_ref,
> +				  context->target_comm))
> +		call_panic = 1;
>  
>  	if (context->pwd.dentry && context->pwd.mnt) {
>  		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
> -- 
> 2.50.1

--
paul-moore.com
