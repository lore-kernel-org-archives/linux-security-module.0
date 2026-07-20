Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572E43C1F24
	for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580109; cv=pass; b=TK9TRJ87yf7QGRKmF7Ick3ZIx9F6LjMPyJRJv8QDUl6vdVmERWci+28Z+YI5Tc0zx3hoYiI0F2JCmKGJcD5HVNBAF5oQRCONkCo0timHrlwKF0wjyr8foHr/0hgraDmeBcNVrp8/SlLKt9cSdA5K87QWKAiuZ9RduMw5Al5W+rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580109; c=relaxed/simple;
	bh=+FnGzrkieywgVg11x7JlrzQVOV+0MSbS/7UrH/f2buE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NddAmrL9ce64SR/QnFEnZdzueArtVyYXrDfDftULwyeMEIqbjdVKhNdokURH3YN/lZuaEQKwQaCPdKDj9oldP9suzSWyUADZtvUQUKQRVj1D/BJ/KQN/PYhTuxwfRhBALnMmXP+dFxlbeEIIWA7ZekS3M5f6R02NK81w4XzD1xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=acU5kcyz; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="acU5kcyz"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38175907a56so3202635a91.0
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 13:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784580107; cv=none;
        d=google.com; s=arc-20260327;
        b=X/EaN8PPMRs0jYemo2PoGIDliRsSKdDHkt8i5EIWzkCsZ/cKTFmJoLeZQOKpoWwHlF
         4qZYdQo3TBfqsVA3MJxF8lQU3vP981y2C54ls9jx6pieBWTHPsKVzdXuTuSLMJweO/KS
         q1KZUoJpmhDQcSMtI8lirh1SAatodmKtM8b03B629nMoBr7KJo/qbWM3g6uoxmO5a33d
         sraYDb93BHrPeXlQSWpP16AA+FJaJRyxLfEjtlqCSWgqYkMpaUWzzlIMXpM4gLbb1EY5
         8MDh8RMZMxH+uAs6XPa91H45tGPmsu3G0GAgfEAPUqNMZuvb28QgyMxv5nQdn/cu62Pk
         Fa1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A9BFAH7wtR+2i0gcTzfUj/Ayf/0UVSPIiKXXXL362qU=;
        fh=1N+89Yuev42BX4hANk2K8z2aTqYieSBCkilYiyubiH0=;
        b=BvfmlutoYfmLlVN9VeKiqi/QyWdh3no0L1CS3E160Nc6+P93kwobAdgGvKlKgllZDh
         YYlEMwQbzZL2UyFuwIwP8Oqq8remRNx0W2u+AzEKtSg/9rk6nu4tpRXA+qeV9ePPoLVz
         xPJ5muUHWvg5aDTo6bqowrvW/qN6l9O0SWmAIvYgqytNbdFKyzYmycc5rE21Q6k64KKT
         kI+Cn+7gYJvYSbfaKmmPSZQ+mjbasIwvnA6z/QmR9rwq4DxtjxZe531KjXtvcpSUyizm
         vkVclsrtqZl7temmPS4D8I5/99A3DMK6J/5vfx9X8LjCSJcJ/8jRdw+5Li9exF4yAvnH
         Ghgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784580107; x=1785184907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A9BFAH7wtR+2i0gcTzfUj/Ayf/0UVSPIiKXXXL362qU=;
        b=acU5kcyz461RfGj31K+aMa61941kdHnQBbJ6e+23LJp4LwniIds9WYheH6RX4YeoNR
         7M52t4Ca736IkAbT2nYVebEA/eSSOwjaJECJ35omKzxXNoN0ZOQnqhKGz6LCYloqdDGH
         fGAodT8jcRTm6eVGA3+33QYCO47NNbbUaOtT/NrH2dRm0GLTh12p0sDRP28QvWm/B7ui
         U7ItQAxCvfMVlZ2CKXqWBQ1guXfAn9gKhFhgkrLpkTCLOcAsuRsCsaYkrB2uRhOtiSU+
         NXyQdOQhNBCOCVmzMfHof6ypHtgwwI6D64fu46mfBjdqG8hg7AixokpvzVQvF3qzwXNY
         ebYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784580107; x=1785184907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A9BFAH7wtR+2i0gcTzfUj/Ayf/0UVSPIiKXXXL362qU=;
        b=AW9GuUGelBWGW1Gyldu7Y914aZDJ8VIu362Xfe22puD49S1slwQmd/s7CiUhnpc71v
         QLt/g/qO/BYe4sMbCB7m05hPMdvGnyCokwuwzGXrKnuqBb0w7kkkm9fLbL+3UrxF0xGx
         XfbA5AV+3ExLvVaUeyyVF0zCnkq0jV2Rgm+xwNG59nACiQ4cnFfUeHCxf4RG96NqXpFq
         k77IvtETUmzbw6GkfBiX/FrVUXbFCLCTZNjO4xAHTYZBVZcaFr5Mcv+eii3Sl1XOLvI9
         y2AaN8yNr+Ba/4CpUWgAWZqa88iCltZ3Uz88N3ZHaXAizly3OtgsF1lNJfBohYQq1a+I
         nplw==
