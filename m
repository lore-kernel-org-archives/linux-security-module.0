Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534521;
	b=FC8W4OsyLozwOOHHKqDI6qjMsnfWIP08jumJ6+fYrowYU48LaFhXtDbc7FzGcZBydPfO
	 Vg+AocibyLAcHUMS0wfq/j/HAFLqw+3DpBDivmrjLz2MJ6Pxb6oK7Esctovy06fkCKS71
	 KKx9jdomwB8wejC1q6TpGmf1xJ5FOXPOmU+DdBvERmKh3BXZCCVEJSVMWFENol4FEnNFg
	 b+0XRX0aizsCqMUkbILDhQIEzXtddqCzJG0eaySFFQGPb5lJr5Da8uCA5zfFGvMnS5UH4
	 tI9XRU1IdNRFlfGpggq6w4SppXA326y/ixdVuSgitmoD7chYlZ+IrgeYcpgq/aEHgEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534521;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=OWtUdVBz8qUGghSmb09UZ9Y11SwaNY7ioITPlbeQQXA=;
	b=OFV8twF5qdvzcfGC074L3qzMeXAUCRShwcslLYs0O2aEbENz2HRPB0LGtP1PPF7xqbSG
	 jjHziHca2DdTIy6AblNAZf1A1eXKN68zXKYHv+rZRg7YkB2BRv6wIFdyyLD8Fv89+RHmb
	 5fXOdXJ03ghAMFL3GZsRWpP7xI4VuLIBQWVwdjspCmePBNMxgdh07pO9DQI+raU59g8hL
	 LvF0g1hdOfYs6ulAGO3Nav5d2OdpKkyMDUq8u6OStoNYGu50DlyKKRybEEilF1lyHEwAm
	 LBGGwWxaVHF3eBflhqkP02PHgoRH3XrqKz7SkBDXtu4fj9xE+gWODfcUtcMhJgQEqzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=CfSTrQx0;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D0606A695;
	Tue, 24 Nov 2026 15:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 438D0606A695
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=CfSTrQx0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Message-Id:Date:References:In-Reply-To:Cc:
	To:From:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OWtUdVBz8qUGghSmb09UZ9Y11SwaNY7ioITPlbeQQXA=; b=CfSTrQx0YNO5M+mIfdIU7xDE5r
	ZOiHdwnftvKPB2wu598tCIs7cwiA6O2qw29n85cOgpD0r80iNzYmr39sz+Py0BBrn5kyMr+bGhWGl
	lFECR3wqGcyoIQxKw6hlkkx9RkHvVPOejQFcOXU3pPykqUMaQRaXPDZXOP1+2QhUrjEFUlygQpQZT
	BgXnrX9pFplXsGeYSvnLdKQHrG5WGPVrdDHXNIEPBO6oMai2CJ8Yt6fMk9mzeOvhSpm+y5fJyA3HF
	FlJlJShLg2i2bM2WbVz/EHqWRFsd+iOeeqbDwtm5ZubyC6o6SrJmMgU1VXAVR9AAPRxf8W9ggPITj
	IXh65JiA==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:31657 helo=archlinux.local)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xVsY8-00000002UiG-1wMm;
	Tue, 24 Nov 2026 16:35:14 +0100
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next -v2 6/8] lockdown: bound the status string with
 scnprintf
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com, 
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
 kalevi@kolttonen.fi, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, lujialin4@huawei.com
In-Reply-To: <20261110132818.2231593-7-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-7-caixinchen1@huawei.com>
Date: Tue, 24 Nov 2026 16:34:52 +0100
Message-Id: <179553449232.44882.7100598310208785962.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=851;
 i=nicolas.bouchinet@oss.cyber.gouv.fr; h=from:subject:message-id;
 bh=RI4dTUfu5aSv1gvAJosEDlAJhl802JnfIZc4LrB9OtE=;
 b=owGbwMvMwCU2peIRu9mVXWKMp9WSGLJZ1y3afCTtfFZpVMDLLl5HgbMPFlsyCr5b946NIyd3X
 7WdYdCxjlIWBjEuBlkxRZZNbuf6ZucqP3L53XYQZg4rE8gQBi5OAZiItgojwzKVb4/2/rhxK4Mp
 ZbXb9pA5C5T/rM2fof3XaSrD5i9/094xMrxbtTvSLNlhz6qduVW6u7KzKpfO/H76woKQ97mlz5z
 NXJgA
X-Developer-Key: i=nicolas.bouchinet@oss.cyber.gouv.fr; a=openpgp;
 fpr=FB48DC6D172A3DE30BA94B0DA548BF06BE454ED7
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

On Tue, 10 Nov 2026 21:28:16 +0800, Cai Xinchen <caixinchen1@huawei.com> wrote:
> Use scnprintf() instead of sprintf() when composing the lockdown status
> string in lockdown_read().  The current set of levels fits well within the
> 80 byte buffer, but sprintf() provides no protection if more or longer
> labels are added later.  scnprintf() makes the buffer bounds explicit.
> 
> Store the level label strings in named arrays and point the matching
> lockdown_reasons[] entries at them.  Their sizes are compile-time
> constants, so a BUILD_BUG_ON() can verify that the status buffer is large
> enough for all level labels, their trailing spaces, and the brackets
> around the active one.
> 
> [...]

Reviewed-by: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>

-- 
Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
