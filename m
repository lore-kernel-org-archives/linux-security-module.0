Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B73A6B70
	for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811811; cv=pass; b=TfttqRqGwzDnVbGi9F9ssmvQXlCZi7Q3bRPyv0k3emtCvFTQ2ajP82ZaCEvdzL2rIWB7Y/cZfU3fDwfKRpjizWNUpdP2zluJgoR/X1ZMC9C6PaeV5bM5H9lQFSgwocF5EAQq6D92BO9+a+WSKb9b/MrSLF28xHj8YbXxdgBJp+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811811; c=relaxed/simple;
	bh=RMm1B3gm6JHZLgId0qeTHFr/hRq1ZH8dqi5UXmGTaKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scyP2N4N5JenLd2tZ6UMt03A773EqG5WDcnfPVnqXJQRmjOCxCW0ZhrbqEbF9JHB1w+WcJcMgvDddOEf0rhgh6JkGNEA/mNYVln2U0Yp0BvefX6dcBfVoJfM7gIhyQ0xDuURb7emMqxR0lqm4ofWmkV1mJWneP+x7cbi3Z9BCG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T75RJCJi; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T75RJCJi"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b0afa0210bso22256215ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 15:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811810; cv=none;
        d=google.com; s=arc-20240605;
        b=DXeIMYsit+PlOcs0i/EkoMseJHkqTUjMGFZi3WFU+fWxV9IwqsaqK7WsnNw718n0DT
         OZd0LB1zUBTvw7Hz7pdB+Zy2kAx7BEHbWWqNM4iihfuMa7NLHLVy6UF9KqwBNgdAo2lN
         IP9wJUpt4VbtxyC6PMl5pV41//jNS3ZhTaBeLMVFVkyBhLU/s0epP5lK/odhH2MOlR3+
         zhM4B6uh6k0JGuqhEmaXb4hsloFVmvjttgRXpSCNzgcfctjJIy2u2yGwK3TpVhuNF65x
         922LSgTr2rDza+U4ybES3IFYiTqzdGzlTSCkPWIWE2jKQJs8I8L+HnoD4KZq31WTSVaR
         ndsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RMm1B3gm6JHZLgId0qeTHFr/hRq1ZH8dqi5UXmGTaKE=;
        fh=T04RpRV/E7Jh9FfGfO7gUnoA2BF2vjinRxfsthVdTP4=;
        b=bsCefGO8T/G+ICllZh0flssf4yQ9ikY7uya8f0w98V3sK8wOFHPvxqLYXkv8Oexqv5
         u9f8skry+EdKdC7fGCONgmBvAb3LUe8wQuHzBjSrjkPpzndCz5bd0l0pBwS2wLSFUhEa
         yMKIvg2Wioy/E1mE1MPtjIW1lxp4SdtHwS4ZmIdtpxRvLP06FFpyCoz+kpkhqK0Alz92
         0hNIiou3mxZf5LHW4Qgcm4AmuIFEFVLvcNunWGE7LkhK+qGLaHsjw9SjI+S5V2MIyy/K
         Fr6bTULOtbbBkflTlbDZDwGZZ6VQ6/ptqCYnzRl2p0I8lMqgaVEwwNtIKHKsOvHGtz5O
         YIsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776811810; x=1777416610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMm1B3gm6JHZLgId0qeTHFr/hRq1ZH8dqi5UXmGTaKE=;
        b=T75RJCJi/8g+lGjFoandwtXi2tVESI3/UIugg6CRYqICGsXnA9F0jWXhxoqU8IWIix
         UUL1wb9ZPHEFuoCB2QNnaCXPyBEmsUoQ5MFscAFA9HtA0KQ2MMZsGK2/EgFFLhXx00io
         bW6Bj7J/heMT7bxY3FrLeZFRmAE+WjVebBYr38MRBfNrf5nYqEJpja8Kl+XDGoopdYY7
         l2omqBX4MIBqbMIeVia3qbeIx1X/VPODFuQ77ZgOtL3PLa3dtg4VrPzniZrXba79Du/m
         nLZLwwz76lyTwSQHVYHkg1IXngrYczlDySkLNVsfgoZUcXrT+/GTwHT8DKX83WEk/Yyq
         2rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776811810; x=1777416610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMm1B3gm6JHZLgId0qeTHFr/hRq1ZH8dqi5UXmGTaKE=;
        b=RHdr3I6JySQOXUqkGcGM3mbNwsEUktdmc/0IoBTaqR8EKnEzton5zGbHvyUaqVgBl+
         tBNM32dk9C5yX///lLZZbBkXSsUUPyMjJRW79mltLSy7xBY9D3UeVWOYhAhw3289DNo5
         wAiLfb4jXEtPPB+KADLM8g6DaXRopyd3fWsSE1/xo3pQXTRCw0/DrmpoapV7EdaSHKG7
         TtBPZhjtLNjRvK5oiAa3gdDLkh0LeDWutTzRfsh6PghYdjhkzftoGuRvicmE2YCy3N8i
         5m8u3Wv27SJt9oXgINNXmNMzCsRXKo/s/VeZ6wzEtrVeofkfmknZDsorHcDnQ/XDVr6Y
         SHiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wGGK+sVCsO2e5F8bjsWLcuw6g/GNqxMteEIJV87hG1UhXHUdYC6lWSFCjB7PH3yVCw0VgkkGZoquLzIBzfR26YMM6ois=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZI0uNxSN989gdDO+JgPjicMPsDGjkHOV0ffTW614DQXfRolm
	KUgzTcbC2tJYH+OIoQgigK8mEhjZNVyPUgQdYAjCIH+waLga7rGs6pHKWFqorFGeo6iLLZTyjPR
	X5oAJQevyQqUpvQNAs7TpZCzwfyhoaC1PJ2VWnZpN
