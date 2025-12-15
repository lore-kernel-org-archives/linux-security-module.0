Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB3327BE0
	for <linux-security-module@vger.kernel.org>; Mon, 15 Dec 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788873; cv=none; b=aN2AaeQGnwDOioPkI8t7IN05MmN3CqZVoJnexeTpZfDtR15lXtBulxasTdnjcJ6wZkqM3bKuyqrhBaKmfxqdBOiI1loXt1pXXtqJrF24SLFtYsZMlkM7tUfbLCA5/gfAwAN7wNRzG50evNWAQvHW7L/uR16RXBYbbodmzCdaDRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788873; c=relaxed/simple;
	bh=i/zLR4pok9uwhVD09koPxt0jOQZxQYDRp87xvil4O+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pu+Gfa87fR2ezVTQWbq/34vh5rcy6BiU2N6vCLTXZZLO4Gd6P5NX+2yeLon/XAv6FK4r+jBa1kSSs07QU2KtPB7HJzl8/7CfayI6s2zP2S0DRIudF6js9SapK08R1CzcRS7W5gXAd+M1qjbgDHOOIYFyMBlfpdht4nYgJbFfys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgY5MTK5; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgY5MTK5"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-644715aad1aso3526755d50.0
        for <linux-security-module@vger.kernel.org>; Mon, 15 Dec 2025 00:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765788870; x=1766393670; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kUj0b71wdn+toXypF7TnMUC/jWlKHJftUM5n/ytAVQA=;
        b=fgY5MTK5iVJxZsEPhAF5YEBRxeGrKVrVdjrmpOa567dnyExFFnL+aKm0+8bUxuVgA9
         SPA9qjv0TWw9I9tiMQ1AEy/6Q08HyZ28W1rnVCrRQPKcDdgo/gnItp8Zs15RZ0AKO1AM
         cRWSYw3vK8vecd+EECebC6LSsaWvVG9Gi4I/D4CuWZZwwl3ErlM12j+UD/EwuqSDS6kM
         +GzNY4Fb0DT44DBc6OapW7PzWZey77Ej9sWuUT1w7zsbUhxiggh1957ia9B9IfNDPWrz
         DpVSlA5jiTFq+h5bizYdrmoVG+Nd7NxjnsAaac2zBhX4XInVMncP2TNJSMTt/Rygoz/z
         n2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765788870; x=1766393670;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUj0b71wdn+toXypF7TnMUC/jWlKHJftUM5n/ytAVQA=;
        b=OREIOOF+2mpMjUXuiGzvlhfnp3L66W6k+vfO9FH30tez5kdiVCWSMCvUhv+3eGFcSa
         1h7PqH+LsvxczKXVgrR9iSkrNdB61t2HKdLI8aEGnPUR6dG6Vk090axupUH+5va9bzvt
         vwArczZkGlYbpF1TbjzKu2Qy6AOq+XRV5g/0ACPso7rWK55i5LANvoSzCy30mSsZyFiO
         6uNtfbqADsE35TiAyW3rBuGQOstVUxbg/h3VQDlhR6bxR95TAWedLSjuchPO/pMv1pZp
         OimYefQ1nnHnjS+6E/L1KM09Hni5n74OWYUGGCQxCeRG4KoHG/2XL/kRCExRY4ZJ/u10
         AjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD8wQTOzh7irubs0z8HP0TYyWz+l0A1AQrbT131A1pyqb1RZYnzyO9oUBIalKrBX9VVUdSIsuI0EeEvNwi9WoCk5Z/XBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNLTKrxfMzL0AaA05SBbg+V/rts+mx4Em0a5GXIDNAqYLIgcag
	LubMNauhoAweqmTMe4e1/eqiakGqqYNmZhySf2Oe09Slj+UufYZWmdyq
X-Gm-Gg: AY/fxX7hjClzWgJuba0K2Yi5msMrRj1yfEf5VCGlAUmxG7O3/rVjDmqZKJwCj6j8Izb
	Yr4aNDHW8qrOgM25FsebRaGllylDFFZ7y9mBc10DuiAoZUtvTM68Dmxsn2Dw5LsZBizypnyyb0s
	phoPPoBYN3tQaKFbxewFxDCOlKbK+Q/u+9sGNdc2tjZpt9M8TGQPLhDgcyMI5W8KnW5Xtp/Yl3U
	FkW7ga8HD8fggBReLMp6tLA25hGxy4xYSsKIyz37pKmoYHyKmAt6k1RfLAafF5z2n/wJ/q341lj
	66SIekWdU98QYoo4+kK5dbKR+wj1/xnNQESLUcH2gxS2N4E8eO6FA9vINRQn6EvOnsPltrlTeZ3
	1KIVF4kvhbqZYRFdOVEwJpkKCMBPcaJcoFhQLchzq9eutZ4cITeW3Nyjigs1YUL5mjn4OkPhAH7
	K0TSccz+MijPfLQzFpsWC2VKNUwKc9XiNlwM01TG5Wu9vH+nAZuMOElbHr49vnIWeeQA+xoHLHw
	yfBn3IdnDbJWxEzYRCaDezt29t0t3PUWh0n9Q==
