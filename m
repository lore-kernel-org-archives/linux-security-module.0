Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FBD2F3C07
	for <linux-security-module@vger.kernel.org>; Tue,  5 May 2026 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974693; cv=none; b=sLS517xXVjezMRXsCuSZqZK3K4TXLSx9XSj9JAKsu71MAAT4B7blZVP1CRMIdy25ORb1jR2+SCLZp8/jbyr2e5WFVR74m31VvkVIfCyWhdXELg6jGO8UJnIGjlRvzML+K8/ZHnYJMLSgCrgvVd8MUxRrIgbAuN0FxLm2neONyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974693; c=relaxed/simple;
	bh=tQWs4GRgNUrnO0gLA5AgSv1ETIuuWdIQlmhRU/E3/V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuV2k59Ar5oL5shJK92sTl6XygTo95GiVdMZEmb1Y53rd/ozJCoPev1VniO6dvVwXZtnnMur9M48U7cCL46qoRzo19EmU5icvvLLRYgNy4IuGtPAeYYjJtqZNVJwV0cbOYomcc5606xftrCtowqR5rPbPhXxmFQCfvQWQyoJOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=aw0EZoA6; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="aw0EZoA6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tQWs4GRgNUrnO0gLA5AgSv1ETIuuWdIQlmhRU/E3/V0=; b=aw0EZoA6FdAIKxeJqnbH+AB/fJ
	PIKk4H6SNKkcQm9uDOf2hckTkdh+hOGZxzOGHiz1398Gqcs8qMj1JVUS7hVAhSh/O7HYTKAr5jiIM
	4UzPJJtoxtFD4LXzpxmay/2YWW/NW+eql1+DkNjQXP8vX/QUNz2pQOqfaMk2zaYnIPkU2KjLQp/Hq
	Bql7ZWNfo2R1t5tYVv971Hewp9TXqEZZEBADRyxL5zpJwiuwOi+CRG6Qy5JF7T0wDIC1OLl16MKXs
	5/oTi+HcqfUnGACWTMkMk0n8sRvZ068TZuVccIhP85CziOwwQoQxQWqRRyHLX+GcLS3jdDTvdkO7e
	u8zpxBPA==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:49064 helo=archlinux)
	by pf-012 with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1wKCR8-00000000kvb-45Zh;
	Tue, 05 May 2026 11:51:30 +0200
Date: Tue, 5 May 2026 11:51:29 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: linux-security-module@vger.kernel.org, 
	Xiujianfeng <xiujianfeng@huawei.com>, Xiujianfeng <xiujianfeng@huaweicloud.com>
Subject: Re: [PATCH] lockdown: remove useless decrement operation
Message-ID: <afm9F_neup5eiD5z@archlinux>
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

Hi Kalevi, thanks for your contribution,

While it is true the len variable decrementing is not used anywhere and
that it would be cleaner to remove it, ideally we should go through a
more in depth Lockdown code cleaning.
I'll include it with Cai's one[1] when a more consequent patch will be
ready. I'll thus keep it somewhere with the patch until then.

I have a two week holiday starting this Friday and will thus not be available
until the 26th of may. Xiu, and Cai, if you want to work on it I'll gladly
review the patch set.

[1]: https://lore.kernel.org/all/20260119091226.3195309-1-caixinchen1@huawei.com/

Best regards,

Nicolas
