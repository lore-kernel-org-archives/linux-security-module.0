Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DF224AF7
	for <linux-security-module@vger.kernel.org>; Wed,  7 Jan 2026 01:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750779; cv=none; b=Jkfd835gMlzI20ZBxWpOUB6TxnPa7m1au91UBacEJ605kezSAWp4PvYrDUbySjXdcLmkhdKdkNUVpVn1yYjWeQthUtM5bHTCGsnT979QMdA5uspTlWdGcKQL2KrGKaSZOVhBgid8yvJqs/WF/45WzOPU8MFrOP5bk+ASr7uYxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750779; c=relaxed/simple;
	bh=gUvN5T3cjTxTMxicRMuq4nADjun0ze5GTMSKGVvMW98=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=jtLlXx5Zr1darg426HN4IF68488x/8bOKJ6jqgymu1wZRnIfRRqEJjPEoFd0015VJgSkPOJW14OLm0JcUaqiZqqrutz+PCVS6QvFp7mJKAXoa4OwMCUygiHF+aePALN7aeFI7UoLeyHSVt3eKwwYvY9aElZlGrpQ8Lb/0mxi1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RtVLNMrQ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RtVLNMrQ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8887f43b224so19982376d6.1
        for <linux-security-module@vger.kernel.org>; Tue, 06 Jan 2026 17:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767750777; x=1768355577; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBn3kzc3HUw2iPUbi6bNhSTOnYvfhQjffxfFf/mz6Yw=;
        b=RtVLNMrQ/8sSxbm4NfBe/SsMXY9ZYC/YGWjJE0XnIz5rW6clniCQDYy4B1jzYZqMXE
         AojIRgmYqIWaaStEwWv7maPCre4hUvkLGXoJno8OyTPIey2euEjB48tpMS3IeLmhPhcE
         /xFD9IAtHRRWa3n8rzjJG5aTakJG4db2JR2ihR1Rx5kkiyQFXp2B9Zg3a/tFMo91/8+H
         ytktr/z/b9bixNqQ1G/tKgqfiruYEL5CLsjy0vkU/idh5gyD5yk6S0Q3EIdWjGH0mL/Q
         zD5ZdOb00qicamqQDxL6Eb8NsrsdDLlDIt2ru+Pb0mHZW8yYLvIIT7VY1nZk7mFAApGw
         vakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767750777; x=1768355577;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBn3kzc3HUw2iPUbi6bNhSTOnYvfhQjffxfFf/mz6Yw=;
        b=n9GpwGVNagOUZ+aO3LXYjL0i76X9YgAR9lkCZIZE3G+S8NHffhOs8mckYAPampnfwp
         OP2ku795phs4xZyMiVV9SqcliT1uBPsbr53NlbLTw1Cffh7KlTbIUkUrPjXNLx3ZSrMf
         /zSl8pDOhNBW4fFmPJ/EnjVJR/GhmeH99U1bqkOec6IoTwvMIy6WRKYKUcpdhIOQFRm9
         fbw2dW6rvdlXQ8FnZz5zcf613SRzYPW9PQuLGYMjb6zQ2WhZITv9IiFrQNNVgwkb0HXx
         uMZ1DroqxezjV0uq6ryiwsLquQVMIVRvGJ7RVXnJahhuj8GbSVYvCfkvKcEWB4ocRGBm
         tyAg==
X-Forwarded-Encrypted: i=1; AJvYcCVb80ocHVgxHjlwEZLnrrsm+7/CToXxTT9GFW4mfPIFxk/qEepK6fpia9TOc7kKfmV6VhpsQjXnFQGiJPnaSZdOXv6VD9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZS1oc+EOmmYUy3/4gl4RzrOTZjGEyQecXOpIJ0eW9bnMpJ6CE
	hwWOCOPJHAIvdeWUJdXeT3NOqVaW7Yl/hF6DT1MmGUvvfvmpDQXJ8HP+f6nC27uNdQ==
X-Gm-Gg: AY/fxX6FKOQTHinvN5+RJmcFtQuktijx5faxnMbWCBTL7I1ZiIz/JEjZpKUcmATdG6o
	VvjfxLYOhPHTuIJl6FpedF1foG5XICq2Cm8WHXnnJXJOE8du1gCDqt49dUF0i3dTBST3Sv3Wl7Y
	BwA9ZexHykOVmkGiY4u64bCMZBCDxpXMtfqwinQJ1Lj54q7ILK6rJOZV/ZXnUOVicTyTNa4vjEE
	inhOPdWQZlp6kbj725rQ7EvIwKjgDo7+/dVWcCVs8zNjZ3piCTq7SkrLCtI50xTHy10gxLIQcEV
	r75OIXcZjgFvO7njH0bWOViczInmGoTfOhDlyxghkH6c0unDUQfpLv7S+8UAmx35A0fB6/wPYs2
	0wyuEaxQES4xUEnpG4ax4RWZWnJIVQPxeRvvxoLsUzrrKFIE7C9TCsqFOuopYiFgjRygbEBCcAF
	lo/UdZUbBPOAZFD31Sga9o64RQ2zZVUfinYnADUnsMt1irgHKSfQMAZ5mD
X-Google-Smtp-Source: AGHT+IF3w6746P6tPYJIRj0Fh7MNJo0Z1kGzh8VJXWxLs/2p60ciPd7uI40dMO1kmCcqYpF/mvutzQ==
X-Received: by 2002:a05:6214:5d04:b0:888:8625:a09f with SMTP id 6a1803df08f44-8908432dd93mr14802986d6.68.1767750776999;
        Tue, 06 Jan 2026 17:52:56 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772346f8sm24699036d6.35.2026.01.06.17.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 17:52:56 -0800 (PST)
Date: Tue, 06 Jan 2026 20:52:55 -0500
Message-ID: <d10679bf08d0fc6e333754ac0c31e289@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260106_1639/pstg-lib:20260106_1639/pstg-pwork:20260106_1639
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, David Howells <dhowells@redhat.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Serge Hallyn <serge@hallyn.com>
Cc: max.kellermann@ionos.com, LSM List <linux-security-module@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] Cred: Remove unused set_security_override_from_ctx()
References: <6c29c8ad-6aa8-4f50-98c8-81b363666ae8@schaufler-ca.com>
In-Reply-To: <6c29c8ad-6aa8-4f50-98c8-81b363666ae8@schaufler-ca.com>

On Dec 22, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> The function set_security_override_from_ctx() has no in-tree callers
> since 6.14. Remove it.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
> kernel/cred.c | 23 -----------------------
> 1 file changed, 23 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
