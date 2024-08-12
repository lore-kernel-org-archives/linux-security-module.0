Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E5175D3D
	for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475219; cv=none; b=bAD6nMYl4MBdqv92JA3y36vLRvg1PhMURCaQBTL7fd9osmYAja8MN5YP3fB+JQa10aZRQcM3uZjVLX4Y3luV8Efi0R8gfaYOW49/ROfFNsXDhDl2yWhLliG7iEWdormduOSJ6Rw50Eli1+EzGVWQj/9OwiwWzygF2gczT1MlcA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475219; c=relaxed/simple;
	bh=/le9A2aEVKUmIV4UkSEJp/ETmS0AvR1tTz3Yj+RukI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZwPdA2echParu5NGwKVDkRRp8MosOUPP4XRXeI9SpssCqXO1usKMfHQLvpB/Z4MnsCBupaImu3TTMncTyWqWkyTI9ImVnGcQ3cfWATQdrm1WvxpjmJ/4HplwPTdtgQMDBbHVrJH7grXkzSP2FKgFmoh2wTgOzEeeBRrlV/a2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PH9uJ1aj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PH9uJ1aj"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so15010a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723475216; x=1724080016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/le9A2aEVKUmIV4UkSEJp/ETmS0AvR1tTz3Yj+RukI4=;
        b=PH9uJ1ajF+VwsbFmieHQ/jDrNVgDM9gz+/DwqwKIF639c7FJEroC/+cyv8n69v5Isl
         nXUvZJkMXhotNViuWUQOirS8pm8gCgFTYB1LhjzaD98BUiDA/5TZqcIa0l6gnVVkYsE0
         3wjH3PKctHMrh58LjomGY94dm4VhgSPE6Ks1f0xB2oj17ZlEgpGq53395gDutO15JB9B
         RmbjYBWtTvvPI7DvFZnzQGmyfawvk0JNUpRXluI6yWZHmckLUyvt06mxzxrJsCpvTriw
         qWHpsD+J81TuG7gAhzKsvLNCvYeEKwRggvxtPQEwwZpiilLZAwmndZ7aoyZNd0TRnKck
         dIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723475216; x=1724080016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/le9A2aEVKUmIV4UkSEJp/ETmS0AvR1tTz3Yj+RukI4=;
        b=QHfN/h13mMc8xOT8jTtRyGFVOpFYfkXDeU3TTfbd0edSip0GA+v+OyKnV2dw+bx2J2
         Aum2EoFzBEa3tG495RwTXDbO+cBTAZKRUTvIIt09Yc7mIMndDHHpc5UeqITWXKCiRnSh
         TQ3dgGFXp8bp0deN96TdJbJ4euJ7acE3wY/0kmdKuVu341EAd6C6pjZDMWhRWN+5/RRt
         p7hzhqt2eCbHIpb8oVNdSisDXwldLEjAXJMrs/k6X7IFlN1ThwmfAnTyZ3sTkUx/QDYi
         jAVt+7OwMU/luebeM1NAF19qTvgeMOW8okgFqhosa5iGUom4B53HCBsqx0SFdvLrSxRp
         naaA==
X-Forwarded-Encrypted: i=1; AJvYcCVPB6WnIFLt4qq4S/OQwhCl3gTCMhj5vHNffCgBqKNoqAD/CbClLVO/5/8c/tfdgSxDI3cH3kvRkz5wV6Mz58yIaX9mhHfXN3IwQB43YQeZqA4OqJfh
X-Gm-Message-State: AOJu0YxfCSYLrcXPSYIM8FnTzTeg3eYS91FLHfyVqvnMjXDGEiJbH5+6
	xm0kQCpCnrLEesSMMMfCAfVE/+eKYtki0V+BbBkU79P7kduf+6VWHmZ3N/mWRp26NZbaLf7YQI/
	Ns2wY+SxMpyRwZeEV5qXLHnTGhPiVtRQnxUtH
X-Google-Smtp-Source: AGHT+IH0SfAmG8rb+QcktSGfHWi/AHs2OD7smK1wxxMlrDuISAWiDiKzS7E7leJ1IekWL3YFAERaSLWneIBYBvP6CMA=
X-Received: by 2002:a05:6402:5206:b0:58b:93:b623 with SMTP id
 4fb4d7f45d1cf-5bd1b40925cmr206174a12.5.1723475214958; Mon, 12 Aug 2024
 08:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net> <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net> <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net> <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
 <20240809.se0ha8tiuJai@digikod.net> <CAG48ez3HSE3WcvA6Yn9vZp_GzutLwAih-gyYM0QF5udRvefwxg@mail.gmail.com>
 <CAHC9VhQsTH4Q8uWfk=SLwQ0LWJDK5od9OdhQ2UBUzxBx+6O8Gg@mail.gmail.com>
 <CAG48ez1fVS=Hg0szXxQym9Yfw4Pgs1THeviXO7wLXbC2-YrLEg@mail.gmail.com> <CAHC9VhS6=s9o4niaLzkDG6Egir4WL=ieDdyeKk4qzQo1WFi=WQ@mail.gmail.com>
In-Reply-To: <CAHC9VhS6=s9o4niaLzkDG6Egir4WL=ieDdyeKk4qzQo1WFi=WQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 12 Aug 2024 17:06:17 +0200
Message-ID: <CAG48ez2tvHgv7sOVP14gCF1MAGE-UzJoMCfZqdmY1nXX4FFV4Q@mail.gmail.com>
Subject: Re: f_modown and LSM inconsistency (was [PATCH v2 1/4] Landlock: Add
 signal control)
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tahera Fahimi <fahimitahera@gmail.com>, gnoack@google.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 4:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Aug 12, 2024 at 9:09=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > On Mon, Aug 12, 2024 at 12:04=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
>
> ...
>
> > > From a LSM perspective I suspect we are always going to need some sor=
t
> > > of hook in the F_SETOWN code path as the LSM needs to potentially
> > > capture state/attributes/something-LSM-specific at that
> > > context/point-in-time.
> >
> > The only thing LSMs currently do there is capture state from
> > current->cred. So if the VFS takes care of capturing current->cred
> > there, we should be able to rip out all the file_set_fowner stuff.
> > Something like this (totally untested):
>
> I've very hesitant to drop the LSM hook from the F_SETOWN path both
> because it is reasonable that other LSMs may want to do other things
> here,

What is an example for other things an LSM might want to do there? As
far as I understand, the whole point of this hook is to record the
identity of the sender of signals - are you talking about an LSM that
might not be storing credentials in struct cred, or something like
that?

> and adding a LSM hook to the kernel, even if it is re-adding a
> hook that was previously removed, is a difficult and painful process
> with an uncertain outcome.

Do you mean that even if the LSM hook ends up with zero users
remaining, you'd still want to keep it around in case it's needed
again later?
