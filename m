Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151562820C6
	for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745350500; cv=none; b=REMeKWRfTNEN+ya9epFG+Fvl0bZJ8eCNuQ9Jq+GGW44/6d711ziDgXjEVObRdGWX3l/aIRLnihNocydXfq+AvD19MQjVXinfHLIAv6aQjRSKcI0mkjN15yJPc4219txg7YIc0tdUdRs5lj6Bl8Hp83yiSGn2vlj96xKAPSROwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745350500; c=relaxed/simple;
	bh=4tnZMN55DZmrCG4zNi9F7Y/HI3ARmqLqBfDB/B0Tt5I=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=U09zRc8GP9I4kvvJLbrcMTMH0rsDJ9gW3dkMlv9bxFsCwyQORfBCS27bXoJXkZjQLIkx6Z1nHkTqH/2AMd5Qj7DNttG8qg7cnvD/FGB32LAumcf85EO0Zjl7ZjRMn2r0pgSsbBKvbjCX+iYXMa12e15u38z2kosb6++MalY8HmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XwPJVMKp; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XwPJVMKp"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476a1acf61eso52537331cf.1
        for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 12:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745350498; x=1745955298; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgMOi5bYMQGhj+CTXzVuh1219rLi/oMk41tK038pDbM=;
        b=XwPJVMKpxFLThF1PurCy4LBhTA+lDWJDxcfTUHWKU9zy1A1kJuYCesKXTfout0UL8v
         eQ5vqo7/KK87q2jqqAoeSbmaZ1PAkgOyJUJvO0z9dZDumYzd4uutSMp+b2JuPLkEJxms
         7JVq+PsJEzNfwoNDbJ7sXXsEMkrX/9ePhcH2KXpdx4e24sjLYLvSSEwdU+QDO6ibijQf
         JjujJ9cGTpjXI2IJ3IGW6Nplk/aBCjMzZx5UPBvVSq3e8m/6o3denv6Le8HPbF8RGZfl
         LIuKIlwNzuSANKoVDhQuDueF1hQ8+6Tb0O60ebR/uIu90D8CpiSqf7aaJjdTqXv6b/1M
         e57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745350498; x=1745955298;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UgMOi5bYMQGhj+CTXzVuh1219rLi/oMk41tK038pDbM=;
        b=GYUVCgNeJyshD5F1cod7fT6P5zQPLHrVhd3KaEASpFCuXq5/TpYVHJs4XuW2gPxoab
         lDRz8fTM/Jnv0VpW59D/FpBOqJh6QEHmkAfTXoJr5i+44l7v7bcfGVigauHjlBGzfKmu
         m9yTMC1w+cCfVqlhAsryAPunWvQhq8h5uXB8/FXIM+OO1HTrjc4KkcTu/wfmdA0P1M1u
         kqQ5Ry96KGfwmFaJc0dTS95Xah2gMW1h5JLqVOCjjOp0JzZWWI75aMUASp7Un64VZYoS
         t3+ajnY9ulOWAnMfNE9b5bGoBQDWOsuz8ZPSb55DbsBUc8PPmqzbuIkv7zagsvN8ia4Z
         ljEg==
X-Forwarded-Encrypted: i=1; AJvYcCX+rjZwdVEjcYtgwqYPsK5CpJ4BuNLO3ZdhJV06AV81d41NBaDOenOT+GgGYXJ/iln53pSkB6tqOEVcI3dCDAF8IJm8880=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJsBMgWEQbSIf8dTRrFHoDN50L2nU5HHyYYoxqKyX6JWLcf6it
	CXhjhpu+h0i7ZUAmTn33PVV0qGNNqWNuFdu9JSXLE7nORyvbsogwqV/vRbvhjg==
X-Gm-Gg: ASbGncuTTQewtG1NPPs08bVddt8/MzqS7OsDy/45Wo6/INdTQttb58T/QaJIzogIjYM
	fXZVkrvDNWIKs0pS77IQ9QESMBEc5/cstEhP109LsETiiEBHZdezimcuXqDepCLbDGcYW6K/JXh
	uTGQgWbrhQ7lgTrYmISmcPQl5qmRVWJVIWSFn+YndKPzxKV2fbNbqKOc12w59sMZ7t8wDcjAW6f
	TKHsM4Zds+t7dJW9ypLrcyL+F04ca0onJVXxXqnDQ9zoRBP9FDT3PabIIr4BQBmKwHDn0c36TuV
	fFadzDFWbLbOlnmcKQ8n2AHRTMZLoKp8NegaSQeKr3Xy2rQ7+IgL1vyXQkGw8P4wAp/1UWliQWG
	ENzInDqUr9w==
X-Google-Smtp-Source: AGHT+IFycseQfg0kLwO4oxZG5+JgJxP4IyeOiqkyzoi025zQHA29IXH0mAeKzb30l8qKo1jAzVjZdA==
X-Received: by 2002:a05:622a:1825:b0:476:903a:b7f0 with SMTP id d75a77b69052e-47aec4d11b7mr278155631cf.49.1745350497903;
        Tue, 22 Apr 2025 12:34:57 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ae9ce2653sm59106831cf.58.2025.04.22.12.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:34:57 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:34:57 -0400
Message-ID: <90ae0b3c6c151950c3a4547f4ad9ad0f@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250422_1524/pstg-lib:20250422_1524/pstg-pwork:20250422_1524
From: Paul Moore <paul@paul-moore.com>
To: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, kernel-team@meta.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH] lsm: Move security_netlink_send to under  CONFIG_SECURITY_NETWORK
References: <20250421225250.2544754-1-song@kernel.org>
In-Reply-To: <20250421225250.2544754-1-song@kernel.org>

On Apr 21, 2025 Song Liu <song@kernel.org> wrote:
> 
> security_netlink_send() is a networking hook, so it fits better under
> CONFIG_SECURITY_NETWORK.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  include/linux/security.h | 12 ++++++------
>  security/security.c      | 36 ++++++++++++++++++------------------
>  2 files changed, 24 insertions(+), 24 deletions(-)

Looks reasonable, merged into lsm/dev, thanks.

--
paul-moore.com
