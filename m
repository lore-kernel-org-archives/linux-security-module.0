Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE31324B17;
	Tue, 25 Nov 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083473; cv=none; b=hPRHL9Bg5tMrRcKnrzssYPp2gHipZFe6xufxNEcnXB0MUao89g48VFcxCA8wx4vLS7d78mbPpp9kTg7069Pu5jLELG2lfOS46p86gXKoDIRPke7WBqOXe9HwbpAi3BeYu9d8/uB3sXTpLPuqq+0J3ZB6fhQQMdQjRL22QJfRBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083473; c=relaxed/simple;
	bh=Gvzy+GG131VoXDqWVUu7DGYA/eTcJ0iyIo3aA8r2e1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdXfhplyhuej58UtNN2v7uwv35fPSVpD44W6J3/ntsAxdkYMtSbSCGACFOtwY5kz5udlTvrzmoHr63uHZOjAoBtgDa3tloogHuUYfU5JElgwXKyy8g6qzImem5JsCTDQ3+vNBWuDXAfXozwNklUsPrHvodoUwr97zH2Ny3YLelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8/rT5rE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8/rT5rE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11004C116B1;
	Tue, 25 Nov 2025 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764083471;
	bh=Gvzy+GG131VoXDqWVUu7DGYA/eTcJ0iyIo3aA8r2e1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8/rT5rE/ljoxffISLB7vsl+xjZUMOG1krv1T6H4Agz6YAE9UyQ5K61sm3B/SeAF2
	 v6kJQEIsp6N0atYBTBjLogJp5JM5Lx3H522z01zXyD9Hb4aZJ2qV7HtCx4Dz8cpI8D
	 ZNb20DdQqMfC1f27naL5JlfrGpYfsSVs7vP2gjLyylXa9jLVjRNLZoU2AjIA3E/cCq
	 YtEkY+Ea0XMI+Nau8SSNQYFu/1HUIiloZeHWtGLyTJlXi2Km7IyTJO8lLlFdWzyko0
	 v6WvN2s3eOxm3i+zQFzcu2R5L7tIRfCkLc0pwGpPH58Udj4G3Epcb015Uoygs8rRYM
	 G2FZFBpHH6IGw==
Date: Tue, 25 Nov 2025 16:11:07 +0100
From: Helge Deller <deller@kernel.org>
To: John Johansen <john.johansen@canonical.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-parisc@vger.kernel.org
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
Message-ID: <aSXHCyH_rS-c5BgP@p100>
References: <20250531150822.135803-1-deller@kernel.org>
 <bc21bee14ca44077ae9323bfc251ad12390fa841.camel@physik.fu-berlin.de>
 <aRxT78fdN5v2Ajyl@p100>
 <90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
 <be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
 <ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com>

* John Johansen <john.johansen@canonical.com>:
> On 11/18/25 04:49, Helge Deller wrote:
> > Hi Adrian,
> > 
> > On 11/18/25 12:43, John Paul Adrian Glaubitz wrote:
> > > On Tue, 2025-11-18 at 12:09 +0100, Helge Deller wrote:
> > > > My patch fixed two call sites, but I suspect you see another call site which
> > > > hasn't been fixed yet.
> > > > 
> > > > Can you try attached patch? It might indicate the caller of the function and
> > > > maybe prints the struct name/address which isn't aligned.
> > > > 
> > > > Helge
> > > > 
> > > > 
> > > > diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> > > > index c5a91600842a..b477430c07eb 100644
> > > > --- a/security/apparmor/match.c
> > > > +++ b/security/apparmor/match.c
> > > > @@ -313,6 +313,9 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size_t size, int flags)
> > > >       if (size < sizeof(struct table_set_header))
> > > >           goto fail;
> > > > +    if (WARN_ON(((unsigned long)data) & (BITS_PER_LONG/8 - 1)))
> > > > +        pr_warn("dfa blob stream %pS not aligned.\n", data);
> > > > +
> > > >       if (ntohl(*(__be32 *) data) != YYTH_MAGIC)
> > > >           goto fail;
> > > 
> > > Here is the relevant output with the patch applied:
> > > 
> > > [   73.840639] ------------[ cut here ]------------
> > > [   73.901376] WARNING: CPU: 0 PID: 341 at security/apparmor/match.c:316 aa_dfa_unpack+0x6cc/0x720
> > > [   74.015867] Modules linked in: binfmt_misc evdev flash sg drm drm_panel_orientation_quirks backlight i2c_core configfs nfnetlink autofs4 ext4 crc16 mbcache jbd2 hid_generic usbhid sr_mod hid cdrom
> > > sd_mod ata_generic ohci_pci ehci_pci ehci_hcd ohci_hcd pata_ali libata sym53c8xx scsi_transport_spi tg3 scsi_mod usbcore libphy scsi_common mdio_bus usb_common
> > > [   74.428977] CPU: 0 UID: 0 PID: 341 Comm: apparmor_parser Not tainted 6.18.0-rc6+ #9 NONE
> > > [   74.536543] Call Trace:
> > > [   74.568561] [<0000000000434c24>] dump_stack+0x8/0x18
> > > [   74.633757] [<0000000000476438>] __warn+0xd8/0x100
> > > [   74.696664] [<00000000004296d4>] warn_slowpath_fmt+0x34/0x74
> > > [   74.771006] [<00000000008db28c>] aa_dfa_unpack+0x6cc/0x720
> > > [   74.843062] [<00000000008e643c>] unpack_pdb+0xbc/0x7e0
> > > [   74.910545] [<00000000008e7740>] unpack_profile+0xbe0/0x1300
> > > [   74.984888] [<00000000008e82e0>] aa_unpack+0xe0/0x6a0
> > > [   75.051226] [<00000000008e3ec4>] aa_replace_profiles+0x64/0x1160
> > > [   75.130144] [<00000000008d4d90>] policy_update+0xf0/0x280
> > > [   75.201057] [<00000000008d4fc8>] profile_replace+0xa8/0x100
> > > [   75.274258] [<0000000000766bd0>] vfs_write+0x90/0x420
> > > [   75.340594] [<00000000007670cc>] ksys_write+0x4c/0xe0
> > > [   75.406932] [<0000000000767174>] sys_write+0x14/0x40
> > > [   75.472126] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
> > > [   75.548802] ---[ end trace 0000000000000000 ]---
> > > [   75.609503] dfa blob stream 0xfff0000008926b96 not aligned.
> > > [   75.682695] Kernel unaligned access at TPC[8db2a8] aa_dfa_unpack+0x6e8/0x720
> > 
> > The non-8-byte-aligned address (0xfff0000008926b96) is coming from userspace
> > (via the write syscall).
> > Some apparmor userspace tool writes into the apparmor ".replace" virtual file with
> > a source address which is not correctly aligned.
> 
> the userpace buffer passed to write(2) has to be aligned? Its certainly nice if it
> is but the userspace tooling hasn't been treating it as aligned. With that said,
> the dfa should be padded to be aligned. So this tripping in the dfa is a bug,
> and there really should be some validation to catch it.
> 
> > You should be able to debug/find the problematic code with strace from userspace.
> > Maybe someone with apparmor knowledge here on the list has an idea?
> > 
> This is likely an unaligned 2nd profile, being split out and loaded separately
> from the rest of the container. Basically the loader for some reason (there
> are a few different possible reasons) is poking into the container format and
> pulling out the profile at some offset, this gets loaded to the kernel but
> it would seem that its causing an issue with the dfa alignment within the container,
> which should be aligned to the original container.


