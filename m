Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80F481AA
	for <linux-security-module@vger.kernel.org>; Fri,  2 Aug 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583288; cv=none; b=eQu2JV23gVQ9EX16EDUDXazRZ+DCWC8nc9/NqXApVaXHL2ZTqRD2LzexHHcHXouWUULjjIyOKb5ocwpBkOCb9bR+MdbzLzm1SRBJTQlqawL/2jcVRQjIfixqHLgZanJxpLM+fEx1m1Cgdyg03NUtQXY/yZ1Mjqfofl9gtPqhUo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583288; c=relaxed/simple;
	bh=PCHK9AQ8hYY+3lWooz8Oue7k/B/xfCu8ovZek0miUKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIft8cx4RRq6zRn93uOKBTkYov+7hrK7ZXbyr35D5KyxCLSEnWvmS8x7g8LTyL++6nmTflAMrxg9mN22zo/munv5ZD0K2XR6IQYMegaIBzjA0plfJKn6GP4u26StImRyjBhOFDPhsPEkEBgeaDqJb4Q1POz75nkNtVCaKeAMSE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBGJDCpT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBGJDCpT"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so47073a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 02 Aug 2024 00:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722583285; x=1723188085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpxgTPokUFyNrltPPoZbQf8Nv+LcbhWrr2CF2IPV7xU=;
        b=lBGJDCpTZGlmwDazgBdRMPDZD3WObuFrZFvxgY4Nb4pEixI7AZgbvhl1JhA74uSPqB
         V7nAreRxxE10wdKsQULfZxnla7+l0MbqODnaHwiMz3km3vX7vjr5fGoQ/Wr8MibCehuX
         di3yBcQc0NaWqRiKst3W1H38AnQztxoeuMxZCdEUYsOibcdheyj5WMi3gZHAUQE+tdE6
         +paDlTMZmClB/VLcyaDyUGS1khPqIrVgJhBAFnCVx3E1sIjDv4wBM3x6UdD/qd98SNC7
         F4mrW8wsxyVrDNB9MeeAgi6niAx2Tk75SPb7CdF5VaHCU1+N3t9pIqpOA4+cDoX29PZH
         VZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722583285; x=1723188085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpxgTPokUFyNrltPPoZbQf8Nv+LcbhWrr2CF2IPV7xU=;
        b=ia+ekBPzz7cViYNifr04pHbH5c6slhLxjJafswwtlLoClVragIlhGUQ4riYud+Sxki
         qzWPKel0rfDpwJ9qNN3Pu41T4CgSVxF0NoAvLtiwRoh5b9G7AkoNw0h9UEbsjM8okF7F
         81MX7kxVnHVi9fdOTvawafhF6+XjTMNtkpzqr4+g0luiaQyqIueEsdtLeul63JBZj2mG
         n0fhXvbC83HVJS5AkWeV5FovKIiaJGEVgdHooySsx3dxng/aVq1IXKKeeTrHPxosWuXU
         EwvT4zscadkw+ZhOfoGIy4vWBjYPwAXEcK9hJj/1GmugtZ+IT6vuAWBbohNp815fZ3TA
         TX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmc77BT/xuYJAo6kxZVAMRYYzSutl+MPCmnN0tFFb14k0NRROAt0RwcFzNty+IwHBDdRMcrWyA1s/jX/WgSyNBXBRGDNcp5uRsTMvvLem3CyJdp3zx
X-Gm-Message-State: AOJu0Yx3r09gu1Zyg7K4Ogce0yGC6OmQ1n5eoIV4CyjDvrOh4tSc0glC
	/bKJe3MM/IzhKnVyjwVL6XQy2EpGRq/e7BE9VmfGdrp5tNQsJ7yeU6dU49F4S1l5ag6lXvUPgnS
	tZdqNnDH52CFotQBnqFu8GTvERRMqG0/IyweJ
X-Google-Smtp-Source: AGHT+IHOcP0+ocqCghIsI3ZkGBkB2Xf4oyNP81XpK8QGg7jspCknSEJMvCSfoVpKqSC5L1Dm8VPwMKjhr72HxO6hI4I=
X-Received: by 2002:a05:6402:51cf:b0:5a7:7f0f:b70b with SMTP id
 4fb4d7f45d1cf-5b86752ec46mr103224a12.0.1722583284587; Fri, 02 Aug 2024
 00:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mailman.7002.1716464964.1888.tomoyo-dev-en@lists.osdn.me> <00000000000023e800061eaa9fea@google.com>
In-Reply-To: <00000000000023e800061eaa9fea@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Aug 2024 09:21:13 +0200
Message-ID: <CANn89iKY6JzgwDpANsniAaDUP8H1QXyuTzpE2YyRMXzwkSWRcA@mail.gmail.com>
Subject: Re: [syzbot] [tomoyo?] INFO: rcu detected stall in
 security_file_ioctl (8)
To: syzbot <syzbot+67defecaa74f7dd0a5d3@syzkaller.appspotmail.com>
Cc: jmorris@namei.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@i-love.sakura.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en-owner@lists.osdn.me, tomoyo-dev-en@lists.osdn.me, 
	vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 5:07=E2=80=AFAM syzbot
<syzbot+67defecaa74f7dd0a5d3@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit e634134180885574d1fe7aa162777ba41e7fcd5b
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> Date:   Mon May 27 15:39:54 2024 +0000
>
>     net/sched: taprio: make q->picos_per_byte available to fill_sched_ent=
ry()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D16a9066d98=
0000
> start commit:   0450d2083be6 Merge tag '6.10-rc-smb-fix' of git://git.sam=
b..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D17ffd15f654c9=
8ba
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D67defecaa74f7dd=
0a5d3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17109b3f180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10bcb2a498000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: net/sched: taprio: make q->picos_per_byte available to fill_sch=
ed_entry()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

This seems legit, according to the repro.

#syz fix: net/sched: taprio: make q->picos_per_byte available to
fill_sched_entry()
