Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B62FF676;
	Wed, 26 Nov 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169950; cv=none; b=U+UhvvyHFNEgDVqOot7KuSfhRxm4cUYe3Ug8ShTBuWdUlfv/0euGJOViVd6PtPyoCX4CD4lABHWKVHhfkQXeO+R9txzdZdbxc55LDgVHeXUoRfJcgpWRVDxG+IIjDRFsxvcd+LHhGWovzJmDkLPwTymPw+qG1gU2L20pnI6E3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169950; c=relaxed/simple;
	bh=A31ZEtB8hXgwmnRmCuYTs0YXUNocajsrU+V31FS5PcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWVD3neXR1AG4cRySF90pcZGse/coFKGF8L/JndwbSRzDlwnRLU1gY/qf8Q7R7yRAowUhTfmHXWKkJjC4OmCYJi1kpNetaJKVp05IUQyFgZ4aa+t9DelNlIbm5HK60AtLhn780MwvWRmUx4cWErCB3MWXn/G9xmgCWnELaaYIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BymReTMg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BymReTMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468F9C4CEF7;
	Wed, 26 Nov 2025 15:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764169949;
	bh=A31ZEtB8hXgwmnRmCuYTs0YXUNocajsrU+V31FS5PcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BymReTMgbvFervNxB8f5k+j8RwfG6V71WiKCc0ukKREmcVSt/35mtWiBqV4bRcgso
	 Zd5qN7TYdy4CkHaoA73q92T8eIQrX89FkTEt7iM0wU0gOuWqwz/nTn3l2Zh7zxdvi2
	 oq38RpQSAEuwBYGPre2TFhLKY8EUYVP83x9yl6KP3XDc1Ty2vh+M6W6K4H8f07k+rx
	 fTEejYRkb+pZvlz0J9BdZnbf7ufgEsLYKtwqk5uMDdWMHhMfjOV7knTA7VTXLuZqFE
	 nVUZ8KW/UMSGXSNQIbJDAOiUWcG+7RUnSvNHuKKqVHksGmmFJX7GVCYNt5e/SpUat5
	 pxombUnx+2/og==
Date: Wed, 26 Nov 2025 16:12:23 +0100
From: Helge Deller <deller@kernel.org>
To: david laight <david.laight@runbox.com>
Cc: Helge Deller <deller@gmx.de>,
	John Johansen <john.johansen@canonical.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
Message-ID: <aScY13MEBATreotz@carbonx1>
References: <90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
 <be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
 <ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com>
 <aSXHCyH_rS-c5BgP@p100>
 <e88c32c2-fb18-4f3e-9ec2-a749695aaf0a@canonical.com>
 <c192140a-0575-41e9-8895-6c8257ce4682@gmx.de>
 <d35010b3-7d07-488c-b5a4-a13380d0ef7c@canonical.com>
 <20251126104444.29002552@pumpkin>
 <4034ad19-8e09-440c-a042-a66a488c048b@gmx.de>
 <20251126142201.27e23076@pumpkin>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126142201.27e23076@pumpkin>

* david laight <david.laight@runbox.com>:
> On Wed, 26 Nov 2025 12:03:03 +0100
> Helge Deller <deller@gmx.de> wrote:
> 
> > On 11/26/25 11:44, david laight wrote:
> ...   
> > >> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> > >> index 26e82ba879d44..3dcc342337aca 100644
> > >> --- a/security/apparmor/match.c
> > >> +++ b/security/apparmor/match.c
> > >> @@ -71,10 +71,10 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
> > >>    				     u8, u8, byte_to_byte);  
> > > 
> > > Is that that just memcpy() ?  
> > 
> > No, it's memcpy() only on big-endian machines.
> 
> You've misread the quoting...
> The 'data8' case that was only half there is a memcpy().
> 
> > On little-endian machines it converts from big-endian
> > 16/32-bit ints to little-endian 16/32-bit ints.
> > 
> > But I see some potential for optimization here:
> > a) on big-endian machines just use memcpy()
> 
> true
> 
> > b) on little-endian machines use memcpy() to copy from possibly-unaligned
> >     memory to then known-to-be-aligned destination. Then use a loop with
> >     be32_to_cpu() instead of get_unaligned_xx() as it's faster.
> 
> There is a function that does a loop byteswap of a buffer - no reason
> to re-invent it.

I assumed there must be something, but I did not see it. Which one?

> But I doubt it is always (if ever) faster to do a copy and then byteswap.
> The loop control and extra memory accesses kill performance.

Yes, you are probably right.

> Not that I've seen a fast get_unaligned() - I don't think gcc or clang
> generate optimal code - For LE I think it is something like:
> 	low = *(addr & ~3);
> 	high = *((addr + 3) & ~3);
> 	shift = (addr & 3) * 8;
> 	value = low << shift | high >> (32 - shift);
> Note that it is only 2 aligned memory reads - even for 64bit.

Ok, then maybe we should keep it simple like this patch:

[PATCH v2] apparmor: Optimize table creation from possibly unaligned memory

Source blob may come from userspace and might be unaligned.
Try to optize the copying process by avoiding unaligned memory accesses.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/security/apparmor/include/match.h b/security/apparmor/include/match.h
index 1fbe82f5021b..386da2023d50 100644
--- a/security/apparmor/include/match.h
+++ b/security/apparmor/include/match.h
@@ -104,16 +104,20 @@ struct aa_dfa {
 	struct table_header *tables[YYTD_ID_TSIZE];
 };
 
-#define byte_to_byte(X) (X)
+#define byte_to_byte(X) (*(X))
 
 #define UNPACK_ARRAY(TABLE, BLOB, LEN, TTYPE, BTYPE, NTOHX)	\
 	do { \
 		typeof(LEN) __i; \
 		TTYPE *__t = (TTYPE *) TABLE; \
 		BTYPE *__b = (BTYPE *) BLOB; \
-		for (__i = 0; __i < LEN; __i++) { \
-			__t[__i] = NTOHX(__b[__i]); \
-		} \
+		BUILD_BUG_ON(sizeof(TTYPE) != sizeof(BTYPE)); \
+		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) || sizeof(BTYPE) == 1) \
+			memcpy(__t, __b, (LEN) * sizeof(BTYPE)); \
+		else /* copy & convert convert from big-endian */ \
+			for (__i = 0; __i < LEN; __i++) { \
+				__t[__i] = NTOHX(&__b[__i]); \
+			} \
 	} while (0)
 
 static inline size_t table_size(size_t len, size_t el_size)
diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index c5a91600842a..13e2f6873329 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -15,6 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/err.h>
 #include <linux/kref.h>
+#include <linux/unaligned.h>
 
 #include "include/lib.h"
 #include "include/match.h"
@@ -70,10 +71,10 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
 				     u8, u8, byte_to_byte);
 		else if (th.td_flags == YYTD_DATA16)
 			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
-				     u16, __be16, be16_to_cpu);
+				     u16, __be16, get_unaligned_be16);
 		else if (th.td_flags == YYTD_DATA32)
 			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
-				     u32, __be32, be32_to_cpu);
+				     u32, __be32, get_unaligned_be32);
 		else
 			goto fail;
 		/* if table was vmalloced make sure the page tables are synced
