Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286CA3F7AA8
	for <linux-security-module@vger.kernel.org>; Tue, 21 Jul 2026 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784598784; cv=none; b=eZ5vqQLXpujacoZAJpMdiBrThKKw5j6SNMQUQFMRWyibRBv7P4jSSuO26utbnI65bwPfTvxBRFyDUSb/OEYRDmTcb6q0+2FSqMlC3W2xcfGC4IQKIvFejt8ZTWK6UvhSn1JAHooQqa5/ZO3OTJhpAt5T+SfKHSRiWF9E+K2lf/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784598784; c=relaxed/simple;
	bh=xkgwRc1Um61YBlkY0tDZ6nTEyXfJqlCh34V6nkav8gc=;
	h=From:To:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WOayVja39AwvY5adcWtSq1+YQGwkFgYZBijXoBxU+jXzA8s9OYoj2HcI0cLIbcu9ULz2wTyoJbbeVcfXHwxNzGk1pcihjwNvrOUQvrntMZsr3FMquHA+zxuByyR8WEpOJw7lJNnGiIyfjqsVMqYlEi1dnF495wWbLPLjDdxoUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cQpkd7oO; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cQpkd7oO"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c2c8f43aaso98808761cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 18:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784598782; x=1785203582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xkgwRc1Um61YBlkY0tDZ6nTEyXfJqlCh34V6nkav8gc=;
        b=cQpkd7oOja5LZnhDzNLoRMRxSbOcHJEnJD4Uu3zntgbW16/JMNSkWx+qZzIW1/xoEe
         xiKh/gI0iLE3TVjdezMAQP4PMGCMtGH1kC7SoJTRX08pmafaZeBvTwYtfDAGCKdzMpRO
         YoYJ1TjxCnjrFgAfypRtNpMomrOedRn2brbrRS7Ih4+ns6rcAU3zA6FIFy5k6ernwApQ
         Me5IwgTzJQUZP9/unU3B70oJtQTZLK3ChtbXkPXkgpQxTEYe4G1+gC3zj8kj/tVyrV39
         olA/NC49fN61iNJYG18gjasEfP+9Lq7SiVymaqVy0ogNLvf7oXEp7QCEx+kaAKVnxwhM
         tVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784598782; x=1785203582;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xkgwRc1Um61YBlkY0tDZ6nTEyXfJqlCh34V6nkav8gc=;
        b=hplNaTVZqOu6+kJwzeFH9tf7+QJIWNa4mcAPz9xG5/m+5I0Ia6KCQVL1mSWXDQ4cLy
         mmlJv3SkEajPorCbX5eu5AP9Akhn1p0yL78Xj2CXdaZ65tzhP3XwH7t2JH19wptEGct9
         U1pAcs7cWqLidRfIAmZkcGb+l8NKe4B9MU4QZ6tPARdtjCDYxd0mDpw1d7nz4NOluk/5
         p9CpcRJ8IUc0z7Opq6jykx7VXiCRFd19xuIC88qFsrRo51RA2C5LdnjaHLJPVadsERFE
         S6P1s9ZnHJkU3JDPMDycOWC+9AKJSmLIxCr5hEL2XtyDkZnICJVQ36vM6DQkrAuj8O6z
         PMvw==
X-Forwarded-Encrypted: i=1; AHgh+RozJ6a0JzBb1gXrdQkjEKQQ6iTeEz4oCiCA0bSWkZrcyX5BOVHdO2QsTLIaRvRRdO0SwvX78XZaoGDrN0sE2qG/Z6B/FR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmYHaSmiG9vd1ERLWrxlDeIqR9oXdxmFfCnRZxqWC08usLUsKn
	Htn1vRrxS+zESiZg3LX+4oqp4IwENkoPKq+/gCmt1Uh/2H/SVmJJJd4tmP7aEJ8Q6FZQyrANDgw
	WBKJZTQ==
X-Gm-Gg: AfdE7cmJvv+f35pu4QDqvBLuY3gcf+3jwm+kFkhqIV6EkNs+nrzseWS1BWqUh7pBaLJ
	i//yMaHMWj+3s0DKszKFQCRKQl+1gdZq1k61BdPGVw4qvWoXU5P/JVulMbIWgude1UwW08UoSMr
	giT7lZgqfMTGrbb68/sqPMQzJGg9657RMvLx6CcbB6K9zZzp4uebfwJMtht4EBch8BDd8L2rR0p
	jMqLEBzNPsL7W+vSprUIpQMilva78UjPTYAoxvzIXgdpYAw105yDeKnKlv7lP2bb+TCABxCGF6U
	IhG3nT0//pWl8WOKvKPbsx3ji3MiDsEDS7h97Ypti12p3kToD2FcvukfWy8TjUAna/3mVNJUI+y
	w/kvWTbVC9uyr76TZtvL1+neBcJybRH2eEULmBH/tMvDERK+AUBepIjaK1oASlhP8df3+XF+DgX
	8UzCMTntBIrBpVHgNX65m4h6eLhdpb21qIxV+Yv8+IMr3uW8yj3SQ=
X-Received: by 2002:a05:622a:1445:b0:51c:f33:9be0 with SMTP id d75a77b69052e-5213daa1d32mr154605771cf.55.1784598781787;
        Mon, 20 Jul 2026 18:53:01 -0700 (PDT)
Received: from [192.168.7.16] (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-526be2883d5sm2193821cf.0.2026.07.20.18.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 18:53:01 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: John Johansen <john.johansen@canonical.com>, <linux-security-module@vger.kernel.org>
Date: Mon, 20 Jul 2026 21:53:01 -0400
Message-ID: <19f82605c48.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <326a6ffc-8cb1-4842-8bf0-74dd58bfdf08@canonical.com>
References: <20260717215254.383183-2-paul@paul-moore.com>
 <326a6ffc-8cb1-4842-8bf0-74dd58bfdf08@canonical.com>
User-Agent: AquaMail/1.59.0 (build: 105900627)
Subject: Re: [PATCH] apparmor: leverage audit_log_n_untrustedstring() when possible
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On July 20, 2026 9:41:05 PM John Johansen <john.johansen@canonical.com> wrote:
> On 7/17/26 14:52, Paul Moore wrote:
>> Make use of the audit_log_n_untrustedstring() function to simplify the
>> code in aa_label_xaudit().
>>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: John Johansen <john.johansen@canonical.com>
>
> unless you object I will pull this into the apparmor tree

Please do, that code is up to you and Georgia, not me.

Thanks.
>
>>

--
paul-moore.com



