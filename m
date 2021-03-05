Return-Path: <SRS0=aNh/=ID=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85578C43381
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 19:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1027D65009
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 19:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCETlS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:41:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43518 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhCETlL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Mar 2021 14:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614973271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gx5drrPzo10rVP2Ug6bIBylz6S8jwfxpx5Mbvv0nZTs=;
        b=GQMf9o6vAz274v2HfyX5fkNU+mv/UjoJGZbA9jN2ZdmQOIZw45Mvk+5rmrmKZYMYOsc2Q7
        xUP8I24QpO/sB1YoeWYcXWU1+OlHK+UpSqqnWHQrogbm46o9VkbsweOw00aD6gLfwTdS2f
        pLAF0HVpZkKMVNV5Nx14WO1bRgPpKjU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-_Xs32-KMNa2wEHm1Yj0v5w-1; Fri, 05 Mar 2021 14:41:08 -0500
X-MC-Unique: _Xs32-KMNa2wEHm1Yj0v5w-1
Received: by mail-wm1-f69.google.com with SMTP id a3so746640wmm.0
        for <linux-security-module@vger.kernel.org>; Fri, 05 Mar 2021 11:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=rIyScA6Mo4EmL+2XyKsh9B4ovscCNZHcZ56Sz7w7WWU=;
        b=mjjysc9IjlTTbUmvUiX0BUndkSMGTxcV+Wyi5V6JExfjdaA9zsE5NvgpLFyhlpFHXw
         OSFA0m8OYFkPRX0+s+v46msAcyYDOY40HQd01IHLOKDk+niKEXopHqODz/6vDdLNpwKg
         gVt8ayL5ubnlz6UH4rD6cxTDyW4LHh5GVKMqeceruF0nKIBV+R+QZdI5DaD3HqSddReB
         HDhPC61pcACCc38J5Ir1Px/bN5vOmRQc6Nh/jkWdHvZZUqupPOsO6jaQIh48S9XS3bzP
         ews5u0kf6DXohqDerLc9cnBlgEjnFCrHJ28ts6o3RPuMWQc3hRJkbRYdDwHcxdehJslZ
         fHYA==
X-Gm-Message-State: AOAM533wGeNSSMpK6Dj3mPIey2FljsILyCmDVVSsNTGLXyXL8fdWQZ/o
        ldCB98dxLXHYGr/TUaqh1vBuXoIkGv5gdDgTtI8IO1MZ9DmBN3JXLHY1SSCNHYeV7ENXP70NF4Y
        KUyaTs+TWwkQBzP0C0Zyi/Gfr4kpBZGf0BN3A
X-Received: by 2002:adf:ebcb:: with SMTP id v11mr10764007wrn.231.1614973267347;
        Fri, 05 Mar 2021 11:41:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqDcoG6FcwCmOVbjwrPRYQFV7JxlxpioxDFxV9pX+oshrNklhdZBtTvpbW2VEu4S4Eb2JV7w==
X-Received: by 2002:adf:ebcb:: with SMTP id v11mr10763976wrn.231.1614973267004;
        Fri, 05 Mar 2021 11:41:07 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6b97.dip0.t-ipconnect.de. [91.12.107.151])
        by smtp.gmail.com with ESMTPSA id m11sm5693156wrz.40.2021.03.05.11.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 11:41:06 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
Date:   Fri, 5 Mar 2021 20:41:04 +0100
Message-Id: <245612A8-56DA-47D8-BB18-613FF9C8AF96@redhat.com>
References: <CAJuCfpHDtu0R6zZ0uo0YZgCE=dyhy6bsToUU2+reo3pBV0PcBg@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?utf-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        James Morris <jmorris@namei.org>,
        Linux MM <linux-mm@kvack.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
In-Reply-To: <CAJuCfpHDtu0R6zZ0uo0YZgCE=dyhy6bsToUU2+reo3pBV0PcBg@mail.gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
X-Mailer: iPhone Mail (18D52)
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


