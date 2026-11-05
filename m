Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845485;
	b=G9sRo8Xhmg+Ahrl81u5cn9Hdb+CEow3f0n+SIW788/fwV0tOIYGB89fN15tXwlXg1TtZ
	 sbLbLEWdyeBdXGsxxz6K8Q+fi9+QMIjljf3DhRJOULIXH/B0LKP2Suh+QkT9mIY+DV42J
	 /CAg+FkpLhmKXLCYEBwo076EydRSNlzlOFWeMsODJnWuq2dBQZgw7C97aS1cwtggAWAkN
	 us4HdUnR3e/YZDi1ldC3T687XB+MaRPtcTuChdgoe479Y5nHoyzu6VCk0UGcm+lxloG9h
	 bvxK187cvqVEr7jtuxaVZcGIPmysFLXu+3d1oD/IXtbTfgdYbwrynnbumrfvvUfJLMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VUFf6jwNeGXVvbspON82vI4aFLY01le+Nblo8PEzIB4=;
	b=W+5onOpTPoIKwC6PrfvWXtAWpCJ3jrJ9qrchWuNO4UIg+x/Zk1bEv3w/3V4T3AFcKKNt
	 mikjkH+D3ij5BC7V6L+aaGTT/W+E5tvXBVrxPJPs5gvMK/+mJr0XrDHKF2luudvIhYceX
	 I/frT/mms0UucoXQtUz7Tzbnw9VS3qO2Xr27D6BNNfnIBYW4SVyOMfRl3VNedHolx9aKE
	 gcIgnz0IBHXfT3j+wkBHWXfNSxIYjvmvJp1IDG+/42UjTOb6/tO4mr0VrnHVVsIFLi2Xk
	 bWN4/6+kDMm+gWKgS1YTW/Lm0jpNpJlMunrvYUcIvu6F6GYHHsS1WCCxGmgjH1HGLUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kooy8NWJ;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD1F606A328
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 02:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD1F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kooy8NWJ
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso889425a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 18:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793845485; x=1794450285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VUFf6jwNeGXVvbspON82vI4aFLY01le+Nblo8PEzIB4=;
        b=Kooy8NWJcFmw3Z8AeCPgH+MoCRF1OjxPp9Pmw31LD32CQgMJIuqljx0i72RopmbDqI
         JiiqvLAJFk0EwLa94SAv+JUznGaBJCnLizW7lTFSx5lNRJiLDCEDGSvhRNDDnWTuI95b
         GvgFcbeBDxyfYEVPx/pYwppXEjoIy/TcKPXs5QK+pL6s6RTwZxd7l+3p+n9vQmvyoAa7
         qkrsTZYBdwifySuGJFkPUq7S8LJtljSrkVp5KA7pECrLsY2bNztY3uCr8qTsIaWbZsaa
         70veFGunrWXxMV+K/V5uMW14o4irHArOhs5Dx50SPkuT1Q0g3Z4Ltr6aD7w2xgD2cybw
         1SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793845485; x=1794450285;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VUFf6jwNeGXVvbspON82vI4aFLY01le+Nblo8PEzIB4=;
        b=F5D3CtLDr1zMoYQWnE8I+cWUm2EHhWSdyxQHYXJ2mh5V7AaGHqt1nn4aBvFkrFuwe8
         c32EppKi+0e2fPh2a0/RZAr+VkFStqocWUMHefmVoteM6381NwsVgbLESJek6ggElrjr
         TBGOGf4byQeoparWoVKX1sznDLGPUBPRMC0IuCMLsNs804pSBnVRxn/DXnhB4NLLFdrL
         sVIv3yPouejtbufhkscX3pnf9QgTSNIBE3VQaO0WI9ftfhS1Arthxc3eTAGX5O2FWWi7
         vqh1aJIoc1akqNHZHVmAibBkd4/7SLTUVD4hK3cGDJbjnwTtnE2GxlIxoX2+oN6Phn+8
         Hzmw==
