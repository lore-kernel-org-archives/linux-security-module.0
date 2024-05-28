Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C1C17C7F;
	Tue, 28 May 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903014; cv=none; b=sD8zqnXRLIF5LEa/uJnkb+8hFb4PjhPs03Jwtad95VoVIoExxzRYVBnDiMSOa4ak7k70g1k0FlhVIZgOrzLAdbHrgw5xsrfVrZ4YQAP4vttwObRHsfG78W2SVrgzBlrIom8HfIDPaAZfsjjCyTNWiGCCluj1L8n/uJ/GVNg0buk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903014; c=relaxed/simple;
	bh=KT035x9FB4QR+Y6hrveG8FjyfKimSkkfkMUdyuKTqZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYrldctYhO20Z1dnyPFZxvao80z3eCV+TB39zj4RDFywfX6OGLsit4Y5K7Vd/a+L+ExSqOa0BKXNevkCIK6IwDdA2oSM5vEy2fwGNu1WPZUv+S0IWaq/8ZltG8DuvuoqZLieFNiAc5ePKQERUVao4ECZtMpPKS5/TppbvPJHY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Juo9CSCD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Juo9CSCD"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5296232e00bso1058826e87.3;
        Tue, 28 May 2024 06:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716903011; x=1717507811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT035x9FB4QR+Y6hrveG8FjyfKimSkkfkMUdyuKTqZw=;
        b=Juo9CSCDePve2+0thC76PYPmAGnSO1RVePVPnM+bU+wDWC8uVoA7amPYSDGyx8NBjf
         XOtwfcyYw52mqH53Xo9Mpvtd5dFXayblB5evID46/s/LxMzcZ8sUGx09dzOyw2IMFuum
         uLh/zkII3jQXEHKsmL+Q5KV/xxx3dftxHtifWfh6KaDFypJ6HHkreZcNJRiODXZENlJW
         ldWbFOfC9maywAgZ+beNKwgaFXQRpurLJQ+Sr+An+cpAcpDnPPsMdlX3VJcRD8tviCTs
         IBUM7nOXldsPgqRFLBuOrOAxlVhoXf8hOptzpNuF5aVSgzWmxMlPmdlesNaWJPwr1xCW
         iAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716903011; x=1717507811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KT035x9FB4QR+Y6hrveG8FjyfKimSkkfkMUdyuKTqZw=;
        b=MpT8rSe1ipLFsMcimuo28EZFjsoliZ5tt6Q7rfLRkmV31+rnrBYCJfw1JNf/eKt/oV
         RWBH9IFlzK0f67eo0DUniWitYA0VT+Aoc+fiQnLI2XTkOsv9VSnx7IoAqOP49/zFNQZG
         LhpI9SVJQ95xxsyEW5/ywcfN+6vX23dvPsD+aC/PqhDDAL/S3U51Nb5Mb/8dNfoNKNH+
         aqzFMfx5a59aeMhiECzIXNLw+TKNBxwiIqX94gwsSZJP2wngbrT8uJQA/4Oy76u/W8lU
         1bgHPgMOhIbmYgEkJ54pw0ASfKjbqldnFAxWGxsAw7F6PMqkrquA7/mNc4axSKQXeVFF
         Wh2A==
X-Forwarded-Encrypted: i=1; AJvYcCUFNgDLz3dqCJQzn5YZ4AZelKJRAQS/3dZRfl0hhi7cjU+JPbWL8tIxRqMk8wHv3pdGp262O2NatMftqaH7OWPzEV2aqS24f1TKX2hr0mMPXlXy+R01vJ55Fq2/PGulEL8BtqCGGF+e+Lk96lhH4m3RmSyA
X-Gm-Message-State: AOJu0Yw36ss80YyB0yifXVoJPRh+eKprq2Lj0XvIwMy6f1yDw9z6XRyj
	lsXSnkz2iNdYhOyEEB42XdrPBt+/pjCm9cFwovId5fkqUxwCZbqa6LX2Af+z4GflPSEBhhW6y4n
	K9N6uRSgCztb4JKb0pnpIyZ5umWc=
X-Google-Smtp-Source: AGHT+IFc0lxBLf++tF3udPPlMPGgJFXB+KSBN0b/PJ93wp7mVKxQX+0iLdX9mh+ovziZjf2r3F7ekyyQsWk8TOj4J30=
X-Received: by 2002:ac2:5a09:0:b0:523:88e9:9cd2 with SMTP id
 2adb3069b0e04-529667cf983mr6448775e87.67.1716903010905; Tue, 28 May 2024
 06:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com> <096178c9-91de-4752-bdc4-6a31bcdcbaf8@amd.com>
 <4871a305-5d45-47d2-85f2-d718c423db80@canonical.com> <CAGudoHFkDmGuPQDLf6rfiJxUdqFxjeeM-_9rFCApSrBYzfyRmA@mail.gmail.com>
 <3b880c7c-0d19-4bb6-9f0f-fb69047f41cd@canonical.com> <CAGudoHEycK3iTO2Rrsqr56_Lm69rCzMRaYz11NLrOcn5gKB3RA@mail.gmail.com>
 <5c94947b-1f1f-44a7-8b9c-b701c78350b4@canonical.com>
In-Reply-To: <5c94947b-1f1f-44a7-8b9c-b701c78350b4@canonical.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 28 May 2024 15:29:58 +0200
Message-ID: <CAGudoHFxma+H_iHPV8+gfEkHc0uwFD8=rJtFy7ZE3TH+7tGiwQ@mail.gmail.com>
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

On Fri, May 24, 2024 at 11:52=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 5/24/24 14:10, Mateusz Guzik wrote:
> > On Fri, Mar 8, 2024 at 9:09=E2=80=AFPM John Johansen
> > <john.johansen@canonical.com> wrote:
> >>
> >> On 3/2/24 02:23, Mateusz Guzik wrote:
> >>> On 2/9/24, John Johansen <john.johansen@canonical.com> wrote:
> >>>> On 2/6/24 20:40, Neeraj Upadhyay wrote:
> >>>>> Gentle ping.
> >>>>>
> >>>>> John,
> >>>>>
> >>>>> Could you please confirm that:
> >>>>>
> >>>>> a. The AppArmor refcount usage described in the RFC is correct?
> >>>>> b. Approach taken to fix the scalability issue is valid/correct?
> >>>>>
> >>>>
> >>>> Hi Neeraj,
> >>>>
> >>>> I know your patchset has been waiting on review for a long time.
> >>>> Unfortunately I have been very, very busy lately. I will try to
> >>>> get to it this weekend, but I can't promise that I will be able
> >>>> to get the review fully done.
> >>>>
> >>>
> >>> Gentle prod.
> >>>
> >>> Any chances of this getting reviewed in the foreseeable future? Would
> >>> be a real bummer if the patchset fell through the cracks.
> >>>
> >>
> >> yes, sorry I have been unavailable for the last couple of weeks. I am
> >> now back, I have a rather large backlog to try catching up on but this
> >> is has an entry on the list.
> >>
> >
> > So where do we stand here?
> >
> sorry I am still trying to dig out of my backlog, I will look at this,
> this weekend.
>

How was the weekend? ;)

--=20
Mateusz Guzik <mjguzik gmail.com>
