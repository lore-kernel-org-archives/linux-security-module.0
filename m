Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AECD285C88
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764192205; cv=none; b=ZunW4YN90tfUT0nj+GFeSJbtkF8T0GvY6AbQZ5tW1LC3nr43+Nf2BomFUPR97VXjvdrFou8LqjLFn+ka6s76WR2xghc9wfrtPyN/YuJfc32nr77qSY32x1Npq0YeBUDCeDLoogruy3Wpf6nop4LMXxXxhOROPrVj5pthktdwbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764192205; c=relaxed/simple;
	bh=JmPqCTuFXfwgzK3vP/scRZ3r/gwwprWdXWg0Z68762Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qp6jsPZYXA8ox5/OsUJpFcmSgnCYT8nsBRz2AUNx034apBt2b3DkldOqnRJbj3TdGWXxqacA+WGPYgqAV7IyVo23OYasXzImzK8yVpZy0lSbUkbbL7K9KEXFZKwor8eNGKaddM7lilioglLx+rXcGx1x6sPfXjr+G1mGoAkEnp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=bYna8wwO; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="bYna8wwO"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vOMyq-00AfWu-UX; Wed, 26 Nov 2025 22:23:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=MxMDkiBxmJ+l/ObDV+Ot5xyfBQkfYYuHtaRagnY7MvE=; b=bYna8wwOYjrM38iUkRTFQgf7Ii
	OpaRnBjmMAt9LaWko5WRmnH9SiWf4TWnVlHMd1GjYR9L4xTjUgAE+rRR5BTYPpU3ex5ceH8D3vDS9
	Vy6C3ESANraVQ54ZPW/9tBwRfeMHCCGPbQv9rcKTx8ItqQd74adSz5DtwJJZ6D3eiX4b9ObHzHG3/
	fESE4Sx5elNY2mkdTrBtV0ronRL6OKvqTV9YcuMyUBGJtauhzRBpYSTGdHtqrQZwe4IOmJ0xW+XT9
	8Mh9YfXD/QAJDzsunyDP7FGFn0h7763GtJEH9JuNQ6d4m96j62pU2S22mn0UQ7MePleN7dKYAcga/
	3HON+FUQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vOMyq-0000Jv-7c; Wed, 26 Nov 2025 22:23:16 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vOMym-00Ea5l-Pt; Wed, 26 Nov 2025 22:23:12 +0100
Date: Wed, 26 Nov 2025 21:23:09 +0000
From: david laight <david.laight@runbox.com>
To: Helge Deller <deller@kernel.org>
Cc: Helge Deller <deller@gmx.de>, John Johansen
 <john.johansen@canonical.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, linux-kernel@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-parisc@vger.kernel.org
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
Message-ID: <20251126212309.5b21edca@pumpkin>
In-Reply-To: <aScY13MEBATreotz@carbonx1>
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
	<aScY13MEBATreotz@carbonx1>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 16:12:23 +0100
Helge Deller <deller@kernel.org> wrote:

> * david laight <david.laight@runbox.com>:
> > On Wed, 26 Nov 2025 12:03:03 +0100
> > Helge Deller <deller@gmx.de> wrote:
> >   
> > > On 11/26/25 11:44, david laight wrote:  
> > ...     
> > > >> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> > > >> index 26e82ba879d44..3dcc342337aca 100644
> > > >> --- a/security/apparmor/match.c
> > > >> +++ b/security/apparmor/match.c
> > > >> @@ -71,10 +71,10 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
> > > >>    				     u8, u8, byte_to_byte);    
> > > > 
> > > > Is that that just memcpy() ?    
> > > 
> > > No, it's memcpy() only on big-endian machines.  
> > 
> > You've misread the quoting...
> > The 'data8' case that was only half there is a memcpy().
> >   
> > > On little-endian machines it converts from big-endian
> > > 16/32-bit ints to little-endian 16/32-bit ints.
> > > 
> > > But I see some potential for optimization here:
> > > a) on big-endian machines just use memcpy()  
> > 
> > true
> >   
> > > b) on little-endian machines use memcpy() to copy from possibly-unaligned
> > >     memory to then known-to-be-aligned destination. Then use a loop with
> > >     be32_to_cpu() instead of get_unaligned_xx() as it's faster.  
> > 
> > There is a function that does a loop byteswap of a buffer - no reason
> > to re-invent it.  
> 
> I assumed there must be something, but I did not see it. Which one?

