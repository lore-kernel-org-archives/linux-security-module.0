Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M4iSgwSJ"
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297C510D0
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 14:59:16 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db54ec0c7b8so2325686276.0
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702076355; x=1702681155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sr/41k9oKa6cm7fjNW5odDkAQdthFs3iTct9jZb0Zfw=;
        b=M4iSgwSJMMQvZPSdIJ5wtBFiEIKKFwCQDcswJbpwBbo3VzftbdYTGmiO3dkOdo6Op1
         HXZYWNwXqOSJMiehSCEVU89O0IuOpHVDlQ3VpwoabPlXVxAXdFfNcLY4m6e5XERpShgc
         aBViAS97The6remYHw289yuBTvVisdGSAx8+gIa7INQ+EkwyweTihGX7NSnwWnoelVrm
         ZzV/5GPizbPKepbtyd9Prob5MVqMh70G9egu32qwOZuo55BB4Q8VzPuds2klw+GeTZ6P
         rF6iQxbtBfvCO+2AxAzEzDV5QJbK5Mk8wh+rSFhRWnHpocOw6NdwRdtKaOCcUsrxAxsu
         ZHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702076355; x=1702681155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sr/41k9oKa6cm7fjNW5odDkAQdthFs3iTct9jZb0Zfw=;
        b=XwKZpQi6LTBpwnMP2u2NeM6HwfxeBbLPxrTf/D3JoXyPc7n6QwqbJptZjN/uvYeFLB
         lOiphWVMeSE+vUJehpbJUbW6LMXmvQ3jKts5mz4/NSi4M9NA03sASu5QEeTlkL8ax7VQ
         ybghQeJ3SqzaG7xljgoc3VA2GxMjukfhS9DT7kmrck+GPX0aQ79KNVP+XW0XvQw/xelb
         xgOEZWpWlLtnpZOvR3GptSmJFGciVHbZ7jnUbt3O0m1ulKecbCGNqalSX943QSUJxHIB
         P8wONkKhvqAYW17B51+hm2aN81VhBY870EjM+UgcrZevkJ9MPAoSabpAvCgbk8OyBa9f
         4mTg==
X-Gm-Message-State: AOJu0YxtpGm4k3TkwXr5WW6/a18xFD7z/sQX2LSDUIieTUHp8BA/vd2g
	Uu/t/v4WTBhxeHpHX9Qzj/fAF8GCD61QkuTv0se2
X-Google-Smtp-Source: AGHT+IGt4qmxjt5YZ9LtiGCXDAam9RB8Xo4/yrAZ1iVjSUlB8gFtZuldGiPAgFp0WjzpkAI5HliI2hJbK593Hq6IoXQ=
X-Received: by 2002:a05:6902:e02:b0:dbc:3924:120f with SMTP id
 df2-20020a0569020e0200b00dbc3924120fmr1181945ybb.43.1702076355288; Fri, 08
 Dec 2023 14:59:15 -0800 (PST)
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
 <202312081302.323CBB189@keescook> <CAHC9VhQ2VxM=WWL_jpoELu=dHuiF3Pk=bxNrpfctc7Q0K2DUfA@mail.gmail.com>
 <202312081352.6587C77@keescook> <CACYkzJ7TbwNOmSeYFANMK86wDx+0yyFgJGM6rp8ZXvQz+pxQrg@mail.gmail.com>
In-Reply-To: <CACYkzJ7TbwNOmSeYFANMK86wDx+0yyFgJGM6rp8ZXvQz+pxQrg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Dec 2023 17:59:04 -0500
Message-ID: <CAHC9VhQPc4k9iAXuifsWzAdkrWghyUh9NF6P0-oSD=5ZccpaLA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: KP Singh <kpsingh@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 5:40=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
> On Fri, Dec 8, 2023 at 11:05=E2=80=AFPM Kees Cook <keescook@chromium.org>=
 wrote:
> > On Fri, Dec 08, 2023 at 04:43:57PM -0500, Paul Moore wrote:
> > > On Fri, Dec 8, 2023 at 4:13=E2=80=AFPM Kees Cook <keescook@chromium.o=
rg> wrote:
> > > > On Fri, Dec 08, 2023 at 03:51:47PM -0500, Paul Moore wrote:
> > > > > Hopefully by repeating the important bits of the conversation you=
 now
> > > > > understand that there is nothing you can do at this moment to spe=
ed my
> > > > > review of this patchset, but there are things you, and KP, can do=
 in
> > > > > the future if additional respins are needed.  However, if you are
> > > > > still confused, it may be best to go do something else for a bit =
and
> > > > > then revisit this email because there is nothing more that I can =
say
> > > > > on this topic at this point in time.
> > > >
> > > > I moved to the list because off-list discussions (that I got involu=
ntarily
> > > > CCed into and never replied to at all) tend to be unhelpful as no o=
ne else
> > > > can share in any context they may provide. And I'm not trying to ru=
sh
> > > > you; I'm trying to make review easier.
> > >
> > > From my perspective whatever good intentions you had at the start wer=
e
> > > completely lost when you asked "What's the right direction forward?"
> > > after I had already explained things multiple times *today*.  That's
> > > the sort of thing that drives really bothers me.
> >
> > Okay, I understand now. Sorry for frustrating you! By "way forward",
> > I meant I didn't understand how to address what looked like conflicting
> > feedback. I think my confusion was over separating the goal ("this
> > feature should be automatically enabled when it is known to be useful")
> > from an interpretation of earlier feedback as "I don't want a CONFIG [t=
hat
> > leaves this up to the user]", when what you really wanted understood wa=
s
> > "I don't want a CONFIG *ever*, regardless of whether it picks the corre=
ct
> > setting automatically".
> >
> > >
> > > > While looking at the v8 again I
> > > > saw an obvious problem with it, so I commented on it so that it's c=
lear
> > > > to you that it'll need work when you do get around to the review.
> > >
> > > That's fair.  The Kconfig patch shouldn't have even been part of the
> > > v8 patchset as far as I'm concerned, both because I explained I didn'=
t
> > > want to merge something like that (and was ignored) and because it
> > > doesn't appear to do anything.  From where I sit this was, and
> > > remains, equally parts comical and frustrating.
>
>
> Paul, as I said I will include it in v3 and we can drop it if that's
> the consensus.
>
> https://lore.kernel.org/bpf/CACYkzJ7KBBJV-CWPkMCqT6rK6yVEOJzhqUjvWzp9BAm-=
rx3Gsg@mail.gmail.com/
>
> Following that, I received Acks on the patch, so I kept it. I wasn't
> sure if this was going to be perceived as "ignoring your feedback".
> Definitely not my intention. I was just giving an option for folks who
> wanted to test the patch so that we get the defaults right. I am
> totally okay with us dropping the config patch.

<heavy sarcasm>I'm glad you're okay with dropping a patch I said I
wasn't going to merge three months ago.  I'm also glad you're okay
with dropping a patch that does absolutely nothing.</heavy sarcasm>

Come on KP, you're better than this.  Continuing to carry a patch that
I've said I'm not going to merge only creates confusion about what
will be accepted/supported (see today's exchange as a perfect
example).  There is no need to keep the patch going "for reference",
to record ACKs, or anything similar to that; all the reviews, ACKs,
etc. happened on a public list so we have that covered from a
historical perspective.

I suppose there is a worthy offshoot discussion about consensus and
maintainer discretion, but I'm too tired and annoyed to give that
discussion the attention it deserves, so let's just say that when I
say stuff like I did back in the v2 patchset that should be taken as a
"regardless of what consensus there may be, I'm not going to merge
this patch."

--=20
paul-moore.com