X-Gm-Gg: AeBDietCRz1LnTwdQuRbm+mMrVuBkQcsiA0BboI94/o8JYpsyCP/MWOKpsLpXa/Qj28
	IF+LpiKqXMMozyIwMoff6GeaJs/3JC5cGm6B76A9fN6i3sJ0vYzySWjX7+Edcu+fzG4GX5nip7K
	hLhJJszaWJM57+RrQ/aqptJHf3+l4TjcVwUSFP749OhMH3UZbLXJ3sCDy7+xx5gvRrT4RBXnE0p
	UmIwDBYI+ENZ1rndtwzwopLrbBo/4F1+tgctNSONIdJ65Efw6seYSe87cohM9wjmMfzmdhIzMZd
	NxMK2DLhz06KmyzMwA==
X-Received: by 2002:a17:902:be0a:b0:2b2:481b:de68 with SMTP id
 d9443c01a7336-2b5f9f8f446mr154652785ad.35.1776811809715; Tue, 21 Apr 2026
 15:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3> <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
 <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com> <CAADnVQL33TOWFmxcWod3BCgmMXSQ=cEp6NCcxgQaJL0C7+Z9zA@mail.gmail.com>
In-Reply-To: <CAADnVQL33TOWFmxcWod3BCgmMXSQ=cEp6NCcxgQaJL0C7+Z9zA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Apr 2026 18:49:57 -0400
X-Gm-Features: AQROBzC8n0JJ9DjsWU-7Puv6JCDhA7IZFjxayYVxpNJDKTQHihIrjlR17p1FK3w
Message-ID: <CAHC9VhSKvC+p5j5Pe1YKB-=vRkRA81K3kp97Q6-H5K+kvYa0AQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Frederick Lawler <fred@cloudflare.com>, 
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

On Tue, Apr 21, 2026 at 6:15=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > > It's still Nack.
> >
> > Based solely on the diffstat and a quick look, this appears to be an
> > LSM patchset, not necessarily a BPF patchset; yes, there are kfuncs,
> > but they are LSM/audit kfuncs and not core BPF functionality.
> > Regardless, I want to see how the LSS presentation is received before
> > worrying about this too much, but your NACK has been noted.
>
> Paul,
>
> told you countless times LSM cannot touch BPF bits without
> explicit Ack.

Based on a quick glance it doesn't appear that Fred's patches touch
BPF bits, they simply supply kfuncs for users to use in their BPF
programs.

> So, no, you cannot add bpf kfuncs in random places in the kernel

I see plenty of places outside of kernel/bpf that define kfuncs.

> And, no, you cannot call bpf internals through bpf_map_ops, etc.

It doesn't appear that Fred is doing that in his patches.

--=20
paul-moore.com
