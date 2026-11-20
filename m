Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795214289;
	b=u97K5BrO1EySx1RVMGgzum3LqpSfWQPj5bCDHXgPQk8xTC5FcGLtWuGLor++Q6WFbNYi
	 1SSOr08b9wucV/cWLFmNY4UguygRvFA0usGw8JN4isZRhTBFeEPjxpsK76G+7A868EwGA
	 SyUvkrT/2rLwOkWCHUbmttjvYqn8xNMyHwovSuIj8Ke+6rVTQBkTcziWY/gR27/nrNHE1
	 bsFQXB8AtjvFJSqbIOF4/4CmcHqrPPnO3FgoixFnaqLbHibywpintP86VvuUWvNhN2kwh
	 FpOFJ8ddrdYbra4WLvC2XwvXCfkTwpq9QRjd/3OYhNU1lbEeI9c21AwY5yJ12yxPMkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vt5ZGvfMRc1ZCLFXNMdzQcTFlp9fnIFCArIgKZ1EHbg=;
	b=zuIwB3QPCW+MWVQEgwBBF1kLR48jepceexonaYjKK/Oc8pVHGtYCyen+Id2+08YdWdMI
	 1SizC957mv3JPa0BJ67D2oXbTcdrUT7hWfgDx627uXA0LjmldwmyAAtA4RaeDKMcgXxHQ
	 YbwwLq+BldlvUfRsPgLVMP+74Swzco/ijp+bFftmM3p8R1opi4ZbIsXnT7E/zcwlwpi1J
	 Ygiw93Yhva+3iof0+IYqFahTjd2fakseLWv7HqAjbH0NdaHpbteaZKEijKPnl5l0Rkjxm
	 DWHQLNs/dVm1XXf/NmI4coy/y5pYZf/3YrCsoKbSMfq9rVE/ULfHKYP7xByZq0TUFHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=UU0LUqxH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C93606A68F
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 22:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03C93606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=UU0LUqxH
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cde1479f76fso942734a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 14:38:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795214283; cv=none;
        d=google.com; s=arc-20260327;
        b=QgxbdY2K/fzLuFEYeX44iK41q06qBk+dPBjPX2Duqrbnf+gEheyt2K65Y0Ik/cwv/O
         EvsD/BCMF2xKY+fcxVlMr7ECdr9vzdHodSNIisGNif6RiCdC9SX3JzudEZzCp9dhEhSo
         7OecYbNQsfSHCZoWXIYKjuKGkioNIw2X0mqBY+ZZg/I6JhhdjA9V6zstI1AX3tbFIKTE
         enWhfLa3pQb0aoKPFzOKBnKQagokJDJysmdE3x0RmSWPLmflw9N20bqiOwZ2PIO/2Sep
         Pqo3AslCzgKEV4GrTHKn9YpgCtjsTVOK7BxPn4HpwqXjegx7ZdvWaqrQNWkR0xvEEUGd
         BSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vt5ZGvfMRc1ZCLFXNMdzQcTFlp9fnIFCArIgKZ1EHbg=;
        fh=I3rGR8LTt45J4/gaAkf4hdVKZ+OXDzQEx2qxOJTAfQM=;
        b=qy1oKpJnRQLAg3+pZ639k6KMpJH2XIZgxh1GDUt/yFgcQlhmORHX3ReOlyuBc+vVEK
         hdD9nvLXBW7c+JJwMLiPXZVY7Csz9REJlaJ90BGsMtZu43nzxLhy5+vZS/YOqzOOf4WM
         uGmlCEg2MIs0Iw2DocZ0YpBrf7/fPiZmHK9JknPXzjICEhDsXH1pfoXn0d5NN7BlzQPA
         ipB9pUe2iF7QBj4nVEC4RmxfW5ivvhf8PZqmU+4cHxeW5MVzC+ZyvhFVBH8rfJwZh3mM
         WQo0DEJWmYf57x2xWiPA4TsphDvnccb48VrmJXvo43WGv4D6NwDSDp183wK4rQUQwZH9
         VC6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795214283; x=1795819083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vt5ZGvfMRc1ZCLFXNMdzQcTFlp9fnIFCArIgKZ1EHbg=;
        b=UU0LUqxHXfMjVJD/noqvHuNbSrWN0j8s3FChpwWgKZ5LWdVlRsnkfEnBO9gla0UG5t
         8RZ5MMsn6ymrvW4dheE1upSxSUXgxv6w1+Jf+xV9ZRhmEEFuWYY2h4FllaXODZQAPTvl
         Oz6vcbQ34Cytlftik01DiW7F9Sp6lmlNexxJpBmjbQJ8fH7vimFc9Frs0Zn6e8jxRLuT
         wORY3lMtxgHpXfGMXo8eFDXTdCzR+pmPgG50HkFfBZt0RqEF7QA6e5eEsoGPHaJiJqWi
         4z4F2y0YDuOi0AJEG8g0p/XyH8QDZO41xCpJgIO+1Kp/KtrZPPgolmWnvBC5n++E/PKr
         ww1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795214283; x=1795819083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vt5ZGvfMRc1ZCLFXNMdzQcTFlp9fnIFCArIgKZ1EHbg=;
        b=QVNRLTN6nSVwis7lA24iaDi8yxCHehUTzlQoMrUVl9LE7gLVf6p1t2Fab0eVySCrbe
         YYfPw2f2wDzRrk4ZZvZqzahVSTGdzJp1ug2PWG5uYPXB3Rq238sBAoNRxJB+taa2uH2Q
         pZaJtsqziAWAErH27UKEsagfZh1cSR0fLuNwLVPiWs1C/oIfZP1nDUJTbdCXLtGiU84n
         Cuobzy243iVkPsGWO4YNjjrYLOt2+rvKEtdD120X+gqKRTjQoCQvL6ESiwVodwZ3Dlnl
         8u+lNuyUjQTyQnbvxn+ZALwsZfv9cM5lmH5B25LzBrozdwcKezNUYVq1SHaMTHMCZYo+
         jWSQ==
