Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EAB18396D;
	Thu, 30 May 2024 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717062468; cv=none; b=NbdtDx0BkTh9P3IVYDiWymR9FieEzHJU+C4JukAvi3qULl+VNvhu5x0KGRZz4Cw4D8BT6prtWEoTKNVoT5Cr9yFb6vPab6v3PMyBdK5GmbzdhInkdRWzzhDTHI04PNSFZT5z4IiMuoW03H+q1LDWe/8qWTxY2oNOa+1WroSMNlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717062468; c=relaxed/simple;
	bh=V5+yoBSzIP4N9nztoHDw9zEkT0VjA12EgOUkjZSYjQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZtvVRf1RjAsZ6s4iKEknYMca2EsBqjltRL+O7HBwxIBVtkxlH5nAxq4+NTfvK5KUijO7fOnHLKmbMWmMny+7y7h3F8yI27dvi0byrUj58uj91EZ8FHZE/BO/kkS5eT9FvQgoLfe/a82vtPHDuvUOvbe+XmsrAvMm0XtVv5JrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2+nXj8l; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2+nXj8l"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6302bdb54aso66089166b.0;
        Thu, 30 May 2024 02:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717062465; x=1717667265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5+yoBSzIP4N9nztoHDw9zEkT0VjA12EgOUkjZSYjQo=;
        b=b2+nXj8ltBw7eokFNLcSW+96QRKGVrnZizG/BZUmqqTAGDw/DbfZdc3Sw49CTNhImz
         y+6g7YTR6yjbfAV2Pojqk4NK4PKORrnpm8psNlzSW+CBBFxm7Na2o7E69+TyFCwsqfa/
         Al6Gk7Nd5Wp1fs1/G8Fa0XqjvcrhDX1lwp0jNLq2WwRZVJZsxZC6hJBU1RODvwiGnv4w
         uyf8F04RUoXjB6/B9y+TWSZ6ELMrqG2JF4hjqjvVfI/4KTpaiUSkxjU0vw1GoT9TeTlh
         dIMnH2i+E4UnBpccnZxLKVCHmjSXApk/KiFtE94z6+mkQyBa32E9VRaIRP4B+yOqtKRu
         8YLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717062465; x=1717667265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5+yoBSzIP4N9nztoHDw9zEkT0VjA12EgOUkjZSYjQo=;
        b=mjkkOadnksFUYjz1J0BKrxgUiCad7URpCyB69baFlIcqpKHdF4MTNGr+VI3T5xxS2r
         CLrcbEJ/IsQDBeALzTFGTTeC4oj/uTf2o9WY+F+NyIjdJRhRkI32GBUGFkRynK754kf9
         0NxGXJMfia023EX7SDJpgkP4lQ16HRkD7d60I+9HW3f7Kma+rjp1UO0GVAKDwkH37g5v
         1jWb4Hq3ssl+AW3uJAaEmccABa27veps0gcfD4jbehtOWE84WQHtDN2+TaKVRx6aInXE
         D9Bg7n+C1WQSxKa8g4wQBl0bgAy/JlCwaOEAA44H9UirtDPAyPnyJCd8Au1HxVpdizuO
         Fy3w==
X-Forwarded-Encrypted: i=1; AJvYcCV4qHsn9xy0neu/UBbRqgLL80sFMB+uQU9PCWD6SFImT4wQxwlJbqvIhEOvhQ04Up2ZB/Umk6cWf/qAylPLAXH6P9hxXQkK5YOSAVJY+V3IgfNoA4oBi/VE3jEwhSXUzeLCyp1G2a1Ec0Q8jnnr5JWXzMUP
X-Gm-Message-State: AOJu0YzbPxaOSSwRQ/AX5HXTEs6pNY/UyFQto97P4As5c6K9jdHbL08m
	OSOleeVF3IRFtISD5qRi3Dn5N/N8z5hwLroQFNhzA9/iGvZJ+pNhKQaCJ/Smf1EyEfq+6EZAOc+
	gHK7MqF5n+9vDDfyEOPobUYlcdwU=
X-Google-Smtp-Source: AGHT+IH50Rwm13AYK+wbRGw5mTFhtbcwPasoIeircptZi3T9RODgZKqlef74HGPeaeVaOrO9C81gfjUWVC/VzvTuIwc=
X-Received: by 2002:a17:906:2bca:b0:a59:a977:a154 with SMTP id
 a640c23a62f3a-a65e937f21amr104485066b.64.1717062464510; Thu, 30 May 2024
 02:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com> <096178c9-91de-4752-bdc4-6a31bcdcbaf8@amd.com>
 <4871a305-5d45-47d2-85f2-d718c423db80@canonical.com> <CAGudoHFkDmGuPQDLf6rfiJxUdqFxjeeM-_9rFCApSrBYzfyRmA@mail.gmail.com>
 <3b880c7c-0d19-4bb6-9f0f-fb69047f41cd@canonical.com> <CAGudoHEycK3iTO2Rrsqr56_Lm69rCzMRaYz11NLrOcn5gKB3RA@mail.gmail.com>
 <5c94947b-1f1f-44a7-8b9c-b701c78350b4@canonical.com> <CAGudoHFxma+H_iHPV8+gfEkHc0uwFD8=rJtFy7ZE3TH+7tGiwQ@mail.gmail.com>
 <78cfe966-33ec-4858-b114-57697e478109@canonical.com> <82556a16-3390-4867-89b6-23e5ff168b89@amd.com>
 <f9215243-5610-4838-a31c-5894b75905e6@canonical.com>
