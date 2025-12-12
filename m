Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C0308F33
	for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765564262; cv=none; b=A2mC19ruffNGwPiD2tqom3KtD28qgMjoclX1/bK7cGuBsdnoj5Wkm0lZJfwuFzeNiMcuWn0zrJzw08nNUK4teAonHHUWCBFrj/qg1nfxSnaKPRdXM8oARhw6wBBB4m6L5FfcVxus31ZN2JpVGI0+Uqf/A7qUgD2zSQgJfq4jIGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765564262; c=relaxed/simple;
	bh=QdayMopPknirf3ss1r8pjdUWlrEk1jfuRGbrUEjERZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBSWr9wfHHp4yQggZy6PSahzc2u9wGbiGEzLJ5rgp6KIQBJNzp1jVcauB/uKCjHu3Y89wRCOI4e9m5wOI0iY+JWFjO/Hh7M+qTEuFebMs27cyGvNmtblasmS5j/7BoIT76hX493vnqroxho4Iw/N9+PX2rUWckc6AUmhVDZImnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AaxsQ2NA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AaxsQ2NA"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34372216275so1936296a91.2
        for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 10:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765564260; x=1766169060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WV+owY8bRwOabcCIBwLP31mTNNBvJW3owcIf3RlWYw=;
        b=AaxsQ2NA3Aomtzo/VVC2d3jQIMZGsNZ6GbnLZyASt54n29FHlUTNMn7/MdGFZOBjVE
         z4rrnTcoHOF4sEjkOjO/3+/OIp9R+R1oRmh0zuBTWehcVM/TM1WlW9OqvI3ktwfhk35Y
         4Qmls7tSKprPFfQxVlxpB/gOTrBppy9KSlRK2sX+AzhBJc6PwVqae74XslFno57iRMbj
         +XS7K8rkk/tLfPwefVyLSA01anJY4gldZZmLZWzv+AcBn6gCIpQXvb9qaX9WtyLRvIVH
         Jatl5c9sIoPp/3fkufp8KPTG5K0SpEo6M1hvRjLIOIwuSXkgbeEie34z9m0v3Jgfmhh4
         kNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765564260; x=1766169060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8WV+owY8bRwOabcCIBwLP31mTNNBvJW3owcIf3RlWYw=;
        b=coEOAhMOMsdfY9DuX2qUUK/Z7leA7DprqGF45LEhascBxCYmq+bOH7Y5rBd02ckw0X
         dsuJBefduVUXppKh7jJ7bhJCrl11G4rVHqq1e3AqaqU+ZvOmCJEu5CaCfD5g97Q3Vtuu
         Nqv2Oy9Lo0pkLIhS4Gl5Hp87W39Jtk8Orm4QUfimNJem3NzEc26cgGS1y8WnCR45Kp+M
         uH2QTrefPl+S9ARjg9JhG6VO2ylDfxWIBIH0l/CYQhnz4gMuzw6A2KXM6FqHcD8BUyt8
         QxXAZ+CVSHoOforDHyiODTGuDTp/6ccgUnmKd1QYWBEdMHJcVXn+TaQ6/egodm5DITAi
         AnPA==
X-Forwarded-Encrypted: i=1; AJvYcCUfdxwIq9EC6QJ0Y80A+W65x/d5EZP6n40NbxIrDBWlblE4tTEFY0peOYx60pXLvROo6q+tJCoyK3MVtU70kq+pQBtHI54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7huTqknA8WCpKs9paeESAMyqx0QgIje8bDXrbaM0KPl45GSSk
	EyyfY5RTcEpqk44NTTc19umeTylmExgwMBvM0OYH3hQ90v9fh7uZnnjrfZciHdFCBLKsxJ/r2QP
	j9AFeGTW5JgsXx0U2cDnul5U+oKUyU/Hj0D+Z+L/Px8SHRgPqam0vcg==
