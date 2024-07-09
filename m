Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83F1514C3
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720562888; cv=none; b=qx5FPleQEDURUdSyxgtllJyVVowmIheee5LZyzf1ak4J4ulM85KoQm0CbG1qNmOu0Jb5hLmDaXjC+YF7a4Z7iDYtMd0NEVrfgQOBVc8HTk2eEAWdrY5+66zAEJHUX8rXYm/Uh5xTR2dUNrMFFZDailIK1nK1veYLT3wFA9O/l20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720562888; c=relaxed/simple;
	bh=iL73oBc8+rL4x45IL/T6qNuRrpKY+9vaUpB4nCKRK7o=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=QQ44fNyay8QsBRrZbsCxxYmp8xnErgJwka9z3AuijBm/jSyVyPDydF82gIX/iMIji0/lILn3qywzBBS+zeGXqUXYAXakV2OsyxNprHY2to8hn7gVSyS/UZ5gatwc52iB7f/shardH8fl8MsoNGtdMOTH93PtiGt8lAqWO9/aYAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EoOxyczQ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EoOxyczQ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4464284029dso1487381cf.1
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720562885; x=1721167685; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qBt3GRTIVmOFD0trS0K/CuIrztvAQBkIOKMmhYVjgwo=;
        b=EoOxyczQj0FZdN2ec2dVmQW/M2djoTTS4TaWD+JA8rNurH2W68nFUGgDDfRCun8xIg
         s+kkiEjSb9aST8PeqnGbAmSA5akivBKUbqBqwD0zb4xc97UrTYaYBsJEcnVjsCe/nh56
         +RtB404wF9J52phX6NcKrCr16Ou/MEWIxShQmZY9Abd1e6jpI7+05u7s5DrscXVGd8vA
         J/qbTaDZsMlB2Bu2DOpgY8eKbzJP11heJFV8uxhPD6Hgm3S2QGYLU3EBNHF4Tqqubp7r
         ZrBSPIpGjIyo8fViPs8IdJFNzqO+jPJXedmygiRk4ZPCIb4+A5qkz+kvdaBQuIJ78jLH
         AJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720562885; x=1721167685;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBt3GRTIVmOFD0trS0K/CuIrztvAQBkIOKMmhYVjgwo=;
        b=v/EmVtnOpzRGxvFB0Fll7s03U/oxuDfoMDntKWFIoovraSx2d0ymQH+ZOqB+RnM371
         K/hIh8bO+rZ0M5XL6bnfza3MGdYlehm1TIaElci/zJ0FuQLgdsF1Jstsl1+RZmyG/oYl
         nQe1fMotErQNH7Rr28LoFm4M9CoHVWBUX3UPOTB8XiS7Ff5msq2dP/RHoWzxBZficF7q
         jpgDbe5DsV6sabKszh6BZb3+2THzTRosINClK0oDoSy68ILQqIXTc7Gto+eLW7oOcpNF
         PARzqP2n2Fna9cOpR9F8fBrMKXXvM4vuOTkpkcwjc3Zq1KSEan5sn3yhX/BC++nUBqVX
         RR+A==
X-Forwarded-Encrypted: i=1; AJvYcCXUykH/WZcqAvKSkS8etIhNCEzOI4k2yQ6W3Dm0R1Igqc2lkscU6TH4pBD4RS1mWmhaJ2ZkDEaEK65VBHG4K9JWojhQnuDxoLgGsl2Yk7lCdGXydh1/
X-Gm-Message-State: AOJu0Yym3pZDwaQG8ODmEk1Yx/q6p6RNCXGK9GXiJl0xreNCwBLWpA75
	DXp8S1O3yjlIXsT+ltmQo8WG0OL+e5X35qrR12CLFULlbgL8tVCTgGCS2n+2uw==
X-Google-Smtp-Source: AGHT+IECy2pozLTkN/IgB0kfUaMB5kYtxP4YuKX37u1b8Ss/4S5+5AxlCrLbXgGW0RbHOFsCuN3STw==
X-Received: by 2002:a05:622a:2b0d:b0:447:ed2c:bea8 with SMTP id d75a77b69052e-447fc3783e9mr59710341cf.3.1720562885623;
        Tue, 09 Jul 2024 15:08:05 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b50fbdsm14525221cf.40.2024.07.09.15.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:08:05 -0700 (PDT)
Date: Tue, 09 Jul 2024 18:08:04 -0400
Message-ID: <e1977a9222cb9cfc7ef55b3767819ea6@paul-moore.com>
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
Subject: Re: [PATCH 5/6] LSM: Infrastructure management of the infiniband blob
References: <20240708213957.20519-6-casey@schaufler-ca.com>
In-Reply-To: <20240708213957.20519-6-casey@schaufler-ca.com>

On Jul  8, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Move management of the infiniband security blob out of the individual
> security modules and into the LSM infrastructure.  The security modules
> tell the infrastructure how much space they require at initialization.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hook_defs.h     |  2 +-
>  include/linux/lsm_hooks.h         |  1 +
>  security/security.c               | 11 ++++++++++-
>  security/selinux/hooks.c          | 16 +++-------------
>  security/selinux/include/objsec.h |  6 ++++++
>  5 files changed, 21 insertions(+), 15 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 2c9d075f5f92..731a54fabc79 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5081,6 +5089,7 @@ EXPORT_SYMBOL(security_ib_alloc_security);
>  void security_ib_free_security(void *sec)
>  {
>  	call_void_hook(ib_free_security, sec);
> +	kfree(sec);
>  }
>  EXPORT_SYMBOL(security_ib_free_security);

Same comment as elsewhere, let's be consistent with the *free() hooks,
either we keep them or we remove them if unused (preferable).

--
paul-moore.com
