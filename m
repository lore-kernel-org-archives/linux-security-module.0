Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795514621;
	b=UN6DuSbyTnsta2C6qAMKIbdnjeke0EK/10Zat8Z3hBoGrNiraKrJ07MpCiehkKvWZHep
	 xJe9d64LLdeeQ8HLjN8iwAovaqOvmE8Z+XGOg4gpG0crfwP1XiZJGVxXiUU7DnPXWvYq+
	 C7MyUly8W8ot4+IZo4YPWxjkbavIDJxFZrhp38eWxTDpbbzTyxQsNoaft7/nYsIsZvuQZ
	 mdIbh5b/YqZOM/as2a9H8/3GuVd9XDaliRIEHoDC4Ril090/Puyg+1faUftU/1QuN6C0E
	 89zOI7S9pAdw3JM8o4W3BZfLY+nNit/x09005qNVfad0JgD/AsIRTlrG9+9UrJfSgFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cGN5g9PtUGCG+wcdSVJumY3ZUtFUe8Es3+mlikmGYwY=;
	b=PPHKcF92dyV2TRXCnwM0HZ3hFIL9EdcgPg4UkX+uPED9/lZsS18oaJEvGVNz7Dnby1h2
	 tnNRz2YJYyXKE/Nlq9rxbsYcP3qv1q81U2xoEbVlj0hoSK3viS7XxGPAcp0djqEcS/XSI
	 ZrJmUjquIbcCaSv2mqs0/sPdFMMREWfPpwHZ6v3ecLW97dKYP+7RHKXpWgO9/uIcG/OlK
	 BItIUK2omqiXc7wgW0wEDcroapoq8fZhWLdLeNc1Ohm7KdoB41eNIrCaSPiq1JOjcQzgU
	 dDAUOkvspyifCaeZg/Wucl4abDQMshC4LxRfL4mD7lU7O22KmaPSZZbkf9ZfoL/HRzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=VmWAs86N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91A4606A330
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 10:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D91A4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=VmWAs86N
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b6b22be970so1634273b3a.1
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 02:03:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795514620; cv=none;
        d=google.com; s=arc-20260327;
        b=P9X71GEU87qvvb7R9/yDi6VxJngjyM6G5LvNJysWMXTrbil610MXyLuNbEErlkmXDZ
         /NL+kROtNOD0YcWMHUFJWer3rWss0uAo3ttgL7OwoIi+6lhifbIYFh2Zsk7Atbk39Bry
         Hn2kxqe73XmgcM0lOkaIRNuFzHqW4knpecg75MDkTnIjWE+K3KixfLhhEiemR9ZmKqnP
         rgjB0cK38VSwHc/ncrcRUOQCPk6auNRQIVm4Ezc8XUHuRmKZWjnpaxTJ6fboFjx5oDKx
         Mil8UuObOKz81y+itDQu3wjWsxhqC46ks3lgDU/1W3E/yPvUBoJji4z7el7TFLbHVb4e
         X3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cGN5g9PtUGCG+wcdSVJumY3ZUtFUe8Es3+mlikmGYwY=;
        fh=6ABc1lYApQDXyiUuhMFIZIZp06beqved2PSEFW1M/CM=;
        b=XxcFtBRbglw9nEnGdqfxC1NKzW9fCEcZbJKGndYIGrVsYPvw1rabSi5/1ynt0CFeeH
         GSQ5ekqvlNq1u+iLgvBeysCwlMtm7Lpg6ePgOWFCTmA0AkH0kV8XH8u+NWNXsuZE6mUO
         h4Z2whs3orUubV64/CBa3pl/FsfCLXMt6/3C+t6kS5Zxk2qRNUclVP9JVB8O/vPXOh6V
         HdGR8YEq3vsuArARMOwvKFMZvuACxBEO62kUbLSQqbeB8WfHu8M978POawixuqPiKhv5
         nX35CbGN5akTX2MoSDFTISo8X1X38q8pwgOjRxgoHAk6O9ZOOwKdfELEqvbhrPm8X536
         KpJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795514620; x=1796119420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cGN5g9PtUGCG+wcdSVJumY3ZUtFUe8Es3+mlikmGYwY=;
        b=VmWAs86Nz7sib60O4izbmOD6cZh1oJHcY4TIr9SaP6pD5C0G2T6As0XqGlZXCid52l
         D7UokUSGtJok+76yw43RikasNHy7al4rTLqNt+q+izWEJlO4nwef7uYHHiWgKe9yWWTM
         I5j2coA6k1F5B5uggw7O4grg7Mi+N5CcJvy20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795514620; x=1796119420;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGN5g9PtUGCG+wcdSVJumY3ZUtFUe8Es3+mlikmGYwY=;
        b=mC/4yzdFTQvD+Ck/p6IKNYx6M+dD/DJ0Vd427Y68MCdTkkslYE5ef+SLmZwF12zYSE
         4KWbk2bOcFj25lpYCKZ+CmLsvig7cJ2flzb1/Q3s/ChOt6mT6yxYXs2TWRN7nG60Kz0N
         AcBJ41QF+pm+9gSwwTVCscGVWlxbTk4ExnqQZUzomkEcTjs91dgTfxz0cwXbSD+8hYiy
         aOD0HvF6PSEkbbN2unZ1G68Yv+oPdGUyy0f9PGALJ9R72pGQW4EczIU2LlcLOSEk2ya7
         oBu0dqvurdVR28efgHjdSpscxLa82GzRrN1sBVaOxMY3jKTEM8aouy2K+Q4F9m6Au5Lq
         TVxg==