X-Forwarded-Encrypted: i=1; AKwUvBxJq/4JJGw0tTAqyvMOnvmLgfQnvqpvv3Tz0nT9EgmH8ZgnWLHr56zh79WYgfCUVGjwL0tfXs9KDuYoY0eWV6gw6z7rVlg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZmUgg4zCuTysAwKikDqbLHooXfBl7q+WxSPlN5onOu9xoBsCw
	17ucudzQXzPo1qLQ/8dXQ2BvLKBEMS/7/HmMqYbUaSQ5EIV8xDRjaJxP
X-Gm-Gg: AYBFou2jCtUOlrQlfFpOia3vhYmgjWktl/ZLofWGT7GXMRIzoPwehsu+ovVJhDKS56C
	z41XBDA74U+QfcjstOrOhMm+ZFipPp6+sDxcC1M1+/rpWb2T2ZZfmnJ6k9g/R6AJBGnyh9qoBvL
	4cO+s8r+vmEuOI/WGMhmw7aMl3kGRnu/tteO+TbXbdEwfoyjt6jgudDztSFAO8WETK1MX5EEmsw
	2NgUDWo+SKHJOB1Q/o9ekkfwtBg30q3J27tGbDq/RI1MbAmk4s2CVMvqdJvohDAKsfCfYn5kD/q
	34FAIpgk+XHJ3WSKQ8SPE831gijGx3VIZuHLLqJHIXCX6KhjjxfXZ2fRkbUbaeAz1TBWgYPpQbm
	zbLQeTIy4Z3cMMNdrxq5VH6vS6om0iUrQN5fpx8TuUx4ed6TJqwYBehjsTU9nQulZBJkCsvC2Ut
	YmioF/LGDOaizNAwytBxTCgjTCIhHxq8KEIp0g0qzz8KbaLqSdkKEVo8A2VTs8A36Zq8VtZS0RZ
	CvCrE3fbYFWga2EMg60XFfp+ohiv/es9bPsDZEMES6gPsWxJtzKLhP4vbejZC5AShrtLioYxVFi
	wgY1ApuMp0rBqxRpRxjdv9PBrPz3444dQGcFCPY7ZYJhG3k=
X-Received: by 2002:a05:6a21:f11a:b0:3e9:24ea:64fb with SMTP id adf61e73a8af0-3e9289d8f84mr12476900637.41.1793845484456;
        Wed, 04 Nov 2026 18:24:44 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46981369sm1577747a12.25.2026.11.04.18.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 18:24:44 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: Protect pkey method checks against type removal
Date: Thu,  5 Nov 2026 10:24:39 +0800
Message-ID: <20261105022439.11846-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <auvG1wGifSsoCuaQ@kernel.org>
References: <aun7J2NGn57RGS5J@kernel.org> <20261104021414.50696-1-0xbeac@gmail.com> <auvG1wGifSsoCuaQ@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Thu, Nov 05, 2026 at 01:59:19AM +0200, Jarkko Sakkinen wrote:
> Please respond to any questions *before* sending a follow-up patch by
> properly using email client and quoting etc.

Sorry. I'll answer the review before sending another revision.

> > +	if (!params->key->type->asym_query) {
> 		ret -EOPNOTSUPP;

I'll move the assignment inside the if block, here and in the other
method checks.

> There should be an empty line prepending the label.

Will fix throughout.

> >  	if (copy_to_user(_res, &res, sizeof(res)) == 0 &&
> >  	    clear_user(_res->__spare, sizeof(_res->__spare)) == 0)
> >  		ret = 0;
>
> Why up_read is not here?

To avoid holding key->sem across user memory faults. After asym_query(),
res is a local copy. Copying it out no longer needs the lock.

> Please figure this part out it does not do a great job minimizing the diff.
>
> There were similar repeating issues that I did not specifically point
> out.

Agreed. I'll keep the switch, allocations and error handling in place.
I'll move the method checks next to the callbacks under key->sem and use
shared unlock points. I'll check the other paths for the same issues.

Thanks,
Yuansheng Yang
