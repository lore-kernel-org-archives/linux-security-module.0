Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07BB229B05
	for <linux-security-module@vger.kernel.org>; Tue, 29 Apr 2025 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945357; cv=none; b=EYML0e76lsbHGp/Szpjznx+6EHxFBAYoOlKIoy/9U1FbORtrqYfjXTs1egBgsaFGSmm0H7JLPCxaVSgmv4b1A//A3XdredG48Hqa88gpRuVxcldlyfTqzQ9dv43YQFilM1RL7uykGMjI0YkYF+DXEccBYDhr3NFV0ebFO/+PRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945357; c=relaxed/simple;
	bh=FMurzIzyO67+dWFuRy6pwztmgR4pKnice6sDOynhZeo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nRFA3F/0YWZuiIqBSXeaQiYxB+P+wpJi95U0nFfc9w2B7cx4VGse4JJe9lU5sf9B5pZhgWY1UcESSQ/3TYFn5yJVhBXxLMaYDwPEiJAs/F+8Qj5PZpbg/V3q2uDvVMKAljKZqMjkTlH+fmvJwt2ViYJU45hefVm4zNVdMXYmNp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Received: from dummy.faircode.eu (unknown [172.56.24.20])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: serge)
	by mail.hallyn.com (Postfix) with ESMTPSA id 105801DDF;
	Tue, 29 Apr 2025 11:49:04 -0500 (CDT)
Date: Tue, 29 Apr 2025 11:48:51 -0500 (CDT)
From: Serge Hallyn <serge@hallyn.com>
To: Luigi Semenzato <semenzato@google.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
	linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>,
	Daniel Erickson <danerickson@google.com>,
	Dave Hill <davehill@google.com>, Alex Glaznev <glaznev@google.com>,
	Su Hong Koo <sukoo@google.com>, Sean Paul <seanpaul@google.com>
Message-ID: <1a67893e-61d1-4b65-b279-ccc21ad457f7@hallyn.com>
In-Reply-To: <CAA25o9Re9Zddos=MgWzEU3wd_VKYD-5xcrL6QaoQ_XcR0WJREw@mail.gmail.com>
References: <CAA25o9THx_+SzE_+DMjCeSRE28s3kxZ0OkXgSib3tU3svdQPzA@mail.gmail.com> <CAA25o9Q24atyK5M6BQaVx5sVq_ZouwRdhXEo3UPa5pE4XVqxQw@mail.gmail.com> <4689f3d0-5c5a-4736-9e09-e40712a53e08@schaufler-ca.com> <CAA25o9Re9Zddos=MgWzEU3wd_VKYD-5xcrL6QaoQ_XcR0WJREw@mail.gmail.com>
Subject: Re: how are new CAP_* added? CAP_{DISPLAY,DRM,GPU}?
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <1a67893e-61d1-4b65-b279-ccc21ad457f7@hallyn.com>

It doesn't look to me like this is necessarily equivalent to CAP_SYS_ADMIN,=
 so worth splittingoff. How about CAP_DRM_MASTER?

Apr 28, 2025 18:51:46 Luigi Semenzato <semenzato@google.com>:

> "DRM" stands for Direct Rendering Manager, which I understand is the
> standard way of accessing the GPU on the (vast?) majority of modern
> Linux systems, for the purpose of producing output on the display.
> (Other googlers on this thread would know better---for instance I
> don't know if DRM is used also for general-purpose computing on the
> GPU.)
>=20
> The DRM master essentially owns the display, so this may be similar to
> the totality of the CAP_NET_* capabilities.=C2=A0 Also similar to
> CAP_SYS_TIME, as it refers to a large class of hardware components.
>=20
> OTOH, just by looking at capability.h I am seeing that there is a lot
> of competition for those bits!
>=20
> I am wondering if this has come up for discussion before.=C2=A0 I couldn'=
t
> find references to it.=C2=A0 Probably because it just isn't a good
> candidate.
>=20
> On Mon, Apr 28, 2025 at 4:16=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
>>=20
>> On 4/28/2025 3:19 PM, Luigi Semenzato wrote:
>>> I have a use case for adding a CAP_DRM, or similar, to replace the
>>> CAP_SYS_ADMIN in drivers/gpu/drm/drm_auth.c for the purpose of
>>> becoming the DRM master.
>>>=20
>>> I am not an expert on either DRM or capabilities, and I am wondering
>>> how one can decide the appropriate level of granularity for a new
>>> capability.=C2=A0 Is CAP_DRM general enough (but not too much), or shou=
ld
>>> it be CAP_GPU, or CAP_DISPLAY?=C2=A0 Or perhaps capabilities should be
>>> discouraged for this case?
>>=20
>> There are a limited number (64) of capabilities available, so we're
>> being careful about handing them out. My first question is one of genera=
lity.
>> If there is only one case where the capability is useful, there's really=
 no
>> way to justify it. If a process would need another capability (typically
>> CAP_SYS_ADMIN) in all cases, there's no point in a separate one. If the
>> use case isn't going to be around more or less permanently, or it is uni=
que
>> to a hardware platform, we won't approve it. Without knowing what a "DRM=
 master"
>> is, it's difficult to say for sure, but I'm guessing you are going to be=
 up
>> against all these criteria.
>>=20
>>>=20
>>> Thanks!
>>>=20
>>>=20
>>> On Mon, Apr 28, 2025 at 3:16=E2=80=AFPM Luigi Semenzato <semenzato@goog=
le.com> wrote:
>>>> I have a use case for adding a CAP_DRM, or similar, to replace the CAP=
_SYS_ADMIN in drivers/gpu/drm/drm_auth.c for the purpose of becoming the DR=
M master.
>>>>=20
>>>> I am not an expert on either DRM or capabilities, and I am wondering h=
ow one can decide the appropriate level of granularity for a new capability=
.=C2=A0 Is CAP_DRM general enough (but not too much), or should it be CAP_G=
PU, or CAP_DISPLAY?=C2=A0 Or perhaps capabilities should be discouraged for=
 this case?
>>>>=20
>>>> Thanks!
>>>>=20
