From: willy@infradead.org (Matthew Wilcox)
Date: Sun, 4 Feb 2018 19:45:31 -0800
Subject: [PATCH 1/6] genalloc: track beginning of allocations
In-Reply-To: <60e66c5a-c1de-246f-4be8-b02cb0275da6@infradead.org>
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
	<20180204164732.28241-2-igor.stoppa@huawei.com>
	<60e66c5a-c1de-246f-4be8-b02cb0275da6@infradead.org>
Message-ID: <20180205034531.GA18559@bombadil.infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Feb 04, 2018 at 02:34:08PM -0800, Randy Dunlap wrote:
> > +/**
> > + * cleart_bits_ll - according to the mask, clears the bits specified by
> 
>       clear_bits_ll

'make W=1' should catch this ... yes?

(hint: building with 'make C=1 W=1' finds all kinds of interesting issues
in your code.  W=12 or W=123 finds too many false positives for my tastes)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
