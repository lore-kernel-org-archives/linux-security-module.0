Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1717575
	for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097168; cv=none; b=NcWTijh2HxYAgkjoCa1SVq1FHebY9wiO9eY8z436/LjHUcwiLAC6MOz6MGlS2noX0Iu2+IC4/fEBYmq/ju2GZz1tfaA7pv4P6XkbO6suLgHodqTlFE8lWksv6WEmB3hZPAuDyTjFeu9y8pfh0QIQe1zcx4TFUrhhkj5MoCZ44Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097168; c=relaxed/simple;
	bh=wGm/t/mCjxAw4AuNU9eHa6Zd/KMKX6mIeCQjtHY/xNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXdJQBNgc0RmR/vBOilXqYSk2AfxXAoPp3fgZKdlMcslmKjIwlMKdmb4F4Uw2I6mGL2oEnuNOMebaoynsaFeHiQQK7mXikaQ3qdpHK+f9Lh3CbW0h0S03vKuWkQ3BpMW5zF9zyDoYYLHEs7XSv6mOXY2vFwqO8N/nADcTiL1BG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=gtOoYDBx; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gtOoYDBx"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V1GBW0j31zBrB;
	Fri, 22 Mar 2024 09:45:55 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4V1GBV0zGZzMpqtk;
	Fri, 22 Mar 2024 09:45:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711097154;
	bh=wGm/t/mCjxAw4AuNU9eHa6Zd/KMKX6mIeCQjtHY/xNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtOoYDBxW5wtCAhKQ6Be4iJSWu2a/QHadnraelKJs6Zv0hp6azoRu+u+d71KqHLDj
	 LuyHhZl72+yBSJ0ZZLN12DQzySntDajTBDz6tL0UsvbHcGmhP9PcekJ82aV1+hGPG6
	 XLMB5cmwK9wYgXvTFS44eiz4HaoljYPtmTcmk7VM=
Date: Fri, 22 Mar 2024 09:45:53 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10 6/9] selftests/landlock: Test IOCTLs on named pipes
Message-ID: <20240322.ohyu9Aithura@digikod.net>
References: <20240309075320.160128-1-gnoack@google.com>
 <20240309075320.160128-7-gnoack@google.com>
 <20240322.axashie2ooJ1@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322.axashie2ooJ1@digikod.net>
X-Infomaniak-Routing: alpha

On Fri, Mar 22, 2024 at 08:48:30AM +0100, Mickaël Salaün wrote:
> It might be interesting to create a layout with one file of each type
> and use that for the IOCTL tests.

To make sure we only restrict the first layer of IOCTL (handled by the
VFS) we should check that an IOCTL command that should be handled by a
specific filesystem is indeed passed through this filesystem and not
blocked by Landlock.  Because Landlock would return EACCES, I guess it
should be enough to check that we get a ENOTTY for non-block/char
devices.  We should find an IOCTL command number that has little chance
to be taken to avoid updating this test too often.