X-Google-Smtp-Source: AGHT+IGsSflo3WVMyuOYkBLhRHpxlIbSMMwxQuNLr9TRwrcHtDtBiNeieC+9pNNXm28ADcDmWJJ78w==
X-Received: by 2002:a05:690e:d4c:b0:645:53eb:a108 with SMTP id 956f58d0204a3-64555155acemr6172878d50.12.1765788869571;
        Mon, 15 Dec 2025 00:54:29 -0800 (PST)
Received: from [10.138.34.110] (h96-60-249-169.cncrtn.broadband.dynamic.tds.net. [96.60.249.169])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477dc65ffsm6132690d50.24.2025.12.15.00.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 00:54:28 -0800 (PST)
Message-ID: <2a681b48-bc6e-4257-8e0f-3b6aff25ac67@gmail.com>
Date: Mon, 15 Dec 2025 03:54:25 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] host/roots: Sandbox xdg-desktop-portal-spectrum-host
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Alyssa Ross <hi@alyssa.is>,
 Spectrum OS Development <devel@spectrum-os.org>,
 linux-security-module@vger.kernel.org, landlock@lists.linux.dev,
 "Ryan B. Sullivan" <ryanbakersullivan@gmail.com>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
References: <20251212-sandbox-dbus-portal-v1-1-522705202482@gmail.com>
 <87o6o25h6y.fsf@alyssa.is> <cfab1f24-65ad-40ed-b4a6-17f0aad8dc60@gmail.com>
 <87ikea5a8x.fsf@alyssa.is> <00256266-26db-40cf-8f5b-f7c7064084c2@gmail.com>
 <87bjk16dvv.fsf@alyssa.is> <515ff0f4-2ab3-46de-8d1e-5c66a93c6ede@gmail.com>
 <20251214.aiW5oc2izaxa@digikod.net> <20251215.5d7e473daa34@gnoack.org>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20251215.5d7e473daa34@gnoack.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TaCMJhSngKc506qOlnu2rm6y"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------TaCMJhSngKc506qOlnu2rm6y
Content-Type: multipart/mixed; boundary="------------GJezn7UIxTUrDEW2e32DP9r1";
 protected-headers="v1"
Message-ID: <2a681b48-bc6e-4257-8e0f-3b6aff25ac67@gmail.com>
Date: Mon, 15 Dec 2025 03:54:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] host/roots: Sandbox xdg-desktop-portal-spectrum-host
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Alyssa Ross <hi@alyssa.is>,
 Spectrum OS Development <devel@spectrum-os.org>,
 linux-security-module@vger.kernel.org, landlock@lists.linux.dev,
 "Ryan B. Sullivan" <ryanbakersullivan@gmail.com>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
References: <20251212-sandbox-dbus-portal-v1-1-522705202482@gmail.com>
 <87o6o25h6y.fsf@alyssa.is> <cfab1f24-65ad-40ed-b4a6-17f0aad8dc60@gmail.com>
 <87ikea5a8x.fsf@alyssa.is> <00256266-26db-40cf-8f5b-f7c7064084c2@gmail.com>
 <87bjk16dvv.fsf@alyssa.is> <515ff0f4-2ab3-46de-8d1e-5c66a93c6ede@gmail.com>
 <20251214.aiW5oc2izaxa@digikod.net> <20251215.5d7e473daa34@gnoack.org>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20251215.5d7e473daa34@gnoack.org>
Autocrypt-Gossip: addr=hi@alyssa.is; keydata=
 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
 wGxvGU7TX5ou

--------------GJezn7UIxTUrDEW2e32DP9r1
Content-Type: multipart/mixed; boundary="------------ZSwy0OuoG8TfUASMiPb88TWQ"