X-Forwarded-Encrypted: i=1; AHgh+RpWIZvMDlPAzJDkwPlTACLCcY68RuLsyq/fRlHnLoj5PZhnvF89BXKme59KDaNmOVoCpPdtujWQqOGlVOIH5Cu0cMHJ3mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySc8l38vDszSgpkf0pHcV+ED5Ns6Bd1wMXEuFoiZkUKK246kfr
	GPUYzVOcVRDXxAppSvmA4vTEpBisph/p10znJWgchtw67BQliy3jDCPXUE90pmFDUlCoAZtUlCY
	YCKNMkewSbAk/kLp5suPi7lfPGb+KaEliiQItfeCo
X-Gm-Gg: AfdE7cnjkpIDKKSvRi17CUdQsU0K+eXp44kh3S+NHpNBWoqeuH6QJEmXI1W5mnG+2fk
	W0cKup3O99MxBTGI/QIfTycmHkV+2SUY9y60SrC5tnM4mta8qIzQHnMXqydmP2z98/5PTTQGOb0
	BP+TvyKMf6XGDKnfUdYrNAAhjnbp4tK5sPCMzstFLEfXUaW33Nxx/+bo10DTEFfEhvZy8rPnAib
	UhsjnDHQKHan1bBNTzJL8FdTnGelsDSjkqBFS4agY+oIxqf4vzBGFXdW/w7/Q==
X-Received: by 2002:a05:6a20:9183:b0:3c0:9acb:3fc with SMTP id
 adf61e73a8af0-3c3ad121d58mr15942725637.33.1784580106787; Mon, 20 Jul 2026
 13:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-2-dwindsor@gmail.com> <cb9f84292a7f1d41ff8388d8c0c8c3d0@paul-moore.com>
 <CAEXv5_i_iHmF8n6Qf1NiVOhm2cCnVLgmwXK-b8M+hvmdO3aQdA@mail.gmail.com>
In-Reply-To: <CAEXv5_i_iHmF8n6Qf1NiVOhm2cCnVLgmwXK-b8M+hvmdO3aQdA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Jul 2026 16:41:35 -0400
X-Gm-Features: AUfX_mxGGJZotoA_L59yykgtbAa9gAB3rgxUm27TjBp9LjxVqLCLOtt3LkUBu9U
Message-ID: <CAHC9VhQFGQmJ829kAZ7U48kQOyPT-+zixb61VuK3Zn-myV6+vA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] security: rework inode_init_security xattr handling
To: David Windsor <dwindsor@gmail.com>
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

On Mon, Jul 20, 2026 at 2:06=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >

...

> > > +int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
> > > +                       const char *name, const void *value,
> > > +                       size_t value_len)
> > > +{
> > > +     struct xattr *xattr;
> > > +     void *xattr_value;
> > > +     size_t name_len;
> > > +
> > > +     if (!xattrs || !xattrs->xattrs || !name || !value)
> > > +             return -EINVAL;
> >
> > Sashiko raised a good point about xattrs->xattrs being NULL not
> > necessarily being a good reason for -EINVAL.  If xattrs is NULL, yes,
> > something has gone wrong and -EINVAL seems reasonable, but the
> > xattr->xattrs NULL case does seem like it should simply return early
> > with a value of 0 (see SELinux's handling of this case as an example).
>
> The problem is, SELinux has already set the sid by before calling
> lsm_get_xattr_slot, so we do indeed get an in-core label for the inode
> before returning early here. Returning early here from BPF would not
> mean the same thing: there is no label anywhere, in memory or on disk.

It's important to remember that you are not always guaranteed to have
an lsm_xattrs buffer, for some filesystems that is going to be normal
and expected.  In these instances the 'xattrs->xattrs' value is going
to be NULL and each LSM that provides a security_inode_init_security()
LSM callback needs to handle that condition gracefully.

As you already know, the SELinux approach to this is to set the
in-memory inode label, but refrain from setting a presistent label
(these filesystems are typically either transient or don't have a
mechanism to allow for persistent label storage).  Each BPF program
will need to decide how they want to handle this in their
security_inode_init_security() callback, but in the
security_lsmxattr_add() code where the only purpose is to populate the
lsm_xattrs strcut with the persistent BPF label/xattr, there is
nothing that can be done, it should simply return early without error.

--=20
paul-moore.com
