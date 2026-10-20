Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505157;
	b=s7UqSsbZBWLreemnK2EZiQZUU+iGTn1lwpwGzglV/hDiGrdARu2QAsZd4lquI5DQmHMI
	 a9puNGeRisz3v5v0E58zEq2vFriCjwvP2RXfgCWA41osj9QStni5Z8zAAYDvATR3Jczve
	 jHUiKvG15zldG67RcbdbVVeQlL6S++Z3frVU8DyKbhfqwoGAxFY4QOiPY7cJnQKjxo95x
	 7py9tILZTxglikurUedaK5eIfeUK2865gMImp1HhVrrXLOG6aDCjwmRID/6BIa0YkfNLX
	 +NBVZMo1ZrjlsB6/8mhruIMfnD10V4BixTutVc8bQaUikSkV1zrHtE9Aat5RhxzeBog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=LdMIhIlvZTbrlYO+3j4hIx5IHxpdtNc/p0dXdNrCqlg=;
	b=pRdYo09DYhU0h/bJMgteVCypkR9BI34xVcEIPrVN4v10H+k34YlFk1EgiF9z4etuYaVN
	 qaRKiaW3jpteQICFQO2U7KcUwWwTalGAHbcfAaiLs7fWphIAts4r/M5i7vXYtQJpTNwjr
	 PvHmD3O2WVQIBz7xK9be92c98cVDb0mGSviM4rK4IfUrRpTXH5T6C3QThqw1Fx0EVbPJY
	 z9zTLfU/Yz3xqyhCOF4vsP7vth+wR0K3lZ7mC6LJ4EHdDHUuqrYzRB8j755g5h7uzqyJN
	 X4Y4dNeLfl6DgHE0lQbxY/ZfO06EWKvtOlIvDPc2Dgx93Vttbc0T4MdauDa1GQyDhHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NU6pBVdp;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF060A2639
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 14:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30CF060A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NU6pBVdp
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-675676afc3cso3270655d50.3
        for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792505156; x=1793109956; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LdMIhIlvZTbrlYO+3j4hIx5IHxpdtNc/p0dXdNrCqlg=;
        b=NU6pBVdpXdS4zzTYissdBw/MDiiN5o5TlNwj//ZWFnIayDvxx9gDu9+hdW70Te0AMR
         lJOPDNX3EmmlHKf5SjsRkfUSpS3+vwRua3DVosyQsGKHGKo8S+9RGOYoBbLl8ZOPexOA
         xzzglLS59r9xTw+UX43wdSNz+zCsYBznrlPO1wxAJjJ4ycSSJkzbxvTL8dKWPvUT1ygb
         zxmJFdEkKjhoPc+3QVIuFZWAzX+hKcUJT4cDBEGwXNO0XgunVCxvpiHtJFEnynNZm9WC
         9StBMW9IYTJjpXxeP7pcleHsubJyMN/oKAkLJ5fmcxcdypeboIphMuGXqduwxNwTdvi8
         u7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505156; x=1793109956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LdMIhIlvZTbrlYO+3j4hIx5IHxpdtNc/p0dXdNrCqlg=;
        b=LIv6M+sU/vq+m780al0STeJMjETpSTrrGxtWBuKVZMme2aPPtFMvMA2iatm1qgItrY
         G2k0+l32+m+o6FLGNk7zhyNFkWQOEqI0Dj2Sxk7lBbEl90XPnsEf/RM+ZYH8gmgvVfFY
         NPxg9sd52t9i/n4VzrgyCyVKoTGqOFqSonosASxgz1SiehcVN8cU6Mf3lBhxXQfV9iCl
         ecrS0boM668mvpjQZUjbq03nIzYnG+2EOWCOI9MLJY9RIAZHRed5KvpdrE66DiEmb4gX
         OOwdBTkCqmrHQFhQJnGklOIoiF8ZxavB2+cLnTMFElptFV+Yk3t7PEB/0KGDqctHbgBI
         9MCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZTU8dTyttN1VXQK+HJK9e8+WnttUXY/e/b7XRLv/kHJuOzi5bovjRBOcvrmbj9pfoK4XDO5jX3LLh38QRSKgpQTkDzbo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL85aMqwlHS7z2HAvShQEgsAofdbzvDCnEB2Eh47XMEtLhc7uz3
	hflAtSq3Fs7667CoXETlf+1DUMGVwenOBymgeIMhKlF+a5dq6e4bHrBj