--------------ZSwy0OuoG8TfUASMiPb88TWQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/15/25 03:20, G=C3=BCnther Noack wrote:
> On Sun, Dec 14, 2025 at 08:50:45PM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
>> On Sat, Dec 13, 2025 at 11:49:11PM -0500, Demi Marie Obenour wrote:
>>> On 12/13/25 20:39, Alyssa Ross wrote:
>>>> Demi Marie Obenour <demiobenour@gmail.com> writes:
>>>>
>>>>> On 12/13/25 16:42, Alyssa Ross wrote:
>>>>>> Demi Marie Obenour <demiobenour@gmail.com> writes:
>>>>>>
>>>>>>> On 12/13/25 14:12, Alyssa Ross wrote:
>>>>>>>> Demi Marie Obenour <demiobenour@gmail.com> writes:
>>>>>>>>
>>>>>>>>> It is quite possible that these Landlock rules are unnecessaril=
y
>>>>>>>>> permissive, but all of the paths to which read and execute acce=
ss is
>>>>>>>>> granted are part of the root filesystem and therefore assumed t=
o be
>>>>>>>>> public knowledge.  Removing access from any of them would only =
increase
>>>>>>>>> the risk of accidental breakage in the future, and would not pr=
ovide any
>>>>>>>>> security improvements.  seccomp *could* provide some improvemen=
ts, but
>>>>>>>>> the effort needed is too high for now.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
>>>>>>>>> ---
>>>>>>>>>  .../template/data/service/xdg-desktop-portal-spectrum-host/run=
    | 8 ++++++++
>>>>>>>>>  1 file changed, 8 insertions(+)
>>>>>>>>
>>>>>>>> Are you sure this is working as intended?  There's no rule allow=
ing
>>>>>>>> access to Cloud Hypervisor's VSOCK socket, and yet it still seem=
s to be
>>>>>>>> able to access that.  Don't you need to set a rule that *restric=
ts*
>>>>>>>> filesystem access and then add holes?  Did you ever see this den=
y
>>>>>>>> anything?
>>>>>>>
>>>>>>> 'man 1 setpriv' states that '--landlock-access fs' blocks all
>>>>>>> filesystem access unless a subsequent --landlock-rule permits it.=

>>>>>>> I tried running with no --landlock-rule flags and the execve of
>>>>>>> xdg-desktop-portal-spectrum-host failed as expected.
>>>>>>>
>>>>>>> The socket is passed over stdin, and I'm pretty sure Landlock
>>>>>>> doesn't restrict using an already-open file descriptor.
>>>>>>> xdg-desktop-portal-spectrum-host does need to find the path to th=
e
>>>>>>> socket, but I don't think it ever accesses that path.
>>>>>>
>>>>>> I've been looking into this a bit myself, and from what I can tell=

>>>>>> Landlock just doesn't restrict connecting to sockets at all, even =
if
>>>>>> they're inside directories that would otherwise be inaccessible.  =
It's
>>>>>> able to connect to both Cloud Hypervisor's VSOCK socket and the D-=
Bus
>>>>>> socket even with a maximally restrictive landlock rule.  So you we=
re
>>>>>> right after all, sorry!
>>>>>
>>>>> That's not good at all!  It's a trivial sandbox escape in so many c=
ases.
>>>>> For instance, with access to D-Bus I can just call `systemd-run`.
>>>>>
>>>>> I'm CCing the Landlock and LSM mailing lists because if you are
>>>>> correct, then this is a bad security hole.
>>>>
>>>> I don't find it that surprising given the way landlock works.  "conn=
ect"
>>>> (to a non-abstract AF_UNIX socket) is not an operation there's a
>>>> landlock action for, and it's not like the other actions care about
>>>> access to parent directories and the like =E2=80=94 I was able to ex=
ecute a
>>>> program via a symlink after only giving access to the symlink's targ=
et,
>>>> without any access to the directory containing the symlink or the
>>>> symlink itself, for example.  Landlock, as I understand it, is inten=
ded
>>>> to block a specified set of operations (on particular file hierarchi=
es),
>>>> rather than to completely prevent access to those hierarchies like
>>>> permissions or mount namespaces could, so the lack of a way to block=

