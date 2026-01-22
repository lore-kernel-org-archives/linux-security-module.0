Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1E3AA185
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769050859; cv=none; b=jgGoiqm621RIbcSPGttwoSE4DBDAGRdiw5E7ynT14waXTupTGcz74yUPvSb1Go8rFGKVlOCAcUxoBdtlreSm7JHpm/FhniqMMwPH5476a0v9VeiBYkVldSXCiMc7MV5Y4vbW3GgviFBL0si3sj/6EYtLsRuiZcfESki9Q/wSsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769050859; c=relaxed/simple;
	bh=gls6KrMY9MoZr6IyIOp94QaEs8EmwWve6vYwp5J4ymk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0PqO413p80SKGqpWxG5uH+CENdDNQq4+rfbJnNMsVadd8DsFATzgFLruuVVrpNgC4wpkOYo+zUYmrFHmo1Fvcx0fPH6OSkjzjXLOaTCo9uMCfzWZh2jdKiT5+YOPQ1C83gJqPYlD3IpItyo0K7hsvhx/M3AOdXXiRAyxrs463o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIwX65XU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIwX65XU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E9EC19422
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 03:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769050859;
	bh=gls6KrMY9MoZr6IyIOp94QaEs8EmwWve6vYwp5J4ymk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dIwX65XUDIP5f+ikHsYxx4MXWdxGzo9LepVeHKQvk9CAkpspgd+zk6/Mw3h9ld4Rn
	 zYH8pmjdhnwyCAHLMUDrDgSxd+09xx4KUALagcnu9iUQdlToe/ho/pzu7DcXwh6HnT
	 7iQWsdP1l4TvZhnXxfQwbW34ft3BU/2fm/glWkquy62r3XHcAh3JXwKZhRfbGF0KzL
	 K5IBM3faZF+5zis9qDQXOD0Bhw8sn54k/cQlkrJFyGuuF/B3v0wjwdgoQ3p3ykjU+f
	 z+t0QDtPONmcihkRbuFFRwM6w5vCYGKCAJavUwQcBvgKW/l0NNFrf+BJX09EVjTLs8
	 nNb5fSVcpHR6w==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8946a794e4fso5973086d6.2
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 19:00:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWC5bYG8eOQjJKdKwP71sYwspsyemxwHBD2jeuS+GVof9jxnFC5MAXRdoyg24F5ocBQ/qaNSyeDyIw4E+eJK44zlIWJ3yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCYo0ebk/QXFj0FkX1OLFXqYpy5du9WCnERpsm9UgwEkR201M
	Xwg4IVo1r7dSOda8SjTsrkzszRlcrLKgXTneccoS5xzNNkEPyRpB3BeYrtyTb/gTUP8uvWE85BX
	LNqrS78Ki9JdE7n/IRCw6+sBnOhDfh0w=
X-Received: by 2002:ad4:5fcc:0:b0:894:6d3c:224c with SMTP id
 6a1803df08f44-8946d3c38d9mr110250046d6.13.1769050858324; Wed, 21 Jan 2026
 19:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
In-Reply-To: <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 21 Jan 2026 19:00:47 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
X-Gm-Features: AZwV_Qgo-qjEoC_t1HYBQPgad9dLpsaDnf8VZt7Ye_LR1Q6ggGfcYM7fpBfpXmU
Message-ID: <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Paul Moore <paul@paul-moore.com>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Wed, Jan 21, 2026 at 4:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Jan 21, 2026 at 4:18=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > Current LSM hooks do not have good coverage for VFS mount operations.
> > Specifically, there are the following issues (and maybe more..):
>
> I don't recall LSM folks normally being invited to LSFMMBPF so it
> seems like this would be a poor forum to discuss LSM hooks.

Agreed this might not be the best forum to discuss LSM hooks.
However, I am not aware of a better forum for in person discussions.

AFAICT, in-tree LSMs have straightforward logics around mount
monitoring. As long as we get these logic translated properly, I
don't expect much controversy with in-tree LSMs.

> > PS: I am not sure whether other folks are already working on it. I will=
 prepare
> > some RFC patches before the conference if I don't see other proposals.
>
> FWIW, I'm not aware of anyone currently working on revising the mount
> hooks, but it's possible.  Posting a patchset, even an early RFC
> draft, is always a good way to find out who might be working in the
> same space :)
>
> Posting to the mailing list also has the advantage of reaching
> everyone who might be interested, whereas discussing this at a
> conference, especially one that is invite-only, is limiting.

I expect there will be RFCs posted to the mailing list before the
conference. We will incorporate feedbacks from the mailing list
to make the discussion more productive at the conference. It is
totally possible that some patches get accepted before the
conference, so that we can simply celebrate at the conference. :)

Thanks,
Song
