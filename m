Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36CF373BE6
	for <linux-security-module@vger.kernel.org>; Thu,  6 Aug 2026 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038121; cv=none; b=alHrdCLNuxtwtTKWQa/IFZM2brFCdAt9TtX7JXAxbObmQj/PSKUYyF3va0u7Gh+EnPm/Uk+9tEnV20V/V+oDGrUeX6fHRnpKxo29Xr1S3YKVBEDnAJNwKEdFZAVqk7+1Nhi8DJJHRCY2DSsEPljzDoyzyWTX4SMz3vQp5I8VmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038121; c=relaxed/simple;
	bh=GeScITOVtMDf5mf4JANMPiPfpgf0CTwPjLb72QCr7j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIWuCZfiBIumZFmB3jYJtV7siX4ySxulvEHIwnn5RUfu9LCq7otNO7tq9eWRLYxaJd5V8vXlbnH9ooC1dDv7bXGHaWNeTT6gJ/wscd4+rPNojOJr+6EUl5fBEdzccbZKhNNU7MlVWQ2is35UO/gkAGpnSOSJ2EAGy4GOmT7bY9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=KtvCxy04; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="KtvCxy04"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hGF2q426rzcHT;
	Thu,  6 Aug 2026 19:41:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786038115;
	bh=+jZTnzeU9akkNKo9pqMtKVeMpOAZJe4vlDnDBnjbnok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtvCxy04K0imZMmIu1vEDVnCr80R52UFIhbuqOqQwCK14GOZkk0CKdlOtdrb8eGxf
	 NauX+Wf5W6Ps6pJoBwk7QbKWSWqcXYexnJ08iw5i7vqYhC4aEmkwC9uP2074MkJY4i
	 tkgIDhflXCmROQffL0e5x5TuqFOVGGACgbVsauXM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hGF2n6JqWzy72;
	Thu,  6 Aug 2026 19:41:53 +0200 (CEST)
Date: Thu, 6 Aug 2026 19:41:49 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Christian Brauner <brauner@kernel.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/20] landlock: Split struct landlock_domain from
 struct landlock_ruleset
Message-ID: <20260806.rooz1ieJahng@digikod.net>
References: <20260722171159.2776765-1-mic@digikod.net>
 <20260722171159.2776765-4-mic@digikod.net>
 <amEwEUKyCPNUxITb@zenbox>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amEwEUKyCPNUxITb@zenbox>
X-Infomaniak-Routing: alpha

On Wed, Jul 22, 2026 at 05:12:18PM -0400, Justin Suess wrote:
> On Wed, Jul 22, 2026 at 07:11:35PM +0200, Mickaël Salaün wrote:
> > Switch all domain users to the new struct landlock_domain type
> > introduced by a previous commit, eliminating the conflation between
> > mutable rulesets and immutable domains. landlock_merge_ruleset() now
> > returns and allocates a struct landlock_domain, and the merge and
> > inherit helpers move next to it; the former static insert_rule() is
> > exported as landlock_rule_insert() for its new caller across the
> > translation-unit boundary.
> > 
> Seems a little confusing that we have
> 
> landlock_rule_insert()

(the new one)

> 
> and
> 
> landlock_insert_rule()

(the existing one)

> 
> Maybe a rename of one these would be appropriate?

It's indeed confusing...  What about landlock_store_rule()?  I couldn't
find anything better given the already taken names.

> 
> Otherwise looks good :)
> 
> Justin
> > [...]
> 
