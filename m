Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5781348C5C
	for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2026 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784232912; cv=none; b=NaX+vI3EO89057i3XfFE02kyOOcy2ZmdGlWqxC8dWbGPE339tFhFi1QIlYLLnyZS5vpnM4F1RVHucYy+cKnsOcG6ncnberQH/X2lIzOj9a1gJ9DW6zIVOEgloCK2gUF6nSDVoAn1VVRSPpHFD9UURg3pGMJECBNVj5fBNFrE1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784232912; c=relaxed/simple;
	bh=8spo3j6W+8H0sPv+ALQUEJdJsCkkbN7yc3jeXC4j5RY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W31WV5ZWEdtr7yrL1rHJvqyjIA0whd8slwth1AbnchXnGqhCwWrJpkZoQJ52zWSpmVvRq9u+2I60zhKFb2610pJKfmt6GE06KzUeG7q9CrMKmKuKq6H+jxZxfLKbJgXdi0QKMf0SjtyiyA/r8fkTg8w4DQKkejsjJGG+kW/kZmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kengrimes.com; spf=pass smtp.mailfrom=kengrimes.com; dkim=pass (2048-bit key) header.d=kengrimes.com header.i=@kengrimes.com header.b=X+15YEN+; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kengrimes.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kengrimes.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kengrimes.com header.i=@kengrimes.com header.b="X+15YEN+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kengrimes.com;
	s=protonmail3; t=1784232898; x=1784492098;
	bh=hlIlaGIRAbsk4+mR01t1Wh0yZsocDwo9hxJdVdQSLEo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=X+15YEN+rQP+I9prMidFPLIkWfVSJYc94/Vmkktmy5THBZ8Bw20rPIwBhvh/EdKJF
	 fwtAHNmpFt6eF9jEOAHDz1gWTEiKmitrvRxpDvYnv9TfcTaQP61i8YW60BF1bNa3dk
	 GqUq+tWz9WOZ3w6wyA9ZBm/wACq7LgltbWR/H578FuiuQyW+n7tgbYek0XUnnd3Wea
	 Iv0LnS4LPwrtq7wFb4pp7P5aMOktwXsszI/B33zq8RqEy/7LBFCLTXwv5/MQwd9fKE
	 dbFrIMRleIJCStpTkltejWShYNFRXIyy03Ch9cJvtDiZZCqAh3FpZlLjRI4ygWHl0f
	 adLkWVWbtP6aA==
Date: Thu, 16 Jul 2026 20:14:55 +0000
To: =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
From: Ken Grimes <ken@kengrimes.com>
Cc: "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, landlock@lists.linux.dev
Subject: Re: [BUG] Landlock denies LANDLOCK_ACCESS_FS_EXECUTE despite a correctly-anchored PathBeneath rule (contradicts selftest layout1.execute)
Message-ID: <kDUhcqAqpOGRVoTEYarGa-jMnCbwREPlvCWcJ8gmPH7wZ8CHdDWEJ-nL8j0LnjiffeNtG9_kE0XjRsUZ-hHfXZA0m1zpdTofgNXTcqMqBRs=@kengrimes.com>
In-Reply-To: <20260716.eijohyi0ieZa@digikod.net>
References: <P8RYlSi7C7oum2lk1F3PumYSvaUyd0Sn_VwUYAcWwjbQxSt_Rau30Aa1oLIEnLZ2iafcsFmEG5C4LTeBWCyd9vCx94FYeTX_OJdHoERcWSI=@kengrimes.com> <aldGXyfBQz8GsAMn@google.com> <20260716.eijohyi0ieZa@digikod.net>
Feedback-ID: 26299838:user:proton
X-Pm-Message-ID: 1ba93b729c0aac8aae946e779a0858eb13a4c588
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------2f7f1da9d424bbe2d2614ee39d537deb578b41753b2512c4ba507b9bfce6f796"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------2f7f1da9d424bbe2d2614ee39d537deb578b41753b2512c4ba507b9bfce6f796
Content-Type: multipart/mixed;boundary=---------------------6df0a0c3e6879956554f423df853ee97

