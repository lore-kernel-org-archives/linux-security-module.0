Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6041E89C
	for <linux-security-module@vger.kernel.org>; Wed, 31 Dec 2025 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767200077; cv=none; b=eTqfIcYT9xkkBlfCAdRy++4vhu8GrognpxuG0nqXnT/EZljLyoO2t8qhI4nYKgGq8l2E5t/a8HzvcHSPK1yZSZNdJ47OJ/nqy5aDTrU2N6zuFEKIx3XZPB5hoAua6GugzZqdc8KCGwzUtgqvyZH5SnBlh9KEc4EI14AU153UERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767200077; c=relaxed/simple;
	bh=Q4HTlMR6EOkXKKLMiCWWo9QKxWRzD29bxNHwIoYwmNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKdUa5B8PUktZJERu+MrX2m8WmfKgQnnD0VHq3zKakfIiN76ipXYII/LwqXomYVEgxRKRMCQ9LvaovePP7BTIMPleaIk9AVO+oWszSyi5RE7TkEK+fPIDoo4ZLhQ7UXyMJvsgQSvqyJ/8djW8nLbH1l5S51qtyyRPpg+pSOZehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7FCRBSv; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7FCRBSv"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79018a412edso37573237b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 31 Dec 2025 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767200074; x=1767804874; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eaorC6IjDYhkxGkvv3gMOY4xNpkyG7LBRTjn4FEHiNQ=;
        b=Z7FCRBSvzp4mANWnLdd3zD1B+zcfLPPVDRFTf2XGKmvIvMXQTAgz561BmA/8fhnmLu
         9y67fRlbh8NYrhX3S8LG9UoP0cQFQOkD7DPKFZ9VMn7Xh7JDcXFzdMWGc/MOrxoWsXlP
         z7Y8ObKhIib3kWhBS/Q54UIjNlszBi51KQ8QALR5WwaOKntTeOlaNBWONeTOBNyJl55M
         g3HkbQ7SBfX6q0MIQyKAUnNOzANRVCKHIlXwvZgMSpStaQgs9VEONBLaT7j5hi63d8P7
         WJqokOcgoGBSvDBb6QImvVZyI/xVMtsZ0H2lPro9SfbSXsmcs/nVTs4Nz6++82qkMhwj
         lEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767200074; x=1767804874;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaorC6IjDYhkxGkvv3gMOY4xNpkyG7LBRTjn4FEHiNQ=;
        b=DN9nEqThXbk4UctW7Gia2fF7Vma7YWSQb5a1Mf/KNSnIaAPGPwcGi3o6E4cuZFcaVl
         jAkSkXDtP1XZudXB/zLIHDJZravcocYaRIYz7XNpDxz89UnoZ9ciYeITuQnqpiExHGBA
         tA4dEbxx1yMbCtOhntM1xhGiQLK/dRSAOkdk2XpySG8/QJ30pl6qsbiJzEWMjEdZDotk
         6FaaCMNUHM2tgfTdSquNoXQqVcHCMxSX19bcaCZlcPVSPXyrKgnNcw+SKSOrN7e+qPOR
         bK6XF8TwlEZFVxsBncwKX7nBAt4iegOujBmGPovum4PWI2u3jfMfD1HGiGUDFTPLFgQs
         f97w==
X-Forwarded-Encrypted: i=1; AJvYcCUSiyfoJoYITfI1c23o+tyuirYaIChdmwo+JealJJ0dIGGrng9JZpJXroulESjHTBV9HQm4Ae7wxvbceEjlwCXx7SlO7Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkRN3DD2TEcDeYyfEDKmmOI3YI6A2eUSJKuCBEDRC48keeD1pH
	auTJPaZzxq97Tml6ScCCF9KK7Iy83Va4iEeN9dF0yIrcEPSAwfPhgrCD
