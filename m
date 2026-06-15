Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11114405C42
	for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537863; cv=none; b=dpgxEyU+w4fLkkRUwg03Q1NqewgwWnbABiCP91Z6RiPhmPkMtBoEilk0mKKyfjr9AmorXhyONCOREKUsL0kkMaBC/xykqydrnBNEZbU2dKf7XaP2yzjdZZ2MbUTRQN/HdM9ycMhQLlRKnA/pvhP58HienVR7i7NGl2jWUNf4ssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537863; c=relaxed/simple;
	bh=MVs6ydmQyV+2JiC6AldWnCkiZDooScRxa9ANNJhFvOM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ozcpC5fkwyXojD7tV2yevu6sWKoZGKS4NvK5qZ6G/FbWp7PfsN33bZQi4oC3qWMb2eqLFAzVZH2Tlfg9yNn+rVWqtedhCWMOQtP4Un/JSO0QrA0Oj+KJRbiZ4sywglpQZPCO0TotNwLiy4CpAiGM9PYzKR7rVZXN4IvTO7Buaos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=epNw6lR1; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="epNw6lR1"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gfDlG2vSTznKp;
	Mon, 15 Jun 2026 17:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781537850;
	bh=iqru0mS2JmyVUk/H/reLzbURxryDJTahjJRy6gpZdOQ=;
	h=Date:From:To:Cc:Subject:From;
	b=epNw6lR1Xmk1zy6rQwol9blZ4AuJap/YegFoiaZZgeF90aVkZGWlEJG5TbAvuja4c
	 MIFbmmWg4+zAZodj2PdoS4nvFbi/2pyRb/sXGMPWOIfMGhrFZuiDzvtasob2yFEs+q
	 uiYHYjCxAj3Sjdx3LvKuo4VrBKZ0I7NogZCgJtFQ=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gfDlF2ZmGzffs;
	Mon, 15 Jun 2026 17:37:29 +0200 (CEST)
Date: Mon, 15 Jun 2026 17:37:24 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: linux-security-module@vger.kernel.org
Cc: sashiko@lists.linux.dev, Roman Gushchin <roman.gushchin@linux.dev>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Subject: Sashiko reviews for the LSM mailing list
Message-ID: <20260615.zeinurej8oZ9@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

I've been reading Sashiko's (AI bot) reviews wrt Landlock patches, and
most of them were valuable.  It found issues (security or not), but it
requires to go to https://sashiko.dev to find them, which is too easy to
forget, and requires additional work from maintainers to copy or point
to these reviews.  I sent a PR (currently in draft) to enable email
replies from Sashiko to the Linux Security Module mailing list (most
patches are already reviewed anyway):
https://github.com/sashiko-dev/sashiko/pull/278

Making such reviews broadly available can improve the quality of patches
we receive without much noise, helping for all LSM-related code.  We can
fine tune some email-related settings if needed.

If there are any concern or question, this is the right time to start a
discussion.

Regards,
 Mickaël
