Received: from 251-188-159-51.instances.scw.cloud (unknown [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCDA2E718F;
	Tue, 25 Nov 2025 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066063; cv=none; b=dsezM+yDPdVYjjPgYUICkT9xdes7GCJRfX5nsaRRFWW906RmLQAoaHyhh+2QhBpAyt9DwQ/eV5Xze+cH9sjITSkzMYh8Ld8UU8eZNshGPOZkjg8D69lHglS4qo/f92q8UBa6OBH64Zi+KwFeeLpbXFi7+O5Ya4zcRfuAtXePCl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066063; c=relaxed/simple;
	bh=LF/6dEL5noT5YXH5bnfTmunohParEkqRLKR/WhHgtYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3spUFN1xMUyrcRM8q6fcuAtqiiwe08WCorhFsr6AXYlxPvKtj1JLogqJxIEHhdWuQ0mSPk7+VVaZ3P0d7KCJp/7j9WsWRiB9d/bFSMRPqJ3JowT0fy6y6yH43zfiAsXWj3fe+627hmlsbGYogUUyh1Eb4kmWgDBZt63KshShTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=OBOsZAwX; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="OBOsZAwX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LF/6dEL5noT5YXH5bnfTmunohParEkqRLKR/WhHgtYM=; b=OBOsZAwXhWsiIPOqTfIgLNgC9C
	/g0+qIbkwFGAXq+wbMSqqWFfRoeDg/5e+gx9FT4pY01A62f54M9QnYSUoKOBpeVk82d2EkqPeXkMp
	c4Mo1+EW+dBXf98q4iFrtVG1NAwNPMpG4yqnlWWnRuKk/tPFt8ZxEsAZuX6ZTerHK9cvkM8XS9Enk
	FGH8bQGsDM8Piv6p4WhwBc0S10PPSw0ADpeuED+CKjsLSraL9PjVgJGWe7aAV8WiUQGEJVk75arRx
	MPVnfauGvA1qY5ZX6vlfNvoj/SuNAion4caDOeryz0wxep8MUxjPUNbNOSbcNiUZAdNtswsIOEp3W
	JCyL6AUA==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:31465 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1vNpqJ-0000000AxnD-0Dr9;
	Tue, 25 Nov 2025 11:00:14 +0100
Date: Tue, 25 Nov 2025 11:00:00 +0100
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Xiujianfeng <xiujianfeng@huaweicloud.com>
Cc: Daniel Tang <danielzgtg.opensource@gmail.com>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Lynch <nathanl@linux.ibm.com>, Matthew Garrett <mjg59@google.com>, 
	Kees Cook <keescook@chromium.org>, David Howells <dhowells@redhat.com>, 
	James Morris <jmorris@namei.org>
Subject: Re: [PATCH v2] lockdown: Only log restrictions once
Message-ID: <do66st3vh2bg5beq4b3s22djn7kdtdp563grttfzmo64suegzb@k3lj3wu4cf3p>
References: <3641397.L58v44csPz@daniel-desktop3>
 <CAHC9VhQNGnm6NBSrUmfwoEwAxqedYbHckEkb+J47W5gWjrKBOA@mail.gmail.com>
 <1961790.USuA9gRusQ@daniel-desktop3>
 <2f4a1af8-adc6-4cbc-813f-4cc8e9bc75ae@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f4a1af8-adc6-4cbc-813f-4cc8e9bc75ae@huaweicloud.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> Currently lockdown does not support the audit function, so I believe the
> logs here serve a purpose similar to auditing. Based on this, I think
> this change will meaningfully degrade the quality of the logs, making it
> hard for users to find out what happens when lockdown is active，
> especially after a long time running.
I agree with Xiu.
I'm not sure to understand how this is a kernel issue. I mean beside
that we do not support hibernation in Lockdown for now.
Can't you just disable hibernation with systemd-logind using someting like
'AllowHibernation=no' ?

Best regards,

Nicolas
