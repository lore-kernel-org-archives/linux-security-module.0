Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2804217BD3;
	Sat, 30 Nov 2024 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732997231; cv=none; b=YmN/q7yPPYG3hGAxPK0WaR3RhKC6AuGq6inq+dV8yAStRsGQ6F/oNfPFBVtA2VEiIL0xmsQAH9viClkt4VZi3Gkg+D8RWhTi8uMHWTP4ozHcu0uRuO5b7Wp4TPtcjRpvR9aECBTC69Uw8Zj646MbORls5oooj0T3ZY/KHQfSWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732997231; c=relaxed/simple;
	bh=/zAtMEcM1T2YahFMnjIYOLMBS4ZkOX9rg58TJ3GZAZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+KCbbiyD2ibfFzsTeKCpwMDB+s8s4BuWCkxLtze23BXO85Ed3zl6lCLriaYYfIlzdkrh4bPi579szIxtdCilIEyNvlmbtv6suIP94gHFGLSzHWVRA19sCW2mmmf7FhzFIi4tmccjP27pNbfmgb3Fw3C7d61Pcx2Jo8i+Tqn154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 1030C579; Sat, 30 Nov 2024 14:07:06 -0600 (CST)
Date: Sat, 30 Nov 2024 14:07:05 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Jordan Rome <linux@jordanrome.com>, Serge Hallyn <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v8] security: add trace event for cap_capable
Message-ID: <20241130200705.GA75312@mail.hallyn.com>
References: <20241128224849.3774367-1-linux@jordanrome.com>
 <CAHC9VhSds8SKprWxN4NQiCJ090eYk7bzTZ=yy0KOAYLHMqOUJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSds8SKprWxN4NQiCJ090eYk7bzTZ=yy0KOAYLHMqOUJw@mail.gmail.com>

On Fri, Nov 29, 2024 at 09:57:54PM -0500, Paul Moore wrote:
> On Thu, Nov 28, 2024 at 5:49 PM Jordan Rome <linux@jordanrome.com> wrote:
> >
> > In cases where we want a stable way to observe/trace
> > cap_capable (e.g. protection from inlining and API updates)
> > add a tracepoint that passes:
> > - The credentials used
> > - The user namespace of the resource being accessed
> > - The user namespace in which the credential provides the
> > capability to access the targeted resource
> > - The capability to check for
> > - The return value of the check
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >  MAINTAINERS                       |  1 +
> >  include/trace/events/capability.h | 57 +++++++++++++++++++++++++++++++
> >  security/commoncap.c              | 57 +++++++++++++++++++++----------
> >  3 files changed, 97 insertions(+), 18 deletions(-)
> >  create mode 100644 include/trace/events/capability.h
> 
> I'm personally not a fan of the helper based approach here, it adds
> unnecessary complexity in my opinion, but I understand that was an
> edict handed to you.  Otherwise, and within the other constraints, I
> think this looks okay.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

Thanks, I'll add it to the caps-next tree so it can get some
testing until the next merge window.

> 
> -- 
> paul-moore.com
