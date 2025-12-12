Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E25D258CDC
	for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765555919; cv=none; b=Z11STjfCZFbnc29GB3yBFrfpiyTxPCi8eWY6IMIA4WD6QNACvhuLPP78DWtYJl1liae7J/vvuW+yZKeIsJ+Q5jie9vSMRMXaXu+g98w1EPXFif1yp3kKyqiZLtGY3rNaH+kg84NzN8+WO3rws1Qdf43ItSFQo9pTKzAQGC+5IsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765555919; c=relaxed/simple;
	bh=q4hmHz4zkIQrTSr1D/U/OAQR9aEJwb70Ad/Fg0fGtNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfX6XjjhAgL/t3PdF2igmGLRbb9g4BfDGZhOm6Dj4InOXryQd76A98vqa7jkHR/J59MiSHF4BN7t+Mjvw5AJ4khxcQP7xAy6C4Ls5+T4r7RqdDXlXPzb9o+uv8Jbi8rc9fiJleF6ql9G6shKIkbbPqznYq5qFuaUTs1Qsh3jBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bokBJwNi; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bokBJwNi"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so1092114a91.2
        for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 08:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765555917; x=1766160717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ePvgf03GzOYCvPDg+xDDNnX/0bIilVwlRIGZUj42HI=;
        b=bokBJwNiRFYbV7r1u+vHLjHOyYkUoePIzh3DSguQrqPREqbVwdOodqkJ5fkEddpNfJ
         PC2Uim7ndFXadLlKhkc7jLf1RbaEe9v0UCmCG8zqlIfoN43MeqfrPIsFINeOqEKaPYuO
         UdmLX6VfTGavGnFFfqdzYg0rDheeyqsRwVMWs1fqFoqdLdjV8L6KBRzaGygVV96vEA1N
         +s36xs8Ai4T4S+ENmoBeJUnZvyDhEhwLxgY8dVTHmzrn8ZoPGuG1QlN/sTcz7OibpDHS
         c0zM/wF+WJaRht1AY+JSJnln+rFbMtAT8qABNMYBSEY6kbHjPATD6EWvyoV43pE4rEMp
         xb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765555917; x=1766160717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ePvgf03GzOYCvPDg+xDDNnX/0bIilVwlRIGZUj42HI=;
        b=HDo+Z+BiLmCHhfZmshah4aUwfCPAI4lSBMIpPlwDYlZq1QHwL8Jj7kXlRBdVQ3dUxc
         8Z/OPGUzWKelguHIOOmgNaJZiktv8ujFBKM629c5RmLpL41N2VSs/LKtwv0BzvXR73+p
         dqWYixo0oCDli95XwidREAUfc+4lePLGnwiYII9kIAkWaREbWl1fotmNVug7V0UnwNLv
         fFf5D4bl8JoyW/U+EUTmhE4TjctcNoqo49BErN9Ul1ciBiHC+MNAMu7O4vghf7Nh5QGl
         tVbI4wrgjIrrW861GcvvvpU4rb3hKA+fpXn4vO0xovVzPQ/Ihp1PN8fZt5lO/JBD/BO1
         g+tA==
X-Forwarded-Encrypted: i=1; AJvYcCUQXRK+wGnE53AYPzJqfcPoIlHOdJa7NEUTHLyzMrg9qjORf1bKxbMyxrs5V6LG2yju2ELcoY1EHvBzUVZusE/eFnTHao0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mUZAZGeM1o3BMxDMxsfGb/ZkCeTNmB2OWgcsJCtNNjLHZLi6
	BP666jiI4aeJfOjlJlUvWj/iDt45Lfc5rhGgGm5LEOWX+uMF2Lh/3v7urhlQqtUELHmYv+blUnb
	8FFoiVdnp/5JtD2fqAVbF/iwLXZTX3nQ=
X-Gm-Gg: AY/fxX6FB51Hv/EMCn9t4UsUvI71CIDUVvnEiqmM29kIQnaq9wb469L47iL/BQqzAHV
	1+/eUXqAtcul/oliTwRBFnFE5g6+pln7c7YMd/t23zkVJmKv2lopBD6fuh2kLHuvrY/kWfbQgz+
	2erSnpKdt9mw9RMFTVi9KKYnn+Weq1HBPYz6ynzV0p4k6URDJOHU1WKRl3Fsp+NhNYKkjPtqByl
	NqseTX4CsTWMz14FlRwJ+/cpxTIrQ5TTAaiqphu68gKU8GsCpwbxhqZt3xfiwirtIcjFbI=
X-Google-Smtp-Source: AGHT+IHEYiLW0KSmfy4AF/Ylo1hjnh+x593YvQU4GKB8oPrJnZUTgcGneFs3vkQVZrWjzAfFG3+FhdyfxVvJ+z0PHBs=
X-Received: by 2002:a17:90b:4c8c:b0:340:bb56:79de with SMTP id
 98e67ed59e1d1-34abd826e23mr2378807a91.30.1765555916502; Fri, 12 Dec 2025
 08:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com>
 <a3d28a4b-ee63-463e-8c5c-2597e2dcba98@schaufler-ca.com> <CABZOZnRQ=b4K5jpNM8Z=Zr=+66COwLpC8gynzw88==mL0FCrOw@mail.gmail.com>
