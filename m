Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30181E1E16
	for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765550859; cv=none; b=Kex7jR5sdeSgt+e0T+y+q1GiV2ximPpAfNeMrKl+3EBJj2/cD7M66N5/z38Mto7Mb8/fxCEKiCn53OT/2oygqmLW8SjHxunbJMmjHuyz2hNwNhfU2I5W3IpUaxDddYF8IfQ3r9Q7yohVS2tE4mQgFwGHGO1I/RQn2/aHkFH5o4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765550859; c=relaxed/simple;
	bh=4Kcvy0SzI9xOozyDWYlhlULDyoTueq/8f0ghOJLoNag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ll1A6Mqi6Sz04srF2pVFXrxuD/Km+ilMIXXhREqoa7swZm1mrkk0pv48sCinJhTq6iqnoFncYKbCWaOYdxWmLANbAWWboJw/0ln9lW1VbT/HxGSUHEuLoi9HsxHCUn1FQBSfVxxZE1q3GJ4p3CW6wiEkoABRs+ulCL1hdyGkAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3Rwq/FS; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3Rwq/FS"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6446d7a8eadso1286582d50.0
        for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 06:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765550857; x=1766155657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+innFxEDqDvCxyfkLYDptfQgx/BAjrxarmI6neVZXCo=;
        b=b3Rwq/FSYUoAI1LPKdNiA/s1lbtmbYr0Q/Jjdoh+UgtxY4riIY4mTyJi7d5UL0CqSj
         QAWdtsKUeMIDvKxUJo9YlqWTN8r1qiHUnX0cjudKivqmFGZOwDJwAe30Tb7et1Oc9AUY
         c/V4y5ef+JhMMFXL9poQEGSft31qHWJkHSTcJ49PcfikLYgMlb9yL2pHXPrWUp2UaNa7
         TimPXdStmf3xuYLVJyf2vS8qOlX/Vh1Ir08Wqu3yiNnaz2/F8hF+aXoB49Qs+jrMO39u
         OTwtYxKzvplsMw7MeH+gzNM5TkdJbE71S6ZyE/C73GJChssIJKs88nOOXyWoBnQr3JKL
         k2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765550857; x=1766155657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+innFxEDqDvCxyfkLYDptfQgx/BAjrxarmI6neVZXCo=;
        b=sfIHNF6fk0Au8GoSF8tGFLHh9RqTb7o8eO7e390aTANlZ8fxXUtzY9nTSjRjd4mlpQ
         uRsx6SziT9pfpwrNviXfWlQ8IOvHt4zYkPuCBAkRZgtIaodnEhRInmxNjDgLHgaPAKTT
         oulLxs+JU3zX+4BwCy+hqtDHO1wpfxVpPsrSY7Ol3xlw9MEmgdHiqEPdkG3ZMN39eVLv
         LigXHg+UGuTJYAcFneZlbe8woaRmwFF1GebvyR+JxqyIi3ISSUpABNK6YQ1ng72O4qDk
         Kkud6lZKGSFNYirga6HU06sO/I30nriNnviEbnB+M2HCdbAGr0FOzZauxi4/j5WSOBA1
         F3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXcQz4r/0KC6u7C1hgShkeKbOVCeHsVPoZrJ0pZ0wOuz2fECNcG7EpOwUhbWLiETsqf52PwVuzHoAaqcCvFnJSTre2JH7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ5IFQ55PQvyPp81fEhCPT6EHlvjifw/TSoYf5Z72zmvQa/WSn
	LE+bhvF08BZ3ZphJZKahrtwkTT6BxLbDk03bP21Ym3BBpui3tYwflA98XlA6yEtuRTVsqYoO77O
	5dCuYnMweNjwMU0nH1mG2ixACFHcufIhL8MwSs20/BBS6
