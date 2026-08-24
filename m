Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F73447141B
	for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593436; cv=pass; b=qWEDcDy1LAl1UW4Npqg+c5UXybg9D3Ezqn7dDPrlK9rANMIJFD3RNBljVksPVk9tWTA2IKdkgysImtini5lxleqSdUhdikNVqNOT9lCrNGUGl976YoyBsl+lUuizoPl+17Mhwe90tDtAF44p8d28Dm2lE6ILEESUUrYhHutU6Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593436; c=relaxed/simple;
	bh=NSsbOf3Y0yWkw9e5dn0dpe66TCS/Em1a5SohkF1dHrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=losrd93c9r6RShsb4RaJKrla2DBS5ZlrCRnAaQWGXhY2hXuOQO027ojswZ9r4OOkG/wnCFOYYW0bc2sZL43KvbIL9EQgadeVvIxTlrptxuvmY8snQo9CK/VNm2UcPHAZIRLCu+ZeYc82lCCfsjv11ezZZzAxqbq6Kplx36idMYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=joZGmF9X; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joZGmF9X"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d3b440b97aso11975ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 10:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787593421; cv=none;
        d=google.com; s=arc-20260327;
        b=SqXilMXv0sckTWsuD+WRQUu6VnSqNM/Ql7XPIWn4Q1TE773GGWaxa8i2a2YOGrydpR
         MYKlrrFrMo14vfMMfSRw+seDUmoyFRqEUXUXB4eVTilayzTP+MgGwjwDFSL3qSrMLTXj
         IRXvF7bR0xclazEnk1VOav6dyQhxt55rbi8dSfgR8fdybgzZ+5g5kao7db3ddOYnBvrr
         FEp2hkAznFB3tT3tfCNK9iXKgjSqz91keGvLAxja8sEbCiL9MTGDBS4EyWwqfWwh+n1w
         26SamkFuvyPv7WSryGGhtVhFr6glPC84/HoaX2jTVsmmBDFzkRMkqItsKOMMjsSQSnH3
         kyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NSsbOf3Y0yWkw9e5dn0dpe66TCS/Em1a5SohkF1dHrY=;
        fh=xYSQLYsR/KlkFr2GlxR5bzMPJoPZvXNcRPEZmQyy9f0=;
        b=k9SmqUWZJHKUFFm/IQIWPivsMyBpDGkdvggDikF2HJ61CSbsT3FQKFcCOzaisuZvdG
         c7agsuHS5misxk0iU8MooHaq9csggNfJxYVwnILVgZF2c9OjHbw3WsBJVUDmjbtJI1au
         X7t+t33yjwlbY0Qsfgt+w/JaiJ/t4Gxktms4RldfX21Y2p5m55XAZYTFjVD+Th2kxj+i
         EDf5u0f2N22jktNZ8JRuJqwwxCB5nY/7MzOhBEVBx6iSyNE1CdAzs5+eoj3LdbHnHxoy
         VHJQmNzUx0esFHbUZWJuoQWEhTMJKGwlpfArmtollTR+wbHdpzrMxBwyGKZ5h/uueUqc
         a5Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787593421; x=1788198221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NSsbOf3Y0yWkw9e5dn0dpe66TCS/Em1a5SohkF1dHrY=;
        b=joZGmF9X6QfJaxTMYXhYEZbMLmkmqBAN5EA9bvW1v2ezu+L7IG0imX76Og0W8AlQDG
         wxlHIHdWM/jAMnQR/mz1grjzyptG06p3gTwRGj0+TB7NT2N/3LbXMVI/WQ243ARLaKJ0
         0K+okMPpuESFoJEeI32SlJatbsXciGmOz4Ga37nTBlyT6sXwR14HiXbMsxP9HShtylEZ
         rdbU69YJONyM2PBRJHaKDbQRH5wgpyo3eAuN5tore3hNychk0/UvXALRWpaYVXubgS3J
         hz+zHXtTcuU646DtzWJXfpEymJji2evbjAy9J3jLfrxf8NCZV/ZwDu5mu3wmJ+BPWCac
         d/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787593421; x=1788198221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NSsbOf3Y0yWkw9e5dn0dpe66TCS/Em1a5SohkF1dHrY=;
        b=cvDzofqzOWrRDYRkOjOXOCPCnPnGzVQrRNis0S57sxAtFUskIhfr8wku4uWjjmFmZo
         hJSTSsyqdcGK6DU2NTAiD8vw+W98KapASn01V0taNK5AvMkYHnOCb8nyQv3kadM6ETC0
         84WJQdbyODEbEvxpcrIouYJIG+mdccZIZPiOislEDL7SRJ250As0ml4rhKUDa92nxONE
         E7+gBmH8+lb/cQNQ9aSDedxiImEqaQV3/+LX8xCAVZEjypIvYAFhTJxtlwF15iSA+iBl
         Uc+AndQhz0v6u4ggSjT/sxnxXN2acblQwI7wIIlmvI9YvNcNDAdXGhe2OwbMo6hJ1fgq
         +wZg==
