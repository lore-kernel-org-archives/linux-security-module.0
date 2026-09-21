Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDFE30E838
	for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958010; cv=pass; b=SNwvvjmWfH7lN+G+4y89Wh0pEvEEUNfQY8m4rWezj6mXzihD9+YU6ty8tc2JhcYTBeqUl5r0pDZo4xsfI18QdNEH2OvNwXpRyivCSYfg7w80awJOf8RX0XXwcmzmHkak0iDD3OfnPNc2s3ziLz7BgjI6a39X/lOEnY5Xnrcs52I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958010; c=relaxed/simple;
	bh=J3vCu+pHHGK9T6Xt/sz+9R2/9vPugUzaNwdrlkLd5oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJpFhuH14LHNntnx0lY0Ci+OBoomafEfb8HPyzTc5ICL25phYaB5qt0azyRMWOJqRJSk6IgiTS9JQ5By/ocF4fMCx3KK7bJFcxSTUM8n2/7r+s2jK95HDMcwl01uUWGUCwAv3Uj84ywitrSauEOWXHOF8vzKfjE+/7RdLx+87uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MvLA8liI; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MvLA8liI"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5121bcf1aso2050819a12.1
        for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 19:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789958008; cv=none;
        d=google.com; s=arc-20260327;
        b=qnthnaitWaTz6jXtAZAjLgWPESe2vTE4hN1mdFjYBGWFRDgAXqgJgFrMNLcCBiCkPb
         9i/aXI5E9Tg8VqKlc/1ginLjKcZa8gTvvWJXLGsGBQdV3Zo+uGwki6YPM2NZr+/21Hyc
         +0rICwawiU/rw8ZobKWQP3oviEPBlGkHwiKy8wJ5PGyjZMO0Nqdph+TbpUdeJc9fSM2d
         cEGIaL4RZLqjt55zAUMfVEvsTtEme733Ww0eVu+HTBUpAXn/PPcbKgcgDUSPpq7wXO2C
         bw6z+mmEHZdCdGTjOGKhtNOmt/+eNwDbdY57BewJWfD7HJlDhbWTU2ViDhdfujWnh1ie
         2W6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y0CX9NjM39oZwYo/+39OeXBXc2j3TkyIq6Vet5QN2Aw=;
        fh=KbeLkQfvxQcpsj0RbR6YFRQcIYb7CMZA+rlW20ArtQ0=;
        b=fz2ZS+Sy78WRs4+nN1F/rsFytQSWSXCrLpr7d0JmWD+SNSyxYU5wv4HTEVyjs2MUpz
         OmKlBg0YkmJ9q7ejfym1yDUe4OoDuNbPvL/KMW7BrMcFEr+8xLHsK/IQ+0vN6Dmg1wmt
         4ZCmdqBawxtpwjNIJOi6yKhoB5rPbucdO4jKMlWnr/wScoAI+e/MjwyF1dUXN8+yCEAd
         LPa1+wgG49YCCAYBUgpBCeL0DhNpBYuYrRwBZ5mfKOBbvw3Hs0NGfr/QyYpmhaUrBZJR
         LBvoTaqW8en94nhdFpqSP80LMIadiqSjjMAhfS9GQEjTPPwpFZishtQnlWfQ36/Wj/iT
         3ZSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789958008; x=1790562808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y0CX9NjM39oZwYo/+39OeXBXc2j3TkyIq6Vet5QN2Aw=;
        b=MvLA8liIOnCDsY9Xgef7LSuV1d83UKiqFKIyA4l9PoHjlXoL8slmr9X0xPA2AsbiIg
         FdUrbPWbSBKM0Vtfxhe50Xz7TSLrPY7Y1z6u6qWuqk87gjTAGpX0mDiAZlq5NVyU4Gj4
         SaEjHBukdPbBkYqXeN2omfZjk4lUiutogvXMwukW09N0y5r8C4T8wDCbI8ClAopxmKKS
         Gz5B8G9ohVad0DF9X83p0oCcad0zErKxtgG5OlbPYVXELHSrGwOkYdSylXTTec2ucdqZ
         NLrcqUGJLpRSKQkg4hpB1uSef69+geJVbI1E7yQpbSEWwGaPWEe8rF27QkkZfz+VtBJl
         yAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958008; x=1790562808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0CX9NjM39oZwYo/+39OeXBXc2j3TkyIq6Vet5QN2Aw=;
        b=IE8TlU1zff6/LDM/JU6+dKF8OrDVgy/9z3u/6UpZo6vq/xujofeOKwGaURc4OyTkLd
         8GOlRg6lb6nzAkAHPmj6NclY4r5lta4pUkqpEdJiYRfSwy+QMIoMeWPZwQeuAsKR2qit
         rIRqz7mfDyoe7rn6dnuD++P1EgcUOp7LAiSTnwT8CdVi4JZm+y4saedyxSK+37fa+jLZ
         SYwuxLROqi7O6x5it6YGsRIxvCjS0hjI6HY7pg3plbhXlvRFr6Hjlavt5XD+EqOO8MIo
         WX9LVh5xwjWM7Vd0+WoISlhXtHQGHraKAH2RJbXZqR858xYGAuXDEo4wYALIJdT6OdbX
         /Vog==