In-Reply-To: <CABZOZnRQ=b4K5jpNM8Z=Zr=+66COwLpC8gynzw88==mL0FCrOw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 12 Dec 2025 11:11:45 -0500
X-Gm-Features: AQt7F2pqj4zEW3opomOwuovI8SZyloHbtB05Z1Ikj4Jrr46ONKzKxzfJuVbFva4
Message-ID: <CAEjxPJ6CbZC-=onSGgELygnt_hsqaN0JS_jJFxWn+hYt90s2Ng@mail.gmail.com>
Subject: Re: An opinion about Linux security
To: Timur Chernykh <tim.cherry.co@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, torvalds@linux-foundation.org, 
	linux-security-module@vger.kernel.org, greg@enjellic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 9:47=E2=80=AFAM Timur Chernykh <tim.cherry.co@gmail=
.com> wrote:
>
> Thanks for the answer!
>
> > eBPF has been accepted because of these restrictions. Without them
> > an eBPF program could very easily reek havoc on the system's behavior.
>
> Unfortunately, these restrictions also make it impossible to use eBPF
> effectively for security. We can certainly discuss the limitations
> themselves if needed, but that=E2=80=99s not the main point I=E2=80=99m t=
rying to make
> here.

There was no shortage of talks about using eBPF for security at LPC this we=
ek,
https://lpc.events/event/19/sessions/235/#all

If eBPF can't do what you want today, I suspect it will in the
not-too-distant future.
The best way to make it so would be to try implementing your desired
functionality using it, find the cases where it is currently
insufficient and then take those to LPC or other venues to argue for
enhancements to enable it to do so. Doing so may require re-thinking
how you implement that functionality to fit within the required safety
constraints but that doesn't mean it is impossible.

> > Please propose the interfaces you want. An API definition would be
> > good, and patches even better.
>
> I=E2=80=99m lucky enough to have already built a working prototype, which=
 I
> once offered for review:
>
> https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/main/=
security/esf
> https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/main/=
include/uapi/linux/esf
>
> Less lucky was the reaction I received. Paul Moore was strongly
> opposed, as far as I remember. Dr. Greg once said that heat death of
> the universe is more likely than this approach being accepted into the
> kernel.

Not seeing an actual response from Paul in the archives, but did you
ever actually post patches to the list? Posting a GitHub URL is NOT a
real request for review.


> I don=E2=80=99t want to =E2=80=9Cpoke old wounds=E2=80=9D, but the design=
 I proposed was
