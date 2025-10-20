Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4981E492A
	for <linux-security-module@vger.kernel.org>; Mon, 20 Oct 2025 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992651; cv=none; b=cYlgG/dkIBfwZ1OgBtseNwxZB514ktR8XvZu20O60L7BzvfIfPaixr27OCyhQ9McP/6NRlyYPG+CrSlX7xikE8fJcf3RwlhMyL6Zrx8qJr6DrFy689aQS8wSGKYQ+4ysdvuJxszbW5SfF1n79PAci4tGOuT2zUj0GdtOWKAYQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992651; c=relaxed/simple;
	bh=+WKmm8u4jlzwsKZN/go5dqD4dMHoNS59XrqqGfdzpwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwNOB/8WPU2mbfuf6KwJO5Oburmlyb0ahbcjom0PxxMCFR4oCStt3pB09TbsjH33Spl6imP+G2eg74ras+8UnW1QU4cH3wdG+6Ttq97rarOIOYVTDByfbDSmBqe3snGzLbg4iNMUJnZDzV8ylpjbJkeLwN2PdrTyZYHRn9Qmsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=H0LsgaY/; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="H0LsgaY/"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cr66N3tgxzZbk;
	Mon, 20 Oct 2025 22:12:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1760991148;
	bh=Pugd6RzrkL/V2H4BAg5r+nT4TY+kGAvOxY6UahNsWwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0LsgaY/+9YKSkI1eNYbnz1nuJyqkRtdu9R1iXQq8UFi/2RcAEcetgN24zxFMd4od
	 l+GXDWbQwt0Q8ojBmUpjbHLEE77HzxRZrtTtI+mXewi2VVNiO9T8nRSGyF5dzViZe+
	 BHB0mU4/T5AFlN8vx0OVeXOW7BcLlDOva2tFlXcs=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cr66N0RG9zRMg;
	Mon, 20 Oct 2025 22:12:28 +0200 (CEST)
Date: Mon, 20 Oct 2025 22:12:27 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/6] landlock/audit: Check for quiet flag in
 landlock_log_denial
Message-ID: <20251020.que5Chod1ooC@digikod.net>
References: <cover.1759686613.git.m@maowtm.org>
 <730434d416100f6a72b12fb31eb7253bc8b6fcc0.1759686613.git.m@maowtm.org>
 <20251015.Iengoh1eeT0c@digikod.net>
 <b44db371-59b5-4e52-bdb2-f6359580a0df@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b44db371-59b5-4e52-bdb2-f6359580a0df@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Oct 19, 2025 at 06:39:55PM +0100, Tingmao Wang wrote:
> On 10/15/25 20:09, Mickaël Salaün wrote:
> > Just use "landlock: " as subject prefix.
> 
> What about samples/landlock or selftests/landlock (in the next version)?
> Should they also just be landlock: ?

No, those are good.  The idea is that these three prefixes identify
Landlock-related code (and potential different/complementary
maintainers) in different places.  It's not useful to identify part of
Landlock inside one file hierarchy.  In doubt, just follow the same
pattern as in previous commits:

- samples/landlock: Files in samples/landlock/

- selftests/landlock: Files in tools/testing/selftests/landlock/

- landlock: Files in security/landlock/, Documentation/*/landlock.rst,
            and Landlock catchall.
