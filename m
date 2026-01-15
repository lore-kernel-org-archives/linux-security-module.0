Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974CA3C0090
	for <linux-security-module@vger.kernel.org>; Thu, 15 Jan 2026 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499358; cv=none; b=pVHEwBU02Uzag8FITUhLoY6Nmpjs2pMwbMcjRNBcjerOzbRWIZfpYvpjCoLZXMrp1KANEIEZxtqpHxWaqEvtrfSZqk0u+P71AWFE6B4cDCfh5Lpie6pkouP8j2lWJaekVdmCpONJSjknXA2kAiiaRenYdpt4WL+dzHrT0eau5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499358; c=relaxed/simple;
	bh=r2ZoM9+MIOa+QcaE7AC4306TvzCJdq+k26/pnFAJlBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYnjfK1zsBnBnwj8gREyIjUj8e2AvEaY2MMEkKoaBqo0GkPsSQke71c5gdbMTJeRSVGSVQoyTf47X2+b8maqsDMFUqKnxW6lD7AILIdkE5mNFHhs6d6i+wkgEUnDZgtgzZS5cW2/nGdi6DD4lOxy7sb2uizNGy7bCE4VMiBbhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SVGQEVnU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SVGQEVnU"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c0bccb8037eso490040a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 15 Jan 2026 09:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768499356; x=1769104156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxUuPcjo1SQv8ISCtatV7Vgux0xRRMO9y2bG++TCF50=;
        b=SVGQEVnUTIL6pc1GU0U348p8McJdlgDA6he5+QLcmsrzrA++nzGfecSUqfBC9AVXu5
         nQZfA8Y1iJUbe92hY490DnyqDXhdYmxbSLSrxibjVYCG4tfEQb5werjBzf0z6FSLTzbm
         I8VLZjjClnD6VNAVR4yA+IzPXFESfUK7Z10SHSMv5xVuSnSu42IKtJXtioKJJFi5CAZp
         4pDpzvsL+rblr5axaZolCza7pmlwAAgAcEUrH27N8gpVMgTjIg/rheLAQ8f5zHcKDcsQ
         YTZmfSEKv6dbQqjYIgZGTHl+B05Yrov0p9NNwoW+oZaObz0FZqd8+LVOnfGNE62iqL5N
         9G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768499356; x=1769104156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zxUuPcjo1SQv8ISCtatV7Vgux0xRRMO9y2bG++TCF50=;
        b=rAQbZ3l4UgFvKutOj/Gjml/H8b9EUCVdhuJ3FOYTcYJ/qIvOKfCwxh5CFbUfT/Qhbl
         R6uMRbzz5vFHSYhZ9HBa46MpZjsuEiRyYJ268TsonoA+/2CVj3CCoP20x7Oeyxwy9g5I
         q0Wq21IXpTwocWtTB/ba5y2b4GG9SB5ETcL/G451EELwRrNRsMUgW0/qfZzKAGRrJJ1z
         237jijiel0zU+8jXKYvjVlUEHb5RrMQWhfVJuPkY8/BaXWvF083FJFQWDxiJVc1QFeZN
         nR70RaMJTKNbUqYVboxzybhZoL2fmF/rbvFFGjyWmJdmKGg/eioa7aKgF8YAJG/qeCdY
         A75A==
X-Forwarded-Encrypted: i=1; AJvYcCVDhhlkWawN9qeewm6LuHd/RU3nuZBcKbwQvt1UfTaSh7WntBs0BCWuiKfxiL85FHe9BbkXIiI00BB4UmxtU8m1LVfYQxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo19H/XeJgKxKwXWGqXG96szIC/d9oZ08XFwcVCD9SXw9RrLUO
	+8sLhNimlhIU5DWeQNHomdqS9l9AKD8+nwKHVU2d364EZQDYPzH8AtOxfs5wsjEGsd/QFxhLicJ
	2WTuFvp489SzMbR6jcJvN7WSr8hdw86H2iZ2ijQjUCbtJ/MopMevzIA==
X-Gm-Gg: AY/fxX6CgXt5e9Mp7P9fSuUuis/ATMdaWMIA+4+sMB6XYpHBs38U/PuJHztR9o6krKb
	uvZYeUWUzv05cW7+Yxh4R2xnc3d1UzC8u92aTRLbbabe5FxXi+kYErR1je8wHNdXSbUiukavm0p
	OSY0lyFMHCup00PnFnTCgoV326ukpeOJQsdJOyMWu77Im5XM2/w8bGOdsiSU/t8Bo8U0TCGfnmS
	889BwcWvB1zsAM3AEf4gmmdmBnYBTwE2ZLsgRyMzerDYS2bkHmSzHj3VnE0Z4gTPGt/AGQ=
X-Received: by 2002:a17:90b:4d8d:b0:34a:e9b:26b1 with SMTP id
 98e67ed59e1d1-35272fb86b4mr184643a91.26.1768499355757; Thu, 15 Jan 2026
 09:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108154604.GA14181@wind.enjellic.com> <CAHC9VhTyvEVLGLJkkyQnSZYSj4-YHPz82BnDEUwMjU7hHdbFoA@mail.gmail.com>
 <2ea2e67e-8fcd-43d8-8cda-7df8d678d2b0@schaufler-ca.com> <20260115155555.GA18668@wind.enjellic.com>
