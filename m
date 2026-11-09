Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794207198;
	b=yBO1x/mCdDeHaB0O22NaTk87BYLT62bGmBUM96nKF3sZug76tybn0XJiPCpxgFjuzBIr
	 z/McHf2BKLBbb+FLJiUXDOeQHcFxUxDq+yz7pmx41iDWZ71CvvpXEjXiaWHSB0uGvIRQt
	 z8BUGwodzyOygjx0bmA3wgFb3EJFvq3bmPkiKkE6mxZ7b50wDkoAo2mJAdyHUTiS2cxJx
	 C6gxIKwVUi2bHpx0D9oBJ3wKAmH0GRAeiU4hhNw98cRm83v45F57fKWwOGL2gc3RMuUk9
	 YY7iApWeW+H9kuwz5CGQ0wfrH1/MBNhsIJMBO2P9oZjKzqTe+paDP9B9d3/Y8e7ksaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
	b=bIfjOuI8wHOv3eMBwUD7KgntzaZYus4KigT9HDExbSLEErXXQMEVhno7a7dd0W3PZNxT
	 2SWSOhNhML8QonZUTgZK6ugdbPJZkOAqFChWT02Rvei8UKm5uDOCBFQKBGCcqEAYu76tt
	 b2yRR2zBm0VoUDc6XhUmLUqwQz43vD01QLQ5dlnk5jRyLgDL+rujjEgtfQQDbZinkPxG9
	 oqjhobUGR+vha6Z9GaLt2GyH2NNZtdsr1hlsfBTdJtMkg8kFkw6Shz44gAHzp+mIqvr8j
	 VH+uOjMmM2+g7UKmkiTlqFACPwTGl1XfTlgMP7vKfgTxfgLwXY7cJzgIjagzY19fGig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sgWujCEB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548AA606A323
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 06:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 548AA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sgWujCEB
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c14f6f58aeso329664e87.2
        for <linux-security-module@vger.kernel.org>; Sun, 08 Nov 2026 22:53:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794207196; cv=none;
        d=google.com; s=arc-20260327;
        b=mfz3E0bDF8SSGyKUAcQqZQLdwJzb33AzZmU3sc7UkFmlqyopxxhueFRwC0bHk8mOZt
         atrxSO31CEXKIDDsWG0Y+qe/m50V+lH8Bibqo6A6cWyl7hwiOlnPbTCWZn5jHnNhvm0H
         7L6i/YQ0G7HGbd6ASDThrg0a7kTTOantgN5J0w0wnzlYJDi8HPiHRekMCWlFy1rcbFGJ
         5AxIAAZV2sAs+XVBeB72oMGO9tIK1dhZPUnyD6mQkQylJTHR7N48Z/56mMac3f2ogCAr
         fqELJqbUEHJ9pTbBOzXhtZOB237tTzUHz/ftwCYrytTvWKcx1YhwHz3GtnG8FBY25dGH
         29aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        fh=gPTSEN2VYRGxwYq/uXgLWKzIkIb+RydODzPU+Frb46c=;
        b=KVEhkIOdScFvxRr7e5BRuA+jg8y/2Tah/7S6FfxBZ/A2mBLEawEnkAk36tIM1gdfDH
         VMmCb4qty3G96WQEXOQmz50J3RMkZ/4IFMsqIsXR8kRROeUvKFXasEONy2yuu+Vxl/iz
         NgTddpyhQt3GcolsEYV8E3Axw16BvI5NR3lPSTyL0e4dEkbXUhIKbVf98weLo/nWqt7G
         n9EX1lEA20JV6M5eqAKXzg/QxKtplLapZZGqf761k77aY2BRW6CoydSiHZVfooBMgvsN
         tBecakd4rLBP1QH65hKemjPLb0mh8RaDHpMQOYvQa0pLWZmL0WxkfV4zaCXx3ybzXwgI
         UK9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794207196; x=1794811996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        b=sgWujCEBcLnI2rCZx2+HrV0hdHuKHGWZkbP/T95hfWdHOsdro1qJU1Fvk+8OO9MdfB
         0BqsBZTh492PGUlz+uiD5cFVvZc+vlVmSZhYzi+w/tlD80Sl6tEzuWFCWZhv/N6pbH35
         rLWt1UHkkGkHK24Z/h6vBhtLRJVzr1jbqDl3LlT+eJtmAmj2BiR6ABZnJcxKkIEwjeuj
         rKb8qVeksOei/N1ZYTOxCXuIYcRzPS0XXno11fSFmwYvkRxmBZ3+yYmHEczZNKiPx5RZ
         oHt9g8LUVuNFkbZtPXFWBtwsCaMo3xAJFO6XAxUED9WmEkoDJbCWdP6YC+ZT/ijPGBxT
         E53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794207196; x=1794811996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        b=AaLIay9smwC3K3DeTKEXF5SQ1MkrdattclxkufYux54rIuLvF8SQvTgSMbkgBJxoBS
         PAoTLk9CE75hZkvkPp3lCAFZXhYhq1APHYIkCn5AOi2zboophaPV3iMcuKSqYJQPcjhy
         8QT/+MNpJWPhoCEAyO2AtyQrZOTv0957vMwQhmrMYJhia/APOGsolUIWYTGLuImbCnFH
         OEg9/KcoNLe6M3m0AnVdN4BgczRvgPqNDPiMWnSNqGru0ew1gLywVuyrRrPU0vhPRolj
         yLMSxbJBlz4ojtECvS6H865eQXiYYvJWxCS18+3o3e7UxXnRb9DFhkJDhV+Otr0MZeCV
         xm6Q==