> Am 05.03.2021 um 19:36 schrieb Suren Baghdasaryan <surenb@google.com>:
>=20
> =EF=BB=BFOn Fri, Mar 5, 2021 at 10:23 AM David Hildenbrand <david@redhat.=
com> wrote:
>>=20
>>> On 05.03.21 19:08, Suren Baghdasaryan wrote:
>>> On Fri, Mar 5, 2021 at 9:52 AM David Hildenbrand <david@redhat.com> wro=
te:
>>>>=20
>>>> On 05.03.21 18:45, Shakeel Butt wrote:
>>>>> On Fri, Mar 5, 2021 at 9:37 AM David Hildenbrand <david@redhat.com> w=
rote:
>>>>>>=20
>>>>>> On 04.03.21 01:03, Shakeel Butt wrote:
>>>>>>> On Wed, Mar 3, 2021 at 3:34 PM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>>>>>>>>=20
>>>>>>>> On Wed, Mar 3, 2021 at 3:17 PM Shakeel Butt <shakeelb@google.com> =
wrote:
>>>>>>>>>=20
>>>>>>>>> On Wed, Mar 3, 2021 at 10:58 AM Suren Baghdasaryan <surenb@google=
.com> wrote:
>>>>>>>>>>=20
>>>>>>>>>> process_madvise currently requires ptrace attach capability.
>>>>>>>>>> PTRACE_MODE_ATTACH gives one process complete control over anoth=
er
>>>>>>>>>> process. It effectively removes the security boundary between th=
e
>>>>>>>>>> two processes (in one direction). Granting ptrace attach capabil=
ity
>>>>>>>>>> even to a system process is considered dangerous since it create=
s an
>>>>>>>>>> attack surface. This severely limits the usage of this API.
>>>>>>>>>> The operations process_madvise can perform do not affect the cor=
rectness
>>>>>>>>>> of the operation of the target process; they only affect where t=
he data
>>>>>>>>>> is physically located (and therefore, how fast it can be accesse=
d).
>>>>>>>>>> What we want is the ability for one process to influence another=
 process
>>>>>>>>>> in order to optimize performance across the entire system while =
leaving
>>>>>>>>>> the security boundary intact.
>>>>>>>>>> Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_REA=
D
>>>>>>>>>> and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metad=
ata
>>>>>>>>>> and CAP_SYS_NICE for influencing process performance.
>>>>>>>>>>=20
>>>>>>>>>> Cc: stable@vger.kernel.org # 5.10+
>>>>>>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>>>>>>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>>>>>>>> Acked-by: Minchan Kim <minchan@kernel.org>
>>>>>>>>>> Acked-by: David Rientjes <rientjes@google.com>
>>>>>>>>>> ---
>>>>>>>>>> changes in v3
>>>>>>>>>> - Added Reviewed-by: Kees Cook <keescook@chromium.org>
>>>>>>>>>> - Created man page for process_madvise per Andrew's request: htt=
ps://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=3Da144f=
458bad476a3358e3a45023789cb7bb9f993
>>>>>>>>>> - cc'ed stable@vger.kernel.org # 5.10+ per Andrew's request
>>>>>>>>>> - cc'ed linux-security-module@vger.kernel.org per James Morris's=
 request
