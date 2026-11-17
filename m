Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794905403;
	b=fIPTVwMAIOne8XCRsfgq3eFxSb5GMH0QdEjJg1NtDrhMNFYDWHJ7iBQsiP2mr7xbsNXd
	 0bIrkJeREl3yGDAIc2KI5Zv4z+yg2ivTynYr8TfLJsB3AFc1rnlwQKy/yVHkVpuVe5wVh
	 bqIpysZbGrV5ZXmtKa67T1S+CKsyrIIiBYleSIq8NNkOB31Y5cdYizyNQlFUz9NBy0X05
	 ZhBSkgd4G6+4pDvXwhKFk7ttgFfcFpkXqU1/3mM2T+mHktPPJwksv9+l9NBKCNRD7B7mn
	 8esfJFaveyu3FbyMBGrZ/BSl71eCAyWHh7ToGU0jqsmzpN8B/ZXqszu0//ZlraFvDfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794905403;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=4Jaothk9pIoXzn6khKlhOzHzJccnvdvTdTICicAJwj4=;
	b=5CptZDqS6YaE2xdP+1KjEpuabpIK9iBVnbJV/dI6/v4Ur3jKHyBLVGHuwPdv3XfwsAHH
	 jSKTEHo5tmnF9bFlOR6BuzBhxLv/k6BsO3D+cCVeVA1IQlUmMojTMcD6/thY9eTkAt1TB
	 f3K79/fo78Mc3h4aooqnl4jiPqNfkflxJ7QiNJUMa3K6Xt64ZbkJGvsCWkMrCBtCQ3h/L
	 sVl8Zaw3drPcfssse86LQTcj1PdEKmPkdjardveKVnVS+JCpAhW/dzSkOmLYnWQzu+gbY
	 Kn9zmXMEt/MVafF1ieX/eBFhHyBtXajwIeHtRwdOxRZbbSHOLfLeTh8r6SMNHV9HXRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b="Q/JBmfvY";
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF2606A886;
	Tue, 17 Nov 2026 08:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86CF2606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Q/JBmfvY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4Jaothk9pIoXzn6khKlhOzHzJccnvdvTdTICicAJwj4=; b=Q/JBmfvYble2Erof+KIjVlEQWH
	WHx8qahHtJKFGLW174pzXsTqwioJXsbLwyC0H6/8PobJk2DS0aev1PKga/utBNayesJO0eY+YGU1c
	G4rqVHkcqG+C0lTCf5RQ022GBESPwRUlVyCvRDuB40AeB7d09d4jlp/DqpjLacnmWjXXvudfgxLKV
	Yvs2o5mCFHK7wBsIRN7hcbvrjaLA3dYUATZ32R2RLuGYZA19ORDc/7fJkw4MEg1Nrjw4xPUnWi4kG
	cWUt6bFOQmR22B132HAx5LVG2aaMbWzPieLknw/wwk2aX05gRCymrrJmsSeVCUBkl+yK5dgXuFtQS
	YqZ83Gdg==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:31494 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xTEt2-00000002fyt-1LRX;
	Tue, 17 Nov 2026 09:49:54 +0100
Date: Tue, 17 Nov 2026 09:49:49 +0100
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Mario Limonciello <superm1@kernel.org>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/2] lockdown: Prevent booting with lockdown enabled but
 IOMMU disabled
Message-ID: <avwUNw2if5GIPA11@archlinux>
References: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
 <44ac3423-0a51-4562-816a-fea881511afa@huawei.com>
 <a444421f-178b-49be-98b7-d34dfb147604@kernel.org>
 <avr31i6M5PqKk_Vf@archlinux>
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
Content-Disposition: inline
In-Reply-To: <avr31i6M5PqKk_Vf@archlinux>
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

On Mon, Nov 16, 2026 at 02:29:01PM +0100, Nicolas Bouchinet wrote:
> > 
> > How would you feel about at least blocking the user from turning off IOMMU
> > (if it's present on the system) via the kernel command line while lockdown
> > was enabled?
> > 
> > Thinking about the case where most distros enable lockdown by default, this
> > will strenghten it's use without much downside that I can see.
> > 
> > At least on a properly configured system that contains an IOMMU it would
> > prevent a user from subverting lockdown with a malicious device during the
> > boot sequence.
> 
> I do agree with you, it could be a great addition. With Lockdown enabled
> as an early LSM (CONFIG_SECURITY_LOCKDOWN_LSM_EARLY), this might be
> feasible before boot parameter parsing. Lockdown already locks unsafe
> module parameters.
> 
> If I remember correctly on distro's that have a Lockdown patch that
> enables it if secure boot is enabled, it should also be called before
> early param parsing.
> 
> But taking this threat into account also brings other questions.
> i.e, a physical attacker with root access on a system where Lockdown is
> enabled and with a bootchain configured with shim+MOK is able to change
> kernel cmdline, generate a MOK and sign a compromised kernel
> binary. Thus defeating lockdown purpose.
> 
> In order to take the physical attacker into account, a securely
> configured bootchain where the kernel image can't be tampered with and
> where an attacker is not able to inject it owns certificates/hash in
> db/MOK is mandatory so that Lockdown makes sense.

To be perfectly clear, my intention was not to suggest including a
physical attacker in the Lockdown threat model, but rather to provide
examples of how such an attacker could bypass Lockdown through other
exploitation paths.
