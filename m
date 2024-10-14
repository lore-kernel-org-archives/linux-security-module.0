Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C16519CCFA
	for <linux-security-module@vger.kernel.org>; Mon, 14 Oct 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912656; cv=none; b=D8w7T0thrDCOYfvcSzdmY/dQFzTWUyN2+IzSfyeMBP4CWe4jrD6onqYp9IDJCHhOsVfCWORZmzHkSi34teM0w2QNxT954C0Sceak2EKlBN4ZzgNM3eWBLY9qOh55KJW9gG16+SBDZKAsFoHPhzzBH/oa+5vBQTsHIwJB+vaYlHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912656; c=relaxed/simple;
	bh=2UVqbexnqNci3grd/5BSq40pYQ2u6L0Swq8qIQHkBKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxD5cR9UYBC3Wt5A0jJPGcpLN1jnkN1eT63J91bH/b1HpvxycwzsVqgiB+4lqYLqg9idbpgwmuNexyHVj356SF4gC1NQtQJ9MHuZ7+WMBDwfMd8AJV2GGX1nIKwIkXbUPzGwTNcrdR3vawImufzj3VBIeMJ3+d069R8OFzzK1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=IXgFt6lR; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="IXgFt6lR"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XRymB46ZCzY1y;
	Mon, 14 Oct 2024 15:30:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728912650;
	bh=Po6hgLNsaKhPpGljJr4fPdd1Y7bt7xIfi6p+nTtQGvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXgFt6lRv5nmZd4eqoFCNKUKNkWSpMmiDNljyTkl0XRtSYm3240gTMrFL8EKWrkJb
	 t8uAlIcC/5Nk9NxuH7OJB9dwmiPobZxTL4E/sfEZQeEjG9NiCQclAW/2J/sONOu7lE
	 qA9IT52drx1bUvQt37VPI/OPjq+Z2G0FRxIGGt/0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XRym96Pn1zTsM;
	Mon, 14 Oct 2024 15:30:49 +0200 (CEST)
Date: Mon, 14 Oct 2024 15:30:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Eric Paris <eparis@redhat.com>
Subject: Re: [RFC PATCH v1 2/7] audit: Fix inode numbers
Message-ID: <20241014.Ahhahz2ux0ga@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241010152649.849254-2-mic@digikod.net>
 <CAHC9VhR8AFZN4tU1oAkaHb+CQDCe2_4T4X0oq7xekxCYkFYv6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR8AFZN4tU1oAkaHb+CQDCe2_4T4X0oq7xekxCYkFYv6A@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Oct 11, 2024 at 05:34:21PM -0400, Paul Moore wrote:
> On Thu, Oct 10, 2024 at 11:26 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > Use the new inode_get_ino() helper to log the user space's view of
> > inode's numbers instead of the private kernel values.
> >
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Eric Paris <eparis@redhat.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/lsm_audit.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> While answering some off-list questions regarding audit, I realized
> we've got similar issues with audit_name->ino and audit_watch->ino.
> It would be nice if you could also fix that in this patchset.

I can do that with the next version, but I'm wondering how it would fit
with the UAPI's struct audit_rule_data which has only 32-bit
fields/values.  Does 64-bit inode filtering currently work?
