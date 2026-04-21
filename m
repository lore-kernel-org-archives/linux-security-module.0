Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014563A75A7
	for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809430; cv=pass; b=DCQXuh/fc6WfmRpiB/i/+ER4M1nWgUTXtuKsV9tQ1lno+nYWf80ptWMTGrqm/+CBiJzkLzsIMY7FclCEr38mdqbHT13A6JoVLBsug9jplye2XmZEvYIW0fEEWSvE2p3QLr6ysiTp7g3vDfgFlBJiiAkALo63GfzjIBFVhbTkg48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809430; c=relaxed/simple;
	bh=xFXFGWyulzpS5kgQ1H2MDTMFPA/U/219DnWbJY3bqbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxR0qEblXmsvHJutbJgiNIDSz1EDWL6xkW80S2loy5EBfc/ImPFp6XrfpOmeTBY7c2nZmRoI2yXwzgzGKrnbeMDXtb7+Vz5dP5vjRh09nZHy3y5dVKkKk60Ad8d2IraRy6B3DOFe9X8mJNsPoBhQ+itXy8+rxTmPOfXOoybMq20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CymeQB43; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CymeQB43"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1901493a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 15:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776809428; cv=none;
        d=google.com; s=arc-20240605;
        b=LFlEaUA9h72uM9TN9k8zvwExOE5NHlQzduQxsqqIrIcMhE9Nh6ukwjtd+JPeJIY/bD
         bPf/7w8roh9DfxkBIxuwpDP8SU7X5CH7eDnksdr5WhawBXzwQoOdR7hifQbxvcHK8q8l
         ai6qZmmqMu4WYVw+lvaK6tXVjD7VTWphQLBPs8V88lgc47Xf0EcYebZmn/dKNFwGaWnh
         rfhWhOGF4pn2F/jdp3qZbcSvFIVuJJau3mhoeVspyqfOKwDI1wn/DiNbFZdeyemMor/s
         iRjat6ar9FSldvFYDcxGskkbF97nWQ9YyzXYuvslQXvFh3P3fgi46NRzZ3NRA45BMISP
         pP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AiGwsmPVPMIRS9FmLSReJQ9g0VW0y/S1QWZXVUVPj4c=;
        fh=awSC81vrDuJc1MxbtukWa/LVQyPmYX4CYEtOZxSBBE0=;
        b=OpcG+v9WM9T0g3uE+cejO8qZREAMV9wk5R8UWq4tbvpEIDUFXnbJejq1qn8BYXmNJR
         f8bmSZuv0OsB1eTCP1/hPiDsRgIvNckvKOGmbjlqdexOIHgF3PDK0K4+e+0MJUrK4FY3
         HeKo19xRW80QeBlnFhrb/+2BttsfnXUd0xJi10qLdlEUHCFo8ENiLL30AgA7qFnlkFtd
         G57yXqeHZJRRd+EKQUhyvZkoyTlM5uiJCChcjgZqTgiuxIJ4kv2o7+B3MD5qaIiXtm/q
         a2xYKTvC7nkBghUCW37T6S1+INW3CcO83dCT8sHIuDgE+WjGXrA9twMTAK1tDxIWVlKh
         UxOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776809428; x=1777414228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiGwsmPVPMIRS9FmLSReJQ9g0VW0y/S1QWZXVUVPj4c=;
        b=CymeQB43g+xgXJkvDnYkNZWs7GQqQn1p0+1Mp1dP+MUiiv2jL58H8azLIiUlG+C0CQ
         oVKVMDkL6kmEZJDJ0Al1sF5svSL5adj6rMz1Ie+h9FNhm+DTGzUW7USpBsRaI9Fit8Dm
         vVJRWetTHq/Zlx104bdtYXQZwnM1ALCHL6Ctr6y2TFxEtxpBKRkVRcGeDe7a18igmPbA
         OZqoHjQXWEONHQzAf+ftKhWbI8IUuf/VvuS5Vz/dFmUjQOcDMWaLXmcdi8vks5J8lExi
         LmZ1AlOdF+vfRsCjqb8V5ZrC9Ea8TeMNY+Gw2Jrka+cQzaOeRFx2iA6rpZ31/Eg70bcg
         6r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809428; x=1777414228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AiGwsmPVPMIRS9FmLSReJQ9g0VW0y/S1QWZXVUVPj4c=;
        b=FJRvRxJzz9sxd1sfoOacwVyqBgkMwu5Ku+p1iAoSXddzcF3ibAAQo92Z7lq7lShUsa
         68j77lzmWaK1MTfmo9IPUvE4LW/ZCt/WqXZPJ6YInLRBD/dE0yuwNSNofDRrcQJ0DoZJ
         dfTOgovLaBaRnZgO+1scV+DHLumUOaKPdJkrBS+kHD5Y0qZdaWyFLrdjmCQOreJCISZW
         5rzKb2kHJmO1YQNj2r7gTwkX+RWHmutR25ZoAhRKx9vCRa9NK3eASnnN8yAvPmQwzVB0
         mE7Lcz5zUlcV5EuQEp6oDf5LEQgH62nXz5VY2Dpm5hDH7HNE0biWitqWUQOenZeMKVo4
         V60A==
