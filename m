Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aH6QkAia"
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C436171E
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 15:33:00 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b9db318839so1703521b6e.3
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 15:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702078379; x=1702683179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay9wzyB12eYmmiTWgs4BAuKgS+CO3Zor3St/DrG4wss=;
        b=aH6QkAia0Uw+lQbwy21kv67GPDlfkILD9fWKk1/Vf9ctxuQQGi2pRTifnfz2NyfJ61
         dx7a22Uos1y8AXwYY1Y7srM+Z1oZYRnjC97hBbN3Z61o3lAmYKy+gYvCIES6Wl24AUbc
         Z+4tYs3lkz5Tas4GvVc23bv1LYT/zcVbPqOpJ8itcfvIBLdCRHbh2kMV6LvZmr90i3WK
         sKxWrdHYbSCVDqO0lXbHmOoPIQjPBvG0b7m6i5jMi1LHnm9vBm0LzpHFSjpKA49NQOdc
         7NRYujojcf01eERWF+u7piL2xoyCKkgInHSNx1EWk3GbtUtNnLNSi0LaVCe1ds+zt30l
         3Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702078379; x=1702683179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay9wzyB12eYmmiTWgs4BAuKgS+CO3Zor3St/DrG4wss=;
        b=fbaCtHgZpFd6qKJ1biAS6ryWsxnb1b+iocUvbvwvVIGFbQSYtVA20PiKR6zO9mAvOr
         1PDQunqWL6uE4ZRR3RhTZ4wnGXT6mf3ahrpSl5KY5Eqn+DhTVuRLkXefmFqZTTr7CLpB
         3w9SJMsceCW2kvA/LeS5rS6QbLClHJtx3LayLiqdtdlQzyHT2bMPLNhdnCIKc0UOBnNq
         EZcqjrcE5EkEXtYmOnGrdxQ82yNDJiudOC67yciPpDFxF3VvJjWsP1uI/M+EKnxzqMdg
         AqRDqiVf3Xy1U50CpJcLYVGdIAzRKBgvIbJ8HJpmI2TmRRjCtUlq2YrJzfnLEuMz3RQ9
         vo8w==
X-Gm-Message-State: AOJu0Yxbcx4q5dT9vCffijC80nAEhMctdJw2iAq4TRMjlEgmQUbPH8Q3
	m/Z9ESEFxD3s5+ATa8Oj16eZXFPd8wH6lGELvnlk
X-Google-Smtp-Source: AGHT+IHJl/+ondJPVs0gGGmSvsUl8CrKv64MLNnqkYioPScNbfM0E6qX9prlhdXXEkzFMove8N2M/8b0Bs5ZpedsDzo=
X-Received: by 2002:a05:6808:2e92:b0:3b8:b45f:29cf with SMTP id
 gt18-20020a0568082e9200b003b8b45f29cfmr840344oib.114.1702078379457; Fri, 08
 Dec 2023 15:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSyaFE7-u470TrnHP7o2hT8600zC+Od=M0KkrP46j7-Qw@mail.gmail.com>
 <20231208021433.1662438-1-kamatam@amazon.com> <CAHC9VhRRdaUWYP3S91D6MrD8xBMR+zYB3SpGKV+60YkmLwr7Sg@mail.gmail.com>
 <0c0e8960-9221-43f0-a5d4-07c8f5342af0@schaufler-ca.com>
In-Reply-To: <0c0e8960-9221-43f0-a5d4-07c8f5342af0@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Dec 2023 18:32:48 -0500
Message-ID: <CAHC9VhQyziaxvbCCfb4YWQ0-L0qASa-yHG4tuNfbnNLecKDG0A@mail.gmail.com>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Munehisa Kamata <kamatam@amazon.com>, adobriyan@gmail.com, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 6:21=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 12/8/2023 2:43 PM, Paul Moore wrote:
> > On Thu, Dec 7, 2023 at 9:14=E2=80=AFPM Munehisa Kamata <kamatam@amazon.=
com> wrote:
> >> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
> > ..
> >
> >>> I think my thoughts are neatly summarized by Andrew's "yuk!" comment
> >>> at the top.  However, before we go too much further on this, can we
> >>> get clarification that Casey was able to reproduce this on a stock
> >>> upstream kernel?  Last I read in the other thread Casey wasn't seeing
> >>> this problem on Linux v6.5.
> >>>
> >>> However, for the moment I'm going to assume this is a real problem, i=
s
> >>> there some reason why the existing pid_revalidate() code is not being
> >>> called in the bind mount case?  From what I can see in the original
> >>> problem report, the path walk seems to work okay when the file is
> >>> accessed directly from /proc, but fails when done on the bind mount.
> >>> Is there some problem with revalidating dentrys on bind mounts?
> >> Hi Paul,
> >>
> >> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.linu=
x.org.uk/
> >>
> >> After reading this thread, I have doubt about solving this in VFS.
> >> Honestly, however, I'm not sure if it's entirely relevant today.
> > Have you tried simply mounting proc a second time instead of using a bi=
nd mount?
> >
> >  % mount -t proc non /new/location/for/proc
> >
> > I ask because from your description it appears that proc does the
> > right thing with respect to revalidation, it only becomes an issue
> > when accessing proc through a bind mount.  Or did I misunderstand the
> > problem?
>
> It's not hard to make the problem go away by performing some simple
> action. I was unable to reproduce the problem initially because I
> checked the Smack label on the bind mounted proc entry before doing
> the cat of it. The problem shows up if nothing happens to update the
> inode.

A good point.

I'm kinda thinking we just leave things as-is, especially since the
proposed fix isn't something anyone is really excited about.

--=20
paul-moore.com