X-Gm-Gg: AY/fxX7XYTX7NW/o5jc39mdOZUJLQimXhDigwGvGSdP4Dsg29Y4d82BWIO6X5Sx9pDW
	oW7cPHL1av9dXakLWZpBD92B1ow/4nSD/IO9D1pRWTxuqiXLf1ja/i7i4bRUiWrQNmMrNYl/vak
	sirrEU7Q6jW7K/g7ooPpx6xvUHjD0kG88ZhvgtIJjUrJCb2OOMxoxG5GJ2Ozyv3AWSvQXwBmlhR
	N0uf8uA1Q8sY9VfQC15cGVxpTJG6ps7N1YvBsd4Lc4pxmJD3UDsuwxbfrsyLGVganclDE6T
X-Google-Smtp-Source: AGHT+IHcGSbmhhfvH8ZWBL+S58XMccSs8Ij/4KaoVZAEMg0eXobbhU3LkaRRzmHg/Sa1xHxApsAkN8wXnEk5cyzAYv0=
X-Received: by 2002:a05:690e:1307:b0:640:ce83:c29d with SMTP id
 956f58d0204a3-645555cf6abmr1501761d50.14.1765550856770; Fri, 12 Dec 2025
 06:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com>
 <a3d28a4b-ee63-463e-8c5c-2597e2dcba98@schaufler-ca.com>
In-Reply-To: <a3d28a4b-ee63-463e-8c5c-2597e2dcba98@schaufler-ca.com>
From: Timur Chernykh <tim.cherry.co@gmail.com>
Date: Fri, 12 Dec 2025 17:47:24 +0300
X-Gm-Features: AQt7F2pd1RFo3xuEG9kZRXcs-Vz_mbMmBiwzw-r904HN4g44rYyPG__d2dOfWOg
Message-ID: <CABZOZnRQ=b4K5jpNM8Z=Zr=+66COwLpC8gynzw88==mL0FCrOw@mail.gmail.com>
Subject: Re: An opinion about Linux security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, 
	greg@enjellic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the answer!

> eBPF has been accepted because of these restrictions. Without them
> an eBPF program could very easily reek havoc on the system's behavior.

Unfortunately, these restrictions also make it impossible to use eBPF
effectively for security. We can certainly discuss the limitations
themselves if needed, but that=E2=80=99s not the main point I=E2=80=99m try=
ing to make
here.

> Yes. That's true for many kernel features.

Right, and that=E2=80=99s a well-known issue that has no clean solution oth=
er
than backporting. I completely agree with that.

> To the best of my understanding, and I have been working with LSMs
> and the infrastructure for quite some time, there has never been an
> out-of-tree LSM API.

I was under the impression that there was something of that sort.
For example: https://elixir.bootlin.com/linux/v3.10/source/include/linux/se=
curity.h#L1688
It may not have been =E2=80=9Cofficially=E2=80=9D exported, but people who =
needed it
simply resolved the symbol through `kallsyms` or a kprobe and used it.
I=E2=80=99m not claiming that this is good practice, but it did work.

> You will need to provide more detail about why you believe that the
> integrity of an AV/EDR product cannot be protected.

Consider the case where an attacker already has root access. The first
thing they typically do is disable or tamper with security tools.
After that, they establish persistence. Access-control models alone
are not enough here =E2=80=94 sometimes they need to be adjusted dynamicall=
y,
based on complex real-time analysis.

> What APIs do you want? It's possible that some exist that you haven't
> discovered.

I=E2=80=99m confident I=E2=80=99ve studied all the mechanisms available for=
 real-time
system protection. I=E2=80=99ve even given talks and published material on
approaches to securing Linux.
I may not have covered every LSM module in depth, but in practice they
simply don=E2=80=99t provide the capabilities required for modern security
workloads.

And I don=E2=80=99t want to sound overly categorical, but the current path =
of
security development feels like a dead end to me, for several reasons.
Modern security relies on analyzing hundreds of thousands of events
per second. eBPF isn=E2=80=99t particularly fast to begin with, and on top =
of
that it imposes strict technological limitations that prevent
meaningful in-kernel analysis. Every EDR vendor ends up doing the same
thing: collecting raw data (which is already difficult) and pushing it
into userspace for processing. That adds transport overhead on top of
everything else.

