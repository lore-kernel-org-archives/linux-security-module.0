Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8457C8D;
	Thu, 13 Jun 2024 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309061; cv=none; b=TzHaKBfDDceW4bMbvzQ4K1tompSNVK9llz6ln9MsJWCYXcpQMLkqjoY0zAfNg+rU0snI07SuThVT5PLbGKGS9+aF74T8meK5mMvBLis+N6wZeAH93UbE1hxgyzkZXRulmvtyLKylcn5VJ1dMbQRqM5w+6oZ5LWR2X9eBU14YA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309061; c=relaxed/simple;
	bh=MEYJeXpmEp6BsUZfvlLwZ3nWqwRD7HkRoo2XmzDvoq8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ifxkKVl0GPRe6X9xRXCxuQsaXzhuzETcQjGh1yvhn2kTamjBcl3ufA40zblWc04olMGQd72FpoIJg6Lbi0CdPYHNgECj9BJFIJYnsksZyMv6nnGP1wgaN6UHOH1/W4DFU3+JwBhdZnvnfclv5ejgbOsHgInZExkwIu+4bDwQG/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ePHLIVEv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ePHLIVEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBD3C2BBFC;
	Thu, 13 Jun 2024 20:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718309061;
	bh=MEYJeXpmEp6BsUZfvlLwZ3nWqwRD7HkRoo2XmzDvoq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ePHLIVEvf8YkzFBvOsUPZOXxGRHALYvuZtGNX5BBtWzd3MVoYIbpOuUjGZIoy45vY
	 l2wUwpQXJrsqaHe8kYhTYe/HbJCZ41HiWLztGV9odkdwdUzLh/bV9/ej1kW/PAYVZ3
	 jr33auWyfX2eFeOywquKIjzxXlNEpP4kn02ojBfo=
Date: Thu, 13 Jun 2024 13:04:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] linux++: delete some forward declarations
Message-Id: <20240613130420.a62ed8965a73b0f8d35890d4@linux-foundation.org>
In-Reply-To: <20240613153402.3b067d4b@rorschach.local.home>
References: <5ad5556c-7c32-45b7-89cf-f723c9d7332b@p183>
	<20240613153402.3b067d4b@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 13 Jun 2024 15:34:02 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 13 Jun 2024 22:22:18 +0300
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > g++ doesn't like forward enum declarations:
> > 
> > 	error: use of enum ‘E’ without previous declaration
> > 	   64 | enum E;
> 
> But we don't care about g++. Do we?

It appears that g++ is a useful enum declaration detector.

I'm curious to know how even the above warning was generated.  Does g++
work at all on Linux?

> I would make that a separate patch.

What are you referring to here?

> > 
> > Delete those which aren't used.
> > 
> > Delete some unused/unnecessary forward struct declarations for a change.
> 
> This is a clean up, but should have a better change log. Just something
> simple like:
> 
>   Delete unnecessary forward struct declarations.

Alexey specializes in cute changelogs.

I do have a concern about the patch: has it been tested with all
possible Kconfigs?  No.  There may be some configs in which the forward
declaration is required.

And...  I'm a bit surprised that forward declarations are allowed in C.
A billion years ago I used a C compiler which would use 16 bits for
an enum if the enumted values would fit in 16 bits.  And it would use 32
bits otherwise.  So the enumerated values were *required* for the
compiler to be able to figure out the sizeof.  But it was a billion
years ago.