X-Forwarded-Encrypted: i=1; AFNElJ+0/C+COvw8Am3yaLtAnlcqqQ7vDJlS13mcC3LxfgrDRG4y+xrB21OSuAMNv4I1m3uilsf4ALo8w0w59aicdKcp+jLXWNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf776/v+UpqmAEQA4j/GcXCsS3na67Q5+lWgFX7lxS+79Fzo+g
	R++NJTzWRYJJ2MTl6R8tbY4NfMC2I+eRnXpJE8cyycvpadayx0MACi6K7DqCUVNc8BXnEPyWwm2
	ZrgtWyzFjjvygsQMNCi+6LF+yEAbkBKdpe5vM/kQG
X-Gm-Gg: AeBDiev7iP+HcdbZSUYIGK9DvINl34D61kN0L24fiPMZsNAJ6c6xeivIGRAoYMbrVGe
	lHl3F9u/kquppwkDl20CTAFyYDCoZl/FnONfhBy2WHNnWEfG/QNKkH995IRXzRsKNW/dZtr7Tn6
	kvzPTBj/BZOugsPpak391xACJ8yUmFxrv8PQGTAqitlImFDNgh6sJMWYwbIybwT6s2uG0eQV6Iv
	eYMVnmkbK6Er0/NGbf3LLha3OsU97lLCMLtLb3S3uN1nlbO07rWuyfzgX779yJBUVtlN5YoxNlH
	FlnGfx8Kxhl9F7Qqf4Gl0WFucnhS
X-Received: by 2002:a05:6300:8088:b0:39b:8dcb:f37d with SMTP id
 adf61e73a8af0-3a08d716acemr16416581637.17.1776809428374; Tue, 21 Apr 2026
 15:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3> <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
In-Reply-To: <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Apr 2026 18:10:15 -0400
X-Gm-Features: AQROBzAZx6KqlUgLuc6SEp8mHgK0_7ru1fA894kSMYQ0Oc1ORPoRRj_U35eYYmo
Message-ID: <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Frederick Lawler <fred@cloudflare.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 5:12=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Apr 21, 2026 at 2:07=E2=80=AFPM Frederick Lawler <fred@cloudflare=
.com> wrote:
> >
> > Hi folks,
> >
> > I was accepted to speak a little bit about this patch series at Linux
> > Security Summit this May [1]. I'm going to use this opportunity to
> > re-iterate some of the motivation, what can be done today with BPF,
> > drawbacks, and wrap up with discussion topics. I'd love to hear feedbac=
k
> > from audit, BPF, and security folks to work towards a viable solution t=
hat
> > addresses shortcomings to allow for better integration with BPF.
>
> I don't think any bpf folks will be there.
> Also giving a talk about it doesn't make it acceptable.

I think it's valid to have a discussion with the LSS folks as they are
the ones who will most likely be interested in using the
functionality.  From my perspective there is still value in validating
the basic ideas in Fred's patchset and checking the value amongst the
LSS audience.

> It's still Nack.

Based solely on the diffstat and a quick look, this appears to be an
LSM patchset, not necessarily a BPF patchset; yes, there are kfuncs,
but they are LSM/audit kfuncs and not core BPF functionality.
Regardless, I want to see how the LSS presentation is received before
worrying about this too much, but your NACK has been noted.

--=20
paul-moore.com
