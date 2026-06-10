Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842429DB86
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099295; cv=none; b=QK+8epj6UEzct844J2qqyczp/CtZ5IkkL45IlN/qbdOhwiV/YsEsj48A6aWCdZF+rg+uq/0wYaQVPTQ3M0D09S6o+TKzNVZiEoo1HE1f9lyuGGvjh3m4cduxMqmJk15+A4yEKhIHCKseXV8/3FfQPEQcUgF4wtyEyJ+jDqRlq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099295; c=relaxed/simple;
	bh=m3N407tw9kMBIv0pilx1K4RvnbFKmbNDuYDAmt4GnKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjV3XlRjrNRovPFuydhbkRFH8tLByeVo64ufrkEZrdGHMWka0zkBikKGrOhJvw5eivY+YsCKZjvvRv/EdqkxiOuVRIb1foHqgCLg316QCD0wmZr4LBqaznIny5WVe4Insoi2Lzx4n0ioOQPfqTYEwuC6FcBcJx6ddL1XW/6um0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=aZ51YD+9; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="aZ51YD+9"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gb6YK1vs0zXjS;
	Wed, 10 Jun 2026 15:48:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781099285;
	bh=Umw3fE6uEs5ZvknbkVql+MwPmeYNXBcUdyWXVBrk8X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZ51YD+9pkEI6przbKjPLssulAG9/eVg7kFJCUaBJjMks40XJEYX6i29upKr7C/qj
	 jFSNX5UVYXxlGb4/MjCL9vwj963p/Kn9hCRT6bvvJZ312YYB6yCPlm3Yc8utU59lcT
	 9lNVqRahSlwYBJpoEHL/BEOC6TbpgCha9voGCEQM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gb6YJ1jRlzY1R;
	Wed, 10 Jun 2026 15:48:04 +0200 (CEST)
Date: Wed, 10 Jun 2026 15:48:03 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Tingmao Wang <m@maowtm.org>, konstantin.meskhidze@huawei.com, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/2] landlock: replace __sk_common struct sock field
 accesses
Message-ID: <20260610.zui1EiWaKahb@digikod.net>
References: <e561a8c3-de10-45ba-a931-27b9a5751dc9@buffet.re>
 <20260609211511.85630-1-matthieu@buffet.re>
 <20260609211511.85630-2-matthieu@buffet.re>
 <20260610.rai6icahch2L@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610.rai6icahch2L@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Jun 10, 2026 at 03:41:06PM +0200, Mickaël Salaün wrote:
> Thanks for the fixes, but can you please send a full v5 patch series?

Ok, these are not part of the UDP patch series, but this part of the
same thread, my bad...  I'll pick them, thanks!

> 
> On Tue, Jun 09, 2026 at 11:15:11PM +0200, Matthieu Buffet wrote:
> > Use the proper macro to access __sk_common.skc_family like everywhere
> > else.
> > 
> > Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> > ---
> >  security/landlock/net.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/security/landlock/net.c b/security/landlock/net.c
> > index 111e58fd9325..fc2acf8bd898 100644
> > --- a/security/landlock/net.c
> > +++ b/security/landlock/net.c
> > @@ -71,7 +71,7 @@ static int current_check_access_socket(struct socket *const sock,
> >  	 * The socket is not locked, so sk_family can change concurrently
> >  	 * due to e.g. setsockopt(IPV6_ADDRFORM).
> >  	 */
> > -	sock_family = READ_ONCE(sock->sk->__sk_common.skc_family);
> > +	sock_family = READ_ONCE(sock->sk->sk_family);
> >  
> >  	switch (address->sa_family) {
> >  	case AF_UNSPEC:
> > -- 
> > 2.47.3
> > 
> > 