Or, of course, writes a dirty and unsafe kernel module. For me in the
perfect world seems to it's better to provide an API for userspace.
It's safe enough and doesn't contain a restriction that eBPF has.

> Please propose the interfaces you want. An API definition would be
> good, and patches even better.

I=E2=80=99m lucky enough to have already built a working prototype, which I
once offered for review:

https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/main/se=
curity/esf
https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/main/in=
clude/uapi/linux/esf

Less lucky was the reaction I received. Paul Moore was strongly
opposed, as far as I remember. Dr. Greg once said that heat death of
the universe is more likely than this approach being accepted into the
kernel.

I don=E2=80=99t want to =E2=80=9Cpoke old wounds=E2=80=9D, but the design I=
 proposed was
largely inspired by Apple=E2=80=99s Endpoint Security Framework (originally
=E2=80=9Cmac policies=E2=80=9D):
https://developer.apple.com/documentation/endpointsecurity

In my view, it is an exemplary model. The kernel provides a consistent
stream of events to userspace, hides the complexity of data collection
and transport, and ensures fault-tolerance if userspace fails to
process events quickly enough.
Audit, for comparison, simply hangs the system if its buffer
overflows. ESF does not have that problem and even lets userspace
control the event stream.

> There are numerous cases where LSMs have mitigated attacks. One case:

And there are thousands of cases where LSMs did not. Most companies
never disclose successful breaches because of NDAs and fear of
investor backlash. The few disclosures we see typically appear only
when it=E2=80=99s safe for the company, or when they specifically want to
appear transparent.

> Your assertion that LSMs don't provide "real" value is not substantiated
> in the literature.

Which literature do you mean?
As I mentioned above, public reports about successful attacks are rare.

Maybe I poorly delivered my point. I'll try again.

The strongest protection on Linux today is provided by proprietary
security vendors. Unfortunately, they often achieve this using
kernel-module =E2=80=9Chacks=E2=80=9D rather than LSMs. It=E2=80=99s not be=
cause they prefer
hacks =E2=80=94 it=E2=80=99s because Linux doesn=E2=80=99t offer proper API=
s to implement the
required functionality.

> Each of the existing LSMs addresses one or more real world issues. I woul=
d
> hardly call any of the Linux security mechanisms, from mode bits and setu=
id
> through SELinux, landlock and EVM, "theoretical".

In practice, most LSM modules are either disabled or misconfigured on
real servers, and the responsibility falls on AV/EDR vendors. As
someone who has been building such systems professionally for years, I
can say with confidence: there is no clean, reliable mechanism
available today.
As much as I love Linux, its security and its friendliness toward
security vendors are its weak side.

In the real world, deploying a modern security product means dealing
with endless pain: missing kernel headers (sometimes there isn=E2=80=99t ev=
en
Internet access to download them), unstable kernel APIs, lack of BTF,
constant fights with the eBPF verifier, and all the other limitations
of eBPF.

To be honest, many developers =E2=80=94 and I=E2=80=99m taking the liberty =
to speak
broadly here =E2=80=94 would simply like to see something similar to Apple=
=E2=80=99s
ESF available on Linux.

Best regards,
Timur Chernykh

