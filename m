Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E98DDA1;
	Mon, 15 Jul 2024 20:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074631; cv=none; b=MLCxs0FbVq5iqmhllLuemAGS19GBsGywc0kBrYvL9QWWch0jg0nDZF1bE4f2X15ToC01AsITtu1k/3Ui49KnrzMh1w3czYvZ6Urse0N9pqerRpqGpjU0ObwGOICeTNMv+bFfOMENb8pQFkPm4d5ufBYIymyEJdR/Jo7hCLPykaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074631; c=relaxed/simple;
	bh=u4CBicVIxv+PSUGttOmE6Lq10Q/gOlrxdZWrIQ1BZ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxmgIVqi5v9w2+jPEZtRcs6y5z2bW58PiNzwzfb0miNMqgw35PY1GwRFvYTy/kU1sm/nrE+GoSyjocKEEz3bd3xuhjsBTOFM58uRwr2/hhZJujjr2zBs/iu4wOToSGEQ/Nog8wNSN2gTYP2QUVADTBCRqwoM/tB1rJLLCxuuGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev0POS+c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev0POS+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3373C4AF0A;
	Mon, 15 Jul 2024 20:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721074630;
	bh=u4CBicVIxv+PSUGttOmE6Lq10Q/gOlrxdZWrIQ1BZ/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ev0POS+cb6T+v69oFbgyIU2UyBW6JdrsoL1vljNELtWhrIDfc8mF/GpyG+t73cx4K
	 eE/ueSgtwYJ/C7GbSSGCmxv9tgFL/aQEI5a2f95xVRcZSbGpgBjxTYqhGUtE1m5uq2
	 Nt098ptMtk1vC160JfAB2VLKWyOugOb1JF0nJohK6FP8fLGejKScMedhnJPyupoQc/
	 CamRX6GXv5lc6BTDrSBJHzB4pgJh6fHaPgC+PCWfdVW5SJJMH1g59YSOC+L5cIKPc/
	 ZSj9lFixWK+tk3K65axoLYmdw9ZN2BHp/s/U5l51Sb5/eTNNpJug4FQfrcVavT8CTx
	 JTU6wg1SrtbXw==
Date: Mon, 15 Jul 2024 13:17:10 -0700
From: Kees Cook <kees@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: CVE-2024-40938: landlock: Fix d_parent walk
Message-ID: <202407151315.88BE0662@keescook>
References: <2024071218-CVE-2024-40938-1619@gregkh>
 <20240715.aeLiunipi8ia@digikod.net>
 <2024071553-yippee-broadways-8035@gregkh>
 <20240715.Eishohd0ehoo@digikod.net>
 <202407150908.34E00AAD1@keescook>
 <20240715.seingevie9Ph@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715.seingevie9Ph@digikod.net>

On Mon, Jul 15, 2024 at 08:04:21PM +0200, Mickaël Salaün wrote:
> Yes, that's why we use WARN_ON_ONCE() to check cases that should never
> happen (at the time of writting), but in practice it's useful to check
> (with fuzzing) that this assertion is true.  However, if a
> WARN_ON_ONCE() is reached, this doesn't mean that this is a security
> issue, but just an unexpected case that kernel maintainers should be
> notified with to fix it.

I leave CVE determinations to the CNA. :) I think the difficulty here is
with having no way to trivially see which WARN is security sensitive and
which isn't, and since WARNs may panic, all WARNs could be a DoS, and
therefore may be a CVE for some deployment somewhere.

-- 
Kees Cook
