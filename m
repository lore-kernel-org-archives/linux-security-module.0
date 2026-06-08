Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911F168BD;
	Mon,  8 Jun 2026 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780891300; cv=none; b=q+lSB5WvcYogi4bJ8JdQcO9uWa//RMDAf90FD9h36mcyP0aoTFNnBZnx53Wnhxs+/nVkJuqypD9WGF4ckKlQLjWuSO4naPK6I6P1eMawum2Wm2wEDrSzxuaDxXYGkzHHSZaLM2NEvx/IpWGAW6NHMXNL/ifCwN+6pACuj/QdL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780891300; c=relaxed/simple;
	bh=RaLnUnhwbfFEjvT/vf9CjJ+x30/U7OhK+WtQuIcKdwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6lFp6fKQ0Bbr7AtPnVdMlUlASZjmCAaYkxm+o7RUQirXoZlKpbJnJZPVI4G91N64oj+ljRdEvb68nM0ko2oe4ztnnq5iBNAtJfOKiyO6kndjb1ORLcYEYm7E5AMDrWZbrTyC/FkID13WOXufHauHmrX/2MZY44vEHNd0dK3+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM84IcI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM84IcI/"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3CCB01F00893;
	Mon,  8 Jun 2026 04:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780891298;
	bh=Lvr28qF/drqKhq4fyZYhBGe9uFTF2BdFmLtuvMB+Q4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fM84IcI/EOI4v3nKftD2Rs9cvyevsMhpsJlaEwfSs5YhZfucAm6S8o0zzfI2LVzMY
	 OkLUINhlV6KCosD9E/dBlVmrBw7SWS1oS/VS82D3GIvfLUP0zJT4xuz/13gu9xBapP
	 qJ0XbUBYQzqEGk3Mnhfo+bN7CQnLMRnXz5Xz3yFinNyrVPIZgjNkkufsehOycV06RQ
	 MWo8XtaaoII0Q1rvtjCsVlVzhMAgxZsC+VonWpJlDC99LJDaBS3BUQ2uHpSswQVBE/
	 tAndm7gf8Ggs+GUpBPg+XWnaoUdtTZypo7/FZhImkyYQwRoedQY7N5IECNAuoTQ4va
	 6/y2I0v253NcQ==
Date: Mon, 8 Jun 2026 07:01:34 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, sudeep.holla@kernel.org, jmorris@namei.org,
	serge@hallyn.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v5 4/4] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <aiY-nvx96uQtJOxP@kernel.org>
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

On Tue, Jun 02, 2026 at 01:56:34PM +0100, Yeoreum Yun wrote:
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
> 
> -- 
> Sincerely,
> Yeoreum Yun

SOB is enough information as it is a small change. I pushed it to
for-next-tpm.

BR, Jarkko
