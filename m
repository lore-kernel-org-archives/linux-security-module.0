Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E311C8604
	for <linux-security-module@vger.kernel.org>; Mon, 19 May 2025 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747684040; cv=none; b=uVKkbcXt/Q5p4nlKar8mjGAwPsJVoxaCsFP8ddXVrxBp27kzMJ8ZzhAlGha6WERoYgrrziUfLNmpouMPDuVMhh8HoUfPF8Xy/WhAB1O0Q4K+LvyjdwOYazSyJrnJdFVXcrWdyH5tUNBnsbEW28KhJmsC7oghg0KAYUZAWmAxYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747684040; c=relaxed/simple;
	bh=kOL0MCAdn1nJGpbhN364DDGzuobCcGyCACHnk5le9ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJO5Rv9nEjtFsubMnqo0cCuAi59YAGfj0hf6QRqqvb1jebRaOJH2/DkojnYjGf4dRxp6KTfnQUbVI42SsuT9/Kv+QCzmUy7oN8trTULxVpgXzq6IeTWaAB3+EVNy4tpQws0Ebrl6xv6K/XDu+I6P39y1YlrgSZXdZYOlOydvRnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZVJEgHKj; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZVJEgHKj"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b1QrL1XPQzvbc;
	Mon, 19 May 2025 20:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1747678626;
	bh=o0H4N/bdp3J6R7Xxv5HUPBp/AKsmuH3GhzDoLlaY008=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVJEgHKjpkLSvZSPlxtaAug59+FrJc2zR6Zj90yUP0moQ1SUF0PS+WKhi7pq7IGIi
	 ftO+xgSWDykYC6gOxovXZ/5oXvfC2JWxipc2brVySX/ACuN2FkGOPrj/rTw9qboWxf
	 Ozz2AwB4cKkaISEybkaXPPXDWhpuEFnRNSRldu1Q=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4b1QrH5tK6znCQ;
	Mon, 19 May 2025 20:17:03 +0200 (CEST)
Date: Mon, 19 May 2025 20:17:01 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Zygmunt Krynicki <me@zygoon.pl>
Cc: landlock@lists.linux.dev, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Ryan Sullivan <rysulliv@redhat.com>, lwn@lwn.net, 
	linux-security-module@vger.kernel.org, oss-security@lists.openwall.com
Subject: Re: Landlock news #5
Message-ID: <20250519.queejoh3Phei@digikod.net>
References: <20250519.ceihohf6a3uT@digikod.net>
 <dc6aa0e2-5a82-4b00-82b2-b38fffb33167@zygoon.pl>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc6aa0e2-5a82-4b00-82b2-b38fffb33167@zygoon.pl>
X-Infomaniak-Routing: alpha

On Mon, May 19, 2025 at 05:20:19PM +0200, Zygmunt Krynicki wrote:
> 
> 
> W dniu 19.05.2025 o 16:30, Mickaël Salaün pisze:
> > Official website:https://landlock.io
> > Previews newsletter:
> > https://lore.kernel.org/landlock/20240716.yui4Iezai8ae@digikod.net/
> 
> This points to the 4th newsletter, is that expected?

Yes, that's the previous newsletter. :)

> 
> Best regards
> ZK
> 
