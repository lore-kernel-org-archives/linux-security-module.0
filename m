Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893102E093C;
	Wed, 26 Nov 2025 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156702; cv=none; b=BksqrEReigFyp0Cqdv6iR4p/SIFGadik/l+tfePh+mL6CwVsxHEOpjHvjWOxBH3AzzK4jJ68le+fN/KPfG1T9kkDDafZh/fic6cjGo3qm5ID4E1tUHB3Lsn7plwBlMRtJg5+NoPlsrATSYWWAQjtKyRpZVHyeZ7lrJnfiYSAvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156702; c=relaxed/simple;
	bh=Fy12amFwhvn0rH6BodVyg6UWwr/9Bx9YkoVUFWKmdYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4yZpOA82gkJHRzZ35VD+W10qXbznhtKy0nhifxP2oEsOWc+EJYrnjNkt3gLwjozTu455yBU1oFD1SlOAIn55cDbK6siFFFtU1JmfpMpAT6QDBxCZPO3Gp071UWSFfl0sVeMOjy02VKrM9iE8o1z8GQz6HXtgvZwKTikqpuilww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJLtZen8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJLtZen8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C13FC16AAE;
	Wed, 26 Nov 2025 11:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764156702;
	bh=Fy12amFwhvn0rH6BodVyg6UWwr/9Bx9YkoVUFWKmdYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJLtZen8vEYtU9PwJHPV7cdew5dhgaAwZJ6S6GRaevXq2JWzYjCumOGgJH0sbBzEM
	 h00VauNPwn2pScFAbokpRlLQHdz4Fg4/+ZtKHVVUv9E/P8aDCNsgRusuQvdnfT5E/0
	 vHEB3nybPJldQNHn+xTMSouIdOCrWAE41tBcGyLwD3YJLz0ABAKO/lMxvuIFV72Luj
	 ektBNsEqHZyQqPG/G3zFwHb0zVxAMYZAET5f9aR3uyMTFMl5lpcXUNZP5o5XOhgp8x
	 38aUIzgydslyD77Bas/5REVnnfOUIqVRscDJnS6fhO1+hrO+isIqrttemzfMf2zeR1
	 yTaP4ndK7e2lw==
Date: Wed, 26 Nov 2025 12:31:36 +0100
From: Helge Deller <deller@kernel.org>
To: John Johansen <john.johansen@canonical.com>,
	david laight <david.laight@runbox.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
Message-ID: <aSblGNyoSV4LfKji@carbonx1>
References: <aRxT78fdN5v2Ajyl@p100>
 <90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
 <be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
 <ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com>
 <aSXHCyH_rS-c5BgP@p100>
 <e88c32c2-fb18-4f3e-9ec2-a749695aaf0a@canonical.com>
 <c192140a-0575-41e9-8895-6c8257ce4682@gmx.de>
 <d35010b3-7d07-488c-b5a4-a13380d0ef7c@canonical.com>
 <20251126104444.29002552@pumpkin>
 <4034ad19-8e09-440c-a042-a66a488c048b@gmx.de>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4034ad19-8e09-440c-a042-a66a488c048b@gmx.de>

