Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="K1Erv+0X"
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB41D54
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 13:44:09 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db632fef2dcso2699232276.1
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 13:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702071848; x=1702676648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+K+9PWObK3AB4WVpJbf7LX17OFUUv6uzQb9uZjuMrI=;
        b=K1Erv+0XiW067a9Tx0hulEtAYebmbTJbRk4yZx+NlSj43AYqVKeoFJvwwbqd6CYN9m
         MJ3lS417KPz/1Bc01qXsFP+tiNhWdmn7n+W5chiJCRJAVW+J3RLfMLnud3KpyopwPj+i
         AcpAA6mvWrSeDJqOJWj3XaGe5FBO1WdtWFbphSVjL2PleyX5RGyf7FHHAwMb7qv7yPaL
         H51JzR0or+JrjJnYVHv4AjWd+8/06z4pEDkKCaatiBHuowLoVm/2pu0+mwv/Wacq9l88
         HTcIMKo6yUQtQGBYjM6K0JIt2qJP+tts+fnQltAKFH3NHfvGphwCE5l1wUJYFb280jjZ
         KNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702071848; x=1702676648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+K+9PWObK3AB4WVpJbf7LX17OFUUv6uzQb9uZjuMrI=;
        b=fX5FjD/Y+qgxRvCocbxtsQBzx097j5mt4RJ6ZfYrwNAXxn9kaYIdyLU6FAE/6E5yOK
         qCmRKL5f2efyD+8enpu+0G9AoicN+KSHhSYiyH5PMWU0h8uohzXBBHHSKmBFtIS4t826
         fDS72GXvbxHsxfMWmr9o6Ck2UX4vcNUb1GFRtmUfMRHGQsoypLFIBqxSYfSrV3tyQyFs
         m5jggwVxtDE9RHSKR08FqJDyA5JvT3DDvyVE+iEFM/CfdUOBWGr6nebRQ+OeHtrgVvZS
         OL6o5lKgXi+j14hm5X9n1MmOVSsCjgzJK7i6KqxFE+cE83H15uFKo4JldCCOhRva7h8G
         6nIA==
X-Gm-Message-State: AOJu0YwwC7U8F8X3uke9U0bsiGvvRxoJBYV7HcNe4mJLOapwpsa8QQkf
	r6UWb7ftTWB7iaIMAnphGaOz5DFNEKFTJliFbWJc
X-Google-Smtp-Source: AGHT+IEkscpRUhjbdoub0t2Ee2q4GKbGdFEWTCCE3QwBuljw3SIOhfShAUVFdCGtYGXq6QkNVzEQONH+to80tmBOpRI=
X-Received: by 2002:a25:ab11:0:b0:dbc:3600:d80e with SMTP id
 u17-20020a25ab11000000b00dbc3600d80emr658263ybi.96.1702071848637; Fri, 08 Dec
 2023 13:44:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110222038.1450156-1-kpsingh@kernel.org> <20231110222038.1450156-6-kpsingh@kernel.org>
 <202312080934.6D172E5@keescook> <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
 <CAHC9VhRguzX9gfuxW3oC0pOpttJ+xE6Q84Y70njjchJGawpXdg@mail.gmail.com>
 <202312081019.C174F3DDE5@keescook> <CAHC9VhRNSonUXwneN1j0gpO-ky_YOzWsiJo_g+b0P86c9Am8WQ@mail.gmail.com>
 <202312081302.323CBB189@keescook>
In-Reply-To: <202312081302.323CBB189@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Dec 2023 16:43:57 -0500
Message-ID: <CAHC9VhQ2VxM=WWL_jpoELu=dHuiF3Pk=bxNrpfctc7Q0K2DUfA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: Kees Cook <keescook@chromium.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 4:13=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> On Fri, Dec 08, 2023 at 03:51:47PM -0500, Paul Moore wrote:
> > Hopefully by repeating the important bits of the conversation you now
> > understand that there is nothing you can do at this moment to speed my
> > review of this patchset, but there are things you, and KP, can do in
> > the future if additional respins are needed.  However, if you are
> > still confused, it may be best to go do something else for a bit and
> > then revisit this email because there is nothing more that I can say
> > on this topic at this point in time.
>
> I moved to the list because off-list discussions (that I got involuntaril=
y
> CCed into and never replied to at all) tend to be unhelpful as no one els=
e
> can share in any context they may provide. And I'm not trying to rush
> you; I'm trying to make review easier.

From my perspective whatever good intentions you had at the start were
completely lost when you asked "What's the right direction forward?"
after I had already explained things multiple times *today*.  That's
the sort of thing that drives really bothers me.

> While looking at the v8 again I
> saw an obvious problem with it, so I commented on it so that it's clear
> to you that it'll need work when you do get around to the review.

That's fair.  The Kconfig patch shouldn't have even been part of the
v8 patchset as far as I'm concerned, both because I explained I didn't
want to merge something like that (and was ignored) and because it
doesn't appear to do anything.  From where I sit this was, and
remains, equally parts comical and frustrating.

--=20
paul-moore.com
