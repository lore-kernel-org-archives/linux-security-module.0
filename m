From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 17 Sep 2017 08:37:55 -0700
Subject: [PATCH 3/3] ima: use fs method to read integrity data (updated
	patch description)
In-Reply-To: <CA+55aFyrZ=YsfNc1vp=vArNgotLXGPr4F6uZiz22Uj2XHGUvaw@mail.gmail.com>
References: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1505451494-30228-4-git-send-email-zohar@linux.vnet.ibm.com>
	<1505507142.4200.103.camel@linux.vnet.ibm.com>
	<CA+55aFxmeff53zeioTiQY6m=F18ekgX1-HWZyQUor=NJYrxM9A@mail.gmail.com>
	<20170917151757.GA14262@infradead.org>
	<CA+55aFyrZ=YsfNc1vp=vArNgotLXGPr4F6uZiz22Uj2XHGUvaw@mail.gmail.com>
Message-ID: <20170917153755.GA21193@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Sep 17, 2017 at 08:28:40AM -0700, Linus Torvalds wrote:
> The issue is that somebody else can come in - using direct IO - at the
> same time as the first person is collecting measurements, and thus
> race with the collector.
>
> So now the measurements are not trustworthy any more.

Yes.  And it's always been that way with IMA.

> .. and *my* point is that it's the wrong lock for actually checking
> integrity (it doesn't actually guarantee exclusion, even though in
> practice it's almost always the case), and so we're adding a nasty
> callback that in 99% of all cases is the same as the normal read, and
> we *could* have just added it with a RWF flag instead.
> 
> Is there some reason why integrity has to use that particular lock
> that is so inconvenient for the filesystems it wants to check?

I'll have to defer that to Mimi - I just jumped into this whole mess
to help fixing the deadlocks we saw on XFS and NFS.

Unfortunately the whole security code is a giant mess that doesn't
document assumptions, threat models or gets any sort of verification
of those through automated testing.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