* Helge Deller <deller@gmx.de>:
> On 11/26/25 11:44, david laight wrote:
> > On Wed, 26 Nov 2025 01:11:45 -0800
> > John Johansen <john.johansen@canonical.com> wrote:
> > 
> > > On 11/25/25 13:13, Helge Deller wrote:
> > > > On 11/25/25 20:20, John Johansen wrote:
> > > > > On 11/25/25 07:11, Helge Deller wrote:
> > > > > > * John Johansen <john.johansen@canonical.com>:
> > > > > > > On 11/18/25 04:49, Helge Deller wrote:
> > > > > > > > Hi Adrian,
> > > > > > > > 
> > > > > > > > On 11/18/25 12:43, John Paul Adrian Glaubitz wrote:
> > > > > > > > > On Tue, 2025-11-18 at 12:09 +0100, Helge Deller wrote:
> > > > > > > > > > My patch fixed two call sites, but I suspect you see another call site which
> > > > > > > > > > hasn't been fixed yet.
> > > > > > > > > > 
> > > > > > > > > > Can you try attached patch? It might indicate the caller of the function and
> > > > > > > > > > maybe prints the struct name/address which isn't aligned.
> > > > > > > > > > 
> > > > > > > > > > Helge
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> > > > > > > > > > index c5a91600842a..b477430c07eb 100644
> > > > > > > > > > --- a/security/apparmor/match.c
> > > > > > > > > > +++ b/security/apparmor/match.c
> > > > > > > > > > @@ -313,6 +313,9 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size_t size, int flags)
> > > > > > > > > >         if (size < sizeof(struct table_set_header))
> > > > > > > > > >             goto fail;
> > > > > > > > > > +    if (WARN_ON(((unsigned long)data) & (BITS_PER_LONG/8 - 1)))
> > > > > > > > > > +        pr_warn("dfa blob stream %pS not aligned.\n", data);
> > > > > > > > > > +
> > > > > > > > > >         if (ntohl(*(__be32 *) data) != YYTH_MAGIC)
> > > > > > > > > >             goto fail;
> > > > > > > > > 
> > > > > > > > > Here is the relevant output with the patch applied:
> > > > > > > > > 
> > > > > > > > > [   73.840639] ------------[ cut here ]------------
> > > > > > > > > [   73.901376] WARNING: CPU: 0 PID: 341 at security/apparmor/match.c:316 aa_dfa_unpack+0x6cc/0x720
> > > > > > > > > [   74.015867] Modules linked in: binfmt_misc evdev flash sg drm drm_panel_orientation_quirks backlight i2c_core configfs nfnetlink autofs4 ext4 crc16 mbcache jbd2 hid_generic usbhid sr_mod hid cdrom
> > > > > > > > > sd_mod ata_generic ohci_pci ehci_pci ehci_hcd ohci_hcd pata_ali libata sym53c8xx scsi_transport_spi tg3 scsi_mod usbcore libphy scsi_common mdio_bus usb_common
> > > > > > > > > [   74.428977] CPU: 0 UID: 0 PID: 341 Comm: apparmor_parser Not tainted 6.18.0-rc6+ #9 NONE
> > > > > > > > > [   74.536543] Call Trace:
> > > > > > > > > [   74.568561] [<0000000000434c24>] dump_stack+0x8/0x18
> > > > > > > > > [   74.633757] [<0000000000476438>] __warn+0xd8/0x100
> > > > > > > > > [   74.696664] [<00000000004296d4>] warn_slowpath_fmt+0x34/0x74
> > > > > > > > > [   74.771006] [<00000000008db28c>] aa_dfa_unpack+0x6cc/0x720
> > > > > > > > > [   74.843062] [<00000000008e643c>] unpack_pdb+0xbc/0x7e0
> > > > > > > > > [   74.910545] [<00000000008e7740>] unpack_profile+0xbe0/0x1300
> > > > > > > > > [   74.984888] [<00000000008e82e0>] aa_unpack+0xe0/0x6a0
> > > > > > > > > [   75.051226] [<00000000008e3ec4>] aa_replace_profiles+0x64/0x1160
> > > > > > > > > [   75.130144] [<00000000008d4d90>] policy_update+0xf0/0x280
> > > > > > > > > [   75.201057] [<00000000008d4fc8>] profile_replace+0xa8/0x100
> > > > > > > > > [   75.274258] [<0000000000766bd0>] vfs_write+0x90/0x420
> > > > > > > > > [   75.340594] [<00000000007670cc>] ksys_write+0x4c/0xe0
> > > > > > > > > [   75.406932] [<0000000000767174>] sys_write+0x14/0x40
> > > > > > > > > [   75.472126] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
> > > > > > > > > [   75.548802] ---[ end trace 0000000000000000 ]---
> > > > > > > > > [   75.609503] dfa blob stream 0xfff0000008926b96 not aligned.
> > > > > > > > > [   75.682695] Kernel unaligned access at TPC[8db2a8] aa_dfa_unpack+0x6e8/0x720
> > > > > > > > 
> > > > > > > > The non-8-byte-aligned address (0xfff0000008926b96) is coming from userspace
> > > > > > > > (via the write syscall).
> > > > > > > > Some apparmor userspace tool writes into the apparmor ".replace" virtual file with
> > > > > > > > a source address which is not correctly aligned.
> > > > > > > 
> > > > > > > the userpace buffer passed to write(2) has to be aligned? Its certainly nice if it
> > > > > > > is but the userspace tooling hasn't been treating it as aligned. With that said,
> > > > > > > the dfa should be padded to be aligned. So this tripping in the dfa is a bug,
> > > > > > > and there really should be some validation to catch it.
> > > > > > > > You should be able to debug/find the problematic code with strace from userspace.
> > > > > > > > Maybe someone with apparmor knowledge here on the list has an idea?
> > > > > > > This is likely an unaligned 2nd profile, being split out and loaded separately
> > > > > > > from the rest of the container. Basically the loader for some reason (there
> > > > > > > are a few different possible reasons) is poking into the container format and
> > > > > > > pulling out the profile at some offset, this gets loaded to the kernel but
> > > > > > > it would seem that its causing an issue with the dfa alignment within the container,
> > > > > > > which should be aligned to the original container.
> > > > > > 
> > > > > > 
> > > > > > Regarding this:
> > > > > > > Kernel side, we are going to need to add some extra verification checks, it should
> > > > > > > be catching this, as unaligned as part of the unpack. Userspace side, we will have
> > > > > > > to verify my guess and fix the loader.
> > > > > > 
> > > > > > I wonder if loading those tables are really time critical?
> > > > > 
> > > > > no, most policy is loaded once on boot and then at package upgrades. There are some
> > > > > bits that may be loaded at application startup like, snap, libvirt, lxd, basically
> > > > > container managers might do some thing custom per container.
> > > > > 
> > > > > Its the run time we want to minimize, the cost of.
> > > > > 
> > > > > Policy already can be unaligned (the container format rework to fix this is low
> > > > > priority), and is treated as untrusted. It goes through an unpack, and translation to
> > > > > machine native, with as many bounds checks, necessary transforms etc done at unpack
> > > > > time as possible, so that the run time costs can be minimized.
> > > > > > If not, maybe just making the kernel aware that the tables might be unaligned
> > > > > > can help, e.g. with the following (untested) patch.
> > > > > > Adrian, maybe you want to test?
> > > > > > ------------------------
> > > > > > 
> > > > > > [PATCH] Allow apparmor to handle unaligned dfa tables
> > > > > > 
> > > > > > The dfa tables can originate from kernel or userspace and 8-byte alignment
> > > > > > isn't always guaranteed and as such may trigger unaligned memory accesses
> > > > > > on various architectures.
> > > > > > Work around it by using the get_unaligned_xx() helpers.
> > > > > > 
> > > > > > Signed-off-by: Helge Deller <deller@gmx.de>
> > > > > lgtm,
> > > > > 
> > > > > Acked-by: John Johansen <john.johansen@canonical.com>
> > > > > 
> > > > > I'll pull this into my tree regardless of whether it fixes the issue
> > > > > for Adrian, as it definitely fixes an issue.
> > > > > 
> > > > > We can added additional patches on top s needed.
> > > > 
> > > > My patch does not modify the UNPACK_ARRAY() macro, which we
> > > > possibly should adjust as well.
> > > 
> > > Indeed. See the patch below. I am not surprised testing hasn't triggered this
> > > case, but a malicious userspace could certainly construct a policy that would
> > > trigger it. Yes it would have to be root, but I still would like to prevent
> > > root from being able to trigger this.
> > > 
> > > > Adrian's testing seems to trigger only a few unaligned accesses,
> > > > so maybe it's not a issue currently.
> > > I don't think the userspace compiler is generating one that is bad, but it
> > > possible to construct one and get it to the point where it can trip in
> > > UNPACK_ARRAY
> > > 
> > > commit 2c87528c1e7be3976b61ac797c6c8700364c4c63
> > > Author: John Johansen <john.johansen@canonical.com>
> > > Date:   Tue Nov 25 13:59:32 2025 -0800
> > > 
> > >       apparmor: fix unaligned memory access of UNPACK_ARRAY
> > >       The UNPACK_ARRAY macro has the potential to have unaligned memory
> > >       access when the unpacking an unaligned profile, which is caused by
> > >       userspace splitting up a profile container before sending it to the
> > >       kernel.
> > >       While this is corner case, policy loaded from userspace should be
> > >       treated as untrusted so ensure that userspace can not trigger an
> > >       unaligned access.
> > >       Signed-off-by: John Johansen <john.johansen@canonical.com>
> > > 
> > > diff --git a/security/apparmor/include/match.h b/security/apparmor/include/match.h
> > > index 1fbe82f5021b1..203f7c07529f5 100644
> > > --- a/security/apparmor/include/match.h
> > > +++ b/security/apparmor/include/match.h
> > > @@ -104,7 +104,7 @@ struct aa_dfa {
> > >    	struct table_header *tables[YYTD_ID_TSIZE];
> > >    };
> > > -#define byte_to_byte(X) (X)
> > > +#define byte_to_byte(X) *(X)
> > 
> > Even though is is only used once that ought to be (*(X))
> > 
> > >    #define UNPACK_ARRAY(TABLE, BLOB, LEN, TTYPE, BTYPE, NTOHX)	\
> > >    	do { \
> > > @@ -112,7 +112,7 @@ struct aa_dfa {
> > >    		TTYPE *__t = (TTYPE *) TABLE; \
> > >    		BTYPE *__b = (BTYPE *) BLOB; \
> > >    		for (__i = 0; __i < LEN; __i++) { \
> > > -			__t[__i] = NTOHX(__b[__i]); \
> > > +			__t[__i] = NTOHX(&__b[__i]); \
> > >    		} \
> > >    	} while (0)
> > > diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> > > index 26e82ba879d44..3dcc342337aca 100644
> > > --- a/security/apparmor/match.c
> > > +++ b/security/apparmor/match.c
> > > @@ -71,10 +71,10 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
> > >    				     u8, u8, byte_to_byte);
> > 
> > Is that that just memcpy() ?
> 
> No, it's memcpy() only on big-endian machines.
> On little-endian machines it converts from big-endian
> 16/32-bit ints to little-endian 16/32-bit ints.
> 
> But I see some potential for optimization here:
> a) on big-endian machines just use memcpy()
> b) on little-endian machines use memcpy() to copy from possibly-unaligned
>    memory to then known-to-be-aligned destination. Then use a loop with
>    be32_to_cpu() instead of get_unaligned_xx() as it's faster.
> 
> Thoughts?

