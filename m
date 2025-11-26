Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC726A0DB;
	Wed, 26 Nov 2025 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155005; cv=none; b=pold+pkTFB65SF6IfXmd5ylv6YYB8DADw7rFFuEecSwdoZhCuwk/iT3TcWzl5SoOZldhLPT8WAE2K3mhlFz3Cixmydz69WmvsxH9uNJprMx+9nchkPQYYf4g+GRHHLxDC2/xVPlExiFbbkT/k44ADNcgbm+uQl8WpcaYRrEwvYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155005; c=relaxed/simple;
	bh=BWpi1CpKxujBxAaN8tBf1E2b5OJ4d/wR5BRuQFQ/6oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8usgjTsYKznZ/8LZCqUTUwg9o7hBBwdbUl3Dqj2+yxFa98N+UbSoKEvIJg/TawKeHl0X9wHDiz3pyTSMhDiHalwaUG04ODYMKYMDjAwRhdaJrB1WRdSvz4c8c9kvHMRQcRU7UBOfAb3JfeDsFcT3tjLa9U1WApAgdFj6KxbmWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=uA7414Cm; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="uA7414Cm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764154985; x=1764759785; i=deller@gmx.de;
	bh=LUAoqoRLZjHDVSiGO7HN2g8+661XeN1421pMfgsSpPM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uA7414Cm9vFjvAXza5LYc8Zk5xds2w06F5xHnoG6iuCxR7UR4w7loNZ9xFJf6H/z
	 lgOVaYSZexMNceS5HXQs+r4Kq7muPESNs1H0yLFq05hNjaXbzPL6FZTWY2Wkolt0v
	 D3btSvS262E5yoxjn47VyhWJPynZitcxBfNHz7UV+IojMy66XXPegbegD4SkGs6kX
	 I8OQ3GIrlrwofyATPgv87zmSEH6XT1T1+bIyMO1MS60zZ2tTvjrjPqzNWNZy1yHSh
	 KdUjZ9ONztqTBxuLutnifZhpBmy3t1BBxj315heYLB3c2M/IzIcP6YRsxUsSsZwU5
	 hwTjNq23XDny/2TLOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.10] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoNC-1vIAt517wM-0039gD; Wed, 26
 Nov 2025 12:03:05 +0100
Message-ID: <4034ad19-8e09-440c-a042-a66a488c048b@gmx.de>
Date: Wed, 26 Nov 2025 12:03:03 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
To: david laight <david.laight@runbox.com>,
 John Johansen <john.johansen@canonical.com>
Cc: Helge Deller <deller@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20250531150822.135803-1-deller@kernel.org>
 <bc21bee14ca44077ae9323bfc251ad12390fa841.camel@physik.fu-berlin.de>
 <aRxT78fdN5v2Ajyl@p100>
 <90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
 <be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
 <ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com> <aSXHCyH_rS-c5BgP@p100>
 <e88c32c2-fb18-4f3e-9ec2-a749695aaf0a@canonical.com>
 <c192140a-0575-41e9-8895-6c8257ce4682@gmx.de>
 <d35010b3-7d07-488c-b5a4-a13380d0ef7c@canonical.com>
 <20251126104444.29002552@pumpkin>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251126104444.29002552@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bBW3D+AEvruuWXIhGuLvCqAWl+Oa2/Y7xsMAdYLIibkrOZbeMEd
 8m5wBz+vzvOtdyUyQpYQdC87u/j/HhHKW00r0xuioPO7m7xVxOqNwVdu4v4TtYLRaDFoGEy
 Dr3zt3VqRGJ8iFFZGTRx6oapf8lDP1CLrBpSARd+K5UiSQ3H6y9aPUG7qkL3PLrHwN89uPA
 Zqj1lX9c1sezh2SK0iSSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P5pCBfmNrHo=;a34aWV1WHPFQ0lBWcbqAPyDt711
 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
 tj0Us9Brpx18/L71CupAgP1icvo2z

