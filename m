Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33DA1F4C87;
	Thu, 14 Aug 2025 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163202; cv=none; b=buGEluVeRwF0tYCYKuZoz0+Ur0fSwnlHuOM1/FL14E56e/yT4BG3QXT6K9ZzAmJvXV37HZC6gHWqkVkfuuZEiLSWQMvW3s9lsX+LkAyvQQ8/XdQVO5PfqqtatCQccgaxAL7Ab0MfrN57mFE0wJqHQn2wraPljRVQEfn8ZUnryYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163202; c=relaxed/simple;
	bh=KMJl13AfWts+9QG5NtWZwsFWghBRa/AhZ9/gLJKZcdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlT+I4dru1Y7hxHKYLM0FTaJZVx+SSS2zDZuwsVZYbBFG+eBBWkEwbIt+GWkGUgmXTOohMVz5RnFePj7XjnTv75OS2pp/Sq2EsdcBQcFzpsJ0XL4VGiBxvuQwksA79CUN4ttINMPZS9LYW9apAzjKAL5vaOYqU/JJWrIA7+0mVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=RCOjqpH1; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="RCOjqpH1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KMJl13AfWts+9QG5NtWZwsFWghBRa/AhZ9/gLJKZcdA=; b=RCOjqpH1sRYr/jK6iGKuz+Wcvc
	+ooHnLxbGdd2Ph64XeTt0q8JhE59WqnwjE5Z7CY9VsPgyy4CkhCF2RrjRUbVJAI6qRy+1/Zsx6nGy
	1Lk2u9hjSaJH2sX/CxiObnW/+kub8WwlSwwZeyAfIbuuAIJHehDO6g2ocNSuxf09mte3JUNGoNP++
	jj6fY/T7DqAh55DFU//nhpdyKLFhpyh2V9axedrVAXhl/nQVpJ5XdS7qO5C+zrXstcvWw2Eoi/6o8
	4W0s2u5vNhGLtCpQ3Y34jHxHzgIX8sEjL0ouuB21+CK27LygCnM1HeSL/0NpjtoHpyP8mPzllnP0G
	ys0DZ+/A==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:4913 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1umToB-00000002tkz-4BtN;
	Thu, 14 Aug 2025 10:59:38 +0200
Date: Thu, 14 Aug 2025 10:59:35 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, serge@hallyn.com, jmorris@namei.org, dan.j.williams@intel.com, 
	Xiujianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH v2 0/3] Allow individual features to be locked down
Message-ID: <2vldrnqs6fbljqqp6vbwmkushx6dxcpephgb6svmu5i64lijpy@lg37aflddv3b>
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <kl4rvgnupxnz4zrwlofrawdfy23tj2ylp5s3wovnsjxkr6tbrt@x5s3avqo2e7t>
 <9b6fd06e-5438-4539-821c-6f3d5fa6b7d1@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b6fd06e-5438-4539-821c-6f3d5fa6b7d1@suse.com>
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

Hi Nikolay,

After discussing with Xiu, we have decided not to accept this patchset.

The goal of Lockdown being to draw a clear line between ring-0 and uid-0,
having a more granular way to activate Lockdown will break it. Primarily
because most lockdown-reasons can be bypassed if used independently.

Even if the goal of Lockdown were to be redefined, we would need to ensure the
security interdependence between different lockdown-reasons. This is highly
tied to where people calls the `security_locked_down` hook and thus is out of
our maintenance scope.

Having coarse-grained lockdown reasons and integrity/confidentiality levels
allows us to ensure that all of the reasons are correctly locked down.

Best regards,

Nicolas
