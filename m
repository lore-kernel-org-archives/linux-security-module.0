Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED768635D
	for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 04:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765687769; cv=none; b=VJBMtwK3Xtt829Y9LcnvlvJldGahy3YaQFFeUsBPgwQB5k6+GtATuGhXElE5Kjst7XniCdTcGBcg8P7gx81f6WzFFYYBhJvvDX4H52dKjUnV4p/7sVpf4rvz5HQMJxP19NU079P/bwro1LiLjGielNZXMMW/LWMCUNYHY0o/X2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765687769; c=relaxed/simple;
	bh=y5FFYprltUF+OvWrjePkVkXcFN6Psq/w4pnWNB+4UuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfwKgIpDNJLUuEWx76C1pMdPwzxLxSjyc7UhyVEiCh2vESXxyOh3qteybdjb4EZ8fssYVHSdSf41gFbQq1ZWbXjsoyI10eTY20UTlOEEINkrJYrS8n4NwbekKbz1L1m6hfT//vW2iu+5pK8l+uIUuM3XFnFDHNp+XCdA1wcjUpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSuhaKWs; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSuhaKWs"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64472ea7d18so2032640d50.2
        for <linux-security-module@vger.kernel.org>; Sat, 13 Dec 2025 20:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765687766; x=1766292566; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kovqurx8TRVD00UOfRcLmzO46S67fpo+ZDSjM3CEdO8=;
        b=SSuhaKWsK/Dt1rmoVQ1cDuKl5JTRpUQBOUtHI8xHRxRHlkQpAIl8Q3/Ge6DTu/QN+Q
         wmgqxxK85wNJuQiZ74K7D2aUb+/EhX1oxhN9c7TKvgjbczEZeFP1UzyVvGqe1Oz+h8SS
         B2xwVrs+JVpTxMhq5ljn9ZtHsmNAu0FKI/23GqRn/nBas3szDBYiYdCz4046ZJuKupl1
         QlkLOOKb5cDRFuU6k6V20BR7sMJqHJ3m/UBd6ABHC8+aYexXB+t0o76VYH2KWrKUJ8g7
         ekhu7tH1jXpOaVVsbhtbf8r9p2gm3xq6vWhPVQS+lmhAM9jdxRYsewhnuDY3s52pFsB1
         jXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765687766; x=1766292566;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kovqurx8TRVD00UOfRcLmzO46S67fpo+ZDSjM3CEdO8=;
        b=lmReNYcAJNoYG6pU/Bcucj7fLSebgWOfvCk+TXFxhthIvxzKehbVODGP48BoXD09Q9
         kz33uZD+hl8sxIjPmHFgFsq4UsUtEs0xplWsmn5Jlny+vVJt0/bmYo6V4ixaNp/FrGnZ
         WTSvSDolLGv7EbCTXFMCEqh4P7/uvSAlc4sd7uEJtg7LQayjpkuNenREbs5Zf2aqKXoL
         hxUQn24UwMjDRS7Shrd05X5F8AV4ZK8lx1ym58VDtc6H0gdcREy58LqEDWbxPvvBae+J
         oROgaQtzfoCUXr4oSxYbzkaglHZMzUgpheUfyQw0lpr/MaDc15v3zezpfiD3A014Cc3M
         9ndQ==
X-Forwarded-Encrypted: i=1; AJvYcCV81KdaZnP7o/9fMMZg4s3Ss+ESIY3K1Q0W8JQY8oJJ3eHiiCfge67VUVm8P5siKB5q13XBeHzk92zSeUEe7d0S1MdGySs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRdLSUOrCYpkJuk1FqqLiemXd7tf8CL+wBOuPT/VEOiDux71Z
	jG5/sbd2uUoCGRPtyVZcdSvgLtpPQJTCaodqQA7ohN4uPGXkNAA/PVvIsX3/NA==
X-Gm-Gg: AY/fxX7ePRjTcfHaafyPi4mPEbEReXYtDHUq6MiSB9ExZVVNH6Ssmg1daapiDOdVhKN
	aZpTxDfkfp8yotZUecD5wBz5ybSrNC4q/wr/n4buT88Qy5ZvZ00CsLtIvfldWcb77ISPrVRLV+2
	SwiFtkE/c9ClXx558w+iJqaozrbVp+dMHdL8lGFUvlylpiKsNGE6LSgjVfdte3s7ayHB2CqDt+Z
	q8mbx129FqB6XS9uybIXoTFZL6KlSCP5cgUPSRI0lU7xkt6Hm/44OyQaamPqcLIPIabDOSMMhBT
	ksZkRGXeu18anN1eiFhowi2gc0Hco4tBkJ7LxHMDdgg5iOY3HstthKgVsHptCpt/f2p/svtOt3D
	6MXmfR5eV17BBPGuWtrDu8aS83dUTfgWxQf26Mc5mkdJAGR/oYZSDmJBPB6zc0/qcGVbPLayOSk
	IVNU+mK+Z06zrAruZKxyzreZTlTbO30vvjrm72OOi+7B9ylIvrCucOM/Z9Ut65XFr/3xz2bolk2
	ADF43ZOMhBZZVf3vuEO7ZvQI6g=
