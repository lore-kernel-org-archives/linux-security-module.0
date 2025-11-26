Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34380218845;
	Wed, 26 Nov 2025 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153908; cv=none; b=YAv770n1iWu5p3rD4WSQiKoX5H/ftzjZyuyv7BrtGR3Lo9Iqq9ZDvXI4Zo+SDBvy5D7gA0/iskH4UgPE2fjSvlkMQDTMr+c14zZQpY9O+E3BklouSxDe7c0h/W8DLEvTt49ey+OgITzXyLoohdZzFYvnE97QeL/tiwqaJdeF0lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153908; c=relaxed/simple;
	bh=4bHyPoD6r2OckPluYnKKCyuqQhr325xq6d2ITJ5UuGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCQ+0Hh1hN/j8Zhfa99dZ887dmjnS6dC0l1azhChZD+lG+NcfFGwA54OPggsr7arRbbR4x3ckHkxq41rl1Otjm0vSFgEDF8pLxolhAE/s/kw3HFeBzAt9rRzEdF6piOyhod8K6qTd+l+sEAD9uGBn+Dg85Mu1YzedwdcSaYLs9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=Lpd/Ahye; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="Lpd/Ahye"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vOD15-0091Yd-Mr; Wed, 26 Nov 2025 11:44:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=U/xvI1xLbuLlvE4jYxbpBDb27Nvo1HmhkhQP+8TuKx0=; b=Lpd/AhyeYDp4BJBBszRVfLVlAi
	+LlvQKSgo5YaXmHNviFpNJISdpvgHLuiW5SFULV4WhWoTzKrWeDZK12eyNUq2CuDXQ8FGaBzY3m3Z
	UxXg30PWWRhX06ie/Di6IZYGAAXJu4yPFXr7FPlsV4LHATePBTrMj76ghaVX+AAk9bqtthe7Aos0s
	JW7gthsvpzJLpJoGorQ/zuxYWgagy4pNaS+62hDPpty+4LaqoZha1zjw037Kd1UOyJdwqEZjxHdUz
	KdZWUjcYcpUvJ1+HpqwaxrOWKE4IGpJJo+/h3OfkWg6poPdzyUTAbGX4CAe0vOq7KF1zHTgQamtei
	lbnmxh2g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vOD14-000801-RP; Wed, 26 Nov 2025 11:44:54 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vOD10-00DR7D-9A; Wed, 26 Nov 2025 11:44:50 +0100
Date: Wed, 26 Nov 2025 10:44:44 +0000
From: david laight <david.laight@runbox.com>
To: John Johansen <john.johansen@canonical.com>
Cc: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>, John
 Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
Message-ID: <20251126104444.29002552@pumpkin>
In-Reply-To: <d35010b3-7d07-488c-b5a4-a13380d0ef7c@canonical.com>
References: <20250531150822.135803-1-deller@kernel.org>
	<bc21bee14ca44077ae9323bfc251ad12390fa841.camel@physik.fu-berlin.de>
	<aRxT78fdN5v2Ajyl@p100>
	<90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
	<be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
	<ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com>
	<aSXHCyH_rS-c5BgP@p100>
	<e88c32c2-fb18-4f3e-9ec2-a749695aaf0a@canonical.com>
	<c192140a-0575-41e9-8895-6c8257ce4682@gmx.de>
	<d35010b3-7d07-488c-b5a4-a13380d0ef7c@canonical.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Nov 2025 01:11:45 -0800
John Johansen <john.johansen@canonical.com> wrote:

> On 11/25/25 13:13, Helge Deller wrote:
> > On 11/25/25 20:20, John Johansen wrote: =20
> >> On 11/25/25 07:11, Helge Deller wrote: =20
> >>> * John Johansen <john.johansen@canonical.com>: =20
> >>>> On 11/18/25 04:49, Helge Deller wrote: =20
> >>>>> Hi Adrian,
> >>>>>
> >>>>> On 11/18/25 12:43, John Paul Adrian Glaubitz wrote: =20
> >>>>>> On Tue, 2025-11-18 at 12:09 +0100, Helge Deller wrote: =20
> >>>>>>> My patch fixed two call sites, but I suspect you see another call=
 site which
