Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515470;
	b=GedYVFUN7nx7g2Wuiv+3qfzz5HNX3EnWYchnQq9IPOzuHht2bG0YfKsOV4XEURk2BsjD
	 xeUQHvWkSqHUPjabdY1+flugHEJq6fH3N3TFF0aoLJVC2NAgdYP6Q3YVTL1ulNucr+gDD
	 kxJ8m+BH3DeFfn8DErUs6X5HcQ8+3mfQy672c8h4llDTrrKyKqKS7Rrs/ACBaP2l1nbUd
	 wjj9M+V4i6vLgdoxnqCGAzLUi1h9FiMGOGQWBA2V18J69HFqYf0fqrEP56RIlFrsKKfDp
	 UL8DB+jmBlSmIVqxuoXiw2pWzzPK+Zu9HUfera8W57TIhw72+JWYFkvUe+e9xV33YhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cDR7cjV4IRioJgp9xWXyZAeSRy7CXHNvvQiffZPND/Q=;
	b=0gwwSSu366qOYuBVjIaY/hM3Fd3mQeAPttGM0Ut9DbQaedjfNPTCiKKsk6+jZ6j0qLfP
	 u3I5bbrg2CE7r64zpjwAus8gqDYQa0vXRb7tcWfYN47HP3swMcoSJTUXBgpAfEQLJ3oEY
	 st5y3KYPllVVCZk6pPevHBBWbD1+qdGhr3hwq5oWTQ40g2K/PdLOHwJEX5byxir++MCD8
	 6s2sni3cW3jKhW2Zj0hC0YPZQc9846bZetD5942tTqX0uMbGDitrGyZ9fim+xQ57AMDtt
	 CmeMHMcfYTX/OP1eUsBbFKqqtWb8Mt2cthay5B7zF8nWlNTs6cVWYAdIql8xzF0YnWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=boQDOESY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75AD606A32D
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 10:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B75AD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=boQDOESY
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cde0daf3a2aso1780201a12.3
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 02:17:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795515469; cv=none;
        d=google.com; s=arc-20260327;
        b=lvqTtDFBY3yd4wQguaKntiYXt/Hu3fqlAHUeimPxnau1XA/ATDt7vdHCPmgULu7mqz
         4PtOUjBZXdZTbocCMhbh7WK9vWfoykHeE0HSNhYZi55GDlWHSVnguGkahyZL1pexl8jl
         e89lmAmzMTAR8mHaRGo2V6gB7P4vxzQas5jJRWYg5BnoZyDtgohVu1g4kxTlFLBCOsn5
         hGIos+KCL7LyOEiVQi2aOw+AVn+uzwFPGe9GJak5w9sAMIy1r8FtrKzVdzPp3TpfjoEu
         UaY9jOdb/cKc+d3LCzOyhP1aUWwv4HVIejpqd+DaKRRUaxKUmXRXN7276MEndqGFFqBW
         IRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cDR7cjV4IRioJgp9xWXyZAeSRy7CXHNvvQiffZPND/Q=;
        fh=ORXsi5GDC5/Y3fMdmVy9s/P+RFxpuBWfAmo/IfglKSY=;
        b=b9M7Lr3TWT0vOJgNCB1MpiksHHZi+DNb8T2LEYZlpvmd5s/9TYXQO5ULzyamSP5sT0
         SUViXOMUp7rOl67bqzeLMs5LJ53AlbnaEBLMMRDWF5AB6lJ/J6r/H0uHK6zo9W24qGQ5
         7mesmfpDmaGZePscySXUHmKUZ2SJH6iPeVzIsCN4SBkgO7k30fWSxU5Aw88T0lKOuyHJ
         8GXvlCtPaEj9usrKHkpO/YVYjdb9C4E4tM6mi0LfDQMv5wpiXfkxjhLmLbyUkyJRLUys
         P5T5Q21kEdyV29nCksxdi/o0Uvec3/NB9B2T04rjnI/smMp74+0r4n6ZjKwDkapLi7yB
         6urw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795515469; x=1796120269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cDR7cjV4IRioJgp9xWXyZAeSRy7CXHNvvQiffZPND/Q=;
        b=boQDOESYfuu+ei6nPbUoODpl/Ek47OYUgvhVk99ETOZyiaz2nZqCLusCouY2MPVsrf
         Lmi4VNPNuXk5gN0d8V16BfTeGNVTHqfHv8lmY2KZWvPzn/MwZzGSASY+bMZQ5SWPoW91
         4pw6s5nM+6RqviziclgIXLw7PFOAQx7tuzf3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795515469; x=1796120269;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cDR7cjV4IRioJgp9xWXyZAeSRy7CXHNvvQiffZPND/Q=;
        b=Dzmpq1q58fLDtdJVHdGNga6FgjKv1GKICZHBfqE6/cOJc5JOfRMrsRUTLqhrxexI1K
         bo+9SIW+4cI0i0kFB4Wdg2wemQ1tbz/LT6lSLoWQ61i3BvJArsLZrdydxWRoNTvJ6OXi
         cxl1Dknb7uWnsU49i9vn/IudCdCB9+5g87nkMEFTlzgGHOlursOcGt+fZ2elnhgYWCHL
         Rnjdby1a+VmeaqpAAgY85nPoJNeRaB+KfktwyI5f6fO6CmrcT2NmCPly8hywKrJauAze
         nQyPpczMt2mF38XfngNHqHBvuXdYUemqofRwpvdJJHie9al6ij8kT61rs7QGsEb8m2aQ
         5p1g==
