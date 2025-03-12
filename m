Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763F1F3BBD
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823503; cv=none; b=PiJxm74Q/1v41As4joF6/KAVNEwwrRyzB3WDcHXtjYT3WyzCBjwbf1KQujWZU+QE7x+PEraZY2MaW36dVH1hv7xwbueHli66i0XwTGzWPpIcE9sIrAakESV9XarXTBH/Mg3ZjCJoxXsfMMG0sBsMHp+1hAHVU4q/Q2t8ZrQG4G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823503; c=relaxed/simple;
	bh=OqK4+EI0TbzhbvaQRc8UpdLTwB+tY8fTMAJuj3Y4hzo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ezRC/AAZ4vc0dTyG0h9bBpFqSrBRyuOJTDZrTBCXsCkj/FVM2iwQY0jMSO4NmQ3N8Y/1q7ihDsbJPpP71Ry4oLO4Ftjec7MSmMmJE0pq6gidFeWaGjQFPcS/v/oMni6RgXxLnVJuzamTPi/mKz+gaQA+uPDySlqdxd1ud4blACQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Evv093QN; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Evv093QN"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so4684646d6.3
        for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 16:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823499; x=1742428299; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxlYmbTsB88Ix/oaEHJZoio3VHyIr3ksQERJyVTw4bA=;
        b=Evv093QNcDQqsE7ZwfMOQOk6wQ6pnItsC2+RyPv/F4HzhGynZsQ1YtMlLPr0+N8JKZ
         rU7ZbRX18N581teTBS4FH3XX8h7MBIB0mBNyGlacJCgacGuTxgMmUJYlAop8g6Z+X1w8
         SIb2iQPv2VG90GhLQPS0pktyCIQAzFPb37ZZjTnpdN7piLU6PFLkXKLNM4sWrewX1kpc
         fB1K9woFBrzsQhuqElTwMdiwrstFgwmixCGaiFQz7j6++BIv4WToynCoa3ECaQVuXoov
         f/p6dxMc6+vHr0UIbAKYJp84wW3mSWVgX7UX6QA1AVM6ZhUk79j4EU4KG9BNanaM6LMw
         v+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823499; x=1742428299;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HxlYmbTsB88Ix/oaEHJZoio3VHyIr3ksQERJyVTw4bA=;
        b=ZeIqQkN+TQnLcbTx1PSC+kZ9DYIiBz2hlaW3NYLom97wAZhJzrGZ4unTLhpBHAnMS3
         qHw2taYnqdtymBK8gen3sEDXeuK1XEJMZd2jeTQLi3qJNuc4YhQUkVwIzK5jFEXraHNk
         jJq4D1DkHkNULjRijAQp2S/qyYfT2yAPooOckUgOiPngxg1IB367mMP0SEHNI2AU06Lp
         GFzPqToNNCHo97qWo+Mb1CwmYzObKvjN8Y5yUQ6huH/p+bEC5z17SDmq03s6b4sTrSFy
         Y/2S9VRXnq1iw8OcdOieyTKhldHcnQx8c37LFUm5UMItqZvnyqYpCXQPbJi39htwNS1H
         Mz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwdUYjR/8R9W+9tuj8tAyIPcVluComl82cw5kPg1Jwp8CLzm8bhBxskgzduMjIpgbMnqjddFpzxQgNxRlVLbo11C9Mgzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0pdUMTwCB9YAwZxcvmzHEKrmp/D7wg8RAMG37+HypdyR9XYGF
	j7E4/bG9MmOxpCF20iJs0tz20Ygi/PQkv8PCrnl3nufN81gc3aTINPRBpnjFwg==
X-Gm-Gg: ASbGnctAgbsHiYzsuFY3uzYeDjYzdUzrWSf7GZWAeGpvnB1S6yTx/ciG1IyMpoiULfp
	dscNaM4L9mVR1mAMQv/fco711v+oEJAsHfoNQSKiYuUqW0Jg0x1EfE9Iz89Nz91L7XqqPM7jFEO
	zr0tTIVsiIkdx88b08QkaOo4mx2O88vAlPR9CBnybKDczwLlCGqImT2pRagobYNWZY0aagOX7fp
	j7EnC0IDZzgq0bSVH3+uqzO0lkTvuVCTNMkbkMmp30+taP+NnAEl5A8tTr3D0MzBxprEzW5Yly5
	bNSJjVdm2ryAUdGYo4EFliAVJBdcPpYUtiUex44xsDWl7JVXq6yVO2GsmDHyu6lhyYuArKnA2uW
	+HwN1sIaXqqqn3A==