On Wed, Dec 10, 2025 at 11:08=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> On 12/9/2025 4:15 PM, Timur Chernykh wrote:
> > Hello Linus,
> >
> > I=E2=80=99m writing to ask for your opinion. What do you think about Li=
nux=E2=80=99s
> > current readiness for security-focused commercial products? I=E2=80=99m
> > particularly interested in several areas.
> >
> > First, in today=E2=80=99s 3rd-party (out-of-tree) EDR development =E2=
=80=94 EDR being
> > the most common commercial class of security products =E2=80=94 eBPF ha=
s
> > effectively become the main option. Yet eBPF is extremely restrictive.
>
> eBPF has been accepted because of these restrictions. Without them
> an eBPF program could very easily reek havoc on the system's behavior.
>
> > It is not possible to write fully expressive real-time analysis code:
> > the verifier is overly strict,
>
> This is of necessity. It is the only protection against malicious and
> badly written eBPF programs.
>
> > non-deterministic loops are not
> > allowed,
>
> Without this restriction denial of service attacks become trivial.
>
> >  and older kernels lack BTF support.
>
> Yes. That's true for many kernel features.
>
> > These issues create real
> > limitations.
> >
> > Second, the removal of the out-of-tree LSM API in the 4.x kernel
> > series caused significant problems for many AV/EDR vendors. I was
> > unable to find an explanation in the mailing lists that convincingly
> > justified that decision.
>
> To the best of my understanding, and I have been working with LSMs
> and the infrastructure for quite some time, there has never been an
> out-of-tree LSM API. We have been very clear that the LSM interfaces
> are fluid. We have also been very clear that supporting out-of-tree
> security modules is not a requirement. There are members of the
> community who would prefer that they be completely prohibited.
>
>
> > The next closest mechanism, fanotify, was a genuine improvement.
> > However, it does not allow an AV/EDR vendor to protect the integrity
> > of its own product. Is Linux truly expecting modern AV/EDR solutions
> > to rely on fanotify alone?
>
> You will need to provide more detail about why you believe that the
> integrity of an AV/EDR product cannot be protected.
>
> > My main question is: what are the future plans?
>
> Security remains a dynamic technology. There are quite a few plans,
> from a variety of sources, with no shortage of security goals. Trying
> to keep up with the concern/crisis of the day is more than sufficient
> to consume the resources committed to Linux security.
>
> >  Linux provides very
> > few APIs for security and dynamic analysis.
>
> What APIs do you want? It's possible that some exist that you haven't
> discovered.
>
> >  eBPF is still immature,
>
> And it will be for some time. That is, until it is mature.
>
> > fanotify is insufficient,
>
> Without specifics it is quite difficult to do anything about that.
> And, as we like to say, patches are welcome.
>
> >  and driver workarounds that bypass kernel
> > restrictions are risky =E2=80=94 they introduce both stability and secu=
rity
> > problems.
>
> Yes. Don't do that.
>
> >  At the same time, properly implemented in-tree LSMs are not
> > inherently dangerous and remain the safer, supported path for
> > extending security functionality. Without safe, supported interfaces,
> > however, commercial products struggle to be competitive. At the
> > moment, macOS with its Endpoint Security Framework is significantly
> > ahead.
>
> Please propose the interfaces you want. An API definition would be
> good, and patches even better.
>
> > Yes, the kernel includes multiple in-tree LSM modules, but in practice
> > SELinux does not simplify operations =E2=80=94 it often complicates the=
m,
> > despite its long-standing presence. Many of the other LSMs are rarely
> > used in production. As an EDR developer, I seldom encounter them, and
> > when I do, they usually provide little practical value. Across
> > numerous real-world server intrusions, none of these LSM modules have
> > meaningfully prevented attacks, despite many years of kernel
> > development.
>
> There are numerous cases where LSMs have mitigated attacks. One case:
>
> https://mihail-milev.medium.com/mitigating-malware-risks-with-selinux-e37=
cf1db7c56
>
> Your assertion that LSMs don't provide "real" value is not substantiated
> in the literature.
>
> > Perhaps it is time for Linux to focus on more than a theoretical model
> > of security.
>
> Each of the existing LSMs addresses one or more real world issues. I woul=
d
> hardly call any of the Linux security mechanisms, from mode bits and setu=
id
> through SELinux, landlock and EVM, "theoretical".
>
> > P.S.
> > Everything above reflects only my personal opinion. I would greatly
> > appreciate your response and any criticism you may have.
>
> We are always ready to improve the security infrastructure of Linux.
> If it does not meet your needs, help us improve it. The best way to
> accomplish this is to provide the changes required.
>
> > Best regards,
> > Timur Chernykh
> >
