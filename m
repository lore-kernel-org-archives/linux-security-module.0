From: keescook@chromium.org (Kees Cook)
Date: Wed, 14 Feb 2018 14:27:47 -0800
Subject: arm64 physmap (was Re: [kernel-hardening] [PATCH 4/6] Protectable
	Memory)
In-Reply-To: <20180214221328.glbrdib3wumve53z@cisco>
References: <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
	<17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com>
	<CAGXu5j+LS1pgOOroi7Yxp2nh=DwtTnU3p-NZa6bQu_wkvvVkwg@mail.gmail.com>
	<414027d3-dd73-cf11-dc2a-e8c124591646@redhat.com>
	<CAGXu5j++igQD4tMh0J8nZ9jNji5mU16C7OygFJ5Td+Bq-KSMgw@mail.gmail.com>
	<CAG48ez1utN_vwHUwk=BU6zM4Wa_53TPu8rm9JuTtY-vGP0Shqw@mail.gmail.com>
	<f4226a44-92fd-8ead-b458-7551ba82f96d@redhat.com>
	<CAGXu5j+zOCLerneUt2b-tvyLLg7fEbr9B0YYow-4DH6oV-nnCw@mail.gmail.com>
	<2f23544a-bd24-1e71-967b-e8d1cf5a20a3@redhat.com>
	<CAGXu5j+zkFx+1Dn908iqaTV-yP7Wk_rMXZRvXN32h+i_oAcy6w@mail.gmail.com>
	<20180214221328.glbrdib3wumve53z@cisco>
Message-ID: <CAGXu5jK1taW5JccCTdi6EzfD7RNnFrRyoJQMtLLi5CwT-8eJkQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Feb 14, 2018 at 2:13 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> On Wed, Feb 14, 2018 at 11:48:38AM -0800, Kees Cook wrote:
>> On Wed, Feb 14, 2018 at 11:06 AM, Laura Abbott <labbott@redhat.com> wrote:
>> > fixed. Modules yes are not fully protected. The conclusion from past
>> > experience has been that we cannot safely break down larger page sizes
>> > at runtime like x86 does. We could theoretically
>> > add support for fixing up the alias if PAGE_POISONING is enabled but
>> > I don't know who would actually use that in production. Performance
>> > is very poor at that point.
>>
>> XPFO forces 4K pages on the physmap[1] for similar reasons. I have no
>> doubt about performance changes, but I'd be curious to see real
>> numbers. Did anyone do benchmarks on just the huge/4K change? (Without
>> also the XPFO overhead?)
>>
>> If this, XPFO, and PAGE_POISONING all need it, I think we have to
>> start a closer investigation. :)
>
> I haven't but it shouldn't be too hard. What benchmarks are you
> thinking?

Unless I'm looking at some specific micro benchmark, I tend to default
to looking at kernel build benchmarks but that gets pretty noisy.
Laura regularly uses hackbench, IIRC. I'm not finding the pastebin I
had for that, though.

I wonder if we need a benchmark subdirectory in tools/testing/, so we
could collect some of these common tools? All benchmarks are terrible,
but at least we'd have the same terrible benchmarks. :)

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
