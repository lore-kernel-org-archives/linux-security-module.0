Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4D2F3C07
	for <linux-security-module@vger.kernel.org>; Tue,  5 May 2026 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974648; cv=none; b=D5Y5CbsRvz7TM7GvLis35HNiQxRttSVh+Z1PqNouFs3nttiOn1/NJUsIPhGdGSqFkagoYg6m162FxZr/6OqjcO/OPPJXMawf9TSqZ8UDAJi5eqOw2cQ8Zq5tucHFTna97wMgwZTRZ2KsBbRR7LQ27XOZu62QcpNp3RT5+//nDPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974648; c=relaxed/simple;
	bh=lcGXuYSvKYdSsjE0MLmNZGGrYTy35aBsjj7BUNVuNI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhnIDB7jwVN7PSgKS9lsxdrW3DO8z4wukvtN5kQAHScrfpcTjg+NIF6PaS6m1i/AkKPdrl2fXF6K49J0fS11addlJn977Tsy5pg6P5T7zdvramV3emCi+2SeWppKaMJvuDPUcyzxu8x5Q6WZdsCPmp5wKac+uOGALzqipkNkB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=eeKgDHcP; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="eeKgDHcP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Xe1yFCNlLOiABi+3ylgr0uZ8s380Mw/tGDgaqvQYjNM=; b=eeKgDHcPI6Qm5GQ1x/e9U5ToPX
	eFmJN8YBGJbj4HrZsmPod7HqPy/5W8d30p1fD88lkxxhEyf2ucW+gALNnvm1ZbNKJoAUufQVZLWzN
	9YWH6ApjYY87JL97DG5nYZ2NMptRRPEnWzfgk9KZ2hGPJ5hfHmhoJZVRq9voBYooJlOMO0JThgEx7
	K9hKg4WyQDPlFfG04wByGzk41IngkAWRLsn6mOAuyv5bIFqvxibcMaqOgXC5fXWYAmUMp9iujmsp3
	EVFUr+j6/Jsec2hh1dE3rqAPZDHiynMNtMJet3yIn6QiIMSsYlwYf4s4OUM+TUI+smEH5ZVdJz01Q
	W7WGX4xQ==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:25019 helo=archlinux)
	by pf-012 with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1wKBwn-00000000K3r-1V6q;
	Tue, 05 May 2026 11:20:09 +0200
Date: Tue, 5 May 2026 11:20:07 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: linux-security-module@vger.kernel.org, 
	Cai Xinchen <caixinchen1@huawei.com>, Xiujianfeng <xiujianfeng@huaweicloud.com>, 
	Xiujianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH] lockdown: remove useless decrement operation
Message-ID: <afmxC6U2p5hITUOY@archlinux>
References: <20260501174448.47154-1-kalevi@kolttonen.fi>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501174448.47154-1-kalevi@kolttonen.fi>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Kalevi, 

Thanks for your contribution,

While it is true that the len variable decrement is not used anywhere
and that removing it would be cleaner, this patch does not otherwise
bring any direct benefits.

Ideally we should go through the full Lockdown code to clean it, I'll
include it with Cai's one[1] when a more consequent patch will be ready.
I'll thus keep those somewhere until then.

I have a two week holiday starting this Friday and will thus not be
available until the 26th of may. Xiu, and Cai, if you want to work on it
I'll gladly review the patchset.

Best regards,

Nicolas

[1]: https://lore.kernel.org/all/20260119091226.3195309-1-caixinchen1@huawei.com/
