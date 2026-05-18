Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A58A330D4C
	for <linux-security-module@vger.kernel.org>; Mon, 18 May 2026 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147558; cv=pass; b=h/Hzm+Z194v0uSr1QHJYQva4nArnacWW0LRaBAamWvo9qXhZJXLr7A2SAmRnXsV13w9a0HU013Wn20lpgeixsJiVg7QIoqVVq9drpRF+LrbNT55nHHGCOaS9ko9OqtgTDfCI8G5B+uBYyRhK9ZS1vVmLxAv3gimflHWMHsC1FXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147558; c=relaxed/simple;
	bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXxUcPm61GXOOUkWA++TCKaQ7JlNVO++tdUBMRGrdAzT39HiEOZnzXEpnqF7TeaLO/evgxPryTvNPGFnBOMeVcPldawHPZxtmTlr7JznxKPWOn5rU8UNvXc1URrFeJIF6cWo/ERTMktlv2mReOQC+j5+VNrgZhjMadTd0kOmD/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CiDPL5Sm; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiDPL5Sm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48d1c670255so495e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 18 May 2026 16:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779147554; cv=none;
        d=google.com; s=arc-20240605;
        b=YfDBEAfuDx2s8NlswVvqBHCcljPCS18dnCXxDOmqOGTGHdrenCWECEoiZApcuIqwDi
         zI6cQo7zOFsfQwDuSe6VjNPRL6c8bKjacXGj0jOOrU+zl1SPi+01ACJSyjPe+JEp0aR+
         vwqJ+1VqNVeB4EAx6AmsVeObCfjatyfIFGlsP/5GNFtBg3HjYh/akbu2AI2CHBmWnoAY
         w0e0fLQfMhfgsfZ3l6SbFUL0RCBTmgXA7z+85+XJwprOiTLuR60nz8WR3sfHKbax120v
         GmgGEpHAOYcAWBSXLMTFBeX0pj75jA2LTp0qORvWakLyKPzDGYfpifEkYa52TDli1iuR
         +n7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
        fh=ZmJv6FFKLr+SQLyhy2ylPBddJ9ZCjQZbBMWTmDQUkgg=;
        b=eIAwD6blzlOpGfxmS1LMr4cpuXuB9/QOqvsZtTqZYjagcNP3XjEV5nX2iTIecd6dke
         VnQ8QWvm5IGxdiamyU5FN3zFEealZ7zwlCCB8wMnh88j2XIoqQtc+uKJOkzzq/Wn2Oqf
         cj+3SqsJVy0OZ2HexcouCRuBdnVMfInEfw/HkOe3HldGnNFVqabWyxpUZDr3fhSSh89t
         kjAmJ8/ZJ0TJTclR/3ym/cAMCNxEEuhoDtc1doxjy/+3vWNPiVAjMfhbc6/6lX/4bGbL
         GBF18/fIEPTEqPasFVy+UC+dZbKR33PwQ8CjweFXnnsxHWnq9AHbE2m5hLqargd3/7xB
         3+FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779147554; x=1779752354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
        b=CiDPL5SmLs8Uj1xMnC+3rSpDgI7bJBLrSvAsM8GnEvfRWf3qxittHUYaoPOdyetJpu
         JB1hiA3FAcsQr8Xvk0ZlvumqY8XNYng0JvUpCtVG1DJHpQ0WgF+CV/NXJVDKN7ha/D5V
         uF/JQ+iboJrsMYyPRJHfPvYpLFTN70CXOfN3gkYX/seyTVNeKgps2MHzHBHUMvKup4rv
         X2KiGwO6w1ICOGOJE1bw+P3EkOGZv4lOWAD5wTrDI6E5VU08b2Pip32Il+WWFSQTsAA/
         WVeQitXHDSigAL84gB9DW8ksILFSJgC4Tab8Ztvqn9itRVBNN8b5JkxRQA519u9z2DRL
         BNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779147554; x=1779752354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
        b=GwkOTnSslfTmpxo+qVH0Im/CfybHR9D+UDTxUabJMbKMM1Le6xsp0jDysPXl5dKxIA
         pTgM8ykkc2v0PIHPvJp16LSS/BJpVGZ/2gW9V4ljkBT80jmXqZHbSimBygNKcBcxjIJJ
         BbA+pH3ywe2yYxffqUyUGa+B1PpqEJK3Fpp8jrX+oftuyZytrjDN3CfvK6JGfWeyWyPZ
         B4bXUYRmT1L9NF0PbdaMSr1exrOnsvbpyCJVxxDwHN2bFhGn4dgHLMyOh6cz3ZO1tt9Q
         76i1okMf4npL3gqibxAnZlavvWZoBF9NNqav/64l530f/jfAaNPsWZavdZAFuogDhZkd
         Ynkw==
X-Forwarded-Encrypted: i=1; AFNElJ8lWLWkiIFEt19VEdJ5BEM2qQgQBSRSJ1xj3JhQF2Z38LycnGItAXbQxyxArpB2eyDYJwlIagcyC+ofYebwCL9Rxkudo8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCPXzxjVhP2y6T8pZrusDKvq+4qCK0c1S9V6eTCnjhqy7tl36R
	OoKlECLWPlwVigPT4Fo/eeyFm8oMNnYjJm/pGc3F63R8ZHDYx933zh115qEZO45gS7Sc9IlEweb
	CPmDEQfTEbqH4ZXBtLZVbm/HKTtn8iXpweYrn0NN4
