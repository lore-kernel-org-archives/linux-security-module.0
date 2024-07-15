Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559A13D8B1;
	Mon, 15 Jul 2024 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042201; cv=none; b=tVvW3E0KP362b3hGXrDqbHSj/xu9O0ySHDUza8NPaqg1g3Nf5desi6wIr9vxv0WLb6LSyoZuG2+W5MtWhVlMd1YrWV04ph3n4ePZ+W05E2cmWf9IetqhUWoJ10oYp1r59Vq+L1p7icYf1XwbNv16gtwWVJZexxBQMRIcuJE23fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042201; c=relaxed/simple;
	bh=MifBY0FmxRHX77tlDpC7n/Xo4IYQHsF6KyVfmI6zDW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxbA1iFmuyWFaeCUk/Y8PVTo7OSI9wguaFm6EUpSgZiTn2QEZJa3mpq64lHRmzP7TBoXotdgB4XLBnuD5iSBm8AiYGwqJvGRwm7y5doKTDO7+i4r6a3rvdpmNv3tr8UlvaMjGMNlRpSqmzxz4+0sVK1CvRBsokJaEmKa0ZAGjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vun2snxF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vun2snxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93329C32782;
	Mon, 15 Jul 2024 11:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721042201;
	bh=MifBY0FmxRHX77tlDpC7n/Xo4IYQHsF6KyVfmI6zDW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vun2snxFE85Zuzs+eUY80ftaet/uz7cSJVQpmovv3Oy14IeRFFbnmVRaOLOfjtW8H
	 MZ65IIe3CUQXDSLitUDrGSRcPVXgEMKU/BBf2eXR1crgcUuGefZYCukbccP9l7Y6Mg
	 6J54lIkOf7/26UXpbLw5DmXTmJoktZn2s1VlyxOw=
Date: Mon, 15 Jul 2024 13:16:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: Re: CVE-2024-40938: landlock: Fix d_parent walk
Message-ID: <2024071553-yippee-broadways-8035@gregkh>
References: <2024071218-CVE-2024-40938-1619@gregkh>
 <20240715.aeLiunipi8ia@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715.aeLiunipi8ia@digikod.net>

On Mon, Jul 15, 2024 at 12:37:53PM +0200, Mickaël Salaün wrote:
> Hello,
> 
> AFAIK, commit 88da52ccd66e ("landlock: Fix d_parent walk") doesn't fix a
> security issue but an unexpected case.  The triggered WARN_ON_ONCE() is
> just a canary, and this case was correctly handled with defensive
> programming and didn't allow to bypass the security policy nor to harm
> the kernel.  However, this fix should indeed be backported.

If a WARN_ON() is hit, a machine with panic_on_warn enabled will reboot,
hence if there is any way that userspace can hit this, it needs to be
issued a CVE, sorry.

> Could you please Cc me for future CVE related to my changes or to
> Landlock?  For kernel CVEs, I think it would be good to Cc at least
> maintainers, reviewers, authors, and committers for the related commits.

I suggest setting up lei to watch the linux-cve-announce mailing list if
you wish to do this (just filter for landlock stuff).  Automatically
mailing cve stuff to maintainers has been deemed too "noisy" which is
why we do not do this by default.

thanks,

greg k-h