> >>>>>>> hasn't been fixed yet.
> >>>>>>>
> >>>>>>> Can you try attached patch? It might indicate the caller of the f=
unction and
> >>>>>>> maybe prints the struct name/address which isn't aligned.
> >>>>>>>
> >>>>>>> Helge
> >>>>>>>
> >>>>>>>
> >>>>>>> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> >>>>>>> index c5a91600842a..b477430c07eb 100644
> >>>>>>> --- a/security/apparmor/match.c
> >>>>>>> +++ b/security/apparmor/match.c
> >>>>>>> @@ -313,6 +313,9 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size=
_t size, int flags)
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (size < sizeof(struct tab=
le_set_header))
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 fail;
> >>>>>>> +=C2=A0=C2=A0=C2=A0 if (WARN_ON(((unsigned long)data) & (BITS_PER=
_LONG/8 - 1)))
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("dfa blob str=
eam %pS not aligned.\n", data);
> >>>>>>> +
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ntohl(*(__be32 *) data) =
!=3D YYTH_MAGIC)
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 fail; =20
> >>>>>>
> >>>>>> Here is the relevant output with the patch applied:
> >>>>>>
> >>>>>> [=C2=A0=C2=A0 73.840639] ------------[ cut here ]------------
> >>>>>> [=C2=A0=C2=A0 73.901376] WARNING: CPU: 0 PID: 341 at security/appa=
rmor/match.c:316 aa_dfa_unpack+0x6cc/0x720
> >>>>>> [=C2=A0=C2=A0 74.015867] Modules linked in: binfmt_misc evdev flas=
h sg drm drm_panel_orientation_quirks backlight i2c_core configfs nfnetlink=
 autofs4 ext4 crc16 mbcache jbd2 hid_generic usbhid sr_mod hid cdrom
