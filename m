Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZmZkcjT5"
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F1CF2
	for <linux-security-module@vger.kernel.org>; Sun, 10 Dec 2023 13:52:58 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cd81e76164so36529237b3.1
        for <linux-security-module@vger.kernel.org>; Sun, 10 Dec 2023 13:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702245178; x=1702849978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHs8yYlfKwwc89x4m519U5rj021HblXAEEdZWCp+oQg=;
        b=ZmZkcjT5tunvPkX4nvQoJWByoqUed7sRDQju+COgAqyT+ZdM2ATmPB7m3haO2MT3Cq
         wnXuC1iZC8N1N/NclzBRJL4fI7XOpekApZm9cZVbtYy2s8vgzYlKMgIw/HMTzpL/iLll
         R63Htjq5K387U/ECXgDTZyGlpLxpgDXZlbljw5qI5MWOENRVHr7TdHKQyGRzHgHB3VDK
         JlrNXo+qLXmGzIEq7vzk+PrW7tpi5Ed529nKz/C9TxRO81QCheM6cfnuzRfy3i2oFaJk
         ltQQqvs4zFb7Cqh9RdGe0muLLhVLiG1O5WWYsaGtz/25kXYG9G3GdjCbcjOd05CAUwPp
         zqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702245178; x=1702849978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHs8yYlfKwwc89x4m519U5rj021HblXAEEdZWCp+oQg=;
        b=KrmK5zROfGupgBRty71OgjpDuNhI/WZAWIal3YGx1mHzpp+nwtc8+pwRJcwCdfBT1c
         W+UK7XMPr6rB6d2AbjX1Xy/NyEBS27bw3hEvaSmORDIFQgqyG3nJMc1TcEJ2GkQl5RNL
         8s0rlyGI7/Ke7KCGPSTrBRPBGmqMCLRwR7bxE4fSarV9MGt5SKCJu0ENZiQZRe8iO6Nn
         CKK1k7PLaE73M0+VGbhGNC7Mrr9C7M2Pykh1CklhcHBsbnkWUU6B2Jbr7n4Ap+HI4M36
         p3353l0OWRonpIlS70qnl00T3JCBRE7hbKkrBORnkP/WGfttmjAkPYFRgY8DURz5lU7n
         n4mg==
X-Gm-Message-State: AOJu0Yxczo/e8+H4G0FTr4VZzesWEhaGKvnSx1n8QeTxnSqX9jz8JxrO
	tAUOzNTMwLSGdyfC/Le6zDqM6unmu91D/fY+DfD5
X-Google-Smtp-Source: AGHT+IGjAgIJw0+ofxr1CkfN2OUCHhIbXuEeCEd0GxdjHa6T/w9f7V05cm0Sqc+uSUVNVEaf9mLLkdEPN+AH2TRjzCg=
X-Received: by 2002:a81:d541:0:b0:5d3:37fe:54bb with SMTP id
 l1-20020a81d541000000b005d337fe54bbmr2445844ywj.15.1702245177921; Sun, 10 Dec
 2023 13:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSiyZ_keXs7s9Me19YWrdb7hcRY7XecMPdEcj7Den9Cbw@mail.gmail.com>
 <20231209211743.194275-1-kamatam@amazon.com>
In-Reply-To: <20231209211743.194275-1-kamatam@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 10 Dec 2023 16:52:47 -0500
Message-ID: <CAHC9VhRyBeKPiy=BX+vm+_a7qcM5Pd-Svaw-kQbLpG-HbQOkVw@mail.gmail.com>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
To: Munehisa Kamata <kamatam@amazon.com>
Cc: adobriyan@gmail.com, akpm@linux-foundation.org, casey@schaufler-ca.com, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 4:17=E2=80=AFPM Munehisa Kamata <kamatam@amazon.com>=
 wrote:
