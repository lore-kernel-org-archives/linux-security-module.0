Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572B948165E;
	Thu,  1 Oct 2026 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872770; cv=none; b=fMcdLP+7BQVd9y7LjsaEtDHwGInFYHhqG4Sqri6Ibc8YiUCq2dE6JsuEi3dFnqlHPD5W3gBbA8fffuxnxDqogvDW5GJEzP8qNXnP0iNtxAcS0SoLDeXfTt5mrQMyYbRrPhD3IFhzP4zmgSGP85vfakJqQQ+4MV6UbKc1cj3Lvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872770; c=relaxed/simple;
	bh=q4SvOgTXIsNqlpMUOj2ef8MMWb7VA7YCONSmXTiArQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiCTTtZ0GxFj6df8kdSDWN8Cz3KFfuKIjc/lHSOfrKz6xgYQIOfGATxe1eMvZvAOJThfT+3NZWH1XuaZ5jjYfriC0r2IRTFWOjGlEybMdpSUiIHaJ9m/JERyu1eE2h1qcz2owWNLV43T3CbcaE/Ep+cqcsXyLfLtmldi/JBdMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=thPgHjGq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="thPgHjGq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE5E9497;
	Thu,  1 Oct 2026 09:39:22 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2E613F85F;
	Thu,  1 Oct 2026 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790872766; bh=q4SvOgTXIsNqlpMUOj2ef8MMWb7VA7YCONSmXTiArQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thPgHjGq4KLCxFCMOxTNwhO46NGyh+WVwgUMuprlxt+Nen4cbvbV1B/AetnyZ63cI
	 qjGPOelzghxSe5sU3NpQYJCnPiPTWokp39L+895qwgszRoFOfxxUCOOwc2wmQus0+8
	 blikHLD31ZKL4WOfKOE2CFaiphHnqEPP7yfAwj2U=
Date: Thu, 1 Oct 2026 17:39:20 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, gongruiqi1@huawei.com
Subject: Re: [PATCH RFC 0/3] security: ima: support TSM measurement registers
Message-ID: <ar6MuKSDQc9J8o-6@e129823.arm.com>
References: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
 <ebe68f6463f8ece8a5cd8ce70bba292ec4f64a41.camel@huaweicloud.com>
 <c4fe5315d70fc162f1e5648e3fccb1676710d5e6.camel@huaweicloud.com>
 <20261001151801.GC3019323@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001151801.GC3019323@ziepe.ca>

Hi Jason,

> On Thu, Oct 01, 2026 at 01:45:26PM +0200, Roberto Sassu wrote:
> > On Thu, 2026-10-01 at 13:27 +0200, Roberto Sassu wrote:
> > > On Wed, 2026-09-30 at 14:43 +0100, Yeoreum Yun wrote:
> > > > Confidential computing guests without a TPM can use TSM measurement
> > > > registers to record IMA measurement digests instead of TPM PCRs.
> > 
> > + Gong Ruiqi, of course.
> 
> We are working very seriously on this same problem too.
> 
> For some time we did investigate extending tsm_mr to do more things,
> have a better uAPI, but that eventually evolved into the realization
> that tsm_mr is simply too narrowly focused. It looks like James got to
> this idea before we did. I agree with his remarks in the 2025 thread
> with Gong.
> 
> So we've started work on a new comprehensive "Attestation subsytem"
> that will pull in all forms of ROTs, TPM, CC stuff and SPDM use cases
> to give a consistent user API to work with this class of HW. In many
> ways I view this as a rename of tsm_mr (it will eventually fully
> absorb it), but the name evokes the broader goal and encourages
> everyone to come in, not just CC world.
> 
> Our overall goal would be for something like systemd to have a single
> uniform kernel API that allows it interwork with any ROT someone may
> have. A uAPI to do "Extend", "Quote", "Get Log" operations so that the
> existing TPM support in systemd can be improved to work on any ROT
> flexibly without having to hard code specific ROT behaviors into
> systemd.
> 
> I've felt the ultimate end goal would be to make all the in-kernel tpm
> users go through the proposed attestation subsystem so they can have
> ROT and "PCR profile" agility. Certainly I've heard enough people
> asking for this.
> 
> This is a broader topic than just IMA. For example DRTM also has to
> use the TPM, and other ROTs. It also brings in a global shift of how
> the system wide "PCR Profile" should work as post-DRTM has a different
> TPM locality and access to the protected DRTM-only PCRs that are
> normally blocked.
> 
> Jiri posted his current state here:
>   https://lore.kernel.org/r/arzr32ZDComnfmny@FV6GYCPJ69

Thanks to let me know. I'll take a look for this.

-- 
Sincerely,
Yeoreum Yun
