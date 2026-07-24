Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCCB1A681C
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784857282; cv=pass; b=JqlzGST0e73YyoveKj8t7+ozA4OvODsmN2RvY0ALovskafau4FfvEwVMX7eCvBuP2DIFq9RyrdsyESXaPPgmP4SC/HEX/sOzDDNUnJaN4VviC8Qw7V/VmJ+9lvDnInMp9yT4SdFqH02Pr1NN3utvtoftHSs3IcA9vjNrcpfdRRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784857282; c=relaxed/simple;
	bh=VgG1L9n4qkqv88OVPiAOkH5r2fUCEJuZKIZh2co0UY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAsRiV5d6WDSkj2THdR2qfNsawxPbZGe/rvTTufoBL/de+wq8tmAe7iT3virTy8uH7aMpQBPXdZUXhMMpXPs/baUKMEkhh6V4NV8C69mdSrVmVDEf+e1Z+GLAisJPcyB3x/o9GmkQs2b1CHjjGILa5HbKDoagvrEWER1RTdAiZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkSPxvej; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkSPxvej"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f23e851626so11694286d6.3
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 18:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784857279; cv=none;
        d=google.com; s=arc-20260327;
        b=RXE8mT00PK839otSCOVmdqIgQiSpzD1RUo9kMI+2kROFWMr+THcmatncsmRhKJAJ+a
         Lg6oi7t7qR8POcz/gKoUbTH8ght1njJbzV+ZTGsjVUMxDFkof8T7tjSl69mfI8H867J3
         9+CqPvQ5l3OKU7jk7go8giGfBtkwKSPaQSi+HzNpdiT1y8HE7C1RqWENHJicmdUmNR8a
         YxNK0qiFkHZCVB7Z/717Ba9gAJZIvaU7xmnKCubQRpry2rEUBMJmlG/8bSr7xS8/2TwB
         IfEULNQnsdVCK9E1mftCYkTuR3IMjSQQjs4dOk0kHoa0AV3qRlNawk9u653Wkr32AJIR
         J2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ejkg2QiGxw6lNSk3SatrnK8cKuk/Z/iPaAUYh7RRVpk=;
        fh=R30WiSO638NsM6XmODpAL48+WNQxRSL+YuGNQhcU7fQ=;
        b=NloPSTDafrACRDcsh22V3QmDHls8xvBDZ9+tbyv5MxonrgV6osSN/DoyGq1fhYtY/A
         ewbnlyyahuhGl9oAG4WlIxzMtaYz5ylCX+YU9gp8qs+TAD2lW881pSvy+qiE/fHvkjsX
         2KF3ZNgyM9i0ADpVrZC6ajyQhtpARq47mo3Az7teOOokzmyo77l50tOC86DiO7t5+2Cq
         OxTXLu/ca9heYGsFnBtPS85ZAJUAG4yCRviadddERXs0i8LTOj6lEyP00sN6m50PkMFn
         ELSQN9njr9IQ9ScWTLJDOm4nvNNdlqYfUz0RWpZSoEHy9j1++YEfXTNKbRsx7tTAHbPr
         MRIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784857279; x=1785462079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ejkg2QiGxw6lNSk3SatrnK8cKuk/Z/iPaAUYh7RRVpk=;
        b=TkSPxvejqbro1K/uX82Xq1lfAfEBj2NcclfYE7eKvV1W6T0XoATG91PYo2cqDjUB3F
         z04f+ulHgLIovyxQLxckGgH0lMlWPVhHWsnRyzP0tEsk//D9C4GIlrjrh32D77Ekqf2o
         AI59ZrCYFx1LeWIpT7mj61vZ4OKBqRew2DFOVzLnx0gbM+t0mJsCbpILJvFqcEUEGnwt
         0jBrUYlz6OIzH6cPETmIIKTKBEP6+c7cX0L9+aivERUcWtU9K8Xp9CngJ34qgl1q/z9j
         pRdiu6GuIRDMPkVYzWHd9C/f6XPcMGKK6MBiczQAPXYi5z3TJfSslo/4qWUyZxBPuM5V
         fU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784857279; x=1785462079;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ejkg2QiGxw6lNSk3SatrnK8cKuk/Z/iPaAUYh7RRVpk=;
        b=ORJ/P00wbW3D06rbx7ZzbxE+DiEdoRisU3tm7lP0jG09zQG1t7VSVq7GOhmKjDeoLS
         68wGZ6iBOhyctn29R7YirV1NSkwIQ1j6FX8yfDvz4psDGdI8EYcLasAVsXNypjf7P84O
         Jue4CU+XPpOxaV5aSRSn1dthZ9B7S7aPLN20XQHrX1jQorpDZi32diWydhkYhbz71tdA
         WAHBQLVkslbor/O1dn+TqN8T6rPS8GfCaMYXqnmee1RR6ySERhlv3OwmVlYrrwcO5YE7
         qB67a4kaTIjjANvoXWbtCUpqIjHz18VoQIDHkYBigc5UElBzJZ3KX6mGVfyfF5262q9Q
         Y7ig==
