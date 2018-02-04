From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Sun, 4 Feb 2018 17:05:25 +0200
Subject: [kernel-hardening] [PATCH 4/6] Protectable Memory
In-Reply-To: <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
	<20180124175631.22925-5-igor.stoppa@huawei.com>
	<CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
	<20180126053542.GA30189@bombadil.infradead.org>
	<alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
	<f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com>
	<b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
	<CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com>
	<8818bfd4-dd9f-f279-0432-69b59531bd41@huawei.com>
	<CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
Message-ID: <17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 04/02/18 00:29, Boris Lukashev wrote:
> On Sat, Feb 3, 2018 at 3:32 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:

[...]

>> What you are suggesting, if I have understood it correctly, is that,
>> when the pool is protected, the addresses already given out, will become
>> traps that get resolved through a lookup table that is built based on
>> the content of each allocation.
>>
>> That seems to generate a lot of overhead, not to mention the fact that
>> it might not play very well with the MMU.
> 
> That is effectively what i'm suggesting - as a form of protection for
> consumers against direct reads of data which may have been corrupted
> by some irrelevant means. In the context of pmalloc, it would probably
> be a separate type of ro+verified pool
ok, that seems more like an extension though.

ATM I am having problems gaining traction to get even the basic merged :-)

I would consider this as a possibility for future work, unless it is
said that it's necessary for pmalloc to be accepted ...

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
