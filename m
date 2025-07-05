Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0235972
	for <linux-security-module@vger.kernel.org>; Sat,  5 Jul 2025 00:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751675105; cv=none; b=jjh+m6nboQDo9plOsriqAF4dt8smYEHaEX4MmR1DHfEXwlAwpiYfzgINedFN6yJKPav95MA4KMrzVvLe6hee3FWiXYM7hoVjmtPxnSWb84JZTBORUlBFzucHCTvUgXK4Bx/sRbzfImp8m0hfvhTdfyQBPSxOHgQhmxECVZzGSE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751675105; c=relaxed/simple;
	bh=JqkyfkKeSDyj510CqGvRxJHBsr4iRlmQFI5mtQuBP8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLdsbsVFszUMddpeiLDCwCjkWUOs1GrKCwhbrkraufDSso2kzNLk16bq1Jh3P/kGagCtU2yDfa2BLD/5+AXqnC6Frk/iBiILCwS8DM3iO6o9Yo02WS9pUnhLp4uBqJsqbq6xSvDFYBJKREdTQcrfiY2DIa6kx0OWTVQMq2c19vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOKRVo+B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOKRVo+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B63EC4CEE3;
	Sat,  5 Jul 2025 00:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751675104;
	bh=JqkyfkKeSDyj510CqGvRxJHBsr4iRlmQFI5mtQuBP8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOKRVo+Bk420ozXAcqlzxllpy4F4ZcLv2Sc1eJ55w53xm2Ux6p3bui9ACNmtJpWlI
	 R5f4Rdh0J4n0jg8dDVaQDrKC0x92JY2ttwj19tnAa/yu4IcuMgH9xMSCa2WwR5k4Ds
	 8Z3N0E1HAnFhY2Y7jztryGdBm+ViE3Q72grTaFfXugj69Dkd+xoM/Nffp5/3Sfc5MS
	 /loGKHGhrGMKttwDfzWRCpeFleqHLXdsthI7jvzCELpHK8MGDf2LQ5qsRpVE6+WKPA
	 05l6Ahwxya48Q9IXKe1VDBR4rw5s6yFurEUs2Zec0v+5jEbyUS2S9I3FluJ28BmO6x
	 8/FO7qZedvk2w==
Date: Sat, 5 Jul 2025 00:25:00 +0000
From: sergeh@kernel.org
To: Ariel Otilibili-Anieli <Ariel.Otilibili-Anieli@eurecom.fr>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	"Andrew G . Morgan" <morgan@kernel.org>
Subject: Re: [PATCH 1/1] uapi: fix broken link in linux/capability.h
Message-ID: <aGhw3P94nyNpuwCU@lei>
References: <20250629120301.1702897-2-ariel.otilibili-anieli@eurecom.fr>
 <66376202561209641dad1c8894ec62cb@paul-moore.com>
 <aGSXgF797s+Oz4C5@mail.hallyn.com>
 <1ad13b-68650480-81f-51fddb80@179270172>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad13b-68650480-81f-51fddb80@179270172>

On Wed, Jul 02, 2025 at 12:05:36PM +0200, Ariel Otilibili-Anieli wrote:
> Hi Serge, hi Paul,
> 
> On Wednesday, July 02, 2025 04:20 CEST, "Serge E. Hallyn" <serge@hallyn.com> wrote:
> 
> > On Tue, Jul 01, 2025 at 10:05:45PM -0400, Paul Moore wrote:
> > > On Jun 29, 2025 Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr> wrote:
> > > > Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> > > > Acked-by: Andrew G. Morgan <morgan@kernel.org>
> > > 
> > > My personal preference would be for a commit description that doesn't
> > > wrap when running 'git log' on a 80 char wide terminal, but ultimately
> > 
> > Agreed.  Would you mind updating that, and then I'll pull it in?
> 
> Sure, there you are: https://lore.kernel.org/all/20250702100021.1849243-2-ariel.otilibili-anieli@eurecom.fr/
> > 
> > thanks,
> > -serge
> > 
> > > that is Serge's call to make.  Otherwise, the updated URL looks good to
> > > me.
> > > 
> > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> 
> Thanks for your feedback,
> Ariel

Thanks - applied.

-serge
