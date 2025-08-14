Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281822F90C9;
	Thu, 14 Aug 2025 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168687; cv=none; b=fwJBzNym/eTH20HFM1CbfSDOwG0jzzKE6AhQQBWWCgi0UA6OVX+JntwsYh9llmqHWSWBm5yUhPlNlgW+UH4RoehpwaNIkpeDHsHKGzYEEatTDW1p+ERZpmD07rvlU+OW3Iv3hIbaWnHKZoT6+SB0ME639LPO8TskIXFpnkrh3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168687; c=relaxed/simple;
	bh=iYBvCy0ozQyrxOTiIbPct9+4MVF/YM+Nm32ZVyUDg1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+bZKlDay0AbGubhYJmgL9hKklHDpHKKkEdUFye5Zg/fNxwITlJHiPdpbjee9swZiXArUcdDBMerZkfBMDwqkIib1ueF4/HUdtgl7KxHUuaG3z2heb/qraJhmg6/iRebpYnsKbBWhDhwW1iv/FBgPyjo1ohih5Aj6TLFoCBPY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=WmCw/CWb; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="WmCw/CWb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dK61LK7LOQ2eOe5xKdABoMGTs6KyqGMZWtWDbiV4RKs=; b=WmCw/CWbz7VPlb/vBOyHhC8MpD
	f0Iu9F9dLls4DZEeOKdqAWvDPZLKszUO+UuzIp3whthWUhXIW1nRuks29QOrpoFzMhMWOGTILzH6Q
	cin7FV6dsC9mZ6nQOwrokYxz/4Pkyyv3NGwTAH23Bjyx6uag+6gapGPjQgBbx84Ai1YRlTcSt9K5R
	XEIO0jcINrGnmGmCyDD3x/VE36VdA1tIsJJB7zs+g8qzK//JccFLc7WWDooJjt62dq2QSNqx5xJ+x
	cMT3TcAFASbox3AFTcvYrE+6+JsSnOfnwNqoYt/0qe2Rs2eVUyxnNwyFJUWD9ZAN5AtNNjyw4Zs7J
	ftyRTTWA==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:33094 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1umVYJ-00000003xgR-3w2N;
	Thu, 14 Aug 2025 12:51:23 +0200
Date: Thu, 14 Aug 2025 12:51:20 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, serge@hallyn.com, jmorris@namei.org, dan.j.williams@intel.com, 
	Xiujianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH v2 0/3] Allow individual features to be locked down
Message-ID: <7hmu5jbctmzdp75kipvjr3dzdmnkl4fpg3tkr4jcc5jcqzse6i@rpocehoxrjis>
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <kl4rvgnupxnz4zrwlofrawdfy23tj2ylp5s3wovnsjxkr6tbrt@x5s3avqo2e7t>
 <9b6fd06e-5438-4539-821c-6f3d5fa6b7d1@suse.com>
 <2vldrnqs6fbljqqp6vbwmkushx6dxcpephgb6svmu5i64lijpy@lg37aflddv3b>
 <60f17362-af8e-46db-9bcf-be85b84a525d@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f17362-af8e-46db-9bcf-be85b84a525d@suse.com>
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

On Thu, Aug 14, 2025 at 01:02:36PM +0300, Nikolay Borisov wrote:
> 
> 
> On 8/14/25 11:59, Nicolas Bouchinet wrote:
> > Hi Nikolay,
> > 
> > After discussing with Xiu, we have decided not to accept this patchset.
> > 
> > The goal of Lockdown being to draw a clear line between ring-0 and uid-0,
> > having a more granular way to activate Lockdown will break it. Primarily
> > because most lockdown-reasons can be bypassed if used independently.
> > 
> > Even if the goal of Lockdown were to be redefined, we would need to ensure the
> > security interdependence between different lockdown-reasons. This is highly
> > tied to where people calls the `security_locked_down` hook and thus is out of
> > our maintenance scope.
> > 
> > Having coarse-grained lockdown reasons and integrity/confidentiality levels
> > allows us to ensure that all of the reasons are correctly locked down.
> > 
> > Best regards,
> > 
> > Nicolas
> 
> Thanks for the feedback, to try and not have all this code go to waste, what
> about consdering patch 2 - kunits tests. Apart from
> lockdown_test_individual_level() the other tests are applicable to the
> existing lockdown implementation and can aid in future developments?
> 

Yes of course, thanks a lot for those tests. Can you adapt them and send
them separately for review ?

i.e, the `lockdown_test_no_downgrade` should check for -EPERM.

FYI, I have a three week holiday starting today. I'll return on
Septembre the 8th. I let Xiu review those patches until then.