> On Sat, 2023-12-09 10:10:32 -0800, Paul Moore wrote:
> > On Fri, Dec 8, 2023 at 8:11=E2=80=AFPM Munehisa Kamata <kamatam@amazon.=
com> wrote:
> > > On Sat, 2023-12-09 00:24:42 +0000, Casey Schaufler wrote:
> > > > On 12/8/2023 3:32 PM, Paul Moore wrote:
> > > > > On Fri, Dec 8, 2023 at 6:21=E2=80=AFPM Casey Schaufler <casey@sch=
aufler-ca.com> wrote:
> > > > >> On 12/8/2023 2:43 PM, Paul Moore wrote:
> > > > >>> On Thu, Dec 7, 2023 at 9:14=E2=80=AFPM Munehisa Kamata <kamatam=
@amazon.com> wrote:
> > > > >>>> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
> > > > >>> ..
> > > > >>>
> > > > >>>>> I think my thoughts are neatly summarized by Andrew's "yuk!" =
comment
> > > > >>>>> at the top.  However, before we go too much further on this, =
can we
> > > > >>>>> get clarification that Casey was able to reproduce this on a =
stock
> > > > >>>>> upstream kernel?  Last I read in the other thread Casey wasn'=
t seeing
> > > > >>>>> this problem on Linux v6.5.
> > > > >>>>>
> > > > >>>>> However, for the moment I'm going to assume this is a real pr=
oblem, is
> > > > >>>>> there some reason why the existing pid_revalidate() code is n=
ot being
> > > > >>>>> called in the bind mount case?  From what I can see in the or=
iginal
> > > > >>>>> problem report, the path walk seems to work okay when the fil=
e is
> > > > >>>>> accessed directly from /proc, but fails when done on the bind=
 mount.
> > > > >>>>> Is there some problem with revalidating dentrys on bind mount=
s?
> > > > >>>> Hi Paul,
> > > > >>>>
> > > > >>>> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@Ze=
nIV.linux.org.uk/
> > > > >>>>
> > > > >>>> After reading this thread, I have doubt about solving this in =
VFS.
> > > > >>>> Honestly, however, I'm not sure if it's entirely relevant toda=
y.
> > > > >>> Have you tried simply mounting proc a second time instead of us=
ing a bind mount?
> > > > >>>
> > > > >>>  % mount -t proc non /new/location/for/proc
> > > > >>>
> > > > >>> I ask because from your description it appears that proc does t=
he
> > > > >>> right thing with respect to revalidation, it only becomes an is=
sue
> > > > >>> when accessing proc through a bind mount.  Or did I misundersta=
nd the
> > > > >>> problem?
> > > > >> It's not hard to make the problem go away by performing some sim=
ple
> > > > >> action. I was unable to reproduce the problem initially because =
I
> > > > >> checked the Smack label on the bind mounted proc entry before do=
ing
> > > > >> the cat of it. The problem shows up if nothing happens to update=
 the
> > > > >> inode.
> > > > > A good point.
> > > > >
> > > > > I'm kinda thinking we just leave things as-is, especially since t=
he
> > > > > proposed fix isn't something anyone is really excited about.
> > > >
> > > > "We have to compromise the performance of our sandboxing tool becau=
se of
> > > > a kernel bug that's known and for which a fix is available."
> > > >
> > > > If this were just a curiosity that wasn't affecting real developmen=
t I
> > > > might agree. But we've got a real world problem, and I don't see ig=
noring
> > > > it as a good approach. I can't see maintainers of other LSMs thinki=
ng so
> > > > if this were interfering with their users.
> > >
> > > We do bind mount to make information exposed to the sandboxed task as=
 little
> > > as possible. We also create a separate PID namespace for each sandbox=
, but
> > > still want to bind mount even with it to hide system-wide and pid 1
> > > information from the task.
> > >
> > > So, yeah, I see this as a real problem for our use case and want to s=
eek an
> > > opinion about a possibly better fix.
> >
> > First, can you confirm that this doesn't happen if you do a second
> > proc mount instead of a bind mount of the original /proc as requested
> > previously?
>
> Mounting the entire /proc was considered and this doesn't happen with it.
> Although we still prefer to do bind mount for the reasons above and then
> seek a solution.

Ah, I had forgotten that you aren't bind mounting all of /proc, only a
PID specific directory.  I guess I'm not surprised this is behaving a
little odd in some corner cases and I'm even less inclined to support
a hack patch to handle this case; if we're going to fully support
this, the patch will need to be pretty clean.

--=20
paul-moore.com
