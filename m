Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795808465;
	b=jynA8EdtESCiphk34F46TTprPFLrNm07sAOOQ91VG8uvPhvQgvO/tknblB9QPxne8FSg
	 IjOIHD2gsf4bpgLre12y3Eg6iTnUOJRa8sJ79/2U2sELm2i6UWFx7sVgGMLeeBDkIHXkp
	 khTuZJG+MksILGpS3hfGfE1GxmjQJQd/OlgolyEFK3ZTtDmgIgsRsnZ1M13+QA6V39jgV
	 UKnTCtEMbR273fZ4RkaIpDvp9I0uHFvzJY51oBSrZO41r06hDvr97/UxoG5ea2LhdGeay
	 NRwzdnKvn2ME2lLnajDsm4alPdgPJ+N1nNAdSlWtNxgsyRCIE1HV7v2xRLLfcX9wZsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795808465;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ULn49rq+foRUnRGBMXBuYjS8gpikS5WyQEKWls+yMRA=;
	b=Kws7iS6dBeBT1e/5doXcDLOYn7oTQHBfjEXJiaMRg/enHYEwByyvpdirkveLhtk1Ox3/
	 fGhK1UvcbXXQeGbMUuXSJgSZ9dJp5V1u+qP6QIkUb2RiNQoU/kXBATnTruBMGD2jaxQsZ
	 +IETZ9wUEWjxJ8Y7uLYRLgz/lDzTrNNaTKIUAFldZIlipQMrNbbA4Ft4flM/3oTcy0+5K
	 gfn+U6UKGRmLcjCHvIPdZuCmy2VLvdKB8If3nTVvCsKXjb6Jtj8kK8i0+IXJL+2d6c52/
	 ww8ufJysoktZH1fUJSWrGqDh0LrNhLqMCz5afmbG1LwYjpRA26Yov8vuHBM1fJ8WjFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lSncp5uC;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A63606A32C;
	Fri, 27 Nov 2026 19:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03A63606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lSncp5uC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DE1D1575;
	Fri, 27 Nov 2026 11:41:01 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 432D53F632;
	Fri, 27 Nov 2026 11:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795808464; bh=fioucID+8fbbj8tWzFHzFZGEV4eCYp3bOFGBcaxc55s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSncp5uCSksq2jem0pQF5wGdzZG7o7CpSitT4QZGqkwrt6CNnmOzoN58im0X0EIRL
	 WpgDd/dGqrL5y414OIyTYa55gA9fzjEksDtUygbJJgVt46+2393rtwIcj9kfxjGrXv
	 PLiwn5Oj7+2c7mutFKeiwqwYxHDE9B/nNcZ8tZpU=
Date: Fri, 27 Nov 2026 19:40:58 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>, thuth@redhat.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 7/8] attestation: providers: introduce CCA Guest
 attestation provider
Message-ID: <awncytx4Nqd8HuNx@e129823.arm.com>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
 <20261127170722.GT246011@ziepe.ca>
 <awnK2c3kMq8p2a_7@e129823.arm.com>
 <20261127183550.GV246011@ziepe.ca>
 <awnV5S703Rgf5sh5@e129823.arm.com>
 <20261127191822.GA1856591@ziepe.ca>
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
In-Reply-To: <20261127191822.GA1856591@ziepe.ca>

On Fri, Nov 27, 2026 at 03:18:22PM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 27, 2026 at 07:11:33PM +0000, Yeoreum Yun wrote:
> > I think the problem is the *max-token-size* could be changed.
> > once the LFA updates the Realm definitely the contents of hash of
> > firmware binary can be changed. this means the token's content could be
> > change including the *max-token-size*.
> 
> I think that is broken, there is no good way to make that work in a
> sane manner.
> 
> LFA must stay under the hard wired max-token-size limit, not try to
> change it while a realm is running. Take this to your spec team.

Yeap. if max-token-size is hard wired. then will not be a problem.
And need to talk them.

Thanks!

> 
> > For this, the RSI host call interface has the way to get LFA eventlog.
> > IOW, after LFA, there will be LFA log is genreated and then for the
> > time of re-attestation, it should deliver the LFA logs together.
> 
> The detached event log is even more reason the token should not ever
> be changed by a LFA.
> 
> > > I saw in your FIRME series a solution to this problem, I think that
> > > would be good to get out on its own and apply it first to RSI as
> > > well. We will have the core RSI stuff, the realm attestation and TSM
> > > driver at a minimum..
> > 
> > Hm,, Does this mean do we need to create two device one for TSM and
> > one for attestation even the functionality same?
> 
> They won't have the same functionality. It will be the same as you had
> with FIRME where there is a driver doing CPU attestation and another
> one (the TSM driver actually) doing link IDE.

Right, I've missed the link IDE.
Yeap. in the next-spin let me make two device for it.

Thanks ;)

-- 
Sincerely,
Yeoreum Yun