X-Forwarded-Encrypted: i=1; AHgh+RqwSgngUrKT3fiC4AtVzLtYsoEgzoQq0+1G21HrdzQHdxHbzjU9wNZjO7IKyGkOQuUU0BpUwe7kbwBmsGQNdoKuEa3z3ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHcswpABKdU4wDjSnKpiYNbZ1ScjDQVFS6fvwmolI299kmGO/q
	fhhOwfrjhHwjc6UnpoDD0sa2dhi787OmgDMhL3y6kd0+bIKoKpqQ8QbCDMaw7KuQx8uMUxNL5lt
	i7bZ3a7PN6+e/+EL7oxIZZz949qXvnQE=
X-Gm-Gg: AR+sD13xVhIE/pCBnx4sf8IZ+qVQ97ddPAuZmkUbc2OcZ/uF7T+CoHvqfai7tNhSrnr
	OYyGgFr6cKS6B0PLZh0DH6nyLazofMlLuL1b6a/3SswKwDRxE/Xp/xQz1xED2hs5GvSSZRur+XZ
	LOjZ7J3diLmU52kgEIyFQH2AjrFtxVW08y9eH1QIwy5JgFIff7rta/LMYSYAS2jnLC+R3po3Inw
	CEU6kPPNBNZghCPGes7KcDz+mlH2+z1KIyYI+fx75mDI2nxv93QQFZ8+leOCw12H0alyKZuP0en
	47OqFNLTWq4rFCle
X-Received: by 2002:a05:6214:338a:b0:8e0:6b2b:1a9 with SMTP id
 6a1803df08f44-907ca5f00c5mr60830756d6.38.1784857279135; Thu, 23 Jul 2026
 18:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-2-dwindsor@gmail.com> <cb9f84292a7f1d41ff8388d8c0c8c3d0@paul-moore.com>
 <CAEXv5_i_iHmF8n6Qf1NiVOhm2cCnVLgmwXK-b8M+hvmdO3aQdA@mail.gmail.com> <CAHC9VhQFGQmJ829kAZ7U48kQOyPT-+zixb61VuK3Zn-myV6+vA@mail.gmail.com>
In-Reply-To: <CAHC9VhQFGQmJ829kAZ7U48kQOyPT-+zixb61VuK3Zn-myV6+vA@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Thu, 23 Jul 2026 21:41:07 -0400
X-Gm-Features: AUfX_mwSCaLmbKkOiyonsmMoEe-BHwDr3PK1QzzhyLZjx1CuuJvM1nFkobHbazY
Message-ID: <CAEXv5_gMkKNfuxZf1uoUJ+nFAH=oyHpc3iJAVUbP3duyA8AcvQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] security: rework inode_init_security xattr handling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 4:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Jul 20, 2026 at 2:06=E2=80=AFPM David Windsor <dwindsor@gmail.com=
> wrote:
> > On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
>
> ...
>
> > > > +int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
> > > > +                       const char *name, const void *value,
> > > > +                       size_t value_len)
> > > > +{
> > > > +     struct xattr *xattr;
> > > > +     void *xattr_value;
> > > > +     size_t name_len;
> > > > +
> > > > +     if (!xattrs || !xattrs->xattrs || !name || !value)
> > > > +             return -EINVAL;
> > >
> > > Sashiko raised a good point about xattrs->xattrs being NULL not
> > > necessarily being a good reason for -EINVAL.  If xattrs is NULL, yes,
> > > something has gone wrong and -EINVAL seems reasonable, but the
> > > xattr->xattrs NULL case does seem like it should simply return early
> > > with a value of 0 (see SELinux's handling of this case as an example)=
.
> >
> > The problem is, SELinux has already set the sid by before calling
> > lsm_get_xattr_slot, so we do indeed get an in-core label for the inode
> > before returning early here. Returning early here from BPF would not
> > mean the same thing: there is no label anywhere, in memory or on disk.
>
> It's important to remember that you are not always guaranteed to have
> an lsm_xattrs buffer, for some filesystems that is going to be normal
> and expected.  In these instances the 'xattrs->xattrs' value is going
> to be NULL and each LSM that provides a security_inode_init_security()
> LSM callback needs to handle that condition gracefully.
>
> As you already know, the SELinux approach to this is to set the
> in-memory inode label, but refrain from setting a presistent label
> (these filesystems are typically either transient or don't have a
> mechanism to allow for persistent label storage).  Each BPF program
> will need to decide how they want to handle this in their
> security_inode_init_security() callback, but in the
> security_lsmxattr_add() code where the only purpose is to populate the
> lsm_xattrs strcut with the persistent BPF label/xattr, there is
> nothing that can be done, it should simply return early without error.
>

Makes sense. If BPF LSMs want to store an in-core label, they could
just use bpf_inode_storage_get.

> --
> paul-moore.com