X-Gm-Gg: AY/fxX5kNf2QVI1yi0/hu8D1xLQgufyz4v8gJ3v2AtsskejX5IvQAjb9XPDVkB6+8M/
	V5iXW0COu3ehcT7nWLxDc86gVvlaQYQ/hQCp8hBv/7X52hJAmP9sdPevsLgZVPapvNWvIqep/t7
	hwwiGkFmfnlRoZ9C8FnfgMVzJC8WHcSohoegKc1auHRKVNHPgx0mVpGi1xPkr+tDIf7VqJcCAja
	I8fb1/cyrRU5xZCid9uq+9Y0pqDzIClmjpmsgqKfyMhs+yQzFs/vDiK61o4JM69YtBxAlHoigqY
	CUehkCT7Gu4Z5BhCm/SFZ5Nkph1DsTZ3fAmSW1LiMgT40WmH/0Q65aKNMaIyi7+VaPSsoRRolm2
	ezbHeMISLsAIFW1GTmisXtL//oDYg8WRzH8DqqyjhQ2ctU5obsHLwRPvAkCTxSDQFyCYnd4XW6B
	4cR626T/emkJmcGqQRz9P5Nn0IyDKcNowddRJMCKMdLrFguv9mMJJfmng/ouuK0Tlh+f6y4fqyF
	QwQkkNW1DoEO+0OtLb0FsTNVef0nNMIDq37isnb
X-Google-Smtp-Source: AGHT+IF97q+Aho1rewdfkVcgvv0gsU0WSz5uo6PvYWWlNeFpTq1m9rqiF1Vto/hI+ylwfhLEEcc/8A==
X-Received: by 2002:a53:ec83:0:b0:646:5019:f3ff with SMTP id 956f58d0204a3-6466a839258mr24144962d50.12.1767200074098;
        Wed, 31 Dec 2025 08:54:34 -0800 (PST)
