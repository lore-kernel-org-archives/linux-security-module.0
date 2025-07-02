Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D492770B
	for <linux-security-module@vger.kernel.org>; Wed,  2 Jul 2025 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751422858; cv=none; b=FJQq9bCC6AD4ouVReZf4E2sFiSZN0cJQ+66g9k5jxbNrXsezjAa4Y3vuofkxp2aL+kb3mZwbwB4HkpZEfpqdlRbAJxpFJ+QYQka/mulIiXTGR7Ye6BBfWUz3ms6wivzIxz3ZdPGpwDduQOlvJ0zvYAJO5SthTAiUsPMX3aM1I7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751422858; c=relaxed/simple;
	bh=aS5nVKZCJKcscBKoJrsMThWCgLMB2LYoq/MhdlRn+SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNkehi5e4ypEJQP/iP3o2vPQT3GE8K4RXvBSjwpQ86b7P9fNspbWPDtAKmal/hCjFqkT6j7DvPzzspNgfr28lheLWjyiszTkIObs2lXAzO0+5AkJvMdlqeDxy3Y6rw4B3bgJdiibRFCg4kSUG0z3wxo6nJskRRDMePqAZq/rsVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 174066CF; Tue,  1 Jul 2025 21:20:48 -0500 (CDT)
Date: Tue, 1 Jul 2025 21:20:48 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	linux-security-module@vger.kernel.org,
	Serge Hallyn <serge@hallyn.com>,
	"Andrew G . Morgan" <morgan@kernel.org>
Subject: Re: [PATCH 1/1] uapi: fix broken link in linux/capability.h
Message-ID: <aGSXgF797s+Oz4C5@mail.hallyn.com>
References: <20250629120301.1702897-2-ariel.otilibili-anieli@eurecom.fr>
 <66376202561209641dad1c8894ec62cb@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66376202561209641dad1c8894ec62cb@paul-moore.com>

On Tue, Jul 01, 2025 at 10:05:45PM -0400, Paul Moore wrote:
> On Jun 29, 2025 Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr> wrote:
> > 
> > The link to the libcap library is outdated:
> > 
> > > $ curl "https://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.6/"
> > >
> > > <html>
> > > <head><title>Index of /pub/linux/libs/security/linux-privs/kernel-2.6/</title></head>
> > > <body>
> > > <h1>Index of /pub/linux/libs/security/linux-privs/kernel-2.6/</h1><hr><pre><a href="../">../</a>
> > > </pre><hr></body>
> > > </html>
> > 
> > Instead, use a link to the libcap2 library:
> > 
> > > $ curl "https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/"
> > >
> > > <html>
> > > <head><title>Index of /pub/linux/libs/security/linux-privs/libcap2/</title></head>
> > > <body>
> > > <h1>Index of /pub/linux/libs/security/linux-privs/libcap2/</h1><hr><pre><a href="../">../</a>
> > > <a href="old/">old/</a>                                               08-Nov-2007 06:34       -
> > > <a href="libcap-2.00.tar.gz">libcap-2.00.tar.gz</a>                                 11-Jan-2014 16:49     37K
> > > <a href="libcap-2.00.tar.sign">libcap-2.00.tar.sign</a>                               11-Jan-2014 16:49     819
> > > [...]
> > > <a href="libcap-2.76.tar.sign">libcap-2.76.tar.sign</a>                               13-Apr-2025 18:20     833
> > > <a href="libcap-2.76.tar.xz">libcap-2.76.tar.xz</a>                                 13-Apr-2025 18:20    195K
> > > <a href="sha256sums.asc">sha256sums.asc</a>                                     13-Apr-2025 18:25     14K
> > > </pre><hr></body>
> > > </html>
> > 
> > As well, give the complete reference of the POSIX compliance.
> > 
> > Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> > Acked-by: Andrew G. Morgan <morgan@kernel.org>
> > ---
> > Cc: Serge Hallyn <serge@hallyn.com>
> > Cc: Andrew G. Morgan <morgan@kernel.org>
> > ---
> >  include/uapi/linux/capability.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> My personal preference would be for a commit description that doesn't
> wrap when running 'git log' on a 80 char wide terminal, but ultimately

Agreed.  Would you mind updating that, and then I'll pull it in?

thanks,
-serge

> that is Serge's call to make.  Otherwise, the updated URL looks good to
> me.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>
> 
> --
> paul-moore.com
