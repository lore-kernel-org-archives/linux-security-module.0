Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12821FF7B1
	for <linux-security-module@vger.kernel.org>; Mon, 21 Oct 2024 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553994; cv=none; b=pBiSy/KRKPlvYwnsj27LLXFAEMMWWb4y8gKP9P9uZxezOei6WpRLCHItH5BIme3LALnge7UHZO9ow41R1QY0fJxc0nzLdpOyXYnvF/ehtTywKTB8y/kHkSwi4pVW4TD1opu1po/YkI10MJJ7CRoeP3T0A4XYrOqoXwI1N4aE1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553994; c=relaxed/simple;
	bh=NInB1ELQ1g4XSXdcmSTFZeS7lQkYq0qiMSkXS/J8G1g=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=IZAm1WS85S6IDpCUenWTCzJ2ral6hgetW0d2e8D3aVPV/VzRI4BB5nmE21rca1Pio7+W5VLDv8TgtRGt+ERJwPXik76puxSDdhMQmENIL45A33yU8aS22uRqH1WRszQns+/bRI5OCPnfKK6fdsfu1/EjtsMwppikuUCnYvtPBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b8hwkhcz; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b8hwkhcz"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84fd057a993so1649583241.3
        for <linux-security-module@vger.kernel.org>; Mon, 21 Oct 2024 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729553991; x=1730158791; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDWEE14Y4prwCb9Fzm1EENaaRq06/1PNnuTUtMOSfEo=;
        b=b8hwkhczIuUS4MDTwG13WlmxeVODuqeDR2T1YxKCKiIcUtQsQFdXYY10kU3Mp3yosW
         gVPDcBjkg9pAU92BOHHGcGI2qcVG5iZnD5pd3qn1Pq2phOL6XcV/tGK1PrjD2JZBmX/T
         QHzBV3yUIVlvtoRiCQHxvbXm/PU+XTn8TBvB2+XXXFkfZZvb9fRknVxn6wShCN1LR+cG
         J9ISacDDRM4z9zKmx6BNu+SXaPiglOp5lwzt3o9PBlvfvaSCcDJ7mLwflooWt3Snm0Ux
         jZ0X1DJ/bxV0V+KvSan2pLMPyyFaK0bCNbuYU4jbykY/9zUReQvr/OPkfEHTUM+03eNq
         q9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553991; x=1730158791;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sDWEE14Y4prwCb9Fzm1EENaaRq06/1PNnuTUtMOSfEo=;
        b=u0AU/85YbqBGf5x1dFsvOQcwhm5CKIGbUTyYt3gQc94TUoli8c5eAc/Gr2M97XfwRT
         a4cKR2vgoszEZsenD2QUwQxY3xd7azjadvhRcbeL+HnljFPaKZLEQghrtJSGmmavshEv
         +QnUyAXQoDjAm8qxjpg//oEqrDWmMhl15bqg2bKqwNcqSRh4Kqho4RTDVw82Qip/8wNO
         UD2FNvCsRRKsDro2EWbR1deEi8ACijib8Oc/DikGvlw1XwBCGKnxrXi00g82d8Ps2eAD
         2s333oExwARXi9g7+Q02sMNzsMz2sSAaH/46mH/A2bRIuu8hRp/z15dHFxn+s0C3v0L2
         PRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/lQSp0YeKYIU0TfljZCVLt98fsbw1mD60GsC6/oATfWF3ds+weXeApetkqykBRe7DSe82OjWOmsSn1Pv6zZnRFmOgOMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyevzqd11LNxlK5u5QWiNUjT/QN+QPaLS8aDloxjvv3ZV35u5O
	A7oGpydQaLJTkb8PrFgqM6g/7uU+PPglPF0c1PYibcmWH1H34OxmqrBlwTu3xQ==
X-Google-Smtp-Source: AGHT+IFWWAbYXocHhlD1zYem9kRJwJmJqB2DCjjBRaGPSAY+7moTo2ts1qOtpARGMDwTWMEgN4Zm7g==
X-Received: by 2002:a05:6102:2924:b0:4a4:8b30:53e with SMTP id ada2fe7eead31-4a742d5c725mr800271137.7.1729553991685;
        Mon, 21 Oct 2024 16:39:51 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3d69467sm23730721cf.75.2024.10.21.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 16:39:51 -0700 (PDT)
Date: Mon, 21 Oct 2024 19:39:50 -0400
Message-ID: <5b6addd938c9feae0b4df8f54d56f9f0@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241021_1626/pstg-lib:20241021_1624/pstg-pwork:20241021_1626
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v2 5/6] LSM: secctx provider check on release
References: <20241014151450.73674-6-casey@schaufler-ca.com>
In-Reply-To: <20241014151450.73674-6-casey@schaufler-ca.com>

On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Verify that the LSM releasing the secctx is the LSM that
> allocated it. This was not necessary when only one LSM could
> create a secctx, but once there can be more than one it is.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/apparmor/secid.c | 10 ++--------
>  security/selinux/hooks.c  | 10 ++--------
>  2 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> index 5d92fc3ab8b4..974f802cbe5a 100644
> --- a/security/apparmor/secid.c
> +++ b/security/apparmor/secid.c
> @@ -122,14 +122,8 @@ int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>  
>  void apparmor_release_secctx(struct lsm_context *cp)
>  {
> -	/*
> -	 * stacking scaffolding:
> -	 * When it is possible for more than one LSM to provide a
> -	 * release hook, do this check:
> -	 * if (cp->id == LSM_ID_APPARMOR || cp->id == LSM_ID_UNDEF)
> -	 */
> -
> -	kfree(cp->context);
> +	if (cp->id == LSM_ID_APPARMOR)
> +		kfree(cp->context);

Should we set cp->context to NULL too?  One could argue that it's an
unecessary assignment, given the cp->id checks, and they wouldn't be
wrong, but considering the potential for a BPF LSM to do things with
a lsm_context, I wonder if resetting the pointer to NULL is the
smart thing to do.

This obviously applies to the SELinux code (below) too.

>  }
>  
>  /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 79776a5e651d..b9286c2c5efe 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6640,14 +6640,8 @@ static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>  
>  static void selinux_release_secctx(struct lsm_context *cp)
>  {
> -	/*
> -	 * stacking scaffolding:
> -	 * When it is possible for more than one LSM to provide a
> -	 * release hook, do this check:
> -	 * if (cp->id == LSM_ID_SELINUX || cp->id == LSM_ID_UNDEF)
> -	 */
> -
> -	kfree(cp->context);
> +	if (cp->id == LSM_ID_SELINUX)
> +		kfree(cp->context);
>  }
>  
>  static void selinux_inode_invalidate_secctx(struct inode *inode)

--
paul-moore.com