X-Google-Smtp-Source: AGHT+IEZBWHSkkIkmFfbv0NDquoweS08lF5xjGzEvKT8K6s9G1IZmT+hLPKJ3v/K3h8pa1zGmn6GtQ==
X-Received: by 2002:a05:690e:1384:b0:645:561a:4c68 with SMTP id 956f58d0204a3-645561a6017mr4763070d50.66.1765687766006;
        Sat, 13 Dec 2025 20:49:26 -0800 (PST)
Received: from [10.138.34.110] (h96-60-249-169.cncrtn.broadband.dynamic.tds.net. [96.60.249.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e748cf925sm14892187b3.5.2025.12.13.20.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Dec 2025 20:49:24 -0800 (PST)
Message-ID: <515ff0f4-2ab3-46de-8d1e-5c66a93c6ede@gmail.com>
Date: Sat, 13 Dec 2025 23:49:11 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] host/roots: Sandbox xdg-desktop-portal-spectrum-host
To: Alyssa Ross <hi@alyssa.is>
Cc: Spectrum OS Development <devel@spectrum-os.org>,
 linux-security-module@vger.kernel.org, landlock@lists.linux.dev
References: <20251212-sandbox-dbus-portal-v1-1-522705202482@gmail.com>
 <87o6o25h6y.fsf@alyssa.is> <cfab1f24-65ad-40ed-b4a6-17f0aad8dc60@gmail.com>
 <87ikea5a8x.fsf@alyssa.is> <00256266-26db-40cf-8f5b-f7c7064084c2@gmail.com>
 <87bjk16dvv.fsf@alyssa.is>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <87bjk16dvv.fsf@alyssa.is>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------m8n0NMK70z0x3RVPvu4JGtmT"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------m8n0NMK70z0x3RVPvu4JGtmT
Content-Type: multipart/mixed; boundary="------------RP4tHxvams4AaeuN0DEh16d0";
 protected-headers="v1"
Message-ID: <515ff0f4-2ab3-46de-8d1e-5c66a93c6ede@gmail.com>
Date: Sat, 13 Dec 2025 23:49:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] host/roots: Sandbox xdg-desktop-portal-spectrum-host
To: Alyssa Ross <hi@alyssa.is>
Cc: Spectrum OS Development <devel@spectrum-os.org>,
 linux-security-module@vger.kernel.org, landlock@lists.linux.dev
References: <20251212-sandbox-dbus-portal-v1-1-522705202482@gmail.com>
 <87o6o25h6y.fsf@alyssa.is> <cfab1f24-65ad-40ed-b4a6-17f0aad8dc60@gmail.com>
 <87ikea5a8x.fsf@alyssa.is> <00256266-26db-40cf-8f5b-f7c7064084c2@gmail.com>
 <87bjk16dvv.fsf@alyssa.is>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <87bjk16dvv.fsf@alyssa.is>
Autocrypt-Gossip: addr=hi@alyssa.is; keydata=
 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
 wGxvGU7TX5ou

--------------RP4tHxvams4AaeuN0DEh16d0
Content-Type: multipart/mixed; boundary="------------cJwWLEvHFq3O20fjKZwiVtxs"

--------------cJwWLEvHFq3O20fjKZwiVtxs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/13/25 20:39, Alyssa Ross wrote:
> Demi Marie Obenour <demiobenour@gmail.com> writes:
>=20
>> On 12/13/25 16:42, Alyssa Ross wrote:
>>> Demi Marie Obenour <demiobenour@gmail.com> writes:
>>>
>>>> On 12/13/25 14:12, Alyssa Ross wrote:
>>>>> Demi Marie Obenour <demiobenour@gmail.com> writes:
>>>>>
>>>>>> It is quite possible that these Landlock rules are unnecessarily
>>>>>> permissive, but all of the paths to which read and execute access =
is
>>>>>> granted are part of the root filesystem and therefore assumed to b=
e
>>>>>> public knowledge.  Removing access from any of them would only inc=
rease
>>>>>> the risk of accidental breakage in the future, and would not provi=
de any
>>>>>> security improvements.  seccomp *could* provide some improvements,=
 but
>>>>>> the effort needed is too high for now.
>>>>>>
>>>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
>>>>>> ---
>>>>>>  .../template/data/service/xdg-desktop-portal-spectrum-host/run   =
 | 8 ++++++++