X-Gm-Gg: AY/fxX6KquJ6lsl61AoQtG6ZFQrHG/hu0CRjOdyuADSikDnfVl5xJX5KkAa2tQji/nz
	4fzRkLO5LdwnLBPOIO1vJbtca8GGN45wtFesjUzOQxc9yX5NDSE7+G/XDnS3ZlEiqvowJVR317n
	IYshO6LUFYUxmYMZFFejT7tEBfc69rPiRG24VPQP2OCiVUk18eEXnNCuS/euCz67I7KX9Nb6Fq5
	WMziUlIQq5tNb6/10ydnI6cb1+NNhp3ir95NxTMpNhRWh8zdOwYxfwKcngvgF+M4xWtWdo=
X-Google-Smtp-Source: AGHT+IH3fVFYC+7U4gca0Dot9dThMEI+EUY6SOp9bdsVvQLeCLIW+QwgftzD7OJGiX0t3ZXQCv8Br2WPwVd2aci8MaE=
X-Received: by 2002:a17:90b:5590:b0:340:e529:5572 with SMTP id
 98e67ed59e1d1-34abe3e0398mr2048343a91.8.1765564259952; Fri, 12 Dec 2025
 10:30:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com>
 <a3d28a4b-ee63-463e-8c5c-2597e2dcba98@schaufler-ca.com> <CABZOZnRQ=b4K5jpNM8Z=Zr=+66COwLpC8gynzw88==mL0FCrOw@mail.gmail.com>
 <CAEjxPJ6CbZC-=onSGgELygnt_hsqaN0JS_jJFxWn+hYt90s2Ng@mail.gmail.com>
 <CAHC9VhSU5yLQkCchCMUx+OLk+_2YY=1fjzth4s+_ELwgXg5t-A@mail.gmail.com>
 <CABZOZnRgYd687neqk5e8vQu5y7cwPwbht2SHS-4=q0y3MWU=mg@mail.gmail.com> <CAEjxPJ5O2YTPaD9S=UXw-KzTtQyXPuvZ_WXDHGX1Of1oxjw9rQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5O2YTPaD9S=UXw-KzTtQyXPuvZ_WXDHGX1Of1oxjw9rQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 Dec 2025 13:30:48 -0500
X-Gm-Features: AQt7F2pFrQRCPJbyWafKv3dCDWGMr518j-Tr7pS4ahjIvBsmWoyTCDvx41CDnMk
Message-ID: <CAHC9VhRPgNCyN58O288-f5RYOB1HvHQo065Fd-q-W=n9yWP_+g@mail.gmail.com>
Subject: Re: An opinion about Linux security
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Timur Chernykh <tim.cherry.co@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, 
	greg@enjellic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 12:37=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Dec 12, 2025 at 12:22=E2=80=AFPM Timur Chernykh <tim.cherry.co@gm=
ail.com> wrote:
> >
> > > While Timur was
> > > added to the conversation by someone, I don't see any mail from him i=
n
> > > that thread.
> >
> > I probably missed this thread.
> >
> > > Beyond that, I'm a bit lost.  As far as I can remember, and both lore
> > > and my own sent mail folder appear to support this, I've never
> > > commented on ESF.  At this point I think Timur may be mistaken
> > > regarding my commenting on ESF, but if I am wrong please provide a
> > > lore link so I can refresh my memory.
> >
> > Sorry for misleading you. My mistake, I should have checked the thread
> > first instead of relying on my memory.
> >
> > > In this post Timur provides links to his ESF project on GitHub, but n=
o
> > > patches.
> >
> > Am I correct in understanding that any proposals and questions I'd
> > like to discuss with the maintainers and the community should start
> > with patches? Even if the goal isn't to implement a change right away,
> > but merely to evaluate the idea.
> >
> > When I proposed the prototype, it seemed excessive to me to prepare
> > patches for something that could be "finished" at the idea stage.
>
> It doesn't seem to require much more effort than creating the
> prototype and publishing it on GitHub. "Write for maximum efficiency
> of reading" includes avoiding the need to follow links to adequately
> evaluate a proposal. Just provide enough code to show what it is you
> want to do and why that can't be done (well) today.

To add to what Stephen already said, if you are serious about
submitting a new LSM upstream, we do have some documented guidance
linked off the "SECURITY SUBSYSTEM" entry in the MAINTAINERS file.  To
save some time/searching, the direct link is below:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsms

--=20
paul-moore.com