I can't find it either - just some functions to do an in-place swap.
(Which aren't usually a good idea)

> 
> > But I doubt it is always (if ever) faster to do a copy and then byteswap.
> > The loop control and extra memory accesses kill performance.  
> 
> Yes, you are probably right.
> 
> > Not that I've seen a fast get_unaligned() - I don't think gcc or clang
> > generate optimal code - For LE I think it is something like:
> > 	low = *(addr & ~3);
> > 	high = *((addr + 3) & ~3);
> > 	shift = (addr & 3) * 8;
> > 	value = low << shift | high >> (32 - shift);
> > Note that it is only 2 aligned memory reads - even for 64bit.  
> 
> Ok, then maybe we should keep it simple like this patch:
> 
> [PATCH v2] apparmor: Optimize table creation from possibly unaligned memory
> 
> Source blob may come from userspace and might be unaligned.
> Try to optize the copying process by avoiding unaligned memory accesses.

Not sure that reads right.
'Allow for misaligned data from userspace when byteswapping source blob' ?

> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/security/apparmor/include/match.h b/security/apparmor/include/match.h
> index 1fbe82f5021b..386da2023d50 100644
> --- a/security/apparmor/include/match.h
> +++ b/security/apparmor/include/match.h
> @@ -104,16 +104,20 @@ struct aa_dfa {
>  	struct table_header *tables[YYTD_ID_TSIZE];
>  };
>  
> -#define byte_to_byte(X) (X)
> +#define byte_to_byte(X) (*(X))

It's a bit of a shame you need something for the above...

	David


>  
>  #define UNPACK_ARRAY(TABLE, BLOB, LEN, TTYPE, BTYPE, NTOHX)	\
>  	do { \
>  		typeof(LEN) __i; \
>  		TTYPE *__t = (TTYPE *) TABLE; \
>  		BTYPE *__b = (BTYPE *) BLOB; \
> -		for (__i = 0; __i < LEN; __i++) { \
> -			__t[__i] = NTOHX(__b[__i]); \
> -		} \
> +		BUILD_BUG_ON(sizeof(TTYPE) != sizeof(BTYPE)); \
> +		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) || sizeof(BTYPE) == 1) \
> +			memcpy(__t, __b, (LEN) * sizeof(BTYPE)); \
> +		else /* copy & convert convert from big-endian */ \
> +			for (__i = 0; __i < LEN; __i++) { \
> +				__t[__i] = NTOHX(&__b[__i]); \
> +			} \
>  	} while (0)
>  
>  static inline size_t table_size(size_t len, size_t el_size)
> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> index c5a91600842a..13e2f6873329 100644
> --- a/security/apparmor/match.c
> +++ b/security/apparmor/match.c
> @@ -15,6 +15,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/err.h>
>  #include <linux/kref.h>
> +#include <linux/unaligned.h>
>  
>  #include "include/lib.h"
>  #include "include/match.h"
> @@ -70,10 +71,10 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
>  				     u8, u8, byte_to_byte);
>  		else if (th.td_flags == YYTD_DATA16)
>  			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> -				     u16, __be16, be16_to_cpu);
> +				     u16, __be16, get_unaligned_be16);
>  		else if (th.td_flags == YYTD_DATA32)
>  			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> -				     u32, __be32, be32_to_cpu);
> +				     u32, __be32, get_unaligned_be32);
>  		else
>  			goto fail;
>  		/* if table was vmalloced make sure the page tables are synced