Regarding this:

> Kernel side, we are going to need to add some extra verification checks, it should
> be catching this, as unaligned as part of the unpack. Userspace side, we will have
> to verify my guess and fix the loader.

I wonder if loading those tables are really time critical?
If not, maybe just making the kernel aware that the tables might be unaligned
can help, e.g. with the following (untested) patch.
Adrian, maybe you want to test?

------------------------

[PATCH] Allow apparmor to handle unaligned dfa tables

The dfa tables can originate from kernel or userspace and 8-byte alignment
isn't always guaranteed and as such may trigger unaligned memory accesses
on various architectures.
Work around it by using the get_unaligned_xx() helpers.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index c5a91600842a..26e82ba879d4 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -15,6 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/err.h>
 #include <linux/kref.h>
+#include <linux/unaligned.h>
 
 #include "include/lib.h"
 #include "include/match.h"
@@ -42,11 +43,11 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
 	/* loaded td_id's start at 1, subtract 1 now to avoid doing
 	 * it every time we use td_id as an index
 	 */
-	th.td_id = be16_to_cpu(*(__be16 *) (blob)) - 1;
+	th.td_id = get_unaligned_be16(blob) - 1;
 	if (th.td_id > YYTD_ID_MAX)
 		goto out;
-	th.td_flags = be16_to_cpu(*(__be16 *) (blob + 2));
-	th.td_lolen = be32_to_cpu(*(__be32 *) (blob + 8));
+	th.td_flags = get_unaligned_be16(blob + 2);
+	th.td_lolen = get_unaligned_be32(blob + 8);
 	blob += sizeof(struct table_header);
 
 	if (!(th.td_flags == YYTD_DATA16 || th.td_flags == YYTD_DATA32 ||
@@ -313,14 +314,14 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size_t size, int flags)
 	if (size < sizeof(struct table_set_header))
 		goto fail;
 
-	if (ntohl(*(__be32 *) data) != YYTH_MAGIC)
+	if (get_unaligned_be32(data) != YYTH_MAGIC)
 		goto fail;
 
-	hsize = ntohl(*(__be32 *) (data + 4));
+	hsize = get_unaligned_be32(data + 4);
 	if (size < hsize)
 		goto fail;
 
-	dfa->flags = ntohs(*(__be16 *) (data + 12));
+	dfa->flags = get_unaligned_be16(data + 12);
 	if (dfa->flags & ~(YYTH_FLAGS))
 		goto fail;
 
@@ -329,7 +330,7 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size_t size, int flags)
 	 * if (dfa->flags & YYTH_FLAGS_OOB_TRANS) {
 	 *	if (hsize < 16 + 4)
 	 *		goto fail;
-	 *	dfa->max_oob = ntol(*(__be32 *) (data + 16));
+	 *	dfa->max_oob = get_unaligned_be32(data + 16);
 	 *	if (dfa->max <= MAX_OOB_SUPPORTED) {
 	 *		pr_err("AppArmor DFA OOB greater than supported\n");
 	 *		goto fail;
