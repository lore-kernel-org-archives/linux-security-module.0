Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9032293C4E
	for <linux-security-module@vger.kernel.org>; Tue,  5 May 2026 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946543; cv=pass; b=Bpm66E9kRPEII/ChYEIDHhJdwKpJKMZ33nGrRpMLHKN62yIIbVOKysAuW0wFTudPWgdbHhXnz30FSXY5QHoFFfB0jkUSlfzS1zVDQgNRAR56A0/6huYn6emnhyH/VQcaPUf8G48lBEKwxUtIbJkWi3Wh8rGow912Spxiu2WO82s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946543; c=relaxed/simple;
	bh=QBGR4uo4ZBFT94adMzS0OW2smvVOxlZjnZ8xICFbg8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxxpFfvX1yoJUoazjAm1C3HtvTjekQ+1GdBcV5nZeoASO5n9235B4gMWhWBUGYY830dpfFJOW67giHl8Lrnw5eiI0bIDNFPl9Fg3OJbHVJtxnfto56ienJ8wnglEqylf5EE6I4kjKxlAq51N8Cv3eodoTsYw1McM6ypsZIGamGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YTbCd1hY; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YTbCd1hY"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8379e010b01so688032b3a.1
        for <linux-security-module@vger.kernel.org>; Mon, 04 May 2026 19:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777946541; cv=none;
        d=google.com; s=arc-20240605;
        b=HlotZFZcJhBjPoHb8T2X/MnN0PMf5RLPTbAc/f/PZL1eRcd57nAtnos9wDWXgya7kc
         I83rUm1w0oF3CBYDkMbusYpNoOv/EGgTQKNSYxyLB0id352B6niKXJFaSE3WO8vOGp4K
         tqrFHwg+IKILEezMSspN8RnOFez1RLc8h76/bXNuyov8YEfiXl9y6H1bmHrz0NOAtL/3
         P8C7T7UKUVk7PioKF6CWVAZIzB779/mIPI6cjUry0IKknD4esjgcfyKEfI0/FqVLTdN8
         Yjmv2O7gxTsaxQHYTHAmukZ4m96VPx4szRA0o1p/5T7aXUlwrJWyzVKLtLsuUfRl0Hmg
         UJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=miwU/ecb6g7PnqI2pTJ+Cbe7pB50VxWGMEGUDTC3cfc=;
        fh=WpHJDPPj9gDJrNWdFdq9V+QyjTt6Np/x9sME9L+d7Vg=;
        b=BFrzjRffZVVQwR4hrNTKYdSj6N99RwrUmbcqmhf60SHlRHKH3HonpiaOxNJG9gsY85
         1znkiAvhI+OqHq4Tg2Ig2WkkH5b5M/1adIzXKJp6chHMrI2CKCzjMdOoPkxwAz4t5iTx
         5UDIscP7iHxQh41dfV7yoiDhk7CCaBdfr3XGV3kwLF4w0uiBXPFSZoHgXnBRZJbE2v4V
         W+Rfge6PaazMg5731zcevD8GvOJuBdqkaW1QqQY7ZMWjUxrjzyWY8cAb2HkxHmKomiqq
         Wxzm0BpvTedVcsHEqNz+k1lN7fc87aXPWzs4owaoLFMt+0XYSRi2hAtPEFnyhmCqMaZK
         SkTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777946541; x=1778551341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miwU/ecb6g7PnqI2pTJ+Cbe7pB50VxWGMEGUDTC3cfc=;
        b=YTbCd1hY7l9lEBVl0w/wv2iueY9Opq9b60f7gr2EYiXALDYdLGnZJNSYxDZ0gUoU59
         FMCsZV0oEDLmwq8QmKiq6ZrYbHSIkov7begKRKjolVzKn/Oil7irs72AOeksYKDtp9VR
         YuwulX7d9aXBeLa+Wc/5nCX0JrLstVSyHXMorJS/6TpVxwRBKCiGLdXgduORSKD9peKm
         IxtN9zOWg76wwIk5EqHMeQFD0waWhunj5eTWSRCXG+bSqvwfShcV64kApLLJJR1Unj21
         TykSnnpDFKZJpGpvz1+BdXWgiSGPTOXMjAGTmUNnuwpzVvMVYF7GmH0vfMgNX15+ItD/
         23Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777946541; x=1778551341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miwU/ecb6g7PnqI2pTJ+Cbe7pB50VxWGMEGUDTC3cfc=;
        b=dYy2Be8MnzdsC5is/g9CPpw4Pim1QHX5OpTMngOG+hYDttVp9zpL5R33i3SJWAa2+l
         obCKx+zYnXaHBKZriNoNVR0+pWCyJk6PMo+L4HxgXTGKNju82ILku5XVU7zVKzQK6npy
         AN6/kQ1qbBG82CEDErUgRAJX1C35IbI5CNNDz5zI1AtSsBbYCUAelSuvRPaEBq1y8r04
         J5ZUkA0oOi11OMCvxRY1zDFalcFfvnutgHlWh7+Mh3fJo/MM8NPgq74iSBFOBhwt8AMj
         RU0p9MuS/NUjVG3OXDosovizTjRrmBDmWP/JMnmFxK+VOrGRIdTwHiKoosdHaC4NozrR
         4WbA==