X-Forwarded-Encrypted: i=1; AHgh+RridoW+RgIiNaIQErwnQs4UDylFKm9i/0GQSh7UTjG8Zng2r/D83St5hR5K3ZRWQ5RCdwS+ObIUxFK+TYuPD7p5BApSIrM=@vger.kernel.org
X-Gm-Message-State: AFuF++lQzyerbs5R/3CRgou25rRtqD8CRiuwtwpTGOwqHPwaKQGu5Yg9
	Ljjbel9WZ2QJHTv3S2r30yeCPr1vMAhZZSEEJytYR56fBmZnsdn8Yrm31saSc94yd8oh7rbgMd6
	jakTlw6Kfq0qQ/g5lRgXJPe5bwRUfIvunRB59fKzr
X-Gm-Gg: AR+sD11sVDhAYkgXzKEJ7UgPp7mUgELeBZv5PubxgmSHwnotEWoNXr7vBMiq1fuBscy
	vpU9kvvOQ4FXjZDoi2C7pPJV4ooKNZKTMr38vDgH0jidXDFXKrqtEq92X7RKkuI40vLCwhGeEWK
	4ymdvka5TXw3TxKMHZA4J1GwYX6NtxbzhDykME5OTw+lxjNrz1EOvzQvnfCLSAZgdDzTENO6Dij
	Ck3PsuNS8k0cN5r45jLhXqDvF0zxhthiEz1emAcK77b/A5GenjGi8x3ZCHtENMPyHYmc+3eW8K2
	iCFLqqzMWj91AE9+xNi+bIkGI71KjW3bEGPaQ30ZEOYPHqRBnGbD+uYtZpURawAtlo1g9hgBNmi
	4QbiZUwBs55Hbe7Vk8k2Sl/gF2b0X7vs=
X-Received: by 2002:a17:902:d592:b0:2ca:bf8e:360b with SMTP id
 d9443c01a7336-2d673b9e9f2mr11726905ad.9.1787593420034; Mon, 24 Aug 2026
 10:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org> <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin> <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
 <aox7tVIQBMuz-xFO@gremlin>
In-Reply-To: <aox7tVIQBMuz-xFO@gremlin>
From: Jann Horn <jannh@google.com>
Date: Mon, 24 Aug 2026 19:43:02 +0200
X-Gm-Features: AcwNN1XNlUaHE0KSmD27zjyuJQAPDoj5SG3PPI6IvJrIGr992XerqXx0rzodOY0
Message-ID: <CAG48ez2-8UjzOp=St5eTPyG_yd2iBmPF6y7qVBTNaPNJgoX=BA@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 7:33=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> On Mon, Aug 24, 2026 at 07:06:04PM +0200, Jann Horn wrote:
> > On Fri, Aug 21, 2026 at 8:52=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kern=
el.org> wrote:
> > > The sharing a /proc/mem fd seems like that's a pretty dumb thing to d=
o in
> > > general :) but I guess you have to protect against that.
> >
> > Yeah, it's a kinda weird thing to do...
>
> Yup :)) but I guess we have to account for people doing weird stuff...
>
> In this case (I do mention it in a reply elsewhere I think) it does seem
> like perhaps you should separately check for current->mm !=3D mm of (what=
 was
> originally /proc/self/mm)?

I wouldn't want to do it for this access check, since that could lead
to "confused deputy" problems.

> Or at least it seems like a crazy thing to be able to get full access to
> another process's memory (that it... gave you though).
>
> Anyway perhaps overthinking it :)

Hm, yes, though I guess that is kind of orthogonal.

For what it's worth, SELinux can prevent such things happening across
domain boundaries - it enforces that, in the SELinux ruleset, the
process calling read()/write() on an FD is granted FILE__READ /
FILE__WRITE permission to the file's inode.
