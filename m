Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79322FD1DC
	for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551794; cv=pass; b=XdpFa6tJcwYRfUVa92y+g5qs+H4rFNFgDNdH6lFPdSPb+r9t5XT5AoGD5YyWUMwuxYOMzeA/Yn69FSriIm0rM9muKV9kfeFHx6/x8kJrrh4ZgexJ4VmqtfKjS4AdK9vuqd+N7HfdUgxr3WEkCvkePnVQMx4yGukqo2bw4F6UBRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551794; c=relaxed/simple;
	bh=OG1FMv7wv4zKYSMHqfAUvVUusenZX7NCSUBskUeV0AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RogYEMqtPDAGsoSHkvPiKaLoCDBtCpPRR1DfPDxrvdsK/Gd3vB5lLQzvjPQF5C6aoPxJasHjimy65Bx007tKKZ6o8XIkWCbCS9CIzbhDS7OZ5d88yqszfaDuzwoXlm/iQjU2ymlzZ5tEuSYZkuEajvX7IfCJgPQlriDBVr//rkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=K+NW2PUz; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="K+NW2PUz"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a2ea96930cso38838835ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 14:09:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769551792; cv=none;
        d=google.com; s=arc-20240605;
        b=kw80fZ2nsXg/pl8NBAN2/1KsyqXs51qHHYYDVYYlMR2I6xxiH1gGPaTTbfJUPm+28M
         Lej2FoahvZOKE4IDX0udLePQDTjDd8TjN2qmiotT7YsYcx3S+mqyhysSV8BZnMx3dgB9
         Uhbnsdxw7rdB4i0Lm8cWU5MWQ6j4a8H7sgqBU7IeV3Sltpgl48cBUsVyHDqyn4B2uAO3
         POQUeWg3yJtyvN6SPcn/cV0g68RyRt3KpawvkyeeOzyXqVp6wDenucVCHQhrRN5Q0VhD
         DaQA6FcaWPrZPV/dlnjjUrwq6q0xZD0vMyUTNucTZbHBINiaEOSq8JEBrqXPdJcMEZoL
         WmsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/pGzPiXnxjkHtE3/gMOoiHqHPM0exsif4iCDkj4dB0I=;
        fh=ERrStXkCW5wpxE5zQ5HH59i2THmXUkKpDS6gzWYneLA=;
        b=A8dVxwZ0ZvX4XSU2Q+hF+FEfXvsUZbDZuCgHL4EEvf6OXgmU6JhqhCm6+Psdgxm/HN
         UmmuFJHHXGJktHe9JVw/oWbq7e+dSsPg8DcS9PRyETAERNoTOokLaDE1AycUwocpczEq
         F9KKkbfEFaaWl3X91SbU5ta2Aj8nLFAtUFBQ2lAmUoHODEd/S3gQ/e3DJowRvvPkPgA+
         vMKQ/ciYCAh4JSiIbiJpLuhFDtHruPv0FuC+7nEld09xRTZ6ThrzAbdM+Z6FUN9n/s6e
         aC7i7swoz2bvTK/X5CEWW2szHHRVxx5tBq3pUyO+S0zqUfTfqqgcKmK3WHGZ1X5lsWyw
         k8lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769551792; x=1770156592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pGzPiXnxjkHtE3/gMOoiHqHPM0exsif4iCDkj4dB0I=;
        b=K+NW2PUzOkp3OBjZuNn5mEk/eIDu+inVJGXEf3b+z3wgN9RpC5JSCz2QpafmyFpvjd
         PptkDgdBv0EmEWmQXnOFX6nONaIZ9ITfVwNm1v9FQ39GLg2CzqSSmIYhBgXw5g5C+0GJ
         YJmPBC7wK/ZBqZGLGcroXtoVL3SOJC2ZPos0+344Wv+MvCKigIbxSVQ2i42RWFHanEA5
         /Y8ZI4jZwmWw8mOSfBaDvLVCnkbHXvIpw6qZX2oDijU3YbRqmIwi5vg2VkZEEZim2s2Q
         MiDUoXAgodLwadbMWwNwc8S/eLHHMYaMbvu3B1hglGAl0ZBh4Ijw++Oi49qHImZ+wLQp
         nbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769551792; x=1770156592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/pGzPiXnxjkHtE3/gMOoiHqHPM0exsif4iCDkj4dB0I=;
        b=LlVcGTLXVV9TLV76Y53YYoOpt1q0S0fhTCNCRX6XLrJT0F2QDzVV1+0yxqn32G28z4
         xTyo/W2giOm3Tq27HZPt/OIUbsd4twIN+Ccr9Vkwjt7guLX83nzfH7UCzs5dfdJRrmMI
         5neLsGzekmvt3ka9xH/KAHRuVuZFQ1BCJwtI/fi3zP9TF3CS5Ht4TtEHC4DkdyRIYjZP
         zoRj/4DgHeA2xbvjHjjA9nq1D8RRLJtrvxx7ai/FUwSYhdPaWt8hdmRrIkdtuR1ew+sG
         gcyXjlt5o2YF/55lyTjlBb+0Pu6K1fJa4p0cen6t9q/MMrZCdj5HlcMj8ibviidl7+Zi
         5gqA==