X-Gm-Gg: Acq92OHGrv2XlLdQfLc0lC63PtsaYjsXx4EkzwWuuyV24wUcRESIvh4TJRKxHVqdgLw
	OrN9SB85ZoRJb6gwoRUV6O/5fsb6DIsN1YpMTOC/c7XmSH/4m2bQRPtG5NZCH3roHJzqMe8hUvO
	Uvu0i+s7rfHc60JNBqUQdIjdyXiCh3fF4z124//vLRLeI/zT7I649m5q2E92GMjAMpWKx46fBQ8
	1w9tkgRGyVg3rPukXiDEMJ8rmmnBv1BM1Ys1C2KFsdi7siVeqXSRrYlB/BMyAd8HUOiie8CguVZ
	93dA4uac7v7CTzuiUTYKz02tmRlYehWhzw58v/O2MGCIuvk6
X-Received: by 2002:a05:600c:83c4:b0:48a:56fa:36dd with SMTP id
 5b1f17b1804b1-48ffd85790amr3271995e9.11.1779147554173; Mon, 18 May 2026
 16:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <20260515-hinschauen-effizient-9e3a05a94f2e@brauner> <CABdmKX0d6Zsg+_TxXjB80UZR23ZvXzxYoWzORgwmx=ZiuE+Nzw@mail.gmail.com>
 <208fb820-d8eb-4832-a343-ef8b360e8120@amd.com> <CADSE00Lh95ygoXGKJGsYvQGEsFV8sVmwEC3uvh8M6r3ERzaJwg@mail.gmail.com>
 <88efe10a-8b93-4a81-8279-4a5559d0f17c@amd.com>
In-Reply-To: <88efe10a-8b93-4a81-8279-4a5559d0f17c@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 16:39:02 -0700
X-Gm-Features: AVHnY4K5WzHxjnmBKK1J4Ij9G3s1JmujGOC18rtfp3AXYH6mFeA4fkV1W-efX6I
Message-ID: <CABdmKX3yZubjDKbVqwrjHAiKyj_ioHzOoxd0wzFbJK=PAGOqcQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Albert Esteve <aesteve@redhat.com>, Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, mripard@kernel.org, 
	echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 7:07=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/18/26 14:50, Albert Esteve wrote:
> > On Mon, May 18, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/15/26 19:06, T.J. Mercier wrote:
> >>> On Fri, May 15, 2026 at 6:53=E2=80=AFAM Christian Brauner <brauner@ke=
rnel.org> wrote:
> >>>>
> >>>> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
> >>>>> On embedded platforms a central process often allocates dma-buf
> >>>>> memory on behalf of client applications. Without a way to
> >>>>> attribute the charge to the requesting client's cgroup, the
> >>>>> cost lands on the allocator, making per-cgroup memory limits
> >>>>> ineffective for the actual consumers.
> >>>>>
> >>>>> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> >>>>
> >>>> Please be aware that pidfds come in two flavors:
> >>>>
> >>>> thread-group pidfds and thread-specific pidfds. Make sure that your =
API
> >>>> doesn't implicitly depend on this distinction not existing.
> >>>
> >>> Hi Christian,
> >>>
> >>> Memcg is not a controller that supports "thread mode" so all threads
> >>> in a group should belong to the same memcg.
> >>
> >> BTW: Exactly that is the requirement automotive has with their native =
context use case.
> >>
> >> The use case is that you have a deamon which has multiple threads were=
 each one is acting on behalve of some other process.
> >>
> >> At the moment we basically say they are simply not using cgroups for t=
hat use case, but it would be really nice if we could handle that as well.
> >>
> >> Summarizing the requirement of that use case: You need a different cgr=
oup for each thread of a process.
> >
> > Hi Christian,
> >
> > Thanks for sharing this atuomotive usecase. If I understand correctly,
> > the actual requirement is attributing dma-buf charges to the right
> > client, not putting each daemon thread in a different cgroup?
>
> Nope, exactly that's the difference.
>
> The thread acts as a filtering agent for both memory allocation and comma=
nd submission for somebody else, the process on which behalve the daemon do=
es things can even be in a client VM, completely remote over some network o=
r even something like a microcontroller.
>
> Everything the thread does regarding CPU time, GPU driver memory allocati=
on as well as resources like GPU processing and I/O time etc.. needs to be =
accounted to one client which can be different for each thread of the proce=
ss.
>
> The only thing which is shared with the main process thread is CPU memory=
 resources, e.g. malloc() because that is basically just needed for houseke=
eping and pretty much irrelevant for this kind of use case.
>
> The problem is now you can't do that with cgroups at the moment but unfor=
tunately only the kernel has the information you need to know to do this.
>
> So what you end up with is to define tons of interfaces just to get the n=
ecessary information from the kernel into userspace and then essentially du=
plicate the same infrastructure cgroup provides in the kernel in userspace =
again.
>
> > If so,
> > the `charge_pid_fd` approach achieves this directly by passing the
> > client's `pid_fd`, without needing to add per-thread cgroup
> > infrastructure.
>
> Well it's already a massive improvemt, we could basically stop doing the =
whole duplication part for the GPU driver stack and just use cgroups for th=
is part.
>
> Doing that automatically for CPU and I/O time would just be nice to have =
additionally.
>
> Regards,
> Christian.

Hopefully I'm following correctly here.... So you are duplicating the
GPU driver stack to achieve remote accounting on a per-thread basis?
Does this mean for GPU allocations you currently have some GFP_ACCOUNT
magic in your driver to attribute GPU memory to the correct remote
client? So this series would close the gap for dma-buf allocations,
but what about private GPU driver memory allocated on behalf of a
client?
