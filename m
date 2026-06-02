Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798831DF261;
	Tue,  2 Jun 2026 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405002; cv=none; b=B7lJSkNXHnWDfVgpgYPbVCooP3V9a1cAFdPtgFLV2JjnFGATU6InawTG8gWElErBbiEQnzN22rKelp7OS622iADLg1nkhMg7qZTFpvDbS61Q01fUmMzFocpA9wUhlfGRdgB8m/ZaQKmic8boBaJaWey2B7X57uLg2Acu6WZucfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405002; c=relaxed/simple;
	bh=7wsYf/7D0u8ESNWFSm2ElY1xmc2anZep4nrGURpBEUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLRyrq30agr0Xumb55cTighbEUPibFqrUjMehmTBPRcQL+l4TU2GyRtgNTq++HFX6fLzZVW4AJOkYyvoQISvksDMobfIa2DszO9g7kvUgyYAKFYB9NM2vcH+OSeL+f198R2lxCUATg+CexrmQr9jmf2tSFVMetYURsdcyd+N3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=htxJfVbJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="htxJfVbJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B00DC22EA;
	Tue,  2 Jun 2026 05:56:33 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED8A83F632;
	Tue,  2 Jun 2026 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780404998; bh=7wsYf/7D0u8ESNWFSm2ElY1xmc2anZep4nrGURpBEUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htxJfVbJ7vzwG2Tsi7weAl+dU96bkd/rUkHnIGsVplMEo+ak+SDa4OzYNmKbxyw72
	 oa84ZU9QzXVjKLR1wHMnXeEuleGZHDefl0UYtA10NnHzCPb0KJ1BJo7WpLegDN6LS0
	 vnYNeXtCe1EyDgrMr08gXz+BX8/SOXq31kzoBOGI=
Date: Tue, 2 Jun 2026 13:56:34 +0100
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
Message-ID: <ah7TAk3iItltddzT@e129823.arm.com>
References: <20260601142749.3379697-1-yeoreum.yun@arm.com>
 <20260601142749.3379697-5-yeoreum.yun@arm.com>
 <ah5AD69RNBdE1BvO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah5AD69RNBdE1BvO@kernel.org>

> On Mon, Jun 01, 2026 at 03:27:49PM +0100, Yeoreum Yun wrote:
> > commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's build_in")
> > probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.
> > 
> > However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
> > initialises IMA at the late_initcall_sync level, so this change is no
> > longer required.
> > 
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Might be rb tag?. Thanks!

-- 
Sincerely,
Yeoreum Yun