In-Reply-To: <f9215243-5610-4838-a31c-5894b75905e6@canonical.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 30 May 2024 11:47:32 +0200
Message-ID: <CAGudoHH44-StgWJ_A8nLRT0g8p+-E0Ajen7Ns5-QRe17cohY0A@mail.gmail.com>
Subject: Re: [RFC 0/9] Nginx refcount scalability issue with Apparmor enabled
 and potential solutions
To: John Johansen <john.johansen@canonical.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	"Shukla, Santosh" <Santosh.Shukla@amd.com>, "Narayan, Ananth" <Ananth.Narayan@amd.com>, 
	raghavendra.kodsarathimmappa@amd.com, koverstreet@google.com, 
	paulmck@kernel.org, boqun.feng@gmail.com, vinicius.gomes@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 7:59=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 5/29/24 21:19, Neeraj Upadhyay wrote:
> > Hi John,
> >
> > Thanks for taking a look at the series!
> >
> > On 5/29/2024 6:07 AM, John Johansen wrote:
> >> On 5/28/24 06:29, Mateusz Guzik wrote:
> >>> On Fri, May 24, 2024 at 11:52=E2=80=AFPM John Johansen
> >>> <john.johansen@canonical.com> wrote:
> >>>>
> >>>> On 5/24/24 14:10, Mateusz Guzik wrote:
> >>>>> On Fri, Mar 8, 2024 at 9:09=E2=80=AFPM John Johansen
> >>>>> <john.johansen@canonical.com> wrote:
> >>>>>>
> >>>>>> On 3/2/24 02:23, Mateusz Guzik wrote:
> >>>>>>> On 2/9/24, John Johansen <john.johansen@canonical.com> wrote:
> >>>>>>>> On 2/6/24 20:40, Neeraj Upadhyay wrote:
> >>>>>>>>> Gentle ping.
> >>>>>>>>>
> >>>>>>>>> John,
> >>>>>>>>>
> >>>>>>>>> Could you please confirm that:
> >>>>>>>>>
> >>>>>>>>> a. The AppArmor refcount usage described in the RFC is correct?
> >>>>>>>>> b. Approach taken to fix the scalability issue is valid/correct=
?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Hi Neeraj,
> >>>>>>>>
> >>>>>>>> I know your patchset has been waiting on review for a long time.
> >>>>>>>> Unfortunately I have been very, very busy lately. I will try to
> >>>>>>>> get to it this weekend, but I can't promise that I will be able
> >>>>>>>> to get the review fully done.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Gentle prod.
> >>>>>>>
> >>>>>>> Any chances of this getting reviewed in the foreseeable future? W=
ould
> >>>>>>> be a real bummer if the patchset fell through the cracks.
> >>>>>>>
> >>>>>>
> >>>>>> yes, sorry I have been unavailable for the last couple of weeks. I=
 am
> >>>>>> now back, I have a rather large backlog to try catching up on but =
this
> >>>>>> is has an entry on the list.
> >>>>>>
> >>>>>
> >>>>> So where do we stand here?
> >>>>>
> >>>> sorry I am still trying to dig out of my backlog, I will look at thi=
s,
> >>>> this weekend.
> >>>>
> >>>
> >>> How was the weekend? ;)
> >>>
> >>
> >> lets say it was busy. Have I looked at this, yes. I am still digesting=
 it.
> >> I don't have objections to moving towards percpu refcounts, but the ov=
erhead
> >> of a percpu stuct per label is a problem when we have thousands of lab=
els
> >> on the system. That is to say, this would have to be a config option. =
We
> >> moved buffers from kmalloc to percpu to reduce memory overhead to redu=
ce
> >> contention. The to percpu, to a global pool because the percpu overhea=
d was
> >> too high for some machines, and then from a global pool to a hybrid sc=
heme
> >> because of global lock contention. I don't see a way of doing that wit=
h the
> >> label, which means a config would be the next best thing.
> >>
> >
> > For the buffers, what was the percpu overhead roughly? For
> > thousands of labels, I think, the extra memory overhead roughly would
> > be in the range of few MBs (need to be profiled though). This extra
> > label overhead would be considered high for the machines where percpu
> > buffer overhead was considered high?
> >
>
> It of course varies. It was fixed at 2-8K per cpu core depending on the b=
uffer
> size. So on a 192 cpu machine you we are talking a couple MBs. Obviously =
more
> on bigger machines. The problem here is say the percpu refcount while sma=
ller
> per label, will be more in situations with lots of cpus. Which is fine if=
 that