X-Forwarded-Encrypted: i=1; AL+hErFa+wRdfnx3kYx95mQ3vqgWM2WDI6bpaxLX00Vpke6QF9Q4RJFKJS8jy4/6xbGds28K6g6VaQan41pRpEIJGJwrc1HkaqU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AkurqXKSePFGQ/JgQjwdD5/TpUxkqiCpZWQeOAA0Fi7HSQ3sv
	dnBC9MkpJf2zjDlDrWmIrvNlSQaaTzvytO4uKFtYWTu7nIrFftUlA+SHeP8J78t95sRS+dH62GG
	UZllxJ77o2j1fXpRTVxDxrG5pXeLUbCZcpDyHHSHj
X-Gm-Gg: AZFdTZdrYC/NSfStaEl+fQQ6OHxLi0dwHYGKZGyLA6y9oBhz7juDDm1Z54dlV4+5UjF
	zcXz9U35myD6lReXgCJ2fxUHogwf7XjLRzqYz5Uvba6QeiCPEHaPcAQfPwy+xIZWHaFzHEcEP+0
	1uP9uMrW39lgQjuQU1PeMM45INMKYicChGJYobZd2XzzL+KLjxHpJY7+RNJV+yqU87zQWpV24EK
	QOo9XaPnP4WY/KZIo2DEMiebuh1TP2k+jf5zARroTzFCRIvPsfVqs/WMxs9Uwe7Ti+AGtBCX0MK
	0OYKv02QZYpOdGAJeBrwJ9CGDv0/HZl71YB+RhMNc5XY7V7Jsr8sAtIds/+dzbithv7dmnLFizC
	BRcNQr3Ap+ZufiJq3ysmupPUIhFgfMSLL3a7a1G2cYB7tu3KT7c1/7S2HItZ6eqVKet8lf9XmyF
	WW16V/nO0nUTGcseB5Dt6f
X-Received: by 2002:a05:6a21:4a8c:b0:3f2:acd9:132e with SMTP id
 adf61e73a8af0-4014db57e24mr12442219637.61.1795515469040; Tue, 24 Nov 2026
 02:17:49 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6b051681.58b41460.7037.0590.GAE@google.com> <DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com>
 <CAM0EoMnVa=xGD3uiZKuzMfFL6oZNd=Umb0U7+_QUrTK7Ej-BYg@mail.gmail.com>
In-Reply-To: <CAM0EoMnVa=xGD3uiZKuzMfFL6oZNd=Umb0U7+_QUrTK7Ej-BYg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 24 Nov 2026 05:17:38 -0500
X-Gm-Features: Aa3M54oAhgDu4a3QN-cUvm8ntTPorq0ToGdV6xzEFC1H8I-IekXAnPLMj4fFDqA
Message-ID: <CAM0EoMn=ZghG5KFu2Nc=W-=KjDv=epspFHZVDY4ww5a9GBUaHQ@mail.gmail.com>
Subject: Re: net: act_gate bug. was: [syzbot] [tomoyo?] [mm?] INFO: rcu
 detected stall in security_file_ioctl (9)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, andrii@kernel.org, bpf@vger.kernel.org, 
	brauner@kernel.org, daniel@iogearbox.net, jack@suse.cz, jmorris@namei.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@i-love.sakura.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-users_en@lists.sourceforge.net, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 5:03=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Nov 24, 2026 at 1:00=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Nov 23, 2026 at 08:45 PM syzbot <syzbot+b6f8640465bdf47ca708@sy=