X-Gm-Gg: AYBFou3ax43W1evKLCjW3T36EYbMT0+tNvJHUDy7u7/K088eXaQwTS08xYALm9HNkYy
	L48i8Zz4Zt9rFJOb4fZNUmYJhrfNkINryFd2+k1kbEIvIyectyoTb32X0GnOl8TPwnWuDcwFvro
	LM7knxMB/JsQTJraWAwAbDFkh2oMDYz71lFq+IVil4oa6aazE+GKm/EN4dbPHjwgK4WoPsqA47N
	hJMRFgktn474Bnk5Tu+MGP+UpO/eIRd+Kuiamq6H/L8XRWR0hKKBLI1KxDis8EGCZiP0EW0exmL
	JyU2i/9QkaUFLJ/bG/lDFTw92Q3fdaZH/tmnbr1B969VrMgoOzmqpUCjPrFwEPe0WidBumdmnyS
	by3JZFVpn5mmgydf4l8Zdk9pW9uVcBtS2Sik4QSSe8WUabUrSbwpgyvNbIpocRNYTASxAVSxZSk
	UbuB08yULWx+F5VKsQXQWhS0FZQlUqA9PCUnLj+/cZmoFQUD10H6d1XDJKjsmY91TNZjn2s3A=
X-Received: by 2002:a05:690e:1443:b0:679:aeed:8900 with SMTP id 956f58d0204a3-679ca7343eamr4757054d50.22.1792505156161;
        Tue, 20 Oct 2026 07:05:56 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8701:205:573e:17eb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1c94c25sm5269200d50.3.2026.10.20.07.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:05:55 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:05:54 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH bpf-next v1 00/11] fs: unified VFS ancestor walk for
 Landlock and BPF
Message-ID: <atdw4wVVarvwgRH0@zenbox>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <DM6PICFFAU5Z.14KOZT5YJO7MA@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PICFFAU5Z.14KOZT5YJO7MA@gmail.com>

On Sat, Oct 17, 2026 at 01:02:40AM +0000, Alexei Starovoitov wrote:
> On Tue, Oct 13, 2026 at 12:47 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > The structure is unchanged from the RFC [2]: a stepwise engine private
> > to namei.c, a callback front-end for in-kernel callers (Landlock
> > is converted, fixing the follow_up() race Al reported, hence the
> > Fixes: tag on patch 3), and open-coded BPF iterators over the engine in
> > referenced and rcu flavors, with bpf_path_ancestors_legitimize()
> > escalating from the latter to the former mid-walk.  Patch 1 is carried
> > from Song's series.  See the RFC cover for the full background and API
> > listing.
> 
> Song's series stopped at
> "It is a conceptual dead-end to expose these two modes via separate APIs
> and leak this implementation detail into non-core code. It will not
> happen as far as I'm concerned."
> VFS_WALK_RCU, -ECHILD to the caller, two bpf iterators and the
> legitimize kfunc are that leak.
Following up on this, plan is I'll submit v2 of the verifier fixes
series and get that finished first.

Then after that I'll do a redesign around a single iterator
implementation that decides the walk type and abstracts away the details.
It will be KF_RCU_PROTECTED and callers will need to break out of the
loop to do sleepable work. They'll be able to acquire the path
references with a kfunc to take them out of the loop.

That drops the __uninit iterator changes and the legitimize kfunc as
well.

> Landlock still passes flags == 0, so nothing in the kernel walks in
> rcu mode.
Mickaël would you be interested in the hybrid walk conversion as part
of this series? Or prefer sleepable walk be retained for now and
converted later?

Justin
> Patches 1-3 fix a real race and don't need bpf.
> Send them to Christian, Al and Mickael on their own.
> 
> > Verifier fixes propagating the RCU-ness to trusted fields can be done,
> > but it's best as a separate series where the idea can be examined more
> > closely.  Then marking the dentry as trusted will allow you to use the
> > dentry xattr kfuncs.  Nothing in this series strictly depends on having
> > a trusted dentry, nor will marking it trusted require changes in this
> > API.  See my follow up [4].
> 
> Then what can a prog do with a position?
> pos->dentry is untrusted now.
> Marking it trusted will require changes.
> d = pos->dentry is not linked to pos. It will stay trusted after
> bpf_path_put(pos).
> pos of the rcu iterator points into bpf stack.
> MEM_RCU propagation fixes neither.
> What next() should return depends on how the verifier tracks it.
> Let's do the verifier part first.
> 
> pw-bot: cr
