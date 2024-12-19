Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE369D2B;
	Thu, 19 Dec 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617996; cv=none; b=Cc/4P5zH4liSuWs4Zl7i+t3VnJoEFhRouD4RRBgQReOodcVnO0O2NdmxdRbjFTIVSc9QiBsUnkuKYu8bkUL+AqTYVxh6wubVQCDNrZw6WyMcRHlITlPjCxNMQMqoQD3VAiAjZPj38V9IRfV78amc0idG3UhoIdKM+wnPaSJGk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617996; c=relaxed/simple;
	bh=SGePen9HXXCLfOzdBkX1Dh45nluxYHFUpPGXxPHPRU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSy+GTwusxF/pbMp4Arkx6F2iAy2Td9/R2j3CJtKuzs7lbVV6nz3AVA2oLawlKrwfsU3CqxBQbTPGA48ZPlebV5o3umKAguHijlkEeGr6oI3g4Ux8MAUuDXK+utd9carlx+WddyOapdEdaFVD98J/sVVf1XRULNoprOQy4RWjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=sEeEBNqv; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="sEeEBNqv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=yZrEUdLTpZn3XuClCPpgf+6mRD3kCVpWTAMxXEmtGCU=; b=sEeEBNqv4CMa60hC
	CiXge5FysVZbOX8uSpdD54A9ojJQpVRy6+HIzRKKqy6CsAxtftVRQ6dduAtbWp6SmW7yIF8ruohxB
	+GciyYsL0YiWtqCggWRqqSNzMPg7ZQsFKark956gygcMFQZQrEMmRkxrtFdmfr9KH5Df6ALcxR0q1
	D8K/Fw3b8sIydu6l3olYdDropcA+azxAAanw85LAM+JGYphv2vWpD5ltVgAxQ4PeQb6LZaLHsg+/9
	ouv7fLb133ag6Sf5SpOJsNWb0s/mAf/K2WUBICAVkdMNWL0qI3qrbaYumLfZANBPO095l5O9eNm5E
	o8Bo9bQqZLPbBhMPmA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tOHNQ-006JUS-1y;
	Thu, 19 Dec 2024 14:19:44 +0000
Date: Thu, 19 Dec 2024 14:19:44 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Paul Moore <paul@paul-moore.com>
Cc: serge@hallyn.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capability: Remove unused has_capability
Message-ID: <Z2QrgI0coNmBMonB@gallifrey>
References: <20241215165352.186692-1-linux@treblig.org>
 <CAHC9VhRyf8Jo54gnz2Nu17eHFOEqeXd3B5_HoXbz9uLYDba=HA@mail.gmail.com>
 <Z2NIpSZ9iY0q1EAl@gallifrey>
 <CAHC9VhTmqMKkemeyWK3d6tyPGSus9ApMpZzTjtrmgHqbC_au+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTmqMKkemeyWK3d6tyPGSus9ApMpZzTjtrmgHqbC_au+Q@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:13:59 up 225 days,  1:28,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Paul Moore (paul@paul-moore.com) wrote:
> On Wed, Dec 18, 2024 at 5:11 PM Dr. David Alan Gilbert
> <linux@treblig.org> wrote:
> > * Paul Moore (paul@paul-moore.com) wrote:
> > > On Sun, Dec 15, 2024 at 11:54 AM <linux@treblig.org> wrote:
> > > >
> > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > >
> > > > The vanilla has_capability() function has been unused since 2018's
> > > > commit dcb569cf6ac9 ("Smack: ptrace capability use fixes")
> > > >
> > > > Remove it.
> > > >
> > > > (There is still mention in a comment in security/commoncap.c
> > > > but I suspect rather than removing the entry it might be better
> > > > to expand the comment to talk about the other
> > > > has_[ns_]capability[_noaudit] variants).
> >
> > Hi Paul,
> >   Thanks for the review,
> >
> > > I would suggest that this patch would be an excellent place to change
> > > that comment.  Without historical knowledge, the comment will be hard
> > > to understand after this patch is merged as inspecting
> > > has_capability() will be much more difficult, and including the
> > > comment change with the function removal will bind the two changes
> > > nicely in the git log.
> >
> > Yeh, how would you like it? The existing comment is:
> >
> > '
> >  * NOTE WELL: cap_has_capability() cannot be used like the kernel's capable()
> >  * and has_capability() functions.  That is, it has the reverse semantics:
> >  * cap_has_capability() returns 0 when a task has a capability, but the
> >  * kernel's capable() and has_capability() returns 1 for this case.
> > '
> >
> > For a start I think that's wrong; the function it's above is
> > 'cap_capable()' not 'cap_has_capability()' - and has been for 15 years :-)
> 
> The code in security/commoncap.c is fairly mature and stable, and I
> don't expect that many people spend a lot of time in that file, I know
> I don't.  An unfortunate side effect is that certain things that
> aren't caught by a compiler can easily go out of date, and stay that
> way for some time :/

There are 'many eyes' scared to look!

> > How about:
> > '
> >  * NOTE WELL: cap_capable() has reverse semantics to the other kernel
> >  * functions. That is cap_capable() returns 0 when a task has a capability,
> >  * the kernel's capable(), has_ns_capability(), has_ns_capability_noaudit(),
> >  * and has_capability_noaudit() return 1 for this case.
> > '
> 
> Two things come to mind when reading the suggested comment:
> 
> * I don't like the "... reverse semantics to the other kernel
> functions" text simply because the majority of kernel functions do
> follow the "0 on success, negative errno on failure" pattern that we
> see in cap_capable().  I would suggest something along the lines of
> "... reverse semantics of the capable() call".
> 
> * Most (all?) of the capable() family of functions, excluding
> cap_capable() of course, return a bool value, true/false, instead of
> non-zero/zero.  If we're going to complain about the existing comment,
> we probably should get this correct ;)
> 

OK, maybe:

* NOTE WELL: cap_capable() has reverse semantics to the capable() call
* and friends. That is cap_capable() returns an int 0 when a task has
* a capability, while the kernel's capable(), has_ns_capability(),
* has_ns_capability_noaudit(), and has_capability_noaudit() return a
* bool true (1) for this case.

Dave

> -- 
> paul-moore.com
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