Like this (untested!) patch:

[PATCH] apparmor: Optimize table creation from possibly unaligned memory

Source blob may come from userspace and might be unaligned.
Try to optize the copying process by avoiding unaligned memory accesses.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/security/apparmor/include/match.h b/security/apparmor/include/match.h
index 1fbe82f5021b..225df6495c84 100644
--- a/security/apparmor/include/match.h
+++ b/security/apparmor/include/match.h
@@ -111,9 +111,14 @@ struct aa_dfa {
 		typeof(LEN) __i; \
 		TTYPE *__t = (TTYPE *) TABLE; \
 		BTYPE *__b = (BTYPE *) BLOB; \
-		for (__i = 0; __i < LEN; __i++) { \
-			__t[__i] = NTOHX(__b[__i]); \
-		} \
+		BUILD_BUG_ON(sizeof(TTYPE) != sizeof(BTYPE)); \
+		/* copy to naturally aligned table address */ \
+		memcpy(__t, __b, (LEN) * sizeof(BTYPE)); \
+		/* convert from big-endian if necessary */ \
+		if (!IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) \
+			for (__i = 0; __i < LEN; __i++, __t++) { \
+				*__t = NTOHX(*__t); \
+			} \
 	} while (0)
 
 static inline size_t table_size(size_t len, size_t el_size)