On 11/26/25 11:44, david laight wrote:
> On Wed, 26 Nov 2025 01:11:45 -0800
> John Johansen <john.johansen@canonical.com> wrote:
>=20
>> On 11/25/25 13:13, Helge Deller wrote:
>>> On 11/25/25 20:20, John Johansen wrote:
>>>> On 11/25/25 07:11, Helge Deller wrote:
>>>>> * John Johansen <john.johansen@canonical.com>:
>>>>>> On 11/18/25 04:49, Helge Deller wrote:
>>>>>>> Hi Adrian,
>>>>>>>
>>>>>>> On 11/18/25 12:43, John Paul Adrian Glaubitz wrote:
>>>>>>>> On Tue, 2025-11-18 at 12:09 +0100, Helge Deller wrote:
>>>>>>>>> My patch fixed two call sites, but I suspect you see another cal=
l site which
>>>>>>>>> hasn't been fixed yet.
>>>>>>>>>
>>>>>>>>> Can you try attached patch? It might indicate the caller of the =
function and
>>>>>>>>> maybe prints the struct name/address which isn't aligned.
>>>>>>>>>
>>>>>>>>> Helge
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> diff --git a/security/apparmor/match.c b/security/apparmor/match=
.c
>>>>>>>>> index c5a91600842a..b477430c07eb 100644
>>>>>>>>> --- a/security/apparmor/match.c
>>>>>>>>> +++ b/security/apparmor/match.c
>>>>>>>>> @@ -313,6 +313,9 @@ struct aa_dfa *aa_dfa_unpack(void *blob, siz=
e_t size, int flags)
>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (size < sizeof(struct t=
able_set_header))
>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to fail;
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (WARN_ON(((unsigned long)data) & (BITS_PE=
R_LONG/8 - 1)))
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("dfa blob st=
ream %pS not aligned.\n", data);
>>>>>>>>> +
>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ntohl(*(__be32 *) data=
) !=3D YYTH_MAGIC)
>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to fail;
>>>>>>>>
>>>>>>>> Here is the relevant output with the patch applied:
>>>>>>>>
>>>>>>>> [=C2=A0=C2=A0 73.840639] ------------[ cut here ]------------
>>>>>>>> [=C2=A0=C2=A0 73.901376] WARNING: CPU: 0 PID: 341 at security/app=
armor/match.c:316 aa_dfa_unpack+0x6cc/0x720
>>>>>>>> [=C2=A0=C2=A0 74.015867] Modules linked in: binfmt_misc evdev fla=
sh sg drm drm_panel_orientation_quirks backlight i2c_core configfs nfnetli=
nk autofs4 ext4 crc16 mbcache jbd2 hid_generic usbhid sr_mod hid cdrom
>>>>>>>> sd_mod ata_generic ohci_pci ehci_pci ehci_hcd ohci_hcd pata_ali l=
ibata sym53c8xx scsi_transport_spi tg3 scsi_mod usbcore libphy scsi_common=
 mdio_bus usb_common
>>>>>>>> [=C2=A0=C2=A0 74.428977] CPU: 0 UID: 0 PID: 341 Comm: apparmor_pa=
rser Not tainted 6.18.0-rc6+ #9 NONE
>>>>>>>> [=C2=A0=C2=A0 74.536543] Call Trace:
>>>>>>>> [=C2=A0=C2=A0 74.568561] [<0000000000434c24>] dump_stack+0x8/0x18
>>>>>>>> [=C2=A0=C2=A0 74.633757] [<0000000000476438>] __warn+0xd8/0x100
>>>>>>>> [=C2=A0=C2=A0 74.696664] [<00000000004296d4>] warn_slowpath_fmt+0=
x34/0x74
>>>>>>>> [=C2=A0=C2=A0 74.771006] [<00000000008db28c>] aa_dfa_unpack+0x6cc=
/0x720
>>>>>>>> [=C2=A0=C2=A0 74.843062] [<00000000008e643c>] unpack_pdb+0xbc/0x7=
e0
>>>>>>>> [=C2=A0=C2=A0 74.910545] [<00000000008e7740>] unpack_profile+0xbe=
0/0x1300
>>>>>>>> [=C2=A0=C2=A0 74.984888] [<00000000008e82e0>] aa_unpack+0xe0/0x6a=
0
>>>>>>>> [=C2=A0=C2=A0 75.051226] [<00000000008e3ec4>] aa_replace_profiles=
+0x64/0x1160
>>>>>>>> [=C2=A0=C2=A0 75.130144] [<00000000008d4d90>] policy_update+0xf0/=
0x280
>>>>>>>> [=C2=A0=C2=A0 75.201057] [<00000000008d4fc8>] profile_replace+0xa=
8/0x100
>>>>>>>> [=C2=A0=C2=A0 75.274258] [<0000000000766bd0>] vfs_write+0x90/0x42=
0
>>>>>>>> [=C2=A0=C2=A0 75.340594] [<00000000007670cc>] ksys_write+0x4c/0xe=
0
>>>>>>>> [=C2=A0=C2=A0 75.406932] [<0000000000767174>] sys_write+0x14/0x40
>>>>>>>> [=C2=A0=C2=A0 75.472126] [<0000000000406174>] linux_sparc_syscall=
+0x34/0x44
>>>>>>>> [=C2=A0=C2=A0 75.548802] ---[ end trace 0000000000000000 ]---
>>>>>>>> [=C2=A0=C2=A0 75.609503] dfa blob stream 0xfff0000008926b96 not a=
ligned.
>>>>>>>> [=C2=A0=C2=A0 75.682695] Kernel unaligned access at TPC[8db2a8] a=
a_dfa_unpack+0x6e8/0x720
>>>>>>>
>>>>>>> The non-8-byte-aligned address (0xfff0000008926b96) is coming from=
 userspace
