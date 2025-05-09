Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA778F40;
	Fri,  9 May 2025 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821839; cv=none; b=nQ6B9urdkkV0Jl+HSvf3kU8ivGLTQ/liWC37NUKfNnYElrY6iIrqceEGF9brFk9hWhOM4wnuLe8sKU/yntZpNs38sERFpm5aU4tJ2KeZGVCAmhirAqPTx5beILo8UDM80nQ1o7lTEz3QtdDQ4hEd/ctyWK1PURmFztH2fUOqrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821839; c=relaxed/simple;
	bh=G8/CFf9ZO+i2PIjLZ8xby/5gBn5P22+n8NyIA/gSLSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+oCgi0UGlObAMThiwjpqhhVwsYzOwAui8Z/StIZNmQqpbTzl1+fnI3YHU5vvM53q8WReUPQIRnkDIHh3kk73rTqQ6VDO72kvS9aps14pbC5A+IdyRJlqFAHK1YQe2WEkyqMAIP2TFUlZAQ41DWyYLDrHBXOOMpEoc01p7g93+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 56608617; Fri,  9 May 2025 15:17:09 -0500 (CDT)
Date: Fri, 9 May 2025 15:17:09 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, sergeh@kernel.org,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andy Lutomirski <luto@kernel.org>, paul@paul-moore.com,
	jmorris@namei.org, kees@kernel.org, morgan@kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security/commoncap: don't assume "setid" if all ids are
 identical
Message-ID: <20250509201709.GA708015@mail.hallyn.com>
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <20250309151907.GA178120@mail.hallyn.com>
 <CAKPOu+_vTuZqsBLfRH+kyphiWAtRfWq=nKAcAYu=Wn2JBAkkYg@mail.gmail.com>
 <20250506132158.GA682102@mail.hallyn.com>
 <CAKPOu+9JCLVpJ-g_0WwLm5oy=9sq=c9rmoAJD6kNatpMZbbw9w@mail.gmail.com>
 <aB0sVcjFZaCVEirH@lei>
 <CAKPOu+89=+SFk1hKGLheMtPq+K47E9FRCo1DBQo9zGMwW=Tr2w@mail.gmail.com>
 <87h61t7siv.fsf@email.froward.int.ebiederm.org>
 <CAKPOu+8uw6SCO_hhOy_Kc_XihTDvJGoPrC1ujAHPYuiBghUb1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+8uw6SCO_hhOy_Kc_XihTDvJGoPrC1ujAHPYuiBghUb1g@mail.gmail.com>

On Fri, May 09, 2025 at 06:53:11PM +0200, Max Kellermann wrote:
> On Fri, May 9, 2025 at 4:45 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > In particular __is_setuid or __is_setgid being true guarantees
> > that has_identical_uids_gids will be false.
> 
> Sorry, no, that's completely wrong!
> 
> __is_setXid() compares effective with real.
> has_identical_uids_gids() compares effective with effective, real with real etc.
> 
> See the difference?
> 
> > Which means has_identical_uids_gids adds nothing, and the patch is
> > pointless.
> 
> Also wrong. If that were correct, then my patch would not have an
> observable effect. But it does. Try it, try the small program I
> posted!
> 
> It seems your whole email is based on this misunderstanding. Please reconsider.
> 
> > If your concern is LD_PRELOAD and the like please don't play with
> > the uids/gids and instead just make certain bprm->secureexec gets
> > set.
> 
> LD_PRELOAD is not my concern at all. I just observed that the current

Right, it is an aside, though an important one.

> kernel behavior can annul the LD_PRELOAD/suid protection as
> implemented in glibc.

Hm, but no, it doesn't annul glibc's protection, right?

The concern is that:
a. musl doesn't implement LD_PRELOAD clearing
b. with NNP, setuid-exec followed by setting NNP followed by exec,
   will lead to different behavior from non-NNP.  In non-NNP,
   you'll continue to have euid=0, ruid=1000, and caps.  With NNP,
   you'll have euid=ruid=1000, and still full caps.

So, if someone is using NNP believing that it is a safe way to
execute untrusted code with privilege, because they see they
are now uid 1000, they will be confused.  Worse, they are
subject with musl to LD_PRELOAD from the user before setuid-root.

So two things we can do are

1. have NNP drop privilege.
2. have NNP not force euid to be ruid.

(1) sort of makes sense since you've bothered to use NNP, but
as Max, who is a user of NNP, says, that is not the behavior
that would be useful to him.  It also leaves the non-NNP and
NNP exec behavior - which is already - obviously - far too
complicated - with yet more cases.

(2) is concerning because it is a change in behavior for NNP
users, but on the other hand, it leaves us with fewer special
cases.

At this point I'm kind of leaning towards (2), though with the
obvious modification Max has already found should be added (for
secureexec).

> > I see no evidence
> > in this conversation that anyone has surveyed the users of NO_NEW_PRIVS
> > and verified how anyone actually uses it.  Without such evidence we

Max is such a user.  I don't know what we can do to get input from
more users.  Perhaps scan the debian codebase results at

  https://codesearch.debian.net/search?q=NO_NEW_PRIVS&literal=1

I'll take a look through those in a bit.

> > have to assume that userspace depends upon the current behavior.
> 
> That's fine for me. But this behavior should be documented, because it
> is rather surprising.
> 
> (In any case, we will keep the patch in our kernel fork because we
> need this part of the kernel to work properly. Our machines don't run
> any code that depends on the buggy behavior.)
> 
> Max