> largely inspired by Apple=E2=80=99s Endpoint Security Framework (original=
ly
> =E2=80=9Cmac policies=E2=80=9D):
> https://developer.apple.com/documentation/endpointsecurity
>
> In my view, it is an exemplary model. The kernel provides a consistent
> stream of events to userspace, hides the complexity of data collection
> and transport, and ensures fault-tolerance if userspace fails to
> process events quickly enough.
> Audit, for comparison, simply hangs the system if its buffer
> overflows. ESF does not have that problem and even lets userspace
> control the event stream.
>
> > There are numerous cases where LSMs have mitigated attacks. One case:
>
> And there are thousands of cases where LSMs did not. Most companies
> never disclose successful breaches because of NDAs and fear of
> investor backlash. The few disclosures we see typically appear only
> when it=E2=80=99s safe for the company, or when they specifically want to
> appear transparent.
>
> > Your assertion that LSMs don't provide "real" value is not substantiate=
d
> > in the literature.
>
> Which literature do you mean?
> As I mentioned above, public reports about successful attacks are rare.
>
> Maybe I poorly delivered my point. I'll try again.
>
> The strongest protection on Linux today is provided by proprietary
> security vendors. Unfortunately, they often achieve this using
> kernel-module =E2=80=9Chacks=E2=80=9D rather than LSMs. It=E2=80=99s not =
because they prefer
> hacks =E2=80=94 it=E2=80=99s because Linux doesn=E2=80=99t offer proper A=
PIs to implement the
> required functionality.
>
> > Each of the existing LSMs addresses one or more real world issues. I wo=
uld
> > hardly call any of the Linux security mechanisms, from mode bits and se=
tuid
> > through SELinux, landlock and EVM, "theoretical".
>
> In practice, most LSM modules are either disabled or misconfigured on
> real servers, and the responsibility falls on AV/EDR vendors. As
> someone who has been building such systems professionally for years, I
> can say with confidence: there is no clean, reliable mechanism
> available today.
> As much as I love Linux, its security and its friendliness toward
> security vendors are its weak side.
>
> In the real world, deploying a modern security product means dealing
> with endless pain: missing kernel headers (sometimes there isn=E2=80=99t =
even
> Internet access to download them), unstable kernel APIs, lack of BTF,
> constant fights with the eBPF verifier, and all the other limitations
> of eBPF.
>
> To be honest, many developers =E2=80=94 and I=E2=80=99m taking the libert=
y to speak
> broadly here =E2=80=94 would simply like to see something similar to Appl=
e=E2=80=99s
> ESF available on Linux.
>
> Best regards,
> Timur Chernykh
>
> On Wed, Dec 10, 2025 at 11:08=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >
> > On 12/9/2025 4:15 PM, Timur Chernykh wrote:
> > > Hello Linus,
> > >
> > > I=E2=80=99m writing to ask for your opinion. What do you think about =
Linux=E2=80=99s
> > > current readiness for security-focused commercial products? I=E2=80=
=99m
> > > particularly interested in several areas.
> > >
> > > First, in today=E2=80=99s 3rd-party (out-of-tree) EDR development =E2=
=80=94 EDR being
> > > the most common commercial class of security products =E2=80=94 eBPF =
has
> > > effectively become the main option. Yet eBPF is extremely restrictive=
.
> >
> > eBPF has been accepted because of these restrictions. Without them
> > an eBPF program could very easily reek havoc on the system's behavior.
> >
> > > It is not possible to write fully expressive real-time analysis code:
> > > the verifier is overly strict,
> >
> > This is of necessity. It is the only protection against malicious and
> > badly written eBPF programs.
> >
> > > non-deterministic loops are not
> > > allowed,
> >
> > Without this restriction denial of service attacks become trivial.
> >
> > >  and older kernels lack BTF support.
> >
> > Yes. That's true for many kernel features.
> >
> > > These issues create real
> > > limitations.
> > >
> > > Second, the removal of the out-of-tree LSM API in the 4.x kernel
> > > series caused significant problems for many AV/EDR vendors. I was
> > > unable to find an explanation in the mailing lists that convincingly
> > > justified that decision.
> >
> > To the best of my understanding, and I have been working with LSMs
> > and the infrastructure for quite some time, there has never been an
> > out-of-tree LSM API. We have been very clear that the LSM interfaces
> > are fluid. We have also been very clear that supporting out-of-tree
> > security modules is not a requirement. There are members of the
> > community who would prefer that they be completely prohibited.
> >
> >
> > > The next closest mechanism, fanotify, was a genuine improvement.
> > > However, it does not allow an AV/EDR vendor to protect the integrity
> > > of its own product. Is Linux truly expecting modern AV/EDR solutions
> > > to rely on fanotify alone?
> >
> > You will need to provide more detail about why you believe that the
> > integrity of an AV/EDR product cannot be protected.
> >
> > > My main question is: what are the future plans?
> >
> > Security remains a dynamic technology. There are quite a few plans,
> > from a variety of sources, with no shortage of security goals. Trying
> > to keep up with the concern/crisis of the day is more than sufficient
> > to consume the resources committed to Linux security.
> >
> > >  Linux provides very
> > > few APIs for security and dynamic analysis.
> >
> > What APIs do you want? It's possible that some exist that you haven't
> > discovered.
> >
> > >  eBPF is still immature,
> >
> > And it will be for some time. That is, until it is mature.
> >
> > > fanotify is insufficient,
> >
> > Without specifics it is quite difficult to do anything about that.
> > And, as we like to say, patches are welcome.
> >
> > >  and driver workarounds that bypass kernel
> > > restrictions are risky =E2=80=94 they introduce both stability and se=
curity
> > > problems.
> >
> > Yes. Don't do that.
> >
> > >  At the same time, properly implemented in-tree LSMs are not
> > > inherently dangerous and remain the safer, supported path for
> > > extending security functionality. Without safe, supported interfaces,
> > > however, commercial products struggle to be competitive. At the
> > > moment, macOS with its Endpoint Security Framework is significantly
> > > ahead.
> >
> > Please propose the interfaces you want. An API definition would be
> > good, and patches even better.
> >
> > > Yes, the kernel includes multiple in-tree LSM modules, but in practic=
e
> > > SELinux does not simplify operations =E2=80=94 it often complicates t=
hem,
> > > despite its long-standing presence. Many of the other LSMs are rarely
> > > used in production. As an EDR developer, I seldom encounter them, and
> > > when I do, they usually provide little practical value. Across
> > > numerous real-world server intrusions, none of these LSM modules have
> > > meaningfully prevented attacks, despite many years of kernel
> > > development.
> >
> > There are numerous cases where LSMs have mitigated attacks. One case:
> >
> > https://mihail-milev.medium.com/mitigating-malware-risks-with-selinux-e=
37cf1db7c56
> >
> > Your assertion that LSMs don't provide "real" value is not substantiate=
d
> > in the literature.
> >
> > > Perhaps it is time for Linux to focus on more than a theoretical mode=
l
> > > of security.
> >
> > Each of the existing LSMs addresses one or more real world issues. I wo=
uld
> > hardly call any of the Linux security mechanisms, from mode bits and se=
tuid
> > through SELinux, landlock and EVM, "theoretical".
> >
> > > P.S.
> > > Everything above reflects only my personal opinion. I would greatly
> > > appreciate your response and any criticism you may have.
> >
> > We are always ready to improve the security infrastructure of Linux.
> > If it does not meet your needs, help us improve it. The best way to
> > accomplish this is to provide the changes required.
> >
> > > Best regards,
> > > Timur Chernykh
> > >
>
