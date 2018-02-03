From: blukashev@sempervictus.com (Boris Lukashev)
Date: Sat, 3 Feb 2018 15:12:20 -0500
Subject: [kernel-hardening] [PATCH 4/6] Protectable Memory
In-Reply-To: <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
	<20180124175631.22925-5-igor.stoppa@huawei.com>
	<CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
	<20180126053542.GA30189@bombadil.infradead.org>
	<alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
	<f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com>
	<b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
Message-ID: <CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Feb 3, 2018 at 2:57 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>>> On Thu, 25 Jan 2018, Matthew Wilcox wrote:
>
>>>> It's worth having a discussion about whether we want the pmalloc API
>>>> or whether we want a slab-based API.
> I'd love to have some feedback specifically about the API.
>
> I have also some idea about userspace and how to extend the pmalloc
> concept to it:
>
> http://www.openwall.com/lists/kernel-hardening/2018/01/30/20
>
> I'll be AFK intermittently for about 2 weeks, so i might not be able to
> reply immediately, but from my perspective this would be just the
> beginning of a broader hardening of both kernel and userspace that I'd
> like to pursue.
>
> --
> igor

Regarding the notion of validated protected memory, is there a method
by which the resulting checksum could be used in a lookup
table/function to resolve the location of the protected data?
Effectively a hash table of protected allocations, with a benefit of
dedup since any data matching the same key would be the same data
(multiple identical cred structs being pushed around). Should leave
the resolver address/csum in recent memory to check against, right?

-- 
Boris Lukashev
Systems Architect
Semper Victus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
