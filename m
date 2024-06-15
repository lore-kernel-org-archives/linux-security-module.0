Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273184779F
	for <linux-security-module@vger.kernel.org>; Sat, 15 Jun 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718464113; cv=none; b=WcLoowyKVdCpm6mYhoWFh3a6v8a1QhaZl92aKzeDtQehBcUsxzqQkYRoNA0pPCg3hEXfX43HVCJrZlogHwidnb/XMiG9axaghGfSO2KCq5voO4KkzzgzZQpA7bJ6mFQHdxClXVTAQTKTdwzj6a2t79eQ9MXPwgkEmnwJ6XCDyq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718464113; c=relaxed/simple;
	bh=mEAUaSYtM704GXb+Tw47BKuFbkXvOoIG6okmdn5DaBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1nSYWfywUnGTpPCCeDNlsmAoChAoyAcWPWFxci2H1hOTWwGpHOK4BMRnkrrv6FpFocKOUa60qOv6m2e0vbI7AVjmJgTYuOJSudyCFRqAYMqZFnL/Ok9IjBP8dwxvIlS+LKhwXGvPLDXgCpkpxHvnbokqKABIi8wrKulfmZJguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Oww9SoUK; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Oww9SoUK"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W1ffS5m60zBWw;
	Sat, 15 Jun 2024 17:08:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1718464096;
	bh=ENCJTkUwhZrciw6pMkqaNCXvUNNHoTFHBqvd1gf3+Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oww9SoUKNKcqh6Lh1sDox3xTjO2p8/06yrUpg5PPiN9FM8/0Oj2ZAkTJ8GH/yNvyy
	 AuWX4KyMGsLR+SKVGNGOUxzOxDPrNWh86H6qC96mq6lPDQGdl5+KTpVqXpwR+/XZSJ
	 uPnxZcn++8b8u1Wk0r5bd7Zwrs61sUhly0EbwK/w=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4W1ffS1WMWz4V2;
	Sat, 15 Jun 2024 17:08:16 +0200 (CEST)
Date: Sat, 15 Jun 2024 17:08:12 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH] landlock: Use bit-fields for storing handled layer
 access masks
Message-ID: <20240615.ahch5wah7OY4@digikod.net>
References: <ZmazTKVNlsH3crwP@google.com>
 <20240610082115.1693267-1-gnoack@google.com>
 <20240613.chiec1EeThe3@digikod.net>
 <ZmwyXoItby7LDd6k@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmwyXoItby7LDd6k@google.com>
X-Infomaniak-Routing: alpha

On Fri, Jun 14, 2024 at 02:06:54PM +0200, Günther Noack wrote:
> On Thu, Jun 13, 2024 at 11:20:38PM +0200, Mickaël Salaün wrote:
> > Great!  Looking at the generated data structures with pahole, it doesn't
> > increase the whole size, and it should be fine with other (small) fields
> > too.
> > 
> > With this new struct, we don't need the landlock_get_* helpers anymore.
> > We might want to keep the landlock_add_*() helpers as safeguards
> > (because of the WARN_ON_ONCE) though.
> 
> I am unsure about removing these helper functions, due to the following reasons:
> 
>  * landlock_get_fs_access_mask is the place where we transparently add the
>    "refer" access right.  If we remove landlock_get_net_access_mask, it would be
>    assymetric with keeping the same function for the file system restrictions.
> 
>  * landlock_init_layer_masks() is using landlock_get_fs_access_mask and
>    landlock_get_net_access_mask through a function pointer.  When these
>    functions are gone, we would have to redefine them locally anyway.
> 
>    Options to refactor this function include:
>     * split it in two separate functions landlock_init_fs_layer_masks and
>       landlock_init_net_layer_masks.  It would end up duplicating some of the
>       bit manipulation code.
>     * add another #if further down in the function
> 
>    Both variants seem not nice.
> 
> Do you think this is worth doing?

No, I agree with you.  It's applied to my next branch. Thanks!

Mikhail, Tahera, please base your next patch series on this branch:
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/