X-Forwarded-Encrypted: i=1; AL+hErF5i6/gaBeTq1L96jtsDLYCopHx0RxoVRuVXKQUzNSWT7q3Njub9jXzSvi1cF+YzhNY+TEQRgr0oVK5Q2nSj4ujz+NvYgc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Gg3VwYFUKsMNNX7I+UcQGKbUAvZZ+N5/OlsxcWtxyZc2MbUsk
	H9xaOnTuH0+WuisQaqmVW6TFnGR1G+JmVRBls0QtmoE77AHuC1CNwUN0NIKnfrlIb85fpkcjAAk
	0E13V843YCnAtkxXRxOE62cHR6b9Ye+TF5raotdjDE3E+KdXfgzFsjg==
X-Gm-Gg: AYBFou0/05Ruw5fyXUeJqIiGG4skdcxfpwT1JZ/XMSpRhjeuTkxqyb2JxmiTPl/qclh
	iJZb6OQR20voJxUnKbBIR3rEtQlRSJJvBZG28NJFel+jHM5yNKkLaATHyU5U8eD0bgcwoep8Hap
	j8BdVGpUvuTodgXtn2IXvRaNLKEWz6m1SwwqdhAAXCU/Sdf/ptIDvarTau6xCkDIvsG+2d+MDxc
	4nzJOQQcaPebv1fwQdAwRWakYShkuEwFe04nzMPaRubDkHso8inBqyL+wx0ALE4RKkW+RavgeYW
	HVpmTaO55bQx8PXmJOkd+FkF65rECfxE1WAOc0BohfSen6OVBT92WlwDAz9lObukp6FJYLyIErh
	IGNnT2+Cu5oG+sGrFKH6RzNRgwv8fKdJXpMt/oh9LVVELxxxKn9nUXoUL1uxIT9eMIiFO
X-Received: by 2002:a05:6a21:4cc7:b0:3de:463c:7fce with SMTP id
 adf61e73a8af0-4014c25017bmr4994159637.12.1795214283378; Fri, 20 Nov 2026
 14:38:03 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114052900.7-1-bbnpreetsingh@gmail.com> <awCgjAHgzJi5Wn4+@hallyn.com>
In-Reply-To: <awCgjAHgzJi5Wn4+@hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Nov 2026 17:37:51 -0500
X-Gm-Features: AclHuK-j_JdQdrpVjapZq8oYMEFZEHkdHRQJ9XZMWAuZkPPeP92Jrma4Sd1E1oQ
Message-ID: <CAHC9VhQkAt0G9nHBeFJnuOkGg1_z9mzpUZRcy3uM+f=jmP10dw@mail.gmail.com>
Subject: Re: [PATCH v2] cred: annotate data race on non_rcu when copying a cred
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Babanpreet Singh <bbnpreetsingh@gmail.com>, Serge Hallyn <sergeh@kernel.org>, 
	Bradley Morgan <brads@mainlining.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+ee58b040032d8bed63d9@syzkaller.appspotmail.com, 
	syzbot+557fdc985d6ac3831e14@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:33=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Sat, Nov 14, 2026 at 05:29:00AM +0000, Babanpreet Singh wrote:
> > prepare_creds() copies the current cred while another task can be in
> > get_cred() on it, clearing non_rcu. KCSAN reports:
> >
> >   BUG: KCSAN: data-race in io_prep_async_work / prepare_creds
> >
> >   write to 0xffff8881046cea68 of 4 bytes by task 3646 on cpu 1:
> >    get_cred_many include/linux/cred.h:222 [inline]
> >    get_cred include/linux/cred.h:238 [inline]
> >    io_prep_async_work+0x9b/0x3c0 io_uring/io_uring.c:367
> >
> >   read to 0xffff8881046ce9c0 of 184 bytes by task 3645 on cpu 0:
> >    prepare_creds+0x71/0x550 kernel/cred.c:192
> >
> > The race is harmless. non_rcu and usage are the only fields that change
> > on a published cred, and both are reset on the new cred right after the
> > copy.
> >
> > Annotate the copy with data_race(). prepare_kernel_cred() makes the
> > same copy, so annotate it too and switch it to memcpy() to match.
> >
> > Reported-by: syzbot+ee58b040032d8bed63d9@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dee58b040032d8bed63d9
> > Reported-by: syzbot+557fdc985d6ac3831e14@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D557fdc985d6ac3831e14
> > Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>
> At the moment this seems correct.
>
> I do worry that if struct cred changes/evolves, then this solution
> may mask newly introduced regressions.  But I don't have a better
> idea.  I mean, I guess we could keep usage at front and nonrcu at
> back, and memcpy just the parts in between...  In a clearly
> named new helper function that wouldn't be so bad, e.g.
>
> static inline void cred_memcpy(new, old), and let cred_mempy do
> the offset and size calculation.

The __randomize_layout annotation will likely make that tricky.

Alternatively we could have a private dup_creds() function which would
copy over the individual non-pointer fields through direct assignment
as opposed to a memcpy(), skipping the rcu and usage fields of course.
It's in that awkward number of fields where it is somewhat practical,
but it would be fairly ugly.  I do wonder what the difference would be
from a performance / compiled-code perspective; if it is slower it is
probably a non-starter.

--=20
paul-moore.com
