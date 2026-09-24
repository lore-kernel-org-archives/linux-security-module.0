Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0565B4BB290
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278440; cv=pass; b=K3hD+49upvk1lNP0cieNesvdV7vbc++i/fDtQSCqtZLzKYdEZ3cC9THbkJ+yayf45IUplpzyaxtLl3p2DMg44FiqFtGy9XtAfYzKo1Bd+OmKe3ADBsywBCPBVMlWBWcIBOtRhaiQNHb5Hg3ZYl41gU3CtYU91KZswiz/5MGIAzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278440; c=relaxed/simple;
	bh=t/N4X0XnQ9obqaKHrk7vetf+dDL6VPJaFNb/XYutegc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp/KY54zDOAO81bP/IV5at/C/Ki+b+Wuh9MXdiiG98yEbht0XQI/1JFMK/bRar3AYt2JHR61Pa98LqDM0m/ZrMF89qPM+Pbl9dS9O/rt/eTu9mSQ1D5AA9uw7PJH2vmOWtRcANk7pOz8zdpPwyq+UzfkVW5/44RK5Az4JQpkMqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GeD5PrGf; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GeD5PrGf"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so40767a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 12:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790278438; cv=none;
        d=google.com; s=arc-20260327;
        b=qsL+62CS7GmLriVdl/ODieE5519KqoJA6lt1UiNoXON/o6QmGF5uf3YepwGQ3WlkeS
         vPiLTdaFONfk16fr0XOxVcN11nc7EUmR2NWeZ+oHL4dZANTLw1KvX87AOpafr16HRGXb
         iTyF6CsqMD4Gq24V8aufwAotCiovLJCDgiIO9PjdAA8MAvEVpKZiMLnO+q1/jfeCQoQK
         mTI1BPC8vMCoZKET2gwOJbMPImY5NGjoA2PFYm9aGjzi6GHY0h+ZUy2CKi3fyZIO2VMg
         Nbez8SdR7JoJ5xmqzv1nWZfAIzA8LfoM4hMGJOiWVkuEkSTP11GSfkK4JkfSG93n7oUG
         ++VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Er0wNZ7ei/sffJZBS6vip8iLxFYHICi+dbdHiy3n2DU=;
        fh=49OJglIhDvAkdoaGbsQ79qMz00ie03ZhigpPtyhOUSQ=;
        b=B11pcePJBtqbaQ4nx3QfJJMlZ+w7oz4KGNu2JXxwnRUCFTNLrw9MtqHtcb9tWZ7E4k
         sLzpp2olCj2M5A6tH1+raLIs5IBszEeyQUsUHpLOp1T9O+2LMHgGSL9F65ak7L0jBbJH
         R74dwEz4TiL8p/zzz4/7HSS1xluvGJfACf+6wtsFYazpwkxIfEb9d5d+XzejotX2I1rq
         JqNnlDW0IBCGoFtFh/+HjCQkZMrrKKHgnO/SNSmg91O1xjx7jWYdIYHFbNFEzCUJCQj2
         kyGpKue8hQ7i+cX4G6FU+klM0jJrjcPzKTjEQqORYcku//QlCq4ZgW8KEzAvY+z6Nxxk
         CuKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790278438; x=1790883238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Er0wNZ7ei/sffJZBS6vip8iLxFYHICi+dbdHiy3n2DU=;
        b=GeD5PrGfMnjZPhdCBFwzGInNpnt3BxrGUjomNh4N1K3ZP9F1k0lDJezDWB5DQhPTJZ
         0p58BADZ/12tdMpaevVRhR1H/JHnK3TS1Tpw3rFFAE/mWivIHgWUUI9Sdd/MAETsSiRA
         L5uWDVMTZDJocm2plpS4mzt/o0nTa98GymvR7SsQf6qUzOZmTHxOW6cmqIYNRh5cnvuX
         G5adkdOY9W3MLY3FeFDEEayolvPNPxqnlkDuuJI3dF9nnyAHmCQMX7vNZZ7aIc5UEg7f
         3b8xoKP5Wo6Ro3d98cJtXF7LGj310r7tDb9CWDqy1UIGlmE7e7JjB+yeq/bAEcsLatJY
         kPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790278438; x=1790883238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Er0wNZ7ei/sffJZBS6vip8iLxFYHICi+dbdHiy3n2DU=;
        b=qwfm+kupMibVJES/E4WbA5mC+6RtcoovtlU2v2vnxG6JprCl2pq39h2VTP0RsLUA7j
         kGBmJ1gflvsjhtjg5dvS0KeL0e2Z4vQR/aPAQpqyAOGnByN/g65iXxrmjFW6ihY8twqG
         KdqqvNvhHPvJLj7+Y0rG3uDL6ZLYKy4s0a1WGsLIS1F90MMF4rOFI5RiPyxluwX8SoVa
         KqopIOvtPQCXrXb92iFV5DfefBjM9hZlzOTXneMh+CSLEr0pydfXxWEzRXAAbEZxBQ1g
         9+FIqRhSmfcWstWBz1XEeb3HnI5wqSGWWph4KXssvao6/bY8nhtT+Mp/+IrRTdet8m4q
         0I3g==