zkaller.appspotmail.com> wrote:
> > > rcu:           hardirqs   softirqs   csw/system
> > > rcu:   number:     5264          0            0
> > > rcu:  cputime:      138      52351           25   =3D=3D> 52490(ms)
> >
> > It's not tomoyo, mm or bpf. Looks like act_gate.
> > Zero new softirqs in 52 sec, so one hrtimer_run_softirq() doesn't retur=
n.
> >
> > > RBP: ffff88807ed35538 R08: ffffffff91be1bbf R09: 1ffffffff237c377
> > > R10: dffffc0000000000 R11: fffffbfff237c378 R12: ffff8880b8228600
> > > R13: ffffffff89fd0480 R14: ffff8880b8228600 R15: 1ffff1101704514a
> >
> > The registers with lockdep struct sizes:
> >
> >   reg       value             points to
> >   --------  ----------------  --------------------------------------
> >   R14       ffff8880b8228600  cpu_base
> >   R15 << 3  ffff8880b8228a50  clock_base[HRTIMER_BASE_TAI_SOFT].seq
> >   RBP       ffff88807ed35538  kmalloc-512 + 0x138, tcf_gate->hitimer
> >
> > act_gate has the only soft hrtimer that can be on CLOCK_TAI.
> > bpf_timer_init() rejects that clock.
> >
> > TCA_GATE_CYCLE_TIME is an unchecked u64. In gate_timer_func():
> >
> >   n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> >   close_time =3D ktime_add_ns(base, (n + 1) * cycle);
> >
> > With base =3D 0 and cycle =3D U64_MAX, n is 0 and close_time is -1.
> > The timer restarts in the past and __hrtimer_run_queues() runs it again=
.
> > It's there since
> > commit a51c328df310 ("net: qos: introduce a gate control flow action").
> >
> > Jamal,
> > taprio's INT_MAX limit doesn't fit. tdc uses cycle-time of 600 sec.
> > The diff saturates the sum instead.
>
> Looks familiar - i will take a look.

Ok, found an abandoned related thread in my list:
https://lore.kernel.org/netdev/tencent_FAEDEECDD478AE6DFC2DE96D389440E96A0A=
@qq.com/
I will take it from here; it looks like your patch is still needed and
requires a fixup to the abandoned one as well. I need to reproduce
this first.

cheers,
jamal

> cheers,
> jamal
> > Here is a potential fix:
> >
> > diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> > index 711cf24..5422d60 100644
> > --- a/net/sched/act_gate.c
> > +++ b/net/sched/act_gate.c
> > @@ -45,8 +45,9 @@ static void gate_get_start_time(struct tcf_gate *gact=
,
> >                                 const struct tcf_gate_params *param,
> >                                 ktime_t *start)
> >  {
> > -       ktime_t now, base, cycle;
> > -       u64 n;
> > +       u64 cycle =3D param->tcfg_cycletime;
> > +       ktime_t now, base;
> > +       u64 rem;
> >
> >         base =3D ns_to_ktime(param->tcfg_basetime);
> >         now =3D gate_get_time(gact);
> > @@ -56,10 +57,9 @@ static void gate_get_start_time(struct tcf_gate *gac=
t,
> >                 return;
> >         }
> >
> > -       cycle =3D param->tcfg_cycletime;
> > -
> > -       n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> > -       *start =3D ktime_add_ns(base, (n + 1) * cycle);
> > +       /* cycle is an unchecked u64, the sum must not wrap into the pa=
st */
> > +       div64_u64_rem(ktime_sub(now, base), cycle, &rem);
> > +       *start =3D ktime_add_safe(now, cycle - rem);
> >  }
> >
> >  static void gate_start_timer(struct tcf_gate *gact, ktime_t start)
> > @@ -107,15 +107,8 @@ static enum hrtimer_restart gate_timer_func(struct=
 hrtimer *timer)
> >
> >         now =3D gate_get_time(gact);
> >
> > -       if (ktime_after(now, close_time)) {
> > -               ktime_t cycle, base;
> > -               u64 n;
> > -
> > -               cycle =3D p->tcfg_cycletime;
> > -               base =3D ns_to_ktime(p->tcfg_basetime);
> > -               n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> > -               close_time =3D ktime_add_ns(base, (n + 1) * cycle);
> > -       }
> > +       if (ktime_after(now, close_time))
> > +               gate_get_start_time(gact, p, &close_time);
> >
> >         gact->next_entry =3D next;
> >
