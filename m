Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1664436EAB8
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867326; cv=pass; b=SSLDKidzHeZOt7ujc54OkB4R9TQEPNvBBNQJFKqENwxOBDDRctgh+LE8u/BE++U9riL/yqfldNZ2HRjWkHo9qcGmbakaOpJiIftw5q/C4EJDUbF2v0oo7KZfX5MhvudiTLsDquoqfcx6iRigDUOKJteJzgkSwD4DAWv0YL+u6v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867326; c=relaxed/simple;
	bh=0J3SkYkL8InsjHVxmNLBnTxY8cGVPE4s4gsacj7fW+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQBbTO8JDqudi+8EJX84lE77AxO0tnAPfxl6lsEFP4Fiz4lToEODWdrW7jZHECXqioyN6ATL43OSBwI8QfZ0TnPlbb4wZ5237+wGy9h1p6zU7vgQp382d2YlugifwUopti+QTrK+GHj4RZ1k93r41mD65Csj8gpuoKtf6Q2Yl7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8LJKVM7; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8LJKVM7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso2366005e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 13:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773867323; cv=none;
        d=google.com; s=arc-20240605;
        b=D/Lg5AShu1AdGk+x6WXPXmyvosYTHiyufu5Ok+MynitiEf/AYb3vvxYQoXURvSo3Ho
         74USIZhl+EyKo1rGZV4aODlRVRi8kSxix46Pgz02zRMVCJJjf1B2eMy4C6eVaRSkeC2e
         cmXu/j0EbJwFti+33SWYzgJmxXLa6+HxHicFC4pj/gzhz0+T1D9KR0v7PYpjDQ93WvwX
         0hCXZuMtw1fJR+YJ98ZhXaPJOveer2JXo2A5kxpN8BBa4KCdBwUWLJeRhGkVDvZ23sa1
         hI42o3r2lAfincDt+lADZDw6VmbByR9FZM2DZu3gIvD2pEdL39ggk1qd6UCPJWjLExtj
         dEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0J3SkYkL8InsjHVxmNLBnTxY8cGVPE4s4gsacj7fW+Y=;
        fh=it7j18RUpFEhxntr6zve2sjsgGNQM8UH0W+OIsWiWoc=;
        b=FY7klWflrtNy/8/DI109kZWR0S/psY1OuoSwViYG563LUGZ9XAY4BEXTvcFpP9DwFz
         XxajNbaUqL61GBBnwb0hYFk9tmI6Y5Z6C5AdDNUpof7YcT2pSjzSwWuFZ4JSdB6BhQ4E
         aNiRF5cwBpLVUrdsQGEiEqvOam1Uas8WxcYZlyK/sKjVfuDA098lJTLcSrvXcr5x3Loo
         yiv5LW+DnZzTVGuJ7JCtqNoscyts7sWM7FXss6b64wbZgNK7/OY8Xi+ZHA9KeRThKwnk
         6ftVwUVco1w6wHX/o5UMtyOhOEvMbyBVhMTCkomECIGoAJWh5QYGgk9FE8KQaP2QutiG
         VlrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773867323; x=1774472123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J3SkYkL8InsjHVxmNLBnTxY8cGVPE4s4gsacj7fW+Y=;
        b=j8LJKVM7f+xyj0bLAmUHN3o6UGd5S76QQBs1GbDzIh3gzq7u3wNKaijkLom30QqaRa
         t8bzygh40P/SS2d3EYc63SL3W7yYcLbgEHTRFNPcnQ7/KcKonBguxs8ru8Yy2QAfk4Le
         GwNbvNbOMrk+qbkIKadQMr9dQIIAAF/vhqQQOZ+SHQztR1Ubl9VnKWbiUKNVQqxnwUkR
         bSblbLaZ24hT0toaeSW9sWgStYF7mjaI2u9+933c/fdnSQGjBHI7Uw2wK/Vk73L3HL40
         Dv2QT25gY18aDrNu26ZyHOBp/aoc8wf9CT7bdRJxIq416XysNt07Gk4r60GO9jViz0Sl
         hyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773867323; x=1774472123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0J3SkYkL8InsjHVxmNLBnTxY8cGVPE4s4gsacj7fW+Y=;
        b=ADmLA0+dd71o255BCyFO4KDtvSG484oGiYwVwxsAviLpk0leViv19weVfh6Q8Cq3Dq
         LK1/cnmUB262CVgr/6Z+9DMYeIfBgxqFQ0uVYQyesfM+Jqk23Eyj+3d1CJCcGHr8sWW/
         eanVZlGc/WEVljwO5/TnDUu2RSIbR7Q32h6Bhrbr7KSdtAV5+GE2YpS4xKqhYtyItSHx
         zX75tbjiiYej1NqTTiuQfBfjKAJheL8R2IUsifI+sG+fQ6RcoTrK61yxrUbe7Fkud7To
         hjBHGuupJkwH3CIhD2qm3uuBOWR5c2/WDNCCVJgrKdlMeEvoqtTRG82QDE6HqRLqulAQ
         0ABg==