X-Forwarded-Encrypted: i=1; AL+hErGc6CZ9AoxbBdYD44R97TT8kT4JHss6/3Pz6CH3MsKY0kQDj7VX466eoecV5+DrDwnuGK6ihmn7TCIwmpXgdzK6C2uYfaU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rHFyGMfvkRWyJHkKqL9vY2KPsmB0PLIxjQzCNYEc2p0iqMO1T
	gcq9Z8FfLQAuMedPWGom5k5dPByBi0kOT82+1Ro+skthPUPOb7vkRvt14jia7hV1bFbQAZnUta5
	GYMb+YbEwSUGfHRb7RrzF4osMhr8w6wQ=
X-Gm-Gg: AYBFou2Jy4QOjuf+bFooX9xwU3ihbakpIEIYwEoV9mo/QxiLYwFF2SOFTtDhschmY/m
	OSv/EahJ+KGAXp8T6AYaoV3iJtRbXkEZwn0uXa2Ou4202fByxO8kuCM5PT7TbV1VGJvrSOXL2/d
	53NeCmW7mXucfLrFk+wB6smi9oqaBWFddbk0NQjohhWL7caKV52AmOXRoltGv2yz1nBRWq0qFqC
	peHl+6ghfSY3JpgAyXsovqk40ejU9Mw6oFqjnYaIJcsEcmyveRRwnQHLHGagtvVHbUu3hZ7JFZv
	DjRar2tMgA5A7YXTp9A5Il0vlwQXD7tKV/9rFI4rfzBLwCO5BtsAPAmZGtN3i6SQG04FAXDNMd7
	mQaFvHa1owT6oNjct2STJunZT5ezruF+sUP5uNpqA5dICwmmiP2EyCs+JGiZAhIwWVSjTyI72e2
	lDFRfgnDOlNfzNjoAj/vqISZWkQLi3HXXelYGq0irTQyjskZU/d54=
X-Received: by 2002:a05:6512:3e1c:b0:5c1:4a48:c2db with SMTP id
 2adb3069b0e04-5c14c01f805mr810751e87.43.1794207196170; Sun, 08 Nov 2026
 22:53:16 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109025425.328445-1-jiayuan.chen@linux.dev>
 <CAL+tcoDvFNAZubOjw9+Z1eyaVeiBzt_Xg3KMNucY879bg-ZLow@mail.gmail.com> <dbdb9385-89cd-4e4f-bfb8-b72510e8801b@linux.dev>
In-Reply-To: <dbdb9385-89cd-4e4f-bfb8-b72510e8801b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 9 Nov 2026 14:52:37 +0800
X-Gm-Features: AclHuK9hO_h4FFhel_M7AacjBweA615sygy6vgIfEMNG5ukVHhzyCYoysXzMOxw
Message-ID: <CAL+tcoA6_gROiprd7YgxvwbaiuzEUPfuWTNMjKu6vDkbUJ5KPw@mail.gmail.com>
Subject: Re: [PATCH net-next 00/14] net: annotate data-races around sysctl knobs
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>, Paul Moore <paul@paul-moore.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Julian Anastasov <ja@ssi.bg>, Allison Henderson <achender@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bridge@lists.linux.dev, 
	linux-security-module@vger.kernel.org, mptcp@lists.linux.dev, 
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 11:33=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 11/9/26 11:11 AM, Jason Xing wrote:
> > On Mon, Nov 9, 2026 at 10:55=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linu=
x.dev> wrote:
> >> While testing the recent sysctl range fixes I noticed that a lot of ou=
r
> >> sysctl knobs are read with plain loads while the handlers update them
> >> with WRITE_ONCE() and no lock, so KCSAN reports them as data races. I
> >> then used an LLM to go through every ctl_table under net/ and list the
> >> readers that were left behind. This series annotates them with
> >> READ_ONCE(), and adds WRITE_ONCE() to a few custom handlers and netlin=
k
> >> paths that store to the same fields with plain writes. Most of it is a
> >> plain READ_ONCE() at each read; where a function reads the same knob
> >> twice to make one decision, it now reads it once into a local, so the
> >> comparison and the value it acts on cannot come from two different
> >> writes.
> >>
> >> There are no Fixes tags. Done one knob per patch this would be well ov=
er
> >> a hundred commits, so I grouped them by subsystem and feature instead =
to
> >> keep the review manageable. If maintainers prefer, I can split it up
> >> further with a Fixes tag on each one, as several smaller series.
> > Over the last year, I've been thinking about the annotation stuff
> > especially around sysctls, which, I suppose, shouldn't actually affect
> > the real workload but does affect the outcome of the syzbot.
> >
> > Out of sheer curiosity, my question would be what is the point of
> > trying to change all of them? Or what kind of benefits can we get from
> > the big series?
>
>
> Three things:
>
> 1. A plain load may be emitted twice by the compiler. ip_error() compares
> peer->rate_tokens against ip_rt_error_cost and then subtracts it again;
> if the sysctl changes in between, the u32 wraps. A few readers have that
> shape and now read the knob once into a local.
>
> 2. Tearing is not involved here, all the fields are at most word sized.
>
> 3. The rest is the memory model: a lockless read of a field written with
> WRITE_ONCE() is a data race unless it is marked
> (tools/memory-model/Documentation/access-marking.txt). That is what KCSAN
> reports, and why most of the series is plain READ_ONCE().
>
>
> I think the benefit is doing it in one pass.
>
>

I was curious about the REAL impact. If this thing really matters, we
have a lot of work to do even not only in the networking subsystem.
Sorry, I still think none of those points are convincing enough, but
that doesn't mean I object to this series. Anyway, it's just my
2-cents.

Thanks,
Jason