>>>>>>> (via the write syscall).
>>>>>>> Some apparmor userspace tool writes into the apparmor ".replace" v=
irtual file with
>>>>>>> a source address which is not correctly aligned.
>>>>>>
>>>>>> the userpace buffer passed to write(2) has to be aligned? Its certa=
inly nice if it
>>>>>> is but the userspace tooling hasn't been treating it as aligned. Wi=
th that said,
>>>>>> the dfa should be padded to be aligned. So this tripping in the dfa=
 is a bug,
>>>>>> and there really should be some validation to catch it.
>>>>>>  =20
>>>>>>> You should be able to debug/find the problematic code with strace =
from userspace.
>>>>>>> Maybe someone with apparmor knowledge here on the list has an idea=
?
>>>>>>>  =20
>>>>>> This is likely an unaligned 2nd profile, being split out and loaded=
 separately
>>>>>> from the rest of the container. Basically the loader for some reaso=
n (there
>>>>>> are a few different possible reasons) is poking into the container =
format and
>>>>>> pulling out the profile at some offset, this gets loaded to the ker=
nel but
>>>>>> it would seem that its causing an issue with the dfa alignment with=
in the container,
>>>>>> which should be aligned to the original container.
>>>>>
>>>>>
>>>>> Regarding this:
>>>>>  =20
>>>>>> Kernel side, we are going to need to add some extra verification ch=
ecks, it should
>>>>>> be catching this, as unaligned as part of the unpack. Userspace sid=
e, we will have
>>>>>> to verify my guess and fix the loader.
>>>>>
>>>>> I wonder if loading those tables are really time critical?
>>>>
>>>> no, most policy is loaded once on boot and then at package upgrades. =
There are some
>>>> bits that may be loaded at application startup like, snap, libvirt, l=
xd, basically
>>>> container managers might do some thing custom per container.
>>>>
>>>> Its the run time we want to minimize, the cost of.
>>>>
>>>> Policy already can be unaligned (the container format rework to fix t=
his is low
>>>> priority), and is treated as untrusted. It goes through an unpack, an=
d translation to
>>>> machine native, with as many bounds checks, necessary transforms etc =
done at unpack
>>>> time as possible, so that the run time costs can be minimized.
>>>>  =20
>>>>> If not, maybe just making the kernel aware that the tables might be =
unaligned
>>>>> can help, e.g. with the following (untested) patch.
>>>>> Adrian, maybe you want to test?
>>>>>  =20
>>>>  =20
>>>>> ------------------------
>>>>>
>>>>> [PATCH] Allow apparmor to handle unaligned dfa tables
>>>>>
>>>>> The dfa tables can originate from kernel or userspace and 8-byte ali=
gnment
>>>>> isn't always guaranteed and as such may trigger unaligned memory acc=
esses
>>>>> on various architectures.
>>>>> Work around it by using the get_unaligned_xx() helpers.
>>>>>
>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>>  =20
>>>> lgtm,
>>>>
>>>> Acked-by: John Johansen <john.johansen@canonical.com>
>>>>
>>>> I'll pull this into my tree regardless of whether it fixes the issue
>>>> for Adrian, as it definitely fixes an issue.
>>>>
>>>> We can added additional patches on top s needed.
>>>
>>> My patch does not modify the UNPACK_ARRAY() macro, which we
>>> possibly should adjust as well.
>>
>> Indeed. See the patch below. I am not surprised testing hasn't triggere=
d this
>> case, but a malicious userspace could certainly construct a policy that=
 would