X-Forwarded-Encrypted: i=1; AKwUvBxBcc7w2ewLaJ+oVQE0ClZ80KgdfySLTMyTqH0cBE9JKpv8oR7TXKvRJp+yxXBPZ90BR3/oqI+OknGcl32P1nbMEEZGvwo=@vger.kernel.org
X-Gm-Message-State: AFuF++mqnC3rVpteyOoilqPrueyaIF1WLM/MqmyzP+uEZIQ+r4IqPEUw
	seidFJD4wtfB5UZab68SEtqaeZlV9iRQH2leRcbc55QrGTxads6R2aoJ/Kgmg9J1+AyfRqU9S5z
	H++LDlxHOYycQpLtCz9+nALZ8i1vRYxbv12tXVyMW
X-Gm-Gg: AYBFou0i+pC0hPWvvulofPKAG1xm6/Mkh2vkqpX5F5nK/Pg0f4EGnGlGCw+b7xsEm5X
	FOS4UWrL3jiKkGpCV003jwfsumMdRym1OVgZz+WFk/kFvLNlNEoFjpg3ICboQym0XvuGzxDbZyf
	HNATqEE/97aPtZk2YUl+g+EZaMHrGhxlkLuIGjjyhfX+0E12fGrvLZ9AVzIgmNMXlm1Po/8BXBM
	HP+RUf7TIcP+iZVhu5imr8tw8n3WdvwaIYfKvw7oi2K9ZABHWwqmjFa8yhKMekrhRMHozIGpDMU
	QedacV0owUiQfSjXR+d2MXXeKhW/+04y34pGS0WmiIEiblqg8wUJUMwZtiLpQ+N0eD0JT+XpXPa
	kFAIhSCy7
X-Received: by 2002:a05:6a20:394a:b0:3dd:a196:53a5 with SMTP id
 adf61e73a8af0-3dda19654e2mr9716786637.71.1789958008327; Sun, 20 Sep 2026
 19:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260910-wohnbau-bezwangen-wegziehen-7a32dcf237b1@brauner>
 <CAHC9VhTE82bRRSXSUuMOdrfoMh=xOb5hDvqiKWzBKD1urab3hA@mail.gmail.com> <20260916-begossen-tischbein-abgemacht-e7dada3d1e56@brauner>
In-Reply-To: <20260916-begossen-tischbein-abgemacht-e7dada3d1e56@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 20 Sep 2026 22:33:15 -0400
X-Gm-Features: AcwNN1XJfic_AjA2ynJbPwX0hNkODxVU2hbKAKXrt_cjhAGvAIE6GT_12dvWT8I
Message-ID: <CAHC9VhRDpR+o9ThzajboAW4mpQWG7Yy0FemuowviyQXYvji7Qw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] proc,security,selinux: let SELinux block
 FOLL_FORCE for /proc/self/mem
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 5:01=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Mon, Sep 14, 2026 at 01:05:39PM -0400, Paul Moore wrote:
> > On Thu, Sep 10, 2026 at 3:48=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On Mon, 07 Sep 2026 23:00:15 +0200, Jann Horn wrote:
> > > > proc,security,selinux: let SELinux block FOLL_FORCE for /proc/self/=
mem
> > > >
> > > > The goal of this series is to let SELinux prevent the use of FOLL_F=
ORCE
> > > > when a process writes into /proc/self/mem and the system is configu=
red
> > > > with PROC_MEM_FORCE_ALWAYS (which used to be the default behavior, =
and
> > > > is still used by current Android devices).
> > > >
> > > > [...]
> > >
> > > Let's move this on a shared branch that both the vfs tree and the lsm
> > > tree pull. That's the standard way of handling dependencies between t=
wo
> > > subsystems that want to route code that touches both of them. Branch =
is
> > > stable.
> >
> > For some reason (/me looks at gmail) your email never hit my inbox, I
> > only noticed it now while reviewing Jann's patchset.
>
> Oh weird?
>
> > Christian, can you explain why you merged LSM code that I haven't
> > ACK'd?  We've talked about this in the past and I think I've been
> > fairly clear about it; I wouldn't merge VFS code without an
> > ACK/Reviewed-by/etc. from you or Al, I've been expecting the same
> > consideration from you.
> >
> > While I don't have a problem with a topic branch for this, can you
> > also explain why this topic branch should live in the VFS tree?  There
> > are more changes under security/ than fs/, and unless I've misread
> > Jann's cover letter, this entire patchset is focused around enabling
> > LSM/SELinux controls and not necessarily anything really new from a
> > VFS perspective.
>
> See the reply on the bpf thread. I think this just a misunderstanding. I
> was under the impression that with minor tweaks v2 was already acked by
> lsm people.
>
> In general, if a subsystems hooks into the vfs layer and filesystems
> that are directly maintained by the vfs layer then the vfs tree provides
> the shared branch. This is not at all specific to security. It's just
> more pronounced for notify or security because hooks are accepted
> layering violations that place constraints on how vfs code itself is
> organized.
>
> I think this is just a misunderstanding that would've been easy to
> clarify without the kerfuffle.

I'll follow up in the other thread, but I will just say here that had
this been the first time there had been an issue like this, it would
have likely been different.  However, from my perspective this was
continuing a pattern of behavior I had previously talked with you
about changing, and as a result I was much more annoyed having to
revisit the same process issues.

--=20
paul-moore.com