-----------------------6df0a0c3e6879956554f423df853ee97
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Thanks so much G=C3=BCnther & Micka=C3=ABl for the fast and thorough respo=
nses, it's very appreciated!

G=C3=BCnther, that's exactly what I found. I went down the path of 2; file=
-scoped LANDLOCK_ACCESS_FS_EXECUTE grant on dynamic loader, discovered at =
runtime since the loader's path varies across distros (/lib64/ld-linux-x86=
-64.so.2 here, but that's obviously not portable).

The fix resolves the target binary's PT_INTERP entry from ELF headers, the=
n runs the interpreter in its own --list mode (invoked in a privilege-drop=
ped, sandboxed child) to get the full shared-object closure. Not just the =
loader itself, but the DT_NEEDED dependencies (/etc/ld.so.cache and /etc/l=
d.so.preload) when present. I grant Execute|ReadFile on the interpreter an=
d ReadFile on everything else, each file-scoped instead of directory wide,=
 so not opening up all of /lib64. Just the files the loader will actually =
touch for the binary. I reproduced the failure standalone first (execveat =
under a single rule landlock domain, EACCESS, adding the loader's file as =
a second rule) before building the real fix, so I feel confident this is w=
hat you're describing.

Regarding the docs, yes please do add a note about this to LANDLOCK_ACCESS=
_FS_EXECUTE docs! That would have definitely saved a decent amount of effo=
rt, and I could see others running into the same issue.

Micka=C3=ABl, thank you! I hadn't looked into the audit log support closel=
y, I'll be sure to use this instead of building standalone reproductions, =
very helpful!

Thanks again for the help and all the great work you do.

-Ken


On Thursday, July 16th, 2026 at 2:37 AM, Micka=C3=ABl Sala=C3=BCn <mic@dig=
ikod.net> wrote:

> Hi!
> =


> You should also get a look at the audit logs:
> https://docs.kernel.org/admin-guide/LSM/landlock.html#audit
> =


>  Micka=C3=ABl
> =


> On Wed, Jul 15, 2026 at 10:39:29AM +0200, G=C3=BCnther Noack wrote:
> > Hello Ken!
> >
> > (Also adding landlock@lists.linux.dev to CC)
> >
> > On Tue, Jul 14, 2026 at 09:07:56PM +0000, Ken Grimes wrote:
> > > Hey all, this is my first bug report for linux. The issue was discov=
ered =


> > > alongside llm-assisted coding on a downstream project. The =


> > > investigation/testing of the bug was a mostly manual process so I co=
uld =


> > > be sure this was something real. Please let me know if I can provide=
 any
> > > further details or assistance. Hope this is helpful, thank you for a=
ll of your
> > > hard work!
> >
> > Welcome and thanks for reporting your first issue!
> >
> > I believe the issue you are observing is that the /bin/true program yo=
u are
> > starting is a dynamically linked executable.  As such, executing it re=
quires
> > both the LANDLOCK_ACCESS_FS_EXECUTE right on the binary itself and on
> > the system's dynamic loader binary, which usually lives in /lib/ld-lin=
ux.so.*
> > (but there are symlinks and 32/64-bit differences at play as well, whi=
ch
> > influence the actual final location).
> >
> > You can try this out with the following experiments:
> >
> > (1) Compile a "true" program statically and try using that:
> >
> >     $ echo 'int main() { return 0; }' > true.c
> >     $ CFLAGS=3D-static make true
> >
> >     This can be started with the test you have,
> >     unlike the dynamically linked version.
> >
> > (2) Alternatively, add execute permissions for the dynamic loader:
> >
> >     Add an additional "path beneath" rule that allow-lists the executi=
on
> >     access right on /lib/ld-linux.so.2, /lib64/ld-linux-x86-64.so.2 or
> >     wherever else your dynamic loader is.  (You can discover the actua=
l
> >     location using "ldd /bin/true".)
> >
> > With either one of these two changes, your standalone reproducer progr=
am
> > starts working again.  Or at least it does on my machine.  If it still=
 doesn't