> >>>>>> sd_mod ata_generic ohci_pci ehci_pci ehci_hcd ohci_hcd pata_ali li=
bata sym53c8xx scsi_transport_spi tg3 scsi_mod usbcore libphy scsi_common m=
dio_bus usb_common
> >>>>>> [=C2=A0=C2=A0 74.428977] CPU: 0 UID: 0 PID: 341 Comm: apparmor_par=
ser Not tainted 6.18.0-rc6+ #9 NONE
> >>>>>> [=C2=A0=C2=A0 74.536543] Call Trace:
> >>>>>> [=C2=A0=C2=A0 74.568561] [<0000000000434c24>] dump_stack+0x8/0x18
> >>>>>> [=C2=A0=C2=A0 74.633757] [<0000000000476438>] __warn+0xd8/0x100
> >>>>>> [=C2=A0=C2=A0 74.696664] [<00000000004296d4>] warn_slowpath_fmt+0x=
34/0x74
> >>>>>> [=C2=A0=C2=A0 74.771006] [<00000000008db28c>] aa_dfa_unpack+0x6cc/=
0x720
> >>>>>> [=C2=A0=C2=A0 74.843062] [<00000000008e643c>] unpack_pdb+0xbc/0x7e0
> >>>>>> [=C2=A0=C2=A0 74.910545] [<00000000008e7740>] unpack_profile+0xbe0=
/0x1300
> >>>>>> [=C2=A0=C2=A0 74.984888] [<00000000008e82e0>] aa_unpack+0xe0/0x6a0
> >>>>>> [=C2=A0=C2=A0 75.051226] [<00000000008e3ec4>] aa_replace_profiles+=
0x64/0x1160
> >>>>>> [=C2=A0=C2=A0 75.130144] [<00000000008d4d90>] policy_update+0xf0/0=
x280
> >>>>>> [=C2=A0=C2=A0 75.201057] [<00000000008d4fc8>] profile_replace+0xa8=
/0x100
> >>>>>> [=C2=A0=C2=A0 75.274258] [<0000000000766bd0>] vfs_write+0x90/0x420
> >>>>>> [=C2=A0=C2=A0 75.340594] [<00000000007670cc>] ksys_write+0x4c/0xe0
> >>>>>> [=C2=A0=C2=A0 75.406932] [<0000000000767174>] sys_write+0x14/0x40
> >>>>>> [=C2=A0=C2=A0 75.472126] [<0000000000406174>] linux_sparc_syscall+=
0x34/0x44
> >>>>>> [=C2=A0=C2=A0 75.548802] ---[ end trace 0000000000000000 ]---
> >>>>>> [=C2=A0=C2=A0 75.609503] dfa blob stream 0xfff0000008926b96 not al=
igned.
> >>>>>> [=C2=A0=C2=A0 75.682695] Kernel unaligned access at TPC[8db2a8] aa=
_dfa_unpack+0x6e8/0x720 =20
> >>>>>
> >>>>> The non-8-byte-aligned address (0xfff0000008926b96) is coming from =
userspace
> >>>>> (via the write syscall).
> >>>>> Some apparmor userspace tool writes into the apparmor ".replace" vi=
rtual file with
> >>>>> a source address which is not correctly aligned. =20
> >>>>
> >>>> the userpace buffer passed to write(2) has to be aligned? Its certai=
nly nice if it
> >>>> is but the userspace tooling hasn't been treating it as aligned. Wit=
h that said,
> >>>> the dfa should be padded to be aligned. So this tripping in the dfa =
is a bug,
> >>>> and there really should be some validation to catch it.
> >>>> =20
> >>>>> You should be able to debug/find the problematic code with strace f=
rom userspace.
> >>>>> Maybe someone with apparmor knowledge here on the list has an idea?
> >>>>> =20
> >>>> This is likely an unaligned 2nd profile, being split out and loaded =
separately
> >>>> from the rest of the container. Basically the loader for some reason=
 (there
> >>>> are a few different possible reasons) is poking into the container f=
ormat and
> >>>> pulling out the profile at some offset, this gets loaded to the kern=
el but
> >>>> it would seem that its causing an issue with the dfa alignment withi=
n the container,
> >>>> which should be aligned to the original container. =20
> >>>
> >>>
> >>> Regarding this:
> >>> =20
> >>>> Kernel side, we are going to need to add some extra verification che=
cks, it should
> >>>> be catching this, as unaligned as part of the unpack. Userspace side=
, we will have
> >>>> to verify my guess and fix the loader. =20
> >>>
> >>> I wonder if loading those tables are really time critical? =20
> >>
> >> no, most policy is loaded once on boot and then at package upgrades. T=
here are some
> >> bits that may be loaded at application startup like, snap, libvirt, lx=
d, basically
> >> container managers might do some thing custom per container.
> >>
> >> Its the run time we want to minimize, the cost of.
> >>
> >> Policy already can be unaligned (the container format rework to fix th=
is is low
> >> priority), and is treated as untrusted. It goes through an unpack, and=
 translation to