> is what it needs to be, but for other use cases tuning it to be smaller w=
ould
> be nice.
>
>
> > Please correct me here, so you are proposing that we use a kconfig to
> > use either 'struct percpu_ref' or a 'struct kref' (using a union maybe)
> > inside the 'struct aa_label' and update the refcount operations accordi=
ngly?
> > If yes, I will work on a patch with this kconfig based selection of
> > refcounting mode to see how it pans out.
> >
> possibly, I am still mulling over how we want to approach this
>
> > @Mateusz can you share the dynamic switching counter mode patch series =
please?
> >
> yes I am interested in looking at this as well.
>

https://lore.kernel.org/lkml/1356573611-18590-26-git-send-email-koverstreet=
@google.com/

> > In addition, for long term, there is an ongoing work (by Paul, Boqun an=
d myself)
> > on implementing hazard pointers as a scalable refcounting scheme [1] in=
 kernel,
> > which would not have memory usage overhead as in percpu refcount. At th=
is point the
> > API design/implementation is in early prototype stage.
> >
> >
> > [1] https://docs.google.com/document/d/113WFjGlAW4m72xNbZWHUSE-yU2HIJnW=
piXp91ShtgeE/edit?usp=3Dsharing
>
> okay, I will take a look
>
> >
> >> Not part of your patch but something to be considered is that the labe=
l tree
> >> needs a rework, its locking needs to move to read side a read side loc=
k less
> >> scheme, and the plan was to make it also use a linked list such that n=
ew
> >> labels are always queued at the end, allowing dynamically created labe=
ls to
> >> be lazily added to the tree.
> >>
> >
> > Read side would be rcu read lock protected in this scheme?
> > The linked list would store the dynamically created compound labels?
> > What is the advantage of using this lazy addition to the tree? We optim=
ize
> > on the label search, addition/deletion for dynamic labels? The lazy add=
ition
> > to the tree is done when a label find operation on the list succeeds?
> >
> there are contexts where we are creating labels, and do not want to wait =
on
> some of the longer tree walk profile updates/replacements. If a replaceme=
nt is
> on going the idea is to just add the label to the end of a list and let t=
he
> process that is doing the tree update take the hit of inserting and rebal=
ancing
> the tree.
>
>
> >> I see the use of the kworker as problematic as well, especially if we =
are
> >> talking using kconfig to switch reference counting modes. I am futzing=
 with
> >> some ideas, on how to deal with this.
> >>
> >
> > We can disable queuing of label reclaim work for non-percpu case?
> >
> maybe, I am pondering ways we can deal with this. I have been pondering t=
he
> if we might be able to leverage a seqlock here, but I will also take a lo=
ok
> at hazard pointers.
>

Since there is some elaborate talk going about this, let me throw in
my own $0,03 -- I may happen to have a simple solution which will sort
it out and it boils down to storing local ref updates in task_struct.

Here is the context: creds are always refed and unrefed when creating
and destroying a file object. Should you have one instance of
credentials for a given user across different processes they would
serialize on updating the ref. Linux mostly dodges the problem by
always creating a copy on fork, thus only serializing within threads
of a given process. Even then that induces avoidable overhead if only
from single-threaded standpoint -- that's 2 atomics slapped for every
open/close cycle.

$elsewhere I devised an idea where cred ref updates to creds matching
current->cred only modify a local counter. They get rolled up when
current->creds is changed. That is to say there is 0 atomics or
modifying memory seen by other cpus as long as the process does not
change creds, which almost never happens compared to how often refing
and unrefing is implemented.

In struct cred apart from regular refs you would have "user" counter
and "distributed" counter. switching user to > 0 grabs a normal ref on
creds, the value of the "distributed" counter is arbitrary as long as
user > 0. users going back to 0 means we can release the special ref
held for that purpose.

I was considering implementing this for Linux. In my original code all
cred handling is augmented like this, but for Linux one could add a
dedicated get_cred_localref or similar machinery.

Skimming through apparmor suggests the bit which does cause
performance problems can be sorted out in the same manner.

Maybe i'll hack it up as a demo just for apparmor.

This would come with some extra space usage in task_struct which on
the surface may sounds like a non-starter. However, should you take a
look at the struct with pahole you will find it is riddles with
padding. If I wanted to I could add all fields I need to the struct
and not grow it on LP64.

--=20
Mateusz Guzik <mjguzik gmail.com>
