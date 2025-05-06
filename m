Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55EE2820A5;
	Tue,  6 May 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537728; cv=none; b=gUgBmjxW6sDuJl2jECENR/ebR1Dr8AVueZ8jQSKBdPXm7EFne1hWXuo9czvZYFt0dHij9XmV1Hrkt0SGSBOB0yTiAtgWLMU0RP+NnWOh0R4E4asmlI9lUYqpxyFHlIOg56tn0PfIPFOaaqPpk/qxS1d2J9EK3y6LgtS+6cl+lw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537728; c=relaxed/simple;
	bh=GPTTPMuoFY2R3xwbARsVC8wijXO7L1qrPRg4T885sN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgHIjptJ+11TSqV8JMJrwTZn+F2yPUzeMpI5am96xbNJnOq8OLmnJ+V4TSXO+h8hZjutr/TH8Sl6NPyB8geS+3r0gmOfV8c1xVDXsVO5FgymwGX43p6nEQJHVIvUoi6QzCfx88DDJ0xRhFv00NCj2sR8uazqd/PhM9MV9XEv954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 821331603; Tue,  6 May 2025 08:21:58 -0500 (CDT)
Date: Tue, 6 May 2025 08:21:58 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>,
	paul@paul-moore.com, jmorris@namei.org, kees@kernel.org,
	morgan@kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security/commoncap: don't assume "setid" if all ids are
 identical
Message-ID: <20250506132158.GA682102@mail.hallyn.com>
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <20250309151907.GA178120@mail.hallyn.com>
 <CAKPOu+_vTuZqsBLfRH+kyphiWAtRfWq=nKAcAYu=Wn2JBAkkYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_vTuZqsBLfRH+kyphiWAtRfWq=nKAcAYu=Wn2JBAkkYg@mail.gmail.com>

On Mon, Apr 28, 2025 at 01:43:43PM +0200, Max Kellermann wrote:
> On Sun, Mar 9, 2025 at 4:19 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> >

Adding Kees and Andrew Morgan for their opinions.

Sorry, I had snipped the actual patch below.  Pre-b4 I would have appended it
here, but as you can just
   b4 mbox CAKPOu+_vTuZqsBLfRH+kyphiWAtRfWq=nKAcAYu=Wn2JBAkkYg@mail.gmail.com
I won't do so unless you ask me to.

> > On Thu, Mar 06, 2025 at 09:26:15AM +0100, Max Kellermann wrote:
> > > If a program enables `NO_NEW_PRIVS` and sets up
> > > differing real/effective/saved/fs ids, the effective ids are
> > > downgraded during exec because the kernel believes it should "get no
> > > more than they had, and maybe less".

Just to quibble here: I don't use NO_NEW_PRIVS, but it seems to me quite
likely that your claim is wrong here.  The whole SECBIT_KEEP_CAPS etc
dance is based on the idea that you understand that once you exec, you
lose some of your existing privilege.  Similarly, it seems quite
likely to me that people using NO_NEW_PRIVS understand, expect, and
count on the fact that their effective ids will be cleared on exec.

Note also that so far I'm only asking about the intent of the patch.
Apart from that, I do think the implementation is wrong, because you
are impacting non-NO_NEW_PRIVS behavior as well, such as calculation
of cap_permitted and the clearing of ambient capabilities.
And, I'm not sure the has_identical_uids_gids() is quite right, as I'm
not sure what the bprm->cred->fsuid and suid make sense, though the
process's fsuid and suid of course need to be checked.

> > > I believe it is safe to keep differing ids even if `NO_NEW_PRIVS` is
> > > set.  The newly executed program doesn't get any more, but there's no
> > > reason to give it less.
> > >
> > > This is different from "set[ug]id/setpcap" execution where privileges
> > > may be raised; here, the assumption that it's "set[ug]id" if
> > > effective!=real is too broad.
> > >
> > > If we verify that all user/group ids remain as they were, we can
> > > safely allow the new program to keep them.
> >
> > Thanks, it's an interesting point.  Seems to mainly depend on what users
> > of the feature have come to expect.
> >
> > Andy, what do you think?
> 
> Serge & Andy, what's your opinion on my patch?
