Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6F83E0730;
	Tue,  2 Jun 2026 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405085; cv=none; b=pFMYiHOHPq8AO/mTutJ2RVAt1HqM0vozg9IXvtaVsaCj9PYdLgy4/IUQ/Q0+++a+bxcyt4tnnil5cj7s78Y7Dxq+GBMS/gIneLmDQjD9Lcpkr9zshXJCeQyzWbAikeqxXVUWy1yIZxSu6HiJUxbpllIaMW6rhQUKclPClBdUd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405085; c=relaxed/simple;
	bh=wmUI05SuEatnASqnxtix94L6uiWkYkABIkEJIXEuLM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWRMAb67am021gLFiPnRUENlFIN8/wuTxVB850GEkpxHXWrokflKt4j0e3KM1nds9JklsmfmfxN8Ka84W4+hk+IOxpFW6oFIb1hE9dn9ohWNoe1VRidLuPZzlEPkOvJn/lF/N7O4JGq/EZWW6TYd+T3fasGn/WcesdgZAmI5Ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZSVY8Snw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZSVY8Snw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E03E169C;
	Tue,  2 Jun 2026 05:57:58 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CC053F632;
	Tue,  2 Jun 2026 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780405083; bh=wmUI05SuEatnASqnxtix94L6uiWkYkABIkEJIXEuLM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSVY8Snw31mpBs4DyX+jZeNKdQv31TO9VvqfhaZTiBMdJe7ikibAhFM0Qj1E4RbsA
	 fHwdSv5qyibjdsSj/2yKW2o/hx7E1ha7Xx9at6FYSS2bKumAF0bLwt9V4pjqPPUcWX
	 g/DGmsoMw2/po5srN1w/PUTwqelpG99x24QZbCq4=
Date: Tue, 2 Jun 2026 13:57:59 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, sudeep.holla@kernel.org, jmorris@namei.org,
	serge@hallyn.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v5 4/4] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <ah7TVybtYa46Df5c@e129823.arm.com>
References: <20260601142749.3379697-1-yeoreum.yun@arm.com>
 <20260601142749.3379697-5-yeoreum.yun@arm.com>
 <ah5AD69RNBdE1BvO@kernel.org>
 <ah7TAk3iItltddzT@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah7TAk3iItltddzT@e129823.arm.com>

> > On Mon, Jun 01, 2026 at 03:27:49PM +0100, Yeoreum Yun wrote:
> > > commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's build_in")
> > > probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.
> > > 
> > > However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
> > > initialises IMA at the late_initcall_sync level, so this change is no
> > > longer required.
> > > 
> > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Might be rb tag?. Thanks!

Ah Sorry. SOB is right thanks!

-- 
Sincerely,
Yeoreum Yun