> > work on your end that way, please let us know. :)
> >
> > I admit that we should probably point this out in the Landlock documen=
tation
> > for the LANDLOCK_ACCESS_FS_EXECUTE right, as dynamic linking is common=
 and it
> > is a potential issue that many people might run into.
> >
> > For background on the dynamic loading mechanism, see the man page ld.s=
o(8) [1]
> > and the LWN article "How programs get run: ELF binaries" [2] (specific=
ally the
> > section "Dynamically linked programs").
> >
> > =E2=80=94G=C3=BCnther
> >
> >
> > [1] https://man7.org/linux/man-pages/man8/ld.so.8.html
> > [2] https://lwn.net/Articles/631631/
> >
> >
> =


-----------------------6df0a0c3e6879956554f423df853ee97
Content-Type: application/pgp-keys; filename="publickey - ken@kengrimes.com - 0xEDFCC5BC.asc"; name="publickey - ken@kengrimes.com - 0xEDFCC5BC.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - ken@kengrimes.com - 0xEDFCC5BC.asc"; name="publickey - ken@kengrimes.com - 0xEDFCC5BC.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWDIvT0xSWUpLd1lCQkFI
YVJ3OEJBUWRBMGIwS2EwWlVWWEpSenNtNG05bFM5blZ0ODlhM1RKQjMKMU9yVEtSS3lKZ1hOSld0
bGJrQnJaVzVuY21sdFpYTXVZMjl0SUR4clpXNUFhMlZ1WjNKcGJXVnpMbU52CmJUN0Nqd1FRRmdv
QUlBVUNYMi9PTFFZTENRY0lBd0lFRlFnS0FnUVdBZ0VBQWhrQkFoc0RBaDRCQUNFSgpFRk0rYjdl
S1piZ2hGaUVFN2Z6RnZDc2Y0bURSTVBtNVV6NXZ0NHBsdUNGWE1BRCtPNGRCS2RoTGNVWFcKbGx0
eFp4MXNZNjFnRVVYNEVId0s1UUdHTjg4VHRjVUJBTU9qMDFQclcrZVI2dWhkZ3M4enlDZ1hTa2xl
CkVNVlplcDBMeTVMWUkwd1B6amdFWDIvT0xSSUtLd1lCQkFHWFZRRUZBUUVIUUxvU2ptbG10Z01j
akFMUwpLMWE5OEZnWURzRDloK3B0SFBNM05XNmFiaUI3QXdFSUI4SjRCQmdXQ0FBSkJRSmZiODR0
QWhzTUFDRUoKRUZNK2I3ZUtaYmdoRmlFRTdmekZ2Q3NmNG1EUk1QbTVVejV2dDRwbHVDRlR5QUQv
UUlvbC9nVUJjZXBlCkVHdjJnZXd3L0hmV0tYY2d2K2VLZ3dib0YvRFpuc2tBLzN0cm56V201QzBp
S3ovajdJRzFwUFNpZmJKcwp3QzZGR1FxOE80ZVlvSHdGCj1GRlVoCi0tLS0tRU5EIFBHUCBQVUJM
SUMgS0VZIEJMT0NLLS0tLS0K
-----------------------6df0a0c3e6879956554f423df853ee97--

--------2f7f1da9d424bbe2d2614ee39d537deb578b41753b2512c4ba507b9bfce6f796
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmpZO7AJEFM+b7eKZbghRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfHBPla/wGR38Zz0/z8o0ubXOCA8FyEEIt8d9ev
xSZG1xYhBO38xbwrH+Jg0TD5uVM+b7eKZbghAAAAUAD/XxwdjhG0BpoVfIJI
OmctLe3mZcntuysNS0eKySqk0z4A/R594kkkoCz+8KYGBZoxosUfTY9VO2xJ
09S5cfd56TQK
=klzG
-----END PGP SIGNATURE-----


--------2f7f1da9d424bbe2d2614ee39d537deb578b41753b2512c4ba507b9bfce6f796--