>> trigger it. Yes it would have to be root, but I still would like to pre=
vent
>> root from being able to trigger this.
>>
>>> Adrian's testing seems to trigger only a few unaligned accesses,
>>> so maybe it's not a issue currently.
>>>   =20
>> I don't think the userspace compiler is generating one that is bad, but=
 it
>> possible to construct one and get it to the point where it can trip in
>> UNPACK_ARRAY
>>
>> commit 2c87528c1e7be3976b61ac797c6c8700364c4c63
>> Author: John Johansen <john.johansen@canonical.com>
>> Date:   Tue Nov 25 13:59:32 2025 -0800
>>
>>       apparmor: fix unaligned memory access of UNPACK_ARRAY
>>      =20
>>       The UNPACK_ARRAY macro has the potential to have unaligned memory
>>       access when the unpacking an unaligned profile, which is caused b=
y
>>       userspace splitting up a profile container before sending it to t=
he
>>       kernel.
>>      =20
>>       While this is corner case, policy loaded from userspace should be
>>       treated as untrusted so ensure that userspace can not trigger an
>>       unaligned access.
>>      =20
>>       Signed-off-by: John Johansen <john.johansen@canonical.com>
>>
>> diff --git a/security/apparmor/include/match.h b/security/apparmor/incl=
ude/match.h
>> index 1fbe82f5021b1..203f7c07529f5 100644
>> --- a/security/apparmor/include/match.h
>> +++ b/security/apparmor/include/match.h
>> @@ -104,7 +104,7 @@ struct aa_dfa {
>>    	struct table_header *tables[YYTD_ID_TSIZE];
>>    };
>>   =20
>> -#define byte_to_byte(X) (X)
>> +#define byte_to_byte(X) *(X)
>=20
> Even though is is only used once that ought to be (*(X))
>=20
>>   =20
>>    #define UNPACK_ARRAY(TABLE, BLOB, LEN, TTYPE, BTYPE, NTOHX)	\
>>    	do { \
>> @@ -112,7 +112,7 @@ struct aa_dfa {
>>    		TTYPE *__t =3D (TTYPE *) TABLE; \
>>    		BTYPE *__b =3D (BTYPE *) BLOB; \
>>    		for (__i =3D 0; __i < LEN; __i++) { \
>> -			__t[__i] =3D NTOHX(__b[__i]); \
>> +			__t[__i] =3D NTOHX(&__b[__i]); \
>>    		} \
>>    	} while (0)
>>   =20
>> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
>> index 26e82ba879d44..3dcc342337aca 100644
>> --- a/security/apparmor/match.c
>> +++ b/security/apparmor/match.c
>> @@ -71,10 +71,10 @@ static struct table_header *unpack_table(char *blob=
, size_t bsize)
>>    				     u8, u8, byte_to_byte);
>=20
> Is that that just memcpy() ?

No, it's memcpy() only on big-endian machines.
On little-endian machines it converts from big-endian
16/32-bit ints to little-endian 16/32-bit ints.

But I see some potential for optimization here:
a) on big-endian machines just use memcpy()
b) on little-endian machines use memcpy() to copy from possibly-unaligned
    memory to then known-to-be-aligned destination. Then use a loop with
    be32_to_cpu() instead of get_unaligned_xx() as it's faster.

Thoughts?

Helge=20
> 	David
>=20
>>    		else if (th.td_flags =3D=3D YYTD_DATA16)
>>    			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
>> -				     u16, __be16, be16_to_cpu);
>> +				     u16, __be16, get_unaligned_be16);
>>    		else if (th.td_flags =3D=3D YYTD_DATA32)
>>    			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
>> -				     u32, __be32, be32_to_cpu);
>> +				     u32, __be32, get_unaligned_be32);
>>    		else
>>    			goto fail;
>>    		/* if table was vmalloced make sure the page tables are synced
>>
>>
>>
>=20

