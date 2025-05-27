Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973DE263C8F
	for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357595; cv=none; b=Tm5DSapZjoZS+Xsg0baTcOnK4dKIqtwHWjCqSd6IWN5sVymS2TZgrRz//ZUcEkwNH89M7A15zvdKbo8xaUctp/KDoPW24j3WNQHPLsHvTiz9e1+up1Fv/oDGkcT9V4t/3lsu1b4ljbsUS8E4s1MnXbyxTAdqX+Ktwf+z8c1YuBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357595; c=relaxed/simple;
	bh=ts+DNvC6aCARNi8CCqKGhRgg/uvCbvowAbg/lEdcYKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puMEYM9kVrK94RhvEF8j0KSo9mEQdKdDyBj5FEgiNZD0ksncshphqez6bLj591tbxUZrLkW1UjHOPCVQvF3lhroQ4tCBJGWpqBjJjmQFp+O+QuuZJ62TjULSUB2kCuGsRJQJrYS4fyKQwf+pwADDf6t/L5pAwX4gXGVSIbyk0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hOMyEtH+; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hOMyEtH+"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b6FxL3rw3zjQQ;
	Tue, 27 May 2025 16:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748357590;
	bh=1SBVUrg0cCADJIOKz4taWQh9mQ/ZLQ2xSY/SCzI0ihM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOMyEtH+vrdo9qsHe3FkJ6PMefegt4cQ7HVe53R71M4s6GcCmnaBdjlYgR81gAcxt
	 TUee96xYrYlDzWgLu/l9tLYe5mjL3ywYkBZ+Xw1p4cZrpvBCD2hRUEsFtr+606Owjl
	 FyKYpOjvBiAVb9yACrt9Ferw+aptIwyjn8VQaBnM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b6FxK6SsTzkK0;
	Tue, 27 May 2025 16:53:09 +0200 (CEST)
Date: Tue, 27 May 2025 16:53:08 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Kees Cook <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Ryan Sullivan <rysulliv@redhat.com>, 
	Shervin Oloumi <enlightened@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/5] landlock: Rename landlock_id to
 landlock_rule_ref
Message-ID: <20250527.AhJ9Wuuc8vee@digikod.net>
References: <20250523165741.693976-1-mic@digikod.net>
 <20250523165741.693976-2-mic@digikod.net>
 <112ec51d-523b-444b-ad7e-7b1b3d56507c@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <112ec51d-523b-444b-ad7e-7b1b3d56507c@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, May 26, 2025 at 07:38:00PM +0100, Tingmao Wang wrote:
> On 5/23/25 17:57, Mickaël Salaün wrote:
> > [RFC PATCH v1 1/5] landlock: Rename landlock_id to landlock_rule_ref
> > 
> > This avoids confusion with the new Landlock IDs.
> 
> A very very minor suggestion, but I think to someone new, landlock_rule_ref
> would sound like a reference to a specific rule (like a *struct
> landlock_rule), but really it represents the "name", or in fact, target of a
> rule... Maybe we should call it "landlock_rule_target"?
> 
> (Or maybe the confusion is resolved quickly when they look at the definition
> so maybe it doesn't matter)

You're right that the name is confusing.  What about just struct
landlock_reference?  Such structure do reference an element (an object
or a raw value), which might be in a ruleset, a domain, or none of them.

We should also probably use "ref=" instead of "object=" in the trace
event.

> 
> > 
> > TODO: Split in several commits to ease potential backports according to
> > stable branches
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> [...]
> 