X-Forwarded-Encrypted: i=1; AJvYcCVcsFL9Z6hk2MCsix3ZExiUP+/VaHfwzapQ4M8vY6ABAUkYEznNSpCaOSx2G9WoxGcM5YlUGDqiycXrNKxKEQESPZLw4Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+vpWX9tTI19fM8JFvhXYb+JI1ZFowsN6AsDWW8E0yK9mObfR
	oiw/mNUVSvw+/QUstLX/765bsURGE4tmumtcgaup4N+J18RmykWEK9GIqxebM7ef21KLHvpQvrS
	B/D6wrLw5rrXmOGRnXyozFMnVtZvqOPM=
X-Gm-Gg: ATEYQzz634mzZpsqX7W4YlZN8Ijse1JM53ScxsFUF2UkAZWdQ797Xoj6vkMwxjWy08n
	lnNNntu7AE2H9URvH7KJXbEAYCe9Chqn3Nw3XcX3Yy9700no/QBX7t8PAjg1mljsgdN6/q1tuQn
	3DD5dYpypGBPdDXnUNnrhyaxNUTpRntMXIhQe1eveD5TG1Prhj3L0PSetaM/OQweD1OoXy84BOs
	Ri53F1tRAm3irhaTPyQHhk0AExfVYpOjGsuDOjw0BPA9OT/WPHPYqaWdspTLo+/3dcpzINzkKV9
	2V8fF0m+R18k3Bl2+6Jg46pnrZaedDdOOgonZyfwHebTX+78+Htf4ugJF54ihYgQrO5n7rzUQA/
	r/Lb7/cal4PTSTcqbjOlynOtrfpAjjMG3ZFv9
X-Received: by 2002:a05:6000:2204:b0:439:b62d:be86 with SMTP id
 ffacd0b85a97d-43b527d2d87mr8541610f8f.47.1773867323192; Wed, 18 Mar 2026
 13:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>
 <CAADnVQJCJaLjGCwjCX9VtT615c4kn7v5bxviUmGFVj=uTtUHMg@mail.gmail.com> <abrlvEjQKUdAOcw5@CMGLRV3>
In-Reply-To: <abrlvEjQKUdAOcw5@CMGLRV3>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Mar 2026 13:55:12 -0700
X-Gm-Features: AaiRm51tc55ib07MZtLJnTRuXxmrfDK1FJuMhF5fp5fXwEvfz5MooV7eUnvCNQI
Message-ID: <CAADnVQ+hNWY2Xd85xHySLN1gJD2paxPne3fAzeXx=De9tA5JNQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Frederick Lawler <fred@cloudflare.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
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

On Wed, Mar 18, 2026 at 10:49=E2=80=AFAM Frederick Lawler <fred@cloudflare.=
com> wrote:
>
> Hi Alexei,
>
> On Tue, Mar 17, 2026 at 06:15:59PM -0700, Alexei Starovoitov wrote:
> > On Mon, Mar 16, 2026 at 7:44=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Wed, 11 Mar 2026 at 22:31, Frederick Lawler <fred@cloudflare.com> =
wrote:
> > > >
> > > > The motivation behind the change is to give BPF LSM developers the
> > > > ability to report accesses via the audit subsystem much like how LS=
Ms
> > > > operate today.
> >
> > Sure, but bpf lsm-s don't need to follow such conventions.
> > audit is nothing but a message passing from kernel to user space
> > and done in a very inefficient way by wrapping strings into skb/netlink=
.
> > bpf progs can do this message passing already via various ways:
> > perfbuf, ringbuf, streams.
> > Teach your user space to consume one of them.
>
> Audit provides additional functionality by keeping messages close to the
> syscall, and in-line with other messages for that syscall. Aside from
> that, BPF is arguably too flexible. I'm sure it's already understood,
> but the idea here is to reduce bespoke logging implementations and reduce
> attack surface for violation reporting. Audit is already provided by the
> kernel and a well leveraged pipeline.

Sorry, I don't buy any of these arguments.
Nack.
