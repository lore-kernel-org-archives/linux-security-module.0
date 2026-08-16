Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3A613B58C;
	Sun, 16 Aug 2026 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786919986; cv=none; b=hpq9D9Rt07hNcS3KaMnSrKb2BKi+1ge8Il/A1DX6AaC3FnOvwPDtr6N3P9LWkHwr9PGi3MyzYsyOm3Nm9agGZDDwSj0r32e0HJgfKvBBHrf/Ksb1+ALe1J0/FJhLbzJUAcC7BJsWRWk79NOTM2EwqnSpprw+ZtWUSEstHdkKdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786919986; c=relaxed/simple;
	bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bh6ompwKbCh3Jjw+3otzC16wrR+WzU7oAp7gwQ2UV6XhOtEABREcCoVpnjnYmfPQgZdXexoazbSdtdytWxXPki6O6qz9uVNWkNvjYnPhplrMQyP50cSljB06qFaD5Sfys23e4G/1TKBCa7RaQvxz/BroEqUpAA9jxRsV2lDBFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=PCxxr9i/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rybartp2; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="PCxxr9i/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rybartp2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 204F314000E7;
	Sun, 16 Aug 2026 18:39:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 16 Aug 2026 18:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786919983;
	 x=1787006383; bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=; b=
	PCxxr9i/1SfOluatBlV3zwVnWsoPbCgu6+BYQOfPgRv9GAs5gqFFQLOHVxe4fmR3
	e1Jmn9SfkmZ6NINtowpVNhSVcx+90+MFy82NVwbXZ3qMIFiLU4baUj4QXljimnlp
	cMAI2ncU0Efe4xoGq4dx+1ReAMBZtnQ/aI+GLwwBLd5qMOPxI+ze6EMV9gFcGpAe
	OFrwteIg/5pXMl2Jj/cvmIhNe8i/If7xTJ3wTZrgd45ubXw/z5ZK8dIaHM5+rvQK
	jbatiTIr0c+7GkDWS5m2aay6xow5CY54EJCrl5m3weEdfFGLMvqfgTYJIABO1Yh/
	KBJnABY4FVF1AADeQpPY+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786919983; x=
	1787006383; bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=; b=R
	ybartp2CIfsb8zBcDFSK7sAu6tgh8m4FXqLtllHNk6i0DAYZAxnV2FxMnnqZfVQL
	QzQTsCsmYF2EC2+z6m72LrkvPVm9d5BbFPqmyf8t+GeLsHtcLzNwYgMzs3wZp138
	8EsS1OKJvIU22JiOIM2FJj9c12kZisSshOQ/EA1vSjO4zQYWTx7lRjJSKcmfkiSh
	rDhlkloWMmIu0p5mvvXR4ZV1/K/ok1/ZH7oHeGBI0veXLzIZwi/0Xq3D8wpzB3xo
	OLIWh33XJARYV/+Os8Bkb0pUFZ5AsQZXuXefKu/SBGz5QpP+vVpTwO/2Wk4cvat1
	Fk53Agwpr7tjpwWyw/Lzw==
X-ME-Sender: <xms:LjyCaskp4Wl7bzRsNkJiS1dHNOZeqc5klAXcz-QIqE2BSZn_3cX2Fg>
    <xme:LjyCappu1QzT5FXVOzcH_K7uKzylogydu9JWH1N7gRRwQYIcxuHAW-MmO-ep8vT5L
    UYoSCcupIHZkKgD8ngd2cFExnrSF4xef3A2vv-x7DpjQIt1gqWAoUjf>
X-ME-Received: <xmr:LjyCalGpd2e095-V1qgyC6CMrbMSiKFl1wpvfrZlMPsFnWC3gm8KPMZAZWIlZ_dn4g5VqVnm2WFbeVkqmL0w-JmrXXqdfQns6YAlLyfmaKhVvolvgW9E2pY>
X-ME-Proxy-Cause: dmFkZTGj5+rsZ1MdkW2jE4UWQOyt5NIdygHBfwpYCnu6v7AtmRd24aCCjJvper54sAi4E1
    9jSAXM/AfRve4DY5E+v78kQH2qqIlNaOvoRerSIBrKTG/pa+IB8ZkJZoJc5T4aGVhq7Avr
    cM4FwcJ4dU0e04+rUIZ47No6eO01WEjBhDkX0GkJmcAibDwDElpyf5S+7zETgdi6G9+43C
    W2Bk4ebnOqe5cAPH4Csj/n23keTvR7x2wFgYvyZTAzGayI9fSeCyYLW3SVRqICkSIJwIYG
    e3hgYIHFnzo521dja0acOrl8Hyk+xXfKpmTGTShK/0jreExxbcfo/HGlu2PAdRcdocRkKj
    U1q+N5wB2XZPGZJAyoda/EbLcaAhbY+pLOXXoaa+iHkx5uIHGVd8QWswLtpMp/orqOY+fJ
    wdUPdpIqWyPndjmXYClug2YZlMF95eFkE277IIdIlPbo+E9nffJfF5P9A0La7c7VJOnYwj
    g2TGJvVO0zPFZtv1CSRv/3110u+HC2vPzcm8HUR3xbgbKudbr1JQZSx8Dq21qBSjHV1ETg
    g/3BCF7mvqGKaMLTqxsLyi3Gh7419kmta4tbTCpag3YQnSWIrwCLKG7fMV1FOWT8sDbpv6
    PRYk/RPw2t0VUqlETwxWJT31n888dsdj35AB7ry9gYxA2JH+LMEbUd8pFhog
X-ME-Proxy: <xmx:LjyCalwrVDP2GO89d0ccODW7z1HgJdQlJAKQOTKHzghF6-JdQF5bMg>
    <xmx:LjyCaqoxhsK5cbZ4C9kId74-sAnxAOtQoGtizlYi-xTxaX0n2VA_Rg>
    <xmx:LjyCavjHprO8Q1l7Sja7U4LsWwndkh5Ui-iHFrlYIG77WBDebrvJ1A>
    <xmx:LjyCaniHXmGP1kTcMZaxAyYP6W_10dwIGgd_9XDEPAXMZrqSkv0_GQ>
    <xmx:LzyCas7YzN1007uQICkPqrdg_1l6qRW6XA3UTW1-Y4o0ZW15aniJXcga>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:39:42 -0400 (EDT)
Message-ID: <a0436d25-d6a2-4d12-8859-823cbace3119@maowtm.org>
Date: Sun, 16 Aug 2026 23:39:40 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/19] landlock: Decouple the per-denial logging
 decision from CONFIG_AUDIT
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: kernel-team@cloudflare.com, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260811094338.288094-1-mic@digikod.net>
 <20260811094338.288094-6-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260811094338.288094-6-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tingmao Wang <m@maowtm.org>
