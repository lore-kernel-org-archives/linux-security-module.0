Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2C0375F81;
	Fri,  3 Jul 2026 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066027; cv=none; b=cIWXdDmpcLZuhZF7qxslfS+8YptBRfGaK7RC3/yr6Px8OvGWOXWvDxoYe3alhEycaOIv805aAztmMcj3aa6iPVgFjcLacEkain8so/ebVGzi6H0iOgw4FybIst1cFPePCvDSvrcs8bVQgxtZ7sJq9jEIu4HTLQUFpeN9dbRUL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066027; c=relaxed/simple;
	bh=TEs2S+futbanPUpJS8g/Mp8Y24zUTxWEzdm1v4qnnlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpxgoVM0EiiKPNQFvvRm5uba8IwMUEFj5QDuId3CbA7V2SgmpuiX4wAnFf71QbOSXDfGlHGv+ZgOhkcUnCzWv2eDKqHsVIiIdTSWHmWEsbXlfjxAOb4oMxYPXmlU0qP+BqgCl/lqcKa7hSefQejO6kstcH2N+QIklH1z43cwBNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=IzS9+CrX; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="IzS9+CrX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HyGTFNVKLNnLP1Zaff14bNFuWzKLKPiRQ+4ckjgseWA=; b=IzS9+CrXdZbZaTA9JPq8ySmrHp
	+T0MS9pPmMEcln1fkm9dE+qv4ZLOm9Lc5M6k26Y/9GmbH9pPX81qEDPd60c0F//1GaSWH6bbcTdmS
	E/WMKedyKWN5kIaUxWIn8J9EM4pKXyctg/wi3mRw22jAq10vWLJvEsc6Lnyizmm3Hxa/AlCoUNIkJ
	JNf4RvoCQzjHQDPf+CBy/maNjXFbdVJwp29RGI84S1gDWCPV6/ZLDdzQ/A8wqOY7Zw8zlEsdQrPzL
	CKGR0qs4LxGpepWHSBsdmz0j5rBmlyeIjzIpYdGPqhGQIWTgK5SLVs72r9DAOny0Qme1QO5cR/ZW6
	4UKz7W5A==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:33310 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1wfYUi-00000008smV-01sD;
	Fri, 03 Jul 2026 09:39:27 +0200
Date: Fri, 3 Jul 2026 07:39:20 +0000
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Paul Moore <paul@paul-moore.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Cai Xinchen <caixinchen1@huawei.com>, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] lockdown: Add break in lockdown_write
Message-ID: <akdjuyJ7tGefNNUW@archlinux>
References: <20260119091226.3195309-1-caixinchen1@huawei.com>
 <b12a0d60-da15-4ba7-a526-247b5a7d97ad@huawei.com>
 <CAHC9VhRokERQGaB-1Xf0AoAzmT5tys4d+e4pmVY-W-88GQ8Jpg@mail.gmail.com>
 <CAHC9VhTQT05+1qYM-8_YTc84Rx2SdZV1iRixeqAywCXf1mMddQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTQT05+1qYM-8_YTc84Rx2SdZV1iRixeqAywCXf1mMddQ@mail.gmail.com>
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

On Thu, Jul 02, 2026 at 12:50:18PM -0400, Paul Moore wrote:
> On Thu, Jan 22, 2026 at 12:41???PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Jan 22, 2026 at 4:31???AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> > > On 1/19/2026 5:12 PM, Cai Xinchen wrote:
> > > > After the label is matched successful, any other levels judgements
> > > > are meaningless. Therefore, add break to return early
> > > >
> > > > Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> > >
> > > Looks good to me, thanks.
> > >
> > > Acked-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > >
> > > Paul,
> > >
> > > Would you mind if this patch went through the LSM tree? :)
> >
> > Assuming Nicolas is okay with that, I can take this through the LSM tree.
> 
> Following up on this as I never saw a response on-list and the patch
> doesn't appear to be in Linus' tree.

Your right, my bad,

First of all, thanks Cai for your contribution and I appologize for the
really late reply.

This is pretty much the same kind of patch as [1], while it effectively
cleans up Lockdown code, in my opinion it doesn't directly add much. I'd
personally prefer to keep those small patches on hold for now, waiting
for a bigger review of Lockdown's code where I will pick them both up.
Sadly, I really don't have much time to work on this right now.

Nicolas

---

[1]: https://lore.kernel.org/all/20260501174448.47154-1-kalevi@kolttonen.fi/