> >> machine native, with as many bounds checks, necessary transforms etc d=
one at unpack
> >> time as possible, so that the run time costs can be minimized.
> >> =20
> >>> If not, maybe just making the kernel aware that the tables might be u=
naligned
> >>> can help, e.g. with the following (untested) patch.
> >>> Adrian, maybe you want to test?
> >>> =20
> >> =20
> >>> ------------------------
> >>>
> >>> [PATCH] Allow apparmor to handle unaligned dfa tables
> >>>
> >>> The dfa tables can originate from kernel or userspace and 8-byte alig=
nment
> >>> isn't always guaranteed and as such may trigger unaligned memory acce=
sses
> >>> on various architectures.
> >>> Work around it by using the get_unaligned_xx() helpers.
> >>>
> >>> Signed-off-by: Helge Deller <deller@gmx.de>
> >>> =20
> >> lgtm,
> >>
> >> Acked-by: John Johansen <john.johansen@canonical.com>
> >>
> >> I'll pull this into my tree regardless of whether it fixes the issue
> >> for Adrian, as it definitely fixes an issue.
> >>
> >> We can added additional patches on top s needed. =20
> >=20
> > My patch does not modify the UNPACK_ARRAY() macro, which we
> > possibly should adjust as well. =20
>=20
> Indeed. See the patch below. I am not surprised testing hasn't triggered =
this
> case, but a malicious userspace could certainly construct a policy that w=
ould
> trigger it. Yes it would have to be root, but I still would like to preve=
nt
> root from being able to trigger this.
>=20
> > Adrian's testing seems to trigger only a few unaligned accesses,
> > so maybe it's not a issue currently.
> >  =20
> I don't think the userspace compiler is generating one that is bad, but it
> possible to construct one and get it to the point where it can trip in
> UNPACK_ARRAY
>=20
> commit 2c87528c1e7be3976b61ac797c6c8700364c4c63
> Author: John Johansen <john.johansen@canonical.com>
> Date:   Tue Nov 25 13:59:32 2025 -0800
>=20
>      apparmor: fix unaligned memory access of UNPACK_ARRAY
>     =20
>      The UNPACK_ARRAY macro has the potential to have unaligned memory
>      access when the unpacking an unaligned profile, which is caused by
>      userspace splitting up a profile container before sending it to the
>      kernel.
>     =20
>      While this is corner case, policy loaded from userspace should be
>      treated as untrusted so ensure that userspace can not trigger an
>      unaligned access.
>     =20
>      Signed-off-by: John Johansen <john.johansen@canonical.com>
>=20
> diff --git a/security/apparmor/include/match.h b/security/apparmor/includ=
e/match.h
> index 1fbe82f5021b1..203f7c07529f5 100644
> --- a/security/apparmor/include/match.h
> +++ b/security/apparmor/include/match.h
> @@ -104,7 +104,7 @@ struct aa_dfa {
>   	struct table_header *tables[YYTD_ID_TSIZE];
>   };
>  =20
> -#define byte_to_byte(X) (X)
> +#define byte_to_byte(X) *(X)

Even though is is only used once that ought to be (*(X))

>  =20
>   #define UNPACK_ARRAY(TABLE, BLOB, LEN, TTYPE, BTYPE, NTOHX)	\
>   	do { \
> @@ -112,7 +112,7 @@ struct aa_dfa {
>   		TTYPE *__t =3D (TTYPE *) TABLE; \
>   		BTYPE *__b =3D (BTYPE *) BLOB; \
>   		for (__i =3D 0; __i < LEN; __i++) { \
> -			__t[__i] =3D NTOHX(__b[__i]); \
> +			__t[__i] =3D NTOHX(&__b[__i]); \
>   		} \
>   	} while (0)
>  =20
> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> index 26e82ba879d44..3dcc342337aca 100644
> --- a/security/apparmor/match.c
> +++ b/security/apparmor/match.c
> @@ -71,10 +71,10 @@ static struct table_header *unpack_table(char *blob, =
size_t bsize)
>   				     u8, u8, byte_to_byte);

Is that that just memcpy() ?

	David

>   		else if (th.td_flags =3D=3D YYTD_DATA16)
>   			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> -				     u16, __be16, be16_to_cpu);
> +				     u16, __be16, get_unaligned_be16);
>   		else if (th.td_flags =3D=3D YYTD_DATA32)
>   			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> -				     u32, __be32, be32_to_cpu);
> +				     u32, __be32, get_unaligned_be32);
>   		else
>   			goto fail;
>   		/* if table was vmalloced make sure the page tables are synced
>=20
>=20
>=20