>>>> connecting to a socket is more of a missing feature than a security
>>>> hole.
>>>
>>> 'man 7 unix' states:
>>>
>>> On  Linux,  connecting to a stream socket object requires write
>>> permission on that socket; sending a datagram to a datagram socket
>>> likewise requires write permission on that socket.
>>>
>>> Landlock is definitely being inconsistent with DAC here.  Also, this
>>> allows real-world sandbox breakouts.  On systemd systems, the simples=
t
>>> way to escape is to use systemd-run to execute arbitrary commands.
>>
>> The Linux kernel is complex and the link between the VFS and named UNI=
X
>> sockets is "special" (see the linked GitHub issue).  Landlock doesn't
>> handle named UNIX sockets yet for the same reason it doesn't handle so=
me
>> other kind of kernel resources or access rights: someone needs to
>> implement it (including tests, doc...).  There is definitely interest =
to
>> add this feature, it has been discussed for some time, but it's not
>> trivial.  It is a work in progress though:
>> https://github.com/landlock-lsm/linux/issues/36
>=20
> Agreed, this would be the change that would let us restrict connect()
> on AF_UNIX sockets.
>=20
> Additionally, *in the case that you do not actually need* Unix
> sockets, the other patch set that would be of interest is the one for
> restricting the creation of new socket FDs:
> https://github.com/landlock-lsm/linux/issues/6
>=20
> In this talk in 2014, I explained my mental model around the
> network-related restrictions:
> https://youtu.be/K2onopkMhuM?si=3DLCObEX6HhGdzPnks&t=3D2030
>=20
> The discussed socket control feature continues to be a central missing
> piece, as the TCP port restrictions do not make much sense as long as
> you can still create sockets for other protocol types.
>=20
> Issue #6 that should fix this is still under active development -- an
> updated version of the patch was posted just last month.
>=20
> To bridge the gap, the same thing can also be emulated with seccomp,
> but as you noted above as well in this thread, this is harder.
>=20
> =E2=80=93G=C3=BCnther

I'm a bit surprised that this needs to be separate from other access
controls.  To me, it seems like a bit of a misdesign in the core kernel
(not Landlock).

I would go as far as to state that enabling other filesystem
restrictions should also restrict AF_UNIX filesystem sockets
automatically, as that is what users and administrators will expect.

What surprises me somewhat is that Linux does not have any sort of
unified hook for filesystem path walks.  My mental model of Landlock
is that from a filesystem perspective, the result should be equivalent
to creating an empty mount namespace, putting a tmpfs on its root,
and bind-mounting the allowed paths.  That this mental model does
not match reality was quite surprising.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------ZSwy0OuoG8TfUASMiPb88TWQ
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
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
EtJuZYM5blWncBOJCoWMnBEcTEo/viU3GgcVRw=3D=3D
=3Dx94R
-----END PGP PUBLIC KEY BLOCK-----

--------------ZSwy0OuoG8TfUASMiPb88TWQ--

--------------GJezn7UIxTUrDEW2e32DP9r1--

--------------TaCMJhSngKc506qOlnu2rm6y
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmk/zMIACgkQszaHOrMp
8lMb9g//fR2NReVC5p9rmePAcAfkr5khs9M8ZfSyua7Pfzxlp/N1fHVTewjfFW73
AvL5lk7c35aDSgI9woe2Np2pIk5PXaKfr/2Vt77p75EaFbh1k2u1GwLaWJwrPozK
rzuO39zzYbPu+wRX7vsLnLD7gYczBbVprv6AXOBHQtTdAkG5aTrw3A2CJmoXoOwH
0codM2ZT+AZ31uuzKS97Dnn9jhAiu1ljrdusdhD9Jz6aQKypattCiFgqcLfmBKIi
zfjvKvb0uys9wz4D9N+Bn36eyealtkj6RZyPo90ZuuFLVhjnZ8C+GiNmwRWr0rxz
TGJ+5pf+rSSeBWTlGkQnP8JDCDK+c8zP/JP7yDp7B6SvE610gORZWhgHIyQtnRUu
VdARtvyD92I59rDuo3YudusYO2eosuU0pbBWGsrH3OwQ7Q2Jem7XzpNzJGmHj8Zm
+6c5QIjV45nlAzlHCerBVp9OhNKEMqKtID3OILUtxCG1yjmikxtiM5/lcs0N/bM1
x0JyUfqq9c6YZ44GFvY5K6ZMaiIfycZCC/VxqfHO0jbBnltYvo4NeKsHvNIoJswg
w6lmpXuvvE+DTu8A4IMpNishmr8ED24h51z31/WqeuZjnJp5xjq6FM1WfdrJP/lE
Yb5ezYXa4MYDMM1j1I4W1EcZZA0q4hJge/WMuVw5qBI/dqG6TPs=
=iON/
-----END PGP SIGNATURE-----

--------------TaCMJhSngKc506qOlnu2rm6y--