X-Forwarded-Encrypted: i=1; AKwUvBxCrI93vNUtRwddHQWKSoMDbb7KF0tuxOjITdN3k+ibkj+jX+IKKl+Tn1BnbNFYvITSu2ZE5MkXFkL/3n/QrmAL4PYRJDY=@vger.kernel.org
X-Gm-Message-State: AFuF++kYLjD5heolrOnTyvfjnJsI3i9tgeKFe72qFpH1EgaMaQcZDYTz
	2xN67bEta1Wt0IVFxUd1W0uLNt72EndXAo3F26FNck59tMLW0a9kxvWWg6BrjURR9ZdwFPA2vXg
	C0eLW+YryMlM11Oipv70ANogvaRw9llUkroELwEk/
X-Gm-Gg: AYBFou2cFOy73P/kRDOdndkNgVBxqfRfJB5DCV3wqH5NBU1e2rqC9FL2/2h/3H+Imsp
	RVokZtHjn58JyrayMwW1sV/axGYf9aXxWZy+rqeZVwYzGU2sTEFxXxeF213k2dMHCSq88CcOXHY
	7LCAOCrSdqgSI8O4N9+wyJG/9ZlafS+buOzP87hyeYXDFCt/5OoL5CaslCu7i60raMnn2Z1Rb3O
	dkmFdZIqgc5boIkK0M2lKAIPVRvZVdBA9+EESTjck2e+R3pyy6eoq0JeBFZT45yoLtBxijFuAjV
	xvdHwZPdUv30yI/2JSQl9HtQReVAys9ai/qpTi2m+fRIbq/x21324wUZuzpqj4I4U0eFs9zs6RB
	JwXaeiMybMvs=
X-Received: by 2002:a17:90b:380a:b0:39e:6c69:f481 with SMTP id
 98e67ed59e1d1-3a098d56a2cmr3187553a91.64.1790278438044; Thu, 24 Sep 2026
 12:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
 <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
 <arVKSpezisxe3pkr@suesslenovo> <CAHC9VhSwbHF8tZkZ00JM40VTBeXVgcVdoBt7NcX0XKaKSARWug@mail.gmail.com>
 <arVkWs7tG3ayGxyX@suesslenovo>
In-Reply-To: <arVkWs7tG3ayGxyX@suesslenovo>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Sep 2026 15:33:45 -0400
X-Gm-Features: AclHuK8Djm6kng1KVJoAo1IKBHaXUoPUqY4SRBxOWSBr835p7OAm38aVvkcIm4U
Message-ID: <CAHC9VhTzGJz5Lt8tXYzJfMihsMOX3Wa=6b83dV8QihpRBfBbWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: Justin Suess <utilityemal77@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	alexei.starovoitov@gmail.com, brauner@kernel.org, john.fastabend@gmail.com, 
	memxor@gmail.com, kpsingh@kernel.org, matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 2:38=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
> On Thu, Sep 24, 2026 at 12:23:13PM -0400, Paul Moore wrote:
> > On Thu, Sep 24, 2026 at 12:15=E2=80=AFPM Justin Suess <utilityemal77@gm=
ail.com> wrote:
> > > On Wed, Sep 23, 2026 at 03:14:28PM -0400, David Windsor wrote:
> > > > On Wed, Sep 23, 2026 at 12:57=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > > @David, simply for my own understanding, did you ask Daniel to do
> > > > > this, or was Daniel operating on his own with this patchset?
> > > > >
> > > >
> > > > Daniel and I work together and both have things written on top of t=
his
> > > > kfunc. He reached out to collaborate, I agreed. We're also going to
> > > > send bpf_set_file_xattr shortly.
> > > >
> > > > This implementation was chosen due to its immediate mergeability (i=
t
> > > > only touches security/bpf), but was actually suggested by Kumar in =
v1
> > > > or so of my original series.
> > > >
> > > > That said, sorry for any confusion about this appearing as a new
> > > > series rather than as v7 of my previous one.
> > >
> > > Howdy all,
> > >
> > > Hope you all are doing well and having a good Thursday.
> > >
> > > These patches are excellent and useful, and have been in the pipeline
> > > for a while.
> > >
> > > In the interest of moving forward:
> > >
> > > Would you both be able to live with the following: provide a security=
 hook
> > > for lsm_get_xattr_slot or another proper interface with the necessary
> > > abstraction, and keep the kfunc where it is in fs/?
> >
> > That still doesn't change the fundamentals around the kfunc: it is
> > really only a valid to call it from within the LSM inode_init_security
> > callback, it populates a LSM framework managed buffer, and that buffer
> > is then used to by the LSM framework code in
> > security_inode_init_security() to do the xattr initialization using
> > the values from the BPF LSM as well as all of the other configured
> > LSMs.  It's very hard to see this as anything other than an LSM kfunc.
> > I worked with David over several revisions of his patchset to review
> > the code and get it in a good place, I'm supportive of the basic
> > ideas, but this really needs to be located in
> > security/bpf_lsm_kfuncs.c as it is an LSM kfunc.  As we've seen there
> > is precedence for subsystem specific kfuncs located in the associated
> > subsystem's directory, things should be no different here.
> >
> Hello,
>
> I'm less arguing for any particular placement:
>
> More so that the concrete security interest of just getting the kfunc
> *somewhere* is much more important. I have no doubt that the function
> would be equally well stewarded in either directory.
>
> The xattr kfunc in security/ question can be fought best in a different
> venue where it's not holding back good contributions.

This (the mailing list) is *the* venue, and sorting out
cross-subsystem issues isn't a foundational thing, not something that
can be cast aside because it is inconvenient.  In this particular
case, resolving this before it lands in Linus' tree is that much more
important since cooperation has been "strained" to put it mildly.

--=20
paul-moore.com