X-Forwarded-Encrypted: i=1; AJvYcCUffH5a4RFlfxRT7DvUWnBJcz+w+pHTRfrinhuMsvutHOSRjk77Y+UFaUa31cVhAl0QL0AjyoeOxdbwDVr3IaK8kRdvkAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/yeG+pSobm+oZKDXC9YM6XqdZKIJGwJJ4wQBlLDD5XMfuchu
	rd4C4O/Wwt3OhC7wclQwBtKQFXtgw65NeLl6VyqXPxl8tkctF0Bvv1GJHQtYmY6W3LNA9igcm4B
	H9tx888j7Inz8DJ7Z2PhdOXW7eF4YV+BQ01quafO/
X-Gm-Gg: AZuq6aLRtn7vqSuBIV1lKol+MQfltQ2Mmj8CZbPGtwhjB8PuaRGCrN84vQlnPGybtvz
	aH5Ge1cUBnK4ARA8MSJGn6nqjYB4QgiOQ6AkbtauRFagmJYMm2bAyHwm6b4iOB7H60eP2ocNWOP
	z3YewNKKkCkC4T4zxL0wM/yVL6iW7cdwp0yCUOt4QPLq9bBCQ/SPz/7wMVN9ZkYN6wDimU3Lvw6
	+EuI61tFow9I8H40HU/YMySDh9tCzTwWgYNq6LQWnrq1VLpyxM3pZBRpNNlrmfke8wk9YE=
X-Received: by 2002:a17:902:d4cf:b0:2a8:7827:bb32 with SMTP id
 d9443c01a7336-2a87827bd1amr24618345ad.15.1769551791950; Tue, 27 Jan 2026
 14:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122140745.239428-1-omosnace@redhat.com> <CAHC9VhSgbHx4NcMVjMMk0D332b0DTEQi6dD_wO1fvQne-JVisw@mail.gmail.com>
 <aXgZI1td0Hremulj@mail.hallyn.com> <CAFqZXNve_7oKFWydUrskOcvsfbRZVKyWRmLvHKsTzBhG+RmEmQ@mail.gmail.com>
In-Reply-To: <CAFqZXNve_7oKFWydUrskOcvsfbRZVKyWRmLvHKsTzBhG+RmEmQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Jan 2026 17:09:40 -0500
X-Gm-Features: AZwV_QhApYhBIK3eOvHFa1J083mRfHMvnNKXNenkPREHmuM8NGRVHHw_H7kBAek
Message-ID: <CAHC9VhQOW4BQR+UCvrcXa_yiSqADN0HC2Xp0pMKs3FtnjcVaOQ@mail.gmail.com>
Subject: Re: [PATCH] ucount: check for CAP_SYS_RESOURCE using ns_capable_noaudit()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 3:05=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> On Tue, Jan 27, 2026 at 2:55=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com=
> wrote:
> >
> > On Mon, Jan 26, 2026 at 05:52:03PM -0500, Paul Moore wrote:
> > > On Thu, Jan 22, 2026 at 9:25=E2=80=AFAM Ondrej Mosnacek <omosnace@red=
hat.com> wrote:
> > > >
> > > > The user.* sysctls implement the ctl_table_root::permissions hook a=
nd
> > > > they override the file access mode based on the CAP_SYS_RESOURCE
> > > > capability (at most rwx if capable, at most r-- if not). The capabi=
lity
> > > > is being checked unconditionally, so if an LSM denies the capabilit=
y, an
> > > > audit record may be logged even when access is in fact granted.
> > > >
> > > > Given the logic in the set_permissions() function in kernel/ucount.=
c and
> > > > the unfortunate way the permission checking is implemented, it does=
n't
> > > > seem viable to avoid false positive denials by deferring the capabi=
lity
> > > > check. Thus, do the same as in net_ctl_permissions() (net/sysctl_ne=
t.c)
> > > > - switch from ns_capable() to ns_capable_noaudit(), so that the che=
ck
> > > > never logs an audit record.
> > > >
> > > > Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >  kernel/ucount.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> >
> > Looks good to me.  What tree should this go through?  Network?
>
> Andrew has already applied the two patches I posted into his
> mm-nonmm-unstable branch, so I assume they are set to go through his
> tree.

Andrew, any chance we can get a reply to these threads when you merge
a patch into your tree?

--=20
paul-moore.com