>>>>>>>>>>=20
>>>>>>>>>>    mm/madvise.c | 13 ++++++++++++-
>>>>>>>>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>>>>>>=20
>>>>>>>>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>>>>>>>>> index df692d2e35d4..01fef79ac761 100644
>>>>>>>>>> --- a/mm/madvise.c
>>>>>>>>>> +++ b/mm/madvise.c
>>>>>>>>>> @@ -1198,12 +1198,22 @@ SYSCALL_DEFINE5(process_madvise, int, pi=
dfd, const struct iovec __user *, vec,
>>>>>>>>>>                   goto release_task;
>>>>>>>>>>           }
>>>>>>>>>>=20
>>>>>>>>>> -       mm =3D mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
>>>>>>>>>> +       /* Require PTRACE_MODE_READ to avoid leaking ASLR metada=
ta. */
>>>>>>>>>> +       mm =3D mm_access(task, PTRACE_MODE_READ_FSCREDS);
>>>>>>>>>>           if (IS_ERR_OR_NULL(mm)) {
>>>>>>>>>>                   ret =3D IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
>>>>>>>>>>                   goto release_task;
>>>>>>>>>>           }
>>>>>>>>>>=20
>>>>>>>>>> +       /*
>>>>>>>>>> +        * Require CAP_SYS_NICE for influencing process performa=
nce. Note that
>>>>>>>>>> +        * only non-destructive hints are currently supported.
>>>>>>>>>=20
>>>>>>>>> How is non-destructive defined? Is MADV_DONTNEED non-destructive?
>>>>>>>>=20
>>>>>>>> Non-destructive in this context means the data is not lost and can=
 be
>>>>>>>> recovered. I follow the logic described in
>>>>>>>> https://lwn.net/Articles/794704/ where Minchan was introducing
>>>>>>>> MADV_COLD and MADV_PAGEOUT as non-destructive versions of MADV_FRE=
E
>>>>>>>> and MADV_DONTNEED. Following that logic, MADV_FREE and MADV_DONTNE=
ED
>>>>>>>> would be considered destructive hints.
>>>>>>>> Note that process_madvise_behavior_valid() allows only MADV_COLD a=
nd
>>>>>>>> MADV_PAGEOUT at the moment, which are both non-destructive.
>>>>>>>>=20
>>>>>>>=20
>>>>>>> There is a plan to support MADV_DONTNEED for this syscall. Do we ne=
ed
>>>>>>> to change these access checks again with that support?
>>>>>>=20
>>>>>> Eh, I absolutely don't think letting another process discard memory =
in
>>>>>> another process' address space is a good idea. The target process ca=
n
>>>>>> observe that easily and might even run into real issues.
>>>>>>=20
>>>>>> What's the use case?
>>>>>>=20
>>>>>=20
>>>>> Userspace oom reaper. Please look at
>>>>> https://lore.kernel.org/linux-api/20201014183943.GA1489464@google.com=
/T/
>>>>>=20
>>>>=20
>>>> Thanks, somehow I missed that (not that it really changed my opinion o=
n
>>>> the approach while skimming over the discussion :) will have a more
>>>> detailed look)
>>>=20
>>> The latest version of that patchset is:
>>> https://lore.kernel.org/patchwork/patch/1344419/
>>> Yeah, memory reaping is a special case when we are operating on a
>>> dying process to speed up the release of its memory. I don't know if
>>> for that particular case we need to make the checks stricter. It's a
>>> dying process anyway and the data is being destroyed. Allowing to
>>> speed up that process probably can still use CAP_SYS_NICE.
>>=20
>> I know, unrelated discussion (sorry, I don't have above thread in my
>> archive anymore due to automatic cleanups ...) , but introducing
>> MADV_DONTEED on a remote processes, having to tweak range logic because
>> we always want to apply it to the whole MM, just to speed up memory
>> reaping sounds like completely abusing madvise()/process_madvise() to me=
.
>>=20
>> You want different semantics than MADV_DONTNEED. You want different
>> semantics than madvise.
>>=20
>> Simple example: mlock()ed pages in the target process. MADV_DONTNEED
>> would choke on that. For the use case of reaping, you certainly don't ca=
re.
>>=20
>> I am not sure if process_madvise() is the right interface to enforce
>> discarding of all target memory.
>>=20
>>=20
>> Not to mention that MADV_FREE doesn't make any sense IMHO for memory
>> reaping ... no to mention exposing this via process_madvise().
>=20
> Yeah, that was the last comment from Christoph Hellwig on
> https://lore.kernel.org/patchwork/patch/1344418/
> I'll be rethinking the whole approach. Previously I proposed couple
> different approaches that would make reaping a part of the kill by
> adding a new flag for pidfd_send_signal:
> https://lore.kernel.org/patchwork/patch/1338196/
> https://lore.kernel.org/patchwork/patch/1060407/
> but maybe a separate syscall for reaping is indeed the right way to go...

Yeah, most likely!

>=20

