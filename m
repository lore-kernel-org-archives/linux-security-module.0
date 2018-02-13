From: keescook@chromium.org (Kees Cook)
Date: Tue, 13 Feb 2018 13:43:49 -0800
Subject: [kernel-hardening] [PATCH 4/6] Protectable Memory
In-Reply-To: <f4226a44-92fd-8ead-b458-7551ba82f96d@redhat.com>
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
	<17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com>
	<CAGXu5j+LS1pgOOroi7Yxp2nh=DwtTnU3p-NZa6bQu_wkvvVkwg@mail.gmail.com>
	<414027d3-dd73-cf11-dc2a-e8c124591646@redhat.com>
	<CAGXu5j++igQD4tMh0J8nZ9jNji5mU16C7OygFJ5Td+Bq-KSMgw@mail.gmail.com>
	<CAG48ez1utN_vwHUwk=BU6zM4Wa_53TPu8rm9JuTtY-vGP0Shqw@mail.gmail.com>
	<f4226a44-92fd-8ead-b458-7551ba82f96d@redhat.com>
Message-ID: <CAGXu5j+zOCLerneUt2b-tvyLLg7fEbr9B0YYow-4DH6oV-nnCw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Feb 13, 2018 at 8:09 AM, Laura Abbott <labbott@redhat.com> wrote:
> No, arm64 doesn't fixup the aliases, mostly because arm64 uses larger
> page sizes which can't be broken down at runtime. CONFIG_PAGE_POISONING
> does use 4K pages which could be adjusted at runtime. So yes, you are
> right we would have physmap exposure on arm64 as well.

Errr, so that means even modules and kernel code are writable via the
arm64 physmap? That seems extraordinarily bad. :(

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
