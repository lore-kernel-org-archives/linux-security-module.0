Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E912ECEAC
	for <linux-security-module@vger.kernel.org>; Mon,  8 Sep 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371893; cv=none; b=mGHCjmiVI2s7QjUifsvSPuHKV6SjyQ6DkjP3bp2TEvJOVUwFY3OJQLOmoP6DmYWyZOcLMOrSfLKGOq/e7eJuPZucFjVubJBoTyCcCw+juO00uUaE4A1bAyP6Uo6khWklOtrEtsgssjL9Z6bD84dqtPjQPPRahuyxJLYrUq7HP70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371893; c=relaxed/simple;
	bh=B7r/MdVFkxF8UOpjUQVzgKnL7FVHjfWobr88oKr636Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rN30VHFG/nVtkH5rY15/LTj/A9WDTq/XJSNosnvcxEoq3623En0nZmc8eSFtfFuvM0Sz79st7ezmQyoVg6OfX55wSQ1WBMTED0+iQ2n1lJ1vM0Sz6OjOjIxy5GcSr5fK7bNXs+X8RDOlOLVo8/i3OJpRA4F0DT8hPq1yMjKjtkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gYGjV2L7; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYGjV2L7"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5607a16639aso15897e87.1
        for <linux-security-module@vger.kernel.org>; Mon, 08 Sep 2025 15:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757371889; x=1757976689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7r/MdVFkxF8UOpjUQVzgKnL7FVHjfWobr88oKr636Q=;
        b=gYGjV2L7/MkOedYGu9TUdyLQ5CgBHp9YrCv6Gh70xrEJOxOFNVH+Bj5+9jKHlejWKy
         0WpnYL4CDkSwBujtEtqgMFTSFtKHwGjTr1fGr+ob53RrOWGxU3C72+fhMrZF7fwiroT0
         vlLlRZrum2/s6aoQpS1JbHClXZoEfwQiNMU+fKMfi+LA6BCkSSj59nGwpeNIRhbPwXXe
         OcYArqmiQcwJ/tS52EqDJE9BiTWORo880ovUGWtZX73pHMvAt6AFQAQ7Ry4N6yjRAOxt
         LxvQIMut1t9+ee9Zup03rNnL9zitqZgtu7EkNLatFTZj9brrh+ycHsurzJ4QGy1Y3mp1
         KGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371889; x=1757976689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7r/MdVFkxF8UOpjUQVzgKnL7FVHjfWobr88oKr636Q=;
        b=rU7EcvwxoYn4r0N19+1q4GcRorBxXFNZY26XvVRbaoJSIReor1XqJ0QTvzjBi26+u6
         u2lCI+gaQ0Z3JphJdrPxtJEInIIGd48T/ZQhtwP8NNI8NvpHkFlxu+o9wvusdlno41ie
         HnuFuVSpJN1BM5g4GgUGXp8wP5FAJEpuwabFFLWm7lyjtIJrg8AnSFFvSFxY8evZYnrj
         HY+HQtpfHz/X0QccHZgAWvWFpNwcIzpZs8nQb5LlCpkJgU2dtloe1p713TcHpc6yU2Cj
         sY8g4qNGkBUuFLtAcRFOpVuyngRRHAO6M0IsJOwuTB91yz65rDL4e1FqYl4bojokeliK
         63Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVlZR3E4iMn1hfcgZIzfhYp2GaqNkoFfAzG/wT21hQqq0DJtzLsTSWSWyETHz+E1yiaxYp9RIedE8r+t8dIbv+KMT/mUho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR9U6RkjlqC9Pjf0SwculezDuI2LKMFKAu8h0LQtlYvE4649wY
	GL4MED3HxAvH1l5QA1Vxa47DfqGDJaY3Sp23wgFRBuoQR9WTV0Jxt7lZSP6Hla3WyDj8K2147Zg
	yebCEMRvkPi8Sger6k9wMZc0vYXRMz+xm1kAGHB7k
X-Gm-Gg: ASbGnct0yPINaiUYN8jEsrr2Vsqf1sm/XzSGCqyi5O/IHu7AOuWpRSgQ8t0wviC1tLL
	nyedZDmCVjfYfE1M830CEsQgvO98nTvr7EAzc1G9JryrIMcnyaSXRxIbAoOMMCa7SfWvyCitveG
	tAWMJLxi9cvORfKcvobUwCUumbNHeNaddeupYShmKJ1Q3OmAqP8WwzI0aK0P9y6Na00isfbX5h2
	2ZLTm0IT4lH1fmfeXRR1F7lpXWJ/fnn2JyuS32jhXesew==
X-Google-Smtp-Source: AGHT+IHGlPCHT+44DAvJB9zRm+3LM/HXySp5XwuN4EFQvOUkmZCnoZLTNZDiAYuGffXb4da9PPxUbTsQPmLHNTo18Sg=
X-Received: by 2002:ac2:5b92:0:b0:55f:6c68:400c with SMTP id
 2adb3069b0e04-56272295585mr463209e87.7.1757371889119; Mon, 08 Sep 2025
 15:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908013419.4186627-1-tweek@google.com> <CAEjxPJ6QfUZijh3PEpHs_Yw6Hmte92-rg8gkvMw9cD=JxA+CMA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6QfUZijh3PEpHs_Yw6Hmte92-rg8gkvMw9cD=JxA+CMA@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 9 Sep 2025 08:51:12 +1000
X-Gm-Features: Ac12FXzaXfPJRpw8SIYa0ofw9A3koHJPN82BozBv8c8kOd4rvQR4t_4Herx7EQg
Message-ID: <CA+zpnLdbLjuGrk-178coxAH1pzpEA1jRzGn8zU9DHZ1rQspP4A@mail.gmail.com>
Subject: Re: [PATCH v2] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Isaac Manjarres <isaacmanjarres@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Sep 7, 2025 at 9:34=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
> >
> > Prior to this change, no security hooks were called at the creation of =
a
> > memfd file. It means that, for SELinux as an example, it will receive
> > the default type of the filesystem that backs the in-memory inode. In
> > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> > be hugetlbfs. Both can be considered implementation details of memfd.
> >
> > It also means that it is not possible to differentiate between a file
> > coming from memfd_create and a file coming from a standard tmpfs mount
> > point.
> >
> > Additionally, no permission is validated at creation, which differs fro=
m
> > the similar memfd_secret syscall.
> >
> > Call security_inode_init_security_anon during creation. This ensures
> > that the file is setup similarly to other anonymous inodes. On SELinux,
> > it means that the file will receive the security context of its task.
> >
> > The ability to limit fexecve on memfd has been of interest to avoid
> > potential pitfalls where /proc/self/exe or similar would be executed
> > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> > similarly to the file class. These access vectors may not make sense fo=
r
> > the existing "anon_inode" class. Therefore, define and assign a new
> > class "memfd_file" to support such access vectors.
> >
> > Guard these changes behind a new policy capability named "memfd_class".
> >
> > [1] https://crbug.com/1305267
> > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.c=
om/
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> When you revise a patch, you aren't supposed to retain other's tags
> since they haven't technically reviewed, agreed to, or tested the
> revised change.
> That said, I have now done so and thus these tags can remain!
>

I'm sorry for that. Thanks for the clarification, I wasn't sure what
the process was. And thanks for the review!