X-Forwarded-Encrypted: i=1; AFNElJ8Y6ismij1Y1FElUmlcMxcIa1GhPEUrKqqcEqg664EPfr3kgBEc9HHPMcz3ZT1m1jejwJ/y9kJ4FmisOxiIQ4u7PdUZgxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDdrzdsS2QjHiIbwk1nBf2mEqxhDMZQvMUzbhAZmhRv4Z6gkDI
	K2btZAuT7xASVRozislorpctOFaEPzgcVOOrE5EGer0grILg7LNywqyn1yBBBH25RFxPyehWglQ
	SIVCGyHmt9vpeebb67iObEldYfh6ke71Y86PIhT0b
X-Gm-Gg: AeBDiet1y7Vwm4IWDa4gMDMS47khH12Bn8qf9Sp3962JWt5TJKSP3DSeprx7KAlt8WR
	iI80C2qiBnhj2ObLKLPyfQQleIZ3vZDX766HQHJZuTtZTsip+xVp3CxxvKHu2qpme2IVzUuoVfL
	c4r88F5P35d1ZNKrD72SdQV6EV4Za/Gyejw8s4X8CedzkKwWbhenIeiA/jaOec1ezpj637ehMyZ
	fDUl+Wi1eHIp0Kb8lodMVW/i8q5qiIbnGoMqVYuM6Lo4j1LRpanyiCTg8miblATsG8lXa6nr799
	4/BZtA+o37+DV/aOYA==
X-Received: by 2002:a05:6a00:9512:b0:82c:e692:1f91 with SMTP id
 d2e1a72fcca58-8352d281ba7mr11640208b3a.39.1777946541290; Mon, 04 May 2026
 19:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
 <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com> <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
In-Reply-To: <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 22:02:09 -0400
X-Gm-Features: AVHnY4JNEAGbbhruN9w4Ua7naDL1XKHAY7HZ8pKFMVGcMz5B9Ok6DLP24wok8oc
Message-ID: <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> [...]
> > > > Perhaps I'm simply not seeing it, but is there a check to ensure th=
at
> > > > there is only one BPF LSM calling into security_inode_init_security=
()
> > > > at any given time?  With the BPF LSM only reserving a single xattr
> > > > slot, multiple loaded BPF LSM programs providing
> > > > security_inode_init_security() callbacks will be a problem.
> > >
> > > I don't think there is such a check. Also, a single BPF LSM function
> > > may call the kfunc multiple times, which is also problematic.
> > >
> > > I think we will need to make the default bigger, and also introduce
> > > some realloc mechanism for the worst case scenario. This should
> > > work, but the code might be a bit messy.
> >
> > Thanks for the clarification, that is what I was afraid of when
> > looking at the code, but I was hoping I was just missing it.
> >
> > Increasing the default is an option, but I don't think we want to
> > support a dynamic reallocation scheme for the xattr slots, that will
> > likely get extremely messy with synchronization between the LSM
> > framework and BPF LSM hook registrations as well as special code to
> > handle inodes with lifetimes that are disjoint from the BPF LSM
> > programs ... I suppose there may be a way to do it, but it will surely
> > be ugly and come at a cost.
>
> BPF trampoline already handles all the synchronizations, such as
> add hook, remove hook, etc. properly. So this is not that hard.

How do you plan to handle the issue of disjoint lifetimes?

> All we really need is to allocate a new array, copy pointers, and free
> the old array. And we only really need this in the worst case
> scenarios.

Oh, is that all? :D

Keep in mind that the code must also handle arbitrary ordering of
LSMs; in other words, you must handle a BPF LSM that isn't at the end
of the LSM order.  While a BPF LSM at the end of the LSM list is the
most common, and recommended ordering for the vast majority of users,
we've been working to make the ordering as generalized as possible.

--
paul-moore.com