X-Google-Smtp-Source: AGHT+IFlyR/GAqSTyYhAIKsmF0zsCtOyT1xvl6rvyoCreNYLYVbRsQ3f/WRhdPpglFjVH6KtCvTPRw==
X-Received: by 2002:a05:6214:c83:b0:6e8:f0f8:67f7 with SMTP id 6a1803df08f44-6e9005f7742mr372102726d6.16.1741823499484;
        Wed, 12 Mar 2025 16:51:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade236776sm1858186d6.49.2025.03.12.16.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:39 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:38 -0400
Message-ID: <f64ab132bdc436ec70ded81f83324f15@paul-moore.com>
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
Subject: Re: [PATCH v2 6/6] Audit: Add record for multiple object contexts
References: <20250307183701.16970-7-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-7-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS (1424) record is:
> 
>     type=MAC_OBJ_CONTEXTS[1424]
>     msg=audit(1601152467.009:1050):
>     obj_selinux=unconfined_u:object_r:user_home_t:s0
> 
> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> the "obj=" field in other records in the event will be "obj=?".
> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on an object security context.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |  7 ++++-
>  include/linux/lsm_hooks.h  |  3 +++
>  include/linux/security.h   |  1 +
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 53 +++++++++++++++++++++++++++++++++++++-
>  kernel/auditsc.c           | 45 ++++++++------------------------
>  security/security.c        |  3 +++
>  security/selinux/hooks.c   |  1 +
>  security/smack/smack_lsm.c |  1 +
>  9 files changed, 79 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index ee3e2ce70c45..0b17acf459f2 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -186,8 +186,10 @@ extern void		    audit_log_path_denied(int type,
>  						  const char *operation);
>  extern void		    audit_log_lost(const char *message);
>  
> +extern int audit_log_object_context(struct audit_buffer *ab,
> +				    struct lsm_prop *prop);

Less is more, "audit_log_obj_ctx()" to match "audit_log_subj_ctx()".

>  extern int audit_log_subject_context(struct audit_buffer *ab,
> -				     struct lsm_prop *blob);
> +				     struct lsm_prop *prop);

Do that back in patch 5/6 please.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index f0c1f0c0b250..054776f29327 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1116,7 +1116,6 @@ static int is_audit_feature_set(int i)
>  	return af.features & AUDIT_FEATURE_TO_MASK(i);
>  }
>  
> -
>  static int audit_get_feature(struct sk_buff *skb)
>  {
>  	u32 seq;
> @@ -2302,6 +2301,58 @@ int audit_log_task_context(struct audit_buffer *ab)
>  }
>  EXPORT_SYMBOL(audit_log_task_context);
>  
> +int audit_log_object_context(struct audit_buffer *ab, struct lsm_prop *prop)
> +{
> +	int i;
> +	int rc;
> +	int error = 0;
> +	char *space = "";
> +	struct lsm_context context;
> +
> +	if (lsm_objctx_cnt < 2) {
> +		error = security_lsmprop_to_secctx(prop, &context,
> +						   LSM_ID_UNDEF);
> +		if (error < 0) {
> +			if (error != -EINVAL)
> +				goto error_path;
> +			return error;
> +		}
> +		audit_log_format(ab, " obj=%s", context.context);
> +		security_release_secctx(&context);
> +		return 0;
> +	}
> +	audit_log_format(ab, " obj=?");
> +	error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
> +	if (error)
> +		goto error_path;
> +
> +	for (i = 0; i < lsm_active_cnt; i++) {
> +		if (!lsm_idlist[i]->objctx)
> +			continue;
> +		rc = security_lsmprop_to_secctx(prop, &context,
> +						lsm_idlist[i]->id);
> +		if (rc < 0) {
> +			audit_log_format(ab, "%sobj_%s=?", space,
> +					 lsm_idlist[i]->name);
> +			if (rc != -EINVAL)
> +				audit_panic("error in audit_log_object_context");
> +			error = rc;
> +		} else {
> +			audit_log_format(ab, "%sobj_%s=%s", space,
> +					 lsm_idlist[i]->name, context.context);
> +			security_release_secctx(&context);
> +		}
> +		space = " ";
> +	}
> +
> +	audit_buffer_aux_end(ab);
> +	return error;
> +
> +error_path:
> +	audit_panic("error in audit_log_object_context");
> +	return error;
> +}

Let's follow the same code pattern as suggested for the subject.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d98ce7097a2d..82470862ea81 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1780,15 +1756,16 @@ static void audit_log_exit(void)
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

Thank you for both of the indent fixes above.

--
paul-moore.com