Received: from [10.138.34.110] (h69-131-146-178.cncrtn.broadband.dynamic.tds.net. [69.131.146.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43cddb7sm138242097b3.24.2025.12.31.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 08:54:33 -0800 (PST)
Message-ID: <dc9b99b6-14a1-45b6-a23f-0b24143dac58@gmail.com>
Date: Wed, 31 Dec 2025 11:54:27 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
 Tahera Fahimi <fahimitahera@gmail.com>,
 Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org
References: <cover.1767115163.git.m@maowtm.org>
 <20251230.bcae69888454@gnoack.org>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20251230.bcae69888454@gnoack.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------57GrmDp3KY0vvxlRoSZ3CkCN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------57GrmDp3KY0vvxlRoSZ3CkCN
Content-Type: multipart/mixed; boundary="------------nbkQL0EyyxVh2IipIwguvixs";
 protected-headers="v1"
Message-ID: <dc9b99b6-14a1-45b6-a23f-0b24143dac58@gmail.com>
Date: Wed, 31 Dec 2025 11:54:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
 Tahera Fahimi <fahimitahera@gmail.com>,
 Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org
References: <cover.1767115163.git.m@maowtm.org>
 <20251230.bcae69888454@gnoack.org>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20251230.bcae69888454@gnoack.org>
Autocrypt-Gossip: addr=hi@alyssa.is; keydata=
 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
 wGxvGU7TX5ou

--------------nbkQL0EyyxVh2IipIwguvixs
Content-Type: multipart/mixed; boundary="------------OuT0ZIM5jkdtwCncIZXsHAIO"

--------------OuT0ZIM5jkdtwCncIZXsHAIO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/30/25 18:16, G=C3=BCnther Noack wrote:
> Hello!
>=20
> Thanks for sending this patch!
>=20
> On Tue, Dec 30, 2025 at 05:20:18PM +0000, Tingmao Wang wrote:
>> Changes in v2:
>>   Fix grammar in doc, rebased on mic/next, and extracted common code f=
rom
>>   hook_unix_stream_connect and hook_unix_may_send into a separate
>>   function.
>>
>> The rest is the same as the v1 cover letter:
>>
>> This patch series extend the existing abstract Unix socket scoping to
>> pathname (i.e. normal file-based) sockets as well, by adding a new sco=
pe
>> bit LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET that works the same as
>> LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET, except that restricts pathname Un=
ix
>> sockets.  This means that a sandboxed process with this scope enabled =
will
>> not be able to connect to Unix sockets created outside the sandbox via=
 the
>> filesystem.
>>
>> There is a future plan [1] for allowing specific sockets based on FS
>> hierarchy, but this series is only determining access based on domain
>> parent-child relationship.  There is currently no way to allow specifi=
c
>> (outside the Landlock domain) Unix sockets, and none of the existing
>> Landlock filesystem controls apply to socket connect().
>>
>> With this series, we can now properly protect against things like the =
the
>> following while only relying on Landlock:
>>
>>     (running under tmux)
>>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb ~# LL_FS_RO=3D/ LL_FS_RW=3D=
 ./sandboxer bash
>>     Executing the sandboxed command...
>>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
>>     cat: /tmp/hi: No such file or directory
>>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# tmux new-window 'echo h=
i > /tmp/hi'
>>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
>>     hi
>>
>> The above but with Unix socket scoping enabled (both pathname and abst=
ract
>> sockets) - the sandboxed shell can now no longer talk to tmux due to t=
he
>> socket being created from outside the Landlock sandbox:
>>
>>     (running under tmux)
>>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb ~# LL_FS_RO=3D/ LL_FS_RW=3D=
 LL_SCOPED=3Du:a ./sandboxer bash
>>     Executing the sandboxed command...
>>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
>>     cat: /tmp/hi: No such file or directory
>>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# tmux new-window 'echo h=
i > /tmp/hi'
>>     error connecting to /tmp/tmux-0/default (Operation not permitted)
>>     root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
>>     cat: /tmp/hi: No such file or directory
>>
>> Tmux is just one example.  In a standard systemd session, `systemd-run=

>> --user` can also be used (--user will run the command in the user's
>> session, without requiring any root privileges), and likely a lot more=
 if
>> running in a desktop environment with many popular applications.  This=

>> change therefore makes it possible to create sandboxes without relying=
 on
>> additional mechanisms like seccomp to protect against such issues.
>>
>> These kind of issues was originally discussed on here (I took the idea=
 for
>> systemd-run from Demi):
>> https://spectrum-os.org/lists/archives/spectrum-devel/00256266-26db-40=
cf-8f5b-f7c7064084c2@gmail.com/
>=20
> What is unclear to me from the examples and the description is: Why is
> the boundary between allowed and denied connection targets drawn at
> the border of the Landlock domain (the "scope") and why don't we solve
> this with the file-system-based approach described in [1]?
>=20
> **Do we have existing use cases where a service is both offered and
> connected to all from within the same Landlock domain, and where the
> process enforcing the policy does not control the child process enough
> so that it would be possible to allow-list it with a
> LANDLOCK_ACCESS_FS_CONNECT_UNIX rule?**
>=20
> If we do not have such a use case, it seems that the planned FS-based
> control mechanism from [1] would do the same job?  Long term, we might
> be better off if we only have only one control -- as we have discussed
> in [2], having two of these might mean that they interact in
> unconventional and possibly confusing ways.

I agree with this.

> Apart from that, there are some other weaker hints that make me
> slightly critical of this patch set:
>=20
> * We discussed the idea that a FS-based path_beneath rule would act
>   implicitly also as an exception for
>   LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET, in [2] - one possible way to
>   interpret this is that the gravity of the system's logic pulls us
>   back towards a FS-based control, and we would have to swim less
>   against the stream if we integrated the Unix connect() control in
>   that way?

I agree with this as well.  Having FS-based controls apply consistently
to all types of inodes is what I would expect.

> * I am struggling to convince myself that we can tell users to
>   restrict LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET as a default, as we are
>   currently doing it with the other "scoped" and file system controls.
>   (The scoped signals are OK because killing out-of-domain processes
>   is clearly bad.  The scoped abstract sockets are usually OK because
>   most processes do not need that feature.)
>=20
>   But there are legitimate Unix services that are still needed by
>   unprivileged processes and which are designed to be safe to use.
>   For instance, systemd exposes a user database lookup service over
>   varlink [3], which can be accessed from arbitrary glibc programs
>   through a NSS module.  Using this is incompatible with
>   LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET as long as we do not have the
>   FS-based control and the surprising implicit permission through a
>   path_beneath rule as discussed in [2].
>=20
>   (Another example is the X11 socket, to which the same reasoning
>   should apply, I think, and which is also used by a large number of
>   programs.)
I think making FS-based controls on by default is the least surprising
option for users.  It's what I suspect most programs intend, and it
would stop a lot of unexpected sandbox escapes.

Without FS-based controls, scoping is also necessary to prevent
sandbox escapes.  In my opinion, it's better to block access to
unprivileged services than to allow connecting to any service.

X11 is a trivial sandbox escape by taking over the user's GUI.
A sandboxed program accessing it indicates a misdesign.  The NSS module
is not needed by programs that do not do user database resolution,
which I suspect includes almost all sandboxed programs.

> I agree that the bug [1] has been asleep for a bit too long, and we
> should probably pick this up soon.  As we have not heard back from
> Ryan after our last inquiry, IMHO I think it would be fair to take it
> over.

I definitely support this!

> Apologies for the difficult feedback - I do not mean to get in the way
> of your enthusiasm here, but I would like to make sure that we don't
> implement this as a stop-gap measure just because the other bug [1]
> seemed more difficult and/or stuck in a github issue interaction.
> Let's rather unblock that bug, if that is the case. :)
>=20
> As usual, I fully acknowledge that I might well be wrong and might
> have missed some of the underlying reasons, in which case I will
> happily be corrected and change my mind. :)
>=20
> [1] https://github.com/landlock-lsm/linux/issues/36
> [2] https://github.com/landlock-lsm/linux/issues/36#issuecomment-369974=
9541
> [3] https://systemd.io/USER_GROUP_API/
>=20
> Have a good start into the new year!
> =E2=80=93G=C3=BCnther
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------OuT0ZIM5jkdtwCncIZXsHAIO
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49y
B+l2nipdaq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYf
bWpr/si88QKgyGSVZ7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/
UorR+FaSuVwT7rqzGrTlscnTDlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7M
MPCJwI8JpPlBedRpe9tfVyfu3euTPLPxwcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9H
zx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR6h3nBc3eyuZ+q62HS1pJ5EvU
T1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl5FMWo8TCniHynNXs
BtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2Bkg1b//r
6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nS
m9BBff0Nm0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQAB
zTxEZW1pIE9iZW5vdXIgKElUTCBFbWFpbCBLZXkpIDxhdGhlbmFAaW52aXNpYmxl
dGhpbmdzbGFiLmNvbT7CwY4EEwEIADgWIQR2h02fEza6IlkHHHGyiLVf/5wiwQUC
X6YJvQIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCyiLVf/5wiwWRhD/0Y
R+YYC5Kduv/2LBgQJIygMsFiRHbR4+tWXuTFqgrxxFSlMktZ6gQrQCWe38WnOXkB
oY6n/5lSJdfnuGd2UagZ/9dkaGMUkqt+5WshLFly4BnP7pSsWReKgMP7etRTwn3S
zk1OwFx2lzY1EnnconPLfPBc6rWG2moA6l0WX+3WNR1B1ndqpl2hPSjT2jUCBWDV
rGOUSX7r5f1WgtBeNYnEXPBCUUM51pFGESmfHIXQrqFDA7nBNiIVFDJTmQzuEqIy
Jl67pKNgooij5mKzRhFKHfjLRAH4mmWZlB9UjDStAfFBAoDFHwd1HL5VQCNQdqEc
/9lZDApqWuCPadZN+pGouqLysesIYsNxUhJ7dtWOWHl0vs7/3qkWmWun/2uOJMQh
ra2u8nA9g91FbOobWqjrDd6x3ZJoGQf4zLqjmn/P514gb697788e573WN/MpQ5XI
Fl7aM2d6/GJiq6LC9T2gSUW4rbPBiqOCeiUx7Kd/sVm41p9TOA7fEG4bYddCfDsN
xaQJH6VRK3NOuBUGeL+iQEVF5Xs6Yp+U+jwvv2M5Lel3EqAYo5xXTx4ls0xaxDCu
fudcAh8CMMqx3fguSb7Mi31WlnZpk0fDuWQVNKyDP7lYpwc4nCCGNKCj622ZSocH
AcQmX28L8pJdLYacv9pU3jPy4fHcQYvmTavTqowGnM08RGVtaSBNYXJpZSBPYmVu
b3VyIChsb3ZlciBvZiBjb2RpbmcpIDxkZW1pb2Jlbm91ckBnbWFpbC5jb20+wsF4
BBMBAgAiBQJafgNKAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyiLVf
/5wiwYa/EACv8a2+MMou9cSCNoZBQaU+fTmyzft9hUE+0d5W2UY1RY3OsjFIzm9R
/4SVccfsqOYLEo+S0vQMIIIqFEq3FCpXXwPzyimotps05VA8U3Bd7yseojFygOgK
sAMOAee2RCaDDOnoJue01dfZMzzHPO/TVdp3OvnpWipfv5G1Xg96rwbhMLE3tg6N
xwAHa31Bv4/Xq8CJOoIWvx6fcmZQpz01/lSvsYn0KrfEbTKkuUf0vM9JrCTCP2oz
VNN5BYzqaq2M4r+jmSyeXLim922VOWqGkUEQ85BSEemqrRS06IU6NtEMsF8EWt/b
hWjk/9GDKTcnpdJHTrMxTspExBiNrvpI2t+YPU5B/dJJAUxvmhFrbSIbdB8umBZs
I3AMYrEmpAbh5x7jEjoskUC7uN3o9vpg1oCLS2ePDLtAtyBtbHnkA4xGD7ar8mem
xpH9lY/i+sC6CyyIUWcUDnnagKyJP0m9ks0GLsTeOCA0bft2XA6rD6aaCnMUsndT
ctrab42CV5XypjmC4U1rPJ8JQJUh1/3P48/8sMH+3krxpJ06KNWNFaUbaMTGiltZ
7x9DngklSYrX0T+2G4kVXNmjaljwkoLahwLla2gUWwBSyofXdqyhQdwZsp01KXNQ
UCyT/Pg+aDcm/E7OMV3d4lf7g/CSxiX2GSEe6BlhSz+Lmd7ZJ3g32M1ARGVtaSBN
YXJpZSBPYmVub3VyIChJVEwgRW1haWwgS2V5KSA8ZGVtaUBpbnZpc2libGV0aGlu
Z3NsYWIuY29tPsLBjgQTAQgAOBYhBHaHTZ8TNroiWQcccbKItV//nCLBBQJgOEV+
AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJELKItV//nCLBKwoP/1WSnFdv
SAD0g7fD0WlF+oi7ISFT7oqJnchFLOwVHK4Jg0e4hGn1ekWsF3Ha5tFLh4V/7UUu
obYJpTfBAA2CckspYBqLtKGjFxcaqjjpO1I2W/jeNELVtSYuCOZICjdNGw2Hl9yH
KRZiBkqc9u8lQcHDZKq4LIpVJj6ZQV/nxttDX90ax2No1nLLQXFbr5wb465LAPpU
lXwunYDij7xJGye+VUASQh9datye6orZYuJvNo8Tr3mAQxxkfR46LzWgxFCPEAZJ
5P56Nc0IMHdJZj0Uc9+1jxERhOGppp5jlLgYGK7faGB/jTV6LaRQ4Ad+xiqokDWp
mUOZsmA+bMbtPfYjDZBz5mlyHcIRKIFpE1l3Y8F7PhJuzzMUKkJi90CYakCV4x/a
Zs4pzk5E96c2VQx01RIEJ7fzHF7lwFdtfTS4YsLtAbQFsKayqwkGcVv2B1AHeqdo
TMX+cgDvjd1ZganGlWA8Sv9RkNSMchn1hMuTwERTyFTr2dKPnQdA1F480+jUap41
ClXgn227WkCIMrNhQGNyJsnwyzi5wS8rBVRQ3BOTMyvGM07j3axUOYaejEpg7wKi
wTPZGLGH1sz5GljD/916v5+v2xLbOo5606j9dWf5/tAhbPuqrQgWv41wuKDi+dDD
EKkODF7DHes8No+QcHTDyETMn1RYm7t0RKR4zsFNBFp+A0oBEAC9ynZI9LU+uJkM
eEJeJyQ/8VFkCJQPQZEsIGzOTlPnwvVna0AS86n2Z+rK7R/usYs5iJCZ55/JISWd
8xD57ue0eB47bcJvVqGlObI2DEG8TwaW0O0duRhDgzMEL4t1KdRAepIESBEA/iPp
I4gfUbVEIEQuqdqQyO4GAe+MkD0Hy5JH/0qgFmbaSegNTdQg5iqYjRZ3ttiswalq
l1/iSyv1WYeC1OAs+2BLOAT2NEggSiVOtxEfgewsQtCWi8H1SoirakIfo45Hz0tk
/Ad9ZWh2PvOGt97Ka85o4TLJxgJJqGEnqcFUZnJJriwoaRIS8N2C8/nEM53jb1sH
0gYddMU3QxY7dYNLIUrRKQeNkF30dK7V6JRH7pleRlf+wQcNfRAIUrNlatj9Txwi
vQrKnC9aIFFHEy/0mAgtrQShcMRmMgVlRoOA5B8RTulRLCmkafvwuhs6dCxN0GNA
ORIVVFxjx9Vn7OqYPgwiofZ6SbEl0hgPyWBQvE85klFLZLoj7p+joDY1XNQztmfA
rnJ9x+YV4igjWImINAZSlmEcYtd+xy3Li/8oeYDAqrsnrOjb+WvGhCykJk4urBog
2LNtcyCjkTs7F+WeXGUo0NDhbd3Z6AyFfqeF7uJ3D5hlpX2nI9no/ugPrrTVoVZA
grrnNz0iZG2DVx46x913pVKHl5mlYQARAQABwsFfBBgBAgAJBQJafgNKAhsMAAoJ
ELKItV//nCLBwNIP/AiIHE8boIqReFQyaMzxq6lE4YZCZNj65B/nkDOvodSiwfwj
jVVE2V3iEzxMHbgyTCGA67+Bo/d5aQGjgn0TPtsGzelyQHipaUzEyrsceUGWYoKX
YyVWKEfyh0cDfnd9diAm3VeNqchtcMpoehETH8frRHnJdBcjf112PzQSdKC6kqU0
Q196c4Vp5HDOQfNiDnTf7gZSj0BraHOByy9LEDCLhQiCmr+2E0rW4tBtDAn2HkT9
uf32ZGqJCn1O+2uVfFhGu6vPE5qkqrbSE8TG+03H8ecU2q50zgHWPdHMOBvy3Ehz
fAh2VmOSTcRK+tSUe/u3wdLRDPwv/DTzGI36Kgky9MsDC5gpIwNbOJP2G/q1wT1o
Gkw4IXfWv2ufWiXqJ+k7HEi2N1sree7Dy9KBCqb+ca1vFhYPDJfhP75I/VnzHVss
Z/rYZ9+51yDoUABoNdJNSGUYl+Yh9Pw9pE3Kt4EFzUlFZWbE4xKL/NPno+z4J9aW
emLLszcYz/u3XnbOvUSQHSrmfOzX3cV4yfmjM5lewgSstoxGyTx2M8enslgdXhPt
hZlDnTnOT+C+OTsh8+m5tos8HQjaPM01MKBiAqdPgksm1wu2DrrwUi6ChRVTUBcj
6+/9IJ81H2P2gJk3Ls3AVIxIffLoY34E+MYSfkEjBz0E8CLOcAw7JIwAaeBTzsFN
BGbyLVgBEACqClxh50hmBepTSVlan6EBq3OAoxhrAhWZYEwN78k+ENhK68KhqC5R
IsHzlL7QHW1gmfVBQZ63GnWiraM6wOJqFTL4ZWvRslga9u28FJ5XyK860mZLgYhK
9BzoUk4s+dat9jVUbq6LpQ1Ot5I9vrdzo2p1jtQ8h9WCIiFxSYy8s8pZ3hHh5T64
GIj1m/kY7lG3VIdUgoNiREGf/iOMjUFjwwE9ZoJ26j9p7p1U+TkKeF6wgswEB1T3
J8KCAtvmRtqJDq558IU5jhg5fgN+xHB8cgvUWulgK9FIF9oFxcuxtaf/juhHWKMO
RtL0bHfNdXoBdpUDZE+mLBUAxF6KSsRrvx6AQyJs7VjgXJDtQVWvH0PUmTrEswgb
49nNU+dLLZQAZagxqnZ9Dp5l6GqaGZCHERJcLmdY/EmMzSf5YazJ6c0vO8rdW27M
kn73qcWAplQn5mOXaqbfzWkAUPyUXppuRHfrjxTDz3GyJJVOeMmMrTxH4uCaGpOX
Z8tN6829J1roGw4oKDRUQsaBAeEDqizXMPRc+6U9vI5FXzbAsb+8lKW65G7JWHym
YPOGUt2hK4DdTA1PmVo0DxH00eWWeKxqvmGyX+Dhcg+5e191rPsMRGsDlH6KihI6
+3JIuc0y6ngdjcp6aalbuvPIGFrCRx3tnRtNc7He6cBWQoH9RPwluwARAQABwsOs
BBgBCgAgFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmbyLVgCGwICQAkQsoi1X/+c
IsHBdCAEGQEKAB0WIQSilC2pUlbVp66j3+yzNoc6synyUwUCZvItWAAKCRCzNoc6
synyU85gD/0T1QDtPhovkGwoqv4jUbEMMvpeYQf+oWgm/TjWPeLwdjl7AtY0G9Ml
ZoyGniYkoHi37Gnn/ShLT3B5vtyI58ap2+SSa8SnGftdAKRLiWFWCiAEklm9FRk8
N3hwxhmSFF1KR/AIDS4g+HIsZn7YEMubBSgLlZZ9zHl4O4vwuXlREBEW97iL/FSt
VownU2V39t7PtFvGZNk+DJH7eLO3jmNRYB0PL4JOyyda3NH/J92iwrFmjFWWmmWb
/Xz8l9DIs+Z59pRCVTTwbBEZhcUc7rVMCcIYL+q1WxBG2e6lMn15OQJ5WfiE6E0I
sGirAEDnXWx92JNGx5l+mMpdpsWhBZ5iGTtttZesibNkQfd48/eCgFi4cxJUC4PT
UQwfD9AMgzwSTGJrkI5XGy+XqxwOjL8UA0iIrtTpMh49zw46uV6kwFQCgkf32jZM
OLwLTNSzclbnA7GRd8tKwezQ/XqeK3dal2n+cOr+o+Eka7yGmGWNUqFbIe8cjj9T
JeF3mgOCmZOwMI+wIcQYRSf+e5VTMO6TNWH5BI3vqeHSt7HkYuPlHT0pGum88d4a
pWqhulH4rUhEMtirX1hYx8Q4HlUOQqLtxzmwOYWkhl1C+yPObAvUDNiHCLf9w28n
uihgEkzHt9J4VKYulyJM9fe3ENcyU6rpXD7iANQqcr87ogKXFxknZ97uEACvSucc
RbnnAgRqZ7GDzgoBerJ2zrmhLkeREZ08iz1zze1JgyW3HEwdr2UbyAuqvSADCSUU
GN0vtQHsPzWl8onRc7lOPqPDF8OO+UfN9NAfA4wl3QyChD1GXl9rwKQOkbvdlYFV
UFx9u86LNi4ssTmU8p9NtHIGpz1SYMVYNoYy9NU7EVqypGMguDCL7gJt6GUmA0sw
p+YCroXiwL2BJ7RwRqTpgQuFL1gShkA17D5jK4mDPEetq1d8kz9rQYvAR/sTKBsR
ImC3xSfn8zpWoNTTB6lnwyP5Ng1bu6esS7+SpYprFTe7ZqGZF6xhvBPf1Ldi9UAm
U2xPN1/eeWxEa2kusidmFKPmN8lcT4miiAvwGxEnY7Oww9CgZlUB+LP4dl5VPjEt
sFeAhrgxLdpVTjPRRwTd9VQF3/XYl83j5wySIQKIPXgT3sG3ngAhDhC8I8GpM36r
8WJJ3x2yVzyJUbBPO0GBhWE2xPNIfhxVoU4cGGhpFqz7dPKSTRDGq++MrFgKKGpI
ZwT3CPTSSKc7ySndEXWkOYArDIdtyxdE1p5/c3aoz4utzUU7NDHQ+vVIwlnZSMiZ
jek2IJP3SZ+COOIHCVxpUaZ4lnzWT4eDqABhMLpIzw6NmGfg+kLBJhouqz81WITr
EtJuZYM5blWncBOJCoWMnBEcTEo/viU3GgcVRw=3D=3D
=3Dx94R
-----END PGP PUBLIC KEY BLOCK-----

--------------OuT0ZIM5jkdtwCncIZXsHAIO--

--------------nbkQL0EyyxVh2IipIwguvixs--

--------------57GrmDp3KY0vvxlRoSZ3CkCN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmlVVUQACgkQszaHOrMp
8lNWgw/+O6OiJ3RWdGbr1vzZgEv/2vuJCWw1XO9BqUNwppsP0/BSGy+39CUjS4pk
b2u3ktI7LAQ2NaFf/7PserOLO+sNjUcr4F79O5caap9g8wHmWpF1m7xZAa/E1h/f
JxX9HwqNXAfnW0lik/9cJcc+7PVumcX6FbMxp6N1X9fzRP8EQ6Ebf+dDbjc2tinV
o+T4+vCPXCHX38Km1HMVVQY6yFWTeolLieHck4BER4kErcuScsUpWM6Z7GO0N+63
zArxqNCkdyHZIVr0gxre66wJM9dA551vxtkTsHt0d6ZUDCM+48BdUc0PgskSFF6c
5P2GwDmfCNqsYEGEfg7VRNDDiZjlTDk1Ssf6PkzIUM7CmN/LYngoGwi97N0Um7bX
cbhzVzMh0foHIAa7GUu9+MiE/pgAb2McUc/xeLfVeGmiSRVHv6oMv6nauTe1kkqV
Q1DsZMn4qhT4hUMZpPLWSNfjGPizdB8wmlP2/OD87uQKumo9VzzYTd1wxC6QVtsp
nefZgcfgTegHKzGWC3d8QCz83sx3Rmv91W0MTm6j3K7tGH3MCQF2bUSCS6ca/S6v
JOixGr+UTe6KuRX3Gl9vxRuS0q0jrge6ojijXuTfSvdAE9fTFyTtL8W2Xid/7kab
jRyKmbjdRpwHPDu0mbduBEakFzKdKOyjhrzVtZzw95gfYBrUd9M=
=b1S5
-----END PGP SIGNATURE-----

--------------57GrmDp3KY0vvxlRoSZ3CkCN--