X-Forwarded-Encrypted: i=1; AL+hErHxQce4J7/yMgaii+EqEVI7Px6rQ1dDxQHcluqh/JPBuepBfeUNJVmAH+YUnEXLsboRg2SeyMJRvDFJ/2jEkW/0uGqs+YM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qE4wmMrpwJGdw01jLEN3slNhQPUxxhcIseA0t3I1FwlZUz9dN
	eMMDuIGF8O3Njzx3nh2xl4UItqio/7ESKYJn68SKENP39AANomLrxsIBFOpk2cQ9dDucqy/8QnH
	2syMFWaOtOP/Go9PcZTmQPe++8SZB+eVPckdzZ0Vx
X-Gm-Gg: AZFdTZfB0U3ccsh0L4Xf4Wv/9S+mjVLWJkyjAlJnnXoyn4RVrUAmcYLutq6IBFMObND
	AB20a95Srpekthd4IcsL4t7eFLHI4T2q5EJbdaozXrwHs4CmFcf+SjpkN4up5o+3x7kllKhUaSS
	QnHaFxHaK0Qm+cdfmqq9U94/2/5vfxpZ1iHzyi880BsNEhEb7w/ZvbV6tr+AE+HQUVLQPEclU5n
	8WxDjFp4vecnIqx0xLB8Fs8BeQ3A2TLxTX4XgENLYHidfG4eL5Ovz5WlQfzwstMjRXqYiuKW9Ll
	51+mDuR4LaI2QPF+SHq45EKb7ySP7+0IURiPyfS1elGMqWFL1HUvsXRCtGWVVcY53RbFofh/o8Z
	lZ9P46CKU+vbQtXHb+I46121iNpLped1guQR//IsfE396UOYoosxVQGHpBkhqJp+OwYhLdI4jLC
	rB0aJTP6yrKvx3WOWX0ZBc
X-Received: by 2002:a05:6a00:3c84:b0:89e:ba55:119a with SMTP id
 d2e1a72fcca58-8c87d123bd5mr13499490b3a.47.1795514620227; Tue, 24 Nov 2026
 02:03:40 -0800 (PST)
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
In-Reply-To: <DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 24 Nov 2026 05:03:29 -0500
X-Gm-Features: Aa3M54qvcfjcRlRGJK01N9tkR68vSDtEhX-HABSVQSN3K_q0am-4DoB8x5iA1ls
Message-ID: <CAM0EoMnVa=xGD3uiZKuzMfFL6oZNd=Umb0U7+_QUrTK7Ej-BYg@mail.gmail.com>
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

