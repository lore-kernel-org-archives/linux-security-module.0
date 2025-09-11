Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8D257829
	for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624064; cv=none; b=bxTBJLfanOxlvWw/nATTvapbKo40lzviW7QGCvD2irlwJKtSuHdcw4Itb3QK+rMMmcM1vIHBoCIe9iFg+ufnZX8XtSAwLH/5RQEBKRYABMVEXI1lgGh0vHNGAim1BitMzWMR7cxEtWNAaFhsSaew4NLmw0JzhDKtWZhSHzsGJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624064; c=relaxed/simple;
	bh=IAkTZVuMJAlakYbDgr6bPsITWtDg+0Us37CUJpJm1uo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=YTq6dZV0CD7GD0Q5dETOdy4c4dGRA4LJBRohcLrv4O11T8LBePTmK3pVyHkng1+FAgekKXW6aUKuu4nGSyzGG5zfncBuqT8BkyA4UDEJ1Wl3LtzdJ1vyEMBuGGufJGFLD2h06Mt6SWv3aas7MQXLIYybfC+RNd+k2DgZ+iDcdG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z0TSCxQT; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z0TSCxQT"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8127215a4c6so210971685a.0
        for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757624062; x=1758228862; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4qvTZ6b1TyKm2nYvC5gMYys0nnyOLAaCMgbalwU4nk=;
        b=Z0TSCxQTANWzfkNYU0Jd00tq7X+YAVQ1XIX2+25ofr/jPjYzDa/GunC5aT59ogxvJx
         eyWRvU5vSHqYUpyhRl4e7QMkfs/5j0OuCEwhJpMjBj326ZzVGQVAmyOxXtrikFLFjygJ
         OvpN9zVK1VjEm66AtirTFkl5bZYm/JawIL/oBNPbGyB/UOmb+z9rjN3MCBqI60hz2iEz
         yJw9NOtfN+tNoN+IKLemGP4EHGVvhhnoNdfW8LuJZM6kT49ZXOV1Bdt3ep/NhFjoh7Pb
         V8d3IIrkD3rFYQsitGNGOJy82KWz44QE9k1yu8sc5ms8QgxWzuRwMuEVc5Ds5yMlDG+M
         uHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757624062; x=1758228862;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y4qvTZ6b1TyKm2nYvC5gMYys0nnyOLAaCMgbalwU4nk=;
        b=GPvxL/My1zqXEWNak0pHwaRifm9iP0AJ68+/a0vs24Kb7P0ShkY8GMGh35jZE7Mu9L
         ahDAybWqgR6p7ugmiSD+vJn16hENs2fLJy0MAHw9o/lZQEHkC8RuQFIHnKc0URBj56S9
         cQw30ghnydSCvHkrwhrw/fD0nUMMgOzTmOfmZhaCc8HwDL9V1MOxB4ELf3r8YZiEfPl8
         HAkAw/yJ7krzlMyG0rnEgMfrVREihRpfiGAtHrzrG944Ls1vN1hIDfML94wxEiyOxMnb
         SUp1nJP1B+8RiLtBJ/ANbizdY57NB11OUqCLztl8QFYnu6I4OKG+SOoAXeyZG8dzbmko
         UCIA==
X-Forwarded-Encrypted: i=1; AJvYcCXUuSwWC7ae0GV+R9sPBZF2sL4lO9TVj8M07Rz9IF9CY8RnRHGIJDmgkKj8e53ha3Kveay4xzdkhZL1CC0C/9JheR+cNI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRVtxwz9qVkRiauZkZXeXMg4pqFIkzmNHQGks74ap9BRRlUBm/
	MZCzXaIdYzJ057AeLPtbLGKRESMi7ji9+fYTx1LUJll6KtTxe154Lp1/c76D32jnrA==
X-Gm-Gg: ASbGncuw4wiDPO0NJofGMG9+S7/I5PTIaIxp1BR+45CgKUoSibO8qiUD82978URJRn2
	J52PlrQ3SRL4uOd/3VRevxCFxSJD2qckPZ+WFWkyVWfaFxV2A81GkVFZdSyJgvg9bnrCgkCie0M
	ckzbU+fkgYpNHUast2h3GCxSiKDvtdD2FKvkCV8xtJDVQ31HFfLWUQXknlUXzzez5fDYhsqPKFH
	XLvC38EYtIQUVwFtbZKNpeBAIyMtgw+HePCRpPDLMNCkGj6q+sJxZjciSt2XkCM8WqG+WkqQXld
	XYiDCj5haNFEaFIBln8eXxX24Taa1e5fGP9p1zMhH+XXhBnwrlH/x8i4fcGkSikA7/0jUFxHSNY
	0yY//eXojajBgBxxcNedT/6sLvKRxKJC4tsJu2UBXfTOTFu2WXZiwIVWOid/ewga/9IN2Aooj/s
	E3roM=
X-Google-Smtp-Source: AGHT+IEX7rklarTyTs1aa6eZxMFKR2mTMUD+PJmsGRKVSSCqnw5/WIrBlp1fNwjoDz3NBnRjfF2IrA==
X-Received: by 2002:a05:620a:1a87:b0:801:537e:cddc with SMTP id af79cd13be357-823f9967911mr107148485a.13.1757624061834;
        Thu, 11 Sep 2025 13:54:21 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820cd701cabsm159872385a.41.2025.09.11.13.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 13:54:21 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:54:20 -0400
Message-ID: <b042d4c28324441644cfd8e3d7733477@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250910_1926/pstg-lib:20250910_1926/pstg-pwork:20250910_1926
From: Paul Moore <paul@paul-moore.com>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, neil@brown.name, linux-security-module@vger.kernel.org, dhowells@redhat.com, linkinjeon@kernel.org
Subject: Re: [PATCH 1/6] security_dentry_init_security(): constify qstr  argument
References: <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20250911050534.3116491-1-viro@zeniv.linux.org.uk>

On Sep 11, 2025 Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> Nothing outside of fs/dcache.c has any business modifying
> dentry names; passing &dentry->d_name as an argument should
> have that argument declared as a const pointer.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 2 +-
>  security/smack/smack_lsm.c    | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

LSM and SELinux bits look fine to me.  Al, I'm guessing you would
prefer to take this patch as part of the larger patchset, but if you
want me to take this single patch for the upcoming merge window let
me know.

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
