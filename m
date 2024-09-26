Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11E156CA
	for <linux-security-module@vger.kernel.org>; Thu, 26 Sep 2024 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356976; cv=none; b=HgA7+XfdkEo6Z6IFYvYD+ng3bJJRUVreZmer947J/1k8eQXPOA6R53D2ZgeH6UhsOKM9eFpnzbON8jIUK87qVpQMbiLVFPgSywVYqqujiSlRQQk5VFntlv2yf/VL3GUxGT58qRnDZsHkpir5LlBxMWnIROaV7hhI8Ka9EcAcNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356976; c=relaxed/simple;
	bh=b/V4ATS4trKJQclhIWM6DhPrVj9wWQoqfmSQkaqvyE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip/2R5WMxwR3xq3luvRZ2h8jC0Kzgz01hYJeyaeQV9RWARBdrsvDcIJEr2LmJq2xmHdy6wx9CleYDBKys1BSFSeuuWgqvlA7qvbeCbknvFD+Gq2w+iAr0xQ8qObcIzRpizW8ikWZb/42bTsnS+EIWMtZK/GczRJMgyU1oB7eJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 8B0F881E; Thu, 26 Sep 2024 08:22:51 -0500 (CDT)
Date: Thu, 26 Sep 2024 08:22:51 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] capabilities: remove cap_mmap_file()
Message-ID: <20240926132251.GB683524@mail.hallyn.com>
References: <20240925192018.15290-2-paul@paul-moore.com>
 <dd386a1f-9245-45ae-b0fe-d07d1dec5100@schaufler-ca.com>
 <20240926131157.GA683524@mail.hallyn.com>
 <CAHC9VhSyYkq=AxiVkwkuk1jsTTCqt9xypdto5yaX3jdLXy+Xxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSyYkq=AxiVkwkuk1jsTTCqt9xypdto5yaX3jdLXy+Xxg@mail.gmail.com>

On Thu, Sep 26, 2024 at 09:16:04AM -0400, Paul Moore wrote:
> On Thu, Sep 26, 2024 at 9:11 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Wed, Sep 25, 2024 at 12:45:20PM -0700, Casey Schaufler wrote:
> > > On 9/25/2024 12:20 PM, Paul Moore wrote:
> > > > The cap_mmap_file() LSM callback returns the default value for the
> > > > security_mmap_file() LSM hook and can be safely removed.
> > > >
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> >
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> 
> Thanks Serge.  Any interest in pulling this via the capabilities tree
> or would you prefer I take this via the LSM tree?

Oh, jinkeys - I guess should take it through the capabilities tree if
only to check that it still works!

thanks,
-serge