On Tue, Nov 24, 2026 at 1:00=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 23, 2026 at 08:45 PM syzbot <syzbot+b6f8640465bdf47ca708@syzk=
aller.appspotmail.com> wrote:
> > rcu:           hardirqs   softirqs   csw/system
> > rcu:   number:     5264          0            0
> > rcu:  cputime:      138      52351           25   =3D=3D> 52490(ms)
>
> It's not tomoyo, mm or bpf. Looks like act_gate.
> Zero new softirqs in 52 sec, so one hrtimer_run_softirq() doesn't return.
>
> > RBP: ffff88807ed35538 R08: ffffffff91be1bbf R09: 1ffffffff237c377
> > R10: dffffc0000000000 R11: fffffbfff237c378 R12: ffff8880b8228600
> > R13: ffffffff89fd0480 R14: ffff8880b8228600 R15: 1ffff1101704514a
>
> The registers with lockdep struct sizes:
>
>   reg       value             points to
>   --------  ----------------  --------------------------------------
>   R14       ffff8880b8228600  cpu_base
>   R15 << 3  ffff8880b8228a50  clock_base[HRTIMER_BASE_TAI_SOFT].seq
>   RBP       ffff88807ed35538  kmalloc-512 + 0x138, tcf_gate->hitimer
>
> act_gate has the only soft hrtimer that can be on CLOCK_TAI.
> bpf_timer_init() rejects that clock.
>
> TCA_GATE_CYCLE_TIME is an unchecked u64. In gate_timer_func():
>
>   n =3D div64_u64(ktime_sub_ns(now, base), cycle);
>   close_time =3D ktime_add_ns(base, (n + 1) * cycle);
>
> With base =3D 0 and cycle =3D U64_MAX, n is 0 and close_time is -1.
> The timer restarts in the past and __hrtimer_run_queues() runs it again.
> It's there since
> commit a51c328df310 ("net: qos: introduce a gate control flow action").
>
> Jamal,
> taprio's INT_MAX limit doesn't fit. tdc uses cycle-time of 600 sec.
> The diff saturates the sum instead.

Looks familiar - i will take a look.

cheers,
jamal
> Here is a potential fix:
>
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index 711cf24..5422d60 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -45,8 +45,9 @@ static void gate_get_start_time(struct tcf_gate *gact,
>                                 const struct tcf_gate_params *param,
>                                 ktime_t *start)
>  {
> -       ktime_t now, base, cycle;
> -       u64 n;
> +       u64 cycle =3D param->tcfg_cycletime;
> +       ktime_t now, base;
> +       u64 rem;
>
>         base =3D ns_to_ktime(param->tcfg_basetime);
>         now =3D gate_get_time(gact);
> @@ -56,10 +57,9 @@ static void gate_get_start_time(struct tcf_gate *gact,
>                 return;
>         }
>
> -       cycle =3D param->tcfg_cycletime;
> -
> -       n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> -       *start =3D ktime_add_ns(base, (n + 1) * cycle);
> +       /* cycle is an unchecked u64, the sum must not wrap into the past=
 */
> +       div64_u64_rem(ktime_sub(now, base), cycle, &rem);
> +       *start =3D ktime_add_safe(now, cycle - rem);
>  }
>
>  static void gate_start_timer(struct tcf_gate *gact, ktime_t start)
> @@ -107,15 +107,8 @@ static enum hrtimer_restart gate_timer_func(struct h=
rtimer *timer)
>
>         now =3D gate_get_time(gact);
>
> -       if (ktime_after(now, close_time)) {
> -               ktime_t cycle, base;
> -               u64 n;
> -
> -               cycle =3D p->tcfg_cycletime;
> -               base =3D ns_to_ktime(p->tcfg_basetime);
> -               n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> -               close_time =3D ktime_add_ns(base, (n + 1) * cycle);
> -       }
> +       if (ktime_after(now, close_time))
> +               gate_get_start_time(gact, p, &close_time);
>
>         gact->next_entry =3D next;
>