In-Reply-To: <20260115155555.GA18668@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Jan 2026 12:49:03 -0500
X-Gm-Features: AZwV_Qj5DqRLuxu7lTWFleDDTcBZdqiXVfQvLug5nFGOdOELBWDLmeS0ZwCuxU0
Message-ID: <CAHC9VhSQdjc7+2NORuhhumxjKuNiXkbXeAoqq=D9fFJT-+HPRw@mail.gmail.com>
Subject: Re: Improved guidance for LSM submissions.
To: "Dr. Greg" <greg@enjellic.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 10:56=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote=
:
> On Fri, Jan 09, 2026 at 11:58:39AM -0800, Casey Schaufler wrote:
> > On 1/9/2026 10:51 AM, Paul Moore wrote:
> > > On Thu, Jan 8, 2026 at 11:08???AM Dr. Greg <greg@enjellic.com> wrote:
> > >> What is not clear in these guidelines is how a virgin LSM should be
> > >> structured for initial submission.  Moving forward, we believe the
> > >> community would benefit from having clear guidance on this issue.
> > >>
> > >> It would be helpful if the guidance covers a submission of 10-15 KLO=
C
> > >> of code and 5-8 compilation units, which seems to cover the average
> > >> range of sizes for LSM's that have significant coverage of the event
> > >> handlers/hooks.

...

> > If you would review the comments I made in 2023 regarding how to
> > make your submission reviewable you might find that you don't need
> > a "formal" statement of policy. Remember that you are not submitting
> > your code to a chartered organization, but to a collection of system
> > developers who are enthusiastic about security. Many are overworked,
> > some are hobbyists, but all treat their time as valuable. If you can't
> > heed the advice you've already been given, there's no incentive for
> > anyone to spend their limited resources to provide it in another
> > format.
>
> As Paul noted in the following:
>
> https://lore.kernel.org/linux-security-module/20230608191304.253977-2-pau=
l@paul-moore.com/
>
> Microsoft employs him to maintain the Linux security sub-system, and
> related infrastructure, secondary to Microsoft's concern over the long
> term health of the Linux community ...

You've brought this up before, which I thought was a bit odd, but I
largely skipped over it because I thought it might simply be you
working your way through learning how the upstream kernel community
works.  We've all been there at one time or another, and we all learn
differently, so no harm in that.  However, you've chosen to bring this
up again, which strikes me as more than just an oddity, but in hopes
that your email is due to an honest lack of understanding, let me try
to provide some background.

I don't have concrete numbers to provide you, but the majority of the
substantial Linux kernel subsystems are maintained by individuals that
are employed, at least in part, to support the upstream Linux kernel.
Personally, I've been responsible for the upkeep of at least one
upstream kernel subsystem for over (checks notes ...) 18 years,
spanning a number of companies with varying levels of employer
support.  Considering the number of people that rely on the subsystems
I maintain, and the trust placed in me by the community, I take my
upstream responsibilities very seriously; I've pushed back against
employers when I've felt their wants would have been detrimental
upstream, and I've left employers when my job duties have become
incompatible with my upstream responsibilities.

I obviously don't want to speak for the other kernel maintainers, but
I believe you will hear similar stories from many others, if not all.
I will say that in my experience the different individual LSM
maintainers have demonstrated the same level of stewardship and
concern for upstream that I've tried to model over the course of my
career.  In my opinion we have a good community here, and our failings
are much more likely due to human time limits than any malice or
intentional constraints.

> Given that, it is disappointing that Microsoft isn't providing
> sufficient resources to enable him to provide guidance to the
> community they desire to support ...

Continuing what I said above, there is no reason to disparage my
current employer, I can assure you my limits are entirely due to how
much time I can spend in front of a computer dealing with difficult
problems, both technical and social, before I burn out for the day.
Of course you are free to make whatever comments you like, but if you
want me to take you seriously, you should give some more thoughtful
consideration before speaking incorrectly about matters you know
little to nothing about (e.g. my relationship with my employer, my
work/life balance, etc.).

Deciding how to prioritize work is a difficult thing, and subject to
revision over the course of a month, week, or even day.  Like many of
us, there are a number of considerations that go into prioritization,
far too many to describe them all here, but one of the criteria is
simply an understanding of how many people will benefit from the work.
While an exhaustive document describing how to submit new LSMs would
surely have value, we've seen a number of LSMs submitted, and merged,
over the years that have been able to do so with the guidance we have
now, if not less.  With that in mind, at this point in time I'm
choosing to focus my efforts on other, more impactful tasks.

> ... regardless of that, we now have
> 'official' guidance as to the requirements for submitting a virgin
> body of LSM code:
>
> https://docs.kernel.org/process/submitting-patches.html

I would encourage a more careful reading of my comments before
repeating.  I "suggested" the document above, I did not say it was
"official guidance":

  "I would suggest looking at the existing Linux kernel documentation
   on submitting patches, a link is provided below."
  (copied from my first reply in this thread)

As Casey pointed out, you've received quite a bit of feedback on your
prior LSM submissions, I would suggest using those comments as a
learning tool to help guide any future submissions.  Just as with
other aspects of life, there are no guarantees here, try to learn from
your experiences and move forward.

Another bit of advice that I think might be helpful in your particular
case: focus on being a constructive member of the LSM community, not a
distraction.  While disruption has been seen as a trendy idea among
the "move fast and break things" crowd, when it comes to core platform
security "break things" can result in significant losses, up to and
including people's lives.

--=20
paul-moore.com
