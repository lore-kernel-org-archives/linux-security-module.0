Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAF8EC4
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 04:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732248786; cv=none; b=BupIshGAJZ0/hlAD5EGjQ0bL5e9Ggqw0sCwyhlkIlAfSL75h8BdxEJGOOv7BAbFngLBdFmVd3DfSsXhetITCRD8ltaNRu3tdfn/OgNLbyLviUJOsimJBqEQmPkPWT7qIqlk9eHzcrNTOA697jWFR/c96eeJ+eVT9GYFpeobtIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732248786; c=relaxed/simple;
	bh=lY9C1lxbNY/2bnsCxRTFsqgYtdsYe8esoSp/fOpIisQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8twuBVvSxqMtp4/SjZrQSbv1MtUC///H5aPLktOhWKvzXfEqubPt8SXc8xs/Yu6dPVONGuUerMKgK6zUBJ56T83dB2I4DkcWGLJwXbLXuW4OZq2Q6SpGTcliPKFPH4kCcoX131/Se4R9rvqXzFOEbdayyNqthnc1ys0zNQ0b/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 4AM4Casj014695;
	Thu, 21 Nov 2024 22:12:36 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 4AM4CYGX014694;
	Thu, 21 Nov 2024 22:12:34 -0600
Date: Thu, 21 Nov 2024 22:12:34 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-security-module@vger.kernel.org
Subject: Re: TOMOYO and runc containers dislike one another.
Message-ID: <20241122041234.GA14684@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20241121184207.GA11007@wind.enjellic.com> <ad1b3db0-b5b5-40c4-9a44-ce11195cd1b5@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad1b3db0-b5b5-40c4-9a44-ce11195cd1b5@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 21 Nov 2024 22:12:36 -0600 (CST)

On Fri, Nov 22, 2024 at 08:22:07AM +0900, Tetsuo Handa wrote:

> Hello.

Hi Tetsuo, I hope this note finds the week ending well for you.

> On 2024/11/22 3:42, Dr. Greg wrote:
> > Kernel version is 6.10 something.
> > 
> > The path causing the issue is as follows:
> > 
> > /dev/fd/7
> > 
> > Here are the warning messages that runc spits out:
> > 
> > FATA[0000] nsexec[1291]: could not ensure we are a cloned binary: No
> > such file or directory
> > 
> > ERRO[0000] runc run failed: unable to start container process: waiting
> > for init preliminary setup: read init-p: connection reset by peer

> Please try applying commit ada1986d0797 ("tomoyo: fallback to realpath
> if symlink's pathname does not exist").

Yes, that did it, thanks for the pointer to the patch.

We now have multiple containers running, each with their own Tomoyo
implementation.... :-)

> Regards.

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

