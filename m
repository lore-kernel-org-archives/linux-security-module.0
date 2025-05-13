Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C5628F3;
	Tue, 13 May 2025 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747095020; cv=none; b=KTh6jqpoVvhpaql7OsMG+R9Xf2kdb9b19j3QovWrC4aQ61qtuFigjMpDL2Fu7f1cl5lzUAibWGXstqVynhYZt/Mj9AliYKu04S8P2EqhJT3y6uIV6YWjROZHBH814BG6kwUtEUoRmPvqqaFD+jnzk92AY1ef7Eg3AtgRBfslv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747095020; c=relaxed/simple;
	bh=BDDpyAkm8mUWkHjzl3M/Ww19BsFg0LLbVl5EU9dvudk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPx8UkqaAyvjkPQxbiTdY+pDgmlUo/EivzaJbkhkC6Xu8QSz8Ef0lboZE2BVPOKaOdJHqipJnBkSr6ctG4Un2QkMqRccQ+XXnGdGhZAP7s58++jTAiBBDJu2ZTFQHhu1dG7sWB3+WzN8lKELY1RkyLHdxKaMZy95uN2xrb/pAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8a9pT7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8a9pT7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF488C4AF09;
	Tue, 13 May 2025 00:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747095019;
	bh=BDDpyAkm8mUWkHjzl3M/Ww19BsFg0LLbVl5EU9dvudk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c8a9pT7qmL7m7+la5hTzwL2/bUgKtk31hKlQX3POVW5kSvWOZhNJIdTlANllPvfvf
	 mDQmUWR+AOIqG9MkS8E15SZ7WLHG6GUe8OLVAve44x6ixNV53z8EPp6bCfDvZUWpY1
	 MvySIJhMNDnsUaqf9Ymg6hJFBdZ87zTy8EfHOmKud4U7BEmbeQPYKfujI4oMFOkL8j
	 oowtFPkt4294Ou13W/eJSvfjc3aTviquM5wNpY8U8nxVN+CIFimy7MBIeBx6KohYfy
	 bLKhgXUw7Njn2fjPmclvtzcgcq3mC2i5ueNJ0JoDf++wS6ucQqAKpVW15Wd6UJCABO
	 fVaQ20xDpiHww==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-708d90aa8f9so46923617b3.3;
        Mon, 12 May 2025 17:10:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUl5u1I69vSiyNt3CvbAcY68qn2jFzCBwsRRr/83BAbKrSiTK++AShl35p2/78qWs52/DID+avPUiVzsiQ=@vger.kernel.org, AJvYcCW/wFRQ7l3/dnJSVtFxkcqkJrkUsowDylhkF4Eg92xbk6Vzr1uDt3BRxUnNfa2YmzvoHXvnl2Ny8r6grydqG1Cl99FetgUF@vger.kernel.org
X-Gm-Message-State: AOJu0YzOWA2ZEmYjmXk6uHbpuo3NTcPeoJGIpgStmdm0dMVl//fL5Az8
	BP/aax+hOxGB+mvvkgAxb3YobB+SYSm6/YqeTSK4di1cQkOuTIUwc+5XSWq0H+pKKYvnj1cOtJW
	O6qvhRT0AiH70/tVrsfAAzzYRqw0=
X-Google-Smtp-Source: AGHT+IEIF0c2ke/1klWIdASX3Xu++buwLzEZcBdDHlLXFskiSFKbrgNsih1kWPFMwkBf1BBrS3IE9UjKYQ0gjgpjWLo=
X-Received: by 2002:a05:690c:708b:b0:6f9:3dd2:7941 with SMTP id
 00721157ae682-70a3fb68f6amr216010367b3.38.1747095019062; Mon, 12 May 2025
 17:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508140438.648533-2-alexjlzheng@tencent.com>
 <20250509032326.GJ2023217@ZenIV> <20250509043712.GK2023217@ZenIV>
 <20250509044613.GT2023217@ZenIV> <CAHC9VhRp5Nb_1FPu8tF6EUsPpSEbbTT0K7a3V-Z7OWKNXy9Yyg@mail.gmail.com>
In-Reply-To: <CAHC9VhRp5Nb_1FPu8tF6EUsPpSEbbTT0K7a3V-Z7OWKNXy9Yyg@mail.gmail.com>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 12 May 2025 17:10:07 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGGQ0F_zfwNEs05Orsm6Vq+E82=eOd=YdbxiXUYW9O1Jg@mail.gmail.com>
X-Gm-Features: AX0GCFs81tqMm_BBRXejb3cTMNt7Xm4wAEQBkqhPLMdSkF1fk1mXY6euPqgpybE
Message-ID: <CAKtyLkGGQ0F_zfwNEs05Orsm6Vq+E82=eOd=YdbxiXUYW9O1Jg@mail.gmail.com>
Subject: Re: [PATCH v3] securityfs: fix missing of d_delete() in securityfs_remove()
To: Paul Moore <paul@paul-moore.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, alexjlzheng@gmail.com, jmorris@namei.org, 
	serge@hallyn.com, greg@kroah.com, chrisw@osdl.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinliang Zheng <alexjlzheng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 2:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, May 9, 2025 at 12:46=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
> > On Fri, May 09, 2025 at 05:37:12AM +0100, Al Viro wrote:
> > > On Fri, May 09, 2025 at 04:23:26AM +0100, Al Viro wrote:
> > >
> > > > I have fixes for some of that crap done on top of tree-in-dcache se=
ries;
> > > > give me an hour or two and I'll separate those and rebase to mainli=
ne...
> > >
> > > Completely untested:
> > > git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git #untested=
.securityfs
> > >
> > > on top of v6.15-rc5.  And I'm serious about the "untested" part - it =
builds
> > > with allmodconfig, but that's all I've checked.  So treat that as an =
outline
> > > of what could be done, but don't use as-is without serious testing.
> >
> > PS: I'm really, really serious - do not use without a serious review; t=
his
> > is a rebase of a branch last touched back in March and it was a part of
> > long tail, with pretty much zero testing even back then.
> >
> > Patches are simple enough to have a chance to be somewhere in the vicin=
ity
> > of being correct, but that's all I can promise.
>
> Fair enough, although unfortunately I don't think anyone has anything
> close to a securityfs test suite so I suspect this may languish on the
> lists for a bit unless someone has the cycles to pick it up and
> properly test it.
>

Since it's me who added the recursive remove, I'm interested in
helping get the fix tested and verified. However, I might not have
enough cycles in the near future. Happy to let someone else test it if
they have bandwidth.

-Fan