>>>>>>  1 file changed, 8 insertions(+)
>>>>>
>>>>> Are you sure this is working as intended?  There's no rule allowing=

>>>>> access to Cloud Hypervisor's VSOCK socket, and yet it still seems t=
o be
>>>>> able to access that.  Don't you need to set a rule that *restricts*=

>>>>> filesystem access and then add holes?  Did you ever see this deny
>>>>> anything?
>>>>
>>>> 'man 1 setpriv' states that '--landlock-access fs' blocks all
>>>> filesystem access unless a subsequent --landlock-rule permits it.
>>>> I tried running with no --landlock-rule flags and the execve of
>>>> xdg-desktop-portal-spectrum-host failed as expected.
>>>>
>>>> The socket is passed over stdin, and I'm pretty sure Landlock
>>>> doesn't restrict using an already-open file descriptor.
>>>> xdg-desktop-portal-spectrum-host does need to find the path to the
>>>> socket, but I don't think it ever accesses that path.
>>>
>>> I've been looking into this a bit myself, and from what I can tell
>>> Landlock just doesn't restrict connecting to sockets at all, even if
>>> they're inside directories that would otherwise be inaccessible.  It'=
s
>>> able to connect to both Cloud Hypervisor's VSOCK socket and the D-Bus=

>>> socket even with a maximally restrictive landlock rule.  So you were
>>> right after all, sorry!
>>
>> That's not good at all!  It's a trivial sandbox escape in so many case=
s.
>> For instance, with access to D-Bus I can just call `systemd-run`.
>>
>> I'm CCing the Landlock and LSM mailing lists because if you are
>> correct, then this is a bad security hole.
>=20
> I don't find it that surprising given the way landlock works.  "connect=
"
> (to a non-abstract AF_UNIX socket) is not an operation there's a
> landlock action for, and it's not like the other actions care about
> access to parent directories and the like =E2=80=94 I was able to execu=
te a
> program via a symlink after only giving access to the symlink's target,=

> without any access to the directory containing the symlink or the
> symlink itself, for example.  Landlock, as I understand it, is intended=

> to block a specified set of operations (on particular file hierarchies)=
,
> rather than to completely prevent access to those hierarchies like
> permissions or mount namespaces could, so the lack of a way to block
> connecting to a socket is more of a missing feature than a security
> hole.

'man 7 unix' states:

On  Linux,  connecting to a stream socket object requires write
permission on that socket; sending a datagram to a datagram socket
likewise requires write permission on that socket.

Landlock is definitely being inconsistent with DAC here.  Also, this
allows real-world sandbox breakouts.  On systemd systems, the simplest
way to escape is to use systemd-run to execute arbitrary commands.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------cJwWLEvHFq3O20fjKZwiVtxs
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

--------------cJwWLEvHFq3O20fjKZwiVtxs--

--------------RP4tHxvams4AaeuN0DEh16d0--

--------------m8n0NMK70z0x3RVPvu4JGtmT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmk+QcgACgkQszaHOrMp
8lPL/A/8DJol6y/8TJbPZj5eqdI5koWOZeBwvuf6YoFkLAj4ME6rO+h/M3OJa2Pt
q/IDZxyaeH7pGdt+ChSzhWc4NgsUz3DOeYlAikkRsotZBafVJ8HnuEc1bE7QbNIr
VXasUXn0iMOI9dROYRiobC1WZ+x9Wp2VIDbVsCNKs/N2wlhnF5zS1nz7MHqV4kyE
jyMvnG4bPYZ9gBp0nfDTcOOG0+7plq8xrKk+JPCW9Ne2lju9LLgYGGqB3Fp+WHy+
tbPZCApKF1JOwiUF7hzQ9XO3qHv3zYxt+Q3R9lwskYQE9CcdVCfuvt+wAW56YhFr
ap6FKMpRBGujJiv1gV5DMUbR8KyPFGBd6aed0TfIhW9aZK1bs0/SzuSssvGi7hnL
2dXwcJ4xNXgtVMfl2vgO78xogZh+2DKKgK5ADysWP19lZ8sIoV2E4nsnF09ZRu2y
BSqhT5Uha18iwtMb4dS13YiPJIP7sSB0F7MSxAvRzdY0jbtVqqBywWzWIEZMcawK
qHslzliHSvLm1jbfMnuxCi0Eys59c5Jf/fNEzk95SMDNNwhMs8haZkRO6WTh7vor
srUVoJ32e8M9vBd2j9JRSeWWz12Vqkt2OEd8SS30x9TuJTY1hhidG1rGgoN1ZImW
p/qLjtakwFgCexaFV63lbCGLcHJYsdgoJ9aJGw8DNWCd+KpfolY=
=qNK7
-----END PGP SIGNATURE-----

--------------m8n0NMK70z0x3RVPvu4JGtmT--
