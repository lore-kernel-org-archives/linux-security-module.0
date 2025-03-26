Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB771B4141
	for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 23:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743030181; cv=none; b=gkFYmnQi8bBoAHb379DuDEMMP4HJRON1z/laD9iHxG0XzmcwREoMqNWmoC8VsZqTHAjVMHbtOww4JHAH0m9jzBSfFg4B3TDgpO95PCls64SdcGaLhknqY8yILgxQZ4Q/USHCokpWDVyKjUq28Oxhvjsng0PRe9MhnqAmf/C+5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743030181; c=relaxed/simple;
	bh=jPUH8cHEITF2cPzC/ZmZ0ONxB+dyH7o21Er3HkXtDvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPos7unQoErz8lLU8IN/ZA2nFFxhYAoTRlQ/lvuRR150eLVni0Kq7HFx5Xa5POCNsZxlKeFAAi4soM2F4EOeN7jcGhaEdBTDbImzs7hXGpY8SNuwQI9onCjQ8loCVB+E27kEC/9PTYXHO9E8fK/Ys4/qokV+2G+ZuUMjv8/Sci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SvkcW293; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SvkcW293"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e5dc299dee9so439629276.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 16:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743030179; x=1743634979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB9UYcH5AdqIyBolCZJx21sb/shumgTj8OuXokPvO7Y=;
        b=SvkcW293mh0HY0jomhpu7kdz3qpx0PViSONxHoknNmnzXuzevmGnYoW0IDb99wfcSg
         LW/ntXYlQbJ8Fd2YLf4/b8vFNpKPR5sR8DEfUULAbJej2ni6bSfO01gt2Ef+jSHi8QRq
         eZqXdB4mkNAInBCcxKXo02FqP8hGJomeU0/GlSqQ89lZ5mY+SGVZ4gMpU66EJL3V5gau
         RqwOr7VMvK5jT3Pcof1Z7MWRg9SM8mzwIRBrlwvaTSo7GsFodvziuZwqFgU0Ou+pww5D
         gkystDi+tJ03YeNKNe61++YFt0kwYlE+yHPtMdMsv6EeVzek1DK6hHIL17SqmGk8K6xa
         sZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743030179; x=1743634979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xB9UYcH5AdqIyBolCZJx21sb/shumgTj8OuXokPvO7Y=;
        b=KrQQyzVaH/KyRQ1q8Iun5EQO5MRrlO0RJNk92mQ8xSC0yerEesKZydEMaf2A0PMlmm
         Ga5/ONksJczWoZlVEWwr16JS0+ToQj/PeO00tBLZdLhJ3KLUOgk7A8/L2TOCktlzB1Ds
         QskiCB3Zvfa1sEE3Ocs7b3yrfA76ZlLwZz5QfTLNIWxS0ywjHXPiNX26d8yA/FiiqCHF
         t/eisFTCC7j3zpN3lEGYWrXqqTLswuFV1YGzJiXwOfsqjgZYUVvBX1F64PydXJZs4+29
         u45asUp4GVMQ/eDM8bIB0eLwUtGGjUQbm9FpawVsZqzwhv2GzPMYqhCfrBa9Nna+V/Ch
         x5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoWfOFdme8JyyeyeOemP4RJtjKW39bY9lRNuhQaqhbuAnqojSLbXetascJFXfgwC7kwQ/xQKudrFqIADB9ZUN3l6Mj1t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJ7BCSdlowejvPNyJknUDQoHM1pA0ABG0ppRJMp3LdpsDxCxg
	RZsbC/SMjN/gTUWvqEvGrHfq2Tx+tAuuo/7nLeOti3u37aXTybPdajAE+fWU+SMGjPFet6Vi9/G
	/PjEbc+/VjWPMZElmUGtO53jZtdIdYiJJcSG5
X-Gm-Gg: ASbGncu6R6hnGJi2Ttz+kdCc6W/5Pq5C8rT3uLqJn4mqxTbEOntc/Pjm0hHAz6rKc7Z
	zybZOL0o6JB7S9psi69/lWLpBuVkBlW28kgkcq1UanOQQVGGPYEvYT1vjZvOVCW6IPdHeMgqfUu
	Y0IjXxUEnvquUO0XdpFfOZpLDDhQ==
X-Google-Smtp-Source: AGHT+IE5Pt/Vffo+1JRWLwabWNqS6xEZLcnPafMLRISgkt7U3sr2Fb1QpXN7gcExs5dAKsCpr+YNc+v2PsCBNTv6dd8=
X-Received: by 2002:a05:6902:240f:b0:e69:1f19:cc3a with SMTP id
 3f1490d57ef6-e694377e6f5mr1997953276.30.1743030178518; Wed, 26 Mar 2025
 16:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
 <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com> <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Mar 2025 19:02:47 -0400
X-Gm-Features: AQ5f1Jp1vWdVeq6koEuglRdSXOOkCRBFnBJO34u8phUSwAMef3byd67a9AAqfD4
Message-ID: <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Cameron K. Williams" <ckwilliams.work@gmail.com>, "Kipp N. Davis" <kippndavis.work@gmx.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 5:06=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> *WHY* is that policy needed at all?
>
> As you correctly point out, it has NOT EXISTED for a long long time
> already, and the code has been the old way since 4.x timeframe.
>
> So my question literally boils down to "WHY SHOULD IT EXIST NOW"?

SELinux is different things to different people, but for this
discussion I think one of the more relevant aspects is the fact that
SELinux is designed in such a way that you can analyze the security
policy and reason about the security properties of the system.  For
example, how does data from application A flow through the system?
Can application B ever read from file C either directly or through
some chain of applications/users?  What about writing to file D?  Who
can manage device E, or configure various runtime knobs in the kernel.
I could go on, but the important part is that SELinux allows an admin
to reason about the security properties of a system in ways that
simply aren't possible using traditional Linux access controls (mode
bits, capabilities, etc.).  If you're curious the collection of
analysis tools can be found below:

https://github.com/SELinuxProject/setools

An important prerequisite of this is that any "security relevant"
operation on the system needs to have a SELinux access control point.
If an access control is missing, the quality of the policy analysis
suffers.

> And I do not not see the point of allowing a driver module load (which
> *is* a policy, and has been for a long time), and then disallowing
> loading the firmware that the driver needs.
>
> That's insane. So explain to me why you added what looks like
> completely insane policy hooks.

In the security_kernel_read_file() LSM hook, the SELinux callback
examines if the current task has the ability to perform the designated
read operation on file A.  Loading a kernel module and loading its
associated firmware are two events inside the kernel with the current
task loading data from two different files, each with potentially
different security properties, and we want to perform an access check
on each file to ensure it is permitted under the security policy
defined by the admin.  For example, with the kernel enforcing kernel
module signing one administrator might be inclined to allow a given
process to load a kernel module from a file that is more widely
writable than a firmware image without any form of integrity
protection.  Having two distinct permissions, system/module_load and
system/firmware_load, allows the administrator to distinguish between
the two different file reads in the SELinux policy.

--=20
paul-moore.com
